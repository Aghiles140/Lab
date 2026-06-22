import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

def callback(ch, method, properties, body):
    print(f" [x] Message: {body.decode()}")
    print(f" [x] Headers: {properties.headers}")
    ch.basic_ack(delivery_tag=method.delivery_tag)

channel.basic_consume(queue='dead_letter_queue', on_message_callback=callback)
print(' [*] Inspecting dead_letter_queue. To exit press CTRL+C')
channel.start_consuming()
