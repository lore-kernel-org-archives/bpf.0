Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C22D8795
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061110; cv=none; b=qllAZ5M34iW7X3CDkP9LiR6VM/uiFkwQrUXOrf9t4+UGMzYqR/tYhnSW+lxEz1fVkHtuMqalRf5xK+G9C/gyeSoNybvMWW02VrpBgcd8aAbGOQRNnAoT7iME00HR8HVGGz6klK05tKtnMEg3BO1hcNuqcYnEWXzTxZ+4yMwfWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061110; c=relaxed/simple;
	bh=IE8ESQrrOG30m9JyKzjk5inKck/ANVzJrrC5HisxLfE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hiGipkvar9yIoL/gpDH3Kub8cw6W3JZUXj59de2JurV62KrnrWd6Gdax4Vd73A+I5rMtyPp2ITKdnvbG+sXieHNc5ePe1r9zKSUafpTFABfCswN7OCXmudG8lekOzlCiUqKlzcQHcjRboofxDiTVMc/3iPPPvnub35fVvrhQoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=rFY0F3IS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="rFY0F3IS"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899fb2b94c1so13894946d6.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774061106; x=1774665906; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enDHMlp2If8foK9V1nsRwFYENcpB3nXX+k6e8kROXpU=;
        b=rFY0F3ISxD59gYVeo3gQtTQW7+cCM/QVhA7WNXE9cprTYYHbOEIBqCCm6Av0iS5StP
         1g4AM41GOVWBxwPXUv+bP+0DT6LxOXmibntfv5hGSrz826z6+XM+diamqPTMTcCrg6xs
         Dl9bSjEJNC6JjvA3QFW1H7Qn37XN33zIMlwRDAhkuHewmljzmd5qx/4kbqo0FnW+MjCM
         lVSda1emoGRy15038IV3RQ8gRUVGYc6U/p0s+V0/btdcXt7/vTSFHZT6K3oLwx1Fy9TP
         salx7ET9Xeq8ypVvwkgAAqY7GY87NbFNqKmtxn/lpgPW+jiixPIq+sQZ42xmPHORNPKl
         kM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061106; x=1774665906;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enDHMlp2If8foK9V1nsRwFYENcpB3nXX+k6e8kROXpU=;
        b=qkqb3f+ZewuIH1rCzQmS0ckepIXr13EwJhDSt/sBLNwUcOQD6i5W2muN9h3VKexpLj
         pvSB/pHD8rjRHJC0tDg/L6mEm6W5DPhffyI7hzkrGrTKtXl0cUADrDCFLK/oMd2VOPq+
         PPkJdotitdJhHO7zK6tNmAY2HhcUHKf42KoMnVF7ATyyiG7Ciz6HHa/nxqHiHKuVdk8W
         wMiVLnchRwB8iHTJ+H2wuUff9duGUjYEmwUPOMKegJeYzWDuI/FRMSk4kDnGu7kwqyOY
         MCexktxRgYEnaS57xqbyZkLqCL+cb3I+AH6vyplP/i89lwdCJpl1Q3P8GwUDe9Ywh7cw
         wTqg==
X-Gm-Message-State: AOJu0YxMOs7S46SrwK7aip2TZ8s7PljFcc9s9P8kiOGBmVKz509fjLi1
	adhKEm4kOYFNEhKrGu63u7yWGRzvavjAMpG0MotXPqOMsHNhdtXuLXbnXiwi9WmbkIk=
X-Gm-Gg: ATEYQzxbOuzM1tuUpJxHcGS0XyPNAguxIgACQHGoheR+G1E1xYYVgbbUazmtxWiJj3C
	ZaTqFLjrjJf9t0bWuurpLLhV0QIaJyWlksoi21zTwe7pjUYKyQnXNRSJrQq9FJ0vnnQvneyvoJT
	wHh7RyZfH+6lY5eCzkt2xUBNYtq1zjZ22jyxsG63kFlWdi8OBVtZq5x+pfi6vEQW2nK9ZgbdQrp
	l0ZTEoqbZ2FKJ3kwXu2/24Ym5R66chkH/TLQY3uRCbnypTR+aL7sRln3WiRjdp3sBIy4CxGWoiY
	+6zDLkY8qE3LLM9zy3ZIHF5KIJ3QX2MOtDj1wM1MIOzP0vOl2ctNfxjC+CfcTYY7vm2dcu0qTxQ
	ZH+eLX+fXfUOSDqjcRSbixV1ppMqQgdrdOcCFyQGftjE6wv7jTsLfn4e74N5TvQ/53Wvx6+XoK3
	Ft8XuLWyfNiaJdfm2ClJdLAKE=
X-Received: by 2002:ad4:5e85:0:b0:89a:258:c1d1 with SMTP id 6a1803df08f44-89c85a5f98emr89899696d6.42.1774061106102;
        Fri, 20 Mar 2026 19:45:06 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335771sm32090036d6.30.2026.03.20.19.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 19:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 22:45:03 -0400
Message-Id: <DH846C0P88QU.16YT12I1LXBZM@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 3/8] bpf: Introduce the bpf_list_del kfunc.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-4-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-4-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> If a user holds ownership of a node in the middle of a list, they
> can directly remove it from the list without strictly adhering to
> deletion rules from the head or tail.
>

Not sure what you mean by this, would saying "remove any node from a
linked list" work:

> We have added an additional parameter bpf_list_head *head to
> bpf_list_del, as the verifier requires the head parameter to
> check whether the lock is being held.
>
> This is typically paired with bpf_refcount. After calling
> bpf_list_del, it is generally necessary to drop the reference to
> the list node twice to prevent reference count leaks.
>

This is pretty confusing as a convention, and it's obvious in patch
8/8. Is it possible to hide this complexity from the user?

> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 11 +++++++++++
>  kernel/bpf/verifier.c |  4 ++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e87b263c5fe6..dac346eb1e2f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2437,6 +2437,8 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head,
>  	 */
>  	if (unlikely(!h->next))
>  		INIT_LIST_HEAD(h);
> +
> +	/* verifier to guarantee n is a list node rather than the head */

Why add this comment here? At the very least you'd need to add this in
the previous patch, but I think it's not particularly useful in general.
It definitely doesn't work here because it's for existing code.


>  	if (list_empty(h))
>  		return NULL;
> =20
> @@ -2463,6 +2465,14 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_bac=
k(struct bpf_list_head *head)
>  	return __bpf_list_del(head, h->prev);
>  }
> =20
> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *hea=
d,
> +					       struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *kn =3D (void *)node;
> +
> +	return __bpf_list_del(head, &kn->list_head);

See the Sashiko review: https://sashiko.dev/#/patchset/20260316112843.78657=
-1-pilgrimtao%40gmail.com

1) The WARN_ON() issue is real, you'd need to adjust the warning.
2) The more important problem is the reuse bug. You need to make sure
any elements in a list that don't get freed by during
bpf_list_head_free() have NULL'ed left/right and owner fields.

> +}
> +
>  __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *h=
ead)
>  {
>  	struct list_head *h =3D (struct list_head *)head;
> @@ -4549,6 +4559,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 64c1f8343dfa..e928ad4290c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12508,6 +12508,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_push_back_impl,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  	KF_bpf_cast_to_kern_ctx,
> @@ -12568,6 +12569,7 @@ BTF_ID(func, bpf_list_push_front_impl)
>  BTF_ID(func, bpf_list_push_back_impl)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
> +BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
> @@ -12644,6 +12646,7 @@ static const enum special_kfunc_type bpf_list_api=
_kfuncs[] =3D {
>  	KF_bpf_list_push_back_impl,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  };
> @@ -12652,6 +12655,7 @@ static const enum special_kfunc_type bpf_list_api=
_kfuncs[] =3D {
>  static const enum special_kfunc_type bpf_list_node_api_kfuncs[] =3D {
>  	KF_bpf_list_push_front_impl,
>  	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_del,
>  };
> =20
>  /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */

