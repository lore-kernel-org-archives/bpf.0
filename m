Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC9189B84
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972596; cv=none; b=qmX8Zgl+20pMZewGDsodJEIUpeKnyGpZLJZ5N1UOQZR8uPI58LTiPZ2VpgIuBMRKJPe4lRV5ztLlXxkiZK0S0Ax1dmk4tZdlnckgyCnV21GRhiN0y3fU+pMZfCrBsvIQ3TKNjET5LXzf6zWnCOfwT2jLJ+3XVKroH8RC3e+c/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972596; c=relaxed/simple;
	bh=J7RbolpEg1uGVOzZFW0g9Ri7u8SSzNte0cslS3mdOFo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UyRqxA4DZDWdhgELo5KWBEo37Nd7gBqk7NmBVtwVxtWgMcxgZR5ZNozarGH948zmCYDtG5fSi1xxLCVNveflcbT8nc8SL/IH0Jg57v73BLKXgSG0j6q+52o4c11D4TfN+2mnXaVL7VdhlgvgppfXL+QKCUGg2S7e+MgJt34SpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8pWRBsX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8pWRBsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F2CC19424;
	Sun, 12 Apr 2026 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972596;
	bh=J7RbolpEg1uGVOzZFW0g9Ri7u8SSzNte0cslS3mdOFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=E8pWRBsXcAh32N+ZDzwXOZEcGFaTh/K5Qx4fMhaFUMuO4iWeC2xzJqBQlZrj6DzXW
	 n9lcR5vCADtpkMMxn4zbybBiMcN+gHVGTu6xvuk17FQMB5FbbiKQZFPPh7HNo/Tb3F
	 0mR2CvGagKv+onNP6lOz9BVPj7sDJElkiK1qtJZfDnupO1LMYojg8Xi1cjLb0Ko/4/
	 NtzmjYpxx1s1eKnBkWwEhdgsi1xnqgzMKbc9H3B58omn7dqFcrSoTJnm0aOoGtjRsp
	 Lt2d/17sismOh9jOv7EU4Vw/mxrKFdWtu20TeuOy1ctJsszFBrWkYo+hL70E0bUtGv
	 6awNbprCEIp0w==
Content-Type: multipart/mixed; boundary="===============8066650122947936996=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb0c281e177d56f45d5dee727f92c62031aab6553deeaeb544e5f44f20968bcf@mail.kernel.org>
In-Reply-To: <20260412050015.267072-1-yonghong.song@linux.dev>
References: <20260412050015.267072-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 13/18] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:16 +0000 (UTC)

--===============8066650122947936996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 45987041bb2a..206ffbd9596d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13848,9 +13858,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>
>  	args = (const struct btf_param *)(meta->func_proto + 1);
>  	nargs = btf_type_vlen(meta->func_proto);
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +	if (nargs > MAX_BPF_FUNC_ARGS) {
>  		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
> -			MAX_BPF_FUNC_REG_ARGS);
> +			MAX_BPF_FUNC_ARGS);
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -15152,6 +15198,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			mark_btf_func_reg_size(env, regno, t->size);
>  	}

With nargs now allowed up to MAX_BPF_FUNC_ARGS (12), the existing
mark_btf_func_reg_size loop in check_kfunc_call() iterates beyond
register arguments:

    for (i = 0; i < nargs; i++) {
        u32 regno = i + 1;
        ...
        mark_btf_func_reg_size(env, regno, t->size);
    }

This calls __mark_btf_func_reg_size() with &regs[regno] where
regs is bpf_func_state.regs[MAX_BPF_REG] and MAX_BPF_REG is 11.

For nargs 6-10, the loop incorrectly calls mark_insn_zext() on
callee-saved registers R6-R9 or the frame pointer R10. These
registers are not cleared by the caller-saved register loop above,
so if the BPF program wrote a 32-bit value to R6 before the kfunc
call, mark_insn_zext() would set zext_dst on that unrelated
instruction and clear the register's subreg_def.

For nargs >= 11 (MAX_BPF_FUNC_ARGS is 12), regs[11] is an
out-of-bounds access that overlaps bpf_func_state.callsite.

Should this loop be bounded to register args only, similar to what
v1 of this patch had?

    for (i = 0; i < nargs && i < MAX_BPF_FUNC_REG_ARGS; i++) {

> +	/* Track outgoing stack arg depth for kfuncs with >5 args */
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		struct bpf_func_state *caller = cur_func(env);
> +		struct bpf_subprog_info *caller_info = &env->subprog_info[caller->subprogno];
> +		u16 kfunc_stack_arg_depth = (nargs - MAX_BPF_FUNC_REG_ARGS) * BPF_REG_SIZE;
> +
> +		if (kfunc_stack_arg_depth > caller_info->outgoing_stack_arg_depth)
> +			caller_info->outgoing_stack_arg_depth = kfunc_stack_arg_depth;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============8066650122947936996==--
