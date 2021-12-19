
function originalCSS(){

  

}

function changeCSS(){



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
