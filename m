Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F6390990
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714476; cv=none; b=eZIwLu8rNusQyVisGqSEzvWMyAV/bNvCoUiEByd4Zy7PC/NyIxqyfaVLmEX1NbX5q8CiZo0pTyaE28pe/XRXAQoYjQVV3dMEx6SNY+U+wc8lRhuHgfxWg7AMuPpyDUSbPq22GQO4YKDv4CKDofcWbhb7GKxM59ezbdBDWpeUsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714476; c=relaxed/simple;
	bh=NmTvPpBOEanmKzfszEfwS50NLM3yxWY8DAIxVfRoNLE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BFAn99wzi0gCAGyLpdU5DuVQ2JaxLXt2cBcRNCFGlL70w9kc/UbwC+c5a2VxADLD2HzWgvp7MWS5bI/IqIxSwMdlJLtirT6/YweVAmYK+P06GtWwdNUe8gFgxWxi95pLkmiVswvQYRg9MvenSUv2JCx1caO5ZoW54RfqQPeMXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8arYGpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8arYGpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C214C19425;
	Wed, 13 May 2026 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714476;
	bh=NmTvPpBOEanmKzfszEfwS50NLM3yxWY8DAIxVfRoNLE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W8arYGpoXVd64I13bHI+VsK4jJQwJ5dwpxIh1MRW3TQ3ktJ0ZFu/E04aKBc+TLId8
	 5Grvui2uUU3PdShIIxnlA/aFy5V8r/zWp9uf3XK1aFfxqQVzKsAOLmSHOvQztNYPF3
	 8IhzpC3bxX70U7vLYPcK6ylpEugGd+AyYEVydQUfuNOdccHtuvxNnyYW0wlA/VSbfr
	 m5HZdvLBGRjCJSQ8YKMRf/aCZBLJDmwZs5CKhO8pvnBM/q3odLtd6K41xQAR3+tV+b
	 rLJCUKKm0FNENLK6DM/GHcR8oVPgWHiEWgE+RFY7/Zmw+XsWZOhoJISTuwc6BKvMeT
	 9r4VRygGhT+2g==
Content-Type: multipart/mixed; boundary="===============6425944684498931191=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95f425fece8396e78971f50a19a7a1222c044417ec12a4b997ff9e5383cd804a@mail.kernel.org>
In-Reply-To: <20260513-rhash-v4-1-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-1-dd3d541ccb0b@meta.com>
Subject: Re: [PATCH bpf-next v4 01/11] rhashtable: Add rhashtable_next_key() API
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 23:21:16 +0000 (UTC)

--===============6425944684498931191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece36..edf4d4c5102e 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -650,6 +650,91 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
>  	return NULL;
>  }
>
> +/* Internal: scan one element forward from prev_key's position.
> + * Returns first rhash_head whose bucket >= prev_key's bucket and
> + * (if within prev_key's bucket) appears after prev_key in chain.
> + * Returns first element if prev_key is NULL or ERR_PTR(-ENOENT) if prev_key
> + * is not found.
> + */
> +static __always_inline struct rhash_head *__rhashtable_next_in_table(
> +	struct rhashtable *ht, struct bucket_table *tbl,
> +	const void *prev_key, const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{
> +	struct rhashtable_compare_arg arg = { .ht = ht, .key = prev_key };
> +	struct rhash_head *he;
> +	unsigned int b = 0;
> +	bool found = false;
> +
> +	if (prev_key) {
> +		b = rht_key_hashfn(ht, tbl, prev_key, params);
> +		rht_for_each_rcu(he, tbl, b) {
> +			if (found)
> +				return he;
> +			if (params.obj_cmpfn ?
> +			    !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
> +			    !rhashtable_compare(&arg, rht_obj(ht, he)))
> +				found = true;
> +		}
> +		if (!found)
> +			return ERR_PTR(-ENOENT);
> +		b++;
> +	}
> +
> +	for (; b < tbl->size; b++)
> +		rht_for_each_rcu(he, tbl, b)
> +			return he;
> +	return NULL;
> +}
> +
> +/**
> + * rhashtable_next_key - return next element after a given key
> + * @ht:		hash table
> + * @prev_key:	pointer to previous key, or NULL for the first element
> + * @params:	hash table parameters
> + *
> + * Returns the next element in best-effort iteration order, walking the
> + * @tbl chain (including any future_tbl in flight). Caller must hold RCU.
> + *
> + * Pass @prev_key == NULL to obtain the first element. To iterate, set
> + * @prev_key to the key of the previously returned element on each call,
> + * and stop when NULL is returned.
> + *
> + * Best-effort semantics:
> + *   - Across the tbl->future_tbl chain, an element being migrated may
> + *     transiently appear in both tables and be observed twice.
> + *   - Concurrent inserts may or may not be observed.
> + *   - Termination of a full iteration loop is NOT guaranteed under
> + *     adversarial continuous rehash; callers MUST tolerate skips and
> + *     repeats and SHOULD bound their loop externally.
> + *   - If prev_key was concurrently deleted and is not present in any
> + *     in-flight table, returns ERR_PTR(-ENOENT).
> + *
> + * Returns entry of the next element, or NULL when iteration is exhausted
> + * or ERR_PTR(-ENOENT) if prev_key is not found.
> + */
> +static inline void *rhashtable_next_key(
> +	struct rhashtable *ht, const void *prev_key,
> +	const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	tbl = rht_dereference_rcu(ht->tbl, ht);
> +	do {
> +		he = __rhashtable_next_in_table(ht, tbl, prev_key, params);
> +		if (!IS_ERR_OR_NULL(he))
> +			return rht_obj(ht, he);
> +		if (!he)
> +			prev_key = NULL;
> +		/* Ensure we see any new future_tbl attached during a rehash. */
> +		smp_rmb();
> +		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
> +	} while (tbl);
> +	return he; /* NULL or -ENOENT */
> +}

In v3 of this patch series, Herbert Xu raised a concern about rehashing
causing infinite iteration in get_next_key():

  https://lore.kernel.org/bpf/afCNDOhbszgMlGB7@gondor.apana.org.au/

  "The same issue from v2 still exists here. If a rehash occurs in
  between calls to rhtab_map_get_next_key you could be iterating over
  the table forever."

This v4 takes a different approach by introducing a new
rhashtable_next_key() API instead of using the rhashtable_walk_* API.
The commit message now documents the issue:

  "Termination of a full iteration is not guaranteed under continuous
  adversarial rehash; callers must bound their loop externally."

However, Herbert Xu has not yet reviewed or acknowledged this new
approach in v4. Given that he maintains rhashtable and raised concerns
about the iteration behavior in v3, would it be helpful to get his
feedback on this alternative design before merging?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25830929099
--===============6425944684498931191==--
