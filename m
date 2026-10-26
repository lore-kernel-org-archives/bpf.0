Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986804;
	b=oOz9T5sNz8GrAQUjUJ5Rv7XaA5Miar41Vw526QPYwQAcAhntu+cYeleMVjAILq/K2lLq
	 PWQu1//KNmWFXc79FdtyRptN55Um2NdFl/1yyr8zRJm7ADXcwBOG0BZE4G76gmdYysV50
	 lMGpaaNmEQk7KKO6KQ6kkzC02got4vIH+YXHw3bv+braBgheuUVA6kykUi3m4omwGN1Bt
	 I+ZGGf9QpzGyquznyAu1Iz5xGDjVaJx3bSn+YE+uAOg9n4hrB37gbIuJVpDfLJyVkTLny
	 PqIRV8Tzj/CMKZxOe/grXOTd26ytzeiP3qGgvqIt7qE1FchI9q27K6NznpuY5ltXRdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986804;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Z93rlBeGbchKL3yH+VaQZpF9u7QbpirjekmRwfcYck0=;
	b=ALMMs5PO+VbDxGNJrjdkCKrsMOEl/VeoQwTzEPhC0dAk1OnKONNVoDr/MlOrmpoj0fR5
	 NEkDb/XDbsz0GRrJRXfmOxUojWD9UJNnDRpm0c/AJaBknWUs9prbPtJUmqF1alkBj4VyK
	 bOf33XjSl2X+faTu/OTnGPR4KEIXWFyOcHJSO9dJkDJSlf3zMG4rPcyW1plVQNM+wgNaM
	 8y8GWLW5e4sw6AMgBDy4h/c2jglCG6dXVE5/Rlapq8VR7bkiTBzLCB98cfu3MckxdhTvt
	 lwp4s8JWpWNT+r/tiHZHXJUu/KaeMdRzD2WStens7Pl/DPjrLE+XnPYWIjYLXsH8EoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK1Jcxqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A6606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK1Jcxqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF0A1F01825;
	Mon, 26 Oct 2026 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986804;
	bh=Z93rlBeGbchKL3yH+VaQZpF9u7QbpirjekmRwfcYck0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WK1Jcxqy1LBuPVJeYbNT5BeHq6FFC1ImvKn6vu7vKQ72fTOI2j5jnOOK5GLF3e4G+
	 KSZ1WTZBlYSY6YjqpCNTLo0ve5GGsTy2f01fv4TiD8dKBTlgjgsnFGN15bvvj++3N2
	 XwsW7Uj71pQqS/3Px7GMYulpgL3lgxsxgc/ecj080fmem1qPMGE0ZJ8ohrM8xFtMTe
	 HXSTvjGxGIg8/m+QIv4AkcZxJbRTdboSw/rnYCQ48cBid369y3fW9B7QyItoS5GaZ1
	 IdUyB3w9CKSeC0ZQwQXA1LbqoIdBwcOvz2xlEyC1KjUx/kxYz0TGMqFRn2hed9AVJR
	 jYD4xjc1DI4Dw==
Content-Type: multipart/mixed; boundary="===============5795186193844349436=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9416321c938fdfde7bfac100f97951ee580af1bb34e4de442d1150d1cb304424@mail.kernel.org>
In-Reply-To: <20261026025943.404450-55-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-55-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 54/81] bpf: Allow 24 arguments of static subprogs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:24 +0000 (UTC)

--===============5795186193844349436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow 24 arguments of static subprogs

TL;DR:
- BPF_MAX_ARG_IDS (32) may be too small for 24 args; dropped ids could lose a
  returned pointer's parent link, allowing writes to a ringbuf record after
  submit
- MAX_BPF_FUNC_ARGS comment inaccurate for global functions

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2ff1a2c97328..d8cd7c63f157 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1035,13 +1035,20 @@ static_assert(__BPF_RET_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
>  /* The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h
>   *
> - * Also reuse this macro for maximum number of arguments a BPF function
> + * Also reuse this macro for maximum number of arguments a global BPF function
>   * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
>   * stack arg slots. The JIT may map some stack arg slots to registers based
>   * on the native calling convention (e.g., arg 6 to R9 on x86-64).
>   */
>  #define MAX_BPF_FUNC_ARGS 12

The updated comment says a global BPF function can have up to
MAX_BPF_FUNC_ARGS arguments, with args 6-12 passed via stack arg slots.
Is that accurate?

btf_check_arg_slots() rejects any global function with more than 5 slots:

    if (is_global) {
            bpf_log(log,
                    "global function %s() needs %d > %d argument slots, "
                    "stack args not supported\n", ...);
            return -EINVAL;
    }

The commit message table also says "global subprog  5, no change".

MAX_BPF_FUNC_ARGS also remains the limit for the BTF-described arguments of
static subprogs (bpf_subprog_info.args[MAX_BPF_FUNC_ARGS] and the slot checks
in btf_prepare_func_args()).

Could the comment say that kfuncs and trampolines get 12, global subprogs
get 5, and static subprogs get MAX_BPF_STATIC_FUNC_ARGS?

[ ... ]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 41ffe9b694a6..c0227e74899b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -499,7 +499,7 @@ static_assert(MAX_CALL_FRAMES <= (1 << 4));
>  static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
>
>  /* Maximum number of bpf_reg_state objects that can exist at once */
> -#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
> +#define MAX_STACK_ARG_SLOTS (MAX_BPF_STATIC_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
>  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
>  			 MAX_CALL_FRAMES)

With MAX_STACK_ARG_SLOTS going from 7 to 19, can the id renaming for
functions verified on their own run out of room and lose the link between a
returned pointer and its parent object?

The previous patch in the series (0535bc235aed "bpf: Verify programs as a
fixpoint over the control flow graph") added:

    #define BPF_MAX_ARG_IDS         32

    static u32 add_arg_id(const struct bpf_verifier_state *state, u32 *ids,
                          u32 n, u32 id)
    {
            ...
            if (!id || n == BPF_MAX_ARG_IDS || inherited_id(state, id) != id)
                    return n;

collect_arg_ids() adds up to two ids, id and parent_id, for each live R1-R5
and for each of the bpf_in_stack_arg_cnt(sub) stack args.

With 5 + 7 arguments that was at most 24 ids, so the cap of 32 was never
hit.  With 5 + 19 it can be 48, and add_arg_id() silently drops everything
after the 32nd id.

For a dropped id, callee_id() in call_func_on_its_own() does not find it, so
the callee's copy keeps the caller's raw id.  At return, bpf_flow_return()
rebuilds idmap from the same truncated ids[] list, and then:

    reg->id = fresh_id(env, idmap, reg->id);
    reg->parent_id = fresh_id(env, idmap, reg->parent_id);

gives R0 a brand-new id instead of mapping it back to the caller's id.

For parent_id that looks unsafe, because release invalidates children by
matching parent_id (in release_reference(), "if (reg->parent_id == id)
idstack_push(...)").

Consider a caller that holds a ringbuf dynptr D and has a slice S from
bpf_dynptr_data(&D), so S.parent_id == D.id.  D.id is not an acquired-ref
id, so add_arg_id() does not skip it as inherited.

The caller then calls a static subprog with about 22 arguments.
func_is_on_its_own() rejects only PTR_TO_STACK and CONST_PTR_TO_DYNPTR in
stack args, so the arguments can be 16 maybe-null slices from 16 local
dynptrs (id + parent_id each, 32 ids), followed by S as stack arg 17.

If the subprog returns S, R0.parent_id in the caller is a fresh id.  Then
bpf_ringbuf_submit_dynptr(&D) does not invalidate R0, and the program could
write to the ringbuf record after it was submitted.

This cannot happen with 12 arguments, and nothing later in the series
(fcfc283e9ac3..51224d16c11b) changes BPF_MAX_ARG_IDS or add_arg_id().

Should BPF_MAX_ARG_IDS be 2 * MAX_BPF_STATIC_FUNC_ARGS, or should
func_is_on_its_own() refuse the call when collect_arg_ids() hits the cap?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============5795186193844349436==--
