docker build -t travisimages/multi-client:latest -t travisimages/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t travisimages/multi-server:latest -f travisimages/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t travisimages/multi-worker:latest -t travisimages/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push travisimages/multi-client:latest
docker push travisimages/multi-server:latest
docker push travisimages/multi-worker:latest

docker push travisimages/multi-client:$SHA
docker push travisimages/multi-server:$SHA
docker push travisimages/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=travisimages/multi-client:$SHA
kubectl set image deployments/server-deployment server=travisimages/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=travisimages/multi-worker:$SHA