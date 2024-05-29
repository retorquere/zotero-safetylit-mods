#!/usr/bin/env crystal

require "json"
require "option_parser"

header = ""
mode = ""

OptionParser.parse do |parser|
  parser.on("--add=HEADER", "add header") {|h|
    header = h
    mode = "add"
  }
  parser.on("--remove=HEADER", "strip header") {|h|
    header = h
    mode = "remove"
  }
end

class ConfigOptions
  include JSON::Serializable
  property dataMode : String
end

class DisplayOptions
  include JSON::Serializable
  property exportNotes : Bool
end

class Header
  include JSON::Serializable
  property translatorID : String
  property label : String
  property creator : String
  property target : String
  property minVersion : String
  property maxVersion : String
  property priority : Int32
  property configOptions : ConfigOptions
  property displayOptions : DisplayOptions
  property inRepository : Bool
  property translatorType : Int32
  property lastUpdated : String
end

ARGV.each do |translator|
  raise translator unless translator.match(/[.]js$/i) 

  body = File.read(translator)
  case mode
    when "add"
      template = Header.from_json(File.read(header))
      template.translatorID = "011e23fd-91bd-4c3e-b1ae-edf22889d944"
      template.label = "SafetyLit MODS"
      template.inRepository = false
      template.creator = "Simon Kornblith, Richard Karnesky, Abe Jellinek and Emiliano Heyns"
      template.translatorType = 2
      template.lastUpdated = Time.local.to_s.sub(/ [^ ]+$/, "")
      File.write(translator, template.to_pretty_json + "\n" + File.read(translator))
    when "remove"
      body.match(/(.*?\n}\n)(.*)/m)
      File.write(header, $1)
      File.write(translator, $2)
    else
      raise mode
  end
end
