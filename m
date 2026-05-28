Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D02BE7A7
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992205; cv=none; b=c4oQaUcnUgQUrfgHY8pbAwcXznKo/x+i8CQM0MTaDb/gTDjeu5dlqvkhnZN+30ymFkux5PgkBWXMB4meY9eTwAZFoTT/BcUWkG6NfGEWcjIIzX2mK6Qo15bHtyM/8r1CSDVtQZCcOcoIlMKc46V1eYHQXbqyaqP4lcqxoOt/8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992205; c=relaxed/simple;
	bh=My7ktzlkkKIvPHHL0p6sDvCGp89//VzOWZ/ErZn3LIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7Ftwo0C7UAWJKmGpFJritcpimL8/cJ3lOmQXt4zeNeNYRZR2svdmfzbj3s8D0FLQ4Z6zcGx/UnWiy+wGuaN3wHqX3KwPW9MhXrvJSuzo66KPKPT3D9Zcg6EGnM/SVsZr5ZZm7oBCzstkNBixfTMw0dYyiv8ROrmEGgu6cG6Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/PFPScp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/PFPScp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F61F000E9;
	Thu, 28 May 2026 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992204;
	bh=CRXBEU5DeUhC5fR6Mm8hNfZdqNGh7ziJy+tSxdI5jcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/PFPScp1Ne6Bciuug5L5GBMYyV3ib3Q495SbTVx3O8A/TKzjh2kaNj/xGQci6zUp
	 3KpU+9HPFf8VsJYNsR9Jfx8pivpyWV+UvGoNLzCgsPNLoENe7kHzKsbwlxDgmWs8PZ
	 95c8Qe0jewRC8bZBoeMVVzVr9ukSiljGPxD6rQjSBZfvXx+GhEsucPWSHckEA2QYTU
	 pdX3f89WE/ORmRZqscvHiB1oDNq3cVWOlAXHYPcnr6f2YNenP+zmVfRRG5UKBPdz5C
	 45YGDtBn0NQymo02smrxrchHsvCxlkXV7o+wONsZZUnCeQJ2NDvWTGmmyYjl6IsLS8
	 syfkEPt6lzzDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 01/11] rhashtable: Add rhashtable_next_key()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-rhash-v5-1-7205191b6c57@meta.com>
References: <20260528-rhash-v5-1-7205191b6c57@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:16:43 +0000
Message-Id: <20260528181644.360F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] rhashtable_next_key completely skips unmigrated elements if pr=
ev_key has already been migrated during a concurrent rehash.
- [High] rhashtable_next_key enters an infinite loop if the hash table cont=
ains duplicate keys.
- [High] Concurrent deletion of the prev_key element aborts the iteration p=
rematurely and returns a dangerous ERR_PTR(-ENOENT) pointer.
- [High] rhashtable_next_key silently ignores all duplicate elements when u=
sed on rhlist-enabled tables.
--

commit 2aba1f7c85d79ee4c37a0c5013226a79bf52f189
Author: Mykyta Yatsenko <yatsenko@meta.com>
Subject: rhashtable: Add rhashtable_next_key() API

Introduce a simpler iteration mechanism for rhashtable that lets
the caller continue from an arbitrary position by supplying the
previous key, without the per-iterator state of the
rhashtable_walk_* API.

> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece364..d6eb3ba476ea2 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -650,6 +650,97 @@ static __always_inline struct rhash_head *__rhashtab=
le_lookup(
>  	return NULL;
>  }
> =20
> +/* Internal: scan one element forward from prev_key's position.
> + * Returns first rhash_head whose bucket >=3D prev_key's bucket and
> + * (if within prev_key's bucket) appears after prev_key in chain.
> + * Returns first element if prev_key is NULL or ERR_PTR(-ENOENT) if prev=
_key
> + * is not found.
> + */
> +static __always_inline struct rhash_head *__rhashtable_next_in_table(
> +	struct rhashtable *ht, struct bucket_table *tbl,
> +	const void *prev_key, const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{
> +	struct rhashtable_compare_arg arg =3D { .ht =3D ht, .key =3D prev_key };
> +	struct rhash_head *he;
> +	unsigned int b =3D 0;
> +	bool found =3D false;
> +
> +	if (prev_key) {
> +		b =3D rht_key_hashfn(ht, tbl, prev_key, params);
> +		rht_for_each_rcu(he, tbl, b) {

[Severity: High]
Does this silently skip duplicate elements when the table is configured with
rhlist =3D true?

For rhlist-enabled tables (like rhltable), the primary hash chain only conn=
ects
the first element of each unique key group, while duplicates are stored in
secondary linked lists via the rhlist_head structure.

Since this iteration relies exclusively on rht_for_each_rcu() and doesn't
traverse those secondary lists, it seems it will only yield the most recent=
ly
inserted element for each unique key.

> +			if (found)
> +				return he;
> +			if (params.obj_cmpfn ?
> +			    !params.obj_cmpfn(&arg, rht_obj(ht, he)) :
> +			    !rhashtable_compare(&arg, rht_obj(ht, he)))
> +				found =3D true;

[Severity: High]
Can this lead to an infinite loop and RCU stall if the hash table contains
duplicate keys?

Since standard rhashtables permit duplicate keys, rhashtable_compare() will
match the first occurrence of prev_key in the chain and then yield the
immediate next element.

If the next element is also a duplicate of prev_key, when the caller resumes
iteration with it, the search restarts from the bucket head, matches the
first occurrence again, and repeatedly yields the same second duplicate
without making forward progress.

> +		}
> +		if (!found)
> +			return ERR_PTR(-ENOENT);

[Severity: High]
Is it safe to return ERR_PTR(-ENOENT) if prev_key is concurrently deleted?

Unlike standard rhashtable iterators, this abruptly aborts the iteration if=
 the
element is removed, missing the remainder of the map.

Additionally, generic callers utilizing standard loop termination checks
(e.g., while (obj)) could inadvertently dereference this error pointer and
cause a kernel panic.

> +		b++;
> +	}
> +
> +	for (; b < tbl->size; b++)
> +		rht_for_each_rcu(he, tbl, b)
> +			return he;
> +	return NULL;
> +}

[ ... ]

> +static inline void *rhashtable_next_key(
> +	struct rhashtable *ht, const void *prev_key,
> +	const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> +	do {
> +		he =3D __rhashtable_next_in_table(ht, tbl, prev_key, params);
> +		if (!IS_ERR_OR_NULL(he))
> +			return rht_obj(ht, he);
> +		if (!he)
> +			prev_key =3D NULL;
> +		/* Ensure we see any new future_tbl attached during a rehash. */
> +		smp_rmb();
> +		tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);

[Severity: Critical]
Does this logic completely skip unmigrated elements if prev_key has already=
 been
migrated during a concurrent rehash?

If prev_key was migrated, __rhashtable_next_in_table() will fail to find it=
 in
the old table and return ERR_PTR(-ENOENT).

The code then falls back to searching future_tbl where it finds the key and
continues. However, by jumping to future_tbl, the iterator permanently aban=
dons
the old table (ht->tbl) and will never visit its remaining unmigrated bucke=
ts,
causing significant data omission.

> +	} while (tbl);
> +	return he; /* NULL or -ENOENT */
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-rhash-v5-0=
-7205191b6c57@meta.com?part=3D1
