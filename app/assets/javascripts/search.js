  var marker_new
  var geocoder
  var aft
  var map
  var marker = [];
  var infoWindow = [];

  function initMap(){
    if ( $('#new_map').length ){
      geocoder = new google.maps.Geocoder()

      map = new google.maps.Map(document.getElementById('new_map'), {
        center:  {lat: 35.6803997, lng:139.7690174},  //東京
        zoom: 13,
        draggable: true
      });
    }
    if ( $('#edit_map').length ){
      var post = gon.post;
      geocoder = new google.maps.Geocoder()

      map = new google.maps.Map(document.getElementById('edit_map'), {
        center:  {lat: post.lat, lng: post.lng },
        zoom: 13,
      });

      marker = new google.maps.Marker({ //GoogleMapにマーカーを落とす
        position: {lat: post.lat , lng: post.lng }, //マーカーを落とす位置を決める（値はDBに入っている）
        map: map //マーカーを落とすマップを指定
      });
    }
    if ( $('#search_map').length ) {
      var posts = gon.posts;
      var markersData = [];
        posts.forEach(function(post){
          var data = {
            id: post.id,
            image: post.image,
            name: post.title,
            lat: post.lat,
            lng: post.lng
          }
          markersData.push(data);
        });
      map = new google.maps.Map(document.getElementById("search_map"), {
        zoom: 6,
        center:  {lat: 35.6803997, lng:139.7690174},  //東京
        });

      for (var i = 0; i < markersData.length; i++ ){
        markerLatLng = new google.maps.LatLng({lat: markersData[i]['lat'], lng: markersData[i]['lng']});
        marker[i] = new google.maps.Marker({
          position: markerLatLng,
          map: map
        });
        infoWindow[i] = new google.maps.InfoWindow({
          content: '<a href="/posts/' + markersData[i]['id'] + '">' + markersData[i]['name'] + '</a>',
          // '<br>' + '<img src="/public/uploads/' + markersData[i]['image'] + '.jpg">',
          disableAutoPan: true
        });
        markerEvent(i);
      }
    }
  }

  function markerEvent(i){
    marker[i].addListener('click', function(){
      infoWindow[i].open(map, marker[i]);
    });
  }

  function codeAddress(){
    var inputAddress = document.getElementById('address').value;
    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
      if (status == 'OK') {
        //マーカーが複数できないようにする
        if (aft == true){
            marker_new.setMap(null);
        }

        //新しくマーカーを作成する
        map.setCenter(results[0].geometry.location);
            marker_new = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location,
            draggable: true // ドラッグ可能にする
        });

        //二度目以降か判断
        aft = true

        //検索した時に緯度経度を入力する
        document.getElementById('lat').value = results[0].geometry.location.lat();
        document.getElementById('lng').value = results[0].geometry.location.lng();

        // マーカーのドロップ（ドラッグ終了）時のイベント
        google.maps.event.addListener( marker_new, 'dragend', function(ev){
            // イベントの引数evの、プロパティ.latLngが緯度経度
            document.getElementById('lat').value = ev.latLng.lat();
            document.getElementById('lng').value = ev.latLng.lng();
        });
      } else {
        alert('該当する結果がありませんでした：' + status);
      }
    });
  }