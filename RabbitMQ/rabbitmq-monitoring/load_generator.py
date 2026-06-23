import pika
import random
import time
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)

print(" [*] Generateur de charge demarre. Ctrl+C pour arreter.")

count = 0
try:
    while True:
        nb_points = random.randint(1, 8)
        message = f"Tache #{count} " + "." * nb_points

        channel.basic_publish(
            exchange='',
            routing_key='task_queue',
            body=message,
            properties=pika.BasicProperties(
                delivery_mode=pika.DeliveryMode.Persistent
            ))

        print(f" [x] Envoye: {message}")
        count += 1
        time.sleep(random.uniform(0.3, 1.5))

except KeyboardInterrupt:
    print(f"\n [*] Arret. {count} messages envoyes au total.")
    connection.close()
    sys.exit(0)
