Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06F3ABD82
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152449; cv=none; b=Kf95uS+xsUv0r8/wXaq263/QYqrK+E+7HZHBKrSiWPKrUaXcrduILDJSap1hF/OgjpU9SO81OPjkcn8+H1Me60tjgvKVq9vrvTHGkPEH9oVbVMQfJBXXOUfsno1sqGwRQffSHxfAyTub/8Cx/vXcS1TRLqU7PTPys+fnuKvLMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152449; c=relaxed/simple;
	bh=+Edu1tO/xoBP0l0EaaAC2ie8r4n3yRjDrWtIaAOYFA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOfpIWKplMVeE4jVJVOGMaBL3MZUgxBQF5jwF/cgGC5sbC4vXrN9F51Uj0uT0ZpIbAsvjmVEtmJzbP1R0qnrI269WxRuZulljJ8m94VA2LFI2qcL4wYvIPfrmz8/moaGbPCD5JCsrSUxYp/f2Rh4BAXlsNrZwW+omCvKIZWmIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns/IGvI0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns/IGvI0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso22999915ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785152447; x=1785757247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJ6MK0mOJGey5f1xMkBaJ3vKBwMFgEHV/k5fF9Nzb/4=;
        b=ns/IGvI0lpk6qcRIoSh6elQnKSLZIH1+IWSuFhIBeiz+fqdvkyK45eW0tyJ4iNCNVI
         23CGIJ/r8QXX6ihnw1CM72FDT9TAYkLd3vs0deiZOsiHyFsMrqGdY2aK4kOjbIejIBCQ
         dvkOmQjQAH1YiuKj/32+tcocAgzaBHzNSK5Ljw9Diu/SdYL/OD7EDsQuOfybiD559gN/
         FwH/Hw/PsneVd3NxpUaUcvoFPxx4TeFE26vS13oT52vO96jDMaMWkYDAPOCXKdJ68o/k
         q7zVVBnkjDD3g6qermagznse4Hgc7qODiY2k2hh6EWIO3Knnlvf18djPSBuooDBBLbHc
         HppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785152447; x=1785757247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJ6MK0mOJGey5f1xMkBaJ3vKBwMFgEHV/k5fF9Nzb/4=;
        b=o5Pk3d0Q5kaZHbOBQQrhZMpwnsPHK5s2/Mv3AWlH9ZOMu2mOBRe9qrae3QD2/UrXXB
         cSgT5R6RGsZOlvMts2JsLHeh5fUYg1Kf+5RUBGpcmSM1hGgrhbNLaEv+VWizo7hhTNqH
         T3lE/WhxSIeJmgLflvZK3mXkgcfFzaCgEHOmkTAUPajUrqRqmjELoFrAolhk9gfqgmrf
         pNm1uL9D9RvQxEtYT6F2I7FkjVwn0sIy5VwAkVviCID6yKDgk2PKoFjCsRUmZpTiWqi+
         VbeHrCQXWh0FQzthbEp9J+4Hy1OVNo1C9L9Yjk5awMaMLNuIWm/CyIGtqDbcpMBxE2zw
         w0Fg==
X-Forwarded-Encrypted: i=1; AHgh+RokjjWPc1rnSi6iOGiUUFNOY2WrMiO6IEU88qAmsngZ0dJjp1uVI66fi5nn8HZAji7stJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNEJl8W1j5v3hVpaC/cMoy3anabUhUHCq39hNpe2BeBRR0zlj
	irL41wuchwySLzhuaJlTn6Aq3Eh+F2SvfRDWachBfCG+Wahg2q/val/3
X-Gm-Gg: AR+sD12pjxGC+eMrq3WmKE6tlUY5vQLE75CcRFwGscY8sge1cP5Zwk85BkKT6mWffCF
	fa7gK00QXobZyMwx/SufuNw+GPYyMlBmLCz+0w4C1HVgRxCDAM7nMw8tkuUZwlS/nOGNdErJzJ0
	J80Ny+kfNfwpDsCp+ap5p492c3LILZUvA6BXtgdo8QXoXnapKAS2Ku+kRwevPWvdaXUcOGieGea
	TsTOaiN5BGkI7dzHh+BF8jwz4RfKG9yibqmFJUztUJu1IAGT3sGrdEDM8yyoKFfOHyqFoSvo65q
	s2MmJayKSU9pbzgQ8lL4Iaq0++S0M5xcoF12PWO469PlM/Kr4y9IyRcWi1zheuoMmgaYlJH9sfC
	cx4fXvRaHC71da6XeXCN/QOKVEQTofsRgG6sD3oOpfJCw9D8gZIu7TgMynQ/b2Mx3AfogvJRx
X-Received: by 2002:a17:90b:2e0c:b0:38f:1a80:d1e7 with SMTP id 98e67ed59e1d1-38f294ea112mr7466680a91.13.1785152446686;
        Mon, 27 Jul 2026 04:40:46 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292ae889sm2995168a91.1.2026.07.27.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:40:45 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: BUG: possible recursive locking detected in sleepable task_vma iterator
Date: Mon, 27 Jul 2026 20:40:23 +0900
Message-ID: <20260727114023.947601-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We found a lockdep warning in the BPF task_vma iterator using our
customized fuzzer. We believe this indicates a potential deadlock.

A program that can cause this issue looks like this:

```
prog_fd = bpf(BPF_PROG_LOAD, {
        .prog_type = BPF_PROG_TYPE_TRACING,
        .expected_attach_type = BPF_TRACE_ITER,
        .attach_btf_id = /* task_vma iterator */,
        .prog_flags = BPF_F_SLEEPABLE,
        .insns = {
                /* even a no-op sleepable program is enough */
        },
});

link_fd = bpf(BPF_LINK_CREATE, {
        .prog_fd = prog_fd,
        .target_fd = 0,
        .attach_type = BPF_TRACE_ITER,
});

iter_fd = bpf(BPF_ITER_CREATE, {
        .link_fd = link_fd,
});

/* Running the task_vma iterator executes the BPF program. */
read(iter_fd, buf, sizeof(buf));
```

The bpf_seq_read() uses the vma iterator task_vma_seq_get_next() which
grabs the mmap_lock of the process. It documents that when it returns
a non-NULL VMA, it holds a task reference, an mm_users reference,
and the read side of vma->mm->mmap_lock. That lock is kept across
task_vma_seq_show() so that the VMA pointer passed to the BPF iterator
program remains valid. It is released later from task_vma_seq_stop().

After task_vma_seq_get_next() returns a VMA with mmap_lock still held for
read, task_vma_seq_show() invokes bpf_iter_run_prog() before the lock is
released by task_vma_seq_stop(). The problematic part is that task_vma
advertises BPF_ITER_RESCHED, and bpf_iter_link_attach() uses that bit to
allow a sleepable iterator program to attach to task_vma. This makes it
possible to run the sleepable bpf_iter_run_prog() path while task_vma still
holds mmap_lock. Since the mmap_lock is being held by task_vma_seq_get_next(),
it can possibly deadlock if the program triggers a page fault.

Our current understanding of the sequence is:

---
bpf_seq_read()
  task_vma_seq_start()
    task_vma_seq_get_next()
      mmap_read_lock_killable(curr_mm)

  task_vma_seq_show()
    __task_vma_seq_show()
      bpf_iter_run_prog()
        if (prog->sleepable)
          might_fault()
            might_lock_read(&current->mm->mmap_lock)
---

Below is the excerpt from the kernel log that shows the lockdep warning:

 ============================================
 WARNING: possible recursive locking detected
 7.2.0-rc4-00471-g0ce37745d4bf #10 Not tainted
 --------------------------------------------
 task_vma_sleepa/55 is trying to acquire lock:
 ffff8881046450b0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xc4/0x170
 
 but task is already holding lock:
 ffff88810007d0b0 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5be/0x9a0
 
 other info that might help us debug this:
  Possible unsafe locking scenario:
 
        CPU0
        ----
   lock(&mm->mmap_lock);
   lock(&mm->mmap_lock);
 
  *** DEADLOCK ***
 
  May be due to missing lock nesting notation
 
 3 locks held by task_vma_sleepa/55:
  #0: ffff888104629c98 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x64/0x12c0
  #1: ffff88810007d0b0 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5be/0x9a0
  #2: ffffffff841b60f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_iter_run_prog+0x467/0x10d0

In the observed trace, the two concrete locks have different addresses
with the same class. So this trace itself demonstrates the unsafe lockdep
chain rather than an already-hung task. However, the same allowed execution
model can become a real rwsem deadlock if the second acquisition targets
the same mm and a writer is pending between the first read lock and the
second read lock:

---
T0: holds mm->mmap_lock for read from task_vma_seq_get_next()
T1: waits for mm->mmap_lock for write
T0: sleepable BPF program faults or uses a user-copy helper
T0: tries to acquire mm->mmap_lock for read again
T0: blocks behind the pending writer
T1: waits for T0's first read lock
---

Thanks,
Junseo Lim

Found-by: Sechang Lim <rhkrqnwk98@gmail.com>
Analyzed-by: Junseo Lim <zirajs7@gmail.com>

Below is the log and reproducer for the issue.
====
Kernel tested:
  Tree: bpf/master
  Commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
  Version: 7.2.0-rc4-00471-g0ce37745d4bf
  Environment: QEMU x86_64
  Command line: console=ttyS0 net.ifnames=0 biosdevname=0 selinux=0 rdinit=/init nokaslr panic=0 printk.time=1

Relevant config options:
  CONFIG_BPF=y
  CONFIG_BPF_SYSCALL=y
  CONFIG_PREEMPT=y
  CONFIG_PREEMPT_DYNAMIC=y
  CONFIG_KASAN=y
  CONFIG_PROVE_LOCKING=y
  CONFIG_LOCKDEP=y
---
[    3.704087] ============================================
[    3.704417] WARNING: possible recursive locking detected
[    3.704792] 7.2.0-rc4-00471-g0ce37745d4bf #10 Not tainted
[    3.705128] --------------------------------------------
[    3.705470] task_vma_sleepa/55 is trying to acquire lock:
[    3.705805] ffff8881046450b0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xc4/0x170
[    3.706328] 
[    3.706328] but task is already holding lock:
[    3.706947] ffff88810007d0b0 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5be/0x9a0
[    3.709536] 
[    3.709536] other info that might help us debug this:
[    3.709920]  Possible unsafe locking scenario:
[    3.709920] 
[    3.710284]        CPU0
[    3.710445]        ----
[    3.710596]   lock(&mm->mmap_lock);
[    3.710810]   lock(&mm->mmap_lock);
[    3.711026] 
[    3.711026]  *** DEADLOCK ***
[    3.711026] 
[    3.712842]  May be due to missing lock nesting notation
[    3.712842] 
[    3.713254] 3 locks held by task_vma_sleepa/55:
[    3.713540]  #0: ffff888104629c98 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x64/0x12c0
[    3.714047]  #1: ffff88810007d0b0 (&mm->mmap_lock){++++}-{4:4}, at: task_vma_seq_get_next+0x5be/0x9a0
[    3.714634]  #2: ffffffff841b60f8 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_iter_run_prog+0x467/0x10d0
[    3.715274] 
[    3.715274] stack backtrace:
[    3.715547] CPU: 0 UID: 0 PID: 55 Comm: task_vma_sleepa Not tainted 7.2.0-rc4-00471-g0ce37745d4bf #10 PREEMPT(full) 
[    3.716179] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    3.716774] Call Trace:
[    3.716934]  <TASK>
[    3.717076]  dump_stack_lvl+0x55/0xb0
[    3.717322]  print_deadlock_bug.cold+0xc0/0xcd
[    3.717610]  __lock_acquire+0x12c7/0x1d70
[    3.717880]  lock_acquire+0x118/0x320
[    3.718123]  ? __might_fault+0xc4/0x170
[    3.718374]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.718678]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.718980]  __might_fault+0xe4/0x170
[    3.719218]  ? __might_fault+0xc4/0x170
[    3.719467]  ? __might_fault+0xc4/0x170
[    3.719719]  bpf_iter_run_prog+0x5ce/0x10d0
[    3.719992]  ? __pfx_bpf_iter_run_prog+0x10/0x10
[    3.720293]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.720600]  task_vma_seq_show+0x15b/0x1e0
[    3.720871]  ? __pfx_task_vma_seq_show+0x10/0x10
[    3.721171]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.721483]  ? __pfx_bpf_seq_read+0x10/0x10
[    3.721753]  ? __pfx_bpf_seq_read+0x10/0x10
[    3.722021]  bpf_seq_read+0x1df/0x12c0
[    3.722267]  ? security_file_permission+0x34/0x70
[    3.722566]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.722867]  ? __pfx_bpf_seq_read+0x10/0x10
[    3.723138]  vfs_read+0x19a/0x9b0
[    3.723371]  ? __pfx_vfs_read+0x10/0x10
[    3.723629]  ksys_read+0x129/0x250
[    3.723857]  ? __pfx_ksys_read+0x10/0x10
[    3.724114]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.724424]  ? __x64_sys_bpf+0xc9/0x1a0
[    3.724755]  do_syscall_64+0xad/0x5c0
[    3.725005]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.725323]  ? exc_page_fault+0x85/0xa0
[    3.725594]  entry_SYSCALL_64_after_hwframe+0x74/0x7c
[    3.725920] RIP: 0033:0x42846d
[    3.726129] Code: d5 48 8d 3c 0a eb 91 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 f0 ff ff ff f7 d8 64 89 01 48
[    3.727351] RSP: 002b:00007fffc51eb9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[    3.727868] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000042846d
[    3.728594] RDX: 0000000000000100 RSI: 00007fffc51ebb00 RDI: 0000000000000005
[    3.729067] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[    3.729551] R10: 00007fffc51eb890 R11: 0000000000000246 R12: 000000000048ac28
[    3.730612] R13: 00007f3cc2795078 R14: 000000000000c3da R15: 0000000000000000
[    3.731029]  </TASK>
---
#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

#define BPF_PROG_LOAD 5
#define BPF_LINK_CREATE 28
#define BPF_ITER_CREATE 33

#define BPF_PROG_TYPE_TRACING 26
#define BPF_TRACE_ITER 28
#define BPF_F_SLEEPABLE (1U << 4)

#define BPF_OBJ_NAME_LEN 16

#define BTF_MAGIC 0xeb9f
#define BTF_KIND_INT 1
#define BTF_KIND_PTR 2
#define BTF_KIND_ARRAY 3
#define BTF_KIND_STRUCT 4
#define BTF_KIND_UNION 5
#define BTF_KIND_ENUM 6
#define BTF_KIND_FWD 7
#define BTF_KIND_TYPEDEF 8
#define BTF_KIND_VOLATILE 9
#define BTF_KIND_CONST 10
#define BTF_KIND_RESTRICT 11
#define BTF_KIND_FUNC 12
#define BTF_KIND_FUNC_PROTO 13
#define BTF_KIND_VAR 14
#define BTF_KIND_DATASEC 15
#define BTF_KIND_FLOAT 16
#define BTF_KIND_DECL_TAG 17
#define BTF_KIND_TYPE_TAG 18
#define BTF_KIND_ENUM64 19

struct bpf_insn {
	uint8_t code;
	uint8_t dst_reg:4;
	uint8_t src_reg:4;
	int16_t off;
	int32_t imm;
};

union bpf_attr_local {
	struct {
		uint32_t prog_type;
		uint32_t insn_cnt;
		uint64_t insns;
		uint64_t license;
		uint32_t log_level;
		uint32_t log_size;
		uint64_t log_buf;
		uint32_t kern_version;
		uint32_t prog_flags;
		char prog_name[BPF_OBJ_NAME_LEN];
		uint32_t prog_ifindex;
		uint32_t expected_attach_type;
		uint32_t prog_btf_fd;
		uint32_t func_info_rec_size;
		uint64_t func_info;
		uint32_t func_info_cnt;
		uint32_t line_info_rec_size;
		uint64_t line_info;
		uint32_t line_info_cnt;
		uint32_t attach_btf_id;
	} prog_load;
	struct {
		uint32_t prog_fd;
		uint32_t target_fd;
		uint32_t attach_type;
		uint32_t flags;
		uint64_t iter_info;
		uint32_t iter_info_len;
	} link_create;
	struct {
		uint32_t link_fd;
		uint32_t flags;
	} iter_create;
	uint8_t pad[256];
};

struct bpf_iter_link_info_task {
	uint32_t tid;
	uint32_t pid;
	uint32_t pid_fd;
};

struct btf_header {
	uint16_t magic;
	uint8_t version;
	uint8_t flags;
	uint32_t hdr_len;
	uint32_t type_off;
	uint32_t type_len;
	uint32_t str_off;
	uint32_t str_len;
};

struct btf_type {
	uint32_t name_off;
	uint32_t info;
	union {
		uint32_t size;
		uint32_t type;
	};
};

static uint64_t ptr_to_u64(const void *ptr)
{
	return (uint64_t)(uintptr_t)ptr;
}

static long sys_bpf(int cmd, union bpf_attr_local *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static void bump_memlock_rlimit(void)
{
	struct rlimit rlim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};

	syscall(SYS_setrlimit, RLIMIT_MEMLOCK, &rlim);
}

static void *read_file(const char *path, size_t *size_out)
{
	ssize_t n;
	size_t done = 0;
	off_t size;
	char *buf;
	int fd;

	fd = syscall(SYS_openat, AT_FDCWD, path, O_RDONLY);
	if (fd < 0) {
		perror("openat(/sys/kernel/btf/vmlinux)");
		return NULL;
	}

	size = syscall(SYS_lseek, fd, 0, SEEK_END);
	if (size <= 0) {
		perror("lseek(SEEK_END)");
		syscall(SYS_close, fd);
		return NULL;
	}
	if (syscall(SYS_lseek, fd, 0, SEEK_SET) < 0) {
		perror("lseek(SEEK_SET)");
		syscall(SYS_close, fd);
		return NULL;
	}

	buf = malloc(size);
	if (!buf) {
		perror("malloc");
		syscall(SYS_close, fd);
		return NULL;
	}

	while (done < (size_t)size) {
		n = syscall(SYS_read, fd, buf + done, (size_t)size - done);
		if (n < 0) {
			if (errno == EINTR)
				continue;
			perror("read(/sys/kernel/btf/vmlinux)");
			free(buf);
			syscall(SYS_close, fd);
			return NULL;
		}
		if (n == 0)
			break;
		done += (size_t)n;
	}

	syscall(SYS_close, fd);
	*size_out = done;
	return buf;
}

static uint32_t btf_kind(uint32_t info)
{
	return (info >> 24) & 0x1f;
}

static uint32_t btf_vlen(uint32_t info)
{
	return info & 0xffff;
}

static size_t btf_extra_size(const struct btf_type *t)
{
	uint32_t kind = btf_kind(t->info);
	uint32_t vlen = btf_vlen(t->info);

	switch (kind) {
	case BTF_KIND_INT:
	case BTF_KIND_VAR:
	case BTF_KIND_DECL_TAG:
		return 4;
	case BTF_KIND_ARRAY:
		return 12;
	case BTF_KIND_STRUCT:
	case BTF_KIND_UNION:
		return (size_t)vlen * 12;
	case BTF_KIND_ENUM:
		return (size_t)vlen * 8;
	case BTF_KIND_FUNC_PROTO:
		return (size_t)vlen * 8;
	case BTF_KIND_DATASEC:
		return (size_t)vlen * 12;
	case BTF_KIND_ENUM64:
		return (size_t)vlen * 12;
	case BTF_KIND_PTR:
	case BTF_KIND_FWD:
	case BTF_KIND_TYPEDEF:
	case BTF_KIND_VOLATILE:
	case BTF_KIND_CONST:
	case BTF_KIND_RESTRICT:
	case BTF_KIND_FUNC:
	case BTF_KIND_FLOAT:
	case BTF_KIND_TYPE_TAG:
		return 0;
	default:
		fprintf(stderr, "unknown BTF kind %u\n", kind);
		exit(1);
	}
}

static int find_btf_func_id(const char *name)
{
	const struct btf_header *hdr;
	const uint8_t *types, *types_end;
	const char *strs;
	size_t btf_size;
	void *btf;
	uint32_t id = 1;

	btf = read_file("/sys/kernel/btf/vmlinux", &btf_size);
	if (!btf)
		return -1;
	if (btf_size < sizeof(*hdr)) {
		fprintf(stderr, "short BTF header\n");
		free(btf);
		return -1;
	}

	hdr = btf;
	if (hdr->magic != BTF_MAGIC) {
		fprintf(stderr, "unexpected BTF magic 0x%x\n", hdr->magic);
		free(btf);
		return -1;
	}
	if ((size_t)hdr->hdr_len + hdr->type_off + hdr->type_len > btf_size ||
	    (size_t)hdr->hdr_len + hdr->str_off + hdr->str_len > btf_size) {
		fprintf(stderr, "invalid BTF section bounds\n");
		free(btf);
		return -1;
	}

	types = (const uint8_t *)btf + hdr->hdr_len + hdr->type_off;
	types_end = types + hdr->type_len;
	strs = (const char *)btf + hdr->hdr_len + hdr->str_off;

	while (types + sizeof(struct btf_type) <= types_end) {
		const struct btf_type *t = (const struct btf_type *)types;
		size_t rec_size = sizeof(*t) + btf_extra_size(t);

		if (types + rec_size > types_end) {
			fprintf(stderr, "truncated BTF type section\n");
			free(btf);
			return -1;
		}

		if (btf_kind(t->info) == BTF_KIND_FUNC &&
		    t->name_off < hdr->str_len &&
		    strcmp(strs + t->name_off, name) == 0) {
			free(btf);
			return (int)id;
		}

		types += rec_size;
		id++;
	}

	fprintf(stderr, "BTF FUNC %s not found\n", name);
	free(btf);
	return -1;
}

static int load_prog(uint32_t attach_btf_id)
{
	static char log_buf[1 << 20];
	static char license[] = "GPL";
	struct bpf_insn insns[] = {
		{ .code = 0xb7, .dst_reg = 0, .src_reg = 0, .off = 0, .imm = 0 },
		{ .code = 0x95, .dst_reg = 0, .src_reg = 0, .off = 0, .imm = 0 },
	};
	union bpf_attr_local attr;
	int fd;

	memset(&attr, 0, sizeof(attr));
	attr.prog_load.prog_type = BPF_PROG_TYPE_TRACING;
	attr.prog_load.insn_cnt = sizeof(insns) / sizeof(insns[0]);
	attr.prog_load.insns = ptr_to_u64(insns);
	attr.prog_load.license = ptr_to_u64(license);
	attr.prog_load.log_level = 1;
	attr.prog_load.log_size = sizeof(log_buf);
	attr.prog_load.log_buf = ptr_to_u64(log_buf);
	attr.prog_load.prog_flags = BPF_F_SLEEPABLE;
	memcpy(attr.prog_load.prog_name, "tvma_sleep", sizeof("tvma_sleep"));
	attr.prog_load.expected_attach_type = BPF_TRACE_ITER;
	attr.prog_load.attach_btf_id = attach_btf_id;

	fd = (int)sys_bpf(BPF_PROG_LOAD, &attr);
	if (fd < 0) {
		perror("BPF_PROG_LOAD");
		if (log_buf[0])
			fprintf(stderr, "verifier log:\n%s\n", log_buf);
		return -1;
	}

	return fd;
}

static int create_iter_fd(int prog_fd, uint32_t pid)
{
	struct bpf_iter_link_info_task iter_info = {
		.tid = 0,
		.pid = pid,
		.pid_fd = 0,
	};
	union bpf_attr_local attr;
	int link_fd, iter_fd;

	memset(&attr, 0, sizeof(attr));
	attr.link_create.prog_fd = prog_fd;
	attr.link_create.target_fd = 0;
	attr.link_create.attach_type = BPF_TRACE_ITER;
	attr.link_create.flags = 0;
	attr.link_create.iter_info = ptr_to_u64(&iter_info);
	attr.link_create.iter_info_len = sizeof(iter_info);

	link_fd = (int)sys_bpf(BPF_LINK_CREATE, &attr);
	if (link_fd < 0) {
		perror("BPF_LINK_CREATE");
		return -1;
	}

	memset(&attr, 0, sizeof(attr));
	attr.iter_create.link_fd = link_fd;
	attr.iter_create.flags = 0;

	iter_fd = (int)sys_bpf(BPF_ITER_CREATE, &attr);
	if (iter_fd < 0) {
		perror("BPF_ITER_CREATE");
		return -1;
	}

	return iter_fd;
}

int main(int argc, char **argv)
{
	char buf[256];
	uint32_t pid = 1;
	int attach_btf_id;
	int prog_fd;
	int iter_fd;
	ssize_t n;

	if (argc > 1)
		pid = (uint32_t)strtoul(argv[1], NULL, 0);

	printf("[repro] target task_vma pid=%u\n", pid);
	bump_memlock_rlimit();

	attach_btf_id = find_btf_func_id("bpf_iter_task_vma");
	if (attach_btf_id < 0)
		return 1;
	printf("[repro] bpf_iter_task_vma attach_btf_id=%d\n", attach_btf_id);

	prog_fd = load_prog((uint32_t)attach_btf_id);
	if (prog_fd < 0)
		return 1;
	printf("[repro] prog_fd=%d\n", prog_fd);

	iter_fd = create_iter_fd(prog_fd, pid);
	if (iter_fd < 0)
		return 1;
	printf("[repro] iter_fd=%d\n", iter_fd);

	n = syscall(SYS_read, iter_fd, buf, sizeof(buf));
	if (n < 0) {
		perror("read(iter_fd)");
		return 1;
	}

	printf("[repro] read returned %zd\n", n);
	return 0;
}
