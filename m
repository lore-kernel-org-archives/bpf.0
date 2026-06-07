Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9E15746F
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780800062; cv=none; b=USbwnqCB5VHlkkL82qTXzaWxMqknnkAelhKPyPANDXlgdy2F5PGbJJfBn3slQmwLKWIuTp0PClMTylAs32wlzH7nSh21IadRzVDov1gQasvVQ3zomzGcy7pJLOpekTNw9MtiZUIbxUcKpvvwOhPwbSB3cZVj05hAM9Sk8cgJmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780800062; c=relaxed/simple;
	bh=jdHt/EMx2RjSEN6qwUYLfnVvh57YIEqA1cafHiHVz8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S5sMDrU9V3i47dUGWOsVbxKtA8hOU66H7dZY6qo2DEsXsb98vYCENLqlz5LFAMZXJ3SBbloSTUffjELSKv2GGs3Lw+xTNnEry3eJDO8tuHF3VwC8xZ0YnTC2xb+KG6DBoKQEgaHjGl01TFBckn04tvK5FFro2F8495FONNQGGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcKP3cat; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcKP3cat"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so28155385e9.1
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800060; x=1781404860; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpjM7elKYnXx9FvoN6+W+67XNbFLMp1wijxRTUf8ZZQ=;
        b=OcKP3catu27dUxik6KJYxuLi3iO+6fNUe2pXJe3h/Iu060sdJIxCSxvOKGDnnWAUTn
         pDLsAV7BPL1ZhOHtk3pjMFPvtrcfxLSX8f+u7KYe4pl84ZJvZLCBlqxYTiv3BPAIHcYF
         WPxJ/VGcm+x3hBc590sHSiBrBYpltmDMRu20rbzJL4FvZlxT9pv2evGRfCwXUJNtbHYV
         WfQEDZHJdw842yMrm1S3dJBWa+5TCVjH+p+xyeD7w7k3qe+JXq42wN7iZg/ISh6tQuOs
         /xOJqqw8nzMBnF0YLREfDcRaw9bTDimUqplZ2fZRjTKlMkGUubzSMoXxxEZ+Hb7jEBSe
         hSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800060; x=1781404860;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpjM7elKYnXx9FvoN6+W+67XNbFLMp1wijxRTUf8ZZQ=;
        b=k+tos5r31mc0AsUvpTxS360z8BxazEaf/qj4w3k3cgJLpfWB4DtYUDnX/l/ZkNIOV1
         OzVeIDhVUpiEQfwq8CqfiKRB1XNhNO5Pz3LV6ktYuKZtjMjW7bFQLul2KIo6/bR3y/hG
         5QUJ3ImZfh//wrxdpiyvi9pGmASHBU2e2WxqBMa7ixu07Q70AyOzIX1ziLme2lOWWIZ8
         SyXagiV72ziJMmF55Ni7PXcHuiHHyJrBAapZD5kuRPf4dcRwuoociP64oQpgHYhyVDtR
         vjWZEWy6mSbNXGAp4F0GBKR/ZMLpCiaWl7lErDtia0ARaZBuC/dBZx+dxcdbsj6xU6LC
         QH3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fgvWfJclmDgB0IaUoKq4HIO75bE8HeIAvmKXgBAlSDRAMe4Rqrt+VwyZ3atXL+jEcbOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaeHrHBInsXZ7zYVp2sdvkvN6La+qUOaJIs1TyA1D0K8WUWar
	6HMePv2aTcgRSPEs8CYA65woNEl0I7msMPJIklsXRVTFjCKwuqfMLboN
X-Gm-Gg: Acq92OFhpSZ+pgk/Grpg7DfQKc3TKrxOrn56gm8bYTSbbVq+uvNDElQJY9VUNpkSBcH
	VvqidYhD9AWG2FVAIk9Z4O1y1a6VpdmrmjWGJ3995CLSzv5ZLfWelcGQMl6p5mz5Wr3yDg0Dwz+
	KHI6TlIeHF0fZhxO+/0QGbSjLZfDUvOfXGgVltuLdcZWsVSgYfxLoWK2rtdSASa6l1g6l88durk
	mtu9CtytM4qDfxMiOyjuScchjkBznyE2qC8DOGoQnFmHOXp+oEVy/67Vj2my5UthG+ZUrYrtq40
	UMqkcuml48fwDCBOZ++dyWyE8fqqa5Y6LkmSxP/L6O51IAh0H6SAkTXBW5PzbcQF0m9MkjMFYkr
	YxIwYFwoDrkI+7JGi4JOOaBZK5V9XEWHYQNHwdnU1ATIl7mSiAFhvY6VIDucM9aMyJEGHdtMdyV
	x+6zZZth0/SIBPzSjr/JRpp7yQgUOaKXBjs6aHBy8NqpTgsrvOEdqKN/hZRA2GNwI0T7gZZJxQy
	BZrcwUboUZjq1MHmQsOpcIyjrETnXeqZnwX+67L3dYxFPybPtounqrbitWQFYZu+7Kc+tfG1ynj
	FcR77nk8emI=
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490c2d1fb35mr141120145e9.15.1780800059463;
        Sat, 06 Jun 2026 19:40:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm331423635e9.9.2026.06.06.19.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 04:40:58 +0200
Message-Id: <DJ2GXOXL4O0G.9DI5VYR6GUMU@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260519011450.1144935-2-utilityemal77@gmail.com>
 <20260519015123.36096C2BCB7@smtp.kernel.org> <agxkV-hsdwhvMliI@suesslenovo>
 <agyG3eQwgmoJwmj2@suesslenovo> <DIMWGCWL1AG2.14F7CN23GMS8N@gmail.com>
 <aiRG9nsbRi2cO3XT@zenbox>
In-Reply-To: <aiRG9nsbRi2cO3XT@zenbox>

On Sat Jun 6, 2026 at 6:27 PM CEST, Justin Suess wrote:
> On Tue, May 19, 2026 at 09:27:58PM +0200, Kumar Kartikeya Dwivedi wrote:
>> On Tue May 19, 2026 at 5:59 PM CEST, Justin Suess wrote:
>> > On Tue, May 19, 2026 at 10:42:44AM -0400, Justin Suess wrote:
>> >> Looks like this kfunc also tries to eagerly free fields and is callab=
le
>> >> from tp_btf/nmi_handler with no recovery mechanism.
>> >>
>> >> I don't see a good way to handle this at all... it also is effectivel=
y
>> >> already bugged in the existing code unless I'm missing something
>> >>
>> >> Since you can use it to call abritrary dtors in NMI.
>> >>
>> >> 1.
>> >>
>> >> In some context where task_acquire is valid:
>> >>
>> >> struct blah {
>> >>   struct task_struct __kptr* task;
>> >> }
>> >>
>> >> b =3D bpf_task_acquire(...)
>> >> a =3D bpf_obj_new(typeof(*blah_ptr));
>> >> bpf_kptr_xchg(a->task, b);
>> >>
>> >> 2.
>> >>
>> >> Then xchg a into map
>> >> bpf_kptr_xchg([map slot], a);
>> >> ...
>> >>
>> >> 3.
>> >>
>> >> In tp_btf/nmi_handler we exchange the obj out of the map
>> >> and then drop it.
>> >>
>> >> c =3D bpf_kptr_xchg([slot where a is stored], NULL);
>> >> bpf_obj_drop(c);
>> >>
>> >> And because this can be called on an object not in a map, we don't ha=
ve
>> >> a good recovery mechanism.
>> >>
>> >> Because tp_btf/nmi_handler is always in_nmi and hence irqs_disabled, =
in
>> >> the code before this patch the task_struct dtor will be invoked and
>> >> cause a deadlock.
>> >>
>> >> This patch will not fix the issue and just free a struct blah holding=
 the
>> >> reference without actually dropping it.
>> >>
>> >> Unless I'm missing something then this whole approach taken by this
>> >> patch can't handle this case since the bpf_obj is detached from the m=
ap
>> >> entirely and has no allocator recovery mechanism at all.
>> >>
>> >> Then we are back to square 1 needing to defer the freeing with irq wo=
rk.
>> >>
>> >> Kumar / Alexei do you have anything on this?
>> >
>> > I've confirmed this is a viable mechanism to deadlock as well
>> >
>> > Using the above approach, just exchanging out of a map and dropping th=
e
>> > bpf_obj containing a task_struct kptr can be used to cause a deadlock
>> > outside any map path:
>> >
>> > On 576482b55c19e7ec00e162a0fde4c4f1a95128c7 (bpf-next/master) w/ RCU_N=
OCB_CPU/RCU_EXPERT:
>> >
>> >   [   10.773819] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >   [   10.773820] WARNING: inconsistent lock state
>> >   [   10.773821] 7.1.0-rc2-g576482b55c19 #150 Not tainted
>> >   [   10.773822] --------------------------------
>> >   [   10.773822] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> >   [   10.773823] test_progs/471 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> >   [   10.773825] ffff98623d66f0e8 (&rdp->nocb_lock){-.-.}-{2:2}, at: _=
_call_rcu_common.constprop.0+0x54a/0x730
>> >   [   10.773832] {INITIAL USE} state was registered at:
>> >   [   10.773832]   lock_acquire+0xbf/0x2e0
>> >   [   10.773835]   _raw_spin_lock+0x30/0x40
>> >   [   10.773838]   rcu_nocb_gp_kthread+0x13f/0xb90
>> >   [   10.773840]   kthread+0xf4/0x130
>> >   [   10.773845]   ret_from_fork+0x264/0x330
>> >   [   10.773848]   ret_from_fork_asm+0x1a/0x30
>> >   [   10.773851] irq event stamp: 1127908
>> >   [   10.773851] hardirqs last  enabled at (1127907): [<ffffffff871044=
84>] _raw_spin_unlock_irqrestore+0x44/0x60
>> >   [   10.773853] hardirqs last disabled at (1127908): [<ffffffff871041=
a1>] _raw_spin_lock_irqsave+0x51/0x60
>> >   [   10.773854] softirqs last  enabled at (1127782): [<ffffffff862e6b=
80>] __irq_exit_rcu+0xc0/0x100
>> >   [   10.773857] softirqs last disabled at (1127777): [<ffffffff862e6b=
80>] __irq_exit_rcu+0xc0/0x100
>> >   [   10.773858]
>> >                  other info that might help us debug this:
>> >   [   10.773859]  Possible unsafe locking scenario:
>> >
>> >   [   10.773859]        CPU0
>> >   [   10.773859]        ----
>> >   [   10.773860]   lock(&rdp->nocb_lock);
>> >   [   10.773861]   <Interrupt>
>> >   [   10.773861]     lock(&rdp->nocb_lock);
>> >   [   10.773862]
>> >                   *** DEADLOCK ***
>> >
>> >   [   10.773862] 4 locks held by test_progs/471:
>> >   [   10.773863]  #0: ffffffff885ccaf0 (dup_mmap_sem){.+.+}-{0:0}, at:=
 copy_process+0x1e39/0x2b80
>> >   [   10.773866]  #1: ffff9861c33a2ff8 (&mm->mmap_lock){++++}-{4:4}, a=
t: dup_mmap+0x83/0x990
>> >   [   10.773871]  #2: ffff9861c1152ff8 (&mm->mmap_lock/1){+.+.}-{4:4},=
 at: dup_mmap+0xc8/0x990
>> >   [   10.773874]  #3: ffffffff885f43b8 (kmemleak_lock){-.-.}-{2:2}, at=
: __create_object+0x3a/0xa0
>> >   [   10.773877]
>> >                  stack backtrace:
>> >   [   10.773879] CPU: 1 UID: 0 PID: 471 Comm: test_progs Not tainted 7=
.1.0-rc2-g576482b55c19 #150 PREEMPT(full)
>> >   [   10.773881] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>> >   [   10.773882] Call Trace:
>> >   [   10.773883]  <NMI>
>> >   [   10.773884]  dump_stack_lvl+0x5d/0x80
>> >   [   10.773887]  print_usage_bug.part.0+0x22b/0x2c0
>> >   [   10.773891]  lock_acquire+0x295/0x2e0
>> >   [   10.773893]  ? __call_rcu_common.constprop.0+0x54a/0x730
>> >   [   10.773896]  _raw_spin_lock+0x30/0x40
>> >   [   10.773898]  ? __call_rcu_common.constprop.0+0x54a/0x730
>> >   [   10.773899]  __call_rcu_common.constprop.0+0x54a/0x730
>> >   [   10.773903]  bpf_obj_free_fields+0x118/0x250
>> >   [   10.773907]  bpf_obj_drop+0x4f/0x80
>> >   [   10.773910]  bpf_prog_b7ff9c2e6c583824_clear_task_kptrs_from_nmi+=
0x174/0x1f4
>> >   [   10.773912]  bpf_trace_run3+0x126/0x430
>> >   [   10.773916]  ? __pfx_perf_event_nmi_handler+0x10/0x10
>> >   [   10.773919]  nmi_handle.part.0+0x15b/0x250
>> >   [   10.773922]  ? __pfx_perf_event_nmi_handler+0x10/0x10
>> >   [   10.773924]  default_do_nmi+0x120/0x180
>> >   [   10.773927]  exc_nmi+0xe3/0x110
>> >   [   10.773928]  end_repeat_nmi+0xf/0x53
>> >   [   10.773931] RIP: 0010:__link_object+0xb4/0x270
>> >   [   10.773932] Code: 00 00 00 48 c7 c6 80 36 bb 89 48 c7 43 70 00 00=
 00 00 48 c7 43 78 00 00 00 00 48 89 3d 35 62 50 03 eb 66 48 89 c8 48 8b 48=
 30 <48> 8d 70 10 48 39 d1 73 11 48 03 48 38 48 39 cf 0f 82 2f 01 00 00
>> >   [   10.773933] RSP: 0018:ffffb516013b7a60 EFLAGS: 00000082
>> >   [   10.773935] RAX: ffff9861c37b5c80 RBX: ffff9861df869878 RCX: ffff=
9861c3776420
>> >   [   10.773936] RDX: ffff9861c3769e00 RSI: ffff9861c43564f8 RDI: ffff=
9861c3769d00
>> >   [   10.773936] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000=
000000000000
>> >   [   10.773937] R10: 0000000000000000 R11: 0000000000000000 R12: ffff=
9861c3769d00
>> >   [   10.773937] R13: 0000000000000286 R14: 0000000000000000 R15: 0000=
000000000001
>> >   [   10.773943]  ? __link_object+0xb4/0x270
>> >   [   10.773945]  ? __link_object+0xb4/0x270
>> >   [   10.773947]  </NMI>
>> >   [   10.773947]  <TASK>
>> >   [   10.773948]  __create_object+0x51/0xa0
>> >   [   10.773951]  kmem_cache_alloc_from_sheaf_noprof+0x1e2/0x290
>> >   [   10.773956]  mas_dup_build+0x41d/0x7f0
>> >   [   10.773960]  __mt_dup+0x78/0xf0
>> >   [   10.773967]  dup_mmap+0x12e/0x990
>> >   [   10.773972]  ? srso_alias_return_thunk+0x5/0xfbef5
>> >   [   10.773973]  ? lock_acquire+0xbf/0x2e0
>> >   [   10.773979]  copy_process+0x1e45/0x2b80
>> >   [   10.773985]  kernel_clone+0xbb/0x3d0
>> >   [   10.773986]  ? srso_alias_return_thunk+0x5/0xfbef5
>> >   [   10.773987]  ? __lock_acquire+0x481/0x2590
>> >   [   10.773993]  __do_sys_clone+0x65/0x90
>> >   [   10.773998]  do_syscall_64+0xa1/0x5f0
>> >   [   10.774002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> >   [   10.774003] RIP: 0033:0x7f9da26e8f2f
>> >   [   10.774005] Code: 89 e7 e8 c4 0e f6 ff 45 31 c0 31 d2 31 f6 64 48=
 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f=
 05 <48> 3d 00 f0 ff ff 77 59 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
>> >   [   10.774005] RSP: 002b:00007ffc278b4540 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000038
>> >   [   10.774007] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f9da26e8f2f
>> >   [   10.774007] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000=
000001200011
>> >   [   10.774008] RBP: 00007ffc278b4740 R08: 0000000000000000 R09: 0000=
000000000001
>> >   [   10.774008] R10: 00007f9da2acaf10 R11: 0000000000000246 R12: 0000=
000000000003
>> >   [   10.774009] R13: 0000000000000001 R14: 0000000000000000 R15: 0000=
5625de8b38d0
>> >   [   10.774014]  </TASK>
>> >   [   10.866584] perf: interrupt took too long (6193 > 6190), lowering=
 kernel.perf_event_max_sample_rate to 32000
>> >   [   16.630663] kauditd_printk_skb: 30 callbacks suppressed
>> >
>> > I can give the reproducer if wished.
>> >
>> > You can see the path involves bpf_obj_drop and not any map methods at
>> > all.
>> >
>> > But basically this makes the whole mechanism of relying on map allocat=
ors to
>> > recycle and free objects in irqs_disabled contexts unsound because kpt=
rs
>> > can live and be released outside map contexts.
>>
>> The approach in this version is still different than what I had proposed=
. For
>> the particular case you highlighted, we should just reject bpf_obj_drop(=
) in
>> is_tracing_prog_type() once the object has kptr fields etc. If someone s=
till
>> wants it they should just use bpf_wq to defer manually.
>>
> Would you be opposed to me submitting a fix for *just* the bpf_obj_drop c=
ase?
>
> Since your proposed solution for that is just a tiny verifier fix w/ btf_=
record_has_field and a prog_type check and is mostly unrelated to this fix =
for the map cases.
>
> It's a small fix, but just don't want to be rude and submit anything if
> you're working on that too in your patch. :)
>
> Thanks for your guidance with this fix in general and apologize for my
> misinterpretation of the intended route.

Unfortunately I already prepared it, though for both fixes I already kept y=
our
authorship since you've put in so much effort in reporting, reproducing, an=
d
testing various fixes, the adjustments might as well have been done by you
rather than me.

I will send it later today, once I do, please help in reviewing and testing
corner cases in the fixes. Reviewing code will be more appreciated than cra=
nking
out new code, there are few people who can do that.

Thanks

>
> Kind Regards,
> Justin
>> The whole prealloc related change to the map is unnecessary, as I said b=
efore.
>> It's an orthogonal change. We should also not use irqs_disabled() and ju=
st do
>> the skipping unconditionally.
>>
>> Let me work on a patch, since the nuance is obviously getting lost in em=
ail.

