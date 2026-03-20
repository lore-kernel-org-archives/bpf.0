Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DF396B8E
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021806; cv=none; b=odr9VIdtBHFusHQ8g8egC/Xp9GLftkq83snh1Tg+XdVz3Mh1H7OZVeLAM4pV/vLiyo4I4c3zK5EpGnctJ6lT25VVuIrTxqzJxduJTsms0h8NuBdhjwAzSnoFjwhe4KGq4VOBhxHBaY6aqk4SoRxxFotwgjge3tX6EmDl8uWBdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021806; c=relaxed/simple;
	bh=GJJAZaccMxFqWk4+9B/WieZEP6Qsyl3qpv7qd5zbElE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hu34FlqLpMc/hmavAKKC3GeSIkWlVtmAIGvyJjphwZ42G8TWk0KUsi94BnLXTP/AoH8+wCLbrHJRxsSm27juPYWMyAUAcK3XabHFsqW2pXV2H+S5UZcjHfH0WP7w7i5TF8k9CzmQgXvRzkzZ7x9P4z6SJcHAA1c8Rxz+X8md42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9rNd31q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9rNd31q"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe655187so12133325e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021798; x=1774626598; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+JS7skj1nhDusKY9cOdC+c8Nv6/VDUPm9hS7rR7Zys=;
        b=C9rNd31qYew+ZDaKK0O7hY8yWV6Zm0o3kZMSQ2GZKfzJaUViGI5v79fIe+5GfYJM1p
         m6qRJQXeRpOLFOl4b7bHPrOYWD8lHu14U8mg5s0kMgG2NW422TU23qW3+1+vdhzAhfPK
         wbIo5yBLmE793O2jt5cu69AsNkc5929qdYfcdPLAHL00n/pJ6sE9Egh3MSzAWSGDCkc4
         g4+4whJgWuQthbySE1NfD8ze/yBltXljQlS9bvYOqSkbUtu70lfQfQo8SR4yw90nlo5C
         Eh0KOUVBfkps7itMVfOGvu/1QL0Za51g3ktYihH8v4pUgxpFpHMTmxVLY17renyB6Cqs
         Y5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021798; x=1774626598;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+JS7skj1nhDusKY9cOdC+c8Nv6/VDUPm9hS7rR7Zys=;
        b=Da/3dpLXKH7qraG86H085YYaYL3MhKFkOaE5czQ0ip3/aHT6yAIbUPDb4TKv2XEoW6
         WFfh5K3aD/6GWlaPSH4IHB0iaTKG+Ofm7Nn18CTGSbw24/iosydHHrDenqnEKzG10NaV
         Cb2PAkZmXbXUilPxNRqqMncD9zWa2/WEmiPiuCgYaSrDcuNq4WTbge1SQfaCzHhMv+Pu
         hSLUhtJK9fr9/7Van5T/gWHmlD8sELyB/ZWZ/Z30+IR7XhiUHJLpFFTTizHp1lP1TyLP
         bCPrtalq4JWohkZmckyycponqmiJHKW4IfFAkCTJOpzDtKalUyEO6OcOQfz0TJyvWb4G
         wKSQ==
X-Gm-Message-State: AOJu0YzoNV8qvl1U8bvYQqmnhiyvdVGHSkAQVwoK+IjwqXi/2wchBdMp
	4joZTuxLot2qssTzLkLOAkpDTIsoyjbTJR5DpIMPyzJhG2n/3blSRGKM
X-Gm-Gg: ATEYQzx2tn0rj8i8UL6iBWkM474gwuSvB2JYCjNSvTt6EaOnqTNRGQZyf41DcRt8RlB
	Xvr8hecjaGyOjr1UM0MnhkIQ4tMj44TqIqPNj3oc48NgzbyzlNk1uVPGIyg/EB8BB8SM8E9p5BM
	Y8ab7icKVX96n0q/vgaQFtB0au4Skc2kvgbSeNBwX6rdkGZGFD1TxleprLXEC7PNUqotMpAb8gw
	QxK2BacQMgAi35SWvgOWP63jyEEGKOIpugmrhvywUK79ms1UGwm3uFeV4Z03HulJEQtcEY6DUtM
	V0rYc63xo2rumz0+/5ISsBuhVSIVaJ40DPR45aGada+5O2HtngD+q7QNYs0NHjGTLTtzSplUoZv
	/t16HeHHwLznfWTyUxkeK319p98bGko2DC6h3bM/j+S2lyyhe/lRrTKnB+zaXs06H8rXZfPqRcN
	kgxFj8w+lzCeUWqxLVSu5u19Zb
X-Received: by 2002:a05:600c:3b1e:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486fee05925mr50491485e9.19.1774021797358;
        Fri, 20 Mar 2026 08:49:57 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:f9f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm63151945e9.13.2026.03.20.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:49:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
In-Reply-To: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
Date: Fri, 20 Mar 2026 15:49:55 +0000
Message-ID: <87tsuajyak.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> The following kfuncs currently accept void *meta__ign argument:
>   * bpf_obj_new_impl
>   * bpf_obj_drop_impl
>   * bpf_percpu_obj_new_impl
>   * bpf_percpu_obj_drop_impl
>   * bpf_refcount_acquire_impl
>   * bpf_list_push_front_impl
>   * bpf_rbtree_add_impl
>
> The __ign suffix is an indicator for the verifier to skip the argument
> in check_kfunc_args(). Then, in fixup_kfunc_call() the verifier may
> set the value of this argument to struct btf_struct_meta *
> kptr_struct_meta from insn_aux_data.
>
> BPF programs must pass a dummy NULL value when caling these kfuncs.
>
> Additionally, the list and rbtree _impl kfuncs also accept an implicit
> u64 argument, which doesn't require __ign suffix because it's a
> scalar, and BPF programs explicitly pass 0.
>
> Add new kfuncs with KF_IMPLICIT_ARGS [1], that correspond to each
> _impl kfunc accepting meta__ign. The existing _impl kfuncs remain
> unchanged for backwards compatibility.
>
> To support this, add "btf_struct_meta" to the list of recognized
> implicit argument types in resolve_btfids.
>
> Implement is_kfunc_arg_implicit() in the verifier, that determines
> implicit args by inspecting both (_impl and non-_impl) BTF prototypes
> of the kfunc.
>
> Update the special_kfunc_list in the verifier and relevant checks to
> support both the old _impl and the new KF_IMPLICIT_ARGS variants of
> btf_struct_meta users.
>
> [1] https://lore.kernel.org/bpf/20260120222638.3976562-1-ihor.solodrai@linux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> v1->v3: Nits suggested by AI
>
> v1: https://lore.kernel.org/bpf/20260312193546.192786-1-ihor.solodrai@linux.dev/
>
> ---
>  kernel/bpf/helpers.c                          |  93 +++++++--
>  kernel/bpf/verifier.c                         | 184 +++++++++++++-----
>  tools/bpf/resolve_btfids/main.c               |   1 +
>  .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>  4 files changed, 206 insertions(+), 76 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb6d242bd093..fc4d537c0b15 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2302,9 +2302,8 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>  
>  __bpf_kfunc_start_defs();
>  
> -__bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +__bpf_kfunc void *bpf_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta)
>  {
> -	struct btf_struct_meta *meta = meta__ign;
>  	u64 size = local_type_id__k;
>  	void *p;
>  
> @@ -2313,17 +2312,28 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>  		return NULL;
>  	if (meta)
>  		bpf_obj_init(meta->record, p);
> +
>  	return p;
>  }
>  
> -__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +__bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +{
> +	return bpf_obj_new(local_type_id__k, meta__ign);
> +}
> +
> +__bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta)
>  {
>  	u64 size = local_type_id__k;
>  
> -	/* The verifier has ensured that meta__ign must be NULL */
> +	/* The verifier has ensured that meta must be NULL */
>  	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
>  }
>  
> +__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +{
> +	return bpf_percpu_obj_new(local_type_id__k, meta__ign);
> +}
> +
>  /* Must be called under migrate_disable(), as required by bpf_mem_free */
>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu)
>  {
> @@ -2347,23 +2357,31 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu)
>  	bpf_mem_free_rcu(ma, p);
>  }
>  
> -__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> +__bpf_kfunc void bpf_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
>  {
> -	struct btf_struct_meta *meta = meta__ign;
>  	void *p = p__alloc;
>  
>  	__bpf_obj_drop_impl(p, meta ? meta->record : NULL, false);
>  }
>  
> -__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
> +__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> +{
> +	return bpf_obj_drop(p__alloc, meta__ign);
> +}
> +
> +__bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
>  {
> -	/* The verifier has ensured that meta__ign must be NULL */
> +	/* The verifier has ensured that meta must be NULL */
>  	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
>  }
>  
> -__bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
> +__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
> +{
> +	bpf_percpu_obj_drop(p__alloc, meta__ign);
> +}
> +
> +__bpf_kfunc void *bpf_refcount_acquire(void *p__refcounted_kptr, struct btf_struct_meta *meta)
>  {
> -	struct btf_struct_meta *meta = meta__ign;
>  	struct bpf_refcount *ref;
>  
>  	/* Could just cast directly to refcount_t *, but need some code using
> @@ -2379,6 +2397,11 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
>  	return (void *)p__refcounted_kptr;
>  }
>  
> +__bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
> +{
> +	return bpf_refcount_acquire(p__refcounted_kptr, meta__ign);
> +}
> +
>  static int __bpf_list_add(struct bpf_list_node_kern *node,
>  			  struct bpf_list_head *head,
>  			  bool tail, struct btf_record *rec, u64 off)
> @@ -2406,24 +2429,38 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
>  	return 0;
>  }
>  
> +__bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
> +				    struct bpf_list_node *node,
> +				    struct btf_struct_meta *meta,
> +				    u64 off)
> +{
> +	struct bpf_list_node_kern *n = (void *)node;
> +
> +	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
> +}
> +
>  __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>  					 struct bpf_list_node *node,
>  					 void *meta__ign, u64 off)
> +{
> +	return bpf_list_push_front(head, node, meta__ign, off);
> +}
> +
> +__bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
> +				   struct bpf_list_node *node,
> +				   struct btf_struct_meta *meta,
> +				   u64 off)
>  {
>  	struct bpf_list_node_kern *n = (void *)node;
> -	struct btf_struct_meta *meta = meta__ign;
>  
> -	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
> +	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
>  }
>  
>  __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  					struct bpf_list_node *node,
>  					void *meta__ign, u64 off)
>  {
> -	struct bpf_list_node_kern *n = (void *)node;
> -	struct btf_struct_meta *meta = meta__ign;
> -
> -	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
> +	return bpf_list_push_back(head, node, meta__ign, off);
>  }
>  
>  static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
> @@ -2535,16 +2572,24 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
>  	return 0;
>  }
>  
> -__bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
> -				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
> -				    void *meta__ign, u64 off)
> +__bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
> +			       struct bpf_rb_node *node,
> +			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
> +			       struct btf_struct_meta *meta,
> +			       u64 off)
>  {
> -	struct btf_struct_meta *meta = meta__ign;
>  	struct bpf_rb_node_kern *n = (void *)node;
>  
>  	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
>  }
>  
> +__bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
> +				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
> +				    void *meta__ign, u64 off)
> +{
> +	return bpf_rbtree_add(root, node, less, meta__ign, off);
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
>  {
>  	struct rb_root_cached *r = (struct rb_root_cached *)root;
> @@ -4536,12 +4581,19 @@ BTF_KFUNCS_START(generic_btf_ids)
>  #ifdef CONFIG_CRASH_DUMP
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
> +BTF_ID_FLAGS(func, bpf_obj_new, KF_ACQUIRE | KF_RET_NULL | KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_percpu_obj_new, KF_ACQUIRE | KF_RET_NULL | KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_percpu_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_refcount_acquire, KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
> +BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> @@ -4550,6 +4602,7 @@ BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_rbtree_add, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
>  BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..25d0564de6bc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12368,7 +12368,8 @@ enum {
>  	KF_ARG_RES_SPIN_LOCK_ID,
>  	KF_ARG_TASK_WORK_ID,
>  	KF_ARG_PROG_AUX_ID,
> -	KF_ARG_TIMER_ID
> +	KF_ARG_TIMER_ID,
> +	KF_ARG_BTF_STRUCT_META,
>  };
>  
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -12382,6 +12383,7 @@ BTF_ID(struct, bpf_res_spin_lock)
>  BTF_ID(struct, bpf_task_work)
>  BTF_ID(struct, bpf_prog_aux)
>  BTF_ID(struct, bpf_timer)
> +BTF_ID(struct, btf_struct_meta)
>  
>  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
>  				    const struct btf_param *arg, int type)
> @@ -12472,6 +12474,30 @@ static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID);
>  }
>  
> +/*
> + * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
> + *   - the _impl prototype with full arg list (this is meta->func_proto)
> + *   - the BPF API prototype w/o implicit args (func->type in BTF)
> + * To determine whether an argument is implicit, we compare its position
> + * against the number of arguments of both prototypes.
> + */
> +static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
> +{
> +	const struct btf_type *func, *func_proto;
> +	u32 argn, full_argn;
> +
> +	if (!(meta->kfunc_flags & KF_IMPLICIT_ARGS))
> +		return false;
> +
> +	full_argn = btf_type_vlen(meta->func_proto);
> +
> +	func = btf_type_by_id(meta->btf, meta->func_id);
> +	func_proto = btf_type_by_id(meta->btf, func->type);
> +	argn = btf_type_vlen(func_proto);
> +
> +	return argn <= arg_idx && arg_idx < full_argn;
The `arg_idx < full_argn` condition is not necessary, is it?
arg_idx is always less than full_argn because full_argn is the number of
arguments in the _impl variant of the function, which is supposed to be
greater than non-_impl variant that arg_idx tracks.
arg_idx >= full_argn is an invariant violation, not the implicit
argument condition, if I understand this right.

The rest of the refactoring looks good to me.
> +}
> +
>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>  static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>  					const struct btf *btf,
> @@ -12594,6 +12620,14 @@ enum special_kfunc_type {
>  	KF_bpf_session_is_return,
>  	KF_bpf_stream_vprintk,
>  	KF_bpf_stream_print_stack,
> +	KF_bpf_obj_new,
> +	KF_bpf_percpu_obj_new,
> +	KF_bpf_obj_drop,
> +	KF_bpf_percpu_obj_drop,
> +	KF_bpf_refcount_acquire,
> +	KF_bpf_list_push_front,
> +	KF_bpf_list_push_back,
> +	KF_bpf_rbtree_add,
>  };
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12674,6 +12708,58 @@ BTF_ID(func, bpf_arena_reserve_pages)
>  BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
> +BTF_ID(func, bpf_obj_new)
> +BTF_ID(func, bpf_percpu_obj_new)
> +BTF_ID(func, bpf_obj_drop)
> +BTF_ID(func, bpf_percpu_obj_drop)
> +BTF_ID(func, bpf_refcount_acquire)
> +BTF_ID(func, bpf_list_push_front)
> +BTF_ID(func, bpf_list_push_back)
> +BTF_ID(func, bpf_rbtree_add)
> +
> +static bool is_bpf_obj_new_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_obj_new] ||
> +	       func_id == special_kfunc_list[KF_bpf_obj_new_impl];
> +}
> +
> +static bool is_bpf_percpu_obj_new_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_percpu_obj_new] ||
> +	       func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl];
> +}
> +
> +static bool is_bpf_obj_drop_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_obj_drop] ||
> +	       func_id == special_kfunc_list[KF_bpf_obj_drop_impl];
> +}
> +
> +static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_percpu_obj_drop] ||
> +	       func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl];
> +}
> +
> +static bool is_bpf_refcount_acquire_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_refcount_acquire] ||
> +	       func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
> +}
> +
> +static bool is_bpf_list_push_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_list_push_front] ||
> +	       func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> +	       func_id == special_kfunc_list[KF_bpf_list_push_back] ||
> +	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
> +}
> +
> +static bool is_bpf_rbtree_add_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_rbtree_add] ||
> +	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
> +}
>  
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
> @@ -12683,10 +12769,8 @@ static bool is_task_work_add_kfunc(u32 func_id)
>  
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> -	if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
> -	    meta->arg_owning_ref) {
> +	if (is_bpf_refcount_acquire_kfunc(meta->func_id) && meta->arg_owning_ref)
>  		return false;
> -	}
>  
>  	return meta->kfunc_flags & KF_RET_NULL;
>  }
> @@ -13074,8 +13158,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
>  
>  static bool is_bpf_list_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	return is_bpf_list_push_kfunc(btf_id) ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
> @@ -13084,7 +13167,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> +	return is_bpf_rbtree_add_kfunc(btf_id) ||
>  	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
>  	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
>  	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
> @@ -13101,8 +13184,9 @@ static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
>  
>  static bool is_bpf_graph_api_kfunc(u32 btf_id)
>  {
> -	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id) ||
> -	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
> +	return is_bpf_list_api_kfunc(btf_id) ||
> +	       is_bpf_rbtree_api_kfunc(btf_id) ||
> +	       is_bpf_refcount_acquire_kfunc(btf_id);
>  }
>  
>  static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
> @@ -13135,7 +13219,7 @@ static bool kfunc_spin_allowed(u32 btf_id)
>  
>  static bool is_sync_callback_calling_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
> +	return is_bpf_rbtree_add_kfunc(btf_id);
>  }
>  
>  static bool is_async_callback_calling_kfunc(u32 btf_id)
> @@ -13199,12 +13283,11 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
> +		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
>  		break;
>  	case BPF_RB_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> +		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
>  		break;
> @@ -13421,11 +13504,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		bool is_ret_buf_sz = false;
>  		int kf_arg_type;
>  
> -		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> -
> -		if (is_kfunc_arg_ignore(btf, &args[i]))
> -			continue;
> -
>  		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
>  			/* Reject repeated use bpf_prog_aux */
>  			if (meta->arg_prog) {
> @@ -13437,6 +13515,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>  
> +		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +			continue;
> +
> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> +
>  		if (btf_type_is_scalar(t)) {
>  			if (reg->type != SCALAR_VALUE) {
>  				verbose(env, "R%d is not a scalar\n", regno);
> @@ -13611,13 +13694,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			break;
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>  			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_obj_drop_impl]) {
> -					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
> +				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
> +					verbose(env, "arg#%d expected for bpf_obj_drop()\n", i);
>  					return -EINVAL;
>  				}
>  			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> -					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i);
> +				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
> +					verbose(env, "arg#%d expected for bpf_percpu_obj_drop()\n", i);
>  					return -EINVAL;
>  				}
>  			} else {
> @@ -13743,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				return ret;
>  			break;
>  		case KF_ARG_PTR_TO_RB_NODE:
> -			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +			if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
>  				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  					verbose(env, "arg#%d expected pointer to allocated object\n", i);
>  					return -EINVAL;
> @@ -13980,13 +14063,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  	if (meta->btf != btf_vmlinux)
>  		return 0;
>  
> -	if (meta->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
> -	    meta->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +	if (is_bpf_obj_new_kfunc(meta->func_id) || is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
>  		struct btf_struct_meta *struct_meta;
>  		struct btf *ret_btf;
>  		u32 ret_btf_id;
>  
> -		if (meta->func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
> +		if (is_bpf_obj_new_kfunc(meta->func_id) && !bpf_global_ma_set)
>  			return -ENOMEM;
>  
>  		if (((u64)(u32)meta->arg_constant.value) != meta->arg_constant.value) {
> @@ -14009,7 +14091,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  			return -EINVAL;
>  		}
>  
> -		if (meta->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
>  			if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
>  				verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %d\n",
>  					ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
> @@ -14039,7 +14121,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  		}
>  
>  		struct_meta = btf_find_struct_meta(ret_btf, ret_btf_id);
> -		if (meta->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
>  			if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
>  				verbose(env, "bpf_percpu_obj_new type ID argument must be of a struct of scalars\n");
>  				return -EINVAL;
> @@ -14055,12 +14137,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
>  		regs[BPF_REG_0].btf = ret_btf;
>  		regs[BPF_REG_0].btf_id = ret_btf_id;
> -		if (meta->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl])
> +		if (is_bpf_percpu_obj_new_kfunc(meta->func_id))
>  			regs[BPF_REG_0].type |= MEM_PERCPU;
>  
>  		insn_aux->obj_new_size = ret_t->size;
>  		insn_aux->kptr_struct_meta = struct_meta;
> -	} else if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
> +	} else if (is_bpf_refcount_acquire_kfunc(meta->func_id)) {
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
>  		regs[BPF_REG_0].btf = meta->arg_btf;
> @@ -14226,7 +14308,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (err < 0)
>  		return err;
>  
> -	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
>  		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
>  					 set_rbtree_add_callback_state);
>  		if (err) {
> @@ -14340,9 +14422,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			return err;
>  	}
>  
> -	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta.func_id)) {
>  		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>  		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
>  		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
> @@ -14390,11 +14470,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
>  
>  	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
> -		/* Only exception is bpf_obj_new_impl */
>  		if (meta.btf != btf_vmlinux ||
> -		    (meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl] &&
> -		     meta.func_id != special_kfunc_list[KF_bpf_percpu_obj_new_impl] &&
> -		     meta.func_id != special_kfunc_list[KF_bpf_refcount_acquire_impl])) {
> +		    (!is_bpf_obj_new_kfunc(meta.func_id) &&
> +		     !is_bpf_percpu_obj_new_kfunc(meta.func_id) &&
> +		     !is_bpf_refcount_acquire_kfunc(meta.func_id))) {
>  			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
>  			return -EINVAL;
>  		}
> @@ -14505,8 +14584,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  	} else if (btf_type_is_void(t)) {
>  		if (meta.btf == btf_vmlinux) {
> -			if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
> -			    meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> +			if (is_bpf_obj_drop_kfunc(meta.func_id) ||
> +			    is_bpf_percpu_obj_drop_kfunc(meta.func_id)) {
>  				insn_aux->kptr_struct_meta =
>  					btf_find_struct_meta(meta.arg_btf,
>  							     meta.arg_btf_id);
> @@ -23312,13 +23391,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm = BPF_CALL_IMM(desc->addr);
>  
> -	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
> -	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>  		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>  		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
>  
> -		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && kptr_struct_meta) {
> +		if (is_bpf_percpu_obj_new_kfunc(desc->func_id) && kptr_struct_meta) {
>  			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
>  				     insn_idx);
>  			return -EFAULT;
> @@ -23329,20 +23407,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[2] = addr[1];
>  		insn_buf[3] = *insn;
>  		*cnt = 4;
> -	} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
> -		   desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] ||
> -		   desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
> +	} else if (is_bpf_obj_drop_kfunc(desc->func_id) ||
> +		   is_bpf_percpu_obj_drop_kfunc(desc->func_id) ||
> +		   is_bpf_refcount_acquire_kfunc(desc->func_id)) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>  		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>  
> -		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] && kptr_struct_meta) {
> +		if (is_bpf_percpu_obj_drop_kfunc(desc->func_id) && kptr_struct_meta) {
>  			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
>  				     insn_idx);
>  			return -EFAULT;
>  		}
>  
> -		if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
> -		    !kptr_struct_meta) {
> +		if (is_bpf_refcount_acquire_kfunc(desc->func_id) && !kptr_struct_meta) {
>  			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
>  				     insn_idx);
>  			return -EFAULT;
> @@ -23352,15 +23429,14 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[1] = addr[1];
>  		insn_buf[2] = *insn;
>  		*cnt = 3;
> -	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +	} else if (is_bpf_list_push_kfunc(desc->func_id) ||
> +		   is_bpf_rbtree_add_kfunc(desc->func_id)) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>  		int struct_meta_reg = BPF_REG_3;
>  		int node_offset_reg = BPF_REG_4;
>  
>  		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 5208f650080f..f8a91fa7584f 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1065,6 +1065,7 @@ static bool is_kf_implicit_arg(const struct btf *btf, const struct btf_param *p)
>  {
>  	static const char *const kf_implicit_arg_types[] = {
>  		"bpf_prog_aux",
> +		"btf_struct_meta",
>  	};
>  	const struct btf_type *t;
>  	const char *name;
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> index f2b8eb2ff76f..81813c724fa9 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> @@ -110,7 +110,7 @@ int BPF_PROG(test_array_map_3)
>  }
>  
>  SEC("?fentry.s/bpf_fentry_test1")
> -__failure __msg("arg#0 expected for bpf_percpu_obj_drop_impl()")
> +__failure __msg("arg#0 expected for bpf_percpu_obj_drop()")
>  int BPF_PROG(test_array_map_4)
>  {
>  	struct val_t __percpu_kptr *p;
> @@ -124,7 +124,7 @@ int BPF_PROG(test_array_map_4)
>  }
>  
>  SEC("?fentry.s/bpf_fentry_test1")
> -__failure __msg("arg#0 expected for bpf_obj_drop_impl()")
> +__failure __msg("arg#0 expected for bpf_obj_drop()")
>  int BPF_PROG(test_array_map_5)
>  {
>  	struct val_t *p;
> -- 
> 2.53.0
