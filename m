Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78333D501
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063545; cv=none; b=ZJW3yVUiE4A0gMaBeuNP2AZbM76cFwrsaPnC5NuaxFW/V/l2y3HHi1ux7mP1WSJlkfqGlMrjdNe879+QifL0XV+LjaO4Pr3Un1VHTIkpN7QRlQ3ocJvQ3gDo+5Bl+IMKSXtbu0qcaFY0UAibVxMoJU5t7PEv1X6DymUazYL6RYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063545; c=relaxed/simple;
	bh=BgfRE1EzM89l5kQIH4JznjmB50FqpjBWsAzeWprlsXU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E9U9Zf84mHYzpjeGnD2VAtC9JNWWM1spwflu5E0T4lCoez9aLcxIxCPtBt4TJLzs+jzWnwc6HRD5ox9FYW7cHRpJTiQ9z/G22s/q5b0eJ3z7ODMMmWDl4g8+jePr+nWpSqpRocJJ5hA0dnYLPbZoFUbf5fD6cvUDKWTumS5nCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2lnw/Q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2lnw/Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0ACC19425;
	Fri, 24 Apr 2026 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063544;
	bh=BgfRE1EzM89l5kQIH4JznjmB50FqpjBWsAzeWprlsXU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Y2lnw/Q7urN8RPvYCswYSqSSurW6WGYvbUpIB6QQJrgocqX0XJQV13xjzkgMbwPTy
	 iKRtSZGPW4z0uWK6xQhbjIcKFYjhw5YhaIVujKvkdJERYaQoauMqRRlTyAIiyLQJhG
	 rJQOTQ/7qiRW95eBEJkfjfo1dDConxozpfdvLDGxOauPLFgTfWp8slzoiMoUzVBxt9
	 UNoiYeTqGg1APSXBoOg0I7YIHMoXLGc+xTRuCIQFaPRW/00PJ//YC1HERDL1L6ppy9
	 GlvCfUDUrSSvhkC0wYGyFHyQ0HBt9hu25DKzSjEaMHtuV4dDA0G3mOGCh/0IQKJ7tO
	 of5B4wmD5XDkg==
Content-Type: multipart/mixed; boundary="===============7580031636570356645=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18e1b5a723d1f81938bb6d2676246a514df7929f58161bfec9db308c85230aa4@mail.kernel.org>
In-Reply-To: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add rhashtable_walk_enter_from()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 20:45:44 +0000 (UTC)

--===============7580031636570356645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -693,6 +693,47 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
>  EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
>
>  /**
> + * rhashtable_walk_enter_from - Initialise a walk starting at a key's bucket
> + * @ht:		Table to walk over
> + * @iter:	Hash table iterator
> + * @key:	Key whose bucket to start from
> + * @params:	Hash table parameters
> + *
> + * Like rhashtable_walk_enter(), but positions the iterator at the bucket
> + * containing @key.  If @key is not present in the main table, the iterator is
> + * positioned at the beginning.
> + *
> + * Same constraints as rhashtable_walk_enter() apply.
> + */
> +void rhashtable_walk_enter_from(struct rhashtable *ht,
> +				struct rhashtable_iter *iter,
> +				const void *key,
> +				const struct rhashtable_params params)
> +				__must_hold(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	rhashtable_walk_enter(ht, iter);
> +
> +	if (!key)
> +		return;
> +
> +	tbl = iter->walker.tbl;
> +	if (!tbl)
> +		return;
> +
> +	he = __rhashtable_lookup_one(ht, tbl, key, params,
> +				     RHT_LOOKUP_NORMAL);
> +	if (!he)
> +		return;

What happens if the table is currently resizing and the key has already
been moved to the future table?

When __rhashtable_lookup_one() fails to find the key in the current
table, the function returns early, leaving the iterator positioned at
bucket 0.

For stateless iterators like BPF's get_next_key, could this cause an
infinite loop where it constantly resets to the beginning of the old
table until the resize completes?

The v2 implementation had code to check future_tbl when the key was not
found in the main table, but this was removed in v3.

Reference: https://lore.kernel.org/all/20260424201535.EA1BCC19425@smtp.kernel.org/

> +
> +	iter->slot = rht_key_hashfn(ht, tbl, key, params);
> +	iter->p = he;

Does this leave iter->list uninitialized for rhlist tables?

rhashtable_walk_enter() does not initialize iter->list. When
rhashtable_walk_start_check() is later called for an rhlist table, it
validates the element using:

lib/rhashtable.c:rhashtable_walk_start_check() {
    ...
} else if (iter->p && rhlist) {
    ...
    if (list == iter->list) {
        iter->p = p;
        iter->skip = skip;
        goto found;
    }
    ...
}

Will this uninitialized read of iter->list cause the validation to fail
and silently fall back to the beginning of the bucket?

Reference: https://lore.kernel.org/all/20260424201535.EA1BCC19425@smtp.kernel.org/

> +}
> +EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);

[ ... ]

> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c

[ ... ]

> @@ -679,6 +680,133 @@
>  	return err;
>  }
>
> +static int __init test_walk_enter_from(void)
> +{
> +	struct rhashtable ht;
> +	struct test_obj objs[4];
> +	struct rhashtable_iter iter;
> +	struct test_obj *obj;
> +	struct test_obj_val key = { };
> +	int err, i, count;
> +	int len_freq[4] = { 0, 0, 0, 0 };
> +
> +	err = rhashtable_init(&ht, &test_rht_params);
> +	if (err)
> +		return err;
> +
> +	/* Insert 4 elements with keys 0, 2, 4, 6 */
> +	for (i = 0; i < 4; i++) {
> +		objs[i].value.id = i * 2;
> +		objs[i].value.tid = 0;
> +		err = rhashtable_insert_fast(&ht, &objs[i].node,
> +					     test_rht_params);
> +		if (err) {
> +			pr_warn("walk_enter_from: insert %d failed: %d\n",
> +				i, err);
> +			goto out;
> +		}
> +	}

[ ... ]

> +	/* Test 3: verify walk_enter_from + walk_next can iterate remaining elements */
> +	for (i = 0; i < 4; i++) {
> +		key.id = i * 2;
> +		count = 0;
> +
> +		scoped_guard(rcu) {
> +			rhashtable_walk_enter_from(&ht, &iter, &key, test_rht_params);
> +			rhashtable_walk_start(&iter);
> +		}
> +
> +		/* Count the number of elements after this one */
> +		do {
> +			obj = rhashtable_walk_next(&iter);
> +			count++;
> +		} while (obj && (!IS_ERR(obj) || (PTR_ERR(obj) == -EAGAIN)));
> +
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +		if (count > 4) {
> +			pr_warn("walk_enter_from: walked %d elements instead of max 4\n", count);
> +			goto out;

Does this error path need to set the err variable?

Right now it jumps to out and returns 0, which might cause the test
suite to silently miss the failure. The err variable should be set to
-EINVAL before the goto.

Reference: https://lore.kernel.org/all/20260424201535.EA1BCC19425@smtp.kernel.org/

> +		}
> +		/*
> +		 * Collect the lengths of every walked path,
> +		 * we should have each length walked one time
> +		 */
> +		len_freq[count - 1]++;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24909591959
--===============7580031636570356645==--
