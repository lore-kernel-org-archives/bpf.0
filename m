Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D23C8713
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267254; cv=pass; b=PXE0UWhtil9EPHgOGQfgYhizlfDnMr0PodBLHz62EdolCx2Cm75rfaqdGJG3uCrEuBuPL9yK4cakyuIQKDsXoDeOTw54wh57UqwUmKOXEKrxfkn9V2jL2uWvNItNhSnr5k7DgCCbYgZXbCqLIOx9wcZ0fv1dtl+em8XAiHjV74A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267254; c=relaxed/simple;
	bh=5ox2ct2yboHyEver6vM5hxy9diHibI+8bx6OOjEZObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA7GRWhicKCnF//x2C29B7pKQQt9Pvf2cS4IZCdDA2K5Yu1FCVBc1zplcHnIGZJwkCIPWGg9e1sKhUqc+ot9R2R9kTwCxjw7//Tj1mH1dMwVjRHAN5u9BSwneV3IgYYK5nwYveYA9/4aiORYfHxaUsy9OIgpLbUllcvneXNwvvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD9TCcJ3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD9TCcJ3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so1167492a12.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 05:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267249; cv=none;
        d=google.com; s=arc-20260327;
        b=Wz6KVqPNZnbhy+wBTHCm5hpxyjKlRD7TVOTFY8hm5GwGdbubVcQHFDBrx1YhStUL3f
         /Bx0LmqrAZ3O+XsqtKUHS3AUHwz+MQQfUsxQmjPnXwmbXIOKyuCA7LQf6IzZnzRXXkn6
         Zh6zQXMn2NCKBCEpAR2uiYzqAcONNq5vzOqe/Tu0TUEd3kzkaTaIomCOK61Q0NawQXuy
         HxV+i5ZipUIXQ2QJ8Cfx22sro4QoEP4LAgKtu0WwN18dnRjOclsl/J6baJkXglvweQJB
         XzdYOGRixiIkzzwPDbLYOQnaqQXRdSeJx5BCWfWNmjYiI17lqxDUCKLfGgYpOcAdGGbJ
         CVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        fh=hOhcSqq6M3OPPbgSBJ34nWR9L45WaP4buBpjnojbZqM=;
        b=GL930pBo2TBNEM46naoBv91K6D3WyNmGspg/yvDO004ICXwX3dSnAsprszhox2Vo7M
         L48PIQ2AubQEkZecmKymbsNYOObpz2C+QbLbfuJL/XHo5qB/Z54c0KH/WW3AEmTcMStN
         sgNMJlAyJ0PjiUMaoBMtpxGaa3BT1otzKhiBBSyTy/FEpDd46H6VqCJPjU85OIaJGKtf
         9oD8KEN0zxmnjJiD4DTvnwjjjUM+++uSJYnlRJCgr6lH8MyIlYZkF1WIATKJe3lNigGh
         VGt9qwtut6UXYzSJ8WHPLBGKEc6NjroWB/yp1HPw0XT3oAw2IENk1PN5Ol+7EjB4c0nR
         P5ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267249; x=1788872049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        b=bD9TCcJ3u7W6mCldzDKZcLCPvFTU0KwDPGVEPf1wzQJk++ZXgiqU16pHHRKJabWjNc
         9Ka6pQDiMUGr6ZIPVk053313qdsDEplJsSaOXK+18ZAiIs+CgqclhNdkZdZ1/uewtkyo
         ndteRQ3hRLj8B0f+X8Wxqiu4mLxyW1BRYOtDonGy9umHn6uKyYFJz+BVjVVJRHkPB9Xt
         xOVHe+SVEzhfn0XLIl/eTMyRGTp6KK7RVdoKUZKizv75+s3qca0Zm7Me2xWo7bZrX4NE
         nuST78PLWVAfl08ICYd1KT2KbBJa84jufAleuMzPZBiuQ/BKvhm73HJz/UqXOJu3LZ/m
         MqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267249; x=1788872049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        b=fj8IVZKUC1ael1gW/I/Vu8YyYY3dd3D0l/LY4nWuvzbt9D2DpX4zbLJX+bfg21Am3A
         B4ziMfVMu1tsB84WLHctFDiHEvCfIVO69EIP8oaeMfm2YyIPyhV0KWy0qwy6fnfoWB9A
         gXENIWg5KAKjf/bP/DUYgUXv6e1r5cFPrhoIoQzAPt+5UGY++Naga1vyqjQ1uREzJohG
         YPVqyFFd0zERKHkQgU09ugZdS/uUwIKpHBHUvUuRu10UzzQjyoPdgV4cg31NOSyaCMNf
         THvTLwMWi6BqBDbz937vxXmEWPuwXUDV34aCtmVbJmeJjEUL7Hgg2TCp1WzABITsM0IO
         15+A==
X-Forwarded-Encrypted: i=1; AKwUvBxqabIFM/NJ+ihPYSaySPurQg2tExbmQdcqf63k5E4K3nyUixToVMNMRAxEPsEZpODLoAU=@vger.kernel.org
X-Gm-Message-State: AFuF++kWQyhxxxiYbqNk+evEc0GQKe+quB2r1440dGSBD1qpESPXFGf4
	DGAGOnVJcGXavh9o1T3y71LRdIm0+MlN8KSUfRuJwBQ9YqbNiycJF4iUma8VEmrsz6Aq638YM1S
	4qTmiin/2zpMIlVOvl1P1zinnrIJ4oWE=
X-Gm-Gg: AYBFou2j/VwXur1CyqrHuOJPJUGGma/ke0QuzvDFoEIFUUx6Qm3y/+RpaQRw313Kz1d
	49+qmN/d/yavNJUfo88SiWErAEpKzngj+nQplcmsYkDa8cOcdwPDQ4pKbbU+p1psIHoNceuNtak
	Zi+kWrfWAkrs+/B15g0PV7XNlTMd1ebvSSFIc5hwTIegFrCr9KA/LqMfqzm84BiCEnz4OBGiA/H
	7Co0CC+e2WbR+Ndga0JghkD/LKEwd2UW3lvjTegVFTh7uCmZOqtQAG7qqOt1e7dVvJxT1d+pVdr
	26hijQlSsR4vp7/N0Y/UDq3WUaNAkUBroNmh00Am8HB8CPJ5uWnuIb7ha2s=
X-Received: by 2002:a05:6402:24d9:b0:6a5:f9ab:bdfd with SMTP id
 4fb4d7f45d1cf-6a60d15f4c5mr16070508a12.0.1788267248852; Tue, 01 Sep 2026
 05:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de>
In-Reply-To: <20260826144636.3IRUXeFV@linutronix.de>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 1 Sep 2026 14:53:56 +0200
X-Gm-Features: AcwNN1VMVsqA5TbOoGtCimTix5w0rFzm4VjPnSAE7cacecLqde7MaGCaDPITNHM
Message-ID: <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:46=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-08-10 05:27:50 [-0700], Puranjay Mohan wrote:
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -572,6 +572,17 @@ static inline void tasks_cblist_init_generic(void)=
 { }
> >  #define RCU_SCHEDULER_INIT   1
> >  #define RCU_SCHEDULER_RUNNING        2
> >
> > +/*
> > + * Defer whenever interrupts are disabled, since a callback-list opera=
tion may
> > + * be in flight on this CPU.  Not before the scheduler is up: irq_work=
 is not
> > + * usable that early, and rcu_init() itself calls call_rcu().
> > + */
> > +static inline bool should_rcu_defer(void)
> > +{
> > +     return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> > +            rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> > +}
>
> Why does the description say that the defer part is for usage from NMI
> and the test here has irqs_disabled() instead of in_nmi()?

We defer for both irq disabled sections, hard irq, and in_nmi() and
checking for irqs_disabled() covers all three.

>
> > +
> >  enum rcutorture_type {
> >       RCU_FLAVOR,
> >       RCU_TASKS_FLAVOR,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 21b6ce1dffb63..3bf3a250f9de8 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_ca=
llback_t func, bool lazy_in)
> >       local_irq_restore(flags);
> >  }
> >
> > +/*
> > + * Re-issue deferred callbacks straight to the enqueue so they cannot =
defer
> > + * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
> > + * rcu_defer_flush() and rcutree_migrate_callbacks().
> > + */
> > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > +{
> > +     struct llist_node *node, *next;
> > +     unsigned long flags;
> > +
> > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) =
{
> > +             struct rcu_head *head =3D (struct rcu_head *)node;
>
> Why do you need the lock. This is still not clear to me despite the
> comment. You can do llist_del_all() towards another list and then feed
> it into rcu_do_enqueue() one by one. And you use the LAZY part.

Because rcu_barrier() can call this for each cpu and at the same time
rcu_defer_drain() can call it too, so this would cause a race where
the irq work can remove the callbacks (llist_del_all) and before it
can enqueue them, rcu_barrier will see that the list is already empty
and will not wait for these callbacks. We want the llist_del_all() and
rcu_do_enqueue() to happen atomically so rcu_barrier() can work
correctly.

>
> > +
> > +             /* Bounds a node self-linked by a double call_rcu(). */
> > +             head->next =3D NULL;
> > +             rcu_do_enqueue(head, head->func, false);
> > +     }
> > +     raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > +}
> =E2=80=A6
> > @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
> >       rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
> >       rdp->last_sched_clock =3D jiffies;
> >       rdp->cpu =3D cpu;
> > +     init_llist_head(&rdp->defer_head);
> > +     raw_spin_lock_init(&rdp->defer_lock);
> > +     rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
>
> Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? Is
> there a requirement that the RCU callback needs to complete asap and not
> be delayed to the next tick? This would give kind of the LAZY part.
>

In discussions with Paul, we concluded that we need HARD because in
low memory situations delaying rcu callbacks can be problematic. Given
that we are already deferring the callbacks, it would be nice to have
them enqueued asap. But if there are downsides to this we may change
it later.

> >       rcu_boot_init_nocb_percpu_data(rdp);
> >  }
> >
>
> Sebastian
