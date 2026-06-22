import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.basic_publish(exchange='', routing_key='main_queue', body='Message qui va échouer')
print(" [x] Message envoyé vers main_queue")
connection.close()
