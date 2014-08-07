module ApplicationHelper

	def locale_switcher_link(locale)

        kaminari_page_parameter_name = :page

		route_name = ""
		path_arr = (Rails.application.routes.recognize_path request.path).to_a
        pars = Array.new(path_arr.length-3)

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
					else
						pars[i-3] = tmp.id
					end
				end
			end
		end 

    	query_string = pars.join("\", \"")

    	Rails.application.routes.router.recognize(request) do |route, _|
    		route_name = (route.name).to_s.gsub(/_[a-z]+$/, "_#{locale.to_s}") + "_path"
    	end

        if current_page?(root_url)
            route = eval("root_#{locale}_path")
        else
            route = eval(route_name + "(\"#{query_string}\")")
        end

        if (!kaminari_page_parameter_name.nil? && !params[kaminari_page_parameter_name].nil?)
           route = (route.gsub(/\/$/, "")) + "/" + params[kaminari_page_parameter_name].to_s
        end

        return route

    end
  
end
