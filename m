Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528774;
	b=AF/hgcoFAuK+oxKCBaVuIFjAnzjh/fNtjMrTR+m0UZygqjb67oQ8wZPMj7DYsCn6hJL8
	 FBUL6hxhJf8Gv2RPPf0IF4EheFJkaiaYgmMXQxiURu69FkT+Zqg6iRuOmavswizSF/UHe
	 c0KfS8LrTCqFUxktFhCVgReLqzL7aXDZwy1ynG+lanWNYOIKVFBws7XPWpL7ev711c4ih
	 fibKWOLmiVkXUfqveLtgp+mj2c6uDNgE0C0Xqhu5s3rT5LGS0OjxzVCApeQMzUZf8H31D
	 fnKAEIt2a2tE3e3iEAHNN7XszxQpQMZq4EqqAn1fq8ErZkDay6owY+cwJm8Ya70H8cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kvsfueMHEyVjE37oaEUJidZMPTJVXlpVOUA/4h72CTE=;
	b=VeKP5VHiBY5sI1MwHnZHtalZAVp3/lGDnMGjWxs3DWFEuhj9YNYRxa/dlaDgHFudHs7G
	 /q4FS3MP4+NOQe56/6g7fk9v4koh9x9ruzqeVYVDknsnqQdNWqo7vZFbtvPMRG7y2exWP
	 0FOptbkeeRV9nFpqsRnGQ05ptY31ilq348FzN4w29Y3RcmRBwPmWluBZA63IGQTz++ACQ
	 mLs0tSyumkaIwWr1yVjrNaRMcRDZyn16pyfvay+6MzBPHEt7AM/76vNhQ2KS0gGwARMpb
	 D9uUcYVQDR4CEGSEffi8GAFClxAuclGt1Mj+uf9QiLW5rXEiWzppmyBSEH/fQDPU6BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSnrQyfZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43306606A31E;
	Tue, 24 Nov 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSnrQyfZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596401F000C4;
	Tue, 24 Nov 2026 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528773;
	bh=kvsfueMHEyVjE37oaEUJidZMPTJVXlpVOUA/4h72CTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSnrQyfZpr4OAwsGrcz8BHCW4/klS/ONxfDAooEDvS8hEw0h8ATzx6RRag7GaRbUZ
	 PdCzu2czJSsynBun1Xe2QTv6o9kwzFJ2AmPJp1aZPCrtokFkcSv4FeIFv9pmKChNzK
	 5PT2q2qOophF71Z2WpnE5nLRQsMCLxPoDPEJkAuyNfu7NIlSUc9Wgxi3He8tHJc9H4
	 /kokeiWu0iDvJ21O7BPsMsGc+LdOqVpgH3DMJJuJhMaqBpbTKo6iE+qyzLBXOct9b1
	 m909zcbnsZXi6tODHQA5YzLCtB4tz0No6fKbf4ksBR2o/vVOSbqEkq47hKdlg1oY/B
	 cK+Ku5T+1/oyQ==
Date: Tue, 24 Nov 2026 13:59:31 +0000
From: Harry Yoo <harry@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, 
	Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Message-ID: <awWRZ9xCzWLnj_R6@thinkstation>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
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
In-Reply-To: <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>

[+Cc Relevant folks]

And a bit of context on the underlying problem.

kmalloc_nolock() could fail when there is a contention on locks
shared across CPUs (e.g., n->list_lock in slab, zone->lock in buddy),
or there is a decent amount of memory pressure. It's more restrictive
than GFP_ATOMIC.

Unconditionally using kmalloc_nolock() in BPF local storage is
unnecessarily restrictive when the program can sleep or spin, and
Emil's patchset teaches the local storage whether the BPF program
accessing the local storage could sleep or spin on a lock.

Answering the question "Does this context allow sleeping, or spinning
on a lock" is extremely tricky in the Linux kernel as BPF programs
could run and call kfuncs almost at any point in the kernel code and
the "context" is usually encoded in the GFP flags or the process flags.

Tracking whether certain locks are taken by current context is not
ideal either as it adds unnecessary overhead for everybody.

On Tue, Nov 24, 2026 at 06:40:11AM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> > +	/* Only try the spinning allocation when preemption disables are tracked. */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
> > +	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
> > +		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
> 
> It works, but I after a bit of brainstorming the following
> might be a better fix, since it will address the root cause:
> Pls run it by Vlastimil, Harry, Sebastian.
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2fef409..4368ab5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  	return NULL;
>  }
>  
> +static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
> +
> +/*
> + * zone->lock is always held with IRQs disabled. A caller that runs with IRQs
> + * enabled is not nested inside of it, so it can wait for the owner.
> + */
> +static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
> +		return spin_trylock_irqsave(&zone->lock, *flags);
> +
> +	/* The caller may hold a raw_spinlock_t. */
> +	lock_map_acquire_try(&zone_nolock_map);
> +	spin_lock_irqsave(&zone->lock, *flags);
> +	lock_map_release(&zone_nolock_map);
> +	return true;
> +}

I'm not sure this is a better solution unless this could be generalized
or abstracted further.

>  /*
>   * Obtain a specified number of elements from the buddy allocator, all under
>   * a single hold of the lock, for efficiency.  Add them to the supplied list.
> @@ -2550,7 +2568,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	int i;
>  
>  	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
> -		if (!spin_trylock_irqsave(&zone->lock, flags))
> +		if (!zone_lock_nolock(zone, &flags))
>  			return 0;
>  	} else {
>  		spin_lock_irqsave(&zone->lock, flags);
> @@ -3237,7 +3255,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  	do {
>  		page = NULL;
>  		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
> -			if (!spin_trylock_irqsave(&zone->lock, flags))
> +			if (!zone_lock_nolock(zone, &flags))
>  				return NULL;
>  		} else {
>  			spin_lock_irqsave(&zone->lock, flags);
> 
> pw-bot: cr

-- 
Cheers,
Harry / Hyeonggon
