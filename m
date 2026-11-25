Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.46.229.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629593;
	b=JCoaPfHzQzF/+NSY2ZPSGDFtfMIR8Tt4N3fwkXSFXPtW+9jcMYxI8d/qZFki2SjXs0a5
	 q99LDkLJIWbU/PlHREPQ/gsV5VINiJ06THmzUPGor94H+cvH+E1B5+doFkh7mCo26+ZOv
	 ZbjZEsOW0Ci5XKHRsYBTjZSKhaKfYLYio/MkoRJGPzivrgXv0Z9M1RqmaABFgH6GMdmeY
	 UAfhA0tVZtKtcys2uacZZhpWgBHDl18l/nhY6FNT0Qxu58VHfgJHO564oIhSrRnrWCQCm
	 qTie0IgEzfktDySSbPkS2ppQMWg//BtsOL6tZtSkPzLvogEO4seAmrrhSN3sSu1IXnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629593;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=j+S7/7WtpcADXEwVRba68L4BGjIYUbo5L1pEZB4YTDE=;
	b=Soz/91XnGmUT7Y11wNRQZacVHX1biDxI1IDBMLY0nHwaJ9hx+t/ifU9dHwOwaLlqilOR
	 wUxVZyLA2fG+T+YXVM3dN8qKeimQDz1EI6qbdVV5noetQEdC0gBt/CY4qtW7LkLpNCLXe
	 fDzjRRXdyf3HIOHHOQO1tUgj7pqIdPIU6UeHRd3xDraRjkoOw4JHZySpyQxCj4z83CVYJ
	 jJUt2fZmMqyCHjoF7O5a1GJk7jvV4gX3Z49KHzHL3jEu3vSZ/3G+azLfSYBaw8IZLAIB1
	 IWDgdq1ymwSrHrzCUjXN9AdrbRj29YXks5sbpzQeQXl5L0Oep+Bai/D3Z8enJg1X8QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=207.46.229.174
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DB606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with UTF8SMTP id IAEQrMBmrs8TIgdrPz0LAA--.49154S2;
	Thu, 26 Nov 2026 01:59:47 +0800 (CST)
Received: from pride-PowerEdge-R740.tailb307d0.ts.net (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wA3wjwQIgdrFXB0AA--.6775S2;
	Thu, 26 Nov 2026 01:59:44 +0800 (CST)
From: Quan Sun <m202672221@hust.edu.cn>
To: bpf@vger.kernel.org,
	kpsingh@kernel.org
Cc: matt@bobrowski.net,
	paul@paul-moore.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	emil@etsalapatis.com,
	Quan Sun <m202672221@hust.edu.cn>
Subject: [PATCH] bpf, lsm: Mark IPC control hook perm parameters nullable
Date: Thu, 26 Nov 2026 01:59:41 +0800
Message-ID: <51ae120f0b3cd8c20dbaaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IAEQrMBmrs8TIgdrPz0LAA--.49154S2
Authentication-Results: app1; spf=neutral smtp.mail=m202672221@hust.ed
	u.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyUAF45WF15Gr1kWw18Grg_yoW7tryfpa
	yUGw1UCr4kJr4IgFWfJFW8ua4ayrsY9ayUGFZFyry0yanxZw1Fqryjvr13CFWrCrs8G3y0
	qrs0g34aga4UAaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI
	0_JF0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCE
	c2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14
	v26r4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWx
	Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r
	43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b4xhJUUUUU=
X-CM-SenderInfo: bpsqjlqxssjio6kx23oohg3hdfq/

The shm_shmctl(), sem_semctl() and msg_queue_msgctl() BPF LSM hooks are
reached with a NULL struct kern_ipc_perm by the informational IPC
commands:

  ipc/shm.c  shmctl_ipc_info()  security_shm_shmctl(NULL, IPC_INFO)
  ipc/shm.c  shmctl_shm_info()  security_shm_shmctl(NULL, SHM_INFO)
  ipc/sem.c  semctl_info()      security_sem_semctl(NULL, cmd)
  ipc/msg.c  msgctl_info()      security_msg_queue_msgctl(NULL, cmd)

None of these three hooks has a strong prototype in
kernel/bpf/bpf_lsm_proto.c, so their BTF comes from the __weak
prototypes generated from include/linux/lsm_hook_defs.h in
kernel/bpf/bpf_lsm.c.  Those carry no __nullable suffix, so
btf_ctx_access() types perm as a plain PTR_TO_BTF_ID and the verifier
accepts a program that dereferences it unconditionally:

  r6 = *(u64 *)(r1 + 0)     /* struct kern_ipc_perm *perm */
  r7 = *(u32 *)(r6 + 96)    /* perm->seq */

The trampoline passes the raw NULL through and the program faults:

  BUG: KASAN: null-ptr-deref in bpf_prog_4c1689a6d8af2199+0x52/0x6e
  Read of size 4 at addr 0000000000000060 by task 03_lsm_raw/89
  Call stack:
   bpf_prog_4c1689a6d8af2199+0x52/0x6e
   bpf_trampoline_6442537938+0x61/0xfd
   security_shm_shmctl+0x29/0x50
   shmctl_ipc_info+0x1b/0x140
   ksys_shmctl.constprop.0+0x22b/0x290
   do_syscall_64+0x10b/0x5f0
  BUG: kernel NULL pointer dereference, address: 0000000000000060
  Oops: 0000 [#1] SMP KASAN PTI

Loading the program requires CAP_BPF, but triggering it requires
nothing: ksys_shmctl() has no capability check ahead of IPC_INFO and
SHM_INFO, and the hook is the first statement of shmctl_ipc_info(), so
an unprivileged shmctl(0, IPC_INFO, buf) kills its own process while the
attachment stays in place for every later caller.  With
panic_on_oops=1 a single CAP_BPF principal takes down the host.

kernel/bpf/bpf_lsm.c defines every attachable hook as

	__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)
	{
		return DEFAULT;
	}

and notes that the linkage is weak "such that strong overrides can be
implemented if need be", so an override has to be a definition rather
than a declaration.  The bodies below return the defaults that
include/linux/lsm_hook_defs.h declares for these three hooks (all 0), so
the generated stubs keep behaving identically; only the parameter name
recorded in BTF changes.

Add strong prototypes for the three hooks so that perm is typed
PTR_MAYBE_NULL, the way mmap_file() and inode_init_security() are
already handled.  With the annotations in place the identical program
is rejected at load time:

  1: R1=ctx() R6=trusted_ptr_or_null_kern_ipc_perm(id=1)
  1: (61) r7 = *(u32 *)(r6 +96)
  R6 invalid mem access 'trusted_ptr_or_null_'

  Reason:
    R6 may be NULL here (a nullable kernel object pointer). The program
    could dereference NULL on this path, so the verifier cannot prove
    this access is safe.

and BPF_PROG_LOAD fails with EPERM.

socket_getpeersec_dgram() passes a NULL struct sock on one path too,
but its reachability from a BPF LSM program has not been confirmed, so
it is left out here and can be handled separately.

This is not a regression: the parameters were never annotated, and the
NULL argument is part of the hook contract -- selinux_shm_shmctl() has
carried the comment "No specific object, just general system-wide
information" for IPC_INFO and SHM_INFO since the hook was added, so the
callers are right and only the BPF side lacks the information.

This change was drafted with an AI coding assistant during a BPF
subsystem audit. I reviewed the code, built the kernel and ran the
reproducer before and after, and take responsibility for it.

Signed-off-by: Quan Sun <m202672221@hust.edu.cn>
---

Reproduce: boot bpf-next master (8dfce13340ae, 7.4.0-rc3-g8dfce13340ae,
CONFIG_KASAN=y) in qemu, load a 4-instruction BPF_PROG_TYPE_LSM program
attached to bpf_lsm_shm_shmctl that dereferences ctx offset 0 without a
NULL check, then call shmctl(0, IPC_INFO, buf) from an unprivileged
process.  The PoC is raw bpf(2) only, no libbpf and no skeleton.
sem_semctl() and msg_queue_msgctl() are annotated for symmetry with the
shm case; I did not run separate reproducers for those two paths.

 kernel/bpf/bpf_lsm_proto.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
index b81179ae2e0..7c48af32c2d 100644
--- a/kernel/bpf/bpf_lsm_proto.c
+++ b/kernel/bpf/bpf_lsm_proto.c
@@ -5,6 +5,7 @@
 
 #include <linux/fs.h>
 #include <linux/xattr.h>
+#include <linux/ipc.h>
 #include <linux/bpf_lsm.h>
 
 /*
@@ -32,3 +33,31 @@ noinline int bpf_lsm_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	return -EOPNOTSUPP;
 }
+
+/*
+ * Strong definitions of the IPC control BPF LSM hooks. The informational
+ * commands have no object to authorize, so they pass a NULL struct
+ * kern_ipc_perm: shmctl_ipc_info() and shmctl_shm_info() call
+ * security_shm_shmctl(NULL, IPC_INFO | SHM_INFO), semctl_info() calls
+ * security_sem_semctl(NULL, cmd) and msgctl_info() calls
+ * security_msg_queue_msgctl(NULL, cmd). The __nullable suffix marks perm as
+ * PTR_MAYBE_NULL so that BPF LSM programs have to check it before
+ * dereferencing it. Without these overrides the hooks fall back to the
+ * __weak prototypes generated from lsm_hook_defs.h in bpf_lsm.c, which carry
+ * no annotation and let the verifier type perm as non-nullable.
+ */
+noinline int bpf_lsm_shm_shmctl(struct kern_ipc_perm *perm__nullable, int cmd)
+{
+	return 0;
+}
+
+noinline int bpf_lsm_sem_semctl(struct kern_ipc_perm *perm__nullable, int cmd)
+{
+	return 0;
+}
+
+noinline int bpf_lsm_msg_queue_msgctl(struct kern_ipc_perm *perm__nullable,
+				      int cmd)
+{
+	return 0;
+}
-- 
2.43.0

