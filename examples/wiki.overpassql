[timeout:180]
[maxsize:1073741824]
  [out:csv(
    ::"id", amenity, name, operator, opening_hours, "contact:website", "contact:phone", brand, dispensing, lastcheck
  )]
[date:"2015-10-28T19:20:00Z"];
[diff:"2012-09-14T15:00:00Z","2012-09-21T15:00:00Z"];

  area[name="Bonn"]->.a;
  ( node(area.a)[railway=station];
    way(area.a)[railway=station];
   rel(area.a)[railway=station];
  );
  out;
  out count;

// TODO delete when done
if (triest.count(tirsentr(tiesnt) + ien.val )) {
  out;
} else {
  oientirt();
  nwr(if: rsietn["stien"] ) ;
}
