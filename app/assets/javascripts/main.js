
var myApp = myApp || {};

myApp.setup = function() {
  console.log("Main JS loaded");
};

$(function() {
  myApp.setup();

});