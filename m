Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E03AB482
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436657; cv=none; b=W1NcLvpFKOj2VCihjfZjl3rZ6bkWNXDTZ+XWZQf2nFHB0rcLfCaczVFij2dFu6xclKdHYRqXhJyhQtKaCDCSdiBizoN4qGQYr+cDfRwwkVZKzUQ3goldYxretoslHvTxAntR2/OTgGMxirmlbU6YchPk2+uIyNQbo9Eyz1tCmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436657; c=relaxed/simple;
	bh=q8jbKNFrJeBg0XDRoE69dE2HADCBjHQkJAnyLoPHpmM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kZGetms14Yi3rlbWxfOT5iF4dDJVaRRFgyWMYaivKOnEgbk5a3rOtxSzHIJV2a6WoXZ6+y109MAY+Qz4YQf3DQrtJQs1LuqhUIt0ci6uh1ivpQPFN6uiG655Rb3rue6Z81ZiYo8Zc+lOgtuSVQyiwJ6RbZ9aTUOKJFULO2Cs9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4acjl6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4acjl6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AF51F00893;
	Tue,  2 Jun 2026 21:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436656;
	bh=SCOisAr/dFSZAzd6RspuRgH8SLUdMhQB0g5lneaXxhc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m4acjl6kSOZ6eYau71JrXvM3AVVrL5UMwBxJmjE9mtpvWHBM8iPek0ESO+rlsZoc+
	 RTizUGWONTzIKc/awXxiuyewj9OjZnPMmpSkWBnO9ZoZqYMjq883q+JPp6eyDzR64J
	 0vCGitY5KcVE9m76IbS5pJ2ObH/tNkCcZJszxI6FsDwwoBHPgEynjV+tvMobwCGUny
	 fJnBbN0xF5kDpFHi8S2b2OPf7OOStv0c3VE927Gr9ahKImrrfFQ1KrtEVg7xA17ciR
	 iw+QNYdEUBKFMnfhM5RKwHoZtBYDjmSZf5FDBshs2Pm4DRpdaatNawK6tEKkREV1Zr
	 cVQkkDAj2qgNg==
Content-Type: multipart/mixed; boundary="===============7425385486865926620=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
In-Reply-To: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
Subject: Re: [PATCH bpf-next v6 03/11] bpf: Implement resizable hashmap basic functions
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 21:44:15 +0000 (UTC)

--===============7425385486865926620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..10f3a058747b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2739,3 +2740,313 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
>  	.map_btf_id = &htab_map_btf_ids[0],
>  };
> +
> +struct rhtab_elem {
> +	struct rhash_head node;
> +	/* key bytes, then value bytes follow */
> +	u8 data[] __aligned(8);
> +};
> +
> +struct bpf_rhtab {
> +	struct bpf_map map;
> +	struct rhashtable ht;
> +	struct bpf_mem_alloc ma;
> +	u32 elem_size;
> +};
> +
> +static const struct rhashtable_params rhtab_params = {
> +	.head_offset = offsetof(struct rhtab_elem, node),
> +	.key_offset  = offsetof(struct rhtab_elem, data),
> +};

[ ... ]

> +static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
> +{
> +	struct rhashtable_params params;
> +	struct bpf_rhtab *rhtab;
> +	int err = 0;
> +
> +	rhtab = bpf_map_area_alloc(sizeof(*rhtab), NUMA_NO_NODE);
> +	if (!rhtab)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bpf_map_init_from_attr(&rhtab->map, attr);
> +
> +	if (rhtab->map.max_entries > 1UL << 31) {
> +		err = -E2BIG;
> +		goto free_rhtab;
> +	}
> +
> +	rhtab->elem_size = sizeof(struct rhtab_elem) + round_up(rhtab->map.key_size, 8) +
> +			   round_up(rhtab->map.value_size, 8);
> +
> +	params = rhtab_params;
> +	params.key_len = rhtab->map.key_size;
> +	params.nelem_hint = (u32)attr->map_extra;
> +	params.automatic_shrinking = true;

Setting automatic_shrinking = true causes rhashtable to invoke
schedule_work() when the table crosses certain occupancy thresholds
(30% during deletions, 75% during insertions).

If a BPF program runs in NMI context (for example, from a perf event or
raw tracepoint), and triggers a map operation that crosses these thresholds,
won't schedule_work() be called from NMI context?

Looking at the workqueue code:

kernel/workqueue.c:__queue_work() {
    ...
    if (WARN_ON_ONCE(in_nmi()))
        return;
    ...
}

This would trigger the warning and prevent the work from being queued,
potentially breaking the map's resizing mechanism. The deadlock concern is
even more serious - workqueue pool locks taken from NMI context could
deadlock against the same locks taken in process context.

The bpf_disable_instrumentation() calls protect against instrumentation-
based recursion but don't prevent the automatic shrinking work scheduling.
Raw tracepoints can execute in NMI context and bypass the bpf_prog_active
recursion checks.

Could this be addressed by either:
1) Setting automatic_shrinking = false
2) Adding an in_nmi() check before map operations that would error out with
   -EBUSY, or
3) Using a custom shrinking callback that checks context before scheduling?

This concern was raised in a previous review iteration (v6, June 2):

https://lore.kernel.org/bpf/20260602210718.AED5C1F00893@smtp.kernel.org/

> +
> +	err = rhashtable_init(&rhtab->ht, &params);
> +	if (err)
> +		goto free_rhtab;
> +
> +	/* Set max_elems after rhashtable_init() since init zeroes the struct */
> +	rhtab->ht.max_elems = rhtab->map.max_entries;
> +
> +	err = bpf_mem_alloc_init(&rhtab->ma, rhtab->elem_size, false);
> +	if (err)
> +		goto destroy_rhtab;
> +
> +	return &rhtab->map;
> +
> +destroy_rhtab:
> +	rhashtable_destroy(&rhtab->ht);
> +free_rhtab:
> +	bpf_map_area_free(rhtab);
> +	return ERR_PTR(err);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26848361040
--===============7425385486865926620==--
