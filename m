Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6B35A385
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099921; cv=none; b=H3k3uycrLjkbxncINVhqG7Am1PGtKZ5+rWKvgqYiQuG6tKWigX2gWls+6bjrUva6/WmfpohGrceke8NEbQrJpOs6ifHXoI7Ep+g1IaQyjDsW5duhfFHkziLNBsqcs07jlN0098Cf2fwS9yqTI7ft4yVH5ebWLgEkkAhzJ/2KOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099921; c=relaxed/simple;
	bh=i3vGogqgXMKaISHzlofu/93nGEMuUM31uP7ukuFVm+o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nqTaODnOeDSHGU3DJQkb1dBntI9ct6RnBoAwCQ6c/iNmBxJLy4bsOnisDqc8TOoPuHR2IiAvAuRnP6YSgelHaGSLKxHcqOxQ193harPt1V821A6Xa+0063n6brNKHnXtf+8XyLKF9zJfipPZKcUCvlMFCX4sKiPp2OqiKbMhoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ0Fvx+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ0Fvx+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2572FC4CEF7;
	Thu,  2 Apr 2026 03:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099921;
	bh=i3vGogqgXMKaISHzlofu/93nGEMuUM31uP7ukuFVm+o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oQ0Fvx+RezjTrHrjXA9O/H6Wy4LFBt2kj9Rxrm9GSEgy2jGJzMVThfA+sOmmJWJeM
	 Wzfz64/CYUZVo68RbdIx6/J8wIj8I7fLVRumN03r+YLwEezEDpmi28BoNW6IXqeZSo
	 LPp5WvBdEjzDoqBfu1o6eWZArCfnx4321QZ5X2Kki8pNH1PmrIJOvD56g4qdSzhTqk
	 eEgengu6ZyKHHSdH7YeJcKVd6JOyqdAsHn0jOmMODTJStt84kiIm6y6z5DCBtLxuPg
	 Xb4jAV3E+mAmSmaNC26Bh/YDE+wDs6VMjhZvipoOyVNy7UOS9pZQpTNRRPqfAIzu6r
	 h/HKpyhYUKFqg==
Content-Type: multipart/mixed; boundary="===============5041961370142310936=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8e301126ace0672841b6a9f9a8ee1e4dba2f6784817ec4d9ba9489518db3cce@mail.kernel.org>
In-Reply-To: <20260402012747.3918081-1-yonghong.song@linux.dev>
References: <20260402012747.3918081-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 04/10] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Apr 2026 03:18:41 +0000 (UTC)

--===============5041961370142310936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d424fe611ef8..6579156486b8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13687,13 +13694,41 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  	 * verifier sees.
>  	 */
>  	for (i = 0; i < nargs; i++) {
> -		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
> +		struct bpf_reg_state *regs = cur_regs(env), *reg;
> +		struct bpf_reg_state saved_reg;

[ ... ]

> +		if (i < MAX_BPF_FUNC_REG_ARGS) {
> +			reg = &regs[i + 1];
> +		} else {
> +			/*
> +			 * Retrieve the spilled reg state from the stack arg slot.
> +			 * Reuse the existing type checking infrastructure which
> +			 * reads from cur_regs(env)[regno], temporarily copy the
> +			 * stack arg reg state into regs[BPF_REG_1] and restore
> +			 * it after checking.
> +			 */

[ ... ]

> +			is_stack_arg = true;
> +			regno = BPF_REG_1;
> +			saved_reg = regs[BPF_REG_1];
> +			regs[BPF_REG_1] = caller->stack_arg_slots[spi].spilled_ptr;
> +			reg = &regs[BPF_REG_1];
> +		}
> +
>  		if (is_kfunc_arg_prog_aux(btf, &args[i])) {

[ ... ]

> -			continue;
> +			goto next_arg;
>  		}
>
>  		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
>  			continue;

The is_kfunc_arg_prog_aux path above was converted from continue to
goto next_arg so that regs[BPF_REG_1] gets restored via the next_arg
label. The scalar path and the KF_ARG_PTR_TO_NULL path were also
converted the same way.

Should this continue for is_kfunc_arg_ignore/is_kfunc_arg_implicit
also be goto next_arg? When a stack arg (i >= MAX_BPF_FUNC_REG_ARGS)
hits this continue, is_stack_arg is true but the next_arg restore is
skipped, so regs[BPF_REG_1] keeps the spilled pointer from the
current iteration. On the next iteration, saved_reg then captures that
stale value instead of the original register state.

The comment above says "restore it after checking", which this continue
path does not do. The impact is currently masked because each iteration
independently overwrites regs[BPF_REG_1] and the caller_saved clearing
in check_kfunc_call() resets R1 after the loop, but it breaks the
save/restore invariant the rest of this patch establishes.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23879588767
--===============5041961370142310936==--
