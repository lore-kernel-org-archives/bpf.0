Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532934DB6B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639430; cv=none; b=ghUBdsZtdLAak8R3Qxl58ynCScMfyQYfRCTn3HNLzz3ayKGo83gMhQBU4u1N8oICmhdZ2TZLO7yH0FLqK7h/KDy2zpkFskQ6e6tq8rLwgTgyefPchLu6IxeIM6JYkmPlk7U/XVNWgbcJi2prdK8ku0BmFs4cPkwg5KeKo6I2dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639430; c=relaxed/simple;
	bh=w6LqXOQUcB1wsH+GmlLg2ewkK/aAuJHDY9tvSj/ttcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+O9RePadBsW7Hf6YiGifLTET+3QbFmoHqQdiuwIBUdfUMJkiGbHKlBGsW0BRC3LxhmICFzMEVYZquvbz97nm+wrMT4amow6vGBiVAwKkMVsLmZ5Qc6iCIAXa5CJJpQ6cLNV8S4s+CfZ4nPL70J+mYqAUxCC2MeFYF1ifje3T+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFhtM+2F; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFhtM+2F"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f8d80faebso1193671266b.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639428; x=1773244228; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ok/YTE+I3sK+ILjnFMurIUPcQGqFnacHImE0I6telA=;
        b=SFhtM+2FRGueSxeHmFUNQB+SEjVuMhJq9nZkFCziikE8BKOgr68pNn4/ByoDblBm9i
         AabcvnzHhbN/zvbbqGdWWbBjmR13f2XJkcAA4Xp9WcZ+Q8lW/9gjsUvHjHTKDY30OLkn
         LgPEZJuSGemyN6LW0OiFyDsPJyYRADQ5vCL64NjNwhhs9tjrvLzAVWaPweAQNxXspyi+
         nhCCbXPWjCgSvyO5wOml7xcGkciwmCjKr5A9Vm/hk2YVwHUDuoTfRW6L2CzSdJRvrtRS
         MqN01XcHZEui6Lz7/M8Btw49hwCRrsabNZblQFmK45l9CGN4jIpmPv6LZCJTkBpex22Y
         ofDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639428; x=1773244228;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ok/YTE+I3sK+ILjnFMurIUPcQGqFnacHImE0I6telA=;
        b=ecgJTqDoJots/hcgiHXJvWwV/WYUhkbkTybX++EQ3g12PGIxxetY/78Kxj0K043Y49
         7YedPzwQm0/wggcIv3MOEBoTco1mmmSO1ngZc6cLZiFFhXKkH5nrMTSarmEsWP81ucG8
         z2vCC49dvAq1N8N5SUaL4cB4qu7OSo+pAhdTY/jyq77rmQXHDpN8fe0wwCSL1sRQbBE/
         FGAsyibXSv+AwZm+7zrigg33Ipy/jlrLiRYVqUMl+y2795IB0KqdZJZHX/VR1mPfPvbn
         KZ2URDdLDV5Sdwb4GoEDt44pVzVBHQ22utNO/NTrFzwWatHUBncElQYM24/8vsv++oKx
         SgMA==
X-Gm-Message-State: AOJu0YyYA1xqV6QKqLWOjXJPNGh1kfuL5dS/NVfVLCvgD9ZUDTEHcoZp
	4m0O2vYwG65C+21WOdpMzlSvx7IIMfef5XmT6m8XegLHpRS4R/JeCIf6
X-Gm-Gg: ATEYQzzH555SM+IzdysIPZyHVoKm4uZSVqWBSf+iwu4N6GWh5XQX8N0Z2snrxJPcdBc
	ZW8rNLsQNCSM+Ou1wUydJkbT5VGhCIpNLjWJbzA3SN4bggy8Yj8VDLDMdTpnfVgCflG9ZqFagtn
	xaLWevhHJtuA70DVKSqhFQQbHjPV3vywOJUrbdymGpn21FAT4yAXghQ/O3EoEsrbw8akRBB+ijZ
	l0nZ6bdrD2ZIESj0FFMS2bkQgrryRRj0tYNgaWsNTf1RIYtHtWTa1UWuW0gLCo6swOgSd8s0GmL
	9qzXpFEnmX5Tx6n28CPhK6qyroPNt6oHID70te7In4dlVJfFk/GW55ZBlpqzTLWHa5tSjctFrNM
	NSdv9cse83p9imuO60h4sinbFJCdvZJPBQPciLfB9+5GAYal/TZtjRNuAdpQxm7UcyEmfyW1xLI
	pml7ZnC5Y4cXWFJP/y763Al2NekBDpsRmKxeT8hQ==
X-Received: by 2002:a17:907:1c1f:b0:b90:bd3f:7c0d with SMTP id a640c23a62f3a-b93d4453848mr366157866b.27.1772639427435;
        Wed, 04 Mar 2026 07:50:27 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66005566561sm4351946a12.30.2026.03.04.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:50:26 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] bpf: Introduce the bpf_list_del kfunc.
In-Reply-To: <20260304031606.43884-2-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
 <20260304031606.43884-2-pilgrimtao@gmail.com>
Date: Wed, 04 Mar 2026 15:50:26 +0000
Message-ID: <87wlzry4ot.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chengkaitao <pilgrimtao@gmail.com> writes:

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
> +					       struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
> +	struct list_head *h = (void *)head;
> +
> +	if (unlikely(!knode))
Can you pass knode==NULL to this kfunc?
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(knode->owner) != h))
it looks like you can just do READ_ONCE(knode->owner) != head. owner is
void*, what's the point of defining struct list_head *h?
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
> -- 
> 2.50.1 (Apple Git-155)
