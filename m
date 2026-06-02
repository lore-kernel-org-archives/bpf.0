Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBB3A9D9B
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436653; cv=none; b=sljwI3yRirCcHFV9daWh3gWmXDWiI9C0cm2T5UY3uulsemFH2VNhDBM90QTzINUw964JlugnliT5WNmlZZuAnJrq5Nwb34EpB6u42ysalR37QaG67Om5imt6CIJBz4IGhHf6z5gWkgeoG5Pc4bGc/yOhrs70CwArnpDkxh7jGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436653; c=relaxed/simple;
	bh=CePJRKrS2Ymcz+Hgb4SOkttY9I04k7PeKBn0HcAPsZ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IELorZUubisWOkCONtqQDpffypeCLtNdCa16ezkwZ/dOxyWB+DItg+hiM47s5qRejbOtRQyICLerOreosD85r3ezkPR55j+VkYZmu6mf/WLuCc+bCv/eFYzfLU3QQmIfQkwHSVtpmlA8NHuxDyZVcWmAwAWniuVrjG3E6bXSvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioVRNLgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioVRNLgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BB21F00893;
	Tue,  2 Jun 2026 21:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436650;
	bh=WvpLDMHv7b4nzyCRPEMGqGC89yFXJ0CC+S6zDHJ0+t0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ioVRNLghhvT23Rg5qiHbL4g7di0/JcQ5Vxf5suHhwqQcPqGFmECIdeCMOp3tE6yga
	 w4WBWPtJ3cCHNQc3cAFL9UizT/dmDV3XGhRFdZeYi2W2WlJVoX2bj516xVNJNBgkzg
	 QMlU79/Na9heZwg4tUA5NH8NUZp2JJhSQyDHlgpnHjRqkdHRrPnBZlYUYYnKuiByC8
	 K34eJ4/dyy3IorZM2BePEgzzcH1dYphsqNF0A5lT/YK++MleITbPqlbOeJK4jUVVPu
	 xnNjfGvwMOSfMfhqV7mBtvQBjBz3w12/2s+eSJ4z3TOow4g6VJpiGP8zYrgMD31KXh
	 UuuFyXwp2HdSg==
Content-Type: multipart/mixed; boundary="===============3557645853254396493=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0576b2f2083bf535e6cc1ce06f6f4fa6d7373b39e11a416042813fad78d7e5e7@mail.kernel.org>
In-Reply-To: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-1-1bfd35a4184f@meta.com>
Subject: Re: [PATCH bpf-next v6 01/11] rhashtable: Add rhashtable_next_key() API
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 21:44:10 +0000 (UTC)

--===============3557645853254396493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece36..7bcc380ec192 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -650,6 +650,110 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
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
> +			bool match = params.obj_cmpfn
> +				     ? !params.obj_cmpfn(&arg, rht_obj(ht, he))
> +				     : !rhashtable_compare(&arg, rht_obj(ht, he));
> +			if (found) {
> +				/* Skip duplicate keys. */
> +				if (match)
> +					continue;
> +				return he;
> +			}
> +			if (match)
> +				found = true;
> +		}

Can this walk fail to make forward progress when duplicate keys are
separated by a hash collision in the same bucket?

Because rhashtable prepends new elements, a bucket can end up holding
interleaved keys, for example A2 -> B -> A1, or after a concurrent
delete and insert of key A, A_new -> B -> A_old.

Walking with prev_key = A matches the first A at the head, sets found,
and returns B. The next call with prev_key = B returns A1 (or A_old).
The following call with prev_key = A again matches the A at the head and
returns B, so the walk appears to oscillate between B and A without
advancing.

Could a caller looping over rhashtable_next_key() while holding the RCU
read lock then spin indefinitely, leading to an RCU stall? The
duplicate-skip logic above only collapses adjacent matches via the
'continue' branch and does not seem to cover the interleaved case.

This was raised against v6 (the current version) in review and does not
appear to have an author response yet:

  https://lore.kernel.org/bpf/20260602205716.BCDBE1F00893@smtp.kernel.org/

Separately, does this 'continue' path drop adjacent duplicates rather
than visiting them?

For a bucket containing A2 -> A1 -> B, prev_key = A matches A2 and sets
found = true. The loop then evaluates A1, sees match is true, and hits
'continue', so A1 is never returned and the next element handed back is
B.

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

This seems to contradict the kdoc just below, which states:

> + *   - Walks the main bucket chain only. Tables with duplicate keys
> + *     in the main chain are handled (each duplicate visited once).

The documentation says each duplicate is visited once, but the
adjacent-duplicate case above returns B and skips A1. Should the kdoc
and the code be reconciled on whether duplicates are visited or skipped?

> + */
> +static inline void *rhashtable_next_key(
> +	struct rhashtable *ht, const void *prev_key,
> +	const struct rhashtable_params params)
> +	__must_hold_shared(RCU)
> +{

One more item that looks unresolved on the list rather than a code
question:

Herbert Xu, the rhashtable maintainer, raised a concern in v2/v3 that a
rehash between iteration calls could cause iterating over the table
forever. In v4 Alexei Starovoitov pinged Herbert directly, asking "Is it
an acceptable api? I suspect you don't like it." As of v5 and v6 there
does not appear to be a review, response, or ack from Herbert on this
new public rhashtable API, and the bpf-ci bot flagged the missing
maintainer approval in both v4 and v5.

  https://lore.kernel.org/bpf/dff0e01315c753d866cb2fb94f92b5af87858ae45c90df3d861a769bc1948b03@mail.kernel.org/

Has the rhashtable maintainer signed off on the design here?

> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	if (unlikely(ht->rhlist))
> +		return ERR_PTR(-EOPNOTSUPP);
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
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26848361040
--===============3557645853254396493==--
