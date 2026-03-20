Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83B3C73F3
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018231; cv=none; b=iBroQeSBDjyCcMF7pNnFEsc71c1uv1g6HMzajQzXCm6fWcw97mK15aLLLu9eEmg9gohlEL8w67avX+4rD7EA0p+iw52oUCHXqx727ViioaQ0Cgr/wGG36ehbBEbknKZjtI/TPHa+S2/EOxEk9Yvg15AD4uYzkPr1Dc441N9OrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018231; c=relaxed/simple;
	bh=9gsE8Qu2AwfEHfou8ag8pU8lDyiV3LFsGrbdMzRddOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yz+Mctr88j889gyWiOwCceWqFsgDbpVWP+dYrm1iEjXVQdplaJZo+MQ3QrBtWKy5Lyjksw0mG9SAQfZ/xRSDo/yiEudYEyBXv9uuiRWkaiKhyYreKDk41p15mMQJdOBh20vHL+kq+EyMftua6VkDyFTcrHD04Jjqv+KEf4AXHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQCxJ9pK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQCxJ9pK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso30209225e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018228; x=1774623028; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Svofh6JIe2hWomBVcmP50hnsxQ2NVseJJ3s2ryWKsDY=;
        b=fQCxJ9pKlPRxUQtQm9zMJVruzRH3VbIgouYRTFAHu96ImH282K9vKSTgam0i/2Tnxz
         V7cF55EuSyfUDD/TRaNGGsrb3U7nQRFuxbmTepbcPfXNSDSihPfJweFVbmaQ+eZ9VK9c
         8bmtC0CzsDqdSL+glpTiz6QiXQAccO6GtKeqdZ7Ih+g5RGYX6M71mPlhj1jfmwKD2p0Y
         spqQIZUGEuFLov7pS7uUdoH8BZDT1+ATGRhW97/wL1k6uJKxIdSyroEQZM95tAxf8Ze4
         fT8Z8OC3nq6/kEzpRQ7gdHSnwZZrgAH8wJACDvfL8TcThGy1h0iTDG3LyWuXcfsAkrYq
         EOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018228; x=1774623028;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Svofh6JIe2hWomBVcmP50hnsxQ2NVseJJ3s2ryWKsDY=;
        b=LPaWf7h7QyvLSTGCd+6FJ24/YKen+pKUF6OKydWEsdOA+oJ6/u5T9SkI+9ha+yBG9I
         2x8gYTNMV/HIQd6qT75QOGycsIOntSgfe83/wcFHVso6vBn9fTQdNiuxrt2OfcaPKIHC
         YcjZnb9JBLXz1Fqs9pqjpAlNwSFTjHRp7UF1+bvcSXmqrYHeu+IV+/g6zkHjOBhQM5zF
         VHLTCCySBMTTA4cAjBE5Xy++tYg2x6Q9khwidBGvCgnia8iJpuMbLXjqIOjr3lrwYR7I
         FN+y7szu4B81q8WhgptC5XKph4NSy+0qfMWenmVzyxjsv5KG3RzPxFTLEdVBgMmroiEM
         pxCQ==
X-Gm-Message-State: AOJu0Ywv8m6ac12rkEMNZ+aqZBNe5adiVIz56s37CUVCITLhLlwLgJWm
	r1orZCN4wGHH2+NmJlx9hs5Y5YxVG8iyqNn2PNXj3gBSbX2tI/KMc3mk
X-Gm-Gg: ATEYQzx/MEGKq0z04dE4Kq75GBnkF1KQj8RoeP3PYy9UajGiPjsw34aLZu+G4euePtl
	OlQ2kcyA0OnHLSq+g2HH5Xt2CfqobI6rXa1wuiy4jdPr5V3d4FxS8pONyXHSdy+S+Q9bbxhx3N7
	Nebl98q3X0MbbAKlvOEnI1Nk9NUIAnJq3sPs/jVqDpjdP1SKI/hiqR2gyd2IJtaRSpqBkhAMXVF
	xExS9rXMgmETPwGvp0r/bCtjOLRgNhThflnCOD3FN8jlwJyNJx8NiDQHq50eStVnZcF7OnwzRYO
	3/FmRTi0TDdpPBAUGcnV8Cg+7aBLjUmWKY2ijeNLOE3D7tZHcPwNuKNHjOqw2aGrPuTzG9Mdiyh
	bvNfuJTkbum6OXZZmIOMg9v3vcT+pI6FJR6/RK7qaiPh3QhfL1LrE/KuxAovn4rKWRyaBXEVLOO
	dZthbduLzyGWo7TA==
X-Received: by 2002:a05:600c:8215:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486fe8e4038mr54171265e9.11.1774018228122;
        Fri, 20 Mar 2026 07:50:28 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:f9f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700649560sm20092825e9.6.2026.03.20.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:50:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
In-Reply-To: <20260318234210.1840295-2-ihor.solodrai@linux.dev>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <20260318234210.1840295-2-ihor.solodrai@linux.dev>
Date: Fri, 20 Mar 2026 14:50:27 +0000
Message-ID: <87wlz6k11o.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> Update selftests to use the new non-_impl kfuncs marked with
> KF_IMPLICIT_ARGS by removing redundant declarations and macros from
> bpf_experimental.h (the new kfuncs are present in the vmlinux.h) and
> updating relevant callsites.
>
> Fix spin_lock verifier-log matching for lock_id_kptr_preserve by
> accepting variable instruction numbers. The calls to kfuncs with
> implicit arguments do not have register moves (e.g. r5 = 0)
> corresponding to dummy arguments anymore, so the order of instructions
> has shifted.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
This patch deletes unnecessary declarations from bpf_experimental.h and
aligns few tests to use non-impl kfuncs.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com> 
>  .../testing/selftests/bpf/bpf_experimental.h  | 156 +-----------------
>  .../selftests/bpf/prog_tests/spin_lock.c      |   5 +-
>  .../selftests/bpf/progs/kptr_xchg_inline.c    |   4 +-
>  3 files changed, 9 insertions(+), 156 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 44466acf8083..2234bd6bc9d3 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -8,156 +8,11 @@
>  
>  #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
>  
> -/* Description
> - *	Allocates an object of the type represented by 'local_type_id' in
> - *	program BTF. User may use the bpf_core_type_id_local macro to pass the
> - *	type ID of a struct in program BTF.
> - *
> - *	The 'local_type_id' parameter must be a known constant.
> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> - *	program to set it.
> - * Returns
> - *	A pointer to an object of the type corresponding to the passed in
> - *	'local_type_id', or NULL on failure.
> - */
> -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> -
> -/* Convenience macro to wrap over bpf_obj_new_impl */
> -#define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
> -
> -/* Description
> - *	Free an allocated object. All fields of the object that require
> - *	destruction will be destructed before the storage is freed.
> - *
> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> - *	program to set it.
> - * Returns
> - *	Void.
> - */
> -extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
> -
> -/* Convenience macro to wrap over bpf_obj_drop_impl */
> -#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
> -
> -/* Description
> - *	Increment the refcount on a refcounted local kptr, turning the
> - *	non-owning reference input into an owning reference in the process.
> - *
> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> - *	program to set it.
> - * Returns
> - *	An owning reference to the object pointed to by 'kptr'
> - */
> -extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
> -
> -/* Convenience macro to wrap over bpf_refcount_acquire_impl */
> -#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
> -
> -/* Description
> - *	Add a new entry to the beginning of the BPF linked list.
> - *
> - *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
> - *	for BPF programs to set them
> - * Returns
> - *	0 if the node was successfully added
> - *	-EINVAL if the node wasn't added because it's already in a list
> - */
> -extern int bpf_list_push_front_impl(struct bpf_list_head *head,
> -				    struct bpf_list_node *node,
> -				    void *meta, __u64 off) __ksym;
> -
> -/* Convenience macro to wrap over bpf_list_push_front_impl */
> -#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
> -
> -/* Description
> - *	Add a new entry to the end of the BPF linked list.
> - *
> - *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
> - *	for BPF programs to set them
> - * Returns
> - *	0 if the node was successfully added
> - *	-EINVAL if the node wasn't added because it's already in a list
> - */
> -extern int bpf_list_push_back_impl(struct bpf_list_head *head,
> -				   struct bpf_list_node *node,
> -				   void *meta, __u64 off) __ksym;
> -
> -/* Convenience macro to wrap over bpf_list_push_back_impl */
> -#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
> -
> -/* Description
> - *	Remove the entry at the beginning of the BPF linked list.
> - * Returns
> - *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
> - */
> -extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
> -
> -/* Description
> - *	Remove the entry at the end of the BPF linked list.
> - * Returns
> - *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
> - */
> -extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
> -
> -/* Description
> - *	Remove 'node' from rbtree with root 'root'
> - * Returns
> - * 	Pointer to the removed node, or NULL if 'root' didn't contain 'node'
> - */
> -extern struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
> -					     struct bpf_rb_node *node) __ksym;
> -
> -/* Description
> - *	Add 'node' to rbtree with root 'root' using comparator 'less'
> - *
> - *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
> - *	for BPF programs to set them
> - * Returns
> - *	0 if the node was successfully added
> - *	-EINVAL if the node wasn't added because it's already in a tree
> - */
> -extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
> -			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
> -			       void *meta, __u64 off) __ksym;
> -
> -/* Convenience macro to wrap over bpf_rbtree_add_impl */
> -#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
> +/* Convenience macro to wrap over bpf_obj_new */
> +#define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
>  
> -/* Description
> - *	Return the first (leftmost) node in input tree
> - * Returns
> - *	Pointer to the node, which is _not_ removed from the tree. If the tree
> - *	contains no nodes, returns NULL.
> - */
> -extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
> -
> -/* Description
> - *	Allocates a percpu object of the type represented by 'local_type_id' in
> - *	program BTF. User may use the bpf_core_type_id_local macro to pass the
> - *	type ID of a struct in program BTF.
> - *
> - *	The 'local_type_id' parameter must be a known constant.
> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> - *	program to set it.
> - * Returns
> - *	A pointer to a percpu object of the type corresponding to the passed in
> - *	'local_type_id', or NULL on failure.
> - */
> -extern void *bpf_percpu_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> -
> -/* Convenience macro to wrap over bpf_percpu_obj_new_impl */
> -#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new_impl(bpf_core_type_id_local(type), NULL))
> -
> -/* Description
> - *	Free an allocated percpu object. All fields of the object that require
> - *	destruction will be destructed before the storage is freed.
> - *
> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
> - *	program to set it.
> - * Returns
> - *	Void.
> - */
> -extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
> +/* Convenience macro to wrap over bpf_percpu_obj_new */
> +#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
>  
>  struct bpf_iter_task_vma;
>  
> @@ -167,9 +22,6 @@ extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __ksym;
>  extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
>  
> -/* Convenience macro to wrap over bpf_obj_drop_impl */
> -#define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
> -
>  /* Description
>   *	Throw a BPF exception from the program, immediately terminating its
>   *	execution and unwinding the stack. The supplied 'cookie' parameter
> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> index 254fbfeab06a..bbe476f4c47d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> @@ -13,8 +13,9 @@ static struct {
>  	const char *err_msg;
>  } spin_lock_fail_tests[] = {
>  	{ "lock_id_kptr_preserve",
> -	  "5: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2) "
> -	  "R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
> +	  "[0-9]\\+: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2)"
> +	  " R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n"
> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
>  	  "R1 type=ptr_ expected=percpu_ptr_" },
>  	{ "lock_id_global_zero",
>  	  "; R1=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
> diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
> index 2414ac20b6d5..ca5943166057 100644
> --- a/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
> +++ b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
> @@ -25,14 +25,14 @@ __naked int kptr_xchg_inline(void)
>  		"if r0 == 0 goto 1f;"
>  		"r1 = r0;"
>  		"r2 = 0;"
> -		"call %[bpf_obj_drop_impl];"
> +		"call %[bpf_obj_drop];"
>  	"1:"
>  		"r0 = 0;"
>  		"exit;"
>  		:
>  		: __imm_addr(ptr),
>  		  __imm(bpf_kptr_xchg),
> -		  __imm(bpf_obj_drop_impl)
> +		  __imm(bpf_obj_drop)
>  		: __clobber_all
>  	);
>  }
> -- 
> 2.53.0
