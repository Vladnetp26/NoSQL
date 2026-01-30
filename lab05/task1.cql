// Задание 1

// Социальная сеть: Люди и их предпочтения
CREATE (Jane:Person {name: "Jane"}),
       (Tom:Person {name: "Tom"}),
       (Patty:Person {name: "Patty"});

// Джейн любит айсвайн
MATCH (p:Person {name: "Jane"}), (w:Wine {style: "ice wine"})
CREATE (p)-[:likes]->(w);

// Том доверяет Публикации
MATCH (p:Person {name: "Tom"}), (pub:Publication {name: "Wine Expert Monthly"})
CREATE (p)-[:trusts]->(pub);

// Патти дружит с Томом и Джейн
MATCH (p1:Person {name: "Patty"}), (p2:Person {name: "Tom"})
CREATE (p1)-[:friends]->(p2);

MATCH (p1:Person {name: "Patty"}), (p2:Person {name: "Jane"})
CREATE (p1)-[:friends]->(p2);

// Запросы (SELECT)
// Кто с кем дружит (друзья Джейн)
MATCH (p:Person {name: "Jane"})--(others)
RETURN p.name, labels(others), others.name;

// Друзья друзей Патти
MATCH (patty:Person {name: "Patty"})-[:friends]-(friend)-[:friends]-(fof)
WHERE fof.name <> "Patty"
RETURN fof.name AS FriendOfFriend;

