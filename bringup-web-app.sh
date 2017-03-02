# This will bring up a full web-app in a dev and test namespace
# 

if [ $1 = "" ]; then
  echo "Parameter for namespace must be used"
  exit
fi

SERVER=$2

echo Creating namespace
kubectl -s $SERVER create namespace $1

echo Creating ingress-controller
kubectl -s $SERVER apply -f deployment_config/nginx-ingress-controller/nginx-backend-service-rc-default.yaml,deployment_config/nginx-ingress-controller/nginx-controller-service-rc-default.yaml --namespace=$1

echo Creating web-app secret
kubectl -s $SERVER create secret generic nginx-secret --from-literal=secret=$1 --namespace=$1

echo Creating config map
kubectl -s $SERVER apply -f web_app/nginx-configmap.yaml --namespace=$1

echo Creating web_app
kubectl -s $SERVER apply -f web_app/web_app.yaml --namespace=$1

echo What ports can I access my service on? 
NODE_PORT=`kubectl -s $SERVER describe svc/nginx-ingress-controller --namespace=$1 | grep 'port-1' | awk '/3/ { print $3 }' | cut -d'/' -f1`
kubectl -s $SERVER describe svc/nginx-ingress-controller --namespace=$1 | grep ${NODE_PORT}


echo get ingress endpoint
NODE_IP=`kubectl -s $SERVER get ing --namespace=$1 -o json | awk '/ip/ { print $2 }' | tr -d '"'`

echo go to any node in the cluster or to this specific endpoint $NODE_IP
echo ""
echo curl dkubnod2u.example.com:$NODE_PORT/web-app
echo or
echo curl -k https://$NODE_IP/web-app
no_proxy=* curl -k https://$NODE_IP/web-app
