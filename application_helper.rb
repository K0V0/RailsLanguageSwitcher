def locale_switcher_link(locale)

	route_name = 						""
	route_mame_new = 					""
	kaminari_page_param_name = 			Kaminari.config.param_name if Object.const_defined?("Kaminari")
	helpers_object = 					Rails.application.routes.url_helpers
	path_arr = 							Rails.application.routes.recognize_path(request.path).to_a
	pars =								Array.new(path_arr.length-3)
	paginates =							true if ((!kaminari_page_param_name.nil?)&&(!params[kaminari_page_param_name].nil?))

<<<<<<< HEAD
		route_name = 			""
		route_mame_new = 		""
		kaminari_page_param_name = 	Kaminari.config.param_name if Object.const_defined?("Kaminari")
		helpers_object = 		Rails.application.routes.url_helpers
		path_arr = 			Rails.application.routes.recognize_path(request.path).to_a
		pars =				Array.new(path_arr.length-3)
       		paginates =			true if (kaminari_page_param_name.nil? && !param[kaminari_page_param_name].nil?)

		for i in 3..path_arr.length-1 do 
			if (path_arr[i][0] =~ /_id$/) 
				class_name = path_arr[i][0].to_s.gsub(/_id$/, "").capitalize 
			elsif (path_arr[i][0].to_s == "id")
				class_name = path_arr[1][1].classify
			end
			if class_name
				tmp = class_name.constantize.find(path_arr[i][1])
				nova_pth = tmp.try("slug_" + locale.to_s)
				if nova_pth
					pars[i-3] = nova_pth
=======
	for i in 3..path_arr.length-1 do 
		if (path_arr[i][0] =~ /_id$/) 
			class_name = path_arr[i][0].to_s.gsub(/_id$/, "").capitalize 
		elsif (path_arr[i][0].to_s == "id")
			class_name = path_arr[1][1].classify
		end
		if class_name
			tmp = class_name.constantize.find(path_arr[i][1])
			nova_pth = tmp.try("slug_" + locale.to_s)
			if nova_pth
				pars[i-3] = nova_pth
			else
				nova_pth_2 = tmp.try("slug")
				if nova_pth_2 
					pars[i-3] = tmp.slug
>>>>>>> critical bug due to typo
				else
					pars[i-3] = tmp.id
				end
			end
		end
	end 

<<<<<<< HEAD
    		Rails.application.routes.router.recognize(request) do |route, _|
    			route_name = (route.name).to_s.gsub(/_[a-z]+$/, "_#{locale.to_s}") + "_path" if !route.name.blank?
    		end

    		if (pars.blank? || pars.any? { |p| p.nil? })
    			if paginates
    				pars = param[kaminari_page_param_name] 
    			else
    				pars << param[kaminari_page_param_name]
			end
    		end

    	return helpers_object.send(route_name, *pars)
	end
  
=======
	Rails.application.routes.router.recognize(request) do |route, _|
		route_name = (route.name).to_s.gsub(/_[a-z]+$/, "_#{locale.to_s}") + "_path" if !route.name.blank?
	end

	if paginates
		if empty_params
			pars[pars.length-1] = params[kaminari_page_param_name] 
		else
			pars << params[kaminari_page_param_name]
		end
	end

return helpers_object.send(route_name, *pars)
>>>>>>> critical bug due to typo
end
