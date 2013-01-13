def template from, to
  tpl = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(tpl).result(binding), to
end
