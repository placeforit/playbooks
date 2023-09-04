## Deploying Jenkins on MicroK8s using Helm

### **Preparation**

#### 1. **Enable MicroK8s Addons**:
MicroK8s provides a set of default addons to enhance the capability of your Kubernetes cluster. We'll start by enabling the required ones.

```bash
microk8s enable dns
microk8s enable hostpath-storage
```

#### 2. **Install Helm**:
Ensure you have Helm 3 installed.

```bash
sudo snap install helm --classic
```

### **Deploying Jenkins**

#### 3. **Add the Jenkins Helm Repository**:
This step ensures you have access to the Jenkins Helm charts.

```bash
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```

#### 4. **Prepare the `values.yaml` File for Jenkins**:
Get the default configuration for Jenkins and make necessary changes for your setup.

```bash
helm show values jenkinsci/jenkins > values.yaml
```

*Note:* Ensure any top-level reference of `master` is changed to `controller` in the `values.yaml` due to Jenkins community renaming the term for inclusivity.

#### 5. **Install Jenkins**:

Deploy Jenkins using the following:

```bash
helm install jenkins jenkinsci/jenkins -f values.yaml --namespace jenkins --create-namespace
```

### **Accessing Jenkins**

#### 6. **Determine the Access Port**:

Find out the port Jenkins is using.

```bash
kubectl get svc --namespace jenkins
```

Note the port mapping for the Jenkins service, especially the port mapped to `8080`. This is the external port you'd use.

For example, if the output looks like:
```
jenkins         LoadBalancer   10.152.183.35    <pending>     8080:31941/TCP   10m
```

You would access Jenkins via the port `31941`.

#### 7. **Access Jenkins on Web Browser**:

On the machine's IP address, use the previously determined port. 

Example:
```
http://[YOUR_MACHINE_IP]:[YOUR_PORT]/
```

#### 8. **Retrieve the Initial Admin Password**:

Get the name of the Jenkins pod:

```bash
kubectl get pods --namespace jenkins
```

Using the pod's name, retrieve the initial admin password:

```bash
kubectl exec --namespace jenkins [YOUR_JENKINS_POD_NAME] -- cat /var/jenkins_home/secrets/initialAdminPassword
```

Use `admin` as the username and the retrieved alphanumeric string as the password to log in to Jenkins.