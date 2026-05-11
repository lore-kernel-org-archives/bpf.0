Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8E44B690
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517523; cv=none; b=eeYKnpKqh4LQZ38srpnz3M0aOXZ8EHCGYKf5P1je2LSmOjphVeZDuIJeVai2zY5vamvluuoqI3TOtBc7qTPIWPbqFdSvtU9eiOUm7Labl7Ad7JKtWwRCwOmVHKTWOYFvubFcijE2jUMZLX7kfIMipodCNT4v4ThVxguiyTg9v5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517523; c=relaxed/simple;
	bh=5EDMw3+WmGH82GtPr7oiAqeNJaohNreEgo4Ks8Pc/TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4Qpvi/ieP2oC1AWh9yioKM5IIwkd3/rljqp28a09rKkwT8u1TUU1NCxGu4lW8xYCFKzg+31kDW/dMitFbP01F8min/KvCpfaYCu8SnuNHt2EIu6z7M66j1zln5j5vTSr0f5OtB+xs9Z/dfxtkJWunbIy0gVSkBh3UxZXq0Fc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASFYe19M; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASFYe19M"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bc83e74aso4677222d50.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517520; x=1779122320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PVKGSBgg7Bi+A/DTuZv6tFd+KJqyq9tjBPa5WQIopE=;
        b=ASFYe19MTSyVjZerJI9w0VWnxfxnw+WaXYFZVZgxIPu2h9p0SG1Ynjp/mN8PV7aUTq
         YnD5iclC7bzMM5z1bOTshMIs1GCYKpz0R19UmZLcBXY4Xp79UOiykbyW+7lXMHMuFxyD
         TKtZnquV56zMcnLCPkIPxjfSunVoqtiU4PqL/q1lrDpXdo304dcFKBfxynZ0tbmOsBJ3
         dGr13eNLDlvnf1t71hHnplIKR72jGh6D4bw9C24Fz7EDkeWCGDruP8A/9IiTX8SEbC/i
         U2h3Xpl4cdX07gTHRrMfugwer/uCHM/W2D2LkGWmOCt10o8JZvL/o+2icVDVcSXlO3Cr
         AWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517520; x=1779122320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PVKGSBgg7Bi+A/DTuZv6tFd+KJqyq9tjBPa5WQIopE=;
        b=p7lAQollJ0/TqOHqsj1I5bSBMiCvdrlOXo5MoYdMfn6aKjFjtfP4h31xXaJyOWEYQy
         UmJjg7FpP33ETkrzLQe+agkt0dF028J8bhu+HaJoMPie3SfAzOJGKgtbmBnvpsxsucmv
         qpL786eA58ZjN2VrkmOa/dwPzCfz54hbQDe5On2N+4URrCbKdUGWK/6C2RrMyMIYoI55
         S8b8WnRlnjj9Zi8H+Rmt/O4yeH8NZ9qyn2DtqWlmlGNDetKC5wMl+Qnp7+Jbdj2aDgWo
         co0sGB9jyIipjgBO+8uv/Nv8pId+iBdyni/z55lSrINj6pszgH9fhulbJGJUyxrv/ngv
         r58g==
X-Forwarded-Encrypted: i=1; AFNElJ+NYu/HfcniQPKZkI/Ou9MjG4u+uPcLfLPDM3WZwYHXUNX9gVcRmvT8j5DrW6B4veD4koI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlu+amafwCYLFmif2P6EsY5B/nNFtbIhD3kubLhhyESKJ254x
	TzhyJQaMWxqGIvP9z5TP3lc0EbKs0HU1kLHpXl0ExbZcWQcqGeMISQHJ
X-Gm-Gg: Acq92OEVjWjI5jYMukiuZwxzjOtfDRqKlk3fZXW9bvjevMuzzIC5z/HSPcWzPVgcp+3
	VUT2f4TNp72zHEWvJjnOxnqGFHTtwiSlmm6o8tNhYC7jY6BrJcs/g0o6WADVUeG/EIHinBtfKD+
	RWRqULXSzUEt/i99i04FsIweYharlRUKPtilPbwfh+MGlSQVlJC1jb7Hm0d2QkB3r1WvSCTEtuU
	Bgr+LrgsM5oxQxwCm9I1gj9rEzuvT9SB2kMjk+kuC1fs5sWjj504qcOZ9OID2Kb6pugUMaI/G++
	NsbdOWBuKLPO3gBZsWb/sR2DYwbWqORQIgTZNeYXGTarp6zefsTVxiY5j1pJu+Mbz482y32iCRC
	oJiINEVUE+kWdchrYB0KXzZ4MDlGNPI0gD20hBBtS0CiCdjBc7Niy4UTaaj+uAtsJmIGnY7kYVL
	Bv+hWp9aFz08D151gObAOOtE8OEyx2JnrPQoOAMiav5EtxthtXh4eq2fVAIX0=
X-Received: by 2002:a05:690e:1590:20b0:658:ac79:ad4d with SMTP id 956f58d0204a3-65c79df1c93mr18588170d50.47.1778517520215;
        Mon, 11 May 2026 09:38:40 -0700 (PDT)
Received: from suesslenovo ([74.244.55.239])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96a57621sm5593685d50.8.2026.05.11.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:38:39 -0700 (PDT)
Date: Mon, 11 May 2026 12:38:39 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agH_0MEw4b0pB11-@suesslenovo>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org>
 <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox>
 <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>

On Mon, May 11, 2026 at 08:51:53AM -0700, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 6:49 PM PDT, Justin Suess wrote:
> > On Sun, May 10, 2026 at 03:38:08PM -0700, Alexei Starovoitov wrote:
> >> On Sun, May 10, 2026 at 8:14 AM Justin Suess <utilityemal77@gmail.com> wrote:
> >> >
> >> >
> >> > Any help or guidance on this would be appreciated!
> >> 
> >> sorry for the delay. Everyone was at lsfmmbpf for a week+.
> >> 
> >
> > No worries! I hope it was an enjoyable trip and I look forward to
> > hearing about the conference.
> >
> >> All of the solutions so far are way too complicated.
> >> bpf_kptr_xchg() has to remain inlined as single atomic xchg
> >> without slowpath otherwise it ruins the concept
> >> and makes usage unpredictable.
> >> 
> >> Let's step back.
> >> What is the issue you're trying to solve?
> >> 
> >> the commit log say:
> >> 
> >> > A BPF program attached to tp_btf/nmi_handler can delete map entries or
> >> > swap out referenced kptrs from NMI context. Today that runs the kptr
> >> > destructor inline. Destructors such as bpf_cpumask_release() can take
> >> > RCU-related locks, so running them from NMI can deadlock the system.
> >> 
> >> and looking at selftest from patch 2 you do:
> >> 
> >> old = bpf_kptr_xchg(&value->mask, old);
> >> if (old)
> >>   bpf_cpumask_release(old);
> >> 
> >> so?
> >> bpf_cpumask_release() is fine to call from any context,
> >> because bpf_mem_cache_free_rcu() is safe everywhere including NMI.
> >>
> >
> > My mistake on that. I picked a bad example for the test, but the test is
> > just exercising the nmi dtor path, and doesn't rely on the particular
> > type of kptr. I just picked one that was easy to acquire a reference to.
> >
> > This dtor is safe. task_struct dtor, cgroup dtor, crypto_ctx dtor are
> > not. I've annotated why here:
> >
> > crypto_ctx:
> >
> >   __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
> >   {
> >   	if (refcount_dec_and_test(&ctx->usage))
> >   		call_rcu(&ctx->rcu, crypto_free_cb); /* UNSAFE: call_rcu */
> >   }
> >   
> >   __bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
> >   {
> >   	bpf_crypto_ctx_release(ctx);
> >   }
> 
> bpf_crypto_ctx_release() is only allowed in syscall prog types
> and dtor via hashmap free will execute in safe context as well.
> So not an issue.
>
It doesn't matter if bpf_crypto_ctx_release is only allowed in syscall
program types; we don't need that to invoke it from a tracing program.
All we have to do is delete a map element with that type of kptr already
in it.

The release function is not the issue, it's bpf_map_delete_elem, which
ultimately invokes bpf_obj_free_fields and then the dtor.

Hashmap free doesn't execute in safe context. See the kernel splat
below.

> > task_struct:
> >
> >   __bpf_kfunc void bpf_task_release(struct task_struct *p)
> >   {
> >   	put_task_struct_rcu_user(p);
> >   }
> >   
> >   __bpf_kfunc void bpf_task_release_dtor(void *p)
> >   {
> >   	put_task_struct_rcu_user(p);
> >   }
> >
> >   void put_task_struct_rcu_user(struct task_struct *task)
> >   {
> >   	if (refcount_dec_and_test(&task->rcu_users))
> >   		call_rcu(&task->rcu, delayed_put_task_struct); /* UNSAFE: call_rcu
> >       */
> >   }
> 
> In theory. I don't think there is a reproducer.
>
I sent the wrong link in my reply. apologies.

This does indeed reproduce, even on bpf-next/master.

Using this reproducer:
https://gist.githubusercontent.com/RazeLighter777/5539336d79ab1854f9e9550c6dcab118/raw/082f1eeb2dd445936e64dd3a33861764690bde82/task_struct_dtor_deadlock.patch

On the latest bpf-next/master : "7e033543a2ab: Merge
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.1-rc3":

With these kconfig options set (not necessary, but increase
reproducibility):
  [justin@zenbox linux-next (repro $%)]$ rg 'RCU_NOCB|RCU_EXPERT' .config
  171:CONFIG_RCU_EXPERT=y
  188:CONFIG_RCU_NOCB_CPU=y

Run ./test_progs -t task_kptr_nmi_deadlock_repro

  [   21.604612] ================================
  [   21.604612] WARNING: inconsistent lock state
  [   21.604613] 7.1.0-rc2-g7e033543a2ab #126 Tainted: G           OE      
  [   21.604614] --------------------------------
  [   21.604615] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  [   21.604616] test_progs/494 [HC1[1]:SC0[0]:HE0:SE1] takes:
  [   21.604617] ffffa2077d66f0e8 (&rdp->nocb_lock){....}-{2:2}, at: __call_rcu_common.constprop.0+0x309/0x730
  [   21.604625] {INITIAL USE} state was registered at:
  [   21.604625]   lock_acquire+0xbf/0x2e0
  [   21.604628]   _raw_spin_lock+0x30/0x40
  [   21.604632]   rcu_nocb_gp_kthread+0x13f/0xb90
  [   21.604633]   kthread+0xf4/0x130
  [   21.604636]   ret_from_fork+0x264/0x330
  [   21.604639]   ret_from_fork_asm+0x1a/0x30
  [   21.604642] irq event stamp: 194
  [   21.604642] hardirqs last  enabled at (193): [<ffffffff9700012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [   21.604644] hardirqs last disabled at (194): [<ffffffff980e7f4f>] exc_nmi+0x7f/0x110
  [   21.604646] softirqs last  enabled at (0): [<ffffffff972d9838>] copy_process+0xfd8/0x2b80
  [   21.604648] softirqs last disabled at (0): [<0000000000000000>] 0x0
  [   21.604650] 
                 other info that might help us debug this:
  [   21.604651]  Possible unsafe locking scenario:
  
  [   21.604651]        CPU0
  [   21.604651]        ----
  [   21.604652]   lock(&rdp->nocb_lock);
  [   21.604653]   <Interrupt>
  [   21.604653]     lock(&rdp->nocb_lock);
  [   21.604654] 
                  *** DEADLOCK ***
  
  [   21.604654] no locks held by test_progs/494.
  [   21.604655] 
                 stack backtrace:
  [   21.604657] CPU: 1 UID: 0 PID: 494 Comm: test_progs Tainted: G           OE       7.1.0-rc2-g7e033543a2ab #126 PREEMPT(full) 
  [   21.604659] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  [   21.604660] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  [   21.604660] Call Trace:
  [   21.604662]  <TASK>
  [   21.604663]  dump_stack_lvl+0x5d/0x80
  [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
  [   21.604669]  lock_acquire+0x295/0x2e0
  [   21.604671]  ? terminate_walk+0x33/0x160
  [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
  [   21.604679]  _raw_spin_lock+0x30/0x40
  [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
  [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
  [   21.604686]  bpf_obj_free_fields+0x118/0x250
  [   21.604691]  free_htab_elem+0x85/0xd0
  [   21.604694]  htab_map_delete_elem+0x168/0x230
  [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
  [   21.604700]  bpf_trace_run3+0x126/0x430
  [   21.604703]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   21.604707]  nmi_handle.part.0+0x15b/0x250
  [   21.604710]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   21.604712]  default_do_nmi+0x120/0x180
  [   21.604715]  exc_nmi+0xe3/0x110
  [   21.604717]  asm_exc_nmi+0xb7/0x100
  [   21.604722] RIP: 0033:0x7fd27529a7ee
  [   21.604724] Code: ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 48 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18 e8 63 ff ff ff 5a <59> 48 3d 00 f0 ff ff 77 09 48 83 c4 08 c3 0f 1f 40 00 48 8b 15 e9
  [   21.604725] RSP: 002b:00007ffe5e3eca08 EFLAGS: 00000202
  [   21.604726] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd2756cef48
  [   21.604727] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 000000000000000c
  [   21.604728] RBP: 00007ffe5e3ecae0 R08: 0000000000000000 R09: 0000000000000000
  [   21.604728] R10: 0000000000000000 R11: 00007fd2756cec40 R12: 0000000000000003
  [   21.604729] R13: 00007fd275887000 R14: 00007ffe5e3eceb8 R15: 000055cd1271d8d0
  [   21.604734]  </TASK>
  [   21.666237] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
  [   21.691290] perf: interrupt took too long (3144 > 3126), lowering kernel.perf_event_max_sample_rate to 63000
  [   21.730227] perf: interrupt took too long (3932 > 3930), lowering kernel.perf_event_max_sample_rate to 50000
  [   21.805475] perf: interrupt took too long (4916 > 4915), lowering kernel.perf_event_max_sample_rate to 40000
  

> > cgroup_release_dtor is more complex, goes through ultimately through
> > callbacks to:
> >
> >   static void css_release(struct percpu_ref *ref)
> >   {
> >   	struct cgroup_subsys_state *css =
> >   		container_of(ref, struct cgroup_subsys_state, refcnt);
> >   
> >   	INIT_WORK(&css->destroy_work, css_release_work_fn);
> >   	queue_work(cgroup_release_wq, &css->destroy_work); /* UNSAFE:
> >     workqueue */
> >   }
> 
> similar to task_struct. I don't think it's exploitable.
> 
> > More generally, unless it's a BPF allocated object or doesn't rely on
> > locking/call_rcu or workqueues, the dtor is unsafe.
> >
> >> hashtab introduced dtor in bpf_mem_alloc,
> >> so bpf_obj_free_fields() and corresponding dtor's of kptr-s
> >> are called from valid context.
> >> 
> >> What is the problematic sequence?
> >
> > So from the beginning stepping back.
> >
> > The problematic sequence:
> >
> > 1. ref kptr (i.e task_struct, cgroup, crypto_ctx) xchg'd into map. 
> >
> > 2. in a tp_btf/nmi_handler (NMI CTX) program we drop the item from the map
> >    with that referenced kptr field.
> >
> > 3. dtor runs in the nmi context
> >
> > 4. dtor runs call_rcu/queue_work/some bad thing in nmi, causing deadlock.
> >
> > You can see this demonstrated in my task_struct reproducer [1].
> 
> did you?
> That link points to your v2 with cpumask.
> I don't recall seeing task_struct repro.
> 
I misplaced the link. See above
> > It causes a deadlock by deliberately releasing the last reference to a
> > task_struct via a ref kptr in nmi, getting it to call_rcu and deadlock.
> >
> > The typical solution to this is to run the nmi unsafe code in non-nmi
> > context by offloading to NMI work, as you proposed.
> >
> > The problem is we need space to for the jobs we enqueue. The required
> > information to run the dtor is the dtor function and the original object
> > pointer. The number of dtors that can run in a single tp_btf/nmi_handler
> > prog is nearly unbounded.
> >
> > The other problem is even though bpf_mem_alloc is safe in NMI generally,
> > we cannot allocate in path that destroys an object. If the allocation
> > fails due to memory pressure, we leak the object.
> >
> > There are a few options, all with drawbacks.
> >
> > 1. Dynamically allocate the job. Non-starter, failing to allocate is
> > unrecoverable, memory pressure means we can't ever schedule the dtor to
> > run.
> >
> > 2. Store job ntrusively in the object : Requires a safe place to place
> > it within the object. Bad because not all objects have a space we can write to.
> > Non-starter.
> >
> > 3. Within the map slot (after actual kptr): Taken with my initial approach in v1.
> > Significant complexity and requires per-map changes. Feasible but very
> > complex and would need DCAS or locking to make updating the map slot and
> > our job information atomic.
> >
> > 4. Wrapping the kptr in a box and storing it in place of the kptr [2] :
> > Proposed by Mykyta. Would break direct load access to kptr objects.
> >
> > 5. Make every dtor nmi safe individually. This would require a lot of
> > duplicated code and require updating every destructor invididually.
> > Feasible technically, but seems brittle.
> >
> > 6. One that would be the least complex, would be forbidding xchg operations
> > that can run the dtor in NMI context. That would preserve the inlining fix,
> > but limit our usage of referenced kptrs in BPF programs that run in NMI context.
> >
> > The approach here:
> >
> > 7. Allocate a new spot for a free job every time we xchg into the map
> > and put it in a global list. When in NMI and we run a dtor, we pop a
> > job from that slot and use it to offload our work via irq_work. If
> > we're not in NMI we run normally. Downside is this breaks inlining for
> > ref kptrs.
> >
> > ...
> >
> > I may be missing something critical, but everything I've looked at
> > points to this problem being much more complex that it initially seemed.
> 
> yes. it is complex. all 7 options are not good.
> 
Agreed. None of them are good but I just don't see any good
alternatives.
> I recall the whole thing started with desire to add bpf_put_file_dtor().
> This was discussed with VFS maintainers and they didn't like the idea,
> since it needs a ton of work to make it safe:
> . umount notifier to make sure stashed file doesn't hold umount
> . potential circular refcnt issue if file to bpf map stashed into the same map
> . scm_rights-like facility with garbage collection
> 
> So generic file stash is really no go.

That may be the case; but this is a seprate issue. This would be a
bug that could apply to future new refcounted kptrs as well.

Thanks,
Justin
