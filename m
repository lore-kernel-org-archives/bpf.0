Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3230B53C
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063546; cv=none; b=DtDWiHzowPIoXq5LyaKcrMNwyvZpWN6P3HfBMc8iQyeJCGSvw7BEObbidCIO5IL1KqVAKBuWIuwubcHxX9p2qAaVSNRrYq9P1iQUtzJF3YtbtkdirlBFLBEt93mYPZ5BORCWkfAlZau193uckRsTW0pC/OAdXkQPv916nMqDAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063546; c=relaxed/simple;
	bh=8KrujyeuGHnZJ87Ec7xMmmBC03h74UsCsBdFeK8syFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mKd1R7x9Gmlsg72HK0BXdV/bmVUiQP8PFB9SumJS75BtdpcdGwyXu3Aji7ikwGkhRj1qVk1FMgN1K9epVP2vajzH7xaUHah+4HUPTvYJ1HH6JFnXFIw2flnd3jBVUs0c9UxXA3odCYGq8qs5Ap38K3PBxcoV/iFGDlcVe5edOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5gNVYZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5gNVYZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA6C19425;
	Fri, 24 Apr 2026 20:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063546;
	bh=8KrujyeuGHnZJ87Ec7xMmmBC03h74UsCsBdFeK8syFs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=H5gNVYZlZN2p8/dVz76kX+lWSgCr3l7ENQJYiWzqZX/7OGkUUvATzSGRn4g6PdDbi
	 tnyIZYKQ8pkcp4f2NR5ZAYnKTzwE1EkDLf71jeCiPTVvzHh8/WZOdZU0510ITc0mdt
	 B2cTSD5TclGDsH2CT5dRRdO6mT1wgbkeXl1wiw27wj68u80uxiAd7BUBsSirWvw/XB
	 HDXZzOhvmrCUsEIUH59zD7KZH13XS24a2dht4+r5I7nljNj4GdWgWKye04FVSYhIGU
	 Wf15sf0f8a1qCeeELQu+D05VLzMMOxhiapqkyft92/nVkPbJl342eYKuDm+XsHewWJ
	 eVEKPxz11qAqQ==
Content-Type: multipart/mixed; boundary="===============7764502755757521332=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8168a9eb342bfdbe138aa31e7c07ea811e9ad4c413e15f5575a4874d2f4dca9e@mail.kernel.org>
In-Reply-To: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Implement resizable hashmap basic functions
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 20:45:46 +0000 (UTC)

--===============7764502755757521332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..a37bd2a7b30f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
> +			       const struct btf_type *key_type,
> +			       const struct btf_type *value_type)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +
> +	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
> +}

Does bpf_ma_set_dtor() exist at this commit?

A git-wide search shows no definition or declaration of bpf_ma_set_dtor().
The kernel provides bpf_mem_alloc_set_dtor() with a 4-argument signature
(ma, dtor, dtor_ctx_free, ctx) in include/linux/bpf_mem_alloc.h:

    int bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma, dtor_fn dtor,
                               dtor_ctx_fn dtor_ctx_free, void *ctx);

The existing htab_set_dtor() in kernel/bpf/hashtab.c builds a struct
htab_btf_record context and calls bpf_mem_alloc_set_dtor() with all four
arguments.

The new rhtab_map_check_btf() attempts to call a not-yet-existing helper
with a 3-argument signature. This breaks compilation with 'implicit
declaration of function "bpf_ma_set_dtor"' (fatal with kernel's
-Werror=implicit-function-declaration) or link failure with 'undefined
reference to bpf_ma_set_dtor'.

Looking at the later commit b3eef0fdafe1 ("bpf: Allow timers, workqueues
and task_work in resizable hashtab"), it renames htab_set_dtor() to
bpf_ma_set_dtor() and changes its signature to (map, ma, dtor), providing
the missing symbol. That commit also wires up .map_check_btf =
rhtab_map_check_btf in rhtab_map_ops.

Can this commit be reordered or squashed to avoid the forward reference
and maintain bisectability?

> +static void rhtab_free_elem(void *ptr, void *arg)
> +{
> +	struct bpf_rhtab *rhtab = arg;
> +	struct rhtab_elem *elem = ptr;
> +
> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> +}

[ ... ]

> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
> +{
> +	int err;
> +
> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
> +	if (err)
> +		return err;
> +
> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> +	return 0;
> +}

Does rhtab_delete_elem() handle special fields properly?

Looking at the v2 review thread
(https://lore.kernel.org/bpf/DHSBDLRKCAQO.1IPJTSEMPESV7@etsalapatis.com/),
Emil Tsalapatis and sashiko raised concerns that special fields are not
handled properly during in-place updates. The v3 changelog claims this was
addressed, but rhtab_delete_elem() does not call
bpf_map_free_internal_structs() before freeing the element.

This is inconsistent with rhtab_free_elem() which properly calls
bpf_map_free_internal_structs(). Could this lead to resource leaks for
maps with timers, workqueues, or other internal structures when elements
are deleted via rhtab_map_delete_elem()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24909591959
--===============7764502755757521332==--
