docker build -t bronxs/multi-client:latest -t bronxs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bronxs/multi-server:latest -t bronxs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bronxs/multi-worker:latest -t bronxs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bronxs/multi-client:latest
docker push bronxs/multi-server:latest
docker push bronxs/multi-worker:latest

docker push bronxs/multi-client:$SHA
docker push bronxs/multi-server:$SHA
docker push bronxs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=bronxs/multi-client:$SHA
kubectl set image deployments/server-deployment server=bronxs/multi-server:$SHA
kubectl set image deployments/worker-deployment server=bronxs/multi-worker:$SHA