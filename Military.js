use Military
// drop collection
db.address.drop()
db.headquarter.drop()
db.division.drop()
db.vehicle.drop()
db.personnel.drop()
db.weapon.drop()
db.gear.drop()
db.mission.drop()
db.missionlog.drop()

//Insert Address
db.address.insertOne({
  zip_code: 44700,
  city: 'Lalitpur'
});

//Insert Headquarter
db.headquarter.insertOne({
  code: 'LMHQ',
  name: 'Lalitpur Metropolitan Headquarter',
  address: db.address.findOne({zip_code: 44700}),
  contact_person: 'Dipen Shrestha'
});

//Insert Division
db.division.insertMany([
  {
    division_id: 001,
    division_name: 'Alpha',
    division_size: 100,
    division_type: 'Infantry'
  },
  {
    division_id: 002,
    division_name: 'Bravo',
    division_size: 150,
    division_type: 'Armored'
  },
  {
    division_id: 003,
    division_name: 'Charlie',
    division_size: 120,
    division_type: 'Artillery'
  },
  {
    division_id: 004,
    division_name: 'Delta',
    division_size: 80,
    division_type: 'Special Forces'
  },
  {
    division_id: 005,
    division_name: 'Foxtrot',
    division_size: 110,
    division_type: 'Airborne'
  }
]);

//Insert Vehicle
db.vehicle.insertMany([
    {
        vehicle_id: 1,
        vehicle_name: 'Tank',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Heavy',
        division: db.division.findOne({division_id: 002})
    },
    {
        vehicle_id: 2,
        vehicle_name: 'Chopper',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Air Attack',
        division: db.division.findOne({division_id: 002})
    },
    {
        vehicle_id: 3,
        vehicle_name: 'Transport truck',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Heavy',
        division: db.division.findOne({division_id: 001})
    },
    {
        vehicle_id: 4,
        vehicle_name: 'Fighter Jet',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Interceptor',
        division: db.division.findOne({division_id: 003})
    },
    {
        vehicle_id: 5,
        vehicle_name: 'APC',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Armoured',
        division: db.division.findOne({division_id: 002})
    },
    {
        vehicle_id: 6,
        vehicle_name: 'Missile Launcher',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Artillery',
        division: db.division.findOne({division_id: 003})
    },
    {
        vehicle_id: 7,
        vehicle_name: 'Scout Vehicle',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Light',
        division: db.division.findOne({division_id: 004})
    },
    {
        vehicle_id: 8,
        vehicle_name: 'Transport aircraft',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        vehicle_type: 'Utility',
        division: db.division.findOne({division_id: 005})
    }
]);


//Insert Personnel
db.personnel.insertMany([
  {
    per_id: 1001,
    per_name: 'Ram Shrestha',
    per_rank: 'Captain',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    vehicle_type: 'Utility',
    division: db.division.findOne({division_id: 001}),
    kills: 73
  },
  {
    per_id: 1002,
    per_name: 'Sam Shrestha',
    per_rank: 'private',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 003}),
    kills: 15
  },
  {
    per_id: 1003,
    per_name: 'Hari Shrestha',
    per_rank: 'Commander',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 002}),
    kills: 72
  },
  {
    per_id: 1004,
    per_name: 'Dipen Shrestha',
    per_rank: 'Lieutenant',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 004}),
    kills: 51
  },
  {
    per_id: 1005,
    per_name: 'Dypen Crest',
    per_rank: 'Sergeant',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 004}),
    kills: 49
  },
  {
    per_id: 1006,
    per_name: 'Tom Crest',
    per_rank: 'Staff Sergeant',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 004}),
    kills: 36
  },
  {
    per_id: 1007,
    per_name: 'Leon Kennedy',
    per_rank: 'Corporal',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 001}),
    kills: 23
  },
  {
    per_id: 1008,
    per_name: 'Jill Valentine',
    per_rank: 'Private',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 002}),
    kills: 10
  },
  {
    per_id: 1009,
    per_name: 'Claire Redfield',
    per_rank: 'Private',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 003}),
    kills: 6
  },
  {
    per_id: 1010,
    per_name: 'Arthur Morgan',
    per_rank: 'Sergeant',
    headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
    division: db.division.findOne({division_id: 005}),
    kills: 53
  }
])

//Insert Weapon
db.weapon.insertMany([
  {
    equipment_id: "001",
    equipment_name: "AK-47",
    weapon_type: "Assault Rifle",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 33
  },
  {
    equipment_id: "002",
    equipment_name: "M4 Carbine",
    weapon_type: "Assault Rifle",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 127
  },
  {
    equipment_id: "003",
    equipment_name: "M9 pistol",
    weapon_type: "Hand Gun",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 308
  },
  {
    equipment_id: "004",
    equipment_name: "M240B",
    weapon_type: "Machine Gun",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 26
  },
  {
    equipment_id: "005",
    equipment_name: "M107",
    weapon_type: "Sniper Rifle",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 23
  },
  {
    equipment_id: "006",
    equipment_name: "RPG-7",
    weapon_type: "Rocket launcher",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 12
  },
  {
    equipment_id: "007",
    equipment_name: "Khukuri",
    weapon_type: "Melee",
    headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
    quantity: 217
  }
]);


//Insert Gear
db.gear.insertMany([
    {
        equipment_id: 010,
        equipment_name: 'Helmet',
        gear_type: 'Ballistic',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        quantity: 363
    },
    {
        equipment_id: 011,
        equipment_name: 'Tactical Vest',
        gear_type: 'Ballistic',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        quantity: 379
    },
    {
        equipment_id: 012,
        equipment_name: 'Night Vision Goggles',
        gear_type: 'Goggles',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        quantity: 66
    },
    {
        equipment_id: 013,
        equipment_name: 'Radios',
        gear_type: 'Communication',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        quantity: 263
    },
    {
        equipment_id: 014,
        equipment_name: 'First aid Kits',
        gear_type: 'Medical',
        headquarter: db.headquarter.findOne({hq_id: 'LMHQ'}),
        quantity: 256
    }
]);


//Insert Explosive
db.explosive.insertMany([
   {
      equipment_id: 100,
      equipment_name: "C4",
      explosive_type: "Plastic explosive",
      headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
      quantity: 50
   },
   {
      equipment_id: 200,
      equipment_name: "M18 Claymore",
      explosive_type: "Antipersonnel mine",
      headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
      quantity: 20
   },
   {
      equipment_id: 300,
      equipment_name: "M67 Frag",
      explosive_type: "Hand grenade",
      headquarter: db.headquarter.findOne({hq_id: "LMHQ"}),
      quantity: 100
   }
]);

//Insert Mission
db.mission.insertMany([
{
    mission_id: 1,
    mission_name: "Assassination",
    mission_geolocation: [
        {
            location_name: "Chitwan",
            location_type: "City",
            latitude: 51.5074,
            longitude: -0.1278
        },
        {
            location_name: "Hetauda",
            location_type: "Jungle",
            latitude: 48.8566,
            longitude: 2.3522
        }
    ],
    start_date: ISODate("2023-04-01T00:00:00Z"),
    end_date: ISODate("2023-04-04T00:00:00Z"),
    duration: {
        days: 3,
        hours: 4,
        minutes: 0,
        seconds: 0
    },
    division: db.division.findOne({division_id: 002}),
    status: "Ended"
},
{
    mission_id: 2,
    mission_name: "Sabotage",
    mission_geolocation: [
        {
            location_name: "Redzone",
            location_type: "Landmark",
            latitude: 27.6810,
            longitude: 85.3139
        },
        {
            location_name: "Firebase",
            location_type: "Landmark",
            latitude: 27.6841,
            longitude: 85.3197
        }
    ],
    start_date: ISODate("2023-04-15T00:00:00Z"),
    end_date: ISODate("2023-04-17T00:00:00Z"),
    duration: {
        days: 2,
        hours: 4,
        minutes: 0,
        seconds: 0
    },
    division: db.division.findOne({division_id: 004}),
    status: "Ended"
},
{
    mission_id: 3,
    mission_name: "Reconnaissance",
    mission_geolocation: [
        {
            location_name: "Biratchowk",
            location_type: "Town",
            latitude: 33.3152,
            longitude: 44.3661
        },
        {
            location_name: "Biratnagar",
            location_type: "City",
            latitude: 36.3350,
            longitude: 43.1189
        }
    ],
    start_date: ISODate("2023-05-01T00:00:00Z"),
    end_date: ISODate("2023-05-04T00:00:00Z"),
    duration: {
        days: 4,
        hours: 8,
        minutes: 0,
        seconds: 0
    },
    division: db.division.findOne({division_id: 001}),
    status: "In progress"
},
{
    mission_id: 4,
    mission_name: "Convoy Escort",
    mission_geolocation: [
        {
            location_name: "Newroad",
            location_type: "Route",
            latitude: 27.6987,
            longitude: 85.3171
        },
        {
            location_name: "Putalisadak",
            location_type: "Route",
            latitude: 27.6949,
            longitude: 85.3232
        }
    ],
    start_date: ISODate("2023-05-10T00:00:00Z"),
    end_date: ISODate("2023-05-12T00:00:00Z"),
    duration: {
        days: 2,
        hours: 0,
        minutes: 0,
        seconds: 0
    },
    division: db.division.findOne({division_id: 002}),
    status: "Planning"
}
]);

//Insert Missionlog
db.missionlog.insertMany([
  {
    log_id: 1,
    mission_id: db.mission.findOne({mission_id:1}),
    outcome: "Accomplished",
    casualties: 0
  },
  {
    log_id: 2,
    mission_id: db.mission.findOne({mission_id:2}),
    outcome: "Failed",
    casualties: 3
  },
  {
    log_id: 3,
    mission_id: db.mission.findOne({mission_id:3}),
    outcome: "Pending",
    casualties: null
  },
  {
    log_id: 4,
    mission_id: db.mission.findOne({mission_id:4}),
    outcome: "Pending",
    casualties: null
  }
]);

//Join Collection(Headquarter,Division,Personnel,Mission)
db.headquarter.aggregate([
    { $lookup: {
        from: 'personnel',
        localField: 'hq_id',
        foreignField: 'headquarter.hq_id',
        as: 'personnel'
    } },
    { $unwind: '$personnel' },
    { $lookup: {
        from: 'division',
        localField: 'personnel.division.division_id',
        foreignField: 'division_id',
        as: 'division'
    } },
    { $unwind: '$division' },
    { $lookup: {
        from: 'mission',
        localField: 'division.division_id',
        foreignField: 'division.division_id',
        as: 'mission'
    } },
    { $project: {
        _id: 1,
        hq: '$hq_id',
        division: '$division.division_name',
        personnel: '$personnel.per_name',
        rank: '$personnel.per_rank',
        mission: { $arrayElemAt: ['$mission.mission_type', 0] }
    } }
]);



//Union/Intersect
db.vehicle.aggregate([
    { $project: { _id: 1, vehicle_name: 1 } },
    { $unionWith: { coll: 'vehicle', pipeline: [
        { $match: { 'division.division_id': { $in: ['001', '002'] } } },
        { $project: { _id: 0, vehicle_name: 1 } }
    ] } }
]);


//Nested
db.mission.aggregate([
  {
    $lookup: {
      from: "location",
      localField: "mission_geolocation.location_id",
      foreignField: "location_id",
      as: "location"
    }
  },
  {
    $match: {
      "division.division_type": "Special Forces"
    }
  },
  {
    $project: {
      _id: 1,
      mission_id: 1,
      division: "$division.division_type",
      mission: 1,
      location: "$mission_geolocation.location_name",
      type: "$mission_geolocation.location_type",
      latitude: "$mission_geolocation.latitude",
      longitude: "$mission_geolocation.longitude"
    }
  }
]);


//Temporal
db.mission.aggregate([
  { 
    $match: {
      start_date: {
        $gte: ISODate('2023-04-01T00:00:00.000Z'),
        $lte: ISODate('2023-05-10T23:59:59.999Z')
      }
    }
  },
  {
    $group: {
      _id: {
        $month: "$start_date"
      },
      number_of_mission: {
        $sum: 1
      }
    }
  },
  {
    $addFields: {
      month: "$_id"
    }
  },
  {
    $project: {
      _id: 0,
      number_of_mission: 1,
      month: 1

    }
  }
]);



//Partition
db.personnel.aggregate([
  {
    $match: {
      kills: { $gt: 5 }
    }
  },
  {
    $lookup: {
      from: "division",
      localField: "division.division_id",
      foreignField: "division_id",
      as: "division"
    }
  },
  {
    $unwind: "$division"
  },
  {
    $group: {
      _id: "$division.division_type",
      personnel: { $push: "$per_name" },
      average_kills: { $avg: "$kills" },
      min_kills: { $min: "$kills" },
      max_kills: { $max: "$kills" }
    }
  },
  {
    $project: {
      _id: 1,
      division: "$_id",
      personnel: 1,
      average_kills: 1,
      min_kills: 1,
      max_kills: 1
    }
  }
]);


















