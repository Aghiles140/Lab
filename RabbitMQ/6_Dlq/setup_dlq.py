import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# 1. Déclarer l'exchange et la queue de Dead Letter
channel.exchange_declare(exchange='dlx', exchange_type='direct')
channel.queue_declare(queue='dead_letter_queue', durable=True)
channel.queue_bind(exchange='dlx', queue='dead_letter_queue', routing_key='dead')

# 2. Déclarer la queue principale, qui pointe vers la DLX en cas d'échec
channel.queue_declare(
    queue='main_queue',
    durable=True,
    arguments={
        'x-dead-letter-exchange': 'dlx',
        'x-dead-letter-routing-key': 'dead'
    }
)

print("Setup terminé : main_queue -> dlx -> dead_letter_queue")
connection.close()
