
function originalCSS(){

    $(".navBarLogoText").css("margin-left", "90%")
    $(".navBarLogoText").css("margin-top", "20px")
    $(".navBarOtherlinks").css("margin-top", "15px")
    $(".navBarOtherlinks").css("margin-right", "10px")
    $(".navBarContact").css("margin-right", "90px")
    $(".navBarContact").css("margin-top", "15px")

    $("#formDesc").show()

  
  }
  
  function changeCSS(){
  
    $(".navBarLogoText").css("margin-left", "0%")
    $(".navBarLogoText").css("margin-top", "0px")
    $(".navBarOtherlinks").css("margin-right", "0px")
    $(".navBarOtherlinks").css("margin-top", "0px")
    $(".navBarContact").css("margin-right", "0px")
    $(".navBarContact").css("margin-top", "0px")

    $("#formDesc").hide()

  
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
  