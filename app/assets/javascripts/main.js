var myMap = myMap || {};

myMap.initialize = function(){
  var mapOptions = {
    center: { lat: 51.52, lng: -0.115 },
    zoom: 14
  };






  myMap.map = new google.maps.Map(myMap.mapElement, mapOptions);


  var markerOptions = {
    position: { lat: 51.53, lng: -0.109446}
  };

  var marker = new google.maps.Marker(markerOptions);

  marker.setMap(myMap.map);

  var popupOptions = {
    content: 'We are here'
    // position: new google.maps.LatLng(51.535, -0.10945)
  };

  var popup = new google.maps.InfoWindow(popupOptions);

  setTimeout(function(){
    popup.open(myMap.map);
  }, 5000);

  google.maps.event.addListener(marker, "mouseover", function(){
    popup.open(myMap.map, marker);
  });

  google.maps.event.addListener(marker, "mouseout", function(){
    popup.close(myMap.map, marker);
  });

  // setTimeout(function(){
  //   myMap.map.setCenter(marker.getPosition())
  // }, 3000);

  myMap.locatorElement.on("click", function(){
    myMap.getPosition();
  });
}

myMap.getPosition = function(){
  if(navigator.geolocation){
    var geolocation = navigator.geolocation.getCurrentPosition(myMap.geolocationSuccess, myMap.geolocationFail);
  } else {
    alert("You cannot geolocate");
  }
};

myMap.populateMap = function() {
  $.get(
    '/users',
    {},
    function(data) {
      $.each(data, function(key, value) {
        console.log(value);
       });
    },
    'json'
  );
}

myMap.geolocationSuccess = function(position){
  myMap.addMarker({
    lat: position.coords.latitude, 
    lng: position.coords.longitude,
    icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
    popupContent: 'You are here'
  });

};

myMap.addMarker = function(data){
  var markerOptions = {
    position: { lat: data.lat, lng: data.lng},
    icon: data.icon
  };

  var marker = new google.maps.Marker(markerOptions);

  marker.setMap(myMap.map);
  myMap.map.setCenter(marker.getPosition());
  myMap.map.setZoom(17);

  var popupOptions = {
    content: data.popupContent
  };

  var popup = new google.maps.InfoWindow(popupOptions);

  google.maps.event.addListener(marker, "click", function(){
    popup.open(myMap.map, marker);    
  });

  popup.open(myMap.map, marker);

};


$(function(){
  myMap.mapElement = $("#map-canvas")[0];
  myMap.locatorElement = $("#locator");
  myMap.initialize();
});


// var myApp = myApp || {};
// // var markerOptions = {
// //       position: new google.maps.LatLng(51.53, -0.109446)
// //   }
// myApp.initMap = function() {
 
//   var mapOptions = {
//       center: { lat:  51.52, lng: -0.115},     
//       zoom: 14,
//       mapTypeId:google.maps.MapTypeId.ROADMAP //default
//   };

//     var map = new google.maps.Map(myApp.mapCanvas, mapOptions);
//     var markerOptions = {
//       position: {lat: 51.53, lng: -0.115446}
//     };

//     var marker = new google.maps.Marker(markerOptions);
//     marker.setMap(map);
//     myApp.map.setCenter(marker.getPosition());
//       myApp.map.setZoom(17);

// };  

// myApp.setup = function() {
//   console.log("Main JS loaded");
// };

// $(function() {
//   myApp.mapCanvas = $('#map-canvas')[0];
//   myApp.initMap();
// });