module ApplicationHelper

	def locale_switcher_link(locale)

		route_name = 		""
		path_arr = 		Rails.application.routes.recognize_path(request.path).to_a
		path_base = 		Hash[path_arr.take(2)]
		parshash =		Hash.new(path_arr.length-3)
		current_locale = 	I18n.locale

		for i in 3..path_arr.length-1 do 
			if (path_arr[i][0] =~ /_id$/) 
				class_name = path_arr[i][0].to_s.gsub(/_id$/, "").capitalize 
			elsif (path_arr[i][0].to_s == "id")
				class_name = path_arr[0][1].to_s.classify
			else
				parshash[path_arr[i][0].to_sym] = path_arr[i][1].to_i
			end
			if class_name
				tmp = class_name.constantize.find(path_arr[i][1])
				nova_pth = tmp.try("slug_" + locale.to_s)
				if nova_pth
					parshash[path_arr[i][0].to_sym] = nova_pth
				else
					I18n.locale = locale
					nova_pth_2 = tmp.try("slug")
					if nova_pth_2 
						parshash[path_arr[i][0].to_sym] = tmp.slug
					else
						parshash[path_arr[i][0].to_sym] = tmp.id
					end
					I18n.locale = current_locale
				end
			end
		end 

		Rails.application.routes.router.recognize(request) do |route, _|
			route_name = (route.name).to_s.gsub(/_[a-z]+$/, "_#{locale.to_s}") + "_path" if !route.name.blank?
		end

	return Rails.application.routes.url_helpers.send(route_name, path_base.merge(parshash))
	end
	
end
