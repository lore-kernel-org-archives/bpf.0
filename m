Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD62147E6
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969273; cv=none; b=bQ2lVTgamOKLE5TMLnrn+DXPpkqUStQ5b3pH5a7nVWvfKxQ0gah0r94knXkMXEJgcCTxsJszJ73LO+r0Oqe/ZUzpSTaz2Iz3D/yRj4TcwVR8XMFlxkbB4+WaIvBK0+8HAuyQZO0ImOQaA/K+/TJTtYNsl4z33COl6w5T8gjBRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969273; c=relaxed/simple;
	bh=keB0QlMp0KvxU7I46dLXT8uUdep8rMfKLdyK7+9q1IA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=I8c4r866RgghqTjDr64J9TInN9PHRMA4dxxvW26t8iGTmdkr+EPkm02+mZGJLyt/FJh1V2Ce41XszkDFkLIT2wjywtQD0za0JWR+8z48qLjhGpsEGZYcpZzbRWmiuhfOzLqed6Ovg341nG+KRiIUTDjInnvFIeztQgl2+tni4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Su0MyR4/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Su0MyR4/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e08baf860so953109a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783969270; x=1784574070; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VJARKbZxQw+5xLSwPuHaI/jl5Lgqh19eFRVAg6BGDE0=;
        b=Su0MyR4/Td1dbX30PfVtcVJlega3yJRbvdpYlT9DAaoMEP9UhmTAs12DRzMcN18dLW
         imF/vnKnS+CRq8jQ+sZkDa1DrGG886SVJon4B8hCX1o+QSz1gEeo2yKWKd/gsFWGXofa
         6/VBwdo3Gj1ovzmYjGaxFix38XOcqStBBkcBBcZT4pg4VuzJ4e3OWqiyoq5Kbe/ZsW8d
         LeuBvUa6x9UEUAl5Rb2XptfmSqlUBbZ4wHPRMAgTwSZLNfggAFQWP2O5SfhON+sGU27L
         lLKzgXKKuj3LKnTXXSkV02z4+o40OkXYLa8CgTuC++HM9UnbDsv27MZpQxm3KZleqW+i
         lhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969270; x=1784574070;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJARKbZxQw+5xLSwPuHaI/jl5Lgqh19eFRVAg6BGDE0=;
        b=p5gjc/uWZlur3pKvVIMn1oj14x7++ANeyJqP955g/QgvbHrfQ2b724r7qVbPPfCuVj
         f3Z9YUto16N2OWeTwDIhK63x9luQ9C5AC4GVvVNa/QKclR8BV0SdZ/RaCnuCQU352VFd
         28dsuWdM7hOdXgX/PP8uISO0VV+aRyloPaISYJKqxEIhBBP4J6WrWL5qFaAf6fvrYBLk
         8XlLNXclCzn9tbSVesa7/oR0h9OtszLy1QNu2nLw4y7R7mAsTFMgM5EU4dp8ru3IT5Os
         fZfLy4vmUlwzpOmhIOY1ol08YhNEU94i/xXl8XOA2XIaLjICU3VOIPr4/h/3eBxXOoZR
         BVig==
X-Forwarded-Encrypted: i=1; AHgh+Rrgl4cxKojX05Rny2lHrrufKayxoCsFoO3TInzld+0EqPBydKhCtFWTZU3BNDMrQXnL8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9svJzk93qX8epkhYqWscGe+NpkhSyiHHmFPeGqpnAPWVRDUw
	nfusGkUc9R9cKtndqz/mwFTnRWF+j/4QZLmONclOS4jbUrlckL3DWdLHVp54r80pg/k=
X-Gm-Gg: AfdE7ckXIus54TNmn1Rlu3KjYvHvWgMGQO/DtWJYYjpjOw/6ZqnLdTytOM99y2FqUM3
	d0G1rVNg8t8HF8MgP6be+heXiWDa6x2v4sQJJ6vq/e1zylQYyOTDbLHycYUzkcBgyYTInfRZURg
	X4y9idGCsD/NBHwJSYcRRkK8SoN+vIUglltK1BevbMZ/VydeRTY0HrKLGKhI2orbe5cFSm2Ty+Z
	XWACStLRt6pXoAZIRJ1pvgp88yB0fH82W5jXtGPwUz4K37ouJdHmt1c/QXbwrm9s9mZRjXmV+TT
	WIkSaoRai6gUut2cXKIY1rKZtq0tn8hI5HENWuM1mMkctYDGIXyAAkes4JK8wzpyPrfE7W0K/qd
	oohGG0FLOPJDbTzbr2Y9EPDZnSOrzFSOMhDS/niqYVncFaQPWD2+xflj4iqfCIp7onEUq4lk4yI
	/6jHFHEEq2HpsEiSTVSUh4PtpRTH8r+Jn8y+26L0g3Vg==
X-Received: by 2002:a17:90b:554d:b0:381:cef1:11b0 with SMTP id 98e67ed59e1d1-38dc77a4517mr9473576a91.33.1783969269613;
        Mon, 13 Jul 2026 12:01:09 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38deea72fc3sm1146162a91.2.2026.07.13.12.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 15:01:08 -0400
Message-Id: <DJXOBRV3S89L.3OLMFO3UY0WS8@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-3-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-3-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf_struct_ops_map_free() currently waits for both a regular RCU grace
> period and a tasks RCU grace period for every struct_ops map through
> synchronize_rcu_mult(call_rcu, call_rcu_tasks).
>
> A regular RCU grace period is still required for all struct_ops maps
> because the struct_ops trampoline ksyms requires a rcu grace period
> (take a look at the list_del_rcu in __bpf_ksym_del).
> Add a map_free_pre_rcu() callback so the struct_ops map can remove
> ksyms before bpf_map_put() wait for the regular rcu grace period.
>
> The tasks RCU grace period is only needed by tcp_congestion_ops.
> Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
> of the bpf_map.
>
> When CONFIG_TASKS_RCU=3Dn, synchronize_rcu_tasks() is the same as
> synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
> grace period before bpf_struct_ops_map_free() runs, skip the extra
> synchronize_rcu_tasks() call in this case.
>
> This cleanup prepares for a later patch that needs to support
> free_after_mult_rcu_gp.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The Sashiko issue looks spurious to me. bpf_prog_dissoc_progs() is not
related to the availability of the struct_ops methods. It is valid for
it to be after the end of the grace period.

> ---
>  include/linux/bpf.h         |  7 +++++++
>  kernel/bpf/bpf_struct_ops.c | 31 +++++++++++++------------------
>  kernel/bpf/syscall.c        |  3 +++
>  net/ipv4/bpf_tcp_ca.c       | 16 ++++++++++++++++
>  4 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..7ac8873839f4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -90,6 +90,7 @@ struct bpf_map_ops {
>  	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
>  	void (*map_release)(struct bpf_map *map, struct file *map_file);
>  	void (*map_free)(struct bpf_map *map);
> +	void (*map_free_pre_rcu)(struct bpf_map *map);
>  	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key)=
;
>  	void (*map_release_uref)(struct bpf_map *map);
>  	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
> @@ -2099,6 +2100,11 @@ struct btf_member;
>   *	   unloaded while in use.
>   * @name: The name of the struct bpf_struct_ops object.
>   * @func_models: Func models
> + * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wai=
t for
> + *                           a tasks_rcu gp before freeing the struct_op=
s map
> + *                           and its progs. It is unnecessary if the @un=
reg
> + *                           has waited for the correct rcu gp or the @u=
nreg
> + *                           has ensured all struct_ops prog has finishe=
d running.
>   */
>  struct bpf_struct_ops {
>  	const struct bpf_verifier_ops *verifier_ops;
> @@ -2117,6 +2123,7 @@ struct bpf_struct_ops {
>  	struct module *owner;
>  	const char *name;
>  	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
> +	bool free_after_tasks_rcu_gp;
>  };
> =20
>  /* Every member of a struct_ops type has an instance even a member is no=
t
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d06b3d9bcc13..c422ce41873e 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -984,9 +984,18 @@ static void __bpf_struct_ops_map_free(struct bpf_map=
 *map)
>  	bpf_map_area_free(st_map);
>  }
> =20
> +static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> +
> +	bpf_struct_ops_map_del_ksyms(st_map);
> +}
> +
>  static void bpf_struct_ops_map_free(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> +	struct bpf_struct_ops *st_ops =3D st_map->st_ops_desc->st_ops;
> +	bool tasks_rcu =3D st_ops->free_after_tasks_rcu_gp;
> =20
>  	/* st_ops->owner was acquired during map_alloc to implicitly holds
>  	 * the btf's refcnt. The acquire was only done when btf_is_module()
> @@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);
> =20
> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();
> =20
>  	__bpf_struct_ops_map_free(map);
>  }
> @@ -1123,6 +1116,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> =20
>  	mutex_init(&st_map->lock);
>  	bpf_map_init_from_attr(map, attr);
> +	map->free_after_rcu_gp =3D true;
> =20
>  	return map;
> =20
> @@ -1155,6 +1149,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
 {
>  	.map_alloc_check =3D bpf_struct_ops_map_alloc_check,
>  	.map_alloc =3D bpf_struct_ops_map_alloc,
>  	.map_free =3D bpf_struct_ops_map_free,
> +	.map_free_pre_rcu =3D bpf_struct_ops_map_free_pre_rcu,
>  	.map_get_next_key =3D bpf_struct_ops_map_get_next_key,
>  	.map_lookup_elem =3D bpf_struct_ops_map_lookup_elem,
>  	.map_delete_elem =3D bpf_struct_ops_map_delete_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..b07acf37ad1d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -956,6 +956,9 @@ void bpf_map_put(struct bpf_map *map)
>  		/* bpf_map_free_id() must be called first */
>  		bpf_map_free_id(map);
> =20
> +		if (map->ops->map_free_pre_rcu)
> +			map->ops->map_free_pre_rcu(map);
> +
>  		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
>  		/* RCU tasks trace grace period implies RCU grace period. */
>  		if (READ_ONCE(map->free_after_mult_rcu_gp))
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 791e15063237..e224ecafbd69 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops =
=3D {
>  	.validate =3D bpf_tcp_ca_validate,
>  	.name =3D "tcp_congestion_ops",
>  	.cfi_stubs =3D &__bpf_ops_tcp_congestion_ops,
> +	/* The struct_ops's function may switch to another struct_ops.
> +	 *
> +	 * For example, bpf_tcp_cc_x->init() may switch to
> +	 * another tcp_cc_y by calling
> +	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +	 * and its refcount may reach 0 which then free its
> +	 * trampoline image while tcp_cc_x is still running.
> +	 *
> +	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> +	 * to finish. bpf-tcp-cc prog is non sleepable.
> +	 * A rcu_tasks gp is to wait for the last few insn
> +	 * in the tramopline image to finish before releasing
> +	 * the trampoline image.
> +	 */
> +	.free_after_tasks_rcu_gp =3D true,
>  	.owner =3D THIS_MODULE,
>  };
> =20

