Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C058494B
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964266; cv=pass; b=nE5IZISqKZjC9wYQiMoMdgA20DGm5AkvUJk/x1xgr0Cb9/InODTuR5/sBxR7jj6jmA1MOMPJWkrND//igiCGYx5k6dc1YR+iaFU1sOjjWIg7AlfkoS1STYgXXRnaurjZIbh4QzZfg6uJCfATMhtqXcwxqZNmIHHsrAPWl6CfAUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964266; c=relaxed/simple;
	bh=bL3FhBHPAN/gO0KYh+II+j6VXDmseoWIh8krisyD6DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZl/EeCR2FwLwVCZ2MkrBj4lbwJ2tVz5F46yvHUE5zmf2GsJ45r0GJxXjxgckU2XMBkFrMhTtvDo6RWZZZNasmEHL3t3M34lraCvDNCVbQrAfCRjpbJJ/9O/XW2NGh4sytb197dDCTz8BLyHeagQHl6f4Bh3Bo1Nc74n98VNO7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVK46is5; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVK46is5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c250f28f1cdso973734666b.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964263; cv=none;
        d=google.com; s=arc-20260327;
        b=LKXhZ7t079mtJf3JopUiQEbRO4iCSFSrP/42qJfHyv+4ibIi4nOOtM7nfGbSdl6ITQ
         juRiKQLJPNY8wghHvTu2i25zmrtudqqOaYWTWxwGBBAziGjvN4GSFd3KJa1YbcKMyNGc
         IZcGwV0kE1sgFZEeBL7tnfdqZEMqIOVJc1oj6vyYTwfaTsqhl8Fy0RrQW6fddHetQ/Iq
         0AbuEou7U3sBs9rpZnNkzrKOgf6Vp66GStBwp4NtKdo6VZNkV+NGNKL9VSpssVBHaZaD
         5QLbonweu2jO86SEbwByXXSEFBxT4J9itx5Il0vzPPaWM3Wfgqlowm/hqwhp+MSmYGYO
         hKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        fh=TQ+kKhJNo4s9DQan4GAN9zPGO4iMMjXF8Ma6qnMCceU=;
        b=bLvZKUhjyVdKm75v1IMEqXLiyAkLg9g/pSlS85lsAzrJJPUDv8EbU16PxYeUoYxnq2
         gJ902GTf6qfuyNJDDNFujnTHQWDrPv+QxlGtO42gAFG9Ho3Ios/F2cLdxZyhINVp4AZ+
         ZpiUKdgo83TLvefiJ+HKu/2LzoPrE5KhkjVQiZ4uASv0gddEm4WBBCaTyVO1l5PJhuGb
         veu3hpWohj9rChhOdmJ5FjO6OF5+LkfbIYbnZBVaEsCxmNzpcje4qFKunmMdJtlnVkMe
         tov1HMwEcBKh5byAUVowCMIN/gh8Wg5Y7ZeXmq4LCSXe7+WAY+4Hm3d/Lo8SzzND5jie
         Ultg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788964263; x=1789569063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=oVK46is54PUpLYbpIBMQLOINYV2JcYG9PO+ngMV/f40+xJBaeGXWpS1X43BK+GMXz2
         QvTce6LZx4Ji6fP5Ao3OdSGfvaxBuY2MdAoXfdiKcnaEetOAM9Tuv0CE4E9/gylO9I/l
         Ot0/SbWgcZ/qGRbxDY7mpmLJX7ZJLJFde8xTkwYc7LW8dR0VQ/PbXl3fA3Cq0J/i1ebT
         wVQpCU/9H6mJh3kgW3h/SWvtwQxAtnGaQAS10RvvCaSUnJVIrnWfEhJ8gFZY+ABVUJEb
         6Jzn7DjLnHWilz25cHyw95ndg3389UCx96nII7kME8AjDCrnB2jiFlAA3N+gBHBB8Abk
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964263; x=1789569063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At/1ljdSD4FTvrT5giBI8BEGFXljDafmPB/bhLReTvQ=;
        b=rG/HN944ji5RW3rOvjKYGw46gvvwh4mrw/8841NMJqkIbMyff4X/x7n9L1/RxtVnR+
         tjj0sK5i24pwH2Il0F7xij1nHSTSR+KjW79PV0DUDdBt5kGIrYs8S9HpGdiKD7luS0tb
         3yYRHEtjpmRrw52g0qZp4GS26g8HVJTvaCm2Df27HMRGTk/dnEbm6qjbByoyigWp2fIF
         Huk7E4z+PSvCa8aVzxFPqOGYdNXtP0SNhbSYQsL65A8pUBCbUIepgJbTcGTvcCO6+36+
         D3mn1NIwUOYQUgSJkjQtuDvpRehT9JbstGM55mmf4lKJfzeG+Waw59BRSPbp4KSCq8un
         ON6A==
X-Forwarded-Encrypted: i=1; AKwUvBwkrW0yNFs7KxG00ACU1cGhU8F2+bksACjp1Y2NrcIef+OE3UblNfQKArmAEItw9TgSks4=@vger.kernel.org
X-Gm-Message-State: AFuF++kDQr0PXcpgJlV/N3TaTycHr6d/bO6DDCHB4Nrg6cFeWcPQ56AO
	BgkII4YH8fi9MFp3D5RC0pVzLcShMelBRSHiflJDhnCbJvd77wUctNTGtTHrhnTUPkoqXy0iVMF
	VZ0veGdjm3QH2h/sZYeHAlldJilBFw6Y=
X-Gm-Gg: AYBFou1fVfAWM255sL8ZANCBjfJEHzYA3S/ZxlnHqITlp8TRhRI0vcbhET1tQ1Uoqr2
	rHCOHnaa9eXfhnpIbZIh8p0qeITothTMhe9HvTYEUUq67x20z7cb9Khewo+M4TfhcR1UTKcP6sp
	C9VSJ+IgthnV7soSjRmtrC6S1Z9F6iL6jou+2SDdUSpxCpni5Xh8NdZ1tLJ3S08997yylGHiGvf
	zGRIekMlqqs47CLOEzpnI1cxzrmF1j9lJ63kxDOLR9xSfs8CPUZimSETP9x3l9wtOU3vCbuJoX8
	q90fVUtiD6AVCfy0KELV2Aheq4v9zCE8jQwK4gyoGUbuDdqQM0We8Z380vOAb0YFV788tTA=
X-Received: by 2002:a17:907:3f2a:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c28fb400053mr726589666b.30.1788964261711; Wed, 09 Sep 2026
 07:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <aqFebI06nXUccuwt@thinkstation>
In-Reply-To: <aqFebI06nXUccuwt@thinkstation>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 9 Sep 2026 15:30:48 +0100
X-Gm-Features: AcwNN1XiH3nsxsI43wM30YdmALjDY-XF6jmsUMiyceN_7aAAFdPSS0ZgK9KjeOs
Message-ID: <CANk7y0htDA4zC6tK=Fi5H9bbFvQzOEJ57NtxDYhRLuMAxgEe3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Harry Yoo <harry@kernel.org>
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
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:26=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 05:27:50AM -0700, Puranjay Mohan wrote:
> > ---
> >  kernel/rcu/Kconfig |   6 +++
> >  kernel/rcu/rcu.h   |  11 ++++
> >  kernel/rcu/tree.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
> >  kernel/rcu/tree.h  |   6 +++
> >  4 files changed, 143 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f15da8038d0ba..1a5fb3156c062 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
> >  config RCU_NEED_SEGCBLIST
> >       def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
> >
> > +# The deferral (and the IRQ_WORK it uses) is only needed where call_rc=
u() /
> > +# call_srcu() can be invoked while a callback-list operation is in fli=
ght.
> > +config RCU_DEFER
> > +     def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> > +     select IRQ_WORK
>
> nit: I don't think this config belongs to RCU.
> Do we really need this when majority of kernels enable those?

Paul was worried about some embedded systems paying a performance
penalty as they might not enable these but would still use RCU.

>
> >  config RCU_FANOUT
> >       int "Tree-based hierarchical RCU fanout value"
> >       range 2 64 if 64BIT
> > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_ca=
llback_t func, bool lazy_in)
> >       local_irq_restore(flags);
> >  }
> >
> > +/*
> > + * Stage @head for this CPU's irq_work to re-issue once interrupts are=
 on.  Only
> > + * the drain side takes a lock, so this stays safe from NMI.
> > + */
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > +
> > +     /*
> > +      * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> > +      * drain.  Re-queuing would livelock it, so drop the callback; an=
 NMI
> > +      * cannot loop, so let it through.
> > +
> > +      */
> > +     if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> > +             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > +                       "call_rcu() re-entered during callback drain; l=
eaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > +             irq_work_queue(&rdp->defer_work);
>
> Should RCU wait for the IRQ work to be processed during e.g.)
> rcu_barrier()?

Yes it should and it does, rcu_barrier() now enqueues these deferred
callbacks from this list before doing the other barrier logic.

Thanks
