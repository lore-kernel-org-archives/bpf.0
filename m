Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43758366549
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595024; cv=none; b=ImnHE3MtlR8NjsgKISuCGT6oqOyGrCTI4QScf8U01krN8RQi+qa4haA0Tt1NzadRz0eL1G+qFN9K/i2HsQpJc0RwqLl7nmOfHIPzXdBA9R6EsVfybNTpKJukBhDY4+sJmQZuGFzgt8sOGPE2UIEU85F/k6IHXj4JrwfOaUItdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595024; c=relaxed/simple;
	bh=bDCY9qCxVKnxLg3h4cj0UKd9B7rYQLhMIbEpt8gfe6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okWAMsWwGIGx7aliuMa0Z2GLip4r9v+UdRn2bn8QGxa2y6+4iAZ2BLFWramIPUNLTCuULOFv6hWRbLUV7nkmq5TS0AXwWl+YCiC17HtVtsbuMOXOGj1CNgW7k+3owJQ4HVuCcX0E+DAx3d3IdeEivirGdKkJefhGLMMRb4ZGu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0AdRvAo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0AdRvAo"
Message-ID: <37bdb73c-095b-4239-806b-8ea51a2d27a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772595021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IF19acMeWMRHcUxQEGDqRzSYniGKihuY5dnjFgK3H60=;
	b=G0AdRvAo7QD7wr9mBKAD7wEFsfqbfNKYvOr4+My07wQRoohB7N07BRrbtL7EWuZoEBQw0i
	KeXF0itWiJf0DjM2VnH0BYW1pjKdHqw8yMFOSlcG7LjoUZN0Cy0sMQZeRVhrfXSrEvSfcH
	jkqKGt+T+AntkWyR97oQwxUQ7BcYq7g=
Date: Wed, 4 Mar 2026 11:30:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
 <20260303135219.33726-6-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260303135219.33726-6-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 21:52, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Add three kfuncs for BPF linked list queries:
> - bpf_list_is_first(head, node): true if node is the first in the list.
> - bpf_list_is_last(head, node): true if node is the last in the list.
> - bpf_list_empty(head): true if the list has no entries.
> 
> In previous versions, to implement the above functionality, it was
> necessary to first call bpf_list_pop_front/back to retrieve the first
> or last node before checking whether the passed-in node was the first
> or last one. After the check, the node had to be pushed back into the
> list using bpf_list_push_front/back, which was very inefficient.
> 
> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
> check whether a node is the first, last, or whether the list is empty,
> without having to first retrieve the node.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 15 +++++++++++++--
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 488810da8f30..3a64a9bab06b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2523,6 +2523,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
>  	return 0;
>  }
>  
> +__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
> +
> +	if (unlikely(!h->next) || list_empty(h))
> +		return false;
> +
> +	if (READ_ONCE(n->owner) != head)
> +		return false;
> +
> +	return h->next == &n->list_head;
> +}
> +
> +__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
> +
> +	if (unlikely(!h->next) || list_empty(h))
> +		return false;
> +
> +	if (READ_ONCE(n->owner) != head)
> +		return false;
> +
> +	return h->prev == &n->list_head;
> +}
> +

bpf_list_is_first() and bpf_list_is_last() are nearly identical. The
duplicated code should be avoided.

> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +
> +	if (unlikely(!h->next))
> +		return true;

NIT: A comment here explaining why !h->next returns true would be helpful.

Thanks,
Leon

> +
> +	return list_empty(h);
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>  						  struct bpf_rb_node *node)
>  {
> @@ -4593,6 +4631,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
> index 6dfd4afff1cf..78652ccd2a89 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12465,6 +12465,9 @@ enum special_kfunc_type {
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  	KF_bpf_list_add_impl,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
>  	KF_bpf_cast_to_kern_ctx,
>  	KF_bpf_rdonly_cast,
>  	KF_bpf_rcu_read_lock,
> @@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
>  BTF_ID(func, bpf_list_add_impl)
> +BTF_ID(func, bpf_list_is_first)
> +BTF_ID(func, bpf_list_is_last)
> +BTF_ID(func, bpf_list_empty)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
> +	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_empty];
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> @@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||

