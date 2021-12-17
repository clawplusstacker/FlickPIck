
function originalCSS(){

  $("#homeBody1").css("height", "600px");
  $(".bannerMainText").show()
  $(".bannerDescText").css("font-size", "3vw");
  $(".bannerDescText").css("text-align", "left");
  $("#logoDescText").css("left", "45%")


  $("#body1Left").css("float", "left");
  $("#body1Left").css("width", "50%");
  $("#body1Left").css("padding", "5% 0% 0% 6%");
  $("#aboutMeText").css("font-size", "2.2vh");
  $("#body1Right").show();


  $("iframe").css("width", "850px");
  $("iframe").css("height", "500px");
  $("#homeBody2").css("height", "1200px")


}

function changeCSS(){

  $(".bannerMainText").hide()
  $(".bannerDescText").css("font-size", "40px");
  $(".bannerDescText").css("text-align", "center");
  $("#logoDescText").css("left", "28%")

  $("#body1Left").css("float", "none");
  $("#body1Left").css("width", "100%");
  $("#body1Left").css("padding", "4%");
  $("#aboutMeText").css("font-size", "17px");
  $("#body1Right").hide();


  $("iframe").css("width", "300px");
  $("iframe").css("height", "200px");
  $("#homeBody2").css("height", "700px")


}

$(function() {

  var win = $(this);
  var width = 855

  //When resizing 
  $(window).on('resize', function(){

    if (win.width() > width) {
      originalCSS()
    }else{

      changeCSS()
    }

  })

  //On load 
   $(document).ready(function() {

      if (win.width() > width) {
        originalCSS()
      }else{
        changeCSS()
      }
  })
})
