import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

def callback(ch, method, properties, body):
    print(f" [x] Received {body.decode()}")
    print(" [x] Simulating processing failure — rejecting message")
    ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

channel.basic_consume(queue='main_queue', on_message_callback=callback)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
