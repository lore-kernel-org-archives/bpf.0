Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4E2CCB5;
	Wed,  7 Oct 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398118; cv=none; b=jxiReUP+9ojQlXzQs+fzZEO33OmdZJrD59fBbVdAs08bFV1KRNDby4bp19FLTvxi31NQPNAxbsFHHiOP8X8+0c9hlEHUuoj4kLznuBB7fnJP62F4kDpAFnH2fBBdDufTur7iLhEyXpOfN0CsZMU3x9tP88vyDuN/LLVye96SLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398118; c=relaxed/simple;
	bh=XGMWTWvVwU7Zg7pRxlSjLqZwzbYgkpw2xESKbCszpi4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Pa+DIVEstl8cph0gaBLg9TA5U/eTFbAfrWeLEnWlzCCxmsrc6nYbvOvyw7/gWVPJiClZb+K0W+NdIcohGbCgr+uqJPJDm4r2ld/dQScRFEnnKSui1DgK/nXca5m7jyO5LVi3d1ksEs3HdKGrP3DBRC+65aA2lPYJuPEbgy1aWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhd25xZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhd25xZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1C31F000FF;
	Wed,  7 Oct 2026 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398117;
	bh=46NfMAGGb6PqZQ5Vgklb65s/ETueXA5/vOFEPvZPUi8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fhd25xZXUbCn8TeVjai/XzGMpv+k78LrR1h23oJH4GVP9MN4ZDVDUX4tEBAb7gqJZ
	 cUX9pYpw62cv18WBtiIq7t6vtfhtEToTLZvVBnZch2Bo64UXl+/Ywc/tkZtyjmISAt
	 CZeVLg8/RjDljcnpTNcNlW90Ubu5+qNyBd0E111LgUzcLCmH54X3XiNu4RguUiNZXQ
	 /JIKW6NeH8ernQa8eWfTXqMW0v54EBvOhZRGMec+yGS0HUVZ2Wy2RZCOtX8lqT705b
	 6WIdyS+DtHhZks4oTay895ONhcnfWayBhgiYv5R0Eps3Q56DkQoiyvmdw+XWmLw5X4
	 iVPwgvMjqDAyw==
Content-Type: multipart/mixed; boundary="===============7069405839763764002=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <090e184cbc019e87c7719897f32c545b5021041dec1e8841a33803c5453d01d7@mail.kernel.org>
In-Reply-To: <20261007174203.37071-1-bestswngs@gmail.com>
References: <20261007174203.37071-1-bestswngs@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Validate stack arg reads against caller state
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,xmei5@asu.edu,bestswngs@gmail.com,co+eada64ce90ecebce@bugs.sh,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  7 Oct 2026 18:35:15 +0000 (UTC)

--===============7069405839763764002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Validate stack arg reads against caller state

TL;DR: Pre-existing, not from this patch: a synchronous callback subprog (e.g.
bpf_loop) with more than 5 args may still read the helper caller's stack arg
slots, so the verifier could accept unsafe reads. Should callbacks be
rejected?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f874979b8d7..a67195aa7ce7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4232,8 +4232,18 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
>  		return -EACCES;
>  	}
>  
> +	if (!vstate->curframe) {
> +		verbose(env, "invalid read from stack arg off %d without caller\n", off);
> +		return -EACCES;
> +	}
> +
>  	caller = vstate->frame[vstate->curframe - 1];
> -	arg = &caller->stack_arg_regs[spi];
> +	arg = bpf_get_spilled_stack_arg(spi, caller);
> +	if (!arg) {
> +		verbose(env, "invalid read from uninitialized stack arg off %d\n", off);
> +		return -EACCES;
> +	}

This isn't introduced by this patch, but the same class of problem looks
like it is still reachable through synchronous callbacks.  Can a callback
subprog still read a stack arg slot that the helper's caller wrote?

Synchronous callbacks (bpf_loop, bpf_for_each_map_elem, user_ringbuf_drain,
callback kfuncs) are verified through push_callback_call() ->
setup_func_entry().  There, frame[curframe - 1] is the frame that called the
helper, and its stack_arg_regs[] still holds whatever it wrote before the
helper call.  check_helper_call() only runs invalidate_outgoing_stack_args()
after push_callback_call() has already copied the state with push_stack().

At runtime the callback is not called by that frame.  bpf_loop() in
kernel/bpf/bpf_iter.c does:

    callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0)

with no stack arguments.  The x86-64 JIT reads incoming arg6 from native r9
and arg7 onwards from [rbp+16...], so the callback would read a caller-saved
register and the helper's own stack frame.

A possible sequence:

  - A static callback whose BTF has more than 5 args gets sub->arg_cnt > 5
    from btf_prepare_func_args().  Nothing restricts callback arg counts.

  - The program writes r11-8/r11-16 (for example a PTR_TO_MAP_VALUE) and
    calls bpf_loop().  The first btf_check_subprog_call() passes
    check_outgoing_stack_args().

  - The register type mismatch on R2 (PTR_TO_FUNC) only marks the callback
    unreliable and returns -EINVAL, which push_callback_call() ignores.

  - In the callback, this passes every check added here:

        r0 = *(u64 *)(r11 + 16)

    spi + 1 <= bpf_in_stack_arg_cnt(), curframe == 1, and
    bpf_get_spilled_stack_arg() finds an initialized slot.

R0 then gets the caller's PTR_TO_MAP_VALUE state while the runtime value
comes from the helper's stack.  bpf_fixup_call_args() is satisfied as long
as the main program also makes one ordinary call to a 7-arg static subprog.

Should check_stack_arg_read() (or push_callback_call()) reject in-stack args
when the current frame is a callback (cur->in_callback_fn), or should
callback subprogs with more than MAX_BPF_FUNC_REG_ARGS args be rejected
outright?

The later commit in the series, b6256658f774, only adds selftests, so it
doesn't appear to address this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37664167673
--===============7069405839763764002==--
