var myMap = myMap || {};

myMap.initialize = function(){
  var mapOptions = {
    center: { lat: 51.52, lng: -0.115 },
    zoom: 5,

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

  function dogContent(user) {
    var returnString = '';
    console.log(user)
    $.each(user.dogs, function(key, dog) {

      returnString += '<a href ="/dogs/' + dog.id + '">' + '<img src="' + dog.picture.thumb.url + '"></a>';

    });

    
    



    return returnString;
  }

  $.get(
    '/users',
    {},
    function(data) {
      $.each(data, function(key, user) {
        if (user.postcode) {
          myMap.addMarker({
            lat: user.home_lat,
            lng: user.home_long,
            icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',

            popupContent: '<a href="/users/' + user.id + '">'+ user.name + '</a><br/>' +
              '<a href="/users/' + user.id + '/conversations/new">Message me!</a><br/>' + dogContent(user)

          });
        }        
      });
    },
    'json'
    );
}



// var infowindow = new google.maps.InfoWindow({
//   content: '<a href="/businesses/' + business.id + '">' + business.business_name + '</a><br/>' + 'Phone: ' + business.phone
// });

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

myMap.userMap = function() {
  myMap.userHomeLat = parseFloat($('#user_home_lat').text());
  myMap.userHomeLng = parseFloat($('#user_home_long').text());
  var mapUserOptions = {
  center: { lat: myMap.userHomeLat, lng: myMap.userHomeLng },
    zoom: 7,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false, 
    mapTypeControl: false 
  };
  myMap.map = new google.maps.Map(myMap.mapUserElement, mapUserOptions);
  var markerUserOptions = {
      position: new google.maps.LatLng(myMap.userHomeLat, myMap.userHomeLng)
    }
  var markerUser = new google.maps.Marker(markerUserOptions);
  markerUser.setMap(myMap.map)
  
};

$(function(){
  if (myMap.mapElement = $("#map-canvas")[0]) {
    myMap.initialize();
    myMap.getPosition();
    myMap.populateMap();    

  }
  if (myMap.mapUserElement = $("#map-user")[0]) {
    myMap.userMap();    
  }
});


