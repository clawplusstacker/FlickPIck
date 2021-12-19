$(function() {

  scrollChange()
 
})
function scrollChange() {
  var header = $(".navBarNew");
  var readmore = $(".readmore");

  $(window).scroll(function() {

      var scroll = $(window).scrollTop();

      if (scroll >= 100) {
          header.addClass("navBarScroll");
      } else {
          header.removeClass("navBarScroll");
      }

      if(scroll >= 150){
          readmore.addClass("scrollFade");

      }else {
        readmore.removeClass("scrollFade");
      }
    });
}

function widthAndScroll(){
  var win = $(this);
  var header = $(".navBarNew");


  $(window).on('resize', function(){

    if (win.width() > 750) {
      scrollChange();
      header.removeClass("navBarScroll")
    }else{
      header.addClass("navBarScroll")
    }

  });

  $(document).ready(function() {
  
    if (win.width() > 750) {
      scrollChange();
    }else{
      header.addClass("navBarScroll")
    }

  });  

}