Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9409352F87
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594836; cv=none; b=s1HAWdtEiJccipSS4phf/EvNCSn5j9dHVV9vy2hhCPurzJWnuX1AY7eGJV7LgsLi6NnYvHvjOdUqfvL6mlP8oA+E3gGxv1vsPj7nR7936/taOj+gaCL+spZv5ApBLCRvbHIbO5FBK87eMkQG9xFmPwv9K8wyzbpd7QC7bonIahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594836; c=relaxed/simple;
	bh=gapBFj8jaqc//3u39R8qRtg1glv1dxjRPXZ6upoI7WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh4IUmSZPQQtJF+7BV/iEKWS3FTi4NrgwWosqtpnwHkR7kLyPLqRc0wnHZ3ySBCuOnFz9Go1L+TedZrXRH2nrxvcyfBDhm7tQHMJ2yT/i0zZkV9WIRKgZf/P6z9ZH39jdCSivebM6ZlZbjIdvlirYYhgs4QCecSqZPi3fFVs4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1ghoeiH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1ghoeiH"
Message-ID: <8bbcfaf1-95f8-4e86-bbc9-fb2199c5df9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772594830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKUouPtAZbpfDt30Unji8r9NCbFXDlkA7tOrnCtuJD0=;
	b=X1ghoeiH4oYzDZtrCRJp4KosJBeFh0oTCWhb8n5BSyS2VzGLE4efykGh6W/UQOD2pgpUDX
	PFdV4g6Xc24WnzMME9Vpi55nGOm0zMQ5ri5mgm1jAe521ER2WDnugBdF41uoLLbnHl+gBe
	86WXXjXuFwB7heF2A0Bks4F35CX2UjM=
Date: Wed, 4 Mar 2026 11:27:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/6] bpf: Introduce the bpf_list_del kfunc.
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
 <20260303135219.33726-2-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260303135219.33726-2-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 21:52, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> If a user holds ownership of a node in the middle of a list, they
> can directly remove it from the list without strictly adhering to
> deletion rules from the head or tail.
> 
> This is typically paired with bpf_refcount. After calling
> bpf_list_del, it is generally necessary to drop the reference to
> the list node twice to prevent reference count leaks.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 19 +++++++++++++++++++
>  kernel/bpf/verifier.c |  6 +++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..19d88da8e694 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2459,6 +2459,24 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>  	return __bpf_list_del(head, true);
>  }
>  
> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,

NIT: The commit log should explain why the head parameter is needed,
similar to patch #3.

> +					       struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
> +	struct list_head *h = (void *)head;
> +
> +	if (unlikely(!knode))
> +		return NULL;

Similar to __bpf_list_del(), what if the list head was 0-initialized?

> +
> +	if (WARN_ON_ONCE(READ_ONCE(knode->owner) != h))
> +		return NULL;
> +
> +	list_del_init(&knode->list_head);
> +	WRITE_ONCE(knode->owner, NULL);
> +
> +	return node;
> +}
> +
>  __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
>  {
>  	struct list_head *h = (struct list_head *)head;
> @@ -4545,6 +4563,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
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

NIT: This series adds 5 list kfuncs, growing the is_bpf_list_api_kfunc()
chain from 5 to 10. It is worth considering a table-driven approach,
which could also apply to check_kfunc_is_graph_node_api().

Thanks,
Leon

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

