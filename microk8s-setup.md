---

## MicroK8s Multi-node Cluster Setup

### Overview
MicroK8s provides a simple way to add and join nodes to form a cluster. This document guides you through the steps to set up a MicroK8s cluster consisting of two control plane nodes and two worker nodes.

### Prerequisites
- MicroK8s installed on all nodes.
- Network connectivity between all nodes.

### Setup Procedure

#### 1. Initialization
Begin on the first control plane node:

- Start MicroK8s:
   ```bash
   sudo microk8s start
   ```

- Enable the HA clustering:
   ```bash
   sudo microk8s enable ha-cluster
   ```

- For ease of use, create an alias for `microk8s.kubectl` to simply use `kubectl`:
   ```bash
   sudo snap alias microk8s.kubectl kubectl
   ```

- Add the user to the `microk8s` group to allow command execution without `sudo`:
   ```bash
   sudo usermod -a -G microk8s [username]
   ```

- Ensure the `~/.kube` directory ownership is set to the user:
   ```bash
   sudo chown -f -R [username] ~/.kube
   ```

#### 2. Adding Nodes
On the first control plane node:

- Generate a join command:
   ```bash
   sudo microk8s add-node
   ```

   This will produce an output with a `microk8s join` command, which includes a token and the IP of the control plane node.

#### 3. Joining Nodes
On each of the other nodes (second control plane and both worker nodes):

- Use the `microk8s join` command generated in the previous step:
   ```bash
   sudo microk8s join <control-plane-ip>:<port>/<token>
   ```

   Replace `<control-plane-ip>`, `<port>`, and `<token>` with the appropriate values from the `add-node` output.

#### 4. Setting Roles
Once all nodes have joined the cluster, label them according to their roles:

- Label the control plane nodes:
   ```bash
   sudo kubectl label nodes <controlplane-node-name> node-role.kubernetes.io/control-plane=""
   ```

- Label the worker nodes:
   ```bash
   sudo kubectl label nodes <worker-node-name> node-role.kubernetes.io/worker=""
   ```

   Replace `<controlplane-node-name>` and `<worker-node-name>` with the names of your nodes.

#### 5. Verify the Cluster
On any node, check the status of all nodes and their roles:
   ```bash
   sudo kubectl get nodes
   ```

### Conclusion
You now have a multi-node MicroK8s cluster with two control plane nodes and two worker nodes. You can begin deploying workloads and managing the cluster as needed.

---

