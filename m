Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDE35A39F
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663213; cv=none; b=f/yU0GrfHq5rI+NWzJEJdkhgCgmZOf8iV9vAsry93gn7ooH/cVOekpGuQBgPPQd0JB+1LMj4a5RAKfQlzHO66IHzprsodkXAONu3byOXBzMqWddcd7aRFI1bAuFTC+tYZwIDAVFrhtz9t1eJV2atCPWjNKJFbBuMiFZmUMf8w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663213; c=relaxed/simple;
	bh=T/tOGzkzhhn6p+uG/Jr65mulWzItficsu5KvA8R57cM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OchKwbqmcumtubJLMKkp4FmVMlxwK+L6yW7MK/HGPvi2375e0a0760s9QBFHIYKOF1naKbzuXSAM6uOsq9NLQU/yHIejHmZOBKZeOdZ1JRYIEClw54iJm4hLLfj/csb0L7byCwfAnguKJxeDgQpYrucgRFr06rbOW3VjtWbCoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBjqnu1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBjqnu1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124871F00893;
	Fri,  5 Jun 2026 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663212;
	bh=JEJB4afI6DhxDbR5CwBCnT3AAeGZeuODJoAByRUg+jI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aBjqnu1paEdfCRnSlVCKnGDxY45GRGMxDbg8B0OW0zasxavjErOm9gN+hdozC+5yX
	 9YtEHQRevncuMV19BilZhT185YmU6IQnRnrcSXbEOrNKJ+igBcssw2qThlTfcx9YIi
	 Z27JQLqSCrq3hx0IGYZpd1+aKG3dpXewf2oK0zS5DuT/Z4MugAwOT+aVTUrLNdsUOB
	 f7yuu/dv/sbAuX6ju6KDs30gy1z2BZ5zOlovMIpkxJ6UEVKWiW6SrzdfEo6dt5pUIH
	 B56f7EhQ2c1HtinFW9si9HRAtrBoDkZzVjwcFDN9S/aEsxcZRVPe8OCkFe9wjzDiDn
	 LbzclopVt1Kfw==
Content-Type: multipart/mixed; boundary="===============3520698004461516831=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e564e01c7b39f2b6196dfd4aa52dc00ae3db255a71f31f2955cd9b0c59a91de5@mail.kernel.org>
In-Reply-To: <20260605-rhash-v7-5-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-5-5b8e05f8630d@meta.com>
Subject: Re: [PATCH bpf-next v7 05/12] bpf: Implement iteration ops for resizable hashtab
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 12:40:12 +0000 (UTC)

--===============3520698004461516831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 10f3a058747b..a149713d0953 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3020,8 +3020,79 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)

[ ... ]

> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
> +				void *callback_ctx, u64 flags)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	void *prev_key = NULL;
> +	struct rhtab_elem *elem;
> +	int num_elems = 0;
> +	u64 ret = 0;
> +
> +	cant_migrate();
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	/*
> +	 * Best-effort iteration: if rhashtable is concurrently resized or
> +	 * elements are deleted/inserted, there may be missed or duplicate
> +	 * elements visited.
> +	 */
> +	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key))) {

The rhashtable_next_key() documentation notes that a full iteration is
not guaranteed to terminate under adversarial or sustained rehashing.

This loop has no external bound and runs under rcu_read_lock() with
migration disabled.  Can continuous concurrent resizes keep this loop
from terminating, leading to a soft lockup or RCU stall?

> +		if (IS_ERR(elem))
> +			break;

If prev_key is deleted concurrently, or by the callback itself,
rhashtable_next_key() returns ERR_PTR(-ENOENT) and this break exits the
loop.  Does that abort the iteration immediately and skip the remaining
elements?

rhtab_map_get_next_key() handles the same -ENOENT case by falling back
to the first key:

	/* if not found, return the first key */
	if (PTR_ERR(elem) == -ENOENT)
		elem = rhashtable_next_key(&rhtab->ht, NULL);

Should bpf_each_rhash_elem() do something similar rather than breaking,
given the comment describes this as best-effort iteration?

> +		num_elems++;
> +		ret = callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);
> +		if (ret)
> +			break;
> +
> +		prev_key = elem->data;	/* valid while RCU held */
> +	}
> +	rcu_read_unlock();
> +
> +	return num_elems;
> }
>
> static u64 rhtab_map_mem_usage(const struct bpf_map *map)
> @@ -3034,6 +3105,275 @@ static u64 rhtab_map_mem_usage(const struct bpf_map *map)

[ ... ]

> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{

[ ... ]

> +	while (elem && !IS_ERR(elem) && total < max_count) {
> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);
> +
> +		if (do_delete)
> +			del_elems[total] = elem;
> +
> +		elem = rhashtable_next_key(&rhtab->ht, dst_key);
> +		dst_key += key_size;
> +		dst_val += value_size;
> +		total++;
> +
> +		/* Bail to userspace to avoid stalls. */
> +		if (need_resched())
> +			break;
> +	}

[ ... ]

> +	if (do_delete) {
> +		for (i = 0; i < total; i++)
> +			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +	}

Deferring the deletion until after the iteration leaves the elements
visible in the hash table while they are copied into the user buffers.

Does this open a window where a concurrent batch operation can
traverse, copy, and return the same elements to userspace?

If so, does that break the exactly-once consumption semantics expected
when a batch is used to drain a map like a work queue?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27013077824
--===============3520698004461516831==--
