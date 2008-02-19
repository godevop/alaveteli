# app/controllers/help_controller.rb:
# Show information about one particular request.
#
# Copyright (c) 2008 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: help_controller.rb,v 1.2 2008-02-19 17:41:58 francis Exp $

class HelpController < ApplicationController
    
    def about
    end

    def contact
        if params[:submitted_contact_form]
            @contact = ContactValidator.new(params[:contact])
            if @contact.valid?
                ContactMailer.deliver_message(
                    params[:contact][:name],
                    params[:contact][:email],
                    params[:contact][:subject],
                    params[:contact][:message],
                    "IP #{request.env['REMOTE_HOST']}"
                )
                flash[:notice] = "Your message has been sent. Thank you for getting in touch! We'll get back to you soon."
                redirect_to home_url 
                return
            end
        end
         
    end

end
