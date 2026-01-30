// Задание 3: Найдите все города в радиусе 50 миль от центра Лондона.
// Для начала внесем геоиндекс и прочие данные:
db = db.getSiblingDB('city');

db.cities.createIndex({ location: "2d" });
db.cities.insert({ name: "Moscow", location: [55.7558, 37.6173] });
db.cities.insert({ name: "London", location: [51.5074, -0.1278] });
db.cities.insert({ name: "Watford", location: [51.6565, -0.3903] }); // этот вариант точно попадает в необходимое для задания значение
db.cities.insert({ name: "Brighton", location: [50.8225, -0.1372] }); 

db.cities.createIndex({ location: "2d" });

print("Города в радиусе 50 миль от Лондона:");
var cursor = db.cities.find({
    location: {
        $geoWithin: {
            $center: [[51.5074, -0.1278], 0.72]
        }
    }
});
cursor.forEach(printjson);

