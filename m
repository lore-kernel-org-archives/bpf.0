Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E373F0750
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206386; cv=none; b=Arh49cX8wHPLeb0w2huc8GEZQni9kFQLguTQj8c1dYZ+2KxuGmQWdjRGvG2U0hi1ySr7lo7l/VT8rIn+JCOrZhR3rOK6+m4UPg1nWE0EVvUeGmFOQsS9vC2LOJasrkXSzgDgzuzz043nHDevahdZLIpVYGSfB/1nR9nVxo1uQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206386; c=relaxed/simple;
	bh=nykLOr1WLOFWPRuLtKT2wTDTxQL2mr+i+dTaw9bLIQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew3bpHYY94p/w4UmxQ4VuMSfe5KWVtqijYrWGqs86e3zSdu8sw1SPAERlUWiZErG/NZl/NRqRB7qlAupXrn5t9xzMmku8FHXtdBo+MQuHRc8BeCcDu4bpoRx+Cvgt329lW4hzkAv9oUc69VMv7qq54mxhIRRoPrkkOyUOn8DQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8RM7rHC; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8RM7rHC"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c37eafcbeso4129967d50.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206384; x=1779811184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JU+lR8hoAXS3wTLdjhEZIsGESiIR7qGmmZAiVEmImkQ=;
        b=k8RM7rHCLIiAzHP0MzJ+4x6ZNjKLQDRmstNF+lWG/mm+n4N55iVLiqnVAbgAwUMYEg
         QGG0oueca1OusWIWtTlpHFT3luXd3HIw4r88ME6zJLC9/mrhf866s4MnfJm84lA/LILT
         Ih8Bb6XSwQemngGZFq7ucRsgcnfY9KUdGU0hIJZu2jQv5ulPgXhiUtauBI3jF/e7ynaA
         j513urbbLV45JXF1Dcr9BjSQWIgL2aEuJ00PyYjrLaGyBsdIB1cuxU25DyRs7tu/Vp3m
         Z5cfU8rfY8osArTwM44jffDZzNnb/It7tq5pGyKsKD7GhfWkTGb9QmsYkL6Z0krO/anv
         P+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206384; x=1779811184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU+lR8hoAXS3wTLdjhEZIsGESiIR7qGmmZAiVEmImkQ=;
        b=RDT0Cd8N7pFxKlFALjyblvQIbzaV5m64p2OHg2Sh3uS4qKUGJyblyRZ7f4mr+SAX3C
         3UbIgiTeDPWCsUXALDL/nuIGFdGLNeTDl+rzFmuHl5WyYKVw3R0MAgKoiwAd0QmJZsfF
         3+G6nUBDh9KvEJMfqgoNwgEjfzWIOcVT7jNp65LGxU4iBZfUR7toJQNEoGQstHsVLrD1
         BRBfwwMjtyfP+ZkJLlsdbJ0SOlaEOrjieVxa5ClFn/F9pbj6XqzrDHatOMzTDyOhYw/X
         i9MNDjYvIqYa4m+/iw72ht88nVnyAjCTjsVHI5JhZFpkcdSZLj/P4mm7i8XX845ANUGO
         w4yQ==
X-Gm-Message-State: AOJu0Yy2/kiAM40lh3FiTCi6jIj4BOiBOkqW2QkPReWNQvObvFZy/aLP
	nFEM2p3KncmdkGL7JHtvt7RkVWtcm4pR3Z0YiKbnibxV1t4wRZKp1yMdvK7GBw==
X-Gm-Gg: Acq92OH2XN1BzfIzWah/SDgwiAzv0MKbqHiqrRaPMbw/ooajwQcrtqIJ2fg5YA1ZFTC
	0sLbuKnaf6Nosmym/tZFMoMoC5ak9it3i5CK6bN1zSX1yApxECPMUudx7kwPDM0dvL8sc7+aglL
	vlbZ8+G9XgSk8AXTbqJnnj/hMn4qywMT9sJWbQ2SzR5BADZTRusofcK4BtLLrzs98+W2aB6nvQJ
	a7CGvgSxUH63IfpQfMdyLg5spqcn4BsinyswLhajwWXOMGZ9XoGVHHIZwETN2JozmJi+UKJh/T6
	xa2kWjra/0/t6vl0HSw+izwO04lcbYRkvefh8kYyLJ1P4uiEieNBZUw2ugTrRWMZqZo3dTmy8Ka
	Cg9GJIVIYeYQ0OsKbWfzxkGl8pHmdynB36+oT0gzzwMMUr8US7G7yRfWVjA7dd56RmVvz5LjyFP
	USXzk5pxspXXOx4RubR7ybQdgM1Is9N8gU5gHOHMLBhqSmOYU/3dglkp8n6DDmQOgieVrH
X-Received: by 2002:a05:690e:1699:b0:651:c160:1c06 with SMTP id 956f58d0204a3-65e22894396mr20382137d50.58.1779206383590;
        Tue, 19 May 2026 08:59:43 -0700 (PDT)
Received: from suesslenovo ([98.97.172.65])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e701fsm8034150d50.8.2026.05.19.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:59:43 -0700 (PDT)
Date: Tue, 19 May 2026 11:59:42 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
Message-ID: <agyG3eQwgmoJwmj2@suesslenovo>
References: <20260519011450.1144935-2-utilityemal77@gmail.com>
 <20260519015123.36096C2BCB7@smtp.kernel.org>
 <agxkV-hsdwhvMliI@suesslenovo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxkV-hsdwhvMliI@suesslenovo>

On Tue, May 19, 2026 at 10:42:44AM -0400, Justin Suess wrote:
> Looks like this kfunc also tries to eagerly free fields and is callable
> from tp_btf/nmi_handler with no recovery mechanism.
> 
> I don't see a good way to handle this at all... it also is effectively
> already bugged in the existing code unless I'm missing something
> 
> Since you can use it to call abritrary dtors in NMI.
> 
> 1. 
> 
> In some context where task_acquire is valid:
> 
> struct blah {
>   struct task_struct __kptr* task;
> }
> 
> b = bpf_task_acquire(...)
> a = bpf_obj_new(typeof(*blah_ptr));
> bpf_kptr_xchg(a->task, b);
> 
> 2. 
> 
> Then xchg a into map
> bpf_kptr_xchg([map slot], a);
> ...
> 
> 3. 
> 
> In tp_btf/nmi_handler we exchange the obj out of the map
> and then drop it.
> 
> c = bpf_kptr_xchg([slot where a is stored], NULL);
> bpf_obj_drop(c); 
> 
> And because this can be called on an object not in a map, we don't have
> a good recovery mechanism.
> 
> Because tp_btf/nmi_handler is always in_nmi and hence irqs_disabled, in
> the code before this patch the task_struct dtor will be invoked and
> cause a deadlock.
> 
> This patch will not fix the issue and just free a struct blah holding the
> reference without actually dropping it.
> 
> Unless I'm missing something then this whole approach taken by this
> patch can't handle this case since the bpf_obj is detached from the map
> entirely and has no allocator recovery mechanism at all.
> 
> Then we are back to square 1 needing to defer the freeing with irq work.
> 
> Kumar / Alexei do you have anything on this?

I've confirmed this is a viable mechanism to deadlock as well

Using the above approach, just exchanging out of a map and dropping the
bpf_obj containing a task_struct kptr can be used to cause a deadlock
outside any map path:

On 576482b55c19e7ec00e162a0fde4c4f1a95128c7 (bpf-next/master) w/ RCU_NOCB_CPU/RCU_EXPERT:

  [   10.773819] ================================
  [   10.773820] WARNING: inconsistent lock state
  [   10.773821] 7.1.0-rc2-g576482b55c19 #150 Not tainted
  [   10.773822] --------------------------------
  [   10.773822] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  [   10.773823] test_progs/471 [HC1[1]:SC0[0]:HE0:SE1] takes:
  [   10.773825] ffff98623d66f0e8 (&rdp->nocb_lock){-.-.}-{2:2}, at: __call_rcu_common.constprop.0+0x54a/0x730
  [   10.773832] {INITIAL USE} state was registered at:
  [   10.773832]   lock_acquire+0xbf/0x2e0
  [   10.773835]   _raw_spin_lock+0x30/0x40
  [   10.773838]   rcu_nocb_gp_kthread+0x13f/0xb90
  [   10.773840]   kthread+0xf4/0x130
  [   10.773845]   ret_from_fork+0x264/0x330
  [   10.773848]   ret_from_fork_asm+0x1a/0x30
  [   10.773851] irq event stamp: 1127908
  [   10.773851] hardirqs last  enabled at (1127907): [<ffffffff87104484>] _raw_spin_unlock_irqrestore+0x44/0x60
  [   10.773853] hardirqs last disabled at (1127908): [<ffffffff871041a1>] _raw_spin_lock_irqsave+0x51/0x60
  [   10.773854] softirqs last  enabled at (1127782): [<ffffffff862e6b80>] __irq_exit_rcu+0xc0/0x100
  [   10.773857] softirqs last disabled at (1127777): [<ffffffff862e6b80>] __irq_exit_rcu+0xc0/0x100
  [   10.773858]
                 other info that might help us debug this:
  [   10.773859]  Possible unsafe locking scenario:
  
  [   10.773859]        CPU0
  [   10.773859]        ----
  [   10.773860]   lock(&rdp->nocb_lock);
  [   10.773861]   <Interrupt>
  [   10.773861]     lock(&rdp->nocb_lock);
  [   10.773862]
                  *** DEADLOCK ***
  
  [   10.773862] 4 locks held by test_progs/471:
  [   10.773863]  #0: ffffffff885ccaf0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1e39/0x2b80
  [   10.773866]  #1: ffff9861c33a2ff8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x83/0x990
  [   10.773871]  #2: ffff9861c1152ff8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0xc8/0x990
  [   10.773874]  #3: ffffffff885f43b8 (kmemleak_lock){-.-.}-{2:2}, at: __create_object+0x3a/0xa0
  [   10.773877]
                 stack backtrace:
  [   10.773879] CPU: 1 UID: 0 PID: 471 Comm: test_progs Not tainted 7.1.0-rc2-g576482b55c19 #150 PREEMPT(full)
  [   10.773881] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  [   10.773882] Call Trace:
  [   10.773883]  <NMI>
  [   10.773884]  dump_stack_lvl+0x5d/0x80
  [   10.773887]  print_usage_bug.part.0+0x22b/0x2c0
  [   10.773891]  lock_acquire+0x295/0x2e0
  [   10.773893]  ? __call_rcu_common.constprop.0+0x54a/0x730
  [   10.773896]  _raw_spin_lock+0x30/0x40
  [   10.773898]  ? __call_rcu_common.constprop.0+0x54a/0x730
  [   10.773899]  __call_rcu_common.constprop.0+0x54a/0x730
  [   10.773903]  bpf_obj_free_fields+0x118/0x250
  [   10.773907]  bpf_obj_drop+0x4f/0x80
  [   10.773910]  bpf_prog_b7ff9c2e6c583824_clear_task_kptrs_from_nmi+0x174/0x1f4
  [   10.773912]  bpf_trace_run3+0x126/0x430
  [   10.773916]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   10.773919]  nmi_handle.part.0+0x15b/0x250
  [   10.773922]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   10.773924]  default_do_nmi+0x120/0x180
  [   10.773927]  exc_nmi+0xe3/0x110
  [   10.773928]  end_repeat_nmi+0xf/0x53
  [   10.773931] RIP: 0010:__link_object+0xb4/0x270
  [   10.773932] Code: 00 00 00 48 c7 c6 80 36 bb 89 48 c7 43 70 00 00 00 00 48 c7 43 78 00 00 00 00 48 89 3d 35 62 50 03 eb 66 48 89 c8 48 8b 48 30 <48> 8d 70 10 48 39 d1 73 11 48 03 48 38 48 39 cf 0f 82 2f 01 00 00
  [   10.773933] RSP: 0018:ffffb516013b7a60 EFLAGS: 00000082
  [   10.773935] RAX: ffff9861c37b5c80 RBX: ffff9861df869878 RCX: ffff9861c3776420
  [   10.773936] RDX: ffff9861c3769e00 RSI: ffff9861c43564f8 RDI: ffff9861c3769d00
  [   10.773936] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000000
  [   10.773937] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9861c3769d00
  [   10.773937] R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000001
  [   10.773943]  ? __link_object+0xb4/0x270
  [   10.773945]  ? __link_object+0xb4/0x270
  [   10.773947]  </NMI>
  [   10.773947]  <TASK>
  [   10.773948]  __create_object+0x51/0xa0
  [   10.773951]  kmem_cache_alloc_from_sheaf_noprof+0x1e2/0x290
  [   10.773956]  mas_dup_build+0x41d/0x7f0
  [   10.773960]  __mt_dup+0x78/0xf0
  [   10.773967]  dup_mmap+0x12e/0x990
  [   10.773972]  ? srso_alias_return_thunk+0x5/0xfbef5
  [   10.773973]  ? lock_acquire+0xbf/0x2e0
  [   10.773979]  copy_process+0x1e45/0x2b80
  [   10.773985]  kernel_clone+0xbb/0x3d0
  [   10.773986]  ? srso_alias_return_thunk+0x5/0xfbef5
  [   10.773987]  ? __lock_acquire+0x481/0x2590
  [   10.773993]  __do_sys_clone+0x65/0x90
  [   10.773998]  do_syscall_64+0xa1/0x5f0
  [   10.774002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [   10.774003] RIP: 0033:0x7f9da26e8f2f
  [   10.774005] Code: 89 e7 e8 c4 0e f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 59 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
  [   10.774005] RSP: 002b:00007ffc278b4540 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
  [   10.774007] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9da26e8f2f
  [   10.774007] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
  [   10.774008] RBP: 00007ffc278b4740 R08: 0000000000000000 R09: 0000000000000001
  [   10.774008] R10: 00007f9da2acaf10 R11: 0000000000000246 R12: 0000000000000003
  [   10.774009] R13: 0000000000000001 R14: 0000000000000000 R15: 00005625de8b38d0
  [   10.774014]  </TASK>
  [   10.866584] perf: interrupt took too long (6193 > 6190), lowering kernel.perf_event_max_sample_rate to 32000
  [   16.630663] kauditd_printk_skb: 30 callbacks suppressed

I can give the reproducer if wished.

You can see the path involves bpf_obj_drop and not any map methods at
all.

But basically this makes the whole mechanism of relying on map allocators to
recycle and free objects in irqs_disabled contexts unsound because kptrs
can live and be released outside map contexts.

