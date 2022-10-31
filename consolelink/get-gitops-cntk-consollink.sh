ARGOURL=$(oc get route -n openshift-gitops | grep openshift-gitops-cntk-server | awk '{print "https://"$2}')
ARGO_SECRET=$(oc get secret/openshift-gitops-cntk-cluster -n openshift-gitops -o json | jq -r '.data."admin.password"' | base64 -D)

( echo "cat <<EOF" ; cat argocd-consolelink.yaml_template;) | \
ARGOURL=${ARGOURL} \
sh > openshift-gitops-cntk.yaml
echo ${ARGOURL}
echo ${ARGO_SECRET}