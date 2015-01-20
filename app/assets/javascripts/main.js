var myMap = myMap || {};

myMap.initialize = function(){
  var mapOptions = {
    center: { lat: 51.52, lng: -0.115 },
    zoom: 5

  };

  myMap.map = new google.maps.Map(myMap.mapElement, mapOptions);

}

myMap.getPosition = function(){
  if(navigator.geolocation){
    var geolocation = navigator.geolocation.getCurrentPosition(myMap.geolocationSuccess, myMap.geolocationFail);
  } else {
    alert("You cannot geolocate");
  }
}

myMap.populateMap = function() {
  $.get(
    '/users',
    {},
    function(data) {
      $.each(data, function(key, value) {
        if (value.postcode) {
          myMap.addMarker({
            lat: value.home_lat,
            lng: value.home_long,
            icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',

            popupContent: value.description
          });
        }        
      });
    },
    'json'
    );
}

myMap.geolocationFail = function(position){
  console.log('failed to geolocate');
}

myMap.geolocationSuccess = function(position){
  myMap.addMarker({
    lat: position.coords.latitude, 
    lng: position.coords.longitude,
    icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
    popupContent: 'You are here'
  });
  myMap.map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
  myMap.map.setZoom(11);
}

myMap.addMarker = function(data){
  var markerOptions = {
    position: { lat: data.lat, lng: data.lng},
    icon: data.icon
  };

  var marker = new google.maps.Marker(markerOptions);

  marker.setMap(myMap.map);

  var popupOptions = {
    content: data.popupContent
  };

  var popup = new google.maps.InfoWindow(popupOptions);

  
  google.maps.event.addListener(marker, "click", function(){
    popup.open(myMap.map, marker);
  });

  google.maps.event.addListener(marker, "mouseover", function(){
    popup.close(myMap.map, marker);
  });
  popup.open(myMap.map, marker);

}


$(function(){
  if (myMap.mapElement = $("#map-canvas")[0]) {
    myMap.initialize();
    myMap.getPosition();
    myMap.populateMap();    

  }
});

