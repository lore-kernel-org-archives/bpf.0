Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EF26D4CA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038066; cv=none; b=ehQrjVw95cVWEvwz9QSYoXIakOhfC7jQrSeS+cB2V/tSTkiSsqVZHn0I/iCKdi9Wm43l8Nc9T43aPLYq45vCiDfCvc8Mk55ZjmC4qYPPkm4E6WyqfJ3vH0eCxq5t//U9OPfIL7QRYkOfts29ltcW66qCUTI4suvY0eSqSmNIgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038066; c=relaxed/simple;
	bh=YlrpL0fO/7GISjyAsbJjQDNQafXT5EqPTrdkxOERr9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNOPH2yyiY0FM2Vm6S4Q2XMZh03iqByJEsIChM59Nh9wysxS4s1AVBf8NH01Qyy9NGdTxJP6vrguCMh2Cvv9buDHuAS6DevYjFPJZZ3Fe4muqlxgzso24B8putNeGrhufBwzJfDI5WFuIumiaecf/E5MhInQMg5udsWBqp9r3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFbq8ghD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFbq8ghD"
Message-ID: <e7d7076a-5a1a-40b3-bff1-4f5de7c6b9ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773038063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVYuGex5GhS6X5XqyVI/Awi8X36At9y4ChFrGeytdUI=;
	b=WFbq8ghDai/FKnMOgiE4mNeQ1A4hL1olHksQnJz3xuEve9xiggtFi9p+l9EhmpVKBolGd4
	YAEXvXmS/OkMBcoUMsHp2H/ReZb3UqqZgHWOCWBYFHsGR/gd238M/Ll4f5ojO0Y8xU/raq
	5e+QrUz1LR8AgVqc6fJnACDBCLgQtM0=
Date: Mon, 9 Mar 2026 14:34:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/5] bpf: Add bpf_list_add_impl to insert node
 after a given list node
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-3-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260308134614.29711-3-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 21:46, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Add a new kfunc bpf_list_add_impl(head, new, prev, meta, off) that
> inserts 'new' after 'prev' in the BPF linked list. Both must be in
> the same list; 'prev' must already be in the list. The new node must
> be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
> that reference and the node becomes non-owning once inserted.
> 
> We have added an additional parameter bpf_list_head *head to
> bpf_list_add_impl, as the verifier requires the head parameter to
> check whether the lock is being held.
> 
> Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
> is already in a list (or duplicate insertion). On failure, the
> kernel drops the passed-in node.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 56 ++++++++++++++++++++++++++++++-------------
>  kernel/bpf/verifier.c | 13 ++++++++--
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 01b74c4ac00d..407520fde668 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2379,11 +2379,12 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
>  	return (void *)p__refcounted_kptr;
>  }
>  
> -static int __bpf_list_add(struct bpf_list_node_kern *node,
> -			  struct bpf_list_head *head,
> -			  bool tail, struct btf_record *rec, u64 off)
> +static int __bpf_list_add(struct bpf_list_head *head,
> +			  struct bpf_list_node_kern *new,
> +			  struct list_head *prev,
> +			  struct btf_record *rec, u64 off)
>  {
> -	struct list_head *n = &node->list_head, *h = (void *)head;
> +	struct list_head *n = &new->list_head, *h = (void *)head;
>  
>  	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
>  	 * called on its fields, so init here
> @@ -2391,39 +2392,59 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
>  	if (unlikely(!h->next))
>  		INIT_LIST_HEAD(h);
>  
> -	/* node->owner != NULL implies !list_empty(n), no need to separately
> +	/* When prev is not the list head, it must be a node in this list. */
> +	if (prev != h && WARN_ON_ONCE(READ_ONCE(container_of(
> +	    prev, struct bpf_list_node_kern, list_head)->owner) != head))
> +		goto fail;
> +
> +	/* new->owner != NULL implies !list_empty(n), no need to separately
>  	 * check the latter
>  	 */
> -	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
> -		/* Only called from BPF prog, no need to migrate_disable */
> -		__bpf_obj_drop_impl((void *)n - off, rec, false);
> -		return -EINVAL;
> -	}
> -
> -	tail ? list_add_tail(n, h) : list_add(n, h);
> -	WRITE_ONCE(node->owner, head);
> +	if (cmpxchg(&new->owner, NULL, BPF_PTR_POISON))
> +		goto fail;
>  
> +	list_add(n, prev);
> +	WRITE_ONCE(new->owner, head);
>  	return 0;
> +
> +fail:
> +	/* Only called from BPF prog, no need to migrate_disable */
> +	__bpf_obj_drop_impl((void *)n - off, rec, false);
> +	return -EINVAL;
>  }
>  

This refactoring is worth. But it should be a preparatory patch.

>  __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>  					 struct bpf_list_node *node,
>  					 void *meta__ign, u64 off)
>  {
> -	struct bpf_list_node_kern *n = (void *)node;
> +	struct bpf_list_node_kern *new = (void *)node;
>  	struct btf_struct_meta *meta = meta__ign;
> +	struct list_head *h = (void *)head;
>  
> -	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
> +	return __bpf_list_add(head, new, h, meta ? meta->record : NULL, off);

Strange to change the positions of the first two args.

Thanks,
Leon

>  }
>  
>  __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  					struct bpf_list_node *node,
>  					void *meta__ign, u64 off)
>  {
> -	struct bpf_list_node_kern *n = (void *)node;
> +	struct bpf_list_node_kern *new = (void *)node;
> +	struct btf_struct_meta *meta = meta__ign;
> +	struct list_head *h = (void *)head;
> +
> +	return __bpf_list_add(head, new, h->prev, meta ? meta->record : NULL, off);
> +}
> +
> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> +				  struct bpf_list_node *new,
> +				  struct bpf_list_node *prev,
> +				  void *meta__ign, u64 off)
> +{
> +	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
>  	struct btf_struct_meta *meta = meta__ign;
>  
> -	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
> +	return __bpf_list_add(head, kn, &kp->list_head,
> +			      meta ? meta->record : NULL, off);
>  }
>  
>  static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
> @@ -4563,6 +4584,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_add_impl)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c9557d3fb8dd..5f55b68ed935 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12459,6 +12459,7 @@ enum special_kfunc_type {
>  	KF_bpf_refcount_acquire_impl,
>  	KF_bpf_list_push_front_impl,
>  	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_add_impl,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
>  	KF_bpf_list_del,
> @@ -12520,6 +12521,7 @@ BTF_ID(func, bpf_obj_drop_impl)
>  BTF_ID(func, bpf_refcount_acquire_impl)
>  BTF_ID(func, bpf_list_push_front_impl)
>  BTF_ID(func, bpf_list_push_back_impl)
> +BTF_ID(func, bpf_list_add_impl)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_list_del)
> @@ -12996,6 +12998,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  {
>  	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
> @@ -13122,6 +13125,7 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  	case BPF_LIST_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
>  		break;
>  	case BPF_RB_NODE:
> @@ -14264,6 +14268,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>  		insn_aux->insert_off = regs[BPF_REG_2].off;
> @@ -23230,13 +23235,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		*cnt = 3;
>  	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> +		   desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>  		int struct_meta_reg = BPF_REG_3;
>  		int node_offset_reg = BPF_REG_4;
>  
> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +		/* list/rbtree_add_impl have an extra arg (prev/less),
> +		 * so args-to-fixup are in different regs.
> +		 */
> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}

