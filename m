Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686386;
	b=3KidfjGYjOYKxs8gobHgyOs9OJixbynjnj+n1orkvZl8CrXtFAEW2r4pVJzj63DPjW5k
	 TvcEp1YZBG0Y9Rd89X2Ai9QHEkujF4yTaxZO551b1QTjfFCEIAK8SjFFu0YMT3sUSIy35
	 0XmpQrrt7LUrfdh2BT9hniyi6xCTBJfk/A22YlSJCEZLopYr42+xOgcPi74zoR0dw+EjL
	 fTU3pJU9O6oO9Oyqd/COjugT0R2QbmUDZzOQ8IF7tzUsKkk7UrVFxm/O21Ihev3oCadMy
	 kGGcQ8sr6WCWv9N2PPmlOhEsQYF5jSIFP/9f68ir8ZnMyYfhYyCIuqXMkwwUy1YjmAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686386;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9iOFGCN2xqfzOpq48k6oJBM/eJYJ7XXUTZKnlzXr0YI=;
	b=GHm1VOjlGkeTDG+bNnd8nH2hfAwbBFOicq4mWR3zx5colGQtq/PaKznfR1llOK4doe5q
	 MgeXXRO5tW73NAy+GgGiw17uMK/NfkTrTjzF59cb/PQPMmN4m/JDNjR8THXrBtkFdEGiH
	 84AdkrOt5jY6hrScZ3COoltHH6ePdjy1iNQSJE7CoLFggdRy7WpRKtpep9+6y0atUZs/g
	 azQSO6iA6GJBAFFP4yup6qsQBuDjcgRTed2FQOeK6fgUMXV05/SnByLeLgVYImhb0N71S
	 dZBdPJHcZhPMkKa7lxkewt58+5HTD2oWKaiBzpn3LTXkyV2MTK+dAMpGErwum5vSJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZfva1MT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223D606A31C;
	Thu, 26 Nov 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZfva1MT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC611F000C0;
	Thu, 26 Nov 2026 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686385;
	bh=9iOFGCN2xqfzOpq48k6oJBM/eJYJ7XXUTZKnlzXr0YI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mZfva1MT0HkGb3bUMZyMaDNx/SSgWJQGvrvB90fiSg6ExD/e2IHNmVp+joGudbs5W
	 4lz+Rj/ZjHsHZWaTBZhUc5nn/To/U+7YNC39ZKO0VkFwg8rkg0PyP4qzNXDBw18DI+
	 t85wpBfIP8OI1JfRs61ONjbZ3ukTEPlcluAkSSvvGfX2YeX0u2Vv6ffqd1A+4LyMLG
	 sGAZ7zYVMaN8Pj0jSkIqhENzHt+nHs89uMB47MU68dhFW6qDH8Qe33Rx5RdY/jg3b7
	 Oz4ISLSPN6u/5TFq/dKt7gT4bmSBoG7cIACIvpVtXEpw3jjB7Ytbq/WeADTVk62Uwh
	 ct8LdZwseltsA==
Message-ID: <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org>
Date: Thu, 26 Nov 2026 10:46:15 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
To: Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 daniel@iogearbox.net, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>,
 Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation>
 <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
 <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com>
 <20261126094403.GA49833@noisy.programming.kicks-ass.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261126094403.GA49833@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 10:44, Peter Zijlstra wrote:
> On Thu, Nov 26, 2026 at 01:04:27AM +0000, Alexei Starovoitov wrote:
>> On Wed, Nov 25, 2026 at 06:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> This is absolute atrocious shite. You cannot attempt a spin_trylock from
>>> NMI context. That thing might be a mutex.
>>
>> cannot spin_trylock from NMI _on PREEMPT_RT_ ... correct.
>> And the patch guard against that.
>>
>> On RT the nolock path doesn't reach zone->lock in NMI or hardirq:
>>
>>   __alloc_frozen_pages_noprof()     alloc_flags has ALLOC_NOLOCK
>>     alloc_nolock_allowed()
>>       can_spin_trylock()
>>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>>                 return false;
>>
>> fwiw kmalloc_nolock() has the same check.
>>
>>> This should not work; if it does, that is an accident we need to fix.
>>
>> It's not an accident.
>> In NMI only !RT SMP kernels reach the trylock.
> 
> Allowing this on !RT makes people think this is 'OK' and then the RT
> people get to fix endless crap again :-(
> 
> Locking constructs should behave identical across the configurations to
> avoid divergence and create problems.
> 
> You're actively creating something that doesn't and cannot work on RT.
> That is not cool.

This is all just way too complicated and shaky, sorry to say it.

-- 
Cheers,

David
