Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6802135C181
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038030; cv=none; b=O99A8I/wGtifE+EbRaWu2KT3KOCEryrm1ZQdDq4OKNcVfbcDezhvH4O/zkIjs5qRtoXEeZLCjHU0775IwLMrgE9h56zOGie1yinMj1MxpKPtnH55iELhpC96W2dkZvvPJgQOWOXOjc76giQQobrh+QjFZmhKyOPB6QjqoqZYD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038030; c=relaxed/simple;
	bh=+SRuM85831/PXhm1hZOO6Mg/9e8NBEVhposo32GwxOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uexptvkHp8Jl0AZlDmZWdkFYuuev1kDeZfGOr7lX57vwklPDccnu6k8u9n1dG+w+Dt9NYXjE8gBCt/pAhe42m+Ayl/FkGLfyDIBod40XM229i+WosNbK0VnuMVspqmLhh1QWi1KyhEWHcN4VV2znChiqKIDSFAI+eaSEcSte8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rKZiwJSX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKZiwJSX"
Message-ID: <8f97dbb5-de94-4ac0-8b3c-e0ce890fffc3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773038016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNjq9OVMQ19n1uQjgdtdpJMa6SfrLwmBjiIgVYkqJoc=;
	b=rKZiwJSX42aiS6fua1F44LKsc/dseamHL85FtfwXZ3PuTPltCFIf8kn0I9A4D2F8L8mWys
	aNMtQAB/p4PliaFgZ5U6KBGsUVV2Trny2BhvZWd1z7rVX9yej9cp43eUWGPKBre8bXyfo9
	IPBCrScYIsO5yD1FyteVkyZ/7NvgSWU=
Date: Mon, 9 Mar 2026 14:33:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Introduce the bpf_list_del kfunc.
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-2-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260308134614.29711-2-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 21:46, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> If a user holds ownership of a node in the middle of a list, they
> can directly remove it from the list without strictly adhering to
> deletion rules from the head or tail.
> 
> We have added an additional parameter bpf_list_head *head to
> bpf_list_del, as the verifier requires the head parameter to
> check whether the lock is being held.
> 
> This is typically paired with bpf_refcount. After calling
> bpf_list_del, it is generally necessary to drop the reference to
> the list node twice to prevent reference count leaks.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 30 +++++++++++++++++++++++-------
>  kernel/bpf/verifier.c |  6 +++++-
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..01b74c4ac00d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2426,20 +2426,23 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
>  }
>  
> -static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
> +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
> +					    struct list_head *n)
>  {
> -	struct list_head *n, *h = (void *)head;
> +	struct list_head *h = (void *)head;
>  	struct bpf_list_node_kern *node;
>  
>  	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
>  	 * called on its fields, so init here
>  	 */
> -	if (unlikely(!h->next))
> +	if (unlikely(!h->next)) {
>  		INIT_LIST_HEAD(h);
> -	if (list_empty(h))
> +		return NULL;
> +	}
> +
> +	if (n == h)
>  		return NULL;
>  
> -	n = tail ? h->prev : h->next;
>  	node = container_of(n, struct bpf_list_node_kern, list_head);
>  	if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
>  		return NULL;

This refactoring is worth, because the "struct list_head *n" seems
better than "bool tail".

But, such refactoring should be a preparatory patch. Importantly,
refactoring should not introduce functional changes.

Thanks,
Leon

> @@ -2451,12 +2454,24 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
>  
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>  {
> -	return __bpf_list_del(head, false);
> +	struct list_head *h = (void *)head;
> +
> +	return __bpf_list_del(head, h->next);
>  }
>  
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>  {
> -	return __bpf_list_del(head, true);
> +	struct list_head *h = (void *)head;
> +
> +	return __bpf_list_del(head, h->prev);
> +}
> +
> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> +					       struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *kn = (void *)node;
> +
> +	return __bpf_list_del(head, &kn->list_head);
>  }
>  
>  __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
> @@ -4545,6 +4560,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 67c09b43a497..c9557d3fb8dd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12461,6 +12461,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_push_back_impl,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  	KF_bpf_cast_to_kern_ctx,
> @@ -12521,6 +12522,7 @@ BTF_ID(func, bpf_list_push_front_impl)
>  BTF_ID(func, bpf_list_push_back_impl)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
> +BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
> @@ -12996,6 +12998,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_back];
>  }
> @@ -13118,7 +13121,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||

