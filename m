Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF12745E;
	Wed, 28 Jan 2026 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558497; cv=none; b=rJL5vUt7PJ77ptrds3BdtKa3K75WzJrivbZZusX5ur18U+uiJLuK7MYAXuzXh3OEtAiaE8v38rc4LubxyttRyQAlaX+NOcGYvb50kNB9CTB0IjH9iVfmuIM9RQPdN92UbPVzOkmPGX/r4ETy/Ls5HVVoep0651d6X2Y9mGdR1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558497; c=relaxed/simple;
	bh=O8Fb0Ldk3MAS25YsvEtXfzMl3Da2GO4IbpLL7qW2tDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F61WjP/a7LzSn6Ck7uojxya0SvaJZNBdjsc9+tRueqEr3BHWw6kJJJ3he9eXI1dO5+ypdXf5LlCNvh0m79KjQGdmcv3U1Yd+qT7fNQZfjKZtggJHVIjB4Csn2TF0pXQ7sLSxz+o3docqPb64YXti4Vu9f9+RY0dg/pOHY/B9h+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EWwc1jT7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EWwc1jT7"
Message-ID: <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769558483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8YbPVSRBfr1Pq7lZZ5KHrcaX8HrXjpOif85fuoyOPo=;
	b=EWwc1jT7OoPIDNYZ413zF26Zg1D0OLcxG2Bo/4M721L0E9gNeNtBqFv3kNpwb/wRfDYpJ0
	3nP/ZnIDNZ4KcRIzRioErYGNmVDjbIBYepaoVWgaaA7HG8bCb0yToB45sy6m+Y4/rwvPmH
	FbX1AtAbXE3oel5JDXO2SIYTZJazSzo=
Date: Tue, 27 Jan 2026 16:01:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev,
 Kernel Team <kernel-team@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Puranjay Mohan <puranjay@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20251119171016.815482037@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251119171016.815482037@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/19/25 9:26 AM, Thomas Gleixner wrote:
> This is a follow up on the V4 series which can be found here:
> 
>     https://lore.kernel.org/20251104075053.700034556@linutronix.de
> 
> The V1 cover letter contains a detailed analyisis of the issues:
> 
>     https://lore.kernel.org/20251015164952.694882104@linutronix.de
> 
> TLDR: The CID management is way to complex and adds significant overhead
> into scheduler hotpaths.
> 
> The series rewrites MM CID management in a more simplistic way which
> focusses on low overhead in the scheduler while maintaining per task CIDs
> as long as the number of threads is not exceeding the number of possible
> CPUs.

Hello Thomas, everyone.

BPF CI caught a deadlock on current bpf-next tip (35538dba51b4).
Job: https://github.com/kernel-patches/bpf/actions/runs/21417415035/job/61670254640

It appears to be related to this series. Pasting a splat below.

Any ideas what might be going on?

Thanks!

[   45.009755] watchdog: CPU2: Watchdog detected hard LOCKUP on cpu 2
[   45.009763] Modules linked in: bpf_testmod(OE)
[   45.009769] irq event stamp: 685710
[   45.009771] hardirqs last  enabled at (685709): [<ffffffffb5bfa8b8>] _raw_spin_unlock_irq+0x28/0x50
[   45.009786] hardirqs last disabled at (685710): [<ffffffffb5bfa651>] _raw_spin_lock_irqsave+0x51/0x60
[   45.009789] softirqs last  enabled at (685650): [<ffffffffb3345e2a>] fpu_clone+0xda/0x4f0
[   45.009795] softirqs last disabled at (685648): [<ffffffffb3345dd2>] fpu_clone+0x82/0x4f0
[   45.009803] CPU: 2 UID: 0 PID: 126 Comm: test_progs Tainted: G           OE       6.19.0-rc5-g748c6d52700a-dirty #1 PREEMPT(full)
[   45.009808] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   45.009810] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   45.009813] RIP: 0010:queued_spin_lock_slowpath+0x6cc/0xac0
[   45.009820] Code: 0c 24 8b 03 66 85 c0 74 38 48 b8 00 00 00 00 00 fc ff df 48 89 da 49 89 de 48 c1 ea 03 41 83 e6 07 48 01 c2 41 83 c6 03 f3 90 <0f> b6 02 41 38 c6 7c 08 84 c0 0f 85 90 02 00 00 8b 03 66 85 c0 75
[   45.009823] RSP: 0018:ffffc9000128f750 EFLAGS: 00000002
[   45.009828] RAX: 0000000000100101 RBX: ffff8881520ba000 RCX: 0000000000000000
[   45.009830] RDX: ffffed102a417400 RSI: 0000000000000002 RDI: ffff8881520ba002
[   45.009832] RBP: 1ffff92000251eec R08: ffffffffb5bfb6c9 R09: ffffed102a417400
[   45.009834] R10: ffffed102a417401 R11: 0000000000000004 R12: ffff88815213b100
[   45.009836] R13: 00000000000c0000 R14: 0000000000000003 R15: 0000000000000002
[   45.009838] FS:  00007f6ab3e0de00(0000) GS:ffff8881998dd000(0000) knlGS:0000000000000000
[   45.009841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.009843] CR2: 00007f6ab2873d58 CR3: 0000000103357005 CR4: 0000000000770ef0
[   45.009845] PKRU: 55555554
[   45.009846] Call Trace:
[   45.009850]  <TASK>
[   45.009855]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   45.009862]  do_raw_spin_lock+0x1d9/0x270
[   45.009868]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   45.009871]  ? __pfx___might_resched+0x10/0x10
[   45.009878]  task_rq_lock+0xcf/0x3c0
[   45.009884]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   45.009888]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   45.009892]  ? lock_acquire+0x14e/0x2b0
[   45.009896]  ? mark_held_locks+0x40/0x70
[   45.009901]  sched_mm_cid_fork+0x6da/0xc20
[   45.009905]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   45.009908]  ? copy_process+0x217b/0x6950
[   45.009913]  copy_process+0x2bce/0x6950
[   45.009919]  ? __pfx_copy_process+0x10/0x10
[   45.009921]  ? find_held_lock+0x2b/0x80
[   45.009926]  ? _copy_from_user+0x53/0xa0
[   45.009933]  kernel_clone+0xce/0x600
[   45.009937]  ? __pfx_kernel_clone+0x10/0x10
[   45.009942]  ? __lock_acquire+0x481/0x2590
[   45.009947]  __do_sys_clone3+0x16e/0x1b0
[   45.009950]  ? __pfx___do_sys_clone3+0x10/0x10
[   45.009952]  ? lock_acquire+0x14e/0x2b0
[   45.009955]  ? __might_fault+0x9b/0x140
[   45.009963]  ? _copy_to_user+0x5c/0x70
[   45.009967]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   45.009974]  ? do_user_addr_fault+0x4c2/0xa40
[   45.009978]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   45.009982]  do_syscall_64+0x6b/0x3a0
[   45.009988]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.009992] RIP: 0033:0x7f6ab430fc5d
[   45.009996] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   45.009998] RSP: 002b:00007fffb282a148 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   45.010002] RAX: ffffffffffffffda RBX: 00007f6ab4282720 RCX: 00007f6ab430fc5d
[   45.010004] RDX: 00007f6ab4282720 RSI: 0000000000000058 RDI: 00007fffb282a1a0
[   45.010005] RBP: 00007fffb282a180 R08: 00007f6ab28736c0 R09: 00007fffb282a2a7
[   45.010007] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f6ab28736c0
[   45.010009] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007fffb282a1a0
[   45.010015]  </TASK>
[   45.010018] Kernel panic - not syncing: Hard LOCKUP
[   45.010020] CPU: 2 UID: 0 PID: 126 Comm: test_progs Tainted: G           OE       6.19.0-rc5-g748c6d52700a-dirty #1 PREEMPT(full)
[   45.010025] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   45.010026] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   45.010027] Call Trace:
[   45.010029]  <NMI>
[   45.010031]  dump_stack_lvl+0x5d/0x80
[   45.010036]  vpanic+0x133/0x3f0
[   45.010042]  panic+0xce/0xce
[   45.010045]  ? __pfx_panic+0x10/0x10
[   45.010050]  ? __show_trace_log_lvl+0x2ee/0x323
[   45.010053]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.010057]  ? nmi_panic+0x91/0x130
[   45.010061]  nmi_panic.cold+0x14/0x14
[   45.010065]  ? __pfx_nmi_panic+0x10/0x10
[   45.010070]  watchdog_hardlockup_check.cold+0x12a/0x1c5
[   45.010076]  __perf_event_overflow+0x2fe/0xeb0
[   45.010082]  ? __pfx___perf_event_overflow+0x10/0x10
[   45.010085]  ? __pfx_x86_perf_event_set_period+0x10/0x10
[   45.010091]  handle_pmi_common+0x405/0x920
[   45.010096]  ? __pfx_handle_pmi_common+0x10/0x10
[   45.010109]  ? __pfx_intel_bts_interrupt+0x10/0x10
[   45.010115]  intel_pmu_handle_irq+0x1c5/0x5d0
[   45.010119]  ? lock_acquire+0x1e9/0x2b0
[   45.010122]  ? nmi_handle.part.0+0x2f/0x370
[   45.010127]  perf_event_nmi_handler+0x3e/0x70
[   45.010130]  nmi_handle.part.0+0x13f/0x370
[   45.010134]  ? trace_rcu_watching+0x105/0x150
[   45.010140]  default_do_nmi+0x3b/0x110
[   45.010144]  ? irqentry_nmi_enter+0x6f/0x80
[   45.010147]  exc_nmi+0xe3/0x110
[   45.010151]  end_repeat_nmi+0xf/0x53
[   45.010154] RIP: 0010:queued_spin_lock_slowpath+0x6cc/0xac0
[   45.010157] Code: 0c 24 8b 03 66 85 c0 74 38 48 b8 00 00 00 00 00 fc ff df 48 89 da 49 89 de 48 c1 ea 03 41 83 e6 07 48 01 c2 41 83 c6 03 f3 90 <0f> b6 02 41 38 c6 7c 08 84 c0 0f 85 90 02 00 00 8b 03 66 85 c0 75
[   45.010159] RSP: 0018:ffffc9000128f750 EFLAGS: 00000002
[   45.010162] RAX: 0000000000100101 RBX: ffff8881520ba000 RCX: 0000000000000000
[   45.010164] RDX: ffffed102a417400 RSI: 0000000000000002 RDI: ffff8881520ba002
[   45.010165] RBP: 1ffff92000251eec R08: ffffffffb5bfb6c9 R09: ffffed102a417400
[   45.010167] R10: ffffed102a417401 R11: 0000000000000004 R12: ffff88815213b100
[   45.010169] R13: 00000000000c0000 R14: 0000000000000003 R15: 0000000000000002
[   45.010172]  ? queued_spin_lock_slowpath+0x559/0xac0
[   45.010177]  ? queued_spin_lock_slowpath+0x6cc/0xac0
[   45.010181]  ? queued_spin_lock_slowpath+0x6cc/0xac0
[   45.010185]  </NMI>
[   45.010186]  <TASK>
[   45.010187]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   45.010194]  do_raw_spin_lock+0x1d9/0x270
[   45.010198]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   45.010201]  ? __pfx___might_resched+0x10/0x10
[   45.010206]  task_rq_lock+0xcf/0x3c0
[   45.010211]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   45.010215]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   45.010219]  ? lock_acquire+0x14e/0x2b0
[   45.010223]  ? mark_held_locks+0x40/0x70
[   45.010228]  sched_mm_cid_fork+0x6da/0xc20
[   45.010232]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   45.010234]  ? copy_process+0x217b/0x6950
[   45.010238]  copy_process+0x2bce/0x6950
[   45.010245]  ? __pfx_copy_process+0x10/0x10
[   45.010247]  ? find_held_lock+0x2b/0x80
[   45.010251]  ? _copy_from_user+0x53/0xa0
[   45.010256]  kernel_clone+0xce/0x600
[   45.010259]  ? __pfx_kernel_clone+0x10/0x10
[   45.010264]  ? __lock_acquire+0x481/0x2590
[   45.010269]  __do_sys_clone3+0x16e/0x1b0
[   45.010272]  ? __pfx___do_sys_clone3+0x10/0x10
[   45.010274]  ? lock_acquire+0x14e/0x2b0
[   45.010277]  ? __might_fault+0x9b/0x140
[   45.010284]  ? _copy_to_user+0x5c/0x70
[   45.010288]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   45.010293]  ? do_user_addr_fault+0x4c2/0xa40
[   45.010296]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   45.010300]  do_syscall_64+0x6b/0x3a0
[   45.010305]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.010307] RIP: 0033:0x7f6ab430fc5d
[   45.010309] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   45.010311] RSP: 002b:00007fffb282a148 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   45.010314] RAX: ffffffffffffffda RBX: 00007f6ab4282720 RCX: 00007f6ab430fc5d
[   45.010316] RDX: 00007f6ab4282720 RSI: 0000000000000058 RDI: 00007fffb282a1a0
[   45.010317] RBP: 00007fffb282a180 R08: 00007f6ab28736c0 R09: 00007fffb282a2a7
[   45.010319] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f6ab28736c0
[   45.010320] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007fffb282a1a0
[   45.010326]  </TASK>
[   46.053092]
[   46.053095] ================================
[   46.053096] WARNING: inconsistent lock state
[   46.053098] 6.19.0-rc5-g748c6d52700a-dirty #1 Tainted: G           OE
[   46.053101] --------------------------------
[   46.053102] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[   46.053103] test_progs/126 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   46.053107] ffffffffb6eace78 (&nmi_desc[NMI_LOCAL].lock){....}-{2:2}, at: __register_nmi_handler+0x83/0x350
[   46.053119] {INITIAL USE} state was registered at:
[   46.053120]   lock_acquire+0x14e/0x2b0
[   46.053123]   _raw_spin_lock_irqsave+0x39/0x60
[   46.053127]   __register_nmi_handler+0x83/0x350
[   46.053130]   init_hw_perf_events+0x1d0/0x850
[   46.053135]   do_one_initcall+0xd0/0x3a0
[   46.053138]   kernel_init_freeable+0x34c/0x580
[   46.053141]   kernel_init+0x1c/0x150
[   46.053145]   ret_from_fork+0x48c/0x590
[   46.053149]   ret_from_fork_asm+0x1a/0x30
[   46.053151] irq event stamp: 685710
[   46.053153] hardirqs last  enabled at (685709): [<ffffffffb5bfa8b8>] _raw_spin_unlock_irq+0x28/0x50
[   46.053156] hardirqs last disabled at (685710): [<ffffffffb5bfa651>] _raw_spin_lock_irqsave+0x51/0x60
[   46.053159] softirqs last  enabled at (685650): [<ffffffffb3345e2a>] fpu_clone+0xda/0x4f0
[   46.053163] softirqs last disabled at (685648): [<ffffffffb3345dd2>] fpu_clone+0x82/0x4f0
[   46.053166]
[   46.053166] other info that might help us debug this:
[   46.053168]  Possible unsafe locking scenario:
[   46.053168]
[   46.053168]        CPU0
[   46.053169]        ----
[   46.053170]   lock(&nmi_desc[NMI_LOCAL].lock);
[   46.053172]   <Interrupt>
[   46.053173]     lock(&nmi_desc[NMI_LOCAL].lock);
[   46.053174]
[   46.053174]  *** DEADLOCK ***
[   46.053174]
[   46.053175] 5 locks held by test_progs/126:
[   46.053177]  #0: ffffffffb6f49790 (scx_fork_rwsem){.+.+}-{0:0}, at: sched_fork+0xf9/0x6b0
[   46.053184]  #1: ffff88810c4930e8 (&mm->mm_cid.mutex){+.+.}-{4:4}, at: sched_mm_cid_fork+0xdf/0xc20
[   46.053190]  #2: ffffffffb7671a80 (rcu_read_lock){....}-{1:3}, at: sched_mm_cid_fork+0x692/0xc20
[   46.053195]  #3: ffff888110548a90 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x3c0
[   46.053201]  #4: ffff8881520ba018 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0xcf/0x3c0
[   46.053207]
[   46.053207] stack backtrace:
[   46.053209] CPU: 2 UID: 0 PID: 126 Comm: test_progs Tainted: G           OE       6.19.0-rc5-g748c6d52700a-dirty #1 PREEMPT(full)
[   46.053214] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   46.053215] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   46.053217] Call Trace:
[   46.053220]  <NMI>
[   46.053223]  dump_stack_lvl+0x5d/0x80
[   46.053227]  print_usage_bug.part.0+0x22b/0x2c0
[   46.053231]  lock_acquire+0x272/0x2b0
[   46.053235]  ? __register_nmi_handler+0x83/0x350
[   46.053240]  _raw_spin_lock_irqsave+0x39/0x60
[   46.053242]  ? __register_nmi_handler+0x83/0x350
[   46.053246]  __register_nmi_handler+0x83/0x350
[   46.053250]  native_stop_other_cpus+0x31c/0x460
[   46.053255]  ? __pfx_native_stop_other_cpus+0x10/0x10
[   46.053260]  vpanic+0x1c5/0x3f0
[   46.053265]  panic+0xce/0xce
[   46.053268]  ? __pfx_panic+0x10/0x10
[   46.053272]  ? __show_trace_log_lvl+0x2ee/0x323
[   46.053276]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   46.053279]  ? nmi_panic+0x91/0x130
[   46.053283]  nmi_panic.cold+0x14/0x14
[   46.053287]  ? __pfx_nmi_panic+0x10/0x10
[   46.053291]  watchdog_hardlockup_check.cold+0x12a/0x1c5
[   46.053296]  __perf_event_overflow+0x2fe/0xeb0
[   46.053300]  ? __pfx___perf_event_overflow+0x10/0x10
[   46.053303]  ? __pfx_x86_perf_event_set_period+0x10/0x10
[   46.053308]  handle_pmi_common+0x405/0x920
[   46.053312]  ? __pfx_handle_pmi_common+0x10/0x10
[   46.053322]  ? __pfx_intel_bts_interrupt+0x10/0x10
[   46.053327]  intel_pmu_handle_irq+0x1c5/0x5d0
[   46.053330]  ? lock_acquire+0x1e9/0x2b0
[   46.053334]  ? nmi_handle.part.0+0x2f/0x370
[   46.053337]  perf_event_nmi_handler+0x3e/0x70
[   46.053340]  nmi_handle.part.0+0x13f/0x370
[   46.053343]  ? trace_rcu_watching+0x105/0x150
[   46.053348]  default_do_nmi+0x3b/0x110
[   46.053351]  ? irqentry_nmi_enter+0x6f/0x80
[   46.053355]  exc_nmi+0xe3/0x110
[   46.053358]  end_repeat_nmi+0xf/0x53
[   46.053361] RIP: 0010:queued_spin_lock_slowpath+0x6cc/0xac0
[   46.053365] Code: 0c 24 8b 03 66 85 c0 74 38 48 b8 00 00 00 00 00 fc ff df 48 89 da 49 89 de 48 c1 ea 03 41 83 e6 07 48 01 c2 41 83 c6 03 f3 90 <0f> b6 02 41 38 c6 7c 08 84 c0 0f 85 90 02 00 00 8b 03 66 85 c0 75
[   46.053367] RSP: 0018:ffffc9000128f750 EFLAGS: 00000002
[   46.053370] RAX: 0000000000100101 RBX: ffff8881520ba000 RCX: 0000000000000000
[   46.053372] RDX: ffffed102a417400 RSI: 0000000000000002 RDI: ffff8881520ba002
[   46.053374] RBP: 1ffff92000251eec R08: ffffffffb5bfb6c9 R09: ffffed102a417400
[   46.053376] R10: ffffed102a417401 R11: 0000000000000004 R12: ffff88815213b100
[   46.053378] R13: 00000000000c0000 R14: 0000000000000003 R15: 0000000000000002
[   46.053380]  ? queued_spin_lock_slowpath+0x559/0xac0
[   46.053385]  ? queued_spin_lock_slowpath+0x6cc/0xac0
[   46.053389]  ? queued_spin_lock_slowpath+0x6cc/0xac0
[   46.053392]  </NMI>
[   46.053393]  <TASK>
[   46.053394]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   46.053400]  do_raw_spin_lock+0x1d9/0x270
[   46.053404]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   46.053407]  ? __pfx___might_resched+0x10/0x10
[   46.053411]  task_rq_lock+0xcf/0x3c0
[   46.053416]  mm_cid_fixup_task_to_cpu+0xb0/0x460
[   46.053420]  ? __pfx_mm_cid_fixup_task_to_cpu+0x10/0x10
[   46.053423]  ? lock_acquire+0x14e/0x2b0
[   46.053427]  ? mark_held_locks+0x40/0x70
[   46.053431]  sched_mm_cid_fork+0x6da/0xc20
[   46.053435]  ? __pfx_sched_mm_cid_fork+0x10/0x10
[   46.053437]  ? copy_process+0x217b/0x6950
[   46.053441]  copy_process+0x2bce/0x6950
[   46.053446]  ? __pfx_copy_process+0x10/0x10
[   46.053448]  ? find_held_lock+0x2b/0x80
[   46.053452]  ? _copy_from_user+0x53/0xa0
[   46.053457]  kernel_clone+0xce/0x600
[   46.053460]  ? __pfx_kernel_clone+0x10/0x10
[   46.053465]  ? __lock_acquire+0x481/0x2590
[   46.053469]  __do_sys_clone3+0x16e/0x1b0
[   46.053472]  ? __pfx___do_sys_clone3+0x10/0x10
[   46.053474]  ? lock_acquire+0x14e/0x2b0
[   46.053477]  ? __might_fault+0x9b/0x140
[   46.053483]  ? _copy_to_user+0x5c/0x70
[   46.053486]  ? __x64_sys_rt_sigprocmask+0x258/0x400
[   46.053491]  ? do_user_addr_fault+0x4c2/0xa40
[   46.053495]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[   46.053498]  do_syscall_64+0x6b/0x3a0
[   46.053503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   46.053506] RIP: 0033:0x7f6ab430fc5d
[   46.053509] Code: 79 14 0e 00 c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
[   46.053511] RSP: 002b:00007fffb282a148 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
[   46.053514] RAX: ffffffffffffffda RBX: 00007f6ab4282720 RCX: 00007f6ab430fc5d
[   46.053516] RDX: 00007f6ab4282720 RSI: 0000000000000058 RDI: 00007fffb282a1a0
[   46.053517] RBP: 00007fffb282a180 R08: 00007f6ab28736c0 R09: 00007fffb282a2a7
[   46.053519] R10: 0000000000000008 R11: 0000000000000202 R12: 00007f6ab28736c0
[   46.053521] R13: ffffffffffffff08 R14: 0000000000000000 R15: 00007fffb282a1a0
[   46.053525]  </TASK>
[   46.053527] Shutting down cpus with NMI
[   46.053722] Kernel Offset: 0x32000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


> 
> [...]

