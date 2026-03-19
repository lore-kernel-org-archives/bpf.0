Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38E3D3309
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923449; cv=none; b=UhJBU9ACpf2wTJCLCaFQ8ed6ZGd7IYS5iUjmkRRTmW/S4P0G2Q03KnV6tjxMNzraYbj+Zz76gzUvKwegTUS+AORX1QsXiu4qWDIEOH+P8fQ/nng7TEry7O/FpjvCOveXm/ye4BCFBLKIs6fTiua9KGao+aZdWQV4mjULaf8IW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923449; c=relaxed/simple;
	bh=u/Ifje0eO1ZzV9QD4IDodCmsGXY/K/2F8jviRTkIHvI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0BVyHzyp//ElGTk3QB83tBWCgWMoAdJXiRrzTur3FOvXbVi1sry/q9G34sXX7+rmB6lHyEvld8L5/cP5IdA+6cbWEPewfppIEShIuhnhA3fgQGJiEkLIm5nq4yB2E0KrhGLLYFPDbZ+BH9VFT8LF3opPDrIhNTCXzT9RvZArB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed/XvZFf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed/XvZFf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso7931005e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923445; x=1774528245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8plfKOAWuGQ+NX35Q6h330BNFDovRsxVaO/3g06bz+w=;
        b=Ed/XvZFfxIFsicbGRiwEecDCvEQokn6vLcJdHbdkVEYscYCQb3Suw3Gctqabc3leqA
         RGSLIxV7tmyNI6sF9Q4DDnp1lFsLUC04ZXPfavPWEO/KOUytyR5sGVP7KcY/AHB5B0Qp
         bIBjzn8zQiuImoIE/kEzF0RRCcxf8mmphpyY2nc0n4hpzHeG4AqUmWZl1sYFm5qCYFwE
         1GHbUUcaSfUs2zHEMDMSI+F+lFXotzrRIoGcnFishxyPYqWRi6h6CZBK9MclkTdmxysW
         NQuoArO59HRyV0MMlXmM6qxv3bgCaCmSDyi0/hZZjHz7aZPbweawYcZd2BUvk5aYKe75
         2q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923445; x=1774528245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8plfKOAWuGQ+NX35Q6h330BNFDovRsxVaO/3g06bz+w=;
        b=RDJOgVSm3MTBCdxTWQg0AwSM1aUHSAIEumMyLCGccnFPixk99IqMEdRkxBgOX7nR9A
         7DRE6P1coQ15qfLbtIIyvqZlKKEUTYD4asJhym6Y57vQAYJ1yYroPKRBUL+iRBEC6vg1
         rm31abnS3ZvJUEIe3d9XhnHoukKhxZKGIyW/F2hPPzQD9mOCuEPDyjsPMV1PSVQgb3QX
         0rtCyiDfxBsMfoU5iwEiHZbYmilmX3GqYFQSsEsSgHqKy/sJBBHWAORJJs8XTKjNWl27
         WP4eUwGsZjeuVMcV/Jr7UzDdxid7uxb3jsi7vS/7XqqdSRNpbAVleGqdnLByGnYPZ3jM
         YExA==
X-Forwarded-Encrypted: i=1; AJvYcCWA/Mr/iJTsfJtU+c6sp+/VTMJoW04ZGhcIwA4QHhB146Dwu5yFIpWatf9bv10jZtxD28U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbD9QwNLy08mz42YIiE51NPKhh+4d++JPKpy1+yDweyXYVpi+G
	PqUF/vEqp6uoOKAWMmUAyQDqThNxqQ+1ArLaQ1SArkV51u5laOCUdscN
X-Gm-Gg: ATEYQzwsE0Sq7Q7OuSKLI6WpNx/5dmXLIrnbAOvCMEalkM0+IxlEPEEcZlzk+b3Cb16
	GM8EZ1hwSur3mTsL474cVDef2CxvEpAOFbdpJ/wXuhbzBMiKn0/prwR5eoXIbKME1tG/fUhsgVN
	8bgKHtqZXzdn/rnNFyTuhej0ozBGPx7j8Edi+k4rFUi3DERTAwruTpLAjdjhJ2UsC+5i9EsSkcC
	eLsxQ4vfHB9MT9jNpb0TaZWUWlRiXoZmEumV47MpaqdCVB9LDxTaHrAKNOhmUikzmuCXcLu8xGf
	Z4NYWpfujfCYnvDJAQjWNTtOgGQMHGhMRfJaYAZ4F31QaDn0YwVIs760WnQI3/Cs9e2XR4CWAz1
	7JbGaRmZE3rb+HT4+0XesK9s4Uu5AsaB3jAZo+02tjKOjISqWrrpBXz1ocRiVBVCGs13wiICx
X-Received: by 2002:a05:600c:37c4:b0:485:17a7:ba0d with SMTP id 5b1f17b1804b1-486f44704famr120620045e9.32.1773923444407;
        Thu, 19 Mar 2026 05:30:44 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c2911asm65747505e9.3.2026.03.19.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:30:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Mar 2026 13:30:42 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
Message-ID: <abvscsnSAiLLWBTZ@krava>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <20260318234210.1840295-2-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318234210.1840295-2-ihor.solodrai@linux.dev>

On Wed, Mar 18, 2026 at 04:42:10PM -0700, Ihor Solodrai wrote:
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

nit, seems like a shame to remove all the comments which are still
valid, maybe we could leave those externs with comments and just
drop the _impl suffix

jirka
