# gcp-speech-to-text
A Ruby client app to invoke Google Cloud Speech-to-Text API

## Supported audio encodings
- MP3
- FLAC
- LINEAR16
- MULAW
- AMR
- AMR_WB
- OGG_OPUS
- SPEEX_WITH_HEADER_BYTE

## Usage
1. Set the environment variable `GOOGLE_APPLICATION_CREDENTIALS` to the file path of the `JSON` file that contains your `service account key`. This variable only applies to your current shell session, so if you open a new session, set the variable again.
1. run `bundle install` to install `google-cloud-speech` gem
2. run `ruby -r "./speech_to_text.rb" -e "puts SpeechToText.convert(SRC_FILE_NAME, DEST_FILE_NAME, ENCODING, SAMPLE_RATE, LANGUAGE_CODE)"` to convert a given audio source to text and write it to a destination file

## Offical API Document
https://cloud.google.com/speech-to-text/docs/
