Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617055;
	b=indO2UPcIZ7YJmmbPmvR1BKgd6Dx1rs9ZiMzmV9V0cSfZTSN4erd9adq4HkryUkIjXCc
	 Q+voLcnXlmV9EaOs3oFc1q8jmodWFisUQO/nopuKag9Ii+CgPx76NZ11Awmj5Q1Ds6unW
	 18XUFArfCrCZdEKL/2vkQGHj7omRUKWtRlIN7lWwanPAxLTqPqHDqMEPckJxEalx0fXgd
	 XyPzPtFE2iJWl69PYvu2Fl5bDGmlGs/s01agdFbWdloGcqC6ztWIx6MWLhKke15CazNT7
	 /41nL4JWpBUUpyPsTNUcarkWh/iLruMiZ8ywm9XLS1gXUdZllxScoYeoTGP7svrDhJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617055;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o7NfTeHgie8kk98wdxr3cUN3JAiQZkYebkrK1SD6t6w=;
	b=zO5TG3hwD+eE174BATZIfKjAbHE55kbUtWYUx5RtnHcGTeaTzOqglRj4iFW7qejMMCYb
	 UCWp+8gJtN2XeMNwC9dCTRONcFSm51YF5RmgFPec++9znM/FYS3OFmVbcmmJCsaKCGoJ9
	 HdpGSHqAOevFf5b4LBnR2xSLY+QfuZqJ/Hxs8ALj0TIQUngYvyKyCfecnAInwj1ccA0zV
	 s5TqQhK5osWLEzUUgp74kt8ZwYL1CsCsvjdCyLOsvkpZtY08cRLa7iiRB8+ntiwRSk7Am
	 P8Tb5PfiZ4cNE4GYUZES6QtJYgVD8djaCd0zViTU8f8D46g5WaInyny/bbCaLVgvxjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BetaRQnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F6606A321;
	Wed, 25 Nov 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BetaRQnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ACE1F000D0;
	Wed, 25 Nov 2026 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617054;
	bh=o7NfTeHgie8kk98wdxr3cUN3JAiQZkYebkrK1SD6t6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BetaRQnYjnzenM/h40NWfe8nEyvUTBR0OueMt/3UKx9DphWz5Jz+xIVdKbjZGzqjr
	 xvkFy4THWdsptklDzOyBa65zOoqT96e81bl+eq2pCE1lHLWudPYCDr9GBzAqQB2pfZ
	 CXhHzUwrtVlcN6cn/5dgEEjfx0eEdeZPYZHoW5BnxzOl8Q1U/Rlp+mGjwKnzyGhX/r
	 o+Uvo+FOCvjFwO6iSz7GU8/Fd8GVgkk8v30gw2LMKQT0x5N4vzBoQUiQtpKloaYUGB
	 uuv/vxu6/v+icbuGJBKEBNpvxlM1T0XNbvqMBtiVZzZIWk2BrDrPpVa5mxuDF5vYan
	 C5p8uR7gn1fZg==
Date: Wed, 25 Nov 2026 14:30:52 +0000
From: Harry Yoo <harry@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, 
	Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Message-ID: <awbvek-HS3OJYJGF@thinkstation>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
 <awWRZ9xCzWLnj_R6@thinkstation>
 <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261125140902.GE2668804@noisy.programming.kicks-ass.net>

On Wed, Nov 25, 2026 at 03:09:02PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2026 at 01:59:31PM +0000, Harry Yoo wrote:
> > [+Cc Relevant folks]
> > On Tue, Nov 24, 2026 at 06:40:11AM +0000, Alexei Starovoitov wrote:
> > > On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> > > > +	/* Only try the spinning allocation when preemption disables are tracked. */
> > > > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
> > > > +	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
> > > > +		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
> > > 
> > > It works, but I after a bit of brainstorming the following
> > > might be a better fix, since it will address the root cause:
> > > Pls run it by Vlastimil, Harry, Sebastian.
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 2fef409..4368ab5 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> > >  	return NULL;
> > >  }
> > >  
> > > +static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
> > > +
> > > +/*
> > > + * zone->lock is always held with IRQs disabled. A caller that runs with IRQs
> > > + * enabled is not nested inside of it, so it can wait for the owner.
> > > + */
> > > +static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
> > > +		return spin_trylock_irqsave(&zone->lock, *flags);
> > > +
> > > +	/* The caller may hold a raw_spinlock_t. */
> > > +	lock_map_acquire_try(&zone_nolock_map);
> > > +	spin_lock_irqsave(&zone->lock, *flags);
> > > +	lock_map_release(&zone_nolock_map);
> > > +	return true;
> > > +}
> > 
> > I'm not sure this is a better solution unless this could be generalized
> > or abstracted further.
> 
> This is absolute atrocious shite. You cannot attempt a spin_trylock from
> NMI context. That thing might be a mutex.

Uh, right. We went through this when kmalloc_nolock() was introduced.

> This should not work; if it does, that is an accident we need to fix.

Current implementation handles this by can_spin_trylock() in
mm/internal.h.

One remaining accident we're aware is that we cannot attempt a
spin_trylock or local_trylock under pi_lock (even on !RT).

Currently I don't have a good idea to fix this :/

-- 
Cheers,
Harry / Hyeonggon
