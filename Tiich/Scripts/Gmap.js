﻿var coords;

function SearchBox(map)
{
    // Create the search box and link it to the UI element.
    var input = /** @type {HTMLInputElement} */(
        document.getElementById('location'));
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(
      /** @type {HTMLInputElement} */(input));

    google.maps.event.addListener(searchBox, 'places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }
        for (var i = 0, marker; marker = markers[i]; i++) {
            marker.setMap(null);
        }
    });

}

function GetLocation(location) {
    coords = location.coords;

}

function initialize() {

    //Initialisation
    var markers = [];
    var map = new google.maps.Map(document.getElementById('map'), {
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    //Default placement
    var defaultBound;
    navigator.geolocation.getCurrentPosition(GetLocation, defaultBound);

    var defaultBounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(-33.8902, 151.1759),
        new google.maps.LatLng(-33.8474, 151.2631));

    // Try W3C Geolocation (Preferred)
    if (navigator.geolocation) {
        browserSupportFlag = true;
        navigator.geolocation.getCurrentPosition(function (position) {
            initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

            var oldLat = $("#oldLat").val();
            var oldLng = $("#oldLng").val();

            //alert(oldLat);
            if (oldLat != "")
            {
                oldLat = oldLat.replace(",", ".");
                oldLng = oldLng.replace(",", ".");
                initialLocation = new google.maps.LatLng(oldLat, oldLng);

            }
            map.setCenter(initialLocation);
        }, function () {
            handleNoGeolocation(browserSupportFlag);
        });
    }
        // Browser doesn't support Geolocation
    else {
        browserSupportFlag = false;
        handleNoGeolocation(browserSupportFlag);
    }

    //Get old default bounds 

    map.fitBounds(defaultBounds);
    map.setZoom(18);

    // Create the search box and link it to the UI element.
    var input = /** @type {HTMLInputElement} */(
        document.getElementById('address'));
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(
      /** @type {HTMLInputElement} */(input));

    // [START region_getplaces]
    // Listen for the event fired when the user selects an item from the
    // pick list. Retrieve the matching places for that item.
    google.maps.event.addListener(searchBox, 'places_changed', function () {
        
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }
        for (var i = 0, marker; marker = markers[i]; i++) {
            marker.setMap(null);
        }

        // For each place, get the icon, place name, and location.
        markers = [];
        var bounds = new google.maps.LatLngBounds();
        for (var i = 0, place; place = places[i]; i++) {
            var image = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };

            // Create a marker for each place.
            var marker = new google.maps.Marker({
                map: map,
                icon: image,
                title: place.name,
                position: place.geometry.location
            });
            markers.push(marker);
            bounds.extend(place.geometry.location);

            var coord = place.geometry.location;

            var scoord = coord + "";
            var lat = scoord.split(",")[0].substr(1, scoord.split(",")[0].length - 1);
            var lng = scoord.split(",")[1].substr(0, scoord.split(",")[1].length - 2);
            //alert($("#Location_Latitude") + coord.LatLng + lat + lng);

            lat = lat.replace(".", ",");
            lng = lng.replace(".", ",");
            $("#Lat").val(lat);
            $("#Lng").val(lng);
        }

        map.fitBounds(bounds);
        map.setZoom(18);

    });
    // [END region_getplaces]

    // Bias the SearchBox results towards places that are within the bounds of the
    // current map's viewport.
    google.maps.event.addListener(map, 'bounds_changed', function () {
        var bounds = map.getBounds();
        searchBox.setBounds(bounds);
    });
   
}

google.maps.event.addDomListener(window, 'load', initialize);
//google.maps.event.addDomListener(window, 'load', initialize);
