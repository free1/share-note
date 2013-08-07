module ApplicationHelper

	# Markdown 格式
	def markdown(text)
		options = { 
		    :autolink => true, 
		    :space_after_headers => true,
		    :fenced_code_blocks => true,
		    :no_intra_emphasis => true,
		    :hard_wrap => true,
		    :strikethrough =>true
		  }
		markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
		markdown.render(h(text)).html_safe
	end

	class HTMLwithCodeRay < Redcarpet::Render::HTML
		def block_code(code, language)
		 	CodeRay.scan(code, language).div(:tab_width=>2)
		end
	end

	# 使冲破布局的内容自动换行
	def wrap(content)
		sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
	end

	private

		def wrap_long_string(text, max_width = 95)
		  zero_width_space = "&#8203;"
		  regex = /.{1,#{max_width}}/
		  (text.length < max_width) ? text :
		                              text.scan(regex).join(zero_width_space)
		end
end
