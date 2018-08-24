class TemplateProcessor
  attr_accessor :processed_templates

  def initialize(source)
    @source = source
    @processed_templates = {}
  end

  # return template with replacements, recurse and memoize templates as they are processed
  #
  # TODO: avoid circular dependencies
  def process_template(template_path)
    if @processed_templates[template_path]
      return @processed_templates[template_path]
    end

    unprocessed_template = read_template(template_path)
    @processed_templates[template_path] = unprocessed_template.gsub(/{{[^{}()\[\]]+}}/) do |to_replace|
      replacement_path = to_replace.gsub(/[{}]/, '')
      process_template(replacement_path)
    end.strip
  end

  private

  def read_template(template_path)
    IO.read(File.join([@source, template_path]))
  end
end
