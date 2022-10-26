   def place_order
      # byebug 
      if params[:address_id].present? 
         cart = current_user.cart
         if cart.present? and cart.cart_items.present? 
            @order = current_user.orders.new(total_price: cart.total_price,total_quantity: cart.total_quantity, address_id: params[:address_id].to_i)
            cart.cart_items.each do |orderitem|
              @order_item = @order.order_items.new(product_id: orderitem.product_id, total_price: orderitem.total_price, product_quantity: orderitem.product_quantity)
            end

            if @order.save
               cart.destroy  
               redirect_to orders_path(@order.id)
            end
         else
            redirect_to orders_path
         
         end
      else
         flash[:error] = "please select delivery address or create new!!" 
         redirect_to carts_path
      end
   end

    def add_to_cart   #<first code >
        cart = Cart.find_or_create_by(user_id: current_user.id)
           product = Product.find_by(id: params[:home_id])
           cart_item = cart.cart_items.new(product_id: product.id, total_price: product.price, product_quantity: 1)
           if cart_item.save
                redirect_to home_index_path
           else
                flash[:alert] = "product not saved!!"  
           end
    end


    def add_to_cart
        cart = Cart.find_or_create_by(user_id: current_user.id)
        if cart.present?
           product = Product.find_by(id: params[:home_id])
           if cart.cart_items.find_by(product_id: product.id).present?
                flash[:message]="Product is already in cart" 
                redirect_to home_index_path
                return
            end
           cart_item = cart.cart_items.new(product_id: product.id, total_price: product.price, product_quantity: 1)

           if cart_item.save
                flash[:message] = "Product added to cart..."
                redirect_to home_index_path
           else
                flash[:alert] = "product not saved!!"  
           end

        end
    end















<h3>pay for orders</h3>
<div >
    <button id="rzp-button1">Pay</button>
</div>

<script>
  document.getElementById('rzp-button1').onclick = function(e){
    
  var options = {
    "key": "rzp_test_sGKFWWIENwCHjV", 
    "amount": "<%= @order.total_price %>", 
    "currency": "INR",
    "name": "Product App",
    "description": "Test Transaction",
    "image": "https://example.com/your_logo",
    "order_id": "<%= @order.razorpay_order_id %>",
    "handler": function (response){
        alert(response.razorpay_payment_id);
        // alert(response.razorpay_order_id);
        // alert(response.razorpay_signature);
        $.ajax({
          type:"PATCH",
          url:"/orders/<%= @order.id %>",
          dataType:"json",
          data: {
            razorpay_payment_id: response.razorpay_payment_id,
            razorpay_signatuz
            amount: <%= @order.total_price/100 %>,
            cart_item_id: <%= @cart.id %>
          },
          success:function(result){
            debugger;
            alert(result);
          }
        });
        window.location = "/orders";
    },
    "prefill": {
        "name": "Gaurav Kumar",
        "email": "gaurav.kumar@example.com",
        "contact": "9340716896"
    },
    "notes": {
        "address": "Razorpay Corporate Office"
    },
    "theme": {
        "color": "#3399cc"
    }
};
var rzp1 = new Razorpay(options);
rzp1.on('payment.failed', function (response){
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
});
    rzp1.open();
    e.preventDefault();
}
</script>
