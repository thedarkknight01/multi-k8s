docker build -t amsanjeevkumar/multi-client:latest -t amsanjeevkumar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amsanjeevkumar/multi-server:latest -t amsanjeevkumar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amsanjeevkumar/multi-worker:latest -t amsanjeevkumar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amsanjeevkumar/multi-client:latest
docker push amsanjeevkumar/multi-server:latest
docker push amsanjeevkumar/multi-worker:latest

docker push amsanjeevkumar/multi-client:$SHA
docker push amsanjeevkumar/multi-server:$SHA
docker push amsanjeevkumar/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=amsanjeevkumar/multi-server:$SHA
kubectl set image deployments/client-deployment client=amsanjeevkumar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amsanjeevkumar/multi-worker:$SHA
