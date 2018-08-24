#!/usr/bin/env ruby

USAGE = "usage: build.rb path/to/config.yml"
# for example config, see examples/website/config.yml

require 'yaml'
require_relative 'lib/template_processor'

CONFIG_PATH = ARGV[0]
throw USAGE unless CONFIG_PATH

CONFIG = YAML.load_file(CONFIG_PATH)
PROJECT_ROOT = File.dirname(CONFIG_PATH)

build_output_keys = CONFIG['output']

processor = TemplateProcessor.new(File.join([PROJECT_ROOT, CONFIG['source']]))

build_output_keys.each do |output_path|
  full_output_path = File.join([PROJECT_ROOT, CONFIG['dest'], output_path])
  out = File.new(full_output_path, 'w')
  out.write(processor.process_template(output_path))
  p full_output_path
end
