Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FB403144
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992813; cv=none; b=tU9bwqN/gcya43agYNOpok4OMqmGuhgn+yA/gj7e1mTaSN++YTHNLXnI1GbZiR8C7yhBxQz/3VE3KFiU/xyiBd2NVIam6iLP1FnVuV0VxBx7Zubk/91n1nFj2TK8eJq5oxL8h5+z1XCO+XjrI962CrILWBhP7pZbH+3RhgKNqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992813; c=relaxed/simple;
	bh=QTx+AytbjYiM4Gufs8j5/HgoocbROpIfaH3EDmCzPII=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jQPw28texwUloL0VTpjpXJBcAjlk8DBoofuujCWfZXkzUsh7y98mHmdV/H3sXGOuxlNEhER/3SpoUcKs2sXBia/mHiaWR8YZr1Ier8fw17h9M9WY7KMRycL9t39nOvclmArUULEUuW0Z/OtJyByYutcbNod9Ny6ESGZkrayjT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei61CG3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei61CG3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB231F00A3A;
	Thu, 28 May 2026 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992811;
	bh=Fy+bQrFGo2SrICMjmffNOLYd1v2b3CWFIX8Y5wVSEcY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ei61CG3KKa2o4lxxG7wAy9CX9i2DCAQ8NO/2TJppEdFSOGYHviopHixozW2W97O5p
	 VfkFfzuGeWHVN+PZl3FLJogz8eA32RTLH/9vPeGbgJGcQZrvfm53+YqerxPT3ky2em
	 Eb/1+aCx+XRIWLS82Zi7E8bDnD3aOrbrEYPKnlShvgKdcwsgS6xKkroMPsF/dCGbka
	 qYQ8kwucnAuIHYvKDryzNkay0cvQti9K3LaFITiVXAVL0Iye+TjzebBbk41nH7i/Bf
	 M/xqTM6TGr7msI7P7gJkbRCs+Ufh7Z2vf6IFuFkdNE10xjgcKzwGynKQr+aJl8bjq0
	 M3xASuBz9TEmA==
Content-Type: multipart/mixed; boundary="===============1336015430491692523=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dff0e01315c753d866cb2fb94f92b5af87858ae45c90df3d861a769bc1948b03@mail.kernel.org>
In-Reply-To: <20260528-rhash-v5-1-7205191b6c57@meta.com>
References: <20260528-rhash-v5-1-7205191b6c57@meta.com>
Subject: Re: [PATCH bpf-next v5 01/11] rhashtable: Add rhashtable_next_key() API
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 18:26:51 +0000 (UTC)

--===============1336015430491692523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece36..d6eb3ba476ea 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h

[ ... ]

> @@ -650,6 +650,97 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
>  	return NULL;
>  }
>
> +/**
> + * rhashtable_next_key - return next element after a given key
> + * @ht:		hash table
> + * @prev_key:	pointer to previous key, or NULL for the first element
> + * @params:	hash table parameters
> + *
> + * WARNING: this walk is highly unstable. Unlike rhashtable_walk_*(),
> + * it cannot detect a concurrent resize or rehash, so a full iteration
> + * is NOT guaranteed to terminate under adversarial or sustained
> + * rehashing. Callers MUST tolerate skipped and duplicated elements and
> + * SHOULD bound their loop externally.
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

Herbert Xu (rhashtable maintainer) raised a concern in v3 about rehashing
causing infinite iteration:

https://lore.kernel.org/bpf/afCNDOhbszgMlGB7@gondor.apana.org.au/

> The same issue from v2 still exists here.  If a rehash occurs in
> between calls to rht_map_get_next_key you could be iterating over
> the table forever.

In v4, a new rhashtable_next_key() API was introduced to address this,
with documentation noting the issue. Alexei Starovoitov asked Herbert
"Is it an acceptable api? I suspect you don't like it" but Herbert has
not responded.

v5 added a WARNING in kdoc attributed to "(Herbert)", but this appears
to acknowledge his concern rather than indicate approval.

Has the rhashtable maintainer explicitly reviewed or approved this new
API design?

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

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26592533594
--===============1336015430491692523==--
