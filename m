Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B7326929
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146403; cv=pass; b=aT22oQbsfv28Vsn5DQ8w4uQcx42qMiuu5bSYqmjykiez1sEGPS1zcns2+eL7PXCcrDgxqyyiJs7F4qO1vs5Yda7rl+o44qmhkCEFm//7ZuGyhWv8iYLhO+BW+QbrLDRh2IZonOn8oTXi9EyYpA7vPBGM0hBqadOqk7X55yHcGL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146403; c=relaxed/simple;
	bh=5fKy4Ky2hOV9AG8yoCxSOmCaOuU+ZKXxPQkHbRqzY8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0qPZRmmZYuFTiOZ+5AQbI0kUFiFh0YhvsDhJL5zy/vaoYiHmuEt5XEWyrXHiTp/oGnxldzM9+Di2xbnh9+Bz1LpuQ3zmCX7tHhX8x65uOrTrY6MELZJQH12fu6YpuZq4nRInddyGUjw4Rcz36qV6sxekvKDnN535HHHz4pLfgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhpyrLPj; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhpyrLPj"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6495d592b58so29715d50.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 11:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770146400; cv=none;
        d=google.com; s=arc-20240605;
        b=AVUPBOgyPVVgVMsBsHihud5Fiag/TBWTPaFIlLQ2h4a+xzOnq11fNgX3UicJeYeKpx
         QA0bm60JVnOMccNOaiFDhqLjbk5VVFu9NUqkDn4d4gesaHnw4LKvcS+pxBHxbgK8+XaA
         ZnIHkwm/Q5QufPeOuCv4pxwuAw0RoeaCCxU8t2RSskmKk5t6sASlXF7m5iP8OTz+1pFJ
         p6dnTV+CoEosbHCAlRTR5690J769Kox15Jzoww9JwizC1GRAXlMaGr0vgIqAFT023rpQ
         MGOibk6i6HaSQu6ETFV0nMOBS4aWCrJFOe15fv/vVnBZUjxy95IkpgL2KsiJ7Gf8GH1p
         2gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgT7zmTz3P0mNZelE2V53iRcvsF2b2K5EeY0zRvB5io=;
        fh=CYujNZajqcu2K+UX2Cnrx8ePVvyywJ5X437MW6RXlWk=;
        b=Od/nzaDp8S3GLwiNZbq/Ulr95XwziN/xYT3Sj3Qf7BTQbqdbtdFbBuBhW0OvybzQyb
         FK6ssEHzo2hx7ifL7A6lO6TNBExta8iqsLCTMvqE2NahSCYZXTw1+Lxm7hjd9l65XJ33
         JWO3aovwwh1qTGknw7JISlSbJ6uL6s2cVyLX7X+WO3g7m7VEozOf+su72n5THhw9h8xZ
         h1FqlypbsluT1tTvFrRMTetW8iKT82CBy9LCNAz12dMyZ3d7wY0F64k4idoXCSN18/ew
         LxVQt/D8Uxa5Goi+hESY9amDuZkY8T4vJbJtxFtfo8+7rLRD9ln9hyr1hu/2WPdewFBC
         je1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770146400; x=1770751200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgT7zmTz3P0mNZelE2V53iRcvsF2b2K5EeY0zRvB5io=;
        b=WhpyrLPj+yx2RhcRvUQbGvhENCM6fPmGXVE1uZHEvj8wjPoxw/oowEea1fpLGhKb4B
         aHxOyB3erIQDaLalNmfZgBkyfNw4Yic2vIAgOTWpk4+AKcZPBvW1dQJNN8AZPBBv9IsY
         x+OrtHUdUpd6ZX5/AqVum6EmximONny6ztnAqfDl2O9O6zkd8Vpavs/wDiSfiNhwlI2v
         gMr1hj6kF6l8IqAxOSpUdbPl0u9jt3FOpKKz95c8eiCBfuHemYfkDJCoS0R6+dSXNGnm
         DMmKr618vrq53HH9DfZct7CFXUQa9zoWHgFcOzGmPETVTNHtSW8FlEuX43A/vX0UVo9j
         NYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146400; x=1770751200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgT7zmTz3P0mNZelE2V53iRcvsF2b2K5EeY0zRvB5io=;
        b=Tg8YhZqxHdVPijkt2RgkkHGWzYWhG2XsfDaNXi8qyie61U4EHjZUaiQ3JiOHj3kj5p
         BDusO35WsKKUfD92uRMr/2cNiP49LVhOrVdZFXKlgWsB1NNdX5VAk6cy6LTnJ/F3CfAm
         es2xobgrO4OsxoB+5Vpny3ePot49IPwsqtQv1ooQbu5ffz/+15tS/IqI/uxYJHWHais3
         w3e8eFnYw3mP6DsfR60DWbVOni7O9ntXloH2yaYdCqTQ9g+LUcw0eMdTdTjLzueqA6yY
         RLwx+6o7mbLaXkFSNRwsxPA/uzMVTx8YTFW6eF3XQbS1AvrIJenpme8CglxoOK1cX7Hx
         VrHg==
X-Gm-Message-State: AOJu0Yy0nD5li9XeGhezhg6WD3cjAaKQCeqTYIeb+YtZAft7JQYtIG6t
	VS0uvCi1FCBF6n2YyPijqj58B8Z6TB8FeuzHgM4coAagMMtnqZh0OGIPbAVlCBQMnm4Q2fqWrUN
	TjyGWwK8EbxohiMXxHrFEpW8ydAAlLmNFxA==
X-Gm-Gg: AZuq6aJ+aStQzYgIQoh5lWK4XcANENWt6blZ6GfxkcvpD55d+xqDFf8vZQt5z396g1/
	Zf7kihe+damDtbtTV0HxYPqb02W3rAfpSS4DbmxYRa92rq3qXYqxTRVGEjgRAA8ubfYCk6TAuEC
	QkvhtVPtO5aLR/w3aP68YirxwiBT+R5890V4CvtwrEY9mwmu/tKL2EylB8vBGisSFsHznfWcmb+
	8RaGyf5mS9BYHLWkpXm1uiFvQEx5pu8qtfZ/Ribx9xs0EQ1ptWwh9YINprsNzw4+nO7pak=
X-Received: by 2002:a53:d015:0:b0:649:5210:2272 with SMTP id
 956f58d0204a3-649db4aa0d5mr530904d50.76.1770146399727; Tue, 03 Feb 2026
 11:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40aeb947.6d7ba.19c2290a82b.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <40aeb947.6d7ba.19c2290a82b.Coremail.kaiyanm@hust.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 3 Feb 2026 11:19:48 -0800
X-Gm-Features: AZwV_QimagAA1JCgbV5ugo-3UKAFRHbaeNq7oy3i14UqZ5jsalSwKdTrBUDZRa8
Message-ID: <CAMB2axMYsEX89sunVkQzAmN2krnsUZhcTuWRXQ-ffHoRoQNHNw@mail.gmail.com>
Subject: Re: INFO: task hung in bpf_struct_ops_map_free
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf@vger.kernel.org, dzm91@hust.edu.cn, dddddd@hust.edu.cn, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 12:16=E2=80=AFAM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyan=
m@hust.edu.cn> wrote:
>
> Our fuzzer discovered a task hung vulnerability in the BPF subsystem. The=
 crash can be trigger on bpf-next(39e9d5f63075f4d54e3b59b8238478c32af92755)=
. We have not yet been able to develop a stable PoC to reproduce this vulne=
rability, but we will continue to analyze it further and testing whether it=
 can be triggered on the latest bpf-next branch.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> # Crash Report
> ```
> INFO: task syz.7.21680:81571 blocked for more than 143 seconds.
>       Not tainted 6.17.0-g39e9d5f63075 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.7.21680     state:D stack:26984 pid:81571 tgid:81569 ppid:71075 =
 task_flags:0x400140 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5325 [inline]
>  __schedule+0x1044/0x5bb0 kernel/sched/core.c:6929
>  __schedule_loop kernel/sched/core.c:7011 [inline]
>  schedule+0xe7/0x3a0 kernel/sched/core.c:7026
>  schedule_timeout+0x245/0x280 kernel/time/sleep_timeout.c:75
>  do_wait_for_common kernel/sched/completion.c:100 [inline]
>  __wait_for_common+0x1d3/0x4e0 kernel/sched/completion.c:121
>  wait_for_common kernel/sched/completion.c:132 [inline]
>  wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:269
>  __wait_rcu_gp+0x262/0x3a0 kernel/rcu/update.c:443
>  bpf_struct_ops_map_free+0x1d6/0x310 kernel/bpf/bpf_struct_ops.c:1000
>  bpf_map_free kernel/bpf/syscall.c:879 [inline]
>  map_create+0x1033/0x2710 kernel/bpf/syscall.c:1604
>  __sys_bpf+0x1b26/0x5390 kernel/bpf/syscall.c:6116
>  __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6242
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f403f7adead
> RSP: 002b:00007f4040570f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f403f9e5fa0 RCX: 00007f403f7adead
> RDX: 0000000000000050 RSI: 0000200000000300 RDI: 0000000000000000
> RBP: 00007f403f847d9f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f403f9e5fa0 R15: 00007f4040551000
>  </TASK>

It seems to be another thread in tasks trace RCU for too long but hung
task is detected first before tasks trace RCU stall detection kicks
in.

Might not be a real bug if it is a wild bpf program running for too
long using different tricks.

>
> Showing all locks held in the system:
> 1 lock held by ksoftirqd/1/23:
> 2 locks held by kworker/u9:0/26:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000000a17d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 3 locks held by kworker/u10:0/27:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000000a27d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
>  #2: ffffffff8efceb78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_l=
ock+0x287/0x3b0 kernel/rcu/tree_exp.h:311
> 1 lock held by rcu_tasks_kthre/30:
>  #0: ffffffff8efc2db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tas=
ks_one_gp+0x708/0xd90 kernel/rcu/tasks.h:614
> 1 lock held by khungtaskd/34:
>  #0: ffffffff8efc35e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8efc35e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8efc35e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_loc=
ks+0x36/0x1c0 kernel/locking/lockdep.c:6775
> 2 locks held by kworker/u9:2/54:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000000140fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u10:2/71:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000001797d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 3 locks held by kworker/u9:3/85:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000000283fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
>  #2: ffffffff8efcea40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barr=
ier+0x48/0x6b0 kernel/rcu/tree.c:3820
> 2 locks held by kworker/u10:3/86:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000000284fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 3 locks held by kworker/0:2/797:
> 2 locks held by kworker/u9:4/1065:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000007987d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 1 lock held by systemd-journal/5203:
> 3 locks held by sshd/9936:
> 2 locks held by kworker/u10:6/12939:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000001188fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u9:6/13627:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000000720fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u9:7/13628:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000004907d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u10:10/14055:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa00000044e7d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u10:11/14069:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000004477d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u9:9/14766:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000003867d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u10:14/68383:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa00000082f7d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 1 lock held by (udev-worker)/69289:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x3=
77/0xfa0 net/core/rtnetlink.c:6960
> 2 locks held by kworker/u10:15/72109:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa0000005c07d10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 2 locks held by kworker/u10:19/73952:
>  #0: ff1100001c071948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work+0x128c/0x1b60 kernel/workqueue.c:3238
>  #1: ffa000000429fd10 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work+0x8ec/0x1b60 kernel/workqueue.c:3239
> 1 lock held by syz-executor/91661:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include=
/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x4=
e1/0x1cf0 net/ipv6/addrconf.c:5027
> 4 locks held by (udev-worker)/91972:
> 1 lock held by (udev-worker)/92355:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x3=
77/0xfa0 net/core/rtnetlink.c:6960
> 1 lock held by syz-executor/94736:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/co=
re/rtnetlink.c:341 [inline]
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x7c0/0x=
1fb0 net/core/rtnetlink.c:4064
> 2 locks held by ifquery/95051:
>  #0: ff11000065e796e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dum=
p_start+0x156/0x980 net/netlink/af_netlink.c:2406
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95294:
>  #0: ff1100004c6b16e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+=
0x72b/0xdc0 net/netlink/af_netlink.c:2269
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95343:
>  #0: ff110000296816e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dum=
p_start+0x156/0x980 net/netlink/af_netlink.c:2406
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95358:
>  #0: ff11000095bb96e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+=
0x72b/0xdc0 net/netlink/af_netlink.c:2269
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95390:
>  #0: ff1100012c1cf6e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+=
0x72b/0xdc0 net/netlink/af_netlink.c:2269
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95537:
>  #0: ff11000066a786e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+=
0x72b/0xdc0 net/netlink/af_netlink.c:2269
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95624:
>  #0: ff1100003234b6e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dum=
p_start+0x156/0x980 net/netlink/af_netlink.c:2406
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by ifquery/95801:
>  #0: ff1100001c7766e0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+=
0x72b/0xdc0 net/netlink/af_netlink.c:2269
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x199/0x2=
00 net/core/rtnetlink.c:6822
> 2 locks held by syz.8.26153/96008:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: bpf_xdp_link_release+=
0x1f/0x7b0 net/core/dev.c:10415
>  #1: ffffffff90cdc7e8 (bpf_dispatcher_xdp.mutex){+.+.}-{4:4}, at: bpf_dis=
patcher_change_prog+0x38/0xa70 kernel/bpf/dispatcher.c:146
> 1 lock held by systemd-sysctl/96015:
> 2 locks held by systemd-sysctl/96039:
> 1 lock held by systemd-sysctl/96082:
> 1 lock held by syz.0.26192/96124:
>  #0: ffffffff90cd7708 (rtnl_mutex){+.+.}-{4:4}, at: bpf_xdp_link_attach+0=
xe3/0x8d0 net/core/dev.c:10540
> 1 lock held by systemd-sysctl/96132:
> 3 locks held by syz.3.26196/96141:
>  #0: ffffffff9b6827d0 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire inc=
lude/linux/srcu.h:161 [inline]
>  #0: ffffffff9b6827d0 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock includ=
e/linux/srcu.h:253 [inline]
>  #0: ffffffff9b6827d0 (&pmus_srcu){.+.+}-{0:0}, at: class_srcu_constructo=
r include/linux/srcu.h:508 [inline]
>  #0: ffffffff9b6827d0 (&pmus_srcu){.+.+}-{0:0}, at: __do_sys_perf_event_o=
pen+0x332/0x2c30 kernel/events/core.c:13460
>  #1: ffffffff8f05a688 (event_mutex){+.+.}-{4:4}, at: perf_trace_destroy+0=
x27/0x1c0 kernel/trace/trace_event_perf.c:239
>  #2: ffffffff8efceb78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_l=
ock+0x1a3/0x3b0 kernel/rcu/tree_exp.h:343
> 4 locks held by ifupdown-hotplu/96139:
> 4 locks held by (spawn)/96149:
> 4 locks held by (spawn)/96153:
> 4 locks held by syz.6.26205/96158:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 34 Comm: khungtaskd Not tainted 6.17.0-g39e9d5f63075 #=
1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x2a0/0x350 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
>  watchdog+0xf16/0x1150 kernel/hung_task.c:495
>  kthread+0x3d0/0x780 kernel/kthread.c:463
>  ret_from_fork+0x676/0x7d0 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 64717 Comm: (udev-worker) Not tainted 6.17.0-g39e9d5f6=
3075 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:check_preemption_disabled+0x3e/0x170 lib/smp_processor_id.c:54
> Code: 44 8b 25 e9 6c 26 09 65 8b 1d de 6c 26 09 81 e3 ff ff ff 7f 31 ff 8=
9 de 0f 1f 44 00 00 85 db 74 15 0f 1f 44 00 00 44 89 e0 5b <5d> 41 5c 41 5d=
 41 5e c3 cc cc cc cc 0f 1f 44 00 00 9c 5b 81 e3 00
> RSP: 0018:ffa0000004fb7708 EFLAGS: 00000046
> RAX: 0000000000000001 RBX: ffa0000004fb7be0 RCX: ffa0000004fb8000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8bb08140 R08: 0000000000000001 R09: ffa0000004fb7bd8
> R10: 0000000000013d84 R11: 00000000000a34f6 R12: 0000000000000001
> R13: ffffffff8d707639 R14: ff11000116aa0000 R15: ffa0000004fb781c
> FS:  00007fb36ec948c0(0000) GS:ff1100020f8a7000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557132ac66f0 CR3: 000000016a34d000 CR4: 0000000000753ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  lockdep_recursion_inc kernel/locking/lockdep.c:465 [inline]
>  lock_release+0x9d/0x2f0 kernel/locking/lockdep.c:5888
>  rcu_lock_release include/linux/rcupdate.h:341 [inline]
>  rcu_read_unlock include/linux/rcupdate.h:897 [inline]
>  class_rcu_destructor include/linux/rcupdate.h:1195 [inline]
>  unwind_next_frame+0x3b6/0x20b0 arch/x86/kernel/unwind_orc.c:479
>  arch_stack_walk+0x86/0xf0 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:56
>  kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
>  __call_rcu_common.constprop.0+0xa4/0xa00 kernel/rcu/tree.c:3123
>  security_inode_free+0xa5/0x170 security/security.c:1774
>  __destroy_inode+0x201/0x730 fs/inode.c:371
>  destroy_inode+0x91/0x1b0 fs/inode.c:394
>  evict+0x598/0x8f0 fs/inode.c:834
>  iput_final fs/inode.c:1914 [inline]
>  iput.part.0+0x5e5/0xa20 fs/inode.c:1966
>  iput+0x35/0x40 fs/inode.c:1929
>  dentry_unlink_inode+0x296/0x470 fs/dcache.c:466
>  __dentry_kill+0x1d2/0x600 fs/dcache.c:669
>  dput.part.0+0x4b0/0x9b0 fs/dcache.c:911
>  dput+0x1f/0x30 fs/dcache.c:901
>  __fput+0x516/0xb50 fs/file_table.c:476
>  fput_close_sync+0x10f/0x250 fs/file_table.c:573
>  __do_sys_close fs/open.c:1589 [inline]
>  __se_sys_close fs/open.c:1574 [inline]
>  __x64_sys_close+0x8e/0x120 fs/open.c:1574
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb36ee7c9a0
> Code: 0d 00 00 00 eb b2 e8 0f f8 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1=
f 44 00 00 80 3d 41 1c 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffce88f1408 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007fb36ee7c9a0
> RDX: 0000557132824470 RSI: 0000000000000007 RDI: 0000000000000012
> RBP: 00007fb36ec946a0 R08: 0000000000000007 R09: 0000557132ac66f0
> R10: 00007ffce88f1528 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000557132ae1b40 R15: 00007ffce88f1530
>  </TASK>
>
> ```
>
> ## Kernel Configuration Requirements for Reproduction
>
> The vulnerability can be triggered with the kernel config in the attachme=
nt. Additionally, we provide the execution log and reproduction log in Syzk=
aller format to facilitate further verification.
