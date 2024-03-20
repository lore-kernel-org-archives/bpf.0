Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322614F8B2
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970888; cv=none; b=t7i+Edoxy3AYvGRhhc5s25e+hf07UZjjGmiiWuh84vCtWhMrLzYX07n0M6fkm+zMjnbh2LxGHihhW9Xa31fgVl4AnyjRDPEtGNIfX4eAK7hrE79gAMPJXJnZdJYvPbjojt6WrzLKK7Yw7A8LCm5bQrdhxeuNsygJy2fSgGRho74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970888; c=relaxed/simple;
	bh=lIwShWRE1RH4UutF9KXq7V7u+wxGXaGextOuV96WtjM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ePIWdGcB3nP9NXmutkAsLwbj5lrSYmU5mB9X4VPplZX8CCn3J+WlqhmLUYtITzqBdb6IDY8a5ht2ZWD6WZCulOdlNo7qbpoSoh61FYFHcaNms9YALGtTGvSCSLhRUsOinmHuzFaqNUFv9WM/F0m2QyBSr6jh1lBh5X5bTTQxGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso25173539f.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 14:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970885; x=1711575685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmVrrjalo9YM4iU9/gvZoCra5ETa+uZO/hJohZ6TG30=;
        b=JHeEJc/O4X41TDCpG/HLWOO8EA1IOwWEQ6b5UOtT6l4w+4X3mKGxOVT0LwEy8NVB7o
         X0ECLNBDjMKi605sZzqC6uvmsSxMSJ774LsQ1SydmanThUcm316ck2aaanvBv+lsFuKh
         xVXdAOb3PyQe95WU1q3fmQ0ui53qguLN3+mBu+HsHDcz0jiepG3zXvZ3OWEqjvlIUnXZ
         CFxIzE1VUGrTWMC0yUPs/iVciUzfixsEohV+NOQZAYv31M/nxmIggZ+7GR88P4w7O0JN
         aNv7YBI+8gvtfHIoWwOophgqop+F2ESwb9EjTQpZZ3Dr3NtCpQHy2UrpWeWEbGnH7lnh
         6Tow==
X-Forwarded-Encrypted: i=1; AJvYcCVsTGJVB38u/ARzzj4nO8oM1XzjQaUzp5o6c2RDiYFa55JxuYwsCXI3FIbFPjpsYX9Fxcx1gpJIpxjJWCJEu5hIwgQr
X-Gm-Message-State: AOJu0YzbJUpdqAREUu1ly0N0VvYm2q/RYFwTd74TMGaiM33MfG50DzNy
	Q6CRPcgk2NNNEdMNGNNNE53PlKHHN4SHsHpEbVT4naiEqKtJVP5vvRr621bdGTQER9X6iYCysUD
	+J8DfBTbcD6nCKfzZi8sxFOJm87K3dxXlG3tLsBFsqjbLMFFPGkycX8U=
X-Google-Smtp-Source: AGHT+IGh8Dr6YncD8irfJjiYVBaF+FvGVf8uiSd5bgIptbVLtJZ4n6ARrEsbMBLxm6G6nUpZxpFB4igiXYtCNtXmzJLG2Jrj56sV
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:366:9ead:6446 with SMTP id
 j19-20020a056e02219300b003669ead6446mr956236ila.2.1710970885433; Wed, 20 Mar
 2024 14:41:25 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8fd6b06141e73a4@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
From: syzbot <syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea80e3ed09ab net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13f2ea6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8627369462e8429d7cd6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a8fac9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1619b83a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c6c49a7ef5c/disk-ea80e3ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/242942b30f2d/vmlinux-ea80e3ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74dcc2059655/bzImage-ea80e3ed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
-----------------------------------------------------
kworker/0:2/782 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888022c5e820 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888022c5e820 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff888014ca0018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6ec/0xec0
which would create a new lock dependency:
 (&pool->lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&pool->lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  wq_worker_tick+0x207/0x440 kernel/workqueue.c:1501
  scheduler_tick+0x375/0x6e0 kernel/sched/core.c:5699
  update_process_times+0x202/0x230 kernel/time/timer.c:2481
  tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
  tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __sanitizer_cov_trace_switch+0x6/0x120 kernel/kcov.c:317
  unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
  __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
  unwind_start arch/x86/include/asm/unwind.h:64 [inline]
  arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
  stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
  save_stack+0xfb/0x1f0 mm/page_owner.c:129
  __set_page_owner+0x29/0x380 mm/page_owner.c:195
  set_page_owner include/linux/page_owner.h:31 [inline]
  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
  prep_new_page mm/page_alloc.c:1540 [inline]
  get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
  __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
  alloc_pages_mpol+0x3de/0x650 mm/mempolicy.c:2133
  __get_free_pages+0xc/0x30 mm/page_alloc.c:4616
  kasan_populate_vmalloc_pte+0x38/0xe0 mm/kasan/shadow.c:311
  apply_to_pte_range mm/memory.c:2619 [inline]
  apply_to_pmd_range mm/memory.c:2663 [inline]
  apply_to_pud_range mm/memory.c:2699 [inline]
  apply_to_p4d_range mm/memory.c:2735 [inline]
  __apply_to_page_range+0x8ec/0xe40 mm/memory.c:2769
  pcpu_get_vm_areas+0x3749/0x4fb0 mm/vmalloc.c:4232
  pcpu_create_chunk+0x69a/0xbc0 mm/percpu-vm.c:342
  pcpu_balance_populated mm/percpu.c:2101 [inline]
  pcpu_balance_workfn+0xc4d/0xd40 mm/percpu.c:2238
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
  bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&pool->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&pool->lock);

 *** DEADLOCK ***

5 locks held by kworker/0:2/782:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90004097d00 ((work_completion)(&aux->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90004097d00 ((work_completion)(&aux->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __queue_work+0x198/0xec0 kernel/workqueue.c:2324
 #3: ffff888014ca0018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6ec/0xec0
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run3+0x14a/0x460 kernel/trace/bpf_trace.c:2421

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&pool->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    wq_worker_tick+0x207/0x440 kernel/workqueue.c:1501
                    scheduler_tick+0x375/0x6e0 kernel/sched/core.c:5699
                    update_process_times+0x202/0x230 kernel/time/timer.c:2481
                    tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __sanitizer_cov_trace_switch+0x6/0x120 kernel/kcov.c:317
                    unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
                    __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
                    unwind_start arch/x86/include/asm/unwind.h:64 [inline]
                    arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    save_stack+0xfb/0x1f0 mm/page_owner.c:129
                    __set_page_owner+0x29/0x380 mm/page_owner.c:195
                    set_page_owner include/linux/page_owner.h:31 [inline]
                    post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
                    prep_new_page mm/page_alloc.c:1540 [inline]
                    get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
                    __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
                    alloc_pages_mpol+0x3de/0x650 mm/mempolicy.c:2133
                    __get_free_pages+0xc/0x30 mm/page_alloc.c:4616
                    kasan_populate_vmalloc_pte+0x38/0xe0 mm/kasan/shadow.c:311
                    apply_to_pte_range mm/memory.c:2619 [inline]
                    apply_to_pmd_range mm/memory.c:2663 [inline]
                    apply_to_pud_range mm/memory.c:2699 [inline]
                    apply_to_p4d_range mm/memory.c:2735 [inline]
                    __apply_to_page_range+0x8ec/0xe40 mm/memory.c:2769
                    pcpu_get_vm_areas+0x3749/0x4fb0 mm/vmalloc.c:4232
                    pcpu_create_chunk+0x69a/0xbc0 mm/percpu-vm.c:342
                    pcpu_balance_populated mm/percpu.c:2101 [inline]
                    pcpu_balance_workfn+0xc4d/0xd40 mm/percpu.c:2238
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    __queue_work+0x6ec/0xec0
                    call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
                    expire_timers kernel/time/timer.c:1838 [inline]
                    __run_timers kernel/time/timer.c:2408 [inline]
                    __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2419
                    run_timer_base kernel/time/timer.c:2428 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0x13/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x22f/0x5d0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
                    rest_init+0x2e0/0x300 init/main.c:730
                    arch_call_rest_init+0xe/0x10 init/main.c:831
                    start_kernel+0x47a/0x500 init/main.c:1077
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   __queue_work+0x6ec/0xec0
                   queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
                   queue_work include/linux/workqueue.h:605 [inline]
                   start_poll_synchronize_rcu_expedited+0xf7/0x150 kernel/rcu/tree_exp.h:1017
                   rcu_init+0xea/0x140 kernel/rcu/tree.c:5240
                   start_kernel+0x1f7/0x500 init/main.c:969
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff926c0e60>] init_worker_pool.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
                    bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
                   bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
                   process_one_work kernel/workqueue.c:3254 [inline]
                   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                   kthread+0x2f0/0x390 kernel/kthread.c:388
                   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
   bpf_prog_2c29ac5cdc6b1842+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
   trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
   __queue_work+0xe5b/0xec0 kernel/workqueue.c:2382
   queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
   __bpf_free_used_maps kernel/bpf/core.c:2716 [inline]
   bpf_free_used_maps kernel/bpf/core.c:2722 [inline]
   bpf_prog_free_deferred+0x21d/0x710 kernel/bpf/core.c:2761
   process_one_work kernel/workqueue.c:3254 [inline]
   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 0 PID: 782 Comm: kworker/0:2 Not tainted 6.8.0-syzkaller-05221-gea80e3ed09ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events bpf_prog_free_deferred
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x4dc7/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
 trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
 __queue_work+0xe5b/0xec0 kernel/workqueue.c:2382
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 __bpf_free_used_maps kernel/bpf/core.c:2716 [inline]
 bpf_free_used_maps kernel/bpf/core.c:2722 [inline]
 bpf_prog_free_deferred+0x21d/0x710 kernel/bpf/core.c:2761
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
