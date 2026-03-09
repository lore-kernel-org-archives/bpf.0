Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA63603D3;
	Mon,  9 Mar 2026 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038561; cv=none; b=pYcP9r14BPITnnoleJZ8i4Zg69T8hBUPQ1miTGmBEuRJIWXnCf7R1PH67yz+XwxGjjvC4ETbdpBSyFVqOa5BKSOTLddf3BlXYld9VCLbz+hRDDMJTnQMpNDBWhgquCe5ZFeYFNpTVZu2iKCeSCAzcl6zF3CwzU0GNU0S2FkRFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038561; c=relaxed/simple;
	bh=XleTbDS4c3am7yRa7QgHFFv9FhBaRieoLajn4tcGITk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puC17SnOoi7a4vj77vUF03JySU0HJIWjoVwyBdDdAPpX6NkuZMlhOvKbJxW1uF5v47Rmh7cWjOxiLbnmLOJRE119cuHm1wWpnXl4uBO+Tt6HL+gXn59xGoKYyHOw/OaKSee2xZ8MN9qpYkznAmdzfoW0NgIp6TLmZeoECGvl7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USOQGGDQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USOQGGDQ"
Message-ID: <489ddc36-d348-48ba-9a1f-52d9f63778cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773038547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBV635naTWeyfGGq/YDFwL1MY0d4l9xL3b/WIfcH7Xg=;
	b=USOQGGDQU3/RNydEUaf46wap2cpX3qtdzQgeOV++kpxnEAv9EhROxSu8EGHl8xwE/oW346
	yKYRmNyO6zCXMolVs7f6CeVOKZb0eZ27AwoGeBXH0hzdMbTIgysccMNNz16Nmk5qcl4V6E
	3piphrmquLcCKxC8YMofj7OSHSsz2qs=
Date: Mon, 9 Mar 2026 14:42:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/5] bpf: add bpf_list_is_first/last/empty
 kfuncs
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-4-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260308134614.29711-4-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 21:46, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Add three kfuncs for BPF linked list queries:
> - bpf_list_is_first(head, node): true if node is the first in the list.
> - bpf_list_is_last(head, node): true if node is the last in the list.
> - bpf_list_empty(head): true if the list has no entries.
> 
> In previous versions, to implement the above functionality, it was  ^
  Currently, ..., it is

"The previous versions" would mislead readers, that you are referring to
the previous versions of this series.

Thanks,
Leon

> necessary to first call bpf_list_pop_front/back to retrieve the first
> or last node before checking whether the passed-in node was the first
> or last one. After the check, the node had to be pushed back into the
> list using bpf_list_push_front/back, which was very inefficient.>
> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
> check whether a node is the first, last, or whether the list is empty,
> without having to first retrieve the node.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 15 +++++++++++++--
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 407520fde668..476f5ad319e2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2515,6 +2515,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
>  	return (struct bpf_list_node *)h->prev;
>  }
>  
> +__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
> +
> +	if (READ_ONCE(kn->owner) != head)
> +		return false;
> +
> +	return list_is_first(&kn->list_head, h);
> +}
> +
> +__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
> +
> +	if (READ_ONCE(kn->owner) != head)
> +		return false;
> +
> +	return list_is_last(&kn->list_head, h);
> +}
> +
> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +
> +	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> +	 * called on its fields, so init here
> +	 */
> +	if (unlikely(!h->next))
> +		INIT_LIST_HEAD(h);
> +
> +	return list_empty(h);
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>  						  struct bpf_rb_node *node)
>  {
> @@ -4585,6 +4620,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_add_impl)
> +BTF_ID_FLAGS(func, bpf_list_is_first)
> +BTF_ID_FLAGS(func, bpf_list_is_last)
> +BTF_ID_FLAGS(func, bpf_list_empty)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f55b68ed935..5e32e02429c4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12465,6 +12465,9 @@ enum special_kfunc_type {
>  	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
>  	KF_bpf_cast_to_kern_ctx,
>  	KF_bpf_rdonly_cast,
>  	KF_bpf_rcu_read_lock,
> @@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
> +BTF_ID(func, bpf_list_is_first)
> +BTF_ID(func, bpf_list_is_last)
> +BTF_ID(func, bpf_list_empty)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_back];
> +	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_empty];
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> @@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||

