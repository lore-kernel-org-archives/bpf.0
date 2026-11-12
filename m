Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501714;
	b=KRcMPXAwzZ8Gn0Kyqzdsf8E5J7/I/hJGDb4kdfgGgE4J/WyVSSwY3i5TpEIQuTxlMvJQ
	 oMr3taEJ7DLAq/HeQW6EW0B8uzEUxuF+L9xGG9MYBoH4dmcQ/9mNlCMtgAxO29kbQd1sv
	 Qxhtfepc4P4FVzgk6qmcr6mpb9LFVKUsKDEV7F7qDajwsuVNrBEURpWztLOSJxGW++44Q
	 EABnSxk1kjTlN00zFakCvlXE1GIK4djB6wWaCD9wpZG2QGp0uzZG+OkU65VCT5K+qM1Si
	 HlYUhwjP0ecTfEHgvgiDsJ1yqO8/KrDf/si6sGJgFVtUYIIbGcr0Beu1PQh6gqLKN9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501714;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FmGT6juCirIZiH3gAOJXo+P6a62HxlEOwgb0n9iNzwg=;
	b=j0o89qJdDkDkbkvNAQp3g0Q1yW/S+Kkp6wXb3VaH2wFECi1Mc8Kw14e+fRHJrkXGpsS6
	 OHpZ0+JMWHW9LqSwkPubk7IUOVvMia+rHjLaayipRSqcEnaz+N5UBCPSSdXCj+aw7MeUD
	 8yAfcfd3VVdLB1IznHHekb/8kKTIgO/IDy3o0kGxTKuOHoBL4UdyTnWurVMg03M1t+MVJ
	 t3I3wv2QciyWn/Nj+WqLwmRC557nz9vZKiAIArxKvD6jW0EnL49iahz2w7iYMIwCusj3i
	 gOPZf1yxTXQrmtsGeX/lS85HLRx6w8mEnLtZ7WZF0lj5dbDOtD5p6w/4at7iOzMdXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Is+VHQ0i;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9784606A331;
	Thu, 12 Nov 2026 16:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9784606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Is+VHQ0i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FmGT6juCirIZiH3gAOJXo+P6a62HxlEOwgb0n9iNzwg=; b=Is+VHQ0i7LL6eE3D80U1yf25vr
	7QJxVPIQpiQuajhj4JxYqPUpz7XW2Jng5ALd/U4BStRCiKgtcajq79BXqWmkDopJpoDmyy9kADkJC
	5ZCp7NKKW5ynx+QNFPFPTlomYQIraZ2A28GTWuE/pxHj7dLH9WZHBVH5xkRJouDw71DN95IlIaFFf
	ekR5cpSA2T8ZGLDm4iQN7pBw1opyB4n5Tb3VeBkoNkmw0OdVWZVPj/M2vxI7QrgwLtyASFtIUM4LK
	bRNdsetgKbjLZ7bhwRORMjGPtWOwSVn7KjBtMVFrA6Y6px7cJd8ncJGkGbw8IMKqQZK7DYIBSMoZT
	dcEe7jzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXry-0000000AZNp-3JMZ;
	Thu, 12 Nov 2026 16:41:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A51033005AF; Thu, 12 Nov 2026 17:41:49 +0100 (CET)
Date: Thu, 12 Nov 2026 17:41:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <20261112164149.GE1813469@noisy.programming.kicks-ass.net>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
 <20261112160136.GF1922751@noisy.programming.kicks-ass.net>
 <avXqKIZ1ZkaH2WTh@gpd4>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avXqKIZ1ZkaH2WTh@gpd4>

On Thu, Nov 12, 2026 at 05:32:40PM +0100, Andrea Righi wrote:

> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a088d4576f5..1c1e669473a6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11252,8 +11252,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
> >  	 */
> >  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
> >  
> > -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
> > -		p->sched_class->switching_to(rq, p);
> > +	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
> > +		bool block = p->sched_class->switching_to(rq, p);
> > +		if (block && p->is_blocked && ctx->queued) {
> > +			block_task(rq, p, READ_ONCE(p->__state));
> > +			ctx->queued = false;
> > +		}
> 
> So at this point sched_change_begin() has already dequeued p from the
> old class, but p hasn't been enqueued in the new class yet, block_task()
> would dequeue it again, through the new class, and repeat the generic
> dequeue accounting. I think we should complete the block without another
> dequeue here.
> 
> Also, if p is rq->donor, clearing ctx->queued isn't enough: we need to
> reset the donor and clear ctx->running, otherwise sched_change_end()
> would call set_next_task(rq, p) for the task we just blocked.

Right, I figured there was something missing. Can you take this patch
and make it work?; you are more proficient with running this ext stuff
than me.

> > +	}
> >  
> >  	if (ctx->queued)
> >  		enqueue_task(rq, p, ctx->flags);
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index f74ffb3b1aca..4440e32236b3 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c

> > @@ -8947,10 +8934,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  
> >  		if (old_class != new_class)
> >  			queue_flags |= DEQUEUE_CLASS;
> > -		if (new_class == &ext_sched_class) {
> > -			scx_prepare_task_sched_change(p);
> > +		if (new_class == &ext_sched_class)
> >  			queue_flags |= DEQUEUE_NOCLOCK;
> > -		}
> 
> scx_prepare_task_sched_change() also calls update_rq_clock(). With
> that call removed, keeping DEQUEUE_NOCLOCK makes sched_change_begin()
> skip the clock update even though we haven't done it here.
> 
> Maybe we should drop this flag too and let sched_change_begin() update
> the clock.

Sure.

> > diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> > index b5d92d89629b..e73f3474d685 100644
> > --- a/kernel/sched/ext/sub.c
> > +++ b/kernel/sched/ext/sub.c
> > @@ -1647,7 +1647,6 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
> >  	lockdep_assert_held(&p->pi_lock);
> >  	lockdep_assert_rq_held(task_rq(p));
> >  
> > -	scx_prepare_task_sched_change(p);
> >  	scoped_guard (sched_change, p,
> >  		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
> 
> With sub-schedulers these paths can move a task between BPF schedulers
> without changing p->sched_class, so switching_to() won't run. We still
> need to end the old proxy session before changing ownership, even if the
> new BPF scheduler also supports proxy-exec.
> 
> Can we keep scx_prepare_task_sched_change() for these ownership changes
> and use switching_to() for the actual class transitions?

ARGH, are you *sure* you want to support crazy like that? Just have the
thing mandate consistent proxy support.

Enforce the primary scheduler's take when loading sub-schedulers. If it
does support proxy, dis-allow loading sub scheds that don't and
vice-versa.

Alternatively, make the support the logical and of all sub-scheduler
support. Ergo if one sub sched doesn't want to support proxy, nobody
gets it.
