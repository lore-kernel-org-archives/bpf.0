Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E821DC1AB
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436654; cv=none; b=iLyLu9aPJVnYH3n+L3hHEqUaXA09Um8mkwjOlXJWLnhilf1o3N3jgDxdkwxWsjfUcL6RjRbjDv5U4bhfJ2H0LAiBYBdVnVpg49f49z+2DppD8lIn0QWlsh1uI1hKacHoBt34dOWgn+uo+N2uiDQma8N+cKCV9B3O6FZv+4CIVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436654; c=relaxed/simple;
	bh=QKME9f22QQDi/mJf9MMgCZ3gv8ORGUVx1fL3GL5rOoA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WLd0SMMBlUD9Cz9j6yinOGF6U8TqKUCDEMaL3QaJMSRVCHDv04VEMdDM7/Um0inj5NgZ+oitEkfGJukAeS21qUNQQ6COY2QuJOa7k35jWw0CH6BC90XXxmHUaPH4H+PEmdBMTig5I7Yo/rYefqbgpNWK8Tp3MrmgRpP2XufkG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kynANM7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kynANM7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658031F00898;
	Tue,  2 Jun 2026 21:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436652;
	bh=rL0+TJoutruQSKj3ZyxR2KO7RkJfgB/NJOOyi9pUVqw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kynANM7M1AaGQzaHnnSTKOWaNKccarGIHy6C+UGCENItKf7G4MmFIDutKo6c58tI0
	 Agg7c55n/U0XwYIPBWI6+scs+qy9T21mQIRvy0CBOVVGToZjlXxhEO2edvz/dPIZHO
	 GZ+AQ65/3uxDu1V3zNaYxnybWP9Mt1VlJhzL0IGHSpB8R3UbdM5YPvl0rPuJdw4ibO
	 UNfjKPEpV71Q0+0naCENXmEyUqDVFKXWVwpcL8GYrf0kTWM0H+3cT1YG+pB+M2OZSw
	 p86hubivlsUQa6azhrZQjEyTzSy/8JeLT1f9iKyM1TiEnvlV/12/bDOlxyCd8vQBAA
	 8xKGufFyEv0bQ==
Content-Type: multipart/mixed; boundary="===============8481201315409494607=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83233804225efa3390e33392e63707d48c5ead1aec3c27884145485dc444ef66@mail.kernel.org>
In-Reply-To: <20260602-rhash-v6-6-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-6-1bfd35a4184f@meta.com>
Subject: Re: [PATCH bpf-next v6 06/11] bpf: Optimize word-sized keys for resizable hashtable
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 21:44:12 +0000 (UTC)

--===============8481201315409494607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 8686918dbc3e..600128c3e328 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2763,6 +2763,31 @@ static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
>  	return l->data + round_up(key_size, 8);
>  }
>
> +/* Specialize hash function and objcmp for long sized key */
> +static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_arg *arg,
> +					      const void *ptr)
> +{
> +	const unsigned long key1 = *(const unsigned long *)arg->key;
> +	const struct rhtab_elem *key2 = ptr;
> +
> +	return key1 != *(const unsigned long *)key2->data;
> +}

Could dereferencing these pointers directly cause alignment faults on
architectures that require strict alignment?

Since BPF programs can pass unaligned pointers (such as from packet data in
skb->data) directly to map helpers, using get_unaligned() might be necessary
here to prevent kernel panics on strict-alignment architectures like ARM32 or
SPARC.

This was raised by Sashiko in v5 and v6 review. While you noted in v5 that
"the same problem exists for the htab jhash2", the issue remains unaddressed.
Does this need fixing?

Reference: https://lore.kernel.org/bpf/20260528182522.23D121F00A3C@smtp.kernel.org/

> +
> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, u32 seed)
> +{
> +	u64 k = *(const unsigned long *)data;
> +
> +	return (u32)(k ^ (k >> 32)) ^ seed;
> +}

Does applying the seed after folding the key make hash collisions entirely
independent of the seed?

If a BPF program or an attacker inserts keys constructed as:

    k = (Y << 32) | (X ^ Y)

These keys will all fold to exactly X before the XOR with the seed, meaning
f(key1) ^ seed == f(key2) ^ seed for any random seed.

If rhashtable detects a long bucket chain and triggers a background rehash
with a new seed, won't all these colliding keys move together to the same new
bucket? This might trap the rhashtable worker in an infinite loop of
rehashing, leading to a 100% CPU livelock.

Sashiko raised this as a critical HashDoS vulnerability in v5 and v6. You
acknowledged in v5 that "the attack is possible in theory" but decided to
"leave for performance" without fixing it. Should this be addressed before
merge?

Reference: https://lore.kernel.org/bpf/20260528182522.23D121F00A3C@smtp.kernel.org/

[ ... ]

> @@ -3167,7 +3216,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>  	 * elements are deleted/inserted, there may be missed or duplicate
>  	 * elements visited.
>  	 */
> -	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
> +	while ((elem = rhtab_next_key(rhtab, prev_key))) {
>  		if (IS_ERR(elem))
>  			break;

Will this iteration silently abort if the callback function deletes the
current element?

Deleting the current element during iteration is a common BPF pattern for
garbage collection. If the callback deletes the current element,
rhtab_next_key will try to locate the deleted prev_key in the hash table,
fail, and return ERR_PTR(-ENOENT). The IS_ERR(elem) check would then
immediately break the loop, skipping remaining map elements.

The same issue affects batch operations. This was raised by Sashiko in v6
review and was never addressed.

Reference: https://lore.kernel.org/bpf/20260602205812.84C631F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26848361040
--===============8481201315409494607==--
