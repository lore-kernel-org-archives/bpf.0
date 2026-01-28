Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFB2FE59A
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641721; cv=none; b=nT3Jud/a1AQm7grk8H8IG1YZpgWdXiDdMnEpt+rV/PiD9qmtxOA7p2OOu4A9MTJQFtBavGWZb7tsBWbiN2IEbXLFN8FPhm3AnyHIlsBSAd2ikX8HVkk+5qIaFnY+GBEW19tIyFkwtZQKcAI14X0zG2PPukkaUIxPtBwQHx2P4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641721; c=relaxed/simple;
	bh=ZDxsL1zUL/J4IWO2f0VLxsCTzDoqL2lc+F3Popx6XWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y9Tn0I4IZOXKFtm3zK2sKZ4zU2XZsfQ/XdMLxiBUnrsGifO+WMsH6WTvvn26oiqOusymd/EoGeMOT+91WNiTGiiFc0vqskOEyKJ4rbLUVudIYTclwJnXhf8mnfhSVWmQqB7Jw62xYVePooMYhZGmDM+9zipGhdk3bBbMbmx2CWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pFYq31sK; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pFYq31sK"
Message-ID: <6a77996f-5b08-4db6-8631-031ce3e52145@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769641706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3IlNn2qzABN+x3n/fkSM74LdTUJHsBfFv2N/fU95Xw=;
	b=pFYq31sKg75hE34zozr3NKqK41VaUcruN03WV/jrxn3irMbiatzzFKj+oOIsu2LSmFRB14
	s08c5mG0Np/I63em1uZs/yT3URrXu5sNRfKWqfgt9gkH32rqPfd70nwJ2NxjGS2GfSzeSX
	JMGGqWFCIvzgiRQdCOa0N4xKeETFEd8=
Date: Wed, 28 Jan 2026 15:08:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, bpf <bpf@vger.kernel.org>,
 sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan
 <puranjay@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev> <877bt29cgv.ffs@tglx>
 <bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ibm.com> <87y0lh96xo.ffs@tglx>
 <87jyx1ml3h.ffs@tglx> <70335ad4-59b6-45fd-8a76-bd91d9658810@linux.dev>
Content-Language: en-US
In-Reply-To: <70335ad4-59b6-45fd-8a76-bd91d9658810@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/26 2:33 PM, Ihor Solodrai wrote:
> [...]
> 
> We have a steady stream of jobs running, so if it's not a one-off it's
> likely to happen again. I'll share if we get anything.

Here is another one, with backtraces of other CPUs:

[   59.133878] watchdog: CPU2: Watchdog detected hard LOCKUP on cpu 2
[   59.133886] Modules linked in: bpf_testmod(OE)
[   59.133892] irq event stamp: 687092
[   59.133893] hardirqs last  enabled at (687091): [<ffffffff8fbfbf78>] _raw_spin_unlock_irq+0x28/0x50
[   59.133908] hardirqs last disabled at (687092): [<ffffffff8fbfbd11>] _raw_spin_lock_irqsave+0x51/0x60
[   59.133912] softirqs last  enabled at (687006): [<ffffffff8d345e2a>] fpu_clone+0xda/0x4f0
[   59.133918] softirqs last disabled at (687004): [<ffffffff8d345dd2>] fpu_clone+0x82/0x4f0
[   59.133925] CPU: 2 UID: 0 PID: 127 Comm: test_progs Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
[   59.133930] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   59.133932] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   59.133935] RIP: 0010:queued_spin_lock_slowpath+0x3a9/0xac0
[   59.133943] Code: 00 00 85 c0 74 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 <41> 0f b6 04 24 44 38 e8 7f 08 84 c0 0f 85 9f 05 00 00 0f b6 03 84
[   59.133945] RSP: 0018:ffffc900012df750 EFLAGS: 00000002
[   59.133950] RAX: 0000000000000001 RBX: ffff8881520ba000 RCX: 0000000000000001
[   59.133952] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881520ba000
[   59.133954] RBP: 1ffff9200025beec R08: ffffffff8fbfcb69 R09: ffffed102a417400
[   59.133956] R10: ffffed102a417401 R11: 0000000000000004 R12: ffffed102a417400
[   59.133958] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881520ba000
[   59.133960] FS:  00007f7230740e00(0000) GS:ffff8881bf8db000(0000) knlGS:0000000000000000
[   59.133964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.133966] CR2: 00007f722f1a6d58 CR3: 000000010ed2f001 CR4: 0000000000770ef0
[   59.133968] PKRU: 55555554
[   59.133969] Call Trace:
[   59.133973]  <TASK>
[   59.133977]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   59.133985]  do_raw_spin_lock+0x1d9/0x270
[   59.133991]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   59.133994]  ? __pfx___might_resched+0x10/0x10
[   59.134001]  task_rq_lock+0xcf/0x3c0
[   59.134007]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   59.134011]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   59.134015]  ? lock_acquire+0x14e/0x2b0
[   59.134020]  ? mark_held_locks+0x40/0x70
[   59.134025]  sched_mm_cid_fork+0x6da/0xc20
[   59.134030]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   59.134032]  ? copy_process+0x217b/0x6950
[   59.134037]  copy_process+0x2bce/0x6950
[   59.134044]  ? __pfx_copy_process+0x10/0x10
[   59.134046]  ? find_held_lock+0x2b/0x80
[   59.134051]  ? _copy_from_user+0x53/0xa0
[   59.134058]  kernel_clone+0xce/0x600
[   59.134061]  ? __pfx_kernel_clone+0x10/0x10
[   59.134066]  ? __lock_acquire+0x481/0x2590
[   59.134071]  __do_sys_clone3+0x16e/0x1b0
[   59.134074]  ? __pfx___do_sys_clone3+0x10/0x10
[   59.134077]  ? lock_acquire+0x14e/0x2b0
[   59.134080]  ? __might_fault+0x9b/0x140
[   59.134089]  ? _copy_to_user+0x5c/0x70
[   59.134092]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   59.134099]  ? do_user_addr_fault+0x4c2/0xa40
[   59.134103]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   59.134107]  do_syscall_64+0x6b/0x3a0
[   59.134111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.134116] RIP: 0033:0x7f7230c42c5d
[   59.134120] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   59.134122] RSP: 002b:00007ffe90d4e1f8 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   59.134126] RAX: ffffffffffffffda RBX: 00007f7230bb5720 RCX: 00007f7230c42c5d
[   59.134128] RDX: 00007f7230bb5720 RSI: 0000000000000058 RDI: 00007ffe90d4e250
[   59.134129] RBP: 00007ffe90d4e230 R08: 00007f722f1a66c0 R09: 00007ffe90d4e357
[   59.134131] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f722f1a66c0
[   59.134133] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007ffe90d4e250
[   59.134139]  </TASK>
[   59.134141] Sending NMI from CPU 2 to CPUs 0-1,3:
[   59.134168] NMI backtrace for cpu 3
[   59.134176] CPU: 3 UID: 0 PID: 67 Comm: kworker/3:1 Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
[   59.134181] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   59.134183] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   59.134186] Workqueue: events drain_vmap_area_work
[   59.134194] RIP: 0010:smp_call_function_many_cond+0x772/0xe60
[   59.134200] Code: 38 c8 7c 08 84 c9 0f 85 92 05 00 00 8b 43 08 a8 01 74 2e 48 89 f1 49 89 f5 48 c1 e9 03 41 83 e5 07 4c 01 f1 41 83 c5 03 f3 90 <0f> b6 01 41 38 c5 7c 08 84 c0 0f 85 c1 04 00 00 8b 43 08 a8 01 75
[   59.134203] RSP: 0018:ffffc90000587948 EFLAGS: 00000202
[   59.134206] RAX: 0000000000000011 RBX: ffff8881520c1ac0 RCX: ffffed102a418359
[   59.134208] RDX: 0000000000000001 RSI: ffff8881520c1ac8 RDI: ffffffff90713be8
[   59.134210] RBP: ffffed102a437680 R08: ffff8881521bb408 R09: 0000000000000000
[   59.134212] R10: 1ffff1102a437681 R11: ffff888103aa8bb0 R12: ffff8881521bb408
[   59.134213] R13: 0000000000000003 R14: dffffc0000000000 R15: ffff8881521bb400
[   59.134215] FS:  0000000000000000(0000) GS:ffff8881bf95b000(0000) knlGS:0000000000000000
[   59.134219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.134221] CR2: 00007fc9ae7762a0 CR3: 000000010c435001 CR4: 0000000000770ef0
[   59.134223] PKRU: 55555554
[   59.134224] Call Trace:
[   59.134226]  <TASK>
[   59.134230]  ? __pfx_do_flush_tlb_all+0x10/0x10
[   59.134238]  ? __pfx_smp_call_function_many_cond+0x10/0x10
[   59.134242]  ? __pfx___apply_to_page_range+0x10/0x10
[   59.134245]  ? mark_held_locks+0x40/0x70
[   59.134250]  on_each_cpu_cond_mask+0x24/0x40
[   59.134254]  flush_tlb_kernel_range+0x402/0x6b0
[   59.134259]  ? __kasan_release_vmalloc+0xd6/0x110
[   59.134265]  purge_vmap_node+0x1db/0x9c0
[   59.134270]  ? __pfx_smp_call_function_many_cond+0x10/0x10
[   59.134275]  ? __pfx_purge_vmap_node+0x10/0x10
[   59.134280]  __purge_vmap_area_lazy+0x6ea/0xac0
[   59.134286]  drain_vmap_area_work+0x27/0x40
[   59.134289]  process_one_work+0x800/0x13e0
[   59.134296]  ? __pfx_process_one_work+0x10/0x10
[   59.134298]  ? lock_acquire+0x14e/0x2b0
[   59.134302]  ? lock_is_held_type+0x87/0xf0
[   59.134307]  ? assign_work+0x156/0x390
[   59.134313]  worker_thread+0x5c8/0xfa0
[   59.134319]  ? __pfx_worker_thread+0x10/0x10
[   59.134322]  kthread+0x3bd/0x780
[   59.134327]  ? do_raw_spin_lock+0x128/0x270
[   59.134332]  ? __pfx_kthread+0x10/0x10
[   59.134335]  ? __pfx_kthread+0x10/0x10
[   59.134340]  ? ret_from_fork+0x6e/0x590
[   59.134344]  ? lock_release+0xd4/0x2c0
[   59.134348]  ? __pfx_kthread+0x10/0x10
[   59.134351]  ret_from_fork+0x48c/0x590
[   59.134355]  ? __pfx_ret_from_fork+0x10/0x10
[   59.134359]  ? __pfx_kthread+0x10/0x10
[   59.134363]  ret_from_fork_asm+0x1a/0x30
[   59.134371]  </TASK>
[   59.134374] NMI backtrace for cpu 1
[   59.134380] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
[   59.134385] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   59.134386] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   59.134388] RIP: 0010:_find_first_zero_bit+0x50/0x90
[   59.134394] Code: 48 39 c1 73 25 48 89 fa 48 c1 ea 03 80 3c 32 00 75 26 48 8b 17 48 83 f2 ff 74 dd f3 48 0f bc d2 48 01 d1 48 39 c8 48 0f 47 c1 <48> 83 c4 18 c3 cc cc cc cc c3 cc cc cc cc 48 89 44 24 10 48 89 4c
[   59.134396] RSP: 0018:ffffc9000014fd58 EFLAGS: 00000046
[   59.134400] RAX: 0000000000000004 RBX: ffff888100d3a440 RCX: 0000000000000004
[   59.134402] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: ffff88810e9d22a0
[   59.134403] RBP: ffffc9000014fe60 R08: ffff88810e9d1840 R09: ffff8881396e0000
[   59.134405] R10: 0000000080000000 R11: 0000000000000004 R12: ffff88810e9d1840
[   59.134407] R13: ffff8881520ba000 R14: ffff88810e9d22a0 R15: ffff8881396e0000
[   59.134409] FS:  0000000000000000(0000) GS:ffff8881bf85b000(0000) knlGS:0000000000000000
[   59.134413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.134414] CR2: 00007f72301a8d58 CR3: 000000010ed2f005 CR4: 0000000000770ef0
[   59.134416] PKRU: 55555554
[   59.134417] Call Trace:
[   59.134420]  <TASK>
[   59.134423]  __schedule+0x3312/0x4390
[   59.134430]  ? __pfx___schedule+0x10/0x10
[   59.134434]  ? trace_rcu_watching+0x105/0x150
[   59.134440]  schedule_idle+0x59/0x90
[   59.134443]  do_idle+0x26b/0x4d0
[   59.134449]  ? __pfx_do_idle+0x10/0x10
[   59.134452]  ? do_idle+0x278/0x4d0
[   59.134456]  cpu_startup_entry+0x53/0x70
[   59.134459]  start_secondary+0x1b9/0x230
[   59.134463]  common_startup_64+0x12c/0x138
[   59.134472]  </TASK>
[   59.134474] NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20
[   59.135160] Kernel panic - not syncing: Hard LOCKUP
[   59.135163] CPU: 2 UID: 0 PID: 127 Comm: test_progs Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
[   59.135167] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   59.135169] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   59.135170] Call Trace:
[   59.135173]  <NMI>
[   59.135174]  dump_stack_lvl+0x5d/0x80
[   59.135179]  vpanic+0x133/0x3f0
[   59.135185]  panic+0xce/0xce
[   59.135188]  ? __pfx_panic+0x10/0x10
[   59.135193]  ? _printk+0xc7/0x100
[   59.135198]  ? nmi_panic+0x91/0x130
[   59.135202]  nmi_panic.cold+0x14/0x14
[   59.135206]  ? __pfx_nmi_panic+0x10/0x10
[   59.135209]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[   59.135214]  watchdog_hardlockup_check.cold+0x12a/0x1c5
[   59.135220]  __perf_event_overflow+0x2fe/0xeb0
[   59.135226]  ? __pfx___perf_event_overflow+0x10/0x10
[   59.135229]  ? __pfx_x86_perf_event_set_period+0x10/0x10
[   59.135235]  handle_pmi_common+0x405/0x920
[   59.135240]  ? __pfx_handle_pmi_common+0x10/0x10
[   59.135253]  ? __pfx_intel_bts_interrupt+0x10/0x10
[   59.135259]  intel_pmu_handle_irq+0x1c5/0x5d0
[   59.135263]  ? lock_acquire+0x1e9/0x2b0
[   59.135266]  ? nmi_handle.part.0+0x2f/0x370
[   59.135271]  perf_event_nmi_handler+0x3e/0x70
[   59.135275]  nmi_handle.part.0+0x13f/0x370
[   59.135278]  ? trace_rcu_watching+0x105/0x150
[   59.135283]  default_do_nmi+0x3b/0x110
[   59.135287]  ? irqentry_nmi_enter+0x6f/0x80
[   59.135291]  exc_nmi+0xe3/0x110
[   59.135294]  end_repeat_nmi+0xf/0x53
[   59.135297] RIP: 0010:queued_spin_lock_slowpath+0x3a9/0xac0
[   59.135301] Code: 00 00 85 c0 74 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 <41> 0f b6 04 24 44 38 e8 7f 08 84 c0 0f 85 9f 05 00 00 0f b6 03 84
[   59.135303] RSP: 0018:ffffc900012df750 EFLAGS: 00000002
[   59.135305] RAX: 0000000000000001 RBX: ffff8881520ba000 RCX: 0000000000000001
[   59.135307] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881520ba000
[   59.135309] RBP: 1ffff9200025beec R08: ffffffff8fbfcb69 R09: ffffed102a417400
[   59.135311] R10: ffffed102a417401 R11: 0000000000000004 R12: ffffed102a417400
[   59.135313] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881520ba000
[   59.135316]  ? queued_spin_lock_slowpath+0x339/0xac0
[   59.135321]  ? queued_spin_lock_slowpath+0x3a9/0xac0
[   59.135325]  ? queued_spin_lock_slowpath+0x3a9/0xac0
[   59.135329]  </NMI>
[   59.135330]  <TASK>
[   59.135332]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   59.135338]  do_raw_spin_lock+0x1d9/0x270
[   59.135342]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   59.135346]  ? __pfx___might_resched+0x10/0x10
[   59.135350]  task_rq_lock+0xcf/0x3c0
[   59.135355]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   59.135359]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   59.135364]  ? lock_acquire+0x14e/0x2b0
[   59.135368]  ? mark_held_locks+0x40/0x70
[   59.135372]  sched_mm_cid_fork+0x6da/0xc20
[   59.135376]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   59.135379]  ? copy_process+0x217b/0x6950
[   59.135383]  copy_process+0x2bce/0x6950
[   59.135389]  ? __pfx_copy_process+0x10/0x10
[   59.135391]  ? find_held_lock+0x2b/0x80
[   59.135396]  ? _copy_from_user+0x53/0xa0
[   59.135401]  kernel_clone+0xce/0x600
[   59.135404]  ? __pfx_kernel_clone+0x10/0x10
[   59.135409]  ? __lock_acquire+0x481/0x2590
[   59.135414]  __do_sys_clone3+0x16e/0x1b0
[   59.135417]  ? __pfx___do_sys_clone3+0x10/0x10
[   59.135419]  ? lock_acquire+0x14e/0x2b0
[   59.135422]  ? __might_fault+0x9b/0x140
[   59.135429]  ? _copy_to_user+0x5c/0x70
[   59.135432]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   59.135438]  ? do_user_addr_fault+0x4c2/0xa40
[   59.135441]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   59.135445]  do_syscall_64+0x6b/0x3a0
[   59.135448]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.135451] RIP: 0033:0x7f7230c42c5d
[   59.135453] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   59.135455] RSP: 002b:00007ffe90d4e1f8 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   59.135458] RAX: ffffffffffffffda RBX: 00007f7230bb5720 RCX: 00007f7230c42c5d
[   59.135459] RDX: 00007f7230bb5720 RSI: 0000000000000058 RDI: 00007ffe90d4e250
[   59.135461] RBP: 00007ffe90d4e230 R08: 00007f722f1a66c0 R09: 00007ffe90d4e357
[   59.135462] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f722f1a66c0
[   59.135464] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007ffe90d4e250
[   59.135470]  </TASK>
[   60.170882]
[   60.170886] ================================
[   60.170888] WARNING: inconsistent lock state
[   60.170890] 6.19.0-rc5-gbe9790cb9e63-dirty #1 Tainted: G           OE
[   60.170893] --------------------------------
[   60.170894] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[   60.170895] test_progs/127 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   60.170899] ffffffff90eace78 (&nmi_desc[NMI_LOCAL].lock){....}-{2:2}, at: __register_nmi_handler+0x83/0x350
[   60.170912] {INITIAL USE} state was registered at:
[   60.170913]   lock_acquire+0x14e/0x2b0
[   60.170918]   _raw_spin_lock_irqsave+0x39/0x60
[   60.170921]   __register_nmi_handler+0x83/0x350
[   60.170924]   init_hw_perf_events+0x1d0/0x850
[   60.170929]   do_one_initcall+0xd0/0x3a0
[   60.170934]   kernel_init_freeable+0x34c/0x580
[   60.170937]   kernel_init+0x1c/0x150
[   60.170939]   ret_from_fork+0x48c/0x590
[   60.170942]   ret_from_fork_asm+0x1a/0x30
[   60.170945] irq event stamp: 687092
[   60.170946] hardirqs last  enabled at (687091): [<ffffffff8fbfbf78>] _raw_spin_unlock_irq+0x28/0x50
[   60.170950] hardirqs last disabled at (687092): [<ffffffff8fbfbd11>] _raw_spin_lock_irqsave+0x51/0x60
[   60.170952] softirqs last  enabled at (687006): [<ffffffff8d345e2a>] fpu_clone+0xda/0x4f0
[   60.170956] softirqs last disabled at (687004): [<ffffffff8d345dd2>] fpu_clone+0x82/0x4f0
[   60.170959]
[   60.170959] other info that might help us debug this:
[   60.170961]  Possible unsafe locking scenario:
[   60.170961]
[   60.170962]        CPU0
[   60.170963]        ----
[   60.170963]   lock(&nmi_desc[NMI_LOCAL].lock);
[   60.170965]   <Interrupt>
[   60.170966]     lock(&nmi_desc[NMI_LOCAL].lock);
[   60.170968]
[   60.170968]  *** DEADLOCK ***
[   60.170968]
[   60.170969] 5 locks held by test_progs/127:
[   60.170970]  #0: ffffffff90f49790 (scx_fork_rwsem){.+.+}-{0:0}, at: sched_fork+0xf9/0x6b0
[   60.170978]  #1: ffff88810e9d1968 (&mm->mm_cid.mutex){+.+.}-{4:4}, at: sched_mm_cid_fork+0xdf/0xc20
[   60.170983]  #2: ffffffff91671a80 (rcu_read_lock){....}-{1:3}, at: sched_mm_cid_fork+0x692/0xc20
[   60.170989]  #3: ffff88810cfbaed0 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x3c0
[   60.170995]  #4: ffff8881520ba018 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0xcf/0x3c0
[   60.171001]
[   60.171001] stack backtrace:
[   60.171004] CPU: 2 UID: 0 PID: 127 Comm: test_progs Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
[   60.171009] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   60.171011] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   60.171013] Call Trace:
[   60.171016]  <NMI>
[   60.171020]  dump_stack_lvl+0x5d/0x80
[   60.171024]  print_usage_bug.part.0+0x22b/0x2c0
[   60.171029]  lock_acquire+0x272/0x2b0
[   60.171032]  ? __register_nmi_handler+0x83/0x350
[   60.171037]  _raw_spin_lock_irqsave+0x39/0x60
[   60.171040]  ? __register_nmi_handler+0x83/0x350
[   60.171043]  __register_nmi_handler+0x83/0x350
[   60.171048]  native_stop_other_cpus+0x31c/0x460
[   60.171052]  ? __pfx_native_stop_other_cpus+0x10/0x10
[   60.171057]  vpanic+0x1c5/0x3f0
[   60.171060]  panic+0xce/0xce
[   60.171064]  ? __pfx_panic+0x10/0x10
[   60.171068]  ? _printk+0xc7/0x100
[   60.171072]  ? nmi_panic+0x91/0x130
[   60.171075]  nmi_panic.cold+0x14/0x14
[   60.171078]  ? __pfx_nmi_panic+0x10/0x10
[   60.171081]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[   60.171085]  watchdog_hardlockup_check.cold+0x12a/0x1c5
[   60.171090]  __perf_event_overflow+0x2fe/0xeb0
[   60.171094]  ? __pfx___perf_event_overflow+0x10/0x10
[   60.171097]  ? __pfx_x86_perf_event_set_period+0x10/0x10
[   60.171102]  handle_pmi_common+0x405/0x920
[   60.171105]  ? __pfx_handle_pmi_common+0x10/0x10
[   60.171115]  ? __pfx_intel_bts_interrupt+0x10/0x10
[   60.171120]  intel_pmu_handle_irq+0x1c5/0x5d0
[   60.171123]  ? lock_acquire+0x1e9/0x2b0
[   60.171127]  ? nmi_handle.part.0+0x2f/0x370
[   60.171130]  perf_event_nmi_handler+0x3e/0x70
[   60.171133]  nmi_handle.part.0+0x13f/0x370
[   60.171135]  ? trace_rcu_watching+0x105/0x150
[   60.171141]  default_do_nmi+0x3b/0x110
[   60.171144]  ? irqentry_nmi_enter+0x6f/0x80
[   60.171147]  exc_nmi+0xe3/0x110
[   60.171150]  end_repeat_nmi+0xf/0x53
[   60.171154] RIP: 0010:queued_spin_lock_slowpath+0x3a9/0xac0
[   60.171158] Code: 00 00 85 c0 74 3d 0f b6 03 84 c0 74 36 48 b8 00 00 00 00 00 fc ff df 49 89 dc 49 89 dd 49 c1 ec 03 41 83 e5 07 49 01 c4 f3 90 <41> 0f b6 04 24 44 38 e8 7f 08 84 c0 0f 85 9f 05 00 00 0f b6 03 84
[   60.171160] RSP: 0018:ffffc900012df750 EFLAGS: 00000002
[   60.171163] RAX: 0000000000000001 RBX: ffff8881520ba000 RCX: 0000000000000001
[   60.171165] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881520ba000
[   60.171167] RBP: 1ffff9200025beec R08: ffffffff8fbfcb69 R09: ffffed102a417400
[   60.171168] R10: ffffed102a417401 R11: 0000000000000004 R12: ffffed102a417400
[   60.171170] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881520ba000
[   60.171173]  ? queued_spin_lock_slowpath+0x339/0xac0
[   60.171178]  ? queued_spin_lock_slowpath+0x3a9/0xac0
[   60.171181]  ? queued_spin_lock_slowpath+0x3a9/0xac0
[   60.171184]  </NMI>
[   60.171185]  <TASK>
[   60.171187]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   60.171192]  do_raw_spin_lock+0x1d9/0x270
[   60.171197]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   60.171200]  ? __pfx___might_resched+0x10/0x10
[   60.171204]  task_rq_lock+0xcf/0x3c0
[   60.171209]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   60.171212]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   60.171216]  ? lock_acquire+0x14e/0x2b0
[   60.171220]  ? mark_held_locks+0x40/0x70
[   60.171224]  sched_mm_cid_fork+0x6da/0xc20
[   60.171227]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   60.171230]  ? copy_process+0x217b/0x6950
[   60.171233]  copy_process+0x2bce/0x6950
[   60.171238]  ? __pfx_copy_process+0x10/0x10
[   60.171241]  ? find_held_lock+0x2b/0x80
[   60.171245]  ? _copy_from_user+0x53/0xa0
[   60.171251]  kernel_clone+0xce/0x600
[   60.171254]  ? __pfx_kernel_clone+0x10/0x10
[   60.171258]  ? __lock_acquire+0x481/0x2590
[   60.171262]  __do_sys_clone3+0x16e/0x1b0
[   60.171265]  ? __pfx___do_sys_clone3+0x10/0x10
[   60.171267]  ? lock_acquire+0x14e/0x2b0
[   60.171270]  ? __might_fault+0x9b/0x140
[   60.171276]  ? _copy_to_user+0x5c/0x70
[   60.171280]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   60.171285]  ? do_user_addr_fault+0x4c2/0xa40
[   60.171289]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   60.171292]  do_syscall_64+0x6b/0x3a0
[   60.171295]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   60.171298] RIP: 0033:0x7f7230c42c5d
[   60.171300] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   60.171302] RSP: 002b:00007ffe90d4e1f8 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   60.171305] RAX: ffffffffffffffda RBX: 00007f7230bb5720 RCX: 00007f7230c42c5d
[   60.171307] RDX: 00007f7230bb5720 RSI: 0000000000000058 RDI: 00007ffe90d4e250
[   60.171309] RBP: 00007ffe90d4e230 R08: 00007f722f1a66c0 R09: 00007ffe90d4e357
[   60.171310] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f722f1a66c0
[   60.171312] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007ffe90d4e250
[   60.171316]  </TASK>
[   60.171319] Shutting down cpus with NMI
[   60.171381] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)



> 
> Thank you for investigating!
> 
> 
>>
>> Thanks,
>>
>>         tglx
>> ---
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10664,8 +10664,14 @@ void sched_mm_cid_exit(struct task_struc
>>  			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
>>  				if (!__sched_mm_cid_exit(t))
>>  					return;
>> -				/* Mode change required. Transfer currents CID */
>> -				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
>> +				/*
>> +				 * Mode change. The task has the CID unset
>> +				 * already. The CPU CID is still valid and
>> +				 * does not have MM_CID_TRANSIT set as the
>> +				 * mode change has just taken effect under
>> +				 * mm::mm_cid::lock. Drop it.
>> +				 */
>> +				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
>>  			}
>>  			mm_cid_fixup_cpus_to_tasks(mm);
>>  			return;
> 

