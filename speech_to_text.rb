# Imports the Google Cloud client library
require "google/cloud/speech"

class SpeechToText
  attr_accessor :speech, :file_name, :config, :results

  def initialize(src_file_name, dest_file_name, encoding, sample_rate, language_code, long_audio = false, beta = false)
    @speech = beta ? Google::Cloud::Speech.new(version: :v1p1beta1) : Google::Cloud::Speech.new

    # The name of the audio file to transcribe or a gs bucket url
    @file_name = src_file_name
    # The audio file's encoding and sample rate
    @config = {
               encoding: encoding,  # :LINEAR16
               sample_rate_hertz: sample_rate,  # 16_000
               language_code: language_code  # "en-US"
              }
    puts "Reading file from #{@file_name} with the following config: "
    puts @config

    @results = if long_audio
      audio = { uri: @file_name } # eg. gs://bucket/audio.raw"
      operation = @speech.long_running_recognize @config, audio

      puts "Long audio operation started ..."
      operation.wait_until_done!
      puts "Long audio operation done ..."

      raise operation.results.message if operation.error?

      operation.response.results
    else
      # Read the raw audio
      audio_file = File.binread @file_name # "./resources/audio.raw"      
      audio  = { content: audio_file }

      puts "Detecting speech in the given audio file ..."
      response = @speech.recognize @config, audio

      puts "Detecting speech done.\n"
      response.results
    end
  end

  def self.convert(src_file_name, dest_file_name, encoding, sample_rate, language_code, long_audio = false, beta = false)
    speech_to_text = new(src_file_name, dest_file_name, encoding, sample_rate, language_code, long_audio, beta)
    results = speech_to_text.results

    # Get first result because we only processed a single audio file
    # Each result represents a consecutive portion of the audio
    File.open(dest_file_name, 'w') do |file|
      results.first.alternatives.each do |alternative|
        transcription = "Transcription: #{alternative.transcript}"

        puts transcription
        file.write(transcription)
      end          
    end
  end
end