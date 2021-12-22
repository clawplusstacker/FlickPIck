$(function() {

  scrollChange()
 
})


function scrollChange() {
  var ssGrid = $("#homeBody1SSGrid");
  var aboutUsText = $("#aboutUsText");
  var teamPic = $("#teamPic")

  $(window).scroll(function() {

      var scroll = $(window).scrollTop();

      if (scroll >= 250) {
        ssGrid.css("margin-top", "40px")
      } else {
        ssGrid.css("margin-top", "80px")
      }


      if(scroll >= 1900){
        aboutUsText.css("margin-top", "100px")
        teamPic.css("margin-top", "40px")

      }else{
        aboutUsText.css("margin-top", "130px")
        teamPic.css("margin-top", "80px")
      }


    });
}
