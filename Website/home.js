
function originalCSS(){

  $(".bannerContainer").css("min-height", "90%")
  $("#bannerLeft").css("float", "left")
  $("#bannerRight").show();

  $(".ssPic").css("width", "300")

  $(".homeBody2Header").css("padding-top", "130px")
  $("#demoDesc").css("width", "25%")
  $("iframe").show()

  $(".halfLeft").css("float", "left")
  $(".halfLeft").css("width", "50%")
  $(".halfLeft").css("height", "80%")
  $(".halfRight").css("float", "right")
  $(".halfRight").css("width", "50%")
  $("#teamPic").css("margin-top", "80px")


}

function changeCSS(){

 
  $(".bannerContainer").css("min-height", "100%")
  $("#bannerLeft").css("float", "none")
  $("#bannerRight").hide();

  $(".ssPic").css("width", "100px")

  $(".homeBody2Header").css("padding-top", "30px")
  $("#demoDesc").css("width", "50%")
  $("iframe").hide()

  $(".homeBody1").css("height", "1300px")
  $(".halfLeft").css("float", "none")
  $(".halfLeft").css("width", "100%")
  $(".halfLeft").css("height", "35%")
  $(".halfRight").css("float", "none")
  $(".halfRight").css("width", "100%")
  $("#teamPic").css("margin-top", "0px")


}

$(function() {

  var win = $(this);
  var width = 1100

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
