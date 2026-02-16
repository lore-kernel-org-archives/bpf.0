Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46712D5410
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264632; cv=none; b=adKl39BBAzk2yHmwcjRvabfO+7s/5EBW2d4EHR1y+bw+Wx4VEwU7keHi7dO1uU+CKPB6I3MfzKUvd1cqGiJMS1TIYrWiZw4kFnWt8y4XVaVdhp2VHvwpzltJWa8afUdrxi1h+tHcGh0/ecaHyj+bFH/MIGfqcd0T0ZrLKdjyXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264632; c=relaxed/simple;
	bh=XCROsQqiNbC2nUl93T/xaFwI09c9tlT59P17nlSirYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVLB3RhfXSQgBrimb/dds7o4UOJPcqVod5wDb485gVSHbu7L09E3NWnLfI4H2+pLF3LSm/bnc0fV6LdkwlNDE2hmUTEEBJzUvL7aCsCC/ICTtovzQcBii0CS01TasxnuNsBL7om7XqutWgENUu/Vkm07bGh3QiTU2o3PNmfCKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9kHfspI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9kHfspI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8196C19422;
	Mon, 16 Feb 2026 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771264632;
	bh=XCROsQqiNbC2nUl93T/xaFwI09c9tlT59P17nlSirYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t9kHfspIjgoepmCsgRHZ4Neb1a43zI+IrSa91yLwNE9vCxtT/FOzSoc60KjkvOxwF
	 FPw0S7n9wsxC0MV2RDF8rEc2KwaGPGaFwo6JG0e0kI4n5AaJkFSxczFvQF96NqAY2L
	 XgrUU5hLR/zXArazfKteVDqnqFfpB1bO9p0OyFclBT8Ign7O2U2Vg/nNN4brXKhDg5
	 GBKZqGDY288V3yyuqD3ztzhPOF/2WsC/JIncGOFXbqsvahJZM5wqqE3/WTH9PrXMll
	 M5RUM9/XPnEaz44XAFoTjXBMyP7W99EKtonZtI1brQWWu7KXGE/GeZ1fv/nyv/lKGN
	 m2JOzA3T5NKog==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix special fields mem leak for
 non-prealloc maps
In-Reply-To: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>
References: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Feb 2026 17:56:57 +0000
Message-ID: <m2wm0cbmhi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> cancel_and_free() uses xchg(&ptr, NULL) to steal the cb/ctx pointer.
> For non-preallocated maps, the element is freed via bpf_mem_cache_free()
> making it immediately available for reuse. Between the xchg and the
> free, a concurrent BPF program sees NULL, treats it as first use,
> allocates a new cb/ctx, and stores it via cmpxchg. The allocation is
> then orphaned when the element is freed, causing a memory leak.
>
> Use BPF_PTR_POISON instead of NULL in the xchg so that concurrent
> readers can distinguish "being destroyed" from "never initialized"
> and refuse to allocate. For preallocated maps, clear the poison
> before recycled elements are handed back to BPF programs.
>
> Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h   | 30 ++++++++++++++++++++++++++++++
>  kernel/bpf/arraymap.c |  4 ++--
>  kernel/bpf/hashtab.c  |  5 +++++
>  kernel/bpf/helpers.c  | 25 +++++++++++++------------
>  4 files changed, 50 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd9b96434904..90006a910dd6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -671,6 +671,36 @@ static inline bool bpf_map_has_internal_structs(struct bpf_map *map)
>  
>  void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
>  
> +/*
> + * Clear special fields (timer/wq/task_work) poisoned by cancel_and_free()
> + * in recycled map elements.
> + *
> + * Uses WRITE_ONCE to match the READ_ONCE/xchg/cmpxchg used by concurrent
> + * readers on the underlying pointer (bpf_async_kern.cb / bpf_task_work_kern.ctx).
> + */
> +static inline void bpf_obj_init_special_fields(const struct btf_record *rec, void *obj)
> +{
> +	void **p;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	if (rec->timer_off >= 0) {
> +		p = obj + rec->timer_off;
> +		WRITE_ONCE(*p, NULL);
> +	}
> +
> +	if (rec->wq_off >= 0) {
> +		p = obj + rec->wq_off;
> +		WRITE_ONCE(*p, NULL);
> +	}
> +
> +	if (rec->task_work_off >= 0) {
> +		p = obj + rec->task_work_off;
> +		WRITE_ONCE(*p, NULL);
> +	}
> +}
> +
>  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>  				   struct bpf_dynptr *ptr__uninit);
>  
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 67e9e811de3a..0ef68e5c4c90 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -386,7 +386,6 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>  		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  		copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
>  	} else {
>  		val = array->value +
>  			(u64)array->elem_size * (index & array->index_mask);
> @@ -394,8 +393,9 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
>  			copy_map_value_locked(map, val, value, false);
>  		else
>  			copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
>  	}
> +	bpf_obj_free_fields(array->map.record, val);
> +	bpf_obj_init_special_fields(array->map.record, val);
>  	return 0;
>  }
>  
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3b9d297a53be..7e93ece61296 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -300,6 +300,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
>  		bpf_map_inc_elem_count(&htab->map);
>  		l = container_of(node, struct htab_elem, lru_node);
>  		memcpy(l->key, key, htab->map.key_size);
> +		bpf_obj_init_special_fields(htab->map.record,
> +					    htab_elem_value(l, htab->map.key_size));
>  		return l;
>  	}
>  
> @@ -1033,6 +1035,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  	}
>  
>  	memcpy(l_new->key, key, key_size);
> +	/* Clear special fields poisoned by cancel_and_free() in recycled elements */
> +	bpf_obj_init_special_fields(htab->map.record, htab_elem_value(l_new, key_size));
> +
>  	if (percpu) {
>  		if (prealloc) {
>  			pptr = htab_elem_get_ptr(l_new, key_size);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 7ac32798eb04..4e95bc085578 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1477,7 +1477,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
>  	struct bpf_async_cb *cb;
>  
>  	cb = READ_ONCE(async->cb);
> -	if (!cb)
> +	if (!cb || cb == BPF_PTR_POISON)
>  		return -EINVAL;
>  
>  	return bpf_async_update_prog_callback(cb, prog, callback_fn);
> @@ -1511,7 +1511,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, fla
>  		return -EINVAL;
>  
>  	t = READ_ONCE(async->timer);
> -	if (!t || !READ_ONCE(t->cb.prog))
> +	if (!t || (void *)t == BPF_PTR_POISON || !READ_ONCE(t->cb.prog))
>  		return -EINVAL;
>  
>  	if (flags & BPF_F_TIMER_ABS)
> @@ -1557,7 +1557,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
>  		return -EOPNOTSUPP;
>  
>  	t = READ_ONCE(async->timer);
> -	if (!t)
> +	if (!t || (void *)t == BPF_PTR_POISON)
>  		return -EINVAL;
>  
>  	cur_t = this_cpu_read(hrtimer_running);
> @@ -1669,11 +1669,8 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
>  {
>  	struct bpf_async_cb *cb;
>  
> -	if (!READ_ONCE(async->cb))
> -		return;

This check can be left so that we don't do xchg() if async->cb is NULL

> -	cb = xchg(&async->cb, NULL);
> -	if (!cb)
> +	cb = xchg(&async->cb, BPF_PTR_POISON);
> +	if (!cb || cb == BPF_PTR_POISON)
>  		return;
>  
>  	bpf_async_update_prog_callback(cb, NULL, NULL);
> @@ -3183,7 +3180,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
>  		return -EINVAL;
>  
>  	w = READ_ONCE(async->work);
> -	if (!w || !READ_ONCE(w->cb.prog))
> +	if (!w || (void *)w == BPF_PTR_POISON || !READ_ONCE(w->cb.prog))
>  		return -EINVAL;
>  
>  	if (!refcount_inc_not_zero(&w->cb.refcnt))
> @@ -4267,6 +4264,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
>  	struct bpf_task_work_ctx *ctx, *old_ctx;
>  
>  	ctx = READ_ONCE(twk->ctx);
> +	if (ctx == BPF_PTR_POISON)
> +		return ERR_PTR(-EINVAL);
>  	if (ctx)
>  		return ctx;
>  
> @@ -4285,6 +4284,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
>  		 * memory and try to reuse already set context.
>  		 */
>  		bpf_mem_free(&bpf_global_ma, ctx);
> +		if (old_ctx == BPF_PTR_POISON)
> +			return ERR_PTR(-EINVAL);
>  		return old_ctx;
>  	}
>  
> @@ -4476,7 +4477,7 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
>  	int ret;
>  
>  	cb = READ_ONCE(async->cb);
> -	if (!cb)
> +	if (!cb || cb == BPF_PTR_POISON)
>  		return -EINVAL;
>  
>  	/*
> @@ -4517,8 +4518,8 @@ void bpf_task_work_cancel_and_free(void *val)
>  	struct bpf_task_work_ctx *ctx;
>  	enum bpf_task_work_state state;
>  
> -	ctx = xchg(&twk->ctx, NULL);
> -	if (!ctx)
> +	ctx = xchg(&twk->ctx, BPF_PTR_POISON);
> +	if (!ctx || ctx == BPF_PTR_POISON)

Should we create a helper macro for the repeated !ptr || (void *)ptr ==
BPF_PTR_POISON pattern

>  		return;
>  
>  	state = xchg(&ctx->state, BPF_TW_FREED);
> -- 
> 2.53.0
