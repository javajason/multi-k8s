# docker build -t travisimages/multi-client:latest -t travisimages/multi-client:$SHA -f ./client/Dockerfile ./client
# docker build -t travisimages/multi-worker:latest -t travisimages/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# docker build -t travisimages/multi-server:latest -t travisimages/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t travisimages/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t travisimages/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t travisimages/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t travisimages/multi-client:latest -f ./client/Dockerfile ./client
docker build -t travisimages/multi-worker:latest -f ./worker/Dockerfile ./worker
docker build -t travisimages/multi-server:latest -f ./server/Dockerfile ./server

docker push travisimages/multi-client:latest
docker push travisimages/multi-server:latest
docker push travisimages/multi-worker:latest

docker push travisimages/multi-worker:$SHA
docker push travisimages/multi-client:$SHA
docker push travisimages/multi-server:$SHA

kubectl apply -f k8s
# kubectl set image deployments/worker-deployment worker=travisimages/multi-worker:$SHA
kubectl set image deployments/client-deployment client=travisimages/multi-client:$SHA
# kubectl set image deployments/server-deployment server=travisimages/multi-server:$SHA

kubectl set image deployments/worker-deployment worker=travisimages/multi-worker:latest
# kubectl set image deployments/client-deployment client=travisimages/multi-client:latest
kubectl set image deployments/server-deployment server=travisimages/multi-server:latest