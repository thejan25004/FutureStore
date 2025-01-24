let dashboardForm = $("#dashboard");
let cartsForm = $("#cardpage");
let productsForm = $("#product");
let  logInForm = $("#loginModal")

cartsForm.css("display","none");
// productsForm.css("display","none")
logInForm.css("display" , "none");

$("#dashboard-nav").on('click',function () {
      dashboardForm.css("display","block");
      cartsForm.css("display","none");
      productsForm.css("display","block");
     logInForm.css("display","none");

});

$("#carts-nav").on('click',function () {
    dashboardForm.css("display","none");
    cartsForm.css("display","block");
    productsForm.css("display","none");
    logInForm.css("display","none");
});

$("#products-nav").on('click',function () {
    dashboardForm.css("display","none");
    cartsForm.css("display","none");
    productsForm.css("display","block");
    logInForm.css("display","none");
});

$("#logIn-nav").on('click',function () {
    dashboardForm.css("display","none");
    cartsForm.css("display","none");
    productsForm.css("display","none");
    logInForm.css("display","block");
});

// $(document).ready(function () {
//     // Initial state
//     $("#dashboard").show();
//     $("#cardpage").hide();
//
//     // Event listeners for navigation
//     $("#dashboard-nav").click(function () {
//         $("#dashboard").show();
//         $("#cardpage").hide();
//     });
//
//     $("#carts-nav").click(function () {
//         $("#dashboard").hide();
//         $("#cardpage").show();
//     });
// });