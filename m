Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14357C9F
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133544; cv=none; b=gZWSsI9/3Gyod4M9BgedrgdH27AyfDihpPtiyvwlDTkfAfaKWPI8shrlx053seKoeJTDLecMp8UxrHRJhOx0HFC8iapxXp5qs45kF4Cg7bkSHY56EGr9RjOQhn8UOH7SpLQW/dvS6Ewx9tVdQpfLoVywSxJ0ruDJEVqPngepaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133544; c=relaxed/simple;
	bh=8/3fOTJx5xEEj6Z9B8A/uzqvatvfn3MHbSzPnMWXCUA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJrRx1PgWRHUtGRH+2E3Rnse1TQFmjgZVRHI/7SYFXyvURfDbr5XD8Jvg7M7YPX00MLvAgwx3V/7yAm/PBAObK0U91EqGHj3yS+icm2/7im6OsiepR9ypXZ+ADTNQ1eDfFewFHHzqnmJypowYcstkVvHVox3j0fLBoPPHi+xxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu+t8+5p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu+t8+5p"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so64801025e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770133540; x=1770738340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXeHy0JOvkNaJyHyKK1MQhE9Nz9nekv3l7wd+hy/824=;
        b=Hu+t8+5pZEounYaAgWiN3QlAoi5GUhdlRTUSIco0ojBcpAq/c5qOagRfz73FG1wlGP
         /KxXQy3lwnnG9kXnaB7ic4qk6fCYifJ23rJuHpu1Laf8p4MuffFdCcJUimgGjtmlOXmR
         weeyyKkG5X0lCx/TCBWaHEy85QfTmnVLeKy2XfgQUaLNQ5P4F7Aqc/8dpz7/7mcyDKHm
         ob56uYqMPbpy/qcJE93ZNOMPO3SATHtM3UUz7UKZIhhIuZPL7Ncy+WAnFllE71uG80tF
         wvWHhui6WQvnTpUhCeBYiyGA4XcyDI2w5xs6jhHU/V/5fZGJi05rI0gVyleSaJdA7HpQ
         56og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133540; x=1770738340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXeHy0JOvkNaJyHyKK1MQhE9Nz9nekv3l7wd+hy/824=;
        b=f8/XDHj1wvI/xf6VU5s6kMvYCBPuntO0IGM1EM4SsDy5dMIzdjgoZU1F4xfnFC0wBS
         EkNe5CfYvArQF4WnvIpJz/F8+ljhlFIuW1PEnbqcPZrfsaqMX2zC89kiQ3T2sURuUMTu
         9chfC8K7bSlXc0vXEuM+MvMYk2j5xRHAaD6qbFIxplZOIFsUWFCDKwpcRlHm8gjpfiDh
         b85tDoZwDrWJIRzF0+v09OIfCKToG9XoRHMs8R4j1jkrxaAZ4+/q3g/R7gkY+K9yM8Mg
         9a5+f1LMD0VftBkvdIcZqNKEBXsHLUpzr8ImrGYSgyRZm77QC/2JI19WNEQX+wT9UeXP
         GL9A==
X-Gm-Message-State: AOJu0YwT5m61+a79RTGy5N+szz3txu49DWIxlCK/OPnnRz6qa3jw6qOC
	MAfp1MpJe6Yeq7H66YmghkEWAMCOyOkwEUKLKKLLqBVaP56eT0SsRVgoW9I7rV5i
X-Gm-Gg: AZuq6aKlltbaWYwQKfSxr2MlA7/QlKU6GvZUvt/8QuvvBlUch2dXm38oMM8rsXGK5vh
	HlOYzSMRJK1fgqj6L13eyFySlabhcgQHeCVMZ+/QkSv2MRUnEzV9xY3cZjPvNaH0vUEI06qAgZp
	4GvomFj2GzMrX3+xDguMk0PztYnWtOCbQe2Kp3JPG4k51LHrqic8ZBj109W5CzYVYZF3jjCoKQP
	eUWmDAqmiDUIXBBFRqpx0ht5E9blx5w6E2TGNZkYs0535lSvaloaoh91FD0iHEXLIgpaN8WAKIn
	JTxMPBBX2NkUFbCtcUk/ho/7n+/oFXviWz6slYo/VjpwG6gu4TwFEWYtuPbt5pim/y/41mR1MEo
	C49Ah5abv9hLfe7KjNw2D7sarQzJA6AozpdseyuynUOJVM55blN2gJMxSSb1OPXaIxIu8mnYORd
	6YN7C5gCtAU4YvoyA=
X-Received: by 2002:a05:600c:19cd:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4830e950d34mr1074905e9.16.1770133539458;
        Tue, 03 Feb 2026 07:45:39 -0800 (PST)
Received: from krava ([2a00:102a:500c:2405:cbd2:15d3:f6ac:c2ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da8d98b8sm143602125e9.1.2026.02.03.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:45:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Feb 2026 16:45:36 +0100
To: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf@vger.kernel.org, dzm91@hust.edu.cn, dddddd@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: INFO: task hung in bpf_trampoline_get
Message-ID: <aYIYIIVE8SYeUHqW@krava>
References: <47f1a0ac.6d7bb.19c2290b99d.Coremail.kaiyanm@hust.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47f1a0ac.6d7bb.19c2290b99d.Coremail.kaiyanm@hust.edu.cn>

On Tue, Feb 03, 2026 at 04:13:55PM +0800, 梅开彦 wrote:
> Our fuzzer discovered a task hung vulnerability in the BPF subsystem. The crash can be trigger on bpf-next(93ce3bee311d6f885bffb4a83843bddbe6b126be). We have not yet been able to develop a stable PoC to reproduce this vulnerability, but we will continue to analyze it further and testing whether it can be triggered on the latest bpf-next branch.
> 

hi,
any idea on what tracing was (or was going to be) enabled?

thanks,
jirka


> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> # Crash Report
> ```
> INFO: task syz.3.43847:258359 blocked for more than 143 seconds.
>       Not tainted 6.18.0-rc4-g93ce3bee311d #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.3.43847     state:D stack:27048 pid:258359 tgid:258358 ppid:255299 task_flags:0x400140 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5325 [inline]
>  __schedule+0x1044/0x5bb0 kernel/sched/core.c:6929
>  __schedule_loop kernel/sched/core.c:7011 [inline]
>  schedule+0xec/0x3b0 kernel/sched/core.c:7026
>  schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:7083
>  __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>  __mutex_lock+0x773/0x1010 kernel/locking/mutex.c:760
>  bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
>  check_attach_btf_id kernel/bpf/verifier.c:24523 [inline]
>  bpf_check+0xb4cc/0xb930 kernel/bpf/verifier.c:25158
>  bpf_prog_load+0x17a6/0x2960 kernel/bpf/syscall.c:3095
>  __sys_bpf+0x1971/0x5390 kernel/bpf/syscall.c:6171
>  __do_sys_bpf kernel/bpf/syscall.c:6281 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6279 [inline]
>  __x64_sys_bpf+0x7d/0xc0 kernel/bpf/syscall.c:6279
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2eea3adead
> RSP: 002b:00007f2eea1f6f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f2eea5e5fa0 RCX: 00007f2eea3adead
> RDX: 0000000000000094 RSI: 0000200000000c00 RDI: 0000000000000005
> RBP: 00007f2eea447d9f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2eea5e5fa0 R15: 00007f2eea1d7000
>  </TASK>
> INFO: task syz.6.43848:258362 blocked for more than 143 seconds.
>       Not tainted 6.18.0-rc4-g93ce3bee311d #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.6.43848     state:D stack:27048 pid:258362 tgid:258361 ppid:253809 task_flags:0x400140 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5325 [inline]
>  __schedule+0x1044/0x5bb0 kernel/sched/core.c:6929
>  __schedule_loop kernel/sched/core.c:7011 [inline]
>  schedule+0xec/0x3b0 kernel/sched/core.c:7026
>  schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:7083
>  __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>  __mutex_lock+0x773/0x1010 kernel/locking/mutex.c:760
>  bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
>  check_attach_btf_id kernel/bpf/verifier.c:24523 [inline]
>  bpf_check+0xb4cc/0xb930 kernel/bpf/verifier.c:25158
>  bpf_prog_load+0x17a6/0x2960 kernel/bpf/syscall.c:3095
>  __sys_bpf+0x1971/0x5390 kernel/bpf/syscall.c:6171
>  __do_sys_bpf kernel/bpf/syscall.c:6281 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6279 [inline]
>  __x64_sys_bpf+0x7d/0xc0 kernel/bpf/syscall.c:6279
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc7c5dadead
> RSP: 002b:00007fc7c6b63f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fc7c5fe5fa0 RCX: 00007fc7c5dadead
> RDX: 0000000000000094 RSI: 0000200000000c00 RDI: 0000000000000005
> RBP: 00007fc7c5e47d9f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc7c5fe5fa0 R15: 00007fc7c6b44000
>  </TASK>
> 
> Showing all locks held in the system:
> 4 locks held by systemd/1:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: do_rmdir+0x1ec/0x3a0 fs/namei.c:4591
>  #1: ff11000109f51528 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
>  #1: ff11000109f51528 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_rmdir+0x236/0x3a0 fs/namei.c:4595
>  #2: ff110001161f1030 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
>  #2: ff110001161f1030 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir fs/namei.c:4537 [inline]
>  #2: ff110001161f1030 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: vfs_rmdir+0xee/0x680 fs/namei.c:4525
>  #3: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #3: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 1 lock held by rcu_tasks_kthre/30:
>  #0: ffffffff8f1c3570 (rcu_tasks.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x70d/0xda0 kernel/rcu/tasks.h:614
> 1 lock held by khungtaskd/35:
>  #0: ffffffff8f1c3da0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8f1c3da0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8f1c3da0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
> 3 locks held by kworker/u10:2/38:
>  #0: ff1100001c4a9948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000000b07d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work+0x8f1/0x1b60 kernel/workqueue.c:3239
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_storage_map_free+0x30/0x240 kernel/bpf/local_storage.c:336
> 1 lock held by sshd/9922:
> 3 locks held by kworker/u9:0/137034:
>  #0: ff1100001c4a9948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b60 kernel/workqueue.c:3238
>  #1: ffa00000046afd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work+0x8f1/0x1b60 kernel/workqueue.c:3239
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_storage_map_free+0x30/0x240 kernel/bpf/local_storage.c:336
> 3 locks held by kworker/0:4/190287:
> 3 locks held by kworker/1:20/194680:
>  #0: ff1100001c45d948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1291/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000003f67d10 (set_printk_work){+.+.}-{0:0}, at: process_one_work+0x8f1/0x1b60 kernel/workqueue.c:3239
>  #2: ffffffff8f2653c8 (event_mutex){+.+.}-{4:4}, at: __ftrace_set_clr_event kernel/trace/trace_events.c:1382 [inline]
>  #2: ffffffff8f2653c8 (event_mutex){+.+.}-{4:4}, at: trace_set_clr_event+0xdd/0x160 kernel/trace/trace_events.c:1461
> 3 locks held by syz.0.43800/258128:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_unlink_prog+0x33/0x510 kernel/bpf/trampoline.c:642
>  #1: ffffffff8f2466c8 (direct_mutex){+.+.}-{4:4}, at: unregister_ftrace_direct+0x11c/0x640 kernel/trace/ftrace.c:6091
>  #2: ffffffff8f246aa8 (ftrace_lock){+.+.}-{4:4}, at: unregister_ftrace_function+0x28/0x420 kernel/trace/ftrace.c:8765
> 1 lock held by syz.3.43847/258359:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.6.43848/258362:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.8.43866/258470:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.7.43922/258720:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.5.43931/258788:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.9.44002/259546:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.2.44005/259601:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.0.44096/261433:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.1.44116/261551:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.3.44168/262581:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.6.44214/263753:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.8.44222/263787:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.7.44228/263808:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 4 locks held by syz.9.44288/264049:
>  #0: ff110001119ac0c8 (&fp->aux->dst_mutex){+.+.}-{4:4}, at: bpf_tracing_prog_attach+0x684/0x1030 kernel/bpf/syscall.c:3648
>  #1: ff11000116834080 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_link_prog+0x2c/0x60 kernel/bpf/trampoline.c:607
>  #2: ff110001168350a0 (&ops->local_hash.regex_lock){+.+.}-{4:4}, at: ftrace_set_hash+0xea/0x830 kernel/trace/ftrace.c:5854
>  #3: ffffffff8f246aa8 (ftrace_lock){+.+.}-{4:4}, at: ftrace_set_hash+0x353/0x830 kernel/trace/ftrace.c:5889
> 4 locks held by syz.5.44299/264182:
>  #0: ff11000137e140c8 (&fp->aux->dst_mutex){+.+.}-{4:4}, at: bpf_tracing_prog_attach+0x684/0x1030 kernel/bpf/syscall.c:3648
>  #1: ff1100007437f880 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_link_prog+0x2c/0x60 kernel/bpf/trampoline.c:607
>  #2: ff1100007437cca0 (&ops->local_hash.regex_lock){+.+.}-{4:4}, at: ftrace_set_hash+0xea/0x830 kernel/trace/ftrace.c:5854
>  #3: ffffffff8f246aa8 (ftrace_lock){+.+.}-{4:4}, at: ftrace_set_hash+0x353/0x830 kernel/trace/ftrace.c:5889
> 1 lock held by syz.4.44292/265279:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.0.44314/265342:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.2.44316/265349:
>  #0: ff1100007437f880 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.1.44333/266429:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 4 locks held by syz.3.44343/266519:
>  #0: ff1100007afc30c8 (&fp->aux->dst_mutex){+.+.}-{4:4}, at: bpf_tracing_prog_attach+0x684/0x1030 kernel/bpf/syscall.c:3648
>  #1: ff11000137e7bc80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_link_prog+0x2c/0x60 kernel/bpf/trampoline.c:607
>  #2: ff11000137e7b4a0 (&ops->local_hash.regex_lock){+.+.}-{4:4}, at: ftrace_set_hash+0xea/0x830 kernel/trace/ftrace.c:5854
>  #3: ffffffff8f246aa8 (ftrace_lock){+.+.}-{4:4}, at: ftrace_set_hash+0x353/0x830 kernel/trace/ftrace.c:5889
> 1 lock held by syz.6.44345/266527:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.8.44378/267353:
>  #0: ff1100007437f880 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 1 lock held by syz.7.44379/267356:
>  #0: ff11000079d5ec80 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_get+0x46/0x110 kernel/bpf/trampoline.c:831
> 3 locks held by syz-executor/268574:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff11000079446c88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 4 locks held by syz.4.44424/268723:
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_bpf_attach kernel/bpf/cgroup.c:914 [inline]
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_bpf_link_attach+0x2b6/0x470 kernel/bpf/cgroup.c:1506
>  #1: ff11000160965080 (&tr->mutex){+.+.}-{4:4}, at: bpf_trampoline_link_cgroup_shim+0x224/0x860 kernel/bpf/trampoline.c:754
>  #2: ff110001609670a0 (&ops->local_hash.regex_lock){+.+.}-{4:4}, at: ftrace_set_hash+0xea/0x830 kernel/trace/ftrace.c:5854
>  #3: ffffffff8f246aa8 (ftrace_lock){+.+.}-{4:4}, at: ftrace_set_hash+0x353/0x830 kernel/trace/ftrace.c:5889
> 3 locks held by syz-executor/268753:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff1100014ba73488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 3 locks held by syz-executor/268758:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff1100014ba72c88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 4 locks held by syz.5.44450/269192:
>  #0: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
>  #0: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
>  #0: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: class_srcu_constructor include/linux/srcu.h:508 [inline]
>  #0: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: __do_sys_perf_event_open+0x332/0x2c30 kernel/events/core.c:13460
>  #1: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
>  #1: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
>  #1: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: class_srcu_constructor include/linux/srcu.h:508 [inline]
>  #1: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event kernel/events/core.c:12664 [inline]
>  #1: ffffffff9ba5a090 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xedb/0x4540 kernel/events/core.c:12978
>  #2: ffffffff8f2653c8 (event_mutex){+.+.}-{4:4}, at: perf_trace_init+0x4d/0x2f0 kernel/trace/trace_event_perf.c:221
>  #3: ffffffff8f2466c8 (direct_mutex){+.+.}-{4:4}, at: register_ftrace_function+0x28/0x650 kernel/trace/ftrace.c:8742
> 1 lock held by syz.9.44465/269323:
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_bpf_attach kernel/bpf/cgroup.c:914 [inline]
>  #0: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_bpf_link_attach+0x2b6/0x470 kernel/bpf/cgroup.c:1506
> 3 locks held by syz-executor/269341:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff1100017c3e4488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 3 locks held by syz-executor/269384:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff11000025a63088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 3 locks held by syz-executor/270517:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff1100013c5cc488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 3 locks held by syz-executor/270885:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff1100007b555888 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 3 locks held by syz-executor/271215:
>  #0: ff11000023d22420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x126/0x240 fs/read_write.c:738
>  #1: ff11000109079488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x298/0x580 fs/kernfs/file.c:343
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:393 [inline]
>  #2: ffffffff8f21f1c8 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x11f/0x590 kernel/cgroup/cgroup.c:1735
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 35 Comm: khungtaskd Not tainted 6.18.0-rc4-g93ce3bee311d #3 PREEMPT(full) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x2a0/0x350 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
>  watchdog+0xf1b/0x1150 kernel/hung_task.c:495
>  kthread+0x3d5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x67b/0x7d0 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 43087 Comm: kworker/u9:11 Not tainted 6.18.0-rc4-g93ce3bee311d #3 PREEMPT(full) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: kvfree_rcu_reclaim kfree_rcu_work
> RIP: 0010:unwind_done arch/x86/include/asm/unwind.h:50 [inline]
> RIP: 0010:unwind_get_return_address+0x1f/0xa0 arch/x86/kernel/unwind_orc.c:366
> Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 89 fb <0f> b6 04 02 84 c0 74 04 3c 03 7e 59 8b 03 85 c0 75 09 31 c0 5b 5d
> RSP: 0000:ffa0000003ad7738 EFLAGS: 00000a02
> RAX: dffffc0000000000 RBX: ffa0000003ad7750 RCX: ffa0000003ad76a4
> RDX: 1ff400000075aeea RSI: 0000000000000000 RDI: ffa0000003ad7750
> RBP: ffa0000003ad77d8 R08: ffffffff91f1f3dc R09: ffffffff91f1f3e0
> R10: ffffffff812b60aa R11: ffa0000003ad7784 R12: ffa0000003ad7808
> R13: 0000000000000000 R14: ff110000286fa500 R15: ff1100001c433280
> FS:  0000000000000000(0000) GS:ff1100010ccd0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe2cc25e2a8 CR3: 000000010af25000 CR4: 0000000000753ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  arch_stack_walk+0xa1/0xf0 arch/x86/kernel/stacktrace.c:26
>  stack_trace_save+0x93/0xd0 kernel/stacktrace.c:122
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
>  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x61/0x80 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2539 [inline]
>  slab_free_freelist_hook mm/slub.c:2568 [inline]
>  slab_free_bulk mm/slub.c:6662 [inline]
>  kmem_cache_free_bulk mm/slub.c:7346 [inline]
>  kmem_cache_free_bulk+0x2a3/0x670 mm/slub.c:7325
>  kfree_bulk include/linux/slab.h:830 [inline]
>  kvfree_rcu_bulk+0x1bd/0x1f0 mm/slab_common.c:1522
>  kfree_rcu_work+0xf3/0x170 mm/slab_common.c:1600
>  process_one_work+0x997/0x1b60 kernel/workqueue.c:3263
>  process_scheduled_works kernel/workqueue.c:3346 [inline]
>  worker_thread+0x683/0xe90 kernel/workqueue.c:3427
>  kthread+0x3d5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x67b/0x7d0 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> ```
> 
> ## Kernel Configuration Requirements for Reproduction
> 
> The vulnerability can be triggered with the kernel config in the attachment. Additionally, we provide the execution logs in Syzkaller format to facilitate further verification.



