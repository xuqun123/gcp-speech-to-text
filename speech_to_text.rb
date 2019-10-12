# Imports the Google Cloud client library
require "google/cloud/speech"

class SpeechToText
  def self.convert(src_file_name, dest_file_name, encoding, sample_rate, language_code)
    speech = Google::Cloud::Speech.new

    # The name of the audio file to transcribe
    file_name = src_file_name # "./resources/audio.raw"
    # The raw audio
    audio_file = File.binread file_name

    # The audio file's encoding and sample rate
    config = {
               encoding: encoding,  # :LINEAR16
               sample_rate_hertz: sample_rate,  # 16_000
               language_code: language_code  # "en-US"
             }
    audio  = { content: audio_file }
    puts "Reading file from #{file_name} with the following config: "
    puts config

    puts "Detecting speech in the given audio file ..."
    response = speech.recognize config, audio

    puts "Detecting speech done.\n"
    results = response.results

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