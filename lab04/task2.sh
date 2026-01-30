# Задание 2
COUCH_URL="http://admin:password@localhost:5984"
DB_NAME="music"

echo -e "\n--- Creating view 'random/artist' ---"
curl -X PUT "$COUCH_URL/$DB_NAME/_design/random" \
 -H "Content-Type: application/json" \
 -d '{
   "views": {
     "artist": {
       "map": "function(doc) { if (doc.random) { emit(doc.random, doc.name); } }"
     }
   }
 }'

# Запрос данных
echo -e "\n--- Querying artists/by_name (limit 5) ---"
curl "$COUCH_URL/$DB_NAME/_design/artists/_view/by_name?limit=5"

echo -e "\n--- Querying random/artist (find random) ---"
# Генерируем случайное число
rand="0.$RANDOM"
echo "Random startkey: $rand"
curl "$COUCH_URL/$DB_NAME/_design/random/_view/artist?startkey=$rand&limit=1"

