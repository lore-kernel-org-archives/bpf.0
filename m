Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC933659F7
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594970; cv=none; b=lOsxbjmFgkz0VaAiwFM+k2aBGR+pQ0Ng/FIZEh2QoOa2eq3J0cao4Z+UelsY+D0z2J9oxyS9mkLXAyfeYYoWFoEsYGwkMXX6gyIOvgs0+ikNkD0YYiatTAjNfxk3hq01Jcb4VkIm+vPItJCs6EGr/dzhgozgX7Ty3qMjX9NpvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594970; c=relaxed/simple;
	bh=0hzv2xhvechn9sHUAnZoW1fRftyh5ZrNmVoIgKw4E98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S03AixM47NQf7ym+8aeKocHyQPmAnkdGYzhW8d6jQhTalENS37+JyLEabblC5Kvtci0H33nQslqLEDu8KKtOpwpftGu0IrCzhqzGB7uF75n3EBsuf9jgV+y8agtqXJza35HQSR3d9WClmxZZpI7uxaCtqRcwP6LagQFMtnRFEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=acqJpgFv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="acqJpgFv"
Message-ID: <ac769b90-262d-43de-85fc-7d47775b0a4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772594957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEpRNSH5ADcIRXvmOmBT4RbUgn1P97XMtCnamERhLyU=;
	b=acqJpgFvh/zPyfWdUeTX8xPAkp2MsWh0NVSx+lG4mvyDtXqlWfvqbyjE2ettTpAJvYQ+kz
	eNZEHLFRI43HZjxXZmKlV/VgKQvAHDfc4lVlKbO55bvjJeKXeRTgT6zR13sfqLJSoeftCN
	/5ZsCIu3aNhquRS6b4ZSMNolCGtJGlM=
Date: Wed, 4 Mar 2026 11:29:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/6] bpf: add bpf_list_add_impl to insert node after a
 given list node
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
 <20260303135219.33726-4-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260303135219.33726-4-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 21:52, Chengkaitao wrote:
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
>  kernel/bpf/helpers.c  | 27 +++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 14 ++++++++++----
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 19d88da8e694..488810da8f30 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2497,6 +2497,32 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
>  	return (struct bpf_list_node *)h->prev;
>  }
>  
> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> +				  struct bpf_list_node *new,
> +				  struct bpf_list_node *prev,
> +				  void *meta__ign, u64 off)
> +{
> +	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
> +	struct btf_struct_meta *meta = meta__ign;
> +	struct list_head *n = &kn->list_head, *p = &kp->list_head;
> +
> +	if (unlikely(!head))
> +		return -EINVAL;

Should the head handling be kept consistent with __bpf_list_add()?

> +
> +	if (WARN_ON_ONCE(READ_ONCE(kp->owner) != head))
> +		return -EINVAL;
> +
> +	if (cmpxchg(&kn->owner, NULL, BPF_PTR_POISON)) {
> +		__bpf_obj_drop_impl((void *)n - off,
> +			meta ? meta->record : NULL, false);
> +		return -EINVAL;
> +	}
> +
> +	list_add(n, p);
> +	WRITE_ONCE(kn->owner, head);
> +	return 0;
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>  						  struct bpf_rb_node *node)
>  {
> @@ -4566,6 +4592,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_add_impl)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c9557d3fb8dd..6dfd4afff1cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12464,6 +12464,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
> +	KF_bpf_list_add_impl,
>  	KF_bpf_cast_to_kern_ctx,
>  	KF_bpf_rdonly_cast,
>  	KF_bpf_rcu_read_lock,
> @@ -12525,6 +12526,7 @@ BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
> +BTF_ID(func, bpf_list_add_impl)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -13000,7 +13002,8 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_back];
> +	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> @@ -13122,7 +13125,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  	case BPF_LIST_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> @@ -14264,6 +14268,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>  		insn_aux->insert_off = regs[BPF_REG_2].off;
> @@ -23230,13 +23235,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

Why drop this comment?

Please add a comment explaining the reason for adding the
KF_bpf_list_add_impl check here.

Thanks,
Leon

> -		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}

