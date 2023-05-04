module BootstrapFlashHelper
  def bootstrap_flash()
    flash_messages = []
    begin
      if eval("@#{controller_name.singularize}.errors.size > 0")
        if eval("@#{controller_name.singularize}.errors[:base].present?")
          flash[:error] = eval("@#{controller_name.singularize}.errors[:base]")
        else
          flash[:error] = I18n.t("helpers.links.#{action_name}_error", model: Kernel.const_get(controller_name.singularize.camelize).model_name.human)
        end
      end
    rescue
      #flash[:error] = ""
    end
    flash.each do |type, message|
      data = case type
        when 'success'
        when 'notice'
          {title: 'Sucess!', icon: 'fas fa-check', type: :success, kind: 'success'}
        when 'error'
          {title: 'Error!', icon: 'fas fa-ban', type: :danger, kind: 'error'}
        when 'alert'
          {title: 'Alert!', icon: 'fas fa-exclamation-triangle', type: :warning, kind: 'warning'}
          # {title: 'Informação', icon: 'fas fa-ban', type: :info, kind: 'info'}
        else
          {title: 'Warning', icon: 'fas fa-info', type: ' bg-primary', kind: 'info'}
      end

      tag_options = {
        class: "alert alert-#{data[:type]} alert-dismissible",
        data: {
          kind: data[:kind],
          text: message
        }
      }

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss": "alert", "aria-hidden": true)

      h5 = content_tag(:h5, content_tag(:i, "", class: "icon #{data[:icon]}") + data[:title])

      Array(message).each do |msg|
        text = content_tag(:div, close_button + h5 + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash[:error] = nil
    flash_messages.join("\n").html_safe
  end
end
