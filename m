Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610600;
	b=lUUnNS8a6yws3fR76zQU2cqz+Xluj7cjJMrCEOpUKUa6E+FLz/sAtWEE2W9vI1uBcL0A
	 65lRfQ3EmK9wKZMVX035GYOqyVdO4BAXvvTcG7S+TtlsNvEZLg4OHyj/y0tBxa0vdOtMi
	 vZ5Or+k0BjNFIWeOJdrmRFo+f5KgtihibH5Bmu3sAfDeAamJVNsWXti2IQmYa2ipJtnAz
	 KmnfSV9ffdoilAWL+79HvGx5bcnnoszss6OrytSjwtG1xhg6YPDU4vcpizP6fowa65bdX
	 ujb/QnxvCL36ajObYJAzP6koh6A5AEQWd9aNSIMLoY78L0YicyAR03sX3dBfuhKG9og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610600;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DGlnuOHumE+T11zyYg+nmOnjux9Y7t4aQF8bT4NlU0A=;
	b=INUGUh5hdjZMgc21ndSA+ZBEElsFTsa2KN+B0BnAkGn0h4fHRZS32EAwyiRa386CqZeY
	 Y+64Ltb2v6UPHueocLhvG1vE5McbaoslhoBUSyDOxvZGdpJAhmjMTA7GHDPmtkBKtb30E
	 yHkmNN1VmlRXs2k8FKCsSBxnQ5uvSOAL3OqPhZW1YcL0SJqBMgBQrl26pLfFivPwKmyF8
	 W+VUaPYTM28KDk8758IflhkJU8HQZo9DxyGelVD+dg8W+YwpZY1VTCeg3KsWzdT/8mny/
	 WG6qos5CTXDa6WDbFjjgLtyFMOgor8MGcKeNE1ch45DmO289znUS7ww2CeaMhxzfqSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT8ghLvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538D606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT8ghLvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A091F000C1;
	Wed, 21 Oct 2026 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610600;
	bh=DGlnuOHumE+T11zyYg+nmOnjux9Y7t4aQF8bT4NlU0A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iT8ghLvNEL61Ky5TPtxLSVQWmQbFYd6q33zD7njG0kDJTpd+NAd5v5HN/g6yqqAJL
	 T0fYpm8ErNRSQ3mxCq8+TD3MQNgqz+7udZYhQwB8tWiW+vMJ/MbDVfEWsWfsLNN+4Q
	 78Li13IYF4ccnZpl7/kPYiAOBLIY5y6ST8VKHuWkta++2IklD7YeM5wX6CFUhWWBs+
	 vUigQJGwzc08oGAALPnqwAhycVmZhz+3pnHhDDDFd4E2JndFibjT3yHpVsi1Tn7v/h
	 Ij3sJAyDSHzSwNgbmwMmz/44zuUBlkEYd+IZn09eeSuNdHIuCVgR7Hvu1dZNY6dcda
	 OMp+QVCZTnJkA==
Content-Type: multipart/mixed; boundary="===============8324463472386661966=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ac40b5a677a32b6a04824bf86b78bbb432813792d8b6ecf721c7a6a41ce9db5b@mail.kernel.org>
In-Reply-To: <20261021185117.650403-1-puranjay@kernel.org>
References: <20261021185117.650403-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Drop percpu_counter from the htab element count
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,mykyta.yatsenko5@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 19:23:19 +0000 (UTC)

--===============8324463472386661966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Drop percpu_counter from the htab element count

TL;DR:
- On 32-bit kernels, torn s64 elem_count reads or NMI races may make
  is_map_full() wrong: spurious -E2BIG, or inserts past max_entries
- Two comment-style nits

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bf78e09f4d51..6e2115477cb9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -94,10 +94,10 @@ struct bpf_htab {
>  		struct bpf_lru lru;
>  	};
>  	struct htab_elem *__percpu *extra_elems;
> -	/* number of elements in non-preallocated hashtable are kept
> -	 * in either pcount or count
> +	/* number of elements in non-preallocated hashtable. With
> +	 * use_percpu_counter it only follows map.elem_count in steps of
> +	 * PERCPU_COUNTER_BATCH, see is_map_full()
>  	 */
> -	struct percpu_counter pcount;
>  	atomic_t count;
>  	bool use_percpu_counter;
>  	bool has_hash;

this isn't a bug, but this multi-line comment still has text on the opening
/* line.  Since the comment is being rewritten anyway, could the /* go on its
own line, as is preferred under kernel/bpf/?

[ ... ]

> @@ -739,29 +739,20 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)

[ ... ]

> +/* is_map_full() needs htab->max_entries - cur_number_of_elems to be more than
> + * batch * nr_cpu_ids for the percpu counter to be faster than atomic_t. In
> + * practice the average bpf hash map size is 10k. With batch count of 32 a 10k
> + * hash map on a system with 64 cpus can be filled up to 80%:
>   * 10k - 8k > 32 _batch_ * 64 _cpus_
> - * and __percpu_counter_compare() will still be fast. At that point hash map
> + * and is_map_full() will still be fast. At that point hash map
>   * collisions will dominate its performance anyway. Assume that hash map filled
>   * to 50+% isn't going to be O(1) and use the following formula to choose
> - * between percpu_counter and atomic_t.
> + * between the percpu counter and atomic_t. The batch has to be a power of 2.
>   */
>  #define PERCPU_COUNTER_BATCH 32

this isn't a bug, but the same applies to the rewritten comment above
PERCPU_COUNTER_BATCH, which also starts its text on the opening /* line.
Could it use the /* on its own line style as well?

[ ... ]

> @@ -1162,30 +1151,33 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>  
>  static bool is_map_full(struct bpf_htab *htab)
>  {
> -	if (htab->use_percpu_counter)
> -		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
> -						PERCPU_COUNTER_BATCH) >= 0;
> -	return atomic_read(&htab->count) >= htab->map.max_entries;
> +	s64 count = atomic_read(&htab->count);
> +
> +	/* each cpu's elem_count is ahead of count by less than the batch */
> +	if (htab->use_percpu_counter &&
> +	    count + nr_cpu_ids * PERCPU_COUNTER_BATCH >= htab->map.max_entries)
> +		count = bpf_map_sum_elem_count(&htab->map);
> +	return count >= htab->map.max_entries;
>  }

Can a torn read of the per-cpu s64 elem_count on 32-bit kernels make
is_map_full() return the wrong answer here?

bpf_map_sum_elem_count() does READ_ONCE(*pcount) on each s64, which on 32-bit
is split into two 32-bit loads (see include/asm-generic/rwonce.h).  A per-cpu
elem_count crosses zero regularly, since an element is often freed on a
different CPU from the one that allocated it.

A 0 -> -1 update rewrites both halves:

    0x00000000_00000000 -> 0xffffffff_ffffffff

If another CPU in htab_map_update_elem() -> alloc_htab_elem() ->
is_map_full() reads the counter in the middle of that update, it can see
0x00000000_ffffffff (+4294967295).  Then "count >= htab->map.max_entries" is
true and alloc_htab_elem() returns -E2BIG for a map that is not full.

A -1 -> 0 update can read as -4294967296, which lets an insert go past
max_entries.

The old slow path was percpu_counter_sum(), which reads s32 per-cpu counters
and fbc->count under fbc->lock.  Near max_entries fbc->count is a large
positive value, so a torn read could not affect that decision.  Before this
patch, torn elem_count reads only affected the iterator statistics.

>  
>  static void inc_elem_count(struct bpf_htab *htab)
>  {
> -	bpf_map_inc_elem_count(&htab->map);
> +	s64 cnt = this_cpu_inc_return(*htab->map.elem_count);
>  
> -	if (htab->use_percpu_counter)
> -		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
> -	else
> +	if (!htab->use_percpu_counter)
>  		atomic_inc(&htab->count);
> +	else if (!(cnt & (PERCPU_COUNTER_BATCH - 1)))
> +		atomic_add(PERCPU_COUNTER_BATCH, &htab->count);
>  }
>  
>  static void dec_elem_count(struct bpf_htab *htab)
>  {
> -	bpf_map_dec_elem_count(&htab->map);
> +	s64 cnt = this_cpu_dec_return(*htab->map.elem_count);
>  
> -	if (htab->use_percpu_counter)
> -		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
> -	else
> +	if (!htab->use_percpu_counter)
>  		atomic_dec(&htab->count);
> +	else if (!((cnt + 1) & (PERCPU_COUNTER_BATCH - 1)))
> +		atomic_sub(PERCPU_COUNTER_BATCH, &htab->count);
>  }

The same concern applies to inc_elem_count() and dec_elem_count().
this_cpu_inc_return() on the s64 per-cpu elem_count uses
this_cpu_add_return_8, which x86 only defines under CONFIG_X86_64.
Elsewhere it falls back to this_cpu_generic_add_return(), a
raw_local_irq_save() read-modify-write that an NMI can interrupt.

On x86-32, if an NMI perf_event program updates another bucket of the same
map in that window, it can see the same return value as the interrupted
context.  If that value is a multiple of PERCPU_COUNTER_BATCH, both contexts
run:

    atomic_add(PERCPU_COUNTER_BATCH, &htab->count);

(or both run atomic_sub() on the dec side).  htab->count then stays 32 off
from the sum of 32 * floor(elem_count / 32) permanently, and the error grows
over time.

That breaks the "each cpu's elem_count is ahead of count by less than the
batch" invariant that the fast path in is_map_full() relies on.  A downward
drift lets the fast path return false while the map is already full.

The old x86-32 fast path used this_cpu_try_cmpxchg() on s32 counters
(HAVE_CMPXCHG_LOCAL), which an NMI cannot split.

This seems to contradict the commit message statement "so that is exact, in
NMI as well" for 32-bit kernels.  Should the batched elem_count scheme be
limited to configurations with native 64-bit per-cpu ops, or should the
summing side handle torn values?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39658415298
--===============8324463472386661966==--
