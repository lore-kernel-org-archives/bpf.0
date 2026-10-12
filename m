Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36838381EBD
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813407; cv=pass; b=k5hA2UWhinRJsdaU9UiufG4GzowUUN6gf2gTJ3bMG85Jl931GjaHeHzpo08JH3YXyk054nfV8P/7ZLr9sfCEWypc8hs7E6A/LfMDhrvbLX7wLIvkoEkZJZO7GVI4kh0XEnJd05+X1KMY8UnBZ0Z5HOZpCRtoEyakDT18IAck92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813407; c=relaxed/simple;
	bh=AXk7YQzZGdPsV1Y19stqR/+N6Eth+uynV8aOKDjd7qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC4sJs/UbHyIx1Pe6TagDxjn/KnpeXCVeZQrTuqg407sQ6nxDXuFMZdvjqpS9/sOslCv6B7mgr40UY+4G5oJP4hd4r3o4BJp/vfjmZnlhJJEeM+aycY4cW10+B8P+5l1uxbncwRgeWcI8p8MQd1dNyrPdRjyCbOrkn8c1aqYoaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcY14mDn; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcY14mDn"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8871ada1a26so11029977b3.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813405; cv=none;
        d=google.com; s=arc-20260327;
        b=g1xfo9lVz7e/Y0XFgsmnJnuVHa3oWDnvfi4+B5wRCTZpqEBwKZFGTpGLvNnq2C4JuN
         gkZBSBgrIecp3+RjscsbLeTSfQh7MdsOVvLgG17DxgjVtTaPQNawus3ybbHA13T1Dn7V
         r1oss/iO66myxAAak5eRM9j+uINO8uk6Yl6VFomVQ90d+LVy4NwGOHBl57Ovy0bnMfdm
         02+DAs+fjFgEvhbWdFS8u94CEN6p8aM95s8y5QwGEjDaL0A4osFtk+4UN3Cj5k7FYooQ
         0JA2rK81ef0pkNB4i8p2nTv2CRM5F2oK7Y2st5KvTVM+/Kl0AU+sE5tOWklnKdh11An2
         cYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUSJf6l0CJa1NnRQ8xG0jpJk1bJoecmuqzqR9c6U0fY=;
        fh=yP5qcPKKmGalxnkekBrfBwwEww/g7lwVscWpFOtwevQ=;
        b=Gw5uid0rAcypQ/4pkYWfsNf5RxG1s0fzVhWIrIHuGtqbrXQ6aFSU8yOArgbpvKb8pc
         fbRf8EeVAHcZ3ABIgBINLqBag/Bov8gFBaAMnxF8VBbj7GpTEIe2PdZOQBRPBPD8nHmT
         nEnLQnqfKV7ipeH4cg3jk8gzhodeqKDMmRdfg/VZ13W+rph8lG6BJgEqNa9eVCIyH+nu
         xqV0bqsVshZoYM07ldY0QFnYkHT91kkR6e/k5ls34LuHc/tEweiAEpUaxr82Vqu+n0B0
         SktkxGHGTDua4gzWftE9l9oHjFD0EDQvjXLnMnwjPxAGI5k9RvvKL5cGXcrmu/46DRO4
         T/cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813405; x=1792418205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUSJf6l0CJa1NnRQ8xG0jpJk1bJoecmuqzqR9c6U0fY=;
        b=gcY14mDnNx8215lV7po1UvX4mpqX6rvr98u0FK1rS/fVMXNLBrr3Tzrgrw6eyvqJLO
         3C6TPWm46/+Qnom8RF+DRnxAPLmeCuVqT5x8hCbt/hXhd0bSwwbS5+XOLwJl6qoocfKt
         qaEF3RJmF/T3es/w9xiI+cymyyKp6ng0WI093Dh5abTLdcW/VzT6Nsj59pSag49fV/A5
         pA1fNlYPENb40hiivelZJoyLmqT5MvW2uRtyOjB31cPb/bl5u+FbG9Mt/sZrPywXFeIQ
         Yqw+Ky82FDGXA0umDyKO0wm9N2hThMlx6q+pT6K2wtR1Xlx2xkAZ7O3ovgWuukZFGkSc
         YSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813405; x=1792418205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUSJf6l0CJa1NnRQ8xG0jpJk1bJoecmuqzqR9c6U0fY=;
        b=al23s7cEyONwEy94mVo2xYuJJIybklFIc480YcOezOzfVRWqQS0cDj/eqlsVp9DDCV
         Dyvl0UmDSWiWVgF8tQjmeG46lltbbDxwXdiOXFtDRnltztfgSIm1cry+i5NDZEhIvf35
         USeM8PpqUAvNIIGhJrrvySGpFx7O5Opq5DaNdL9uvRu10pTOc7aXDBJCa1LDRcsI/OUo
         xkiSCuekXvFtLifPdSkwSjUStgqWQ49Tc6Vob/Z7M0/m81Rkpvpz0ufDIN61xPwxhorw
         pXYX8yvGHRFVSYdcAXudk59ozkfcuGfn41kYoJwN2ikLERzOUtt18fIt4kt277u/9VUR
         XMlw==
X-Forwarded-Encrypted: i=1; AKwUvBw01lLK0CZWDNQixGyVyIrUZ3R92J7N77H//q1TywFodz3RExHEnP93v04vzsK4TTRcrI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh2kZo2aHRTkeKRnQF/xmDDE7Z4YXxH5QJmovgt5MxPJKgVwJV
	DiKL925JhgNyMFTSssoF8nFUa33LkBkPofvd4GAdUD/y3pRtzw0ofJXKayP5nyABtyfizQHd2/N
	3LQQzHqpZfnx6tYahXalw+tYHmn667hg=
X-Gm-Gg: AYBFou1E/jnZw4xXrNoegTzmbjQ88uhJpMuKmzu0s9i6nQOsStY+KZvvv/W9+k2aZUp
	MRYkrm2jLLsU6ClhLfapi+fv3/DnzzGKNtMJeVmJWzKa/DvpJjZH+SHuqygpc1jDZW6TetQf41v
	A0ijBp70nVnKrGG1jYqwcNXe/rWdn410b1G9Mt6nDTXgSAIBZ/qyfyGRBp4J/XoPk0YRX5QR8qR
	c5XMOawaqW3+MHf/bKOJsBMbfALfYrmdbP/ANTx5izobhFJKqqwiMVHuF22qIZbxKjDnIh4racZ
	bTlLl+C0Pr8geXGgic5Snftl3SARbyyctTJxqOWDkD3TLXOVcEBxEd0dW9eYUYCzxNtupECCBYf
	T7KHPSaY2jA==
X-Received: by 2002:a05:690c:c3b7:b0:8b0:702f:1169 with SMTP id
 00721157ae682-8b07edb7254mr19201297b3.38.1791813403774; Mon, 12 Oct 2026
 06:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <20261012120438.52849-3-laoar.shao@gmail.com>
 <sashiko-outbox-168093@kernel.org>
In-Reply-To: <sashiko-outbox-168093@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 12 Oct 2026 21:55:54 +0800
X-Gm-Features: AclHuK_hWKERSs8YM5btLTPqoL7z0K5nG8ilNCIMeTV20zODt-3yd-QFVAUCxgQ
Message-ID: <CALOAHbADKfZRuJD=B0bcBz_=QQ96dA=YKj_xvPZpsxF5V5A-xw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] sched: add per-cgroup NUMA balancing mode
 selection via BPF
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] mm: folio_can_map_prot_numa() disables NORMAL NUMA balancing on =
top-tier nodes when TIERING is active
> - [High] sched: AB-BA deadlock in bpf_numab_mode (rq->lock -> pi_lock)
> - [High] bpf: missing __nullable annotation in bpf_numab_ops leads to ker=
nel panic
> - [Medium] sched: BPF NUMA balancing opt-in ignored by LLC scheduling
> --
>
> commit 3975a69bbe7653d443a34c5ce6984dadc110d558
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> sched: add per-cgroup NUMA balancing mode selection via BPF
>
> Global NUMA balancing is all-or-nothing: kernel.numa_balancing and
> kernel.numa_balancing_mode pick the mode for every workload. A
> latency-sensitive service wants the scheduler's NUMA statistics but
> not tiering's promotion machinery. This patch adds a bpf_numab_ops
> struct_ops to allow policies attached to a cgroup to pick a mode.
>
> > diff --git a/include/linux/bpf_numab.h b/include/linux/bpf_numab.h
> > --- /dev/null
> > +++ b/include/linux/bpf_numab.h
> [ ... ]
> > +struct bpf_numab_ops {
> > +     /**
> > +      * numab_mode - request a NUMA balancing mode
> > +      * @p: task the NUMA balancing machinery is about to act on, or N=
ULL
> > +      * @folio: folio whose NUMA balancing semantics are being decided=
,
> > +      *         or NULL
> > +      *
> > +      * Exactly one of @p and @folio is set. The kernel passes @p when
> [ ... ]
> > +      * Return: bits from enum bpf_numab_mode.  Other bits are dropped=
.
> > +      */
> > +     u32 (*numab_mode)(struct task_struct *p, struct folio *folio);
>
> [Severity: High]
> Could the lack of a __nullable annotation here lead to a NULL pointer
> dereference in user BPF programs?

Nice catch.

It should be
u32 (*numab_mode)(struct task_struct *p__nullable, struct folio
*folio__nullable);

>
> The BPF verifier relies on the __nullable suffix on struct_ops stub
> arguments to mark them as PTR_MAYBE_NULL. Without it, the verifier assume=
s
> they are strictly non-NULL and optimizes away any user-provided NULL chec=
ks.
> When the kernel passes a NULL argument (as designed, since only one of p =
or
> folio is set), the executing BPF program will crash the system.
>
> > +};
> [ ... ]
> > diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched=
/numa_balancing.h
> > --- a/include/linux/sched/numa_balancing.h
> > +++ b/include/linux/sched/numa_balancing.h
> [ ... ]
> >  static inline bool task_numab_enabled(struct task_struct *p)
> >  {
> > +     u32 state =3D bpf_numab_mode(p, NULL);
> > +
> > +     /* A policy can always opt out, regardless of the global state. *=
/
> > +     if (state & BPF_NUMAB_DISABLED)
> > +             return false;
> > +     if (state & (BPF_NUMAB_NORMAL | BPF_NUMAB_TIERING))
> > +             return true;
> >       return static_branch_unlikely(&sched_numa_balancing);
> >  }
>
> [Severity: Medium]
> Is this BPF opt-in overlooked by the LLC scheduling logic?

Right, LLC scheduling was overlooked on my end. Will fix in v2.

>
> This new helper allows workloads to opt into NUMA balancing even when glo=
bal
> NUMA balancing is disabled. However, functions like get_pref_llc() and
> get_scan_cpumasks() still check the global static key sched_numa_balancin=
g
> directly instead of using task_numab_enabled(p). For a workload that
> explicitly opts in via BPF, its numa_preferred_nid and CPU scan masks wil=
l
> be skipped.
>
> [ ... ]
> > diff --git a/kernel/sched/bpf_numab.c b/kernel/sched/bpf_numab.c
> > --- /dev/null
> > +++ b/kernel/sched/bpf_numab.c
> [ ... ]
> > +static u32 numab_mode_stub(struct task_struct *p, struct folio *folio)
> > +{
> > +     return BPF_NUMAB_GLOBAL;
> > +}
>
> [Severity: High]
> Should this stub function also include the __nullable suffix on its
> arguments?

I will add the __nullable here as well.

>
> As mentioned in include/linux/bpf_numab.h, omitting the __nullable suffix
> (e.g., p__nullable) prevents the verifier from recognizing the arguments =
as
> optional. This leads to dead-code elimination of user NULL checks and a
> subsequent system crash.
>
> [ ... ]
> > +u32 bpf_numab_mode(struct task_struct *p, struct folio *folio)
> > +{
> [ ... ]
> > +     bpf_cgroup_struct_ops_foreach(ops, item, cgrp, CGROUP_NUMAB_OPS) =
{
> > +             if (ops->numab_mode)
> > +                     acc |=3D ops->numab_mode(p, folio) & BPF_NUMAB_VA=
LID_MASK;
> > +     }
> > +
> > +     cgroup_bpf_put(cgrp);
>
> [Severity: High]
> Could dropping the cgroup BPF reference here trigger an AB-BA deadlock?
>
> The scheduler path calls task_tick_fair() under rq->lock, which invokes
> bpf_numab_mode(). Dropping the cgroup BPF reference here via
> cgroup_bpf_put() can trigger queue_work() if this is the final reference
> while the cgroup is being offlined.
>
> queue_work() acquires pool->lock and wakes up a worker by acquiring its
> pi_lock. Because standard wakeup paths acquire pi_lock before rq->lock, t=
his
> inverted rq->lock -> pool->lock -> pi_lock sequence leads to a deadlock.
>
> Since this code is already protected by rcu_read_lock(), is the reference
> counting strictly necessary here?

Nice catch.

The walk needs no refcount on cgrp->bpf: the cgroup itself is only
freed after an RCU grace period (css_free_rwork_fn() runs through
queue_rcu_work()), and the effective prog array is freed through
bpf_prog_array_free() (kfree_rcu), so rcu_read_lock() keeps both
alive for the whole walk -- the same protection bpf_tcp_ops_call()
relies on.

While removing it I noticed the copy from the memcg_ext series
missed a warning its walk carries: it is only v1-safe because
memory.high happens to be v2-only, and a hook on a path v1 can
reach needs its own cgroup_on_dfl() test -- a v1 cgroup has an
uninitialised bpf.refcnt and a NULL effective array.  The folio
surface here can reach v1 memcgs on a hybrid system, so the walk
now reads:

    rcu_read_lock();

    if (p) {
            cgrp =3D task_dfl_cgroup(p);
    } else {
            memcg =3D folio_memcg(folio);
            cgrp =3D memcg ? memcg->css.cgroup : NULL;
    }

    /* Only the default hierarchy has a cgroup_bpf. */
    if (!cgrp || !cgroup_on_dfl(cgrp))
            goto out;

    bpf_cgroup_struct_ops_foreach(ops, item, cgrp, CGROUP_NUMAB_OPS) {
            if (ops->numab_mode)
                    acc |=3D ops->numab_mode(p, folio) &
                           BPF_NUMAB_VALID_MASK;
    }
out:
    rcu_read_unlock();
    return acc;

>
> > +out:
> > +     rcu_read_unlock();
> > +     return acc;
> > +}
> [ ... ]
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -884,11 +884,10 @@ bool folio_can_map_prot_numa(struct folio *folio,=
 struct vm_area_struct *vma,
> >               return false;
> >
> >       /*
> > -      * Skip scanning top tier node if normal numa
> > -      * balancing is disabled
> > +      * Skip scanning top tier memory whose owner participates in
> > +      * tiering: hinting faults on it would buy nothing.
> >        */
> > -     if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> > -         node_is_toptier(nid))
> > +     if (folio_numab_mode_tiering(folio) && node_is_toptier(nid))
> >               return false;
>
> [Severity: High]
> Does this unconditionally disable NORMAL NUMA balancing on top-tier nodes
> when TIERING is active?
>
> Previously, this skipped hinting faults on top-tier nodes only if
> NUMA_BALANCING_NORMAL was explicitly disabled. The new logic skips top-ti=
er
> scanning entirely if tiering is enabled.

You are right, this is a regression.
I will fix it by introducing a new folio_numab_mode_normal().

>
> When the global sysctl_numa_balancing_mode is 3 (both NORMAL and TIERING
> enabled), folio_numab_mode_tiering() returns true. This breaks standard N=
UMA
> page placement optimization for fast memory on tiered systems by dropping
> all top-tier scanning.
>
> >
> >       if (folio_use_access_time(folio))
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012120438.52=
849-1-laoar.shao@gmail.com?part=3D2



--=20
Regards
Yafang
