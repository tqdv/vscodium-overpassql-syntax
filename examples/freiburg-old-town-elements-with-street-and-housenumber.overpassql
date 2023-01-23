// [bbox:south,west,north,east]
[bbox:47.9892,7.8344,-47.9998,7.8598]
[out:json];

area["name"="Altstadt"]["admin_level"="10"]->.administrativeBoundary;
(
  nwr["addr:street"]["addr:housenumber"](area.administrativeBoundary);
);

out center;
out count;
