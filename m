Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615750;
	b=dHI2mtE3NrBgqu52jEtDuhpqVojMQz87svzzIpsxzjtzgezE/QSanDZXFvClKesqRMBX
	 hAqpwiU3UnRMyo6q2edfsrtV/YFsJNECqz/vUN3lHWoJmbgipgEc4SmNLqPsfKnU/EJGW
	 h8y7lDA6NXrKkcrt/F1rtBO23HcBvLNhw3FWLzKAox2doJr6zV2kupqs0N6jl2MIpUzaI
	 tccBgbEj2CTHk5SAhJH564IzL9G/D7HvaYAMPo01KX4EvMPWdywCvVR0CnS9y91fPlcFi
	 f+n5OpiMpq71fymaZhDgYxWaE8R0xb0LiwqwJ9C8/fCWNmTTO489XAVqp7JMDB45e2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615750;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OJfj0NWZLxmiap02Jgv9y6mBQfosM9khI8VQAwhpY5c=;
	b=fqtacTEG3wxjcLvdcQ4xt08RXgKDFGADRA1LCbEA9mt8dhMA5oOqX4bcq+W3VXmOkW7s
	 n2avDIY+88OXUpUFbs1m2mEBiZeOS7MH2ci9nB4k/4Hl2Xr5PvmLLlpKHQNi79f+TnqHi
	 LVA0RHTdBiVmqWi0hnB7WF5iwwUHBcUBXRTxI1mPrwfmvufDl7/+hQeTQ0aXfL+IspFe/
	 4oixkHrHsk6PqTrrIcILfo29rmUtDX7eRTbegycTagFA0PfEeYJ4rx29pWewxuVyf9kJI
	 4xLpJRFeV5aRcEALIA1CKeqDxhVfnOzNMzdAeAW+awrYnOp5Ti9r1N2I4jBPw2xebfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HLOmayJZ;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0D606A6BD;
	Wed, 25 Nov 2026 14:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A0D606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HLOmayJZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OJfj0NWZLxmiap02Jgv9y6mBQfosM9khI8VQAwhpY5c=; b=HLOmayJZkdjmUcSo04fNYiJZ+F
	iuOcY/vbBOs7dUr1USwUAgETw2iJRkCXAb4zbYLJWrHC3WdrMh0hRKm6cbzkctZ33FtIMF3UbqamV
	lfulBT3qwftheBZI9jUuNiHYSb/CAexRFMIcHIHIePn/PM2FGT2Xzfm8Ex9gbwZ3577im9HaOCuQp
	EO6f8P1MAwM2LMF7+4K7DdbOh3BJG58TXUNqO2FWUdFV8PzNHKMuGvIPM9gAtb4Q+PEVJ3+a+MkRD
	lY9sYRYO7EkLhaHmTL+YpkUgZ7yNNP/ohxd6aFksxkzhoeN2Z63iEYrIVQSfWtTmEswM2oOxhh4an
	Bd/m2EIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDgG-00000005O70-0o3R;
	Wed, 25 Nov 2026 14:09:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B818F302186; Wed, 25 Nov 2026 15:09:02 +0100 (CET)
Date: Wed, 25 Nov 2026 15:09:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Harry Yoo <harry@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	daniel@iogearbox.net,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Message-ID: <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
 <awWRZ9xCzWLnj_R6@thinkstation>
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
In-Reply-To: <awWRZ9xCzWLnj_R6@thinkstation>

On Tue, Nov 24, 2026 at 01:59:31PM +0000, Harry Yoo wrote:
> [+Cc Relevant folks]
> 
> And a bit of context on the underlying problem.
> 
> kmalloc_nolock() could fail when there is a contention on locks
> shared across CPUs (e.g., n->list_lock in slab, zone->lock in buddy),
> or there is a decent amount of memory pressure. It's more restrictive
> than GFP_ATOMIC.
> 
> Unconditionally using kmalloc_nolock() in BPF local storage is
> unnecessarily restrictive when the program can sleep or spin, and
> Emil's patchset teaches the local storage whether the BPF program
> accessing the local storage could sleep or spin on a lock.
> 
> Answering the question "Does this context allow sleeping, or spinning
> on a lock" is extremely tricky in the Linux kernel as BPF programs
> could run and call kfuncs almost at any point in the kernel code and
> the "context" is usually encoded in the GFP flags or the process flags.
> 
> Tracking whether certain locks are taken by current context is not
> ideal either as it adds unnecessary overhead for everybody.
> 
> On Tue, Nov 24, 2026 at 06:40:11AM +0000, Alexei Starovoitov wrote:
> > On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> > > +	/* Only try the spinning allocation when preemption disables are tracked. */
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
> > > +	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
> > > +		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
> > 
> > It works, but I after a bit of brainstorming the following
> > might be a better fix, since it will address the root cause:
> > Pls run it by Vlastimil, Harry, Sebastian.
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2fef409..4368ab5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> >  	return NULL;
> >  }
> >  
> > +static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
> > +
> > +/*
> > + * zone->lock is always held with IRQs disabled. A caller that runs with IRQs
> > + * enabled is not nested inside of it, so it can wait for the owner.
> > + */
> > +static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
> > +{
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
> > +		return spin_trylock_irqsave(&zone->lock, *flags);
> > +
> > +	/* The caller may hold a raw_spinlock_t. */
> > +	lock_map_acquire_try(&zone_nolock_map);
> > +	spin_lock_irqsave(&zone->lock, *flags);
> > +	lock_map_release(&zone_nolock_map);
> > +	return true;
> > +}
> 
> I'm not sure this is a better solution unless this could be generalized
> or abstracted further.

This is absolute atrocious shite. You cannot attempt a spin_trylock from
NMI context. That thing might be a mutex.

This should not work; if it does, that is an accident we need to fix.
