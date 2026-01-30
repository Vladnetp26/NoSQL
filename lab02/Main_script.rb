include Java
import 'org.apache.hadoop.hbase.client.ConnectionFactory'
import 'org.apache.hadoop.hbase.client.Put'
import 'org.apache.hadoop.hbase.util.Bytes'
import 'org.apache.hadoop.hbase.TableName'

# Перед заданиями выполню подготовку
conf = @hbase.configuration
connection = ConnectionFactory.createConnection(conf)
admin = connection.getAdmin()

table_name = TableName.valueOf('wiki')
unless admin.tableExists(table_name)
  puts "Creating 'wiki' table..."
  create 'wiki', 'text', 'revision' 
end

# Задание 1: Создайте функцию под названием put_many(), которая создает экземпляр Put, добавляет любое
# количество пар "колонка-значение" и фиксирует их в таблице.
def put_many(table_name, row, column_values)
  table = @hbase.getTable(table_name)
  p = Put.new(Bytes.toBytes(row))
  column_values.each do |key, value|
    parts = key.split(':')
    family = parts[0]
    qualifier = parts[1] || "" 
    
    p.addColumn(Bytes.toBytes(family), Bytes.toBytes(qualifier), Bytes.toBytes(value))
  end
  
  # Отправка
  table.table.put(p)
  puts "Row '#{row}' inserted successfully."
  table.close()
end

# Задание 2: Использование put_many
puts "Executing put_many..."
put_many 'wiki', 'Some title', {
  "text" => "Some article text",
  "revision:author" => "jschmoe",
  "revision:comment" => "no comment" 
}

# Проверка результата
puts "Verifying insertion..."
count 'wiki'
scan 'wiki'

exit
