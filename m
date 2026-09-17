Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22330C632
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625727; cv=none; b=KOivDYeh5+YWhsWni4R71Nd4H6+k1jlOZtl5wfIyxjDTtLQiirLYMDY51LHTQqNFB0U7gWVAMYhf64uf7oOEts4OMzwfZCcvmJ9YjdJhhMrdMx5WYKjSoj82W/cVLa/TkSWdZjLC45dwIxfAkvMqqED9FAlGksrYFQ8nPUGtWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625727; c=relaxed/simple;
	bh=gCS40mH67Tgy4wQVBNiesLUGgMNvt0ESJgPxPs1rQ3g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KG0zb8/avK677T55plmpUzP0hbgBSDLL+LN38nKCf7OmNNVKQpKHU1JUOD82MKplvd8jg/T1TIWJNxd/uJQVi+s7nw4HpM9Ldxv3bH8yeXF2hRZkEsL/NjRMdtGFHZWSRGt/t8zvZwOW06XZEjAyog4Sl3PrCdTgWD/EGQU8F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CElhXjgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CElhXjgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE801F000FF;
	Thu, 17 Sep 2026 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625725;
	bh=kG4JuweHm+wIZm2PC7YKmqf1DYFABGx2nYlzMINc6rE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CElhXjgtRX0gG4DL4yYCBs4AT4z2WeYDt8UyAOoDbWRar5vwiOZyEZchRXBJMaXmL
	 M0KFDB7hSqQ22q6F3oMLdrh5kaixg1DossipkCPnu+CzpHc1UX5DUmr1ge4DTZUVJ7
	 yfjc97a4vGGTtEg8wsKEKY4VvuoJnXQcq2UepJXc1quCYSpx/8dQbFo0ciUH/bN4PE
	 +OZxCkKudGo3+SmFW0BtFV9g4+kia1ConOSF9tEvK+j5tArp/qgsZhA/mu+fkcRpn7
	 S9A/x/35pSLM/raZ5x7mjqWA8irwOjeWEWm+BgeKfY7a68QoyHx6nw1VV2vuDWtdUT
	 GPEDotdqs8THw==
Content-Type: multipart/mixed; boundary="===============3048320597230397391=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <782c696a90a11379ecfc3987c30e4101499ab31c70158ff87d3264973a4a9633@mail.kernel.org>
In-Reply-To: <20260917052000.1589643-2-xyx2021@mail.ustc.edu.cn>
References: <20260917052000.1589643-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Destroy callee-local dynptrs on subprog return
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 06:15:24 +0000 (UTC)

--===============3048320597230397391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..4beca102c11d1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -843,8 +844,34 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
>  	return ref_cnt;
>  }
>
> +static int destroy_dynptrs_on_func_exit(struct bpf_verifier_env *env,
> +					struct bpf_func_state *callee)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +		struct bpf_stack_state *slot = &callee->stack[i];
> +
> +		if (slot->slot_type[0] != STACK_DYNPTR ||
> +		    !slot->spilled_ptr.dynptr.first_slot)
> +			continue;
> +
> +		/*
> +		 * A callee-local dynptr is destroyed when its stack frame goes
> +		 * away. Apply the normal stack-slot teardown so references cannot
> +		 * be lost and slices derived from that dynptr are invalidated.
> +		 */
> +		err = destroy_if_dynptr_stack_slot(env, callee, i, true);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

Does this teardown need to apply to every dynptr in the departing frame?
The invalidation rejects programs that verified before this commit and
are safe at run time.

destroy_if_dynptr_stack_slot() calls release_reference() which
invalidates every register and spilled slot in EVERY frame whose id or
parent_id matches:

kernel/bpf/verifier.c:release_reference() {
    bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
        if (reg->id != id && reg->parent_id != id)
            continue;
        ...
        mark_reg_invalid(env, reg);

A data slice carries parent_id equal to the source dynptr id, so a slice
returned in R0 and already copied into caller->regs[BPF_REG_0] is marked
invalid, and the caller's later dereference fails with "invalid mem
access 'scalar'".

For a dynptr whose data is the callee's own stack (bpf_dynptr_from_mem
over a callee-local buffer) that invalidation is exactly right and is the
UAF the commit fixes.

But for skb/xdp/skb_meta dynptrs, and for BPF_DYNPTR_TYPE_LOCAL dynptrs
created over map-value or ringbuf memory, the slice does not point into
the departing frame. bpf_dynptr_slice() returns pointers into skb linear
data or caller-provided buffers whose lifetime is unaffected by the
subprog returning:

kernel/bpf/helpers.c:bpf_dynptr_slice() {
    case BPF_DYNPTR_TYPE_LOCAL:
    case BPF_DYNPTR_TYPE_RINGBUF:
        return ptr->data + ptr->offset + offset;
    case BPF_DYNPTR_TYPE_SKB:
        if (buffer__nullable)
            return skb_header_pointer(...);
        else
            return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);

Nothing else about such a slice depends on the source dynptr's stack slot
still existing either: packet-change invalidation is driven by the slice
register's own type flags, not by the dynptr.

So the natural idiom

    static __noinline struct ethhdr *slice_in_subprog(struct sk_buff *skb)
    {
        struct bpf_dynptr ptr;
        bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
        return bpf_dynptr_slice(&ptr, 0, NULL, sizeof(struct ethhdr));
    }

loaded before this commit and is rejected after it. The follow-up commit
f0ee00b2958de ("selftests/bpf: Test dynptr teardown on subprog return")
codifies the new rejection as intended in
progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c with __failure
__msg("invalid mem access 'scalar'").

Could the teardown be restricted to dynptrs whose data can live in the
departing frame, or should the changelog call out that skb/xdp and
map-value-backed slices escaping a subprogram are now rejected?

> @@ -11043,6 +11079,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  			bpf_diag_mod_end(env);
>  		}
>  	}
> +	err = destroy_dynptrs_on_func_exit(env, callee);
> +	if (err)
> +		return err;
>
>  	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
>  	 * there function call logic would reschedule callback visit. If iteration

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35185711006
--===============3048320597230397391==--
