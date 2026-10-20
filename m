Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502913;
	b=Jg9i3Rqq1IPJFe6lLiubGNWmR5jmc+ZyHmJdAqwAIHuDxXoWdOcCU3wSTU9rXUYscrEU
	 g45tJJb+WOhpkP8alrApQG/et6HEm8ODwKxIOfrE0X2iRyNz5waUbM/xdC3piKUdCVY8U
	 rrCbLKlQZU8b06tbyqJqXghJeNgj2JXk2EvbDK30vZRdqt7IzQP+QQHTalvWhYdpp3Eqr
	 o0Ks8MjxJijC5UFnUv6h/qfPsjdQ7dotxfMKCumP+fcR+3J+4Auc/vBO1FVW6imkfzGay
	 +/VsoG28l52fP3HfvF7zcSpbbssfunbTDetFz1OhIKuYCxuACx4vDO4+avnBnfycW0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xnlzo4fG0UZyLGW9CfjR229o5tG5Xv1ZKZ4PZU+ji/A=;
	b=WdpCRdsJo3ENOLJLhT2yMdHW5wpxEh6giEhYz932WNkSn0k8BVIy/X8Mz1TEsDSuqxTL
	 d9gpUDBHNFKfKgHWALbJ4MAd+glYEbRRf+r4sepTb0Myr/wS6oqIs7YKjwIf6VK7R8DrJ
	 PM6yG6oh9iwbCRPrgoAeCrqo0qOtRs2bEXDPmzsd7LiQ9kG9sNSBLHlE/F0d0+5w0li0B
	 hSQ2museUtEeA5OdkRpQFOee4qbZSYI1QogNaRJn3JZn7AKWPgxoUUIRBmP+Qcj3pyXUv
	 666Mv0xwPv4HFlTykBWOgY1ZmrV3IkNP+zaGBsUh5xUu77L7NkUGrcMTRLjReEMMLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A68uQ3zc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10531606A324
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A68uQ3zc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACF11F000C8;
	Tue, 20 Oct 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502912;
	bh=Xnlzo4fG0UZyLGW9CfjR229o5tG5Xv1ZKZ4PZU+ji/A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A68uQ3zccE6W8yiyi9ITaI7pqj8sgDvcgCZeypE9kk3hkPQQua9OFyG0Z7zhy3ZWF
	 3Gs8sY3555yCD15VD8/VTnXyGsBNPm5EOzA+s3GqBIWwt4knpCCvzleFcw0DWG0U/T
	 KZ2nhgjGJe99A0uhYqTMlzzk0zRmB3d3x35tU95GWgWt0VvTsNqAozOrvCY6eTyZOa
	 QpHNkuE8cwLDNnITwnInpaC/XZwpU4gIBw8AlB047yl+sOVUjseuE8g4J2ETwgbTAX
	 5SqACpahxhOD/HTDbGro5hx8uKKDJ6PYBzUaiSa7QDkg3C2OHhyQSs6IWMa0el+06V
	 UlvXwvYS0At1g==
Message-ID: <sashiko-outbox-179024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Don't use percpu_counter for the htab
 element count in NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261020131524.207415-1-puranjay@kernel.org>
References: <20261020131524.207415-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:28:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: 32-bit atomic_t htab->count overflow with 64-bit percpu_count=
er
--

commit 9bfb61b87bddde697a9661d8440f11f7f1dcd019
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Don't use percpu_counter for the htab element count in NMI

This patch avoids deadlocking on the percpu_counter spinlock in NMI context
by routing NMI element count updates for non-preallocated hash maps into
htab->count instead of htab->pcount, and combining the two counters in
is_map_full() and htab_map_mem_usage().

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bf78e09f4d518..7a27479c46dc5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -95,7 +95,8 @@ struct bpf_htab {
>  	};
>  	struct htab_elem *__percpu *extra_elems;
>  	/* number of elements in non-preallocated hashtable are kept
> -	 * in either pcount or count
> +	 * in either pcount or count; with pcount, those added or removed
> +	 * in NMI are in count, see is_map_full()
>  	 */
>  	struct percpu_counter pcount;
>  	atomic_t count;
> @@ -1160,11 +1161,23 @@ static void htab_put_fd_value(struct bpf_htab *ht=
ab, struct htab_elem *l)
>  	}
>  }
> =20
> +/*
> + * With use_percpu_counter the elements added or removed in NMI are coun=
ted in
> + * @count, as percpu_counter takes a spinlock that the NMI could have
> + * interrupted the holder of.
> + */
>  static bool is_map_full(struct bpf_htab *htab)
>  {
> -	if (htab->use_percpu_counter)
> -		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
> +	if (htab->use_percpu_counter) {
> +		/* percpu_counter_sum() takes that lock, so only read it in NMI */
> +		if (in_nmi())
> +			return percpu_counter_read(&htab->pcount) +
> +			       atomic_read(&htab->count) >=3D htab->map.max_entries;
> +		return __percpu_counter_compare(&htab->pcount,
> +						(s64)htab->map.max_entries -
> +						atomic_read(&htab->count),
>  						PERCPU_COUNTER_BATCH) >=3D 0;
> +	}
>  	return atomic_read(&htab->count) >=3D htab->map.max_entries;
>  }
> =20
> @@ -1172,7 +1185,7 @@ static void inc_elem_count(struct bpf_htab *htab)
>  {
>  	bpf_map_inc_elem_count(&htab->map);
> =20
> -	if (htab->use_percpu_counter)
> +	if (htab->use_percpu_counter && !in_nmi())
>  		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
>  	else
>  		atomic_inc(&htab->count);
> @@ -1182,7 +1195,7 @@ static void dec_elem_count(struct bpf_htab *htab)
>  {
>  	bpf_map_dec_elem_count(&htab->map);
> =20
> -	if (htab->use_percpu_counter)
> +	if (htab->use_percpu_counter && !in_nmi())
>  		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
>  	else
>  		atomic_dec(&htab->count);
> @@ -2578,7 +2591,8 @@ static u64 htab_map_mem_usage(const struct bpf_map =
*map)
>  #define LLIST_NODE_SZ sizeof(struct llist_node)
> =20
>  		num_entries =3D htab->use_percpu_counter ?
> -					  percpu_counter_sum(&htab->pcount) :
> +					  percpu_counter_sum(&htab->pcount) +
> +					  atomic_read(&htab->count) :
>  					  atomic_read(&htab->count);
>  		usage +=3D (htab->elem_size + LLIST_NODE_SZ) * num_entries;
>  		if (percpu) {

[Severity: High]
Can htab->count overflow or underflow when elements are inserted in NMI
context and deleted outside NMI context (or vice versa)?

When htab->use_percpu_counter is enabled, inc_elem_count() and
dec_elem_count() choose between htab->pcount and htab->count based on
in_nmi() at the time of each operation, and htab->count is never folded
into htab->pcount.

If a perf_event BPF program running in NMI inserts elements via
htab_map_update_elem() -> alloc_htab_elem() -> inc_elem_count() (which
calls atomic_inc(&htab->count)) and userspace or a non-NMI BPF program
later deletes those elements via free_htab_elem() -> dec_elem_count()
(which calls percpu_counter_add_batch(&htab->pcount, -1, ...)), the two
counters diverge without bound over the lifetime of the map.

Because htab->pcount is a 64-bit signed counter (s64) while htab->count
is a 32-bit signed atomic_t, after 2^31 net cross-context insert/delete
cycles, htab->count wraps between INT_MAX and INT_MIN while htab->pcount
continues counting in 64-bit arithmetic.

When atomic_read(&htab->count) is sign-extended to s64 and combined with
htab->pcount in is_map_full() and htab_map_mem_usage(), wrapping
htab->count shifts the computed occupancy by +/- 2^32. That either
disables the max_entries limit in is_map_full() and underflows
num_entries in htab_map_mem_usage(), or causes is_map_full() to
permanently return true (-E2BIG) even when the map is empty.

Should htab->count be atomic64_t (or folded into htab->pcount in the
non-NMI paths via atomic_xchg(&htab->count, 0)) so the two counters
cannot wrap at different widths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020131524.2074=
15-1-puranjay@kernel.org?part=3D1
