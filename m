Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B023D7F0
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931136; cv=none; b=BO7+lgcbqR3H09x7mrFObvoBCZ1HN+dq0sOAJBMfwEzynqrFw3jIVWPzzo8x34Zbze4UpJfh+mw/2aHWiw2rvqnIgv3iyUqlPe7Kuv4GPbX4HpWIJw0RQA3bdX+hQ3cAjcRNV4HciIG3VigcekyzOzgLrkT0PlsoTshr1sRuw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931136; c=relaxed/simple;
	bh=11rVOLfyUm79ptImupz/IUrUqoUhIVM9BwipSeoNYbI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QoxDeyBc3iLkYXBV4SFJffvNmDnp4v/o1UWul9aijuZRwm6djsbx/Rhg6wwQLfjHC+oB3LeQeq6LrE4I2tqcUB6TT/8uxHyCJHgKWBBopVVLxIaQBBxzgCNiZp0o0DuvWsQkFh1d/f6iDTuP5K2SWDIvCEHRtZSM5E6AiAULLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaI1uYI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaI1uYI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF82D1F00A3D;
	Wed,  9 Sep 2026 05:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931134;
	bh=oz3V89L4CNxG8AH8StzHHaTDrobm86S7pgyqVCihZk8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XaI1uYI0Z29vDhPLKr+Ho1rcKjeSp3kSiMo3AqQQkr2DPMMOMp+DeEcEGjmJdos5A
	 k7rtd4nGhYRM0LlrL/61NLNti91cBqV8KD3KPgkTuk2cBcdJAR8dMjezyynBe7aq5b
	 a0PmFY3GwzfHrOl9CvhtrETc+/8o8fNYEKMC0RfEoaw7YULrISS5FXUJELjqiPccBc
	 KrWwjopcbpuGio/0jnkqqcL1vSjAh6Nu6Sg3BsETpnMxhjvphw6atvpn6Ixsgzpvmv
	 rwvWcPy0jkejlmM7UZbH/NwHj/nBLoDjU/LKF08/7k8OZv1V9auhjizRpct7m636mW
	 YbBM/hnkWpBMg==
Content-Type: multipart/mixed; boundary="===============7561841753974121083=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b8b26eae1ccf6a2c32e876a2c2ee5631718e2ae72f923d9ea8047404e8d6be47@mail.kernel.org>
In-Reply-To: <20260909042858.1734125-2-xyx2021@mail.ustc.edu.cn>
References: <20260909042858.1734125-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf 1/2] bpf: Preserve escaped dynptr slice ancestry on subprog return
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 05:18:53 +0000 (UTC)

--===============7561841753974121083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd2..d1e0b1a7d0a3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -800,6 +800,39 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
>  	return ref_cnt;
>  }
>
> +static void reparent_dynptr_slices_on_func_exit(struct bpf_verifier_env *env,
> +						struct bpf_func_state *callee)
> +{
> +	struct bpf_verifier_state *vstate = env->cur_state;
> +	struct bpf_func_state *state;
> +	struct bpf_reg_state *reg;
> +	int i;
> +
> +	for (i = 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +		struct bpf_stack_state *slot = &callee->stack[i];
> +		struct bpf_reg_state *dynptr = &slot->spilled_ptr;
> +
> +		if (slot->slot_type[0] != STACK_DYNPTR ||
> +		    !dynptr->dynptr.first_slot ||
> +		    !dynptr_type_referenced(dynptr->dynptr.type))
> +			continue;
                     ^^^^

Does dynptr_type_referenced() cover all the types that need reparenting?

Looking at mark_stack_slots_dynptr(), parent_id is set for every dynptr
at the start:

    parent_id = ref_obj->id;                       /* all types */
    if (dynptr_type_referenced(type)) {
            id = acquire_reference(env, insn_idx, parent_id);
            parent_id = id;                        /* overwrites for RINGBUF/FILE */
    }

So parent_id is meaningful for any dynptr constructed from a live
reference, but dynptr_type_referenced() only returns true for
BPF_DYNPTR_TYPE_RINGBUF and BPF_DYNPTR_TYPE_FILE.

BPF_DYNPTR_TYPE_SKB can also be constructed from a tracked reference.
In qdisc programs, the skb argument is marked __ref:

    net/sched/bpf_qdisc.c:
    BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
    BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
    ...

And bpf_dynptr_from_skb is in the bpf_qdisc kfunc set, so a program
can do this:

    static __noinline void *get_slice(struct sk_buff *skb, char *buf)
    {
            struct bpf_dynptr d;
            bpf_dynptr_from_skb(skb, 0, &d);       /* d.parent_id = skb ref */
            return bpf_dynptr_slice_rdwr(&d, 0, buf, 14);  /* slice.parent_id = d.id */
    }

    /* in enqueue callback: */
    p = get_slice(skb, buf);                        /* slice escapes in R0 */
    /* prepare_func_exit calls reparent_dynptr_slices_on_func_exit */
    /* but dynptr_type_referenced(SKB) == false, so d.id is not reparented */
    bpf_qdisc_skb_drop(skb, to_free);               /* release_reference(skb_id) cannot reach p */
    if (p) *(char *)p = 1;                          /* still accepted */

Since bpf_dynptr_slice_rdwr() may return the packet data pointer
rather than the caller buffer, the write can land in freed skb memory.

Could the condition use `dynptr->parent_id != 0` instead of
`dynptr_type_referenced(...)` to reparent whenever the dynptr has a
tracked parent, regardless of its type?

> +
> +		/*
> +		 * A callee can spill a slice derived from its local dynptr into
> +		 * the caller's stack. The slice then outlives the dynptr id that
> +		 * links it to the rest of the object tree. Preserve that link by
> +		 * making escaped slices children of the dynptr's parent before
> +		 * the callee frame is freed.
> +		 */
> +		bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> +			if (state == callee || reg->parent_id != dynptr->id ||
> +			    base_type(reg->type) != PTR_TO_MEM)
> +				continue;
> +			reg->parent_id = dynptr->parent_id;
> +		}));
> +	}
> +}
> +
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  				        struct bpf_func_state *state, int spi)
>  {
> @@ -10399,6 +10432,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  		print_verifier_state(env, state, caller->frameno, true);
>  	}
>  	account_processed_insns(env, callee, caller);
> +	reparent_dynptr_slices_on_func_exit(env, callee);
>  	/* clear everything in the callee. In case of exceptional exits using
>  	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
>  	free_func_state(callee);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34312284038
--===============7561841753974121083==--
