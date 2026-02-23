Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C5229B18
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876762; cv=none; b=pty69W6zm4bGMAEEZq1d7w/5bh87CdFEoep8PURw4h8UtKml0WBYm37i+X1pZYgWp9uiZ+Ojm/EvpZbV+PXZSvCNnN388lMxvStey590ZUmcWxSYbnAPw8org0sDsE/5Kvci1gcvPN3wtZ2HcQ3XCGHbuC2zOcYy8Lzjq3bHLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876762; c=relaxed/simple;
	bh=LKZH4rLNDVKfX+799kna7gl6D5IYVKJO5vtN8T0C0Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hob6hS6K6xjUrV960koHyDjDrITJDQ528wcF6LOeDs2qART3HyhLCs+fj2Rdz2m9H9avcvJkovEuZDlSwyYwIwbfzVRXVEKgHLSqDI7mNqn6gbGhhlnm2cvWEB4b0MZzHB4lf4wazGPYMA9hV4naOe/U/9TjajjT/Hx2swUXSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJNCOEXj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJNCOEXj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48336a6e932so29318765e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771876759; x=1772481559; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=reWcvuR/XFyjD3pBsK+UzihjzP1SBGha0kmQ2nKEypI=;
        b=RJNCOEXjaGazbcX03gebAb3j0WFiOvcqMgQ5FLnMjhdJK9TZY7KWmt85Gs8mOd+xK6
         D2dkejddk5mNLf+2SNMVApxDOPNTuiFpLt7oB1SOEyJ5stFr8yNTZjcSc9I4Af+iujVu
         DyPBh7NftjUoq3oKw1z9/9rU+TYvF0WoYS4DHfa7Fd/GmkF4DpKMcZHD2TS40ZVO3ECh
         G2lAcaJjzbcVrC5OFr3hjxD75+eEMAo3z4NuDZXIllObV20Qh+6haIQWiIz+zkXzFO2l
         i7MzgR/DWHhBZqwciwFkrlwzTxlZO0+EJGUkG2t7S700/6Bt4E/DLVJ1R6xpiuUjpfwe
         U2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876759; x=1772481559;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reWcvuR/XFyjD3pBsK+UzihjzP1SBGha0kmQ2nKEypI=;
        b=CESZcuChbO2IMwhd0NXX4N0j4A+l3/nPyEtJ/VgkDCSHApxw1rmV+q7I34+EZgbMCu
         z62dHYPFYJnVnn3cCEIQC4C7mwL08zlHtcs+pba0b5aCbRrvtMTrOefIzNuuZ8/Hwb9Z
         //YLKFCuhtcovXTyp2ubhXe/XiQSCG9QPH9yqRimNLy/b4jttquX/mK3tXRicqCWCMNj
         zSPnttwH7MUrcLiHFcYbMLUEkgp3TSP9UnMXRfGo0ZjDfOIMF+b68esXFlqtf3xiFCud
         q7nSvRARXLY/uoXtWiyOjXZDOvFVHl0EyqwCUylf/R6XuWgO1vvk3kaaExmVM5Hvc4Q6
         Nvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUpvGC+G63BO5rOk7T7RFOqbjMrJ+Mte4DNvVaM41snAlwpwRK6TcazWjJnEAlV3m3yUlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwId9MjAfAnSe4YgSDdxoFND4mYdc3vethxvHMAsJMQcJE2Yd
	gZZJpvXp/i07/eJfhOEWmZd+2K6mxh4fNN/89IWbhwsOSb5RjwSIqPpA
X-Gm-Gg: ATEYQzyV9EZ1b5akiC1iNfdVcK6SUjJmq1oubEe12XnU585MBTLoFnLdOwVBWQJrsSt
	8pMiV9/13fJAqt7Ed6o9wBwoZmuaQ9eX9p/smDHXCaeLhsge1AGn+dyCQDTCsn++C4WdAnKXhSq
	8NcL0Od34OF8bFajfTLO6ePY5I27GMoi4lA0Q5ONXO49lwu97vSBV/+5KPmQK9CsI53S5tpDzxO
	Bv4aGgh+J0VgcqtwnnePtfE8PDInTo4UVscM7ydN9uj2q5vx/YBxNWay1MJc8NJNEk7pcVrGgU1
	vSC5DyEmlYpWMufeyjdaj9I0qoo+AZPXrEK1cOzQUwxujbuBRsuMenvJZ7pmC3nSOV/pc6EzkQn
	7vxfuUR6VwELSKUJBkMY7bSDLTXEQRY02Em8BIC/Q36BU3otPSbexkR5X36SKoie/Ra5wKbeiRZ
	JhF8xv004UNQugsbWGtN0=
X-Received: by 2002:a05:6000:4009:b0:439:4d46:606 with SMTP id ffacd0b85a97d-4396f178264mr19110072f8f.31.1771876759106;
        Mon, 23 Feb 2026 11:59:19 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:9032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54760sm21542232f8f.35.2026.02.23.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:59:18 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add KF_ACQUIRE and KF_RELEASE
 support for iterators
In-Reply-To: <20260223174659.2749964-2-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
 <20260223174659.2749964-2-puranjay@kernel.org>
Date: Mon, 23 Feb 2026 19:59:18 +0000
Message-ID: <871pibcju1.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> Some iterators hold resources (like mmap_lock in task_vma) that prevent
> sleeping. To allow BPF programs to release such resources mid-iteration
> and call sleepable helpers, the verifier needs to track acquire/release
> semantics on iterator _next pointers.
>
> Repurpose the st->id field on STACK_ITER slots to track the ref_obj_id
> of the pointer returned by _next when the kfunc is annotated with
> KF_ACQUIRE. This is safe because st->id is initialized to 0 by
> __mark_reg_known_zero() in mark_stack_slots_iter() and is not compared
> in stacksafe() for STACK_ITER slots.
>
> The lifecycle is:
>
>   _next (KF_ACQUIRE):
>     - auto-release old ref if st->id != 0
>     - acquire new ref, store ref_obj_id in st->id
>     - DRAINED branch: release via st->id, set st->id = 0
>     - ACTIVE branch: keeps ref, st->id tracks it
>
>   _release (KF_RELEASE + __iter arg):
>     - read st->id, release_reference(), set st->id = 0
>
>   _destroy:
>     - release st->id if non-zero before releasing iterator's own ref
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 61 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2ef00f9b94fe..c693dd663cab 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1038,6 +1038,7 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg);
>  static bool in_rcu_cs(struct bpf_verifier_env *env);
>  
>  static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
> +static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta);
>  
>  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>  				 struct bpf_kfunc_call_arg_meta *meta,
> @@ -1083,6 +1084,23 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +/*
> + * Release the acquired reference tracked by iter_st->id, if any.
> + * Used during auto-release in _next, DRAINED handling, and _destroy.
> + */
> +static int iter_release_acquired_ref(struct bpf_verifier_env *env,
> +				     struct bpf_reg_state *iter_st)
> +{
> +	int err;
> +
> +	if (!iter_st->id)
> +		return 0;
> +	err = release_reference(env, iter_st->id);
> +	if (!err)
> +		iter_st->id = 0;
> +	return err;
> +}
> +
>  static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>  				   struct bpf_reg_state *reg, int nr_slots)
>  {
> @@ -1097,8 +1115,14 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>  		struct bpf_stack_state *slot = &state->stack[spi - i];
>  		struct bpf_reg_state *st = &slot->spilled_ptr;
>  
> -		if (i == 0)
> +		if (i == 0) {
> +			/*
> +			 * Release any outstanding acquired ref tracked by st->id
> +			 * before releasing the iterator's own ref.
> +			 */
> +			WARN_ON_ONCE(iter_release_acquired_ref(env, st));
>  			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
> +		}
>  
>  		__mark_reg_not_init(env, st);
>  
> @@ -8943,6 +8967,8 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
>  		/* remember meta->iter info for process_iter_next_call() */
>  		meta->iter.spi = spi;
>  		meta->iter.frameno = reg->frameno;
> +		if (is_kfunc_release(meta))
> +			meta->release_regno = regno;
>  		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
>  
>  		if (is_iter_destroy_kfunc(meta)) {
> @@ -9178,8 +9204,11 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
>  	/* mark current iter state as drained and assume returned NULL */
>  	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
>  	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
> -
> -	return 0;
> +	/*
> +	 * If _next acquired a ref (KF_ACQUIRE), release it in the DRAINED branch since NULL
> +	 * was returned.
> +	 */
> +	return iter_release_acquired_ref(env, cur_iter);
>  }
>  
>  static bool arg_type_is_mem_size(enum bpf_arg_type type)
> @@ -14197,6 +14226,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  		if (meta.initialized_dynptr.ref_obj_id) {
>  			err = unmark_stack_slots_dynptr(env, reg);
> +		} else if (base_type(reg->type) == PTR_TO_STACK) {
Do we also need to check that corresponding stack slot is iterator?
I see there is is_iter_reg_valid_init() that does that, maybe we can use
it here.
> +			struct bpf_reg_state *iter_st;
> +
> +			iter_st = get_iter_from_state(env->cur_state, &meta);
> +			if (!iter_st->id) {
> +				verbose(env, "no acquired reference to release\n");
> +				return -EINVAL;
> +			}
> +			err = release_reference(env, iter_st->id);
> +			if (!err)
> +				iter_st->id = 0;
>  		} else {
>  			err = release_reference(env, reg->ref_obj_id);
>  			if (err)
> @@ -14274,6 +14314,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>  		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
>  	} else if (btf_type_is_ptr(t)) {
> +		struct bpf_reg_state *iter_acquire_st = NULL;
> +
>  		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
>  		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
>  		if (err) {
> @@ -14356,6 +14398,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  		}
>  		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> +		/*
> +		 * For iterators with KF_ACQUIRE, auto-release the previous iteration's ref before
> +		 * acquiring a new one, and after acquisition track the new ref on the iter slot.
> +		 */
> +		if (is_iter_next_kfunc(&meta) && is_kfunc_acquire(&meta)) {
> +			iter_acquire_st = get_iter_from_state(env->cur_state, &meta);
> +			err = iter_release_acquired_ref(env, iter_acquire_st);
> +			if (err)
> +				return err;
> +		}
>  		if (is_kfunc_acquire(&meta)) {
nit: what if we move is_iter_next_kfunc() check into this block, so that
we have only one place where we check is_kfunc_acquire() in this function?
>  			int id = acquire_reference(env, insn_idx);
>  
> @@ -14368,6 +14420,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			ref_set_non_owning(env, &regs[BPF_REG_0]);
>  		}
>  
> +		if (iter_acquire_st)
> +			iter_acquire_st->id = regs[BPF_REG_0].ref_obj_id;
> +
>  		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  	} else if (btf_type_is_void(t)) {
> -- 
> 2.47.3
