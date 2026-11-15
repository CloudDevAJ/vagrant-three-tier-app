
# Deployment Testing — Vagrant Three-Tier Application

## Purpose

This document outlines the testing process for the Vagrant three-tier application. The goal is to verify that all three virtual machines start successfully, communicate over the private network, and support the web, application, and database tiers.

## Environment Configuration

| VM | Hostname | Private IP | Provisioning Script |
|---|---|---|---|
| Web | web-server | 192.168.56.10 | scripts/web.sh |
| App | app-server | 192.168.56.11 | scripts/app.sh |
| DB | db-server | 192.168.56.12 | scripts/db.sh |

**Configuration:**
- Base box: `hashicorp/bionic64` (Ubuntu 18.04)
- Virtualization: VirtualBox
- Memory: 2048 MB per VM
- CPUs: 2 per VM
- Web port forwarding: Host 8080 → Guest 80
- Private networking: 192.168.56.x

Note: The web host port may change automatically if 8080 is unavailable.

## 1. VM Startup and Configuration

Run the following commands from the project directory:

```powershell
vagrant validate
vagrant up
vagrant status
vagrant port web
```

### Verification Checklist

- [ ] Vagrantfile validation completes successfully.
- [ ] Web VM starts successfully.
- [ ] App VM starts successfully.
- [ ] DB VM starts successfully.
- [ ] All provisioning scripts complete without errors.
- [ ] All three VMs show `running` in Vagrant status.
- [ ] Web port forwarding is configured correctly.

## 2. SSH Connectivity

Test SSH access to each VM.

```powershell
vagrant ssh web
vagrant ssh app
vagrant ssh db
```

Run each command separately. Type `exit` before connecting to the next VM.

### Verification Checklist

- [ ] SSH access to Web VM successful.
- [ ] SSH access to App VM successful.
- [ ] SSH access to DB VM successful.

## 3. Private Network Connectivity

All three VMs communicate through the configured private network.

### From Web VM

```powershell
vagrant ssh web
```

Inside the VM:

```bash
ping -c 3 192.168.56.11
ping -c 3 192.168.56.12
```

### From App VM

```powershell
vagrant ssh app
```

Inside the VM:

```bash
ping -c 3 192.168.56.12
```

### Verification Checklist

- [ ] Web VM can reach App VM.
- [ ] Web VM can reach DB VM.
- [ ] App VM can reach DB VM.
- [ ] No unexpected network connectivity issues.

Note: Successful ping confirms basic network connectivity, not that application services are functioning.

## 4. Provisioning Verification

Each virtual machine uses a shell provisioning script defined in the Vagrantfile.

| VM | Script |
|---|---|
| Web | scripts/web.sh |
| App | scripts/app.sh |
| DB | scripts/db.sh |

To rerun provisioning:

```powershell
vagrant provision web
vagrant provision app
vagrant provision db
```

### Verification Checklist

- [ ] Web provisioning completes successfully.
- [ ] Application provisioning completes successfully.
- [ ] Database provisioning completes successfully.
- [ ] Required web service is running.
- [ ] Required application service is running.
- [ ] Required database service is running.

The installed services and their exact ports will be verified against the provisioning scripts.

## 5. Application Testing

### Test 1 — Browser Access

First, identify the forwarded host port:

```powershell
vagrant port web
```

If host port 8080 is being used, open:

http://localhost:8080

### Test 2 — Web to Application Communication

Verify that the web server can communicate with the application server through its private IP address.

Application server IP: `192.168.56.11`

### Test 3 — Application to Database Communication

Verify that the application server can communicate with the database server.

Database server IP: `192.168.56.12`

### Test 4 — Database Operations

Use an application feature that reads or writes database data, if supported by the application.

### Verification Checklist

- [ ] Application opens successfully in the browser.
- [ ] Web server communicates with application server.
- [ ] Application server connects to database server.
- [ ] Application successfully performs a database operation.
- [ ] No unexpected application errors occur.

## 6. Shutdown Testing

Stop all virtual machines:

```powershell
vagrant halt
```

Check their status:

```powershell
vagrant status
```

### Verification Checklist

- [ ] Web VM shuts down successfully.
- [ ] App VM shuts down successfully.
- [ ] DB VM shuts down successfully.
- [ ] All three VMs show a powered-off state.

Restarting the existing environment can be tested using:

```powershell
vagrant up
```

## 7. Testing Results

| Test | Expected Result | Status |
|---|---|---|
| Vagrant validation | Configuration is valid | Not Tested |
| VM startup | All 3 VMs running | Not Tested |
| SSH access | All 3 VMs accessible | Not Tested |
| Private networking | VMs communicate | Not Tested |
| Web provisioning | Web tier configured | Not Tested |
| App provisioning | App tier configured | Not Tested |
| DB provisioning | Database tier configured | Not Tested |
| Browser access | Web application loads | Not Tested |
| Web-to-App connection | Application tier reachable | Not Tested |
| App-to-DB connection | Database reachable | Not Tested |
| VM shutdown | All VMs stopped | Not Tested |

## 8. Screenshots and Evidence

Screenshots will be added after successful testing.

Planned screenshots:

- `screenshots/vagrant-status.png`
- `screenshots/ssh-connectivity.png`
- `screenshots/network-connectivity.png`
- `screenshots/web-application.png`
- `screenshots/database-test.png`

## Current Testing Status

Testing has not yet been completed on the current computer.

The VM configuration is based on the project's Vagrantfile. Application-specific checks will be finalized after reviewing the provisioning scripts and application code.
