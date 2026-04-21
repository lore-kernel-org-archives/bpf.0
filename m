Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10B3DCD9B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802258; cv=none; b=MK8/j/pS+57E16G68jcfr2WktCHm352GWLbNC2Fnlyam6elmjlhMjnMBFtoeSo7lTjkanyZRv9+yHQBVrcE8PvZvYIWSxSNgU2D9gn094ROkpnLzEbLm+yGoRxHLl5E5chAcOEUhDGK0b8BzZe1lHnZT1H2ln0UDrGseY80fMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802258; c=relaxed/simple;
	bh=sJ5mqHFMfZKrOPIbAzxnHT0VDCtWgsvV1yK0FVXSrtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdskdUVrvPrQVVl3dBkCDCZt/CMNAIt2oZeECg1M5S0abSZPVoGaII/ylHiZXI+8qxnaQTjIAyq9Nul/+Ktip7TscrLu8AQmZ7Ywh2XQ0UveOPgHoo8jmJ8ceLYyTN9dNXN67i0cWfl0FkoRaLTGuWMuNmhbdcKTDe4c3bElQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o94oLgZN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o94oLgZN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65318dafbcbso4700483d50.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776802254; x=1777407054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVENE4Qf5Ff4nnLmI0DCHQqU6XDusubXOoRECbIEz/k=;
        b=o94oLgZNJqe2qQSS/EbT2tz5Txq1ZvbaWj2BD5wl+kkyIdedypXQzlNrG3xqgruJ1b
         lAUoCbAweV0SgAl0eOEFaAvffHXo1r3Xx7fHPRLrQTmeaDMEkcIcdJHgOBGeV5FCNqLC
         m7dKLtU53uV2KD+387EtOXmKWwHvGdlfQpf4aoXEuQEBj/XsjaMLURHeF5Wwn7rYISHA
         pKBqHxk+GN5BC2aP7TWR2fMpGYb2l3Yxb5WYpnwfuW4/T1WXmfIGUSNUCPtem0idcsIZ
         Pnv9i9ngrteeLtgre1FcKXGLNdzphiTohr+y4cokQSBIpupwfEEtPLjM0IycgIUFG79r
         cG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802254; x=1777407054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVENE4Qf5Ff4nnLmI0DCHQqU6XDusubXOoRECbIEz/k=;
        b=INyifee4kuqIpNKkrhFAzXPLJGLS+LCikdBeZX8y8VkW2ZxhhpBItCmQJgA0GNonX9
         xFdSD+3YNqQUfstvPT0Cgah6xvGcr6Ba4LoAmTQbkYimz7nUe7xv40WL33Gu5Zjf8lO2
         t5zvQUHoUkaYjCs1ucQoXiwBQO69AyUc40wEd1eRD50RYFtSMfxzQqcMhZHEECOmHTzY
         svpggwCyLQ69dpP8d2Co5BuQp0AaooVv8b+ub+nwH4hYmRMSiRZVuapx1qAYH6jWrxQK
         A1yDAaGZFIJWkHXvqrWf4qhTFwdwS1xVHFRov+OfaSpL1BDGBD6IzxTEBWj12XqE6yWH
         mlrA==
X-Gm-Message-State: AOJu0YwV/tXomfK/3N9Lld7aPcWTefHUK1u1b1dfx4BdIWuo0pL+r+UQ
	JV2jhWL9f/J4bMQ4/3Tt6u/SLVtQik1MN3VPnQ5hW+PVHHzCfm00Pl4vhVD6AQ==
X-Gm-Gg: AeBDies1pUiFSJG3jxwxIwMy7L7He9wYVgBUrqH8PHfXK9l0Ok/VfTZqcaPzJgabjyF
	8b8bl5y/KhK9+zy3NPTboKwDska8ggmlMjydzpBbSjk2Pp/geN2M4N0jzUNOe04p+ZywPjdv9U+
	cEYltnMFyQiQdLNRlT05tlf3iL3uI6P+Y8jqsfP2ExHC3PFXu9ElGO/gpFvzyhURHqe8IeYzKSw
	HrmLvyfUiHf1OoH4B68Zfd6DKZpTJzaRSnHLy9PjZxn1xtn1tqtPj37qy2oeqqgoNpn5LZxJHZS
	wswH+h2wfqFoX/smLlMuuKPT36HhtjBingtm6HaLpkcYl7dun8HcCkxu3kD0PskIHEiLC1MoaLm
	yWtWPcOonadsjF80Z5EIWcm77Kl/LY/TODQknLHwT5d0S7JyIpWDU9YLg1PvVb5H04+uMnRHU7a
	BKOPuKW8Tm2J/deoHFBHiICU/mMBrL2GJ/gabilM627Fg9klAvVRwCfwYvi67mv+ZMWc6jusu5S
	FOwq+5GPzTNOG6kQcEVQQ==
X-Received: by 2002:a53:b460:0:b0:651:c48e:b1f9 with SMTP id 956f58d0204a3-653109e0f8emr13449117d50.38.1776802253768;
        Tue, 21 Apr 2026 13:10:53 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:2ac1:99d4:1cef:9896])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314f11315sm7054233d50.21.2026.04.21.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:10:53 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	jolsa@kernel.org
Subject: [BUG] bpf: Soft lockup / panic triggered by bpf_task_release_dtor from NMI on rcu_nocbs CPU
Date: Tue, 21 Apr 2026 16:10:33 -0400
Message-ID: <20260421201035.1729473-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.

It was found after further investigation from a Sashiko report on my patch:
https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t

The issue is reproducible with a BPF selftest-derived reproducer that:

1. Stores exited task references in a BPF hash map as refcounted task kptrs.
2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
3. Runs on an `rcu_nocbs` CPU.

In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:

`perf_sched_delayed`
`  -> static_key_disable()`
`  -> arch_jump_label_transform_apply()`
`  -> smp_text_poke_batch_finish()`
`  -> on_each_cpu_cond_mask()`
`  -> smp_call_function_many_cond()`

The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.

Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:

`bpf_map_delete_elem()`
`  -> htab_map_delete_elem()`
`  -> free_htab_elem()`
`  -> bpf_obj_free_fields()`
`  -> bpf_task_release_dtor()`
`  -> put_task_struct_rcu_user()`
`  -> call_rcu()`

This is triggered from:

`tp_btf/nmi_handler`
`  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)

Environment

- x86_64 QEMU VM
- PREEMPT(full)
- `CONFIG_RCU_EXPERT=y`
- `CONFIG_RCU_NOCB_CPU=y`
- booted with `rcu_nocbs=1-7`

(the CONFIG_RCU_NOCB_CPU makes reproducing this more likely)

Observed result

- watchdog reports a soft lockup
- kernel panics with `Kernel panic - not syncing: softlockup: hung tasks`
- the stuck task is a kworker running `perf_sched_delayed`

Logs:

env TASK_KPTR_NMI_DEADLOCK_REPRO=1 ./test_progs -t task_kptr_nmi_deadlock_repro
[    1.336781] bpf_testmod: loading out-of-tree module taints kernel.
[    1.336961] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
[    1.358431] 
[    1.358433] ================================
[    1.358433] WARNING: inconsistent lock state
[    1.358434] 7.0.0-11169-ge4ef174588b8-dirty #16 Tainted: G           OE      
[    1.358435] --------------------------------
[    1.358436] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[    1.358436] test_progs/134 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    1.358438] ffff8ae3bbc6f0e8 (&rdp->nocb_lock){....}-{2:2}, at: __call_rcu_common.constprop.0+0x316/0x740
[    1.358445] {INITIAL USE} state was registered at:
[    1.358445]   lock_acquire+0xc0/0x2d0
[    1.358448]   _raw_spin_lock+0x33/0x50
[    1.358451]   rcu_nocb_gp_kthread+0x13b/0xbb0
[    1.358453]   kthread+0x10d/0x140
[    1.358456]   ret_from_fork+0x26d/0x330
[    1.358458]   ret_from_fork_asm+0x1a/0x30
[    1.358465] irq event stamp: 47398
[    1.358465] hardirqs last  enabled at (47397): [<ffffffff8a1397cb>] _raw_spin_unlock_irqrestore+0x4b/0x60
[    1.358467] hardirqs last disabled at (47398): [<ffffffff8a12ca1d>] __schedule+0xb1d/0x13e0
[    1.358469] softirqs last  enabled at (47298): [<ffffffff8928d770>] fpu_clone+0x80/0x210
[    1.358471] softirqs last disabled at (47296): [<ffffffff8928d740>] fpu_clone+0x50/0x210
[    1.358473] 
[    1.358473] other info that might help us debug this:
[    1.358473]  Possible unsafe locking scenario:
[    1.358473] 
[    1.358473]        CPU0
[    1.358474]        ----
[    1.358474]   lock(&rdp->nocb_lock);
[    1.358475]   <Interrupt>
[    1.358475]     lock(&rdp->nocb_lock);
[    1.358476] 
[    1.358476]  *** DEADLOCK ***
[    1.358476] 
[    1.358476] 1 lock held by test_progs/134:
[    1.358477]  #0: ffff8ae3bbc6dfe0 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x119/0x13e0
[    1.358480] 
[    1.358480] stack backtrace:
[    1.358482] CPU: 1 UID: 0 PID: 134 Comm: test_progs Tainted: G           OE       7.0.0-11169-ge4ef174588b8-dirty #16 PREEMPT(full) 
[    1.358484] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[    1.358484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    1.358486] Call Trace:
[    1.358487]  <NMI>
[    1.358488]  dump_stack_lvl+0x63/0x90
[    1.358491]  print_usage_bug.part.0+0x233/0x2d0
[    1.358495]  lock_acquire+0x28b/0x2d0
[    1.358497]  ? __call_rcu_common.constprop.0+0x316/0x740
[    1.358501]  _raw_spin_lock+0x33/0x50
[    1.358502]  ? __call_rcu_common.constprop.0+0x316/0x740
[    1.358505]  __call_rcu_common.constprop.0+0x316/0x740
[    1.358509]  bpf_obj_free_fields+0x129/0x260
[    1.358514]  free_htab_elem+0x8d/0xe0
[    1.358518]  htab_map_delete_elem+0x16b/0x240
[    1.358522]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xb3/0x144
[    1.358524]  bpf_trace_run3+0x11b/0x2f0
[    1.358527]  ? __pfx_perf_event_nmi_handler+0x10/0x10
[    1.358530]  ? __pfx_perf_event_nmi_handler+0x10/0x10
[    1.358531]  nmi_handle.part.0+0x15c/0x260
[    1.358536]  default_do_nmi+0x12f/0x190
[    1.358539]  exc_nmi+0xeb/0x120
[    1.358542]  end_repeat_nmi+0xf/0x53
[    1.358544] RIP: 0010:dequeue_entities+0x7ba/0xd70
[    1.358547] Code: fa ff ff f6 45 b4 01 0f 84 75 fa ff ff 4c 89 ff e8 6b 41 ff ff 4d 8b ad a8 00 00 00 49 83 3f 00 0f 84 6d fa ff ff 49 8b 47 40 <49> 8b 57 50 48 c7 c3 ff ff ff ff 48 85 c0 0f 84 54 05 00 00 48 85
[    1.358548] RSP: 0018:ffffa83480a77c30 EFLAGS: 00000006
[    1.358549] RAX: ffff8ae382fe4590 RBX: 0000000000000009 RCX: ffff8ae382fe45c8
[    1.358550] RDX: ffff8ae380dd80c8 RSI: 0000000000000000 RDI: ffff8ae383d82300
[    1.358551] RBP: ffffa83480a77ca8 R08: 000000000001084f R09: ffff8ae383d82300
[    1.358551] R10: 0000000000000002 R11: 0000000008264572 R12: 0000000000000000
[    1.358552] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8ae3bbc6e040
[    1.358558]  ? dequeue_entities+0x7ba/0xd70
[    1.358561]  ? dequeue_entities+0x7ba/0xd70
[    1.358563]  </NMI>
[    1.358563]  <TASK>
[    1.358567]  dequeue_task_fair+0xf2/0x480
[    1.358570]  __schedule+0x998/0x13e0
[    1.358574]  ? do_wait+0x63/0x1a0
[    1.358577]  schedule+0x3e/0x140
[    1.358578]  do_wait+0x7b/0x1a0
[    1.358581]  kernel_wait4+0xc0/0x170
[    1.358584]  ? __pfx_child_wait_callback+0x10/0x10
[    1.358588]  __do_sys_wait4+0xa7/0xc0
[    1.358594]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.358596]  do_syscall_64+0xa1/0x5f0
[    1.358598]  ? irq_exit_rcu+0x12/0x20
[    1.358601]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.358602] RIP: 0033:0x7fc342ca6922
[    1.358603] Code: 08 0f 85 51 36 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[    1.358604] RSP: 002b:00007fff75f85138 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
[    1.358605] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc342ca6922
[    1.358606] RDX: 0000000000000000 RSI: 00007fff75f851c8 RDI: 0000000000000090
[    1.358606] RBP: 00007fff75f85160 R08: 0000000000000000 R09: 0000000000000000
[    1.358607] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff75f85618
[    1.358607] R13: 0000000000000003 R14: 00007fc343411000 R15: 000055f2f8140a30
[    1.358613]  </TASK>
[    1.427470] perf: interrupt took too long (2528 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
[    1.450479] perf: interrupt took too long (3179 > 3160), lowering kernel.perf_event_max_sample_rate to 62000
[    1.489552] perf: interrupt took too long (3984 > 3973), lowering kernel.perf_event_max_sample_rate to 50000
[    1.567488] perf: interrupt took too long (4990 > 4980), lowering kernel.perf_event_max_sample_rate to 40000
[    1.696694] tsc: Refined TSC clocksource calibration: 4191.351 MHz
[    1.696873] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3c6a77879d2, max_idle_ns: 440795420607 ns
[    1.697225] clocksource: Switched to clocksource tsc
#466     task_kptr_nmi_deadlock_repro:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[    2.017327] smc: removing smcd device lo
[    2.018518] ACPI: PM: Preparing to enter system sleep state S5
[    2.018712] reboot: Power down


I reduced this to a dedicated selftest-style reproducer.

Reproducer: https://gist.githubusercontent.com/RazeLighter777/5539336d79ab1854f9e9550c6dcab118/raw/082f1eeb2dd445936e64dd3a33861764690bde82/task_struct_dtor_deadlock.patch

This looks like an NMI-unsafety issue in the task kptr destructor path.

This may also apply to the cgroup release dtor, which I believe also can use call_rcu in this path. I haven't tried to make a reproducer for that case.

This should be fixed because even without that specific kconfig, call_rcu is not intended to be called from an NMI handler ever and can result in corruption.


Thanks,

Justin Suess
