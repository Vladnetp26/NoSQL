// Задание 1: Вывести JSON-документ { "hello": "world" }
printjson({ "hello": "world" });

// Задание 2: Поиск города по регистронезависимому шаблону 'new'

// Для начала создам в БД сами города, с примерно следующей структурой:
db.towns.insert({
  name: "Dublin",
  population: 49193,
  famousFor: ["Dublin Irish Festival", "PGA Memorial Tournament", "Bridge Street District"],
  mayor: { 
    name: "Jane Fox" 
  }
});

db.towns.insert({
 name: "New York",
 population: 22200000,
 famousFor: ["subway", "food"],
 mayor: {name: "Bill de Blasio"}
});

db.towns.insert({
 name: "New albanyy",
 population: 11770,
 famousFor: ["Shipbuilding "],
 mayor: { name: "Sloan Spalding" }
});

db.towns.insert({
 name: "Portland",
 population: 582000,
 famousFor: ["beer", "food", "Portlandia"],
 mayor: { name: "Ted Wheeler"}
});

var cursor = db.towns.find({ name: /new/i });
cursor.forEach(printjson);

// Задание 3: Города с буквой 'e', известные едой или пивом
cursor = db.towns.find({
    name: /e/,
    famousFor: { $in: ['food', 'beer'] }
});
cursor.forEach(printjson);

var bloggerDb = db.getSiblingDB('blogger');

// Задание 4: Создание базы blogger и добавление статьи
var article = {
    author: "Zlobin Vladislav",
    email: "vlad@example.com",
    date: new Date(),
    text: "MongoDB."
};
bloggerDb.articles.insert(article);
printjson(bloggerDb.articles.findOne());

// Задание 5: Добавление комментария к статье
var comment = {
    author: "Zlobin Vladislav",
    text: "Эта статья нужна мне для выполнения лабороторной"
};

bloggerDb.articles.update(
    { author: "Zlobin Vladislav" },
    { $push: { comments: comment } }
);
printjson(bloggerDb.articles.findOne());

// Задание 6: Завершение выполнения скрипта
print("Задание выполнено");