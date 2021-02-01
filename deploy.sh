docker build \
    -t logic0verflow/multi-client:latest \
    -t logic0verflow/multi-client:$SHA \
    -f ./client/Dockerfile \
    ./client
docker build \
    -t logic0verflow/multi-server:latest \
    -t logic0verflow/multi-server:$SHA \
    -f ./server/Dockerfile \
    ./server
docker build \
    -t logic0verflow/multi-worker:latest \
    -t logic0verflow/multi-worker:$SHA \
    -f ./worker/Dockerfile \
    ./worker

docker push logic0verflow/multi-client:latest
docker push logic0verflow/multi-server:latest
docker push logic0verflow/multi-worker:latest

docker push logic0verflow/multi-client:$SHA
docker push logic0verflow/multi-server:$SHA
docker push logic0verflow/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=logic0verflow/multi-server:$SHA
kubectl set image deployments/client-deployment client=logic0verflow/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=logic0verflow/multi-worker:$SHA
