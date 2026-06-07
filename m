Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7661347BC1
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844728; cv=none; b=KSrrAKFn0308s29XxgLzbKLJeyuLaxb4nEbHoVsve9iTkfWIdM4YjvLkQ3aEXLNKLbDiTzA87AjW4ksPLbnjQVJYCUln2BOnuwQoe2RZmGEjHb+uMx34i1bvDVRBqq9fWrSeVwQaj9wsxyfhy9/834mxS0AKo5iOxpuwyCahKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844728; c=relaxed/simple;
	bh=1Jv3EXhFOK77dOJBtNtI2r1vQIukhUGV7sC1dcZg7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjouyGQhep0/vK4TxnfLIFF1xiAgA8iCHtLDcjvIbfbdX9R0gstl5/gUwxREMDCNMx5X0axhTiWl6028JyTXPeLJgRCwp/aeQFNmzWSLuT2eBbMrry29i8OFnn78esdJfDtV718V1Vu5ZpLJfk0yl9nMkbIJibJUQgTOT6kaQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6NPOVCa; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6NPOVCa"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660390a8999so3710844d50.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780844726; x=1781449526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxcJylqdvL/bZokoezhkYb1Oi44269zoZ+zcqvLoXeo=;
        b=P6NPOVCaqI7/fX1+slJ/VPIiRyK6vDy3pI6v6FCW9UIHHO6R4/wz7EIJiJCj4spR5P
         XY1O3v0HkhN+IVc3Ky/4m2wKMJOuVmoyrwrC8lU9SFxm6rH6ZW6colF1aNN3zRNeiJgL
         vjxycbdTTOFJpj4iCC1M+HTYKQsdvF3XIgHX+DDvZUOLYWCnHPZ1cxcplgXWKgLWSPa/
         UO8oR+WSCpFJLSFdwl38Iw83mFWyKN0qRi14K9hrMjQfFR+NZXpfGJBpkYtT06GypKF+
         pY8bDPXm/ppZhMdHH5SLjXuayQXsQgONQ4Jn+FsR77+6vKPAtAz4s/ns7R+3o2pTxLc7
         0ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780844726; x=1781449526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxcJylqdvL/bZokoezhkYb1Oi44269zoZ+zcqvLoXeo=;
        b=s4wPbvvwRKhXT0M/9cb3poVVqG1K8xcihqBloHPo6h/KOacnS+PFkWpS1aKWI2pMEw
         JedTX/UxPvZ/yE5xF0VMYf54JSWPuaW4XTbBiROLWFDDLaAZTOUQK7Ph6srFzktbTnYE
         hrqyne25K3GSU2Ml/Sxh2ah9Z4pygFt0ZIxsaMT111CaXhOszegnoceZP8le5HaIdwul
         Jzt4S83PpeL0pHcsGS2sg3ePxojcDxX+O0nRgiHowRYZUSHDpq2/toLyVK7eu59H6c8R
         r5g/zA8IIzq29XXA+BxceQwOpyZVu2g1U17ne/ACVBX1Rt8IC5D6OhrqrSjRnvOb23kv
         Yajg==
X-Forwarded-Encrypted: i=1; AFNElJ+KvPI5gz2qbDpny4UmoXVV99stwae7OklEA4l7/OeWtfUWEyXqh5x2O+yy8+Nr57MNfKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXcgei0ZsM0KtaXaf5nCiWXNpf22qIKeld/EOb0soMBxOZaLT
	h/UFeEu+QInQzzr46MWpSSCEW7yAK/7xoTJCLw6OINNZvFKkYHCl9Ws8iXyMoQ==
X-Gm-Gg: Acq92OEGRlp9JQutDAW5I7dMOoUZbxeDDiB11IiTM1O59BmKbomx27QsSYYIG+yLQ68
	FKvW5nFaU46/QuzWa4Tzh8TCXvsTH615Wz8ubPqlzVBlgi8NRk+5dhDE6TpUm5KpE3+mJzj8O3/
	fGBMg7gH5Z1hWoyL8z2Fz2DvDzr1RKvu2WzFMH8Vx8w90UCNxoD45cxbIcUeM0H7uYIXrqRDcz7
	Qj0Os4X1H5OkbassmcZo8nWcq3AyDx4nRVt+Yd1WFx8M0TlvkhOo2EZuPN7Okeh0pfOUAX6JNax
	r3sT0fMq8r9OraQx6f6JzO3v95s3yrDRJOghmRtBYITTBXVxtOkLma+VOK8gWahY2hr7SHzVNUJ
	72bTIpdhOd+09DXNJx02/VMU/pI9d/CsYP4uORQWHf3tP+9/BcVddFmFQB8aUhx89Sd44i2PlPM
	oS+ltRL+P+UZD2fzzHyQlzCTR/+x/VUdBrp8JpVvrbGsK49AMdRyzy2Xsplpj3z/bOkKMl1nUAm
	BFkdYg=
X-Received: by 2002:a05:690e:150f:b0:65c:477a:2ad7 with SMTP id 956f58d0204a3-66106f5006amr10333586d50.25.1780844725517;
        Sun, 07 Jun 2026 08:05:25 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:360a:d4cf:1c8d:f0c4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d64409e9sm8137906d50.15.2026.06.07.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 08:05:25 -0700 (PDT)
Date: Sun, 7 Jun 2026 11:05:24 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
Message-ID: <aiWFGUQRP-VCtlNr@zenbox>
References: <20260519011450.1144935-2-utilityemal77@gmail.com>
 <20260519015123.36096C2BCB7@smtp.kernel.org>
 <agxkV-hsdwhvMliI@suesslenovo>
 <agyG3eQwgmoJwmj2@suesslenovo>
 <DIMWGCWL1AG2.14F7CN23GMS8N@gmail.com>
 <aiRG9nsbRi2cO3XT@zenbox>
 <DJ2GXOXL4O0G.9DI5VYR6GUMU@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ2GXOXL4O0G.9DI5VYR6GUMU@gmail.com>

On Sun, Jun 07, 2026 at 04:40:58AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat Jun 6, 2026 at 6:27 PM CEST, Justin Suess wrote:
> > On Tue, May 19, 2026 at 09:27:58PM +0200, Kumar Kartikeya Dwivedi wrote:
> >> On Tue May 19, 2026 at 5:59 PM CEST, Justin Suess wrote:
> >> > On Tue, May 19, 2026 at 10:42:44AM -0400, Justin Suess wrote:
> >> >> Looks like this kfunc also tries to eagerly free fields and is callable
> >> >> from tp_btf/nmi_handler with no recovery mechanism.
> >> >>
> >> >> I don't see a good way to handle this at all... it also is effectively
> >> >> already bugged in the existing code unless I'm missing something
> >> >>
> >> >> Since you can use it to call abritrary dtors in NMI.
> >> >>
> >> >> 1.
> >> >>
> >> >> In some context where task_acquire is valid:
> >> >>
> >> >> struct blah {
> >> >>   struct task_struct __kptr* task;
> >> >> }
> >> >>
> >> >> b = bpf_task_acquire(...)
> >> >> a = bpf_obj_new(typeof(*blah_ptr));
> >> >> bpf_kptr_xchg(a->task, b);
> >> >>
> >> >> 2.
> >> >>
> >> >> Then xchg a into map
> >> >> bpf_kptr_xchg([map slot], a);
> >> >> ...
> >> >>
> >> >> 3.
> >> >>
> >> >> In tp_btf/nmi_handler we exchange the obj out of the map
> >> >> and then drop it.
> >> >>
> >> >> c = bpf_kptr_xchg([slot where a is stored], NULL);
> >> >> bpf_obj_drop(c);
> >> >>
> >> >> And because this can be called on an object not in a map, we don't have
> >> >> a good recovery mechanism.
> >> >>
> >> >> Because tp_btf/nmi_handler is always in_nmi and hence irqs_disabled, in
> >> >> the code before this patch the task_struct dtor will be invoked and
> >> >> cause a deadlock.
> >> >>
> >> >> This patch will not fix the issue and just free a struct blah holding the
> >> >> reference without actually dropping it.
> >> >>
> >> >> Unless I'm missing something then this whole approach taken by this
> >> >> patch can't handle this case since the bpf_obj is detached from the map
> >> >> entirely and has no allocator recovery mechanism at all.
> >> >>
> >> >> Then we are back to square 1 needing to defer the freeing with irq work.
> >> >>
> >> >> Kumar / Alexei do you have anything on this?
> >> >
> >> > I've confirmed this is a viable mechanism to deadlock as well
> >> >
> >> > Using the above approach, just exchanging out of a map and dropping the
> >> > bpf_obj containing a task_struct kptr can be used to cause a deadlock
> >> > outside any map path:
> >> >
> >> > On 576482b55c19e7ec00e162a0fde4c4f1a95128c7 (bpf-next/master) w/ RCU_NOCB_CPU/RCU_EXPERT:
> >> >
> >> >   [   10.773819] ================================
> >> >   [   10.773820] WARNING: inconsistent lock state
> >> >   [   10.773821] 7.1.0-rc2-g576482b55c19 #150 Not tainted
> >> >   [   10.773822] --------------------------------
> >> >   [   10.773822] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >> >   [   10.773823] test_progs/471 [HC1[1]:SC0[0]:HE0:SE1] takes:
> >> >   [   10.773825] ffff98623d66f0e8 (&rdp->nocb_lock){-.-.}-{2:2}, at: __call_rcu_common.constprop.0+0x54a/0x730
> >> >   [   10.773832] {INITIAL USE} state was registered at:
> >> >   [   10.773832]   lock_acquire+0xbf/0x2e0
> >> >   [   10.773835]   _raw_spin_lock+0x30/0x40
> >> >   [   10.773838]   rcu_nocb_gp_kthread+0x13f/0xb90
> >> >   [   10.773840]   kthread+0xf4/0x130
> >> >   [   10.773845]   ret_from_fork+0x264/0x330
> >> >   [   10.773848]   ret_from_fork_asm+0x1a/0x30
> >> >   [   10.773851] irq event stamp: 1127908
> >> >   [   10.773851] hardirqs last  enabled at (1127907): [<ffffffff87104484>] _raw_spin_unlock_irqrestore+0x44/0x60
> >> >   [   10.773853] hardirqs last disabled at (1127908): [<ffffffff871041a1>] _raw_spin_lock_irqsave+0x51/0x60
> >> >   [   10.773854] softirqs last  enabled at (1127782): [<ffffffff862e6b80>] __irq_exit_rcu+0xc0/0x100
> >> >   [   10.773857] softirqs last disabled at (1127777): [<ffffffff862e6b80>] __irq_exit_rcu+0xc0/0x100
> >> >   [   10.773858]
> >> >                  other info that might help us debug this:
> >> >   [   10.773859]  Possible unsafe locking scenario:
> >> >
> >> >   [   10.773859]        CPU0
> >> >   [   10.773859]        ----
> >> >   [   10.773860]   lock(&rdp->nocb_lock);
> >> >   [   10.773861]   <Interrupt>
> >> >   [   10.773861]     lock(&rdp->nocb_lock);
> >> >   [   10.773862]
> >> >                   *** DEADLOCK ***
> >> >
> >> >   [   10.773862] 4 locks held by test_progs/471:
> >> >   [   10.773863]  #0: ffffffff885ccaf0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1e39/0x2b80
> >> >   [   10.773866]  #1: ffff9861c33a2ff8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x83/0x990
> >> >   [   10.773871]  #2: ffff9861c1152ff8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0xc8/0x990
> >> >   [   10.773874]  #3: ffffffff885f43b8 (kmemleak_lock){-.-.}-{2:2}, at: __create_object+0x3a/0xa0
> >> >   [   10.773877]
> >> >                  stack backtrace:
> >> >   [   10.773879] CPU: 1 UID: 0 PID: 471 Comm: test_progs Not tainted 7.1.0-rc2-g576482b55c19 #150 PREEMPT(full)
> >> >   [   10.773881] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> >> >   [   10.773882] Call Trace:
> >> >   [   10.773883]  <NMI>
> >> >   [   10.773884]  dump_stack_lvl+0x5d/0x80
> >> >   [   10.773887]  print_usage_bug.part.0+0x22b/0x2c0
> >> >   [   10.773891]  lock_acquire+0x295/0x2e0
> >> >   [   10.773893]  ? __call_rcu_common.constprop.0+0x54a/0x730
> >> >   [   10.773896]  _raw_spin_lock+0x30/0x40
> >> >   [   10.773898]  ? __call_rcu_common.constprop.0+0x54a/0x730
> >> >   [   10.773899]  __call_rcu_common.constprop.0+0x54a/0x730
> >> >   [   10.773903]  bpf_obj_free_fields+0x118/0x250
> >> >   [   10.773907]  bpf_obj_drop+0x4f/0x80
> >> >   [   10.773910]  bpf_prog_b7ff9c2e6c583824_clear_task_kptrs_from_nmi+0x174/0x1f4
> >> >   [   10.773912]  bpf_trace_run3+0x126/0x430
> >> >   [   10.773916]  ? __pfx_perf_event_nmi_handler+0x10/0x10
> >> >   [   10.773919]  nmi_handle.part.0+0x15b/0x250
> >> >   [   10.773922]  ? __pfx_perf_event_nmi_handler+0x10/0x10
> >> >   [   10.773924]  default_do_nmi+0x120/0x180
> >> >   [   10.773927]  exc_nmi+0xe3/0x110
> >> >   [   10.773928]  end_repeat_nmi+0xf/0x53
> >> >   [   10.773931] RIP: 0010:__link_object+0xb4/0x270
> >> >   [   10.773932] Code: 00 00 00 48 c7 c6 80 36 bb 89 48 c7 43 70 00 00 00 00 48 c7 43 78 00 00 00 00 48 89 3d 35 62 50 03 eb 66 48 89 c8 48 8b 48 30 <48> 8d 70 10 48 39 d1 73 11 48 03 48 38 48 39 cf 0f 82 2f 01 00 00
> >> >   [   10.773933] RSP: 0018:ffffb516013b7a60 EFLAGS: 00000082
> >> >   [   10.773935] RAX: ffff9861c37b5c80 RBX: ffff9861df869878 RCX: ffff9861c3776420
> >> >   [   10.773936] RDX: ffff9861c3769e00 RSI: ffff9861c43564f8 RDI: ffff9861c3769d00
> >> >   [   10.773936] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000000
> >> >   [   10.773937] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9861c3769d00
> >> >   [   10.773937] R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000001
> >> >   [   10.773943]  ? __link_object+0xb4/0x270
> >> >   [   10.773945]  ? __link_object+0xb4/0x270
> >> >   [   10.773947]  </NMI>
> >> >   [   10.773947]  <TASK>
> >> >   [   10.773948]  __create_object+0x51/0xa0
> >> >   [   10.773951]  kmem_cache_alloc_from_sheaf_noprof+0x1e2/0x290
> >> >   [   10.773956]  mas_dup_build+0x41d/0x7f0
> >> >   [   10.773960]  __mt_dup+0x78/0xf0
> >> >   [   10.773967]  dup_mmap+0x12e/0x990
> >> >   [   10.773972]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >   [   10.773973]  ? lock_acquire+0xbf/0x2e0
> >> >   [   10.773979]  copy_process+0x1e45/0x2b80
> >> >   [   10.773985]  kernel_clone+0xbb/0x3d0
> >> >   [   10.773986]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >   [   10.773987]  ? __lock_acquire+0x481/0x2590
> >> >   [   10.773993]  __do_sys_clone+0x65/0x90
> >> >   [   10.773998]  do_syscall_64+0xa1/0x5f0
> >> >   [   10.774002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> >   [   10.774003] RIP: 0033:0x7f9da26e8f2f
> >> >   [   10.774005] Code: 89 e7 e8 c4 0e f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 59 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
> >> >   [   10.774005] RSP: 002b:00007ffc278b4540 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> >> >   [   10.774007] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9da26e8f2f
> >> >   [   10.774007] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> >> >   [   10.774008] RBP: 00007ffc278b4740 R08: 0000000000000000 R09: 0000000000000001
> >> >   [   10.774008] R10: 00007f9da2acaf10 R11: 0000000000000246 R12: 0000000000000003
> >> >   [   10.774009] R13: 0000000000000001 R14: 0000000000000000 R15: 00005625de8b38d0
> >> >   [   10.774014]  </TASK>
> >> >   [   10.866584] perf: interrupt took too long (6193 > 6190), lowering kernel.perf_event_max_sample_rate to 32000
> >> >   [   16.630663] kauditd_printk_skb: 30 callbacks suppressed
> >> >
> >> > I can give the reproducer if wished.
> >> >
> >> > You can see the path involves bpf_obj_drop and not any map methods at
> >> > all.
> >> >
> >> > But basically this makes the whole mechanism of relying on map allocators to
> >> > recycle and free objects in irqs_disabled contexts unsound because kptrs
> >> > can live and be released outside map contexts.
> >>
> >> The approach in this version is still different than what I had proposed. For
> >> the particular case you highlighted, we should just reject bpf_obj_drop() in
> >> is_tracing_prog_type() once the object has kptr fields etc. If someone still
> >> wants it they should just use bpf_wq to defer manually.
> >>
> > Would you be opposed to me submitting a fix for *just* the bpf_obj_drop case?
> >
> > Since your proposed solution for that is just a tiny verifier fix w/ btf_record_has_field and a prog_type check and is mostly unrelated to this fix for the map cases.
> >
> > It's a small fix, but just don't want to be rude and submit anything if
> > you're working on that too in your patch. :)
> >
> > Thanks for your guidance with this fix in general and apologize for my
> > misinterpretation of the intended route.
> 
> Unfortunately I already prepared it, though for both fixes I already kept your
> authorship since you've put in so much effort in reporting, reproducing, and
> testing various fixes, the adjustments might as well have been done by you
> rather than me.
> 
> I will send it later today, once I do, please help in reviewing and testing
> corner cases in the fixes. Reviewing code will be more appreciated than cranking
> out new code, there are few people who can do that.
> 
> Thanks
>
No worries! thanks. All that matters is the code, not who writes it.
kernel dev is just a hobby for me so all that work was for fun anyways.
Once you send it I'll apply it and poke around at the corner cases and
see if I can make it splat again.

Justin
> >
> > Kind Regards,
> > Justin
> >> The whole prealloc related change to the map is unnecessary, as I said before.
> >> It's an orthogonal change. We should also not use irqs_disabled() and just do
> >> the skipping unconditionally.
> >>
> >> Let me work on a patch, since the nuance is obviously getting lost in email.
> 
