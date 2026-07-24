Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979F33A00C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906838; cv=none; b=bUn7TI6DJ3Y3j80o0ZmnbbsyHz/VNV2BatAFw0xK0n44Ab73pIT06u7/OECnEY1sgwXTKpAS21MDYzL3F4apY4EGO0r7d7FPsK9Ugj9KZw1LoYS7/vgKTth2FOZ4WD649fyXtqueT35Ee4kv74xY1GtMj+vyBxke3eoFUE9VYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906838; c=relaxed/simple;
	bh=sEuW3CjevMU5v+cUPj6CJKfFH6duxFx9Mo9tPDQ1Onk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti+Bs7YK9Q3PP3ePcDwn/JUG5lTCxz/glLC7f0v5axo7t//DX2lBibGjRBeitKU1kxzkDPTWvMY5600jTXMocHbLGECDucUPmU0q0WyhhEcQg7uOZKxE/eeq75/dhmr9jre8iurpFTVKzVHSB9PmDBCsM47xDU5sTXCARx3TIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exein.io; spf=pass smtp.mailfrom=exein.io; dkim=pass (1024-bit key) header.d=exein.io header.i=@exein.io header.b=RCPElc21; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exein.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exein.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=exein.io header.i=@exein.io header.b="RCPElc21"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495437bb891so5960095e9.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exein.io; s=google; t=1784906835; x=1785511635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hfuwx8sttZ/SdqRjVjTTYRllHzioQ+mJ3rU/O/x6Nk8=;
        b=RCPElc21x44we/qjZ3+tXuAnv7D2Zo2WJ9dz4VLPmNOW494w3kT0Qy6FL0jGiZLvwk
         qShi5p/QNMc3AaW4aMFOq3orTAapPp/R4YuEiB8HDtz0PcA3PHHyH6cMic/Q9SrOjQwm
         36m/ksxuD/HPZ8H4uzekdQByNce65nKTTRkKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906835; x=1785511635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hfuwx8sttZ/SdqRjVjTTYRllHzioQ+mJ3rU/O/x6Nk8=;
        b=apT6WkJRb66cH6OB+WwLQBDULY7g8tU1VYG2yFvDy6Z9KVntF8kbq0hDnZrDT98xNW
         gIVVAnV9txbL+gmhricMUBWcj6SM5b0CcPI3n8XvI0BamSZ+alSQ0sQUaklKronDVkkA
         juwwW0qh9np70ol9SgqCN1N/1H7FQ1FgBZDuyJb5xnG5dRKIaq0u42JKWDuy+dz/f4c8
         HXXr0FpO2XUZZUD/9z0MnqGYj1NGFoNobqZmBLp4O7ZNPVACvqpgypDdRWFDEbVieW18
         vhgDmpxjeXsajrqQpTak0GkRT0BdAsGBoFhGWnzfDGpl1c0DBAANNUQdwlkAnG2Ul5OO
         1Xjw==
X-Gm-Message-State: AOJu0YwLbvwaAYDjPEcv17Bi0Rwn2H3z5Hu4h9QZoeDOWt6j1WwfsYFb
	AnzcYCIA1sV1PZHut3YX1fl7jB6exhovPviR0qyNDX01FkjFCNqu+Np9tMa/NAm+QtT1Yj4iNJP
	8Id+6snA=
X-Gm-Gg: AR+sD13wAlDp+d9ApDcJ7wC3mW8jzh2CUyma33hq4VPpMGUmijAhNHPWgPTl5+zJwuo
	v/tIi4V5XrR8491TNsPTfDzXUcrttggwvIVRjzTe1FRsD3ODCkJasyfc6PhXr/YMtMMyBxX5o9g
	cCEGXnZ/WE3J/hcnzLmLWVaOuhmjrKGzQUV45vagBsgXUrRZXxd8kR7bVKRQlUCFDu3vqxuyzl1
	ydtl2nnwWgiHlSN9zP3qPuL3ED2iZiUZLpwQFLGftfMgFkGel3AIenv6aKeWE/xbtqccPzTq317
	erNo0tPz6flSR2VY1PI08SICANA8lsvhFGt7V4w2iHJouPVWaRFCItFTGIprOMGRd02NbND96cr
	Wh43d56DTLWWTl7VcQa+NV2Pu1ruNY0Av/riCjcllHd91xlIHdw5UJsqDrYS8YZfmotfOvoiURz
	jA
X-Received: by 2002:a05:600c:1d0c:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-496997167demr13789235e9.4.1784906834695;
        Fri, 24 Jul 2026 08:27:14 -0700 (PDT)
Received: from bndtbox2 ([2a07:7e87:43dd:0:5c77:3af2:8834:7ec1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm26186817f8f.2.2026.07.24.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:27:13 -0700 (PDT)
From: Domenico Salvatore <banditopazzo@exein.io>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	oleg@redhat.com
Subject: [BUG] bpf: AA deadlock on task->alloc_lock via bpf_get_task_exe_file() in lsm/ptrace_access_check
Date: Fri, 24 Jul 2026 17:26:47 +0200
Message-ID: <20260724152651.212359-1-banditopazzo@exein.io>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I encountered a deadlock using the bpf_get_task_exe_file() kfunc in the
ptrace_access_check LSM hook that hard-hangs the machine. The kfunc
ends up calling task_lock() on an already-locked task.

It affects everything from the 6.12 LTS to the latest release.

Not reporting via security@ since it needs high privileges.

Minimal reproducer
------------------

  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>

  char LICENSE[] SEC("license") = "GPL";

  extern struct file *bpf_get_task_exe_file(struct task_struct *task) __ksym;
  extern void bpf_put_file(struct file *file) __ksym;

  SEC("lsm/ptrace_access_check")
  int BPF_PROG(ptrace_access_check, struct task_struct *child, unsigned int mode)
  {
          struct file *exe = bpf_get_task_exe_file(child);
          if (exe)
                  bpf_put_file(exe);
          return 0;
  }

Attaching the program is usually enough to trigger it; otherwise open
/proc/1/mem to force it.

The deadlock
------------

The hook runs with task_lock(task) held. From kernel/ptrace.c:

  bool ptrace_may_access(struct task_struct *task, unsigned int mode)
  {
          int err;
          task_lock(task);
          err = __ptrace_may_access(task, mode);
          task_unlock(task);
          return !err;
  }

__ptrace_may_access() ends with:

          return security_ptrace_access_check(task, mode);

The kfunc just forwards to get_task_exe_file():

  __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
  {
          return get_task_exe_file(task);
  }

which re-takes the same lock. From kernel/fork.c:

  struct file *get_task_exe_file(struct task_struct *task)
  {
          struct file *exe_file = NULL;
          struct mm_struct *mm;

          if (task->flags & PF_KTHREAD)
                  return NULL;
          task_lock(task);           /* <-- already locked */
          mm = task->mm;
          if (mm)
                  exe_file = get_mm_exe_file(mm);
          task_unlock(task);
          return exe_file;
  }

lockdep splat (v7.1.4)
----------------------

I attached it with a small custom loader; the resulting splat:

  ============================================
  WARNING: possible recursive locking detected
  7.1.4-g7a5cef0db479 #1 Not tainted
  --------------------------------------------
  loader/88 is trying to acquire lock:
  ffff9fcac12fd798 (&p->alloc_lock){+.+.}-{3:3}, at: get_task_exe_file+0x24/0x60

  but task is already holding lock:
  ffff9fcac12fd798 (&p->alloc_lock){+.+.}-{3:3}, at: ptrace_may_access+0x22/0x50

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&p->alloc_lock);
    lock(&p->alloc_lock);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  3 locks held by loader/88:
   #0: ffff9fcac130d370 (&sig->exec_update_lock){++++}-{4:4}, at: mm_access+0x27/0x110
   #1: ffff9fcac12fd798 (&p->alloc_lock){+.+.}-{3:3}, at: ptrace_may_access+0x22/0x50
   #2: ffffffff87b64a98 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x63/0x110

  stack backtrace:
  CPU: 0 UID: 0 PID: 88 Comm: loader Not tainted 7.1.4-g7a5cef0db479 #1 PREEMPT(lazy)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x54/0x70
   print_deadlock_bug+0x279/0x290
   __lock_acquire+0x11b6/0x28c0
   lock_acquire+0xc3/0x290
   _raw_spin_lock+0x30/0x40
   get_task_exe_file+0x24/0x60
   bpf_prog_e6cb40d68b68175a_ptrace_dl+0x2a/0x3f
   bpf_trampoline_6442533847+0x5c/0xfd
   ptrace_may_access+0x2c/0x50
   mm_access+0x83/0x110
   proc_mem_open+0x2e/0xc0
   mem_open+0x21/0x70
   do_dentry_open+0x12b/0x420
   vfs_open+0x2c/0xf0
   path_openat+0xbc5/0xe70
   do_file_open+0xd7/0x190
   do_sys_openat2+0x74/0xe0
   __x64_sys_open+0x7e/0xa0
   do_syscall_64+0x143/0x470
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  ... and ~26s later the CPU is confirmed wedged on that lock:

  rcu: INFO: rcu_preempt self-detected stall on CPU
  rcu:     0-....: (25983 ticks this GP) idle=3e94/1/0x4000000000000000 softirq=104/104 fqs=6483
  CPU: 0 UID: 0 PID: 88 Comm: loader Not tainted 7.1.4-g7a5cef0db479 #1 PREEMPT(lazy)
  RIP: 0010:queued_spin_lock_slowpath+0x1c/0x320
  Call Trace:
   <TASK>
   do_raw_spin_lock+0xd3/0xe0
   get_task_exe_file+0x24/0x60
   bpf_prog_e6cb40d68b68175a_ptrace_dl+0x2a/0x3f
   bpf_trampoline_6442533847+0x5c/0xfd
   ptrace_may_access+0x2c/0x50
   mm_access+0x83/0x110
   proc_mem_open+0x2e/0xc0
   mem_open+0x21/0x70
   do_dentry_open+0x12b/0x420
   vfs_open+0x2c/0xf0
   path_openat+0xbc5/0xe70
   do_file_open+0xd7/0x190
   do_sys_openat2+0x74/0xe0
   __x64_sys_open+0x7e/0xa0
   do_syscall_64+0x143/0x470
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Notes
-----

A similar issue was fixed for bpf_task_storage_[get|delete] with a guard
whose trylock returns NULL on failure.

I don't think that would work here, though: a trylock guard would
always fail and return NULL, making the kfunc useless in this hook.

Ideally a fix would keep the kfunc usable from this hook. One idea could
be to make kfuncs context-aware, in this case taking task_lock() only
when the caller doesn't already hold it, but you may have better
alternatives.

Thanks,
Domenico
