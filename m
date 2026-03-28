Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469F3491F5
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711248; cv=none; b=dweEvFUtv0Mg1iDMXu0ZTWVH+3yzHuMlMzFEsiyqPGl237tJTiF7iPpa+/ZhoAASmFcx65kodS10cghOQZq+jrEXYXg3kyb5bTFNWD5Md3LmSTeX2oKo46YdWHbWistKqyFh+CM+5HlWA+0KLWv1X8BZyvRk/9WEcE/yEuu4lJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711248; c=relaxed/simple;
	bh=YlVmldUM4ySXMYYQ22OmmL2W6MsB5D2KZUEL9HtgECI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/bLtSoMreG5SzBRH2ARlGbB8g6AzY2JuZnSF5jpzQomOAiv5OlB2dyVMc3fGpz6qXpgRa9rmxNWC5VM1Si/Pxj/RUS2SpvEmj4n4GF6qnislkAdzG8Y3IvLZhCcl3fvn749hBg7pvmpbcFRzD4gnjxX+Gd85gCssLlsGW3+xNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSdDJqWj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSdDJqWj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so4869214a12.0
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711245; x=1775316045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOVQ59AZB53pswcczmapH8Kv6W0EN0CgW4ld++taO5w=;
        b=MSdDJqWjXYvB+1nzZFjF6RZW+I40KzXGLiEFMn63pCZNkITm4g9pHxT1n2PZbUZl+7
         7OPgv9mKjozr6AzXFX2QEG0qLFPW4UQQRyWfjvpODDKPn99NOJfw/BOVOXkIH3xq8d8G
         i+ucl2ASkuBODY6uyL5nIVTElRtAtpqgPG8l7pEIWXhHxz7GXrcVM746FpDcucMs5OZb
         gvGaSzn3T+6kJtQdLvZfkBUoKAEHxG+Ky/bi2yGo1VZe8ITPFueu1JaO9fA0Kkw9CKMw
         UzOCsu+mJv2fvaVDOn4RLOpgIENAAkR4VWyYlOWbhzDcZnNNezKqEqlCSUwfMge/bbbd
         oUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711245; x=1775316045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOVQ59AZB53pswcczmapH8Kv6W0EN0CgW4ld++taO5w=;
        b=QEaDfz9lHU5ILL2HuJT/UcCdSddD/q7l/Z2h8LyIg+lKdg0TLPdE0Co/wAoPvi+N7S
         UahkGtxR349/KRYdZ7VBRN2SQ44/9JlcGZlK52vc6q4cItrM155MRm2pLb2DJi0YssiF
         sbZ+coIzu/x98SZ9KbK5+3npTQncAze+tLEtNGi5JWjzMZsS7wVxCezPhFfmSPIthJX6
         M31yr56esvbwu97SzFvpWv+6OC0yIy5KKu3V68neLXU4deVgIUWp8uk+mugU13zavHFN
         qj+g7Is5X0VpztusmwXOuqFH9zDTSSt8NLS0YT/Sjwyf1FO69bbxVOLaR80WoS1D/+yw
         Jgag==
X-Forwarded-Encrypted: i=1; AJvYcCUvCNu5877PAsT7erw3oVvJfK1BUx28i5S1Q8aOc0AbP769qk32rSLWiN5LUquRS2uMVls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4odWAndyz8+usppJUUROhG81LcMKeHIWPIjVDb/+B/FAb6nr
	UtesNMdesA06l5xwy2+ajsTQwhZrkdmxQ/Zd3JTKyUjwTenBdJf1bAeYQHY2Y3sn
X-Gm-Gg: ATEYQzwuUDD6Xr3e4z/URLWAP845VcjC9eO2fNgBD6/JKq5QVzbxL/v8xUEKL0RBz9b
	mk5QR5y9T2rjXw+MG/rVaGT7rx3xVJC9qz6TVzIVAXhhufgCk4UAOIU15sYyyeNXsMSM7HRdnpt
	ZpIcwvj4gs7Vzeyv+4gG2SyQMalWOXFFJCXsvREcywrNOpwN99LQohEnQj6FhhqndQVdJN4fzV8
	gwXZXXc8H9MDWHwpW5pqH5g2oBL35mjt/YrWo6K+08F2nabspLngrOzMhWLJGPhl4gd2+YJkcit
	qWURwocJLIgXRDfPS2Fj4PolhLzckdNNDIBAQfGJGCnFAX75KW5uDYgNmbVxmHrHUIx1SUpCvlt
	m5yZgCLoH2TQAVEOV8R78zIHkION732iiv3JJxbA43OT4ZBeN4fM+SEK3WRTbAxJxWk6Tm3malA
	0jcnJdeARl1Mpxd9jqr7Mq8VU=
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48727eda549mr106384535e9.17.1774707565111;
        Sat, 28 Mar 2026 07:19:25 -0700 (PDT)
Received: from krava ([2a01:e0a:1057:8840:999:a3d5:618e:57b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm149590505e9.10.2026.03.28.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:19:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 28 Mar 2026 15:19:22 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
Message-ID: <acfjaqJc2QlppL1v@krava>
References: <20260327203241.3365046-1-ihor.solodrai@linux.dev>
 <20260327203241.3365046-2-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327203241.3365046-2-ihor.solodrai@linux.dev>

On Fri, Mar 27, 2026 at 01:32:41PM -0700, Ihor Solodrai wrote:
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
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
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
> 
