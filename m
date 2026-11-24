Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543674;
	b=qO7gaFV066H2hm0YDoxCoLj5/q6OIQf5AvJpBMNQp3TwLGhtu8Yn9YanuanHTHm5wH/y
	 dkTzWIAX5tC5MWXgfqn23iJb76xp2HPpSQMObWh7lPv44snqQow5GJEoJjBhGnhfZ5dGC
	 cWD53SQ/L7czVh7QQJ1WETxwtYc9kJAerG02gp5aVcZGvgIwSqvIOzQLg+jRF5a/S7YDK
	 BwhDOlnzTjj8+pGNFKSAppWRsHvWiRShWk7XkLJxbt92MJkmXwu240OqCUM1zCRUMAca3
	 fKG21HFh5TA5VdPD1TnHdePLSYO97Gt1Bs9Rws/mNkEjFT66pRhZr6j6xwDxWWF2PqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
	b=SXbW3x2ohG5wITNgcZ1c+2yaF+qXM6EOr2mdRXaCfDPTn3l8nP7yDhWJMnwqDJTJHRsq
	 YELlm3QTOPfklaTKwC6yNCQXus7YynwW2HgvTEVgmmjzue3lkAEfkDbSE7I/em66lPZa2
	 1Ei37oEorpZt8wZeN+GxjSE2hE9sd36k4ENyxNuO0aqcqPao6yfbH4Koa++tnEf1+Wdxl
	 aYwRFwp58S1TJhMVL1JlRVi+G4JmcNQS9630ClkEv8f/upr2nekKRDsQoBCWoob708VYX
	 GVkdjcmwfKt/XQ5dSxsU6tARD3ryIgMzDHxaFWPo8FkY6ow2dZLz1bPjYfomIG4PjUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=m9Gg7CuI;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDF606A33E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1FDF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=m9Gg7CuI
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3114025b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795543668; x=1796148468; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
        b=m9Gg7CuIG+jD0F4py9j/7S33KdOQKnj1BFeWFS7deXWSLRTSpi5axZOyScB7q6h6Jh
         cmKjd39TdnMesr99sl4PPEOr3evNY1EKBME81qLW7WSlv5c8a9SCm/S6X6hHddaB08yv
         2MSNmuhbAU2STpzoHFA4wmXjjadDndtxEzyBGzgYkx3G3ufBdWxE1PZcF0WKZvimIqu7
         sfsDDLZnEf6RXQu5S1mXmLeryVmpwDINaqvOwVKxHrqoD3bpyFgOJZ3A0Cx8CEkUtGFD
         lfIqZ2QmJJYn83ctLX6MeJ1Q5K9jynH26heEoTBO1/VHsAWjYFLbjL1/xWLlK6yE22Of
         eL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543668; x=1796148468;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
        b=Bu0/OhyRrlcGc9iww6NJKguY50LpNcfv9chFVIvuEkM2M/qaABtEzFNMhhBFAOw3eh
         e4j1WByylKBS58l94MUuSDiDPmcqEtDj68eNsLNXRJtcB0TgBa2r98HMxahey9PPdqkm
         LmGer9rRISmg0iSFQcAt25b5JD87DSZLzn0iohti6eY+68+97NhsBiSflZkJJyJ8u5U0
         jNF9cFctql8vxqjgUghT1F00h/ZfH5Glsajs6I4OLrLW7JqZaxOMV6J2piGZfhOZ00EA
         P6i5TwK2AqepIRw6CF2fZH+fcN99Y0Mvv1sEE77nL9KTQ+qxxcHCkDGx7y2Xvn3S47xK
         r7bA==
X-Forwarded-Encrypted: i=1; AL+hErEanrNA9GpY81sKc4yqRK+EHkUIfgLkuCYawy+A7XnLcoDs90+tPzp/exHkev1vt8ni3oc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A3maZ4JlvWERpbjTIQqIbpTl7+IJhwv2rb3ZMhFMmLEiVt8Ak
	mjtod0DKqhzf6PewWC3DgjGbREKI7ltfTIpHpD3HSCSNQtnNiz8o1R3Q+cguBEEcWYI=
X-Gm-Gg: AZFdTZcWCRTzYvKYEOelxO411KbjPyijOxXbeS2zvMFIkj3FYaWNxSNHijD2da3FGCG
	yEdw43bb6cHrlfeCB/Ql8A5iSL1EJGxiGf/Gr0IM6mCZMDzdatqBZDeWE/MZ17RSLxvGyBtVxyf
	hR5aiBkapbBIARQeQ0fezgwtyJhdXtedJSl0SNeMYWiNVf/VUf6xsA3q5zG4E2oc/rfw43RLcKO
	vL6uosQQt4gPpgNJ28XzCIbeEsWjfY8v72Y3/zY5j3YDQPN8HxaTvPAOy1kEmlToOwDmRXtVwBR
	YzMFLdR1f9vO5wEL41+s759b4YB6JawofjEmVlS/kdHyoL819dl9EKMCDJ1vKSVb+IkXaaSZKcR
	3fSZlqan6cGINhsb2F9E97pINhk9IETYiRymzkDYp86DgZkPurfZIVQ5Lv7Kg7spi8g19wx6ZHV
	ymPnLaA8658G7GKggDBNxzmpuhhE78ytlBe2MZylC3+VqNSp0un8bL79DpWBLALknaq+Yf2OwZL
	3PEmcCDWEFWyol5Pl+CgPYXKWVreXipqHsgJHSJC/hZByLthwaDL1n/eKAzH2QxWZRP4GDx7UN3
	v1bvG4FkkXidq6ouPGw0WDWpEXaR4M+mF1+URsXOqmZZxqyw4RbGHlUeV//vFtXYe3MZ3ZtFONK
	BSb1OVyccVFPyv0210vo91HYRd2HZvJTCek75ugM=
X-Received: by 2002:a05:6300:492:b0:3eb:a2d9:58f1 with SMTP id adf61e73a8af0-401493a61ecmr13003503637.9.1795543668120;
        Tue, 24 Nov 2026 10:07:48 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm7283156a12.15.2026.11.24.10.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 10:07:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 18:07:46 +0000
Message-Id: <DN3N3WXWFO3J.IQPVUAFZKE3B@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Harry Yoo" <harry@kernel.org>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation>
In-Reply-To: <awWRZ9xCzWLnj_R6@thinkstation>

On Tue Nov 24, 2026 at 1:59 PM UTC, Harry Yoo wrote:
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

Yes, we considered the page_alloc approach with Harry offlist and I think w=
hat
it comes down to is that one approach is the most turnkey for users while
the other has the clearest semantics. I went with the latter because
making the selection straight in the BPF code makes the behavior of the
top-level local storage alloc call ends up easier to understand and
explicit in the BPF subsystem.

>
> On Tue, Nov 24, 2026 at 06:40:11AM +0000, Alexei Starovoitov wrote:
>> On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> =
wrote:
>> > +	/* Only try the spinning allocation when preemption disables are tra=
cked. */
>> > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
>> > +	    size <=3D KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
>> > +		ptr =3D kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
>>=20
>> It works, but I after a bit of brainstorming the following
>> might be a better fix, since it will address the root cause:
>> Pls run it by Vlastimil, Harry, Sebastian.
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2fef409..4368ab5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, =
int migratetype,
>>  	return NULL;
>>  }
>> =20
>> +static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
>> +
>> +/*
>> + * zone->lock is always held with IRQs disabled. A caller that runs wit=
h IRQs
>> + * enabled is not nested inside of it, so it can wait for the owner.
>> + */
>> +static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
>> +		return spin_trylock_irqsave(&zone->lock, *flags);
>> +
>> +	/* The caller may hold a raw_spinlock_t. */
>> +	lock_map_acquire_try(&zone_nolock_map);
>> +	spin_lock_irqsave(&zone->lock, *flags);
>> +	lock_map_release(&zone_nolock_map);
>> +	return true;
>> +}
>
> I'm not sure this is a better solution unless this could be generalized
> or abstracted further.
>
>>  /*
>>   * Obtain a specified number of elements from the buddy allocator, all =
under
>>   * a single hold of the lock, for efficiency.  Add them to the supplied=
 list.
>> @@ -2550,7 +2568,7 @@ static int rmqueue_bulk(struct zone *zone, unsigne=
d int order,
>>  	int i;
>> =20
>>  	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>> -		if (!spin_trylock_irqsave(&zone->lock, flags))
>> +		if (!zone_lock_nolock(zone, &flags))
>>  			return 0;
>>  	} else {
>>  		spin_lock_irqsave(&zone->lock, flags);
>> @@ -3237,7 +3255,7 @@ struct page *rmqueue_buddy(struct zone *preferred_=
zone, struct zone *zone,
>>  	do {
>>  		page =3D NULL;
>>  		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>> -			if (!spin_trylock_irqsave(&zone->lock, flags))
>> +			if (!zone_lock_nolock(zone, &flags))
>>  				return NULL;
>>  		} else {
>>  			spin_lock_irqsave(&zone->lock, flags);
>>=20
>> pw-bot: cr

