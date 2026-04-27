Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864F3EDAA2;
	Mon, 27 Apr 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315423; cv=none; b=sNM0mHyHmQIT/XomW5Lt8njQU9RCOO7zzVtpCN5B7qzNY0ITa7AhGCt7gQpW/BxBzQegM0ysWYwf03y8IqlvC/beQfX10ZUFARfuLJdjNxUwsv4wYsAGefSxJ20POlZlDc8CAt+jRxXFyYWtpTCvt8sozu859dcB1WZKjkmVAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315423; c=relaxed/simple;
	bh=KcZ3ydS6YTK7lW3taOUCxfr92mDoIz+Xt8XwnfP5m+I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=i5kp1TmpKHmgGNNSKjyD6FlPA7fiEaPVo1ZxxQ2+TmxgsPyhSbw9Wd9O8LyHGDqJdNuRD8qyGBKMqMl+wXEjDClx/P1eeshY70HKT+wM+Reqwf2uT8pPc4+gtaFcw/6tpfkDjpixOo+LVWzPjd5f10X5lTK0YKtTfKI1Q098oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHaIrABb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHaIrABb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE967C2BCB7;
	Mon, 27 Apr 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315423;
	bh=KcZ3ydS6YTK7lW3taOUCxfr92mDoIz+Xt8XwnfP5m+I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FHaIrABbux6D/ddZOZdZn00bbFvkifUlx2S/trm02xCiH4UcaL2BjwNJBvaDiFaR6
	 XqfEmCxXVp5FClD3CqyUU7hmB5oy1nbLXdSZO1nB2o4WhzxL/g9zdqdvsdBoKghIE6
	 lkp7HbXaJ7f6RAuuEVaRcmfnFhH23nSDN43BeAg/YrvnH3bteu52DZREtcjvKKnMi2
	 J6FRqe9ZXL4U9l+FURR7ovuOZyOLpw/3X47FZjbZbwZzNg3inSKWFdnj1LXvITt7wq
	 Fp6vu33isx7bY1vx1wxqAy7ffKaZifwpsac4sgM8MOCZ4Hfk4GWdAot3+UkVWiqOHf
	 zkdsKeFhPyf3w==
Content-Type: multipart/mixed; boundary="===============3585725359997332679=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb7368c6062232b6ad5f9ab1c6a97bc8530566a8b3db5c4deefdd5ea63d31538@mail.kernel.org>
In-Reply-To: <20260427165906.84420-6-kaitao.cheng@linux.dev>
References: <20260427165906.84420-6-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v10 5/8] bpf: Add bpf_list_add to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 18:43:42 +0000 (UTC)

--===============3585725359997332679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2570,6 +2570,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  	return bpf_list_push_back(head, node, meta__ign, off);
>  }
>
> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
> +			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
> +			     u64 off)
> +{
> +	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
> +	struct list_head *prev_ptr = &p->list_head;
> +
> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
> +}
> +

The 'prev' argument is described in the commit message as "must already be
in the list." How can a BPF program obtain such a reference and pass it to
this kfunc?

A node already in the list is tracked by the verifier as a non-owning
reference (PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0).
The typical way to obtain this is via bpf_list_front() or bpf_list_back(),
which return non-owning references.

However, check_kfunc_args() in kernel/bpf/verifier.c handles
KF_ARG_PTR_TO_LIST_NODE by requiring:

    if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
        verbose(env, "%s expected pointer to allocated object\n", ...);
        return -EINVAL;
    }
    if (!reg->ref_obj_id) {
        verbose(env, "allocated object must be referenced\n");
        return -EINVAL;
    }

This check rejects non-owning references. The 'prev' argument in R3 is
typed as struct bpf_list_node *, so the verifier classifies it as
KF_ARG_PTR_TO_LIST_NODE and applies this validation.

Compare with KF_ARG_PTR_TO_RB_NODE, which distinguishes between insertion
(requires owning ref) and other operations (allows non-owning refs):

    case KF_ARG_PTR_TO_RB_NODE:
        if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
            /* owning ref required */
        } else {
            /* non-owning or refcounted allowed */
        }

Without a similar distinction for KF_ARG_PTR_TO_LIST_NODE, is there any
valid BPF register state that satisfies both the verifier check and the
runtime semantics stated in the commit message?

It appears the API only works when 'prev' is an owning reference to a
refcounted object still in the list. This is the pattern used in the
selftests, but it limits the kfunc to a narrow use case that the commit
message does not describe.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10742,6 +10742,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_push_front,
>  	KF_bpf_list_push_back_impl,
>  	KF_bpf_list_push_back,
> +	KF_bpf_list_add,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
>  	KF_bpf_list_del,

[ ... ]

> @@ -10923,7 +10925,8 @@ static bool is_bpf_list_push_kfunc(u32 func_id)
>  	return func_id == special_kfunc_list[KF_bpf_list_push_front] ||
>  	       func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  	       func_id == special_kfunc_list[KF_bpf_list_push_back] ||
> -	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
> +	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	       func_id == special_kfunc_list[KF_bpf_list_add];
>  }
>
>  static bool is_bpf_rbtree_add_kfunc(u32 func_id)
> @@ -19228,8 +19231,11 @@ struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>  		int struct_meta_reg = BPF_REG_3;
>  		int node_offset_reg = BPF_REG_4;
>
> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
> +		/* list_add/rbtree_add have an extra arg (prev/less),
> +		 * so args-to-fixup are in diff regs.
> +		 */
> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add] ||
> +		    is_bpf_rbtree_add_kfunc(desc->func_id)) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772
--===============3585725359997332679==--
