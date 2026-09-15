Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B933ACF10
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482280; cv=none; b=YmWnZ8TwZm/jKiDAYrT2ywAKyA/dIiQ5pODrGf5xlD7imQWRt19xx71LQew+rVxxYW/hvKCenKTP4T4lyKnMK3MJtbhPsu4uAhSRuEHlNAGLQ5XFVgn+F/imxNa2B6mcAPbi5ia5C0+BJmE7lHcibhFiKxvGZqqnJRNbfYrYNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482280; c=relaxed/simple;
	bh=sk47XabpCnRkLeI7L8tpv9hFrpywHFOLgc/myNxHOv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LXek3F/wa5Rxr0wM68aHJ5gzLz2prqsDy+8YYlhhbm0KA8sFFK18vHmBtXwrW6kCVIElSAzfl3d1kivKhb4bdounYqG+QGJe+t4CGW4bDHkQedu3GwUjnac0YwR7Hqzq/L7dUQA4/T/hj/0O/bn3Tyu9I7iDH37FE8uL9OQOyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMD+h/LW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMD+h/LW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7671F000FF;
	Tue, 15 Sep 2026 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482278;
	bh=4aQIC4pzFxLKUobhipzqjA0zF98jIHKQ5YVti0Pd3ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMD+h/LWiKC4DNIC0dIrcVY5g5prv55yvARYWCUlvg8yeq1jY8KTm9sHB6ZHXr3Vr
	 urI5mG6pUaWLVGWt+7zRg66xQl+d6tq0KxkfYJxkt7pP8lybr4/rdls7+23aY/ItLt
	 1dZ2q5GQ8TqDGypyA+tvQavttx69LzqPbDvD+uRz0ZOhZ+o4jz0e2AJqPOd1mOngGc
	 8wio1ONS5Nt2Be18WPsWC+ni7hk//gP2iix5p6eXrAt0fajbQXparF3F2AV5veVyjr
	 SGPLejQE+sxOeqQtP0oZOdN1JDfjza8+BtRryFM87SzROZNSLHLSm8yCc6LnAJAx/C
	 1RweygY6jAzFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix generic __uninit kfunc output
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915141004.1196460-2-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
 <20260915141004.1196460-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:24:37 +0000
Message-Id: <20260915142438.4E7671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: UBSAN out-of-bounds and NULL pointer arithmetic in mark_raw_s=
tack()
--

commit fc77f675fb39113d85b64af5b859a8ccdbd2caef
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix generic __uninit kfunc output buffers

This commit updates the verifier to check generic __uninit memory
arguments as write-only, tracking output sizes per argument slot so a call
can initialize multiple buffers, including those passed on the stack. It
reuses helper raw memory handling to record their definite initialization
after validating all arguments.

Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel.o=
rg

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..070ec5daeec33 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9550,6 +9556,33 @@ static int check_func_args(struct bpf_verifier_env=
 *env, struct bpf_call_arg_met
>  	return 0;
>  }
> =20
> +static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_=
arg_meta *meta,
> +			  int insn_idx)
> +{
> +	struct bpf_func_state *caller =3D cur_func(env);
> +	u32 slot;
> +	int i, err;
> +
> +	/*
> +	 * Validate every argument before initializing outputs: an input argume=
nt
> +	 * may alias an output buffer. Use the normal stack-write checks to dis=
card
> +	 * stale spills and preserve the rules for special stack objects.
> +	 */
> +	for (slot =3D 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
> +		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, cur_regs(env), =
slot);

[Severity: High]
Does this unconditional call to get_func_arg_reg() for all MAX_BPF_FUNC_ARGS
slots cause an out-of-bounds or NULL pointer arithmetic issue?

Looking at get_func_arg_reg(), it computes a pointer offset based on the
caller's stack arguments:

kernel/bpf/verifier.c:get_func_arg_reg() {
    ...
    return &caller->stack_arg_regs[arg - MAX_BPF_FUNC_REG_ARGS];
}

Since this loop unconditionally evaluates get_func_arg_reg() for all 12
potential slots (MAX_BPF_FUNC_ARGS), even if meta->arg_raw_mem.size[slot]
is 0, won't this trigger undefined behavior and a UBSAN panic for any
helper or kfunc call where caller->stack_arg_regs is NULL or smaller than
the computed offset?

> +		argno_t argno =3D argno_from_arg(slot + 1);
> +
> +		for (i =3D 0; i < meta->arg_raw_mem.size[slot]; i++) {
> +			err =3D check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
> +					       BPF_WRITE, -1, false, false);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915141004.1196=
460-1-memxor@gmail.com?part=3D1
