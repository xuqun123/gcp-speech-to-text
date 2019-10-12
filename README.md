# google-cloud-speech-to-text
A Ruby client app to invoke Google Cloud Speech-to-Text API, which converting audio file with human speech to a text transcription.

## Supported audio encodings
- MP3 (Only available for beta verison API)
- FLAC
- LINEAR16
- MULAW
- AMR
- AMR_WB
- OGG_OPUS
- SPEEX_WITH_HEADER_BYTE

## Supported languages
Refer to https://cloud.google.com/speech-to-text/docs/languages

## Max payload size limit
10485760 bytes

## Usage
1. Set the environment variable `GOOGLE_APPLICATION_CREDENTIALS` to the file path of the `JSON` file that contains your `service account key`. This variable only applies to your current shell session, so if you open a new session, set the variable again.
1. run `bundle install` to install `google-cloud-speech` gem
2. run `ruby -r "./speech_to_text.rb" -e "puts SpeechToText.convert(SRC_FILE_NAME, DEST_FILE_NAME, ENCODING, SAMPLE_RATE, LANGUAGE_CODE, LONG_AUDIO_BOOLEAN, BETA_VERSION_BOOLEAN)"` to convert a given audio source to text and write it to a destination file
- short audio (less than 1 min) example: `ruby -r "./speech_to_text.rb" -e "puts SpeechToText.convert('./falls-creek-audio-p1.opus', './transcript', :OGG_OPUS, 48_000, 'zh')"`
- long audio (more than 1 min) example using beta version API: `ruby -r "./speech_to_text.rb" -e "puts SpeechToText.convert('gs://BUCKET_NAME/CLOUD_FILE_KEY', './transcript', :MP3, 48_000, 'zh', true, true)"`

## Offical API Document
https://cloud.google.com/speech-to-text/docs/
