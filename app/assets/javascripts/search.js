if (document.getElementById("search_map") != null){
  console.log(1)
//   var map;
//   var marker = [];
//   var infoWindow = [];
//   var posts = gon.posts;
//   var markersData = [];
//     posts.forEach(function(post){
//       var data = {
//         name: post.title,
//         lat: post.lat,
//         lng: post.lng
//       }
//       markersData.push(data);
//       console.log(data);
//     });
//   function initMap(){
//     map = new google.maps.Map(document.getElementById("search_map"), {
//       zoom: 6,
//       center:  {lat: 35.6803997, lng:139.7690174},  //東京
//     });

//     for (var i = 0; i < markersData.length; i++ ){
//       markerLatLng = new google.maps.LatLng({lat: markersData[i]['lat'], lng: markersData[i]['lng']});
//       marker[i] = new google.maps.Marker({
//         position: markerLatLng,
//         map: map
//       });
//       infoWindow[i] = new google.maps.InfoWindow({
//         content: markersData[i]['name'],
//         disableAutoPan: true
//       });
//       markerEvent(i);
//     }
//   }

//   function markerEvent(i){
//     marker[i].addListener('click', function(){
//       infoWindow[i].open(map, marker[i]);
//     });
//   }
 }
