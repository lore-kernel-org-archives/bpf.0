Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30162E9730
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135415; cv=none; b=hxyMb16C/eAWpMa6Y+9On3zR/bAGjMNxo7+1i2UBOY50G6MaXjA+eza1npOTIm/D7BUXAW9zmRIeEcWhFxbOWAKVWjHodTUqxEXiDZCPIBpDQ+6Lk9thK+qOYipw1v2zNFn4Oz4AJiQL69RNs4Ys4jUO523HOZQiSyj54SUjXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135415; c=relaxed/simple;
	bh=Ax4oyaT6DcrmY97EUmDPCUDE6qVUTmdLH5lBNUnZEYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sh0OO03szN4GhdlOSlNgMjbDk4ulvGbgSrmbRddd5GEjlYmcIAKQo3+ZofWxA4u+JDElqXYuqemOB48Ncw2UskeUVnIdca/M4dfi8Bzrxqn6UgfUBLF0o3wbfjnrlxbfO6D4OHcljrlwqlXVQp4J2dZ91AgtIH9hh2jostkb96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=qUMywL21; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="qUMywL21"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50912a097b0so20238331cf.1
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774135413; x=1774740213; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oizmS4mQpOjWAfvbDhfDQ+/IZZTNKcbAQcQjyMhxDuM=;
        b=qUMywL21Ad0kChpw04E7mUi0dLNqw6Mq91VKYffZ4fLaLR71lhyQMGiLi3w6ofeNXr
         0fVZPU1lInkoNuHEwzkz4+MCNksWUCQfSF+4j/A3apc+3G55dKjpqsOTjqJnY9rGFvm4
         BT1TckjgTvuZzLjL4Ifzh7j4NU6Cc4Nk4fSvV2CuWVrePK8gv1JepjtgXvYJm1b5iMTd
         OwVBZyPiVWxBpx34GIFvIoa7IKzrayWm/YKfiuatwU6A4c9XFymTcbHWUPPIO6gJj5tt
         dm9IzyB4x8msPSFLUrIo/kGLmFw6Z6tlwgtoHH+6Vkewwak2jXwe/0WRJiUPx8Ij1j5q
         3JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135413; x=1774740213;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oizmS4mQpOjWAfvbDhfDQ+/IZZTNKcbAQcQjyMhxDuM=;
        b=mRpw3lQXuKnSq7zvtrgEvdNmIZyjs0vUO2dunh9HwWaOf+1xXrieMqsDs/hd4NCilZ
         pIcUlCVIErCywM/yDlb93aHM/VumQHw+PehgknH+R9GSP7eQf1BLGHChNQnhjygXJh6k
         G4hoZ5Mysv6ko303cbCV1D1O9bdeYhVpGoUc1PNjBLjUivsHzcoQAqyJB9ViD9Y4efPk
         IU1QMvLvvypsF2dVaMBfAqj8/M3fkWMeySsZDyW+9lkg+Tyo8qav0paB8U1mpXuCVUjw
         B6kVc3TlcuhJUmr3HoT8Ho10T1P3mMflHfQmR7lW+QqdDQSfLFtzG6iZsYFEOXHNe1mn
         R2Yw==
X-Gm-Message-State: AOJu0YxkFaixYxJFY3fVCMsR8ESroFlQ5Sa9Egwx2rd2FRGcgFf3vUhP
	xho2RrpgrjlPBmXO/euf7CucmiG7cAFdPSLGG/zRnB4Sligw29pi5PfDPYe9AZ0M/R4=
X-Gm-Gg: ATEYQzwMI1kS+10QVSDCPkAti8H0UPNDHzRI0g5BrlieOltf9LCAKWtZGQThoKP05CC
	n5C/V0vDxRh31rHDW3nVQHgMDuTOsonGi4ABNROAHzIliN1ZO9PMwKDiJsISzqbCNovEDnpe7/1
	BZ3MgwpFOm7gKhtOaxFGvF1DZx9CtkOJ/EfiGwfdy3+Bn7vqjfblKw1TzFxGa2ZBKz57O7RF7M7
	+9K4l6m5NrIwkSD+NX/Bdh1U2sCrLlybBZ3j8yDwdiwhvkkXSOCcghOVSNGO7Um0B0Rufc7sPD3
	gHAnibZjNX+R3ljOF64hDJld3hCCJAtXwrf1nAhsANV46Hefm77a8b1EOz2IARrGWLlanrtMODa
	qoHN7BXdQABpHx861gmX+PqJIOJearXzdCqf4j7JlVwMwrekyDTFdiNz6yZHUw7rYxWFYOSH7c1
	4UCkux3+/jCNiKFrw3ObJC/h8=
X-Received: by 2002:a05:622a:4c12:b0:50b:534f:4285 with SMTP id d75a77b69052e-50b534f440dmr14765661cf.7.1774135412558;
        Sat, 21 Mar 2026 16:23:32 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb3c91sm52360571cf.4.2026.03.21.16.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 16:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 19:23:31 -0400
Message-Id: <DH8UIK9AQRV0.KZTEGI7CK0AV@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 4/8] bpf: refactor __bpf_list_add to take
 insertion point via **prev_ptr
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-5-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-5-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Refactor __bpf_list_add to accept (new, head, struct list_head **prev_ptr=
,
> ..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr afte=
r
> INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
> head was 0-initialized (e.g. push_back passes &h->prev).
>
> When prev is not the list head, validate that prev is in the list via
> its owner.
>
> Prepares for bpf_list_add_impl(head, new, prev, ..) to insert after a
> given list node.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dac346eb1e2f..a9665f97b3bc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2379,11 +2379,13 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void =
*p__refcounted_kptr, void *meta
>  	return (void *)p__refcounted_kptr;
>  }
> =20
> -static int __bpf_list_add(struct bpf_list_node_kern *node,
> +static int __bpf_list_add(struct bpf_list_node_kern *new,
>  			  struct bpf_list_head *head,
> -			  bool tail, struct btf_record *rec, u64 off)
> +			  struct list_head **prev_ptr,
> +			  struct btf_record *rec, u64 off)
>  {
> -	struct list_head *n =3D &node->list_head, *h =3D (void *)head;
> +	struct list_head *n =3D &new->list_head, *h =3D (void *)head;
> +	struct list_head *prev;
> =20
>  	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
>  	 * called on its fields, so init here
> @@ -2391,39 +2393,49 @@ static int __bpf_list_add(struct bpf_list_node_ke=
rn *node,
>  	if (unlikely(!h->next))
>  		INIT_LIST_HEAD(h);
> =20
> -	/* node->owner !=3D NULL implies !list_empty(n), no need to separately
> +	prev =3D *prev_ptr;
> +
> +	/* When prev is not the list head, it must be a node in this list. */
> +	if (prev !=3D h && WARN_ON_ONCE(READ_ONCE(container_of(
> +	    prev, struct bpf_list_node_kern, list_head)->owner) !=3D head))
> +		goto fail;
> +

This is pretty difficult to read, can you clean this up?

> +	/* new->owner !=3D NULL implies !list_empty(n), no need to separately
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
> =20
> +	list_add(n, prev);
> +	WRITE_ONCE(new->owner, head);
>  	return 0;
> +
> +fail:
> +	/* Only called from BPF prog, no need to migrate_disable */
> +	__bpf_obj_drop_impl((void *)n - off, rec, false);
> +	return -EINVAL;
>  }
> =20
>  __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>  					 struct bpf_list_node *node,
>  					 void *meta__ign, u64 off)
>  {
> -	struct bpf_list_node_kern *n =3D (void *)node;
> +	struct bpf_list_node_kern *new =3D (void *)node;

I don't think this rename or the one in __bpf_list_add are useful, they
also kind of obfuscate the point of the patch by accident imo.

>  	struct btf_struct_meta *meta =3D meta__ign;
> +	struct list_head *h =3D (void *)head;
> =20
> -	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
> +	return __bpf_list_add(new, head, &h, meta ? meta->record : NULL, off);
>  }
> =20
>  __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  					struct bpf_list_node *node,
>  					void *meta__ign, u64 off)
>  {
> -	struct bpf_list_node_kern *n =3D (void *)node;
> +	struct bpf_list_node_kern *new =3D (void *)node;
>  	struct btf_struct_meta *meta =3D meta__ign;
> +	struct list_head *h =3D (void *)head;
> =20
> -	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
> +	return __bpf_list_add(new, head, &h->prev, meta ? meta->record : NULL, =
off);
>  }
> =20
>  static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,

