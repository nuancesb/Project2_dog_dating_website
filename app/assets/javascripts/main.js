
var myApp = myApp || {};

myApp.initMap = function() {
 
  var mapOptions = {
      center: { lat:  51.52, lng: -0.115},     
      zoom: 14,
      mapTypeId:google.maps.MapTypeId.ROADMAP //default
  };

    var map = new google.maps.Map(myApp.mapCanvas, mapOptions);
  
};

myApp.setup = function() {
  console.log("Main JS loaded");
};

$(function() {
  myApp.mapCanvas = $('#map-canvas')[0];
  myApp.initMap();
});