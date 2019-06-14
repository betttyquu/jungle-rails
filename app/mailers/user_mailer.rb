class UserMailer < ApplicationMailer
    default from: "no-reply@jungle.com"

    def order_email(order)
        @order = order
        @url = "http://localhost:3000"
        mail(to: order.email, subject: "Thank you for your order! Jungle Order # #{@order.id}")
    end

end
