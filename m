Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67662264DB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648285; cv=none; b=efPtTwsZfaLSvmTIZix+mn7v/GUpqX/BYF+MltMvz/3Z2hO9h/4XTNkJXmj9jC7FcvK/vQbDRFz39+kYOv3nQyrPw8wLY51xERPKBaZHDMLZvk49AUvNXB0BK3aXTqfNTkAwnwuIPojT2RPUHap83bBeJmdu4zcS/BF6v2dIAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648285; c=relaxed/simple;
	bh=ILUSYvYlywnYHEBKI2FWLzBwtUoU9KPQ3uNqRrD4TRw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S2utZyFHT4wcGBnd8sWDsiWQxXXKGA/58FW1v2yFA4wAJapGs9Y/hNWgFjuGo7TS2SXWRjTKjI0gq8f2b9Gk7ZzZd9EuMK5sqhF1RmyCtIKT4LhkEBgbvXlI8j2l4IyzXpI71EcX02VT/p3+z1vjEB8OjKzvOyMQTyTbzZQyZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CScQRG8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CScQRG8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09491F00A3D;
	Sat,  5 Sep 2026 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648283;
	bh=Roai6mE5d6d+W9LG8LsMBUWkwV937Kfn97grWaAATHM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CScQRG8QYbzIKX1VAYWjpPpey4Piq+J9Cq4E9qZWBS2Rh1jEYjPonVM/s1cbJoGe+
	 g0MDjfHXsEdw9K7WG5Zqd1nj5Hc2swkyhPKRWYOENfHHmlLtV04tEVC8T3r0On4mRT
	 /n1uTYRImMR7GMCaDAZHvNu9O8u62fDkdqqlS+sANhqcEJQcCVvLAkAiTQiLUBbIT+
	 SlfkPCohTOmunNF17Cvb+EW1t/p6mshfs3PTXB4p3aLUg6uwjGLLl0AaMHMCZYmPTh
	 Eqgmlz+fXkJsQ7EoQR9ewPi8pK5V3c8Dlts1s46zWxS00/sgk2ww7rdC79MHMc6Qx9
	 4p6/IJPnYv5Bw==
Content-Type: multipart/mixed; boundary="===============3345345809899800765=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2bc0fc604c11468717d136f444f0a46f4ba716d1a2b5b9371358a8aa5be649d3@mail.kernel.org>
In-Reply-To: <20260905220117.922028-3-ameryhung@gmail.com>
References: <20260905220117.922028-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/22] bpf: Address check_func_arg() arguments by argno
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 22:44:42 +0000 (UTC)

--===============3345345809899800765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> check_func_arg() derives every argument from BPF_REG_1 + arg. That works
> for helpers, which have at most five arguments, but kfunc arguments
> beyond the fifth are passed on the stack.
>
> Switch to the argno_t addressing used by check_kfunc_args(): obtain
> argument state with get_func_arg_reg(), use argno for diagnostics, and
> call check_reg_arg() only when the argument is held in a register. This
> prepares check_func_arg() to be shared with kfunc verification.
>
> There is no functional change for helpers. reg_arg_name() renders their
> register arguments as R%d, so the updated diagnostics remain unchanged.

The changelog lists three edits this patch makes, but only two of them
appear in the diff. The first two changes are present: "obtain argument
state with get_func_arg_reg()" and "use argno for diagnostics" are both
implemented. However, the third change, "call check_reg_arg() only when
the argument is held in a register", is not in this commit.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f49c90beefc5..30e1f7a7553e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8769,10 +8769,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  int insn_idx)
>  {
>  	const struct bpf_func_proto *fn = meta->fn;
> -	u32 regno = BPF_REG_1 + arg;
> -	struct bpf_reg_state *reg = reg_state(env, regno);
> +	struct bpf_func_state *caller = cur_func(env);
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	argno_t argno = argno_from_arg(arg + 1);
> +	struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, arg);
>  	enum bpf_arg_type arg_type = fn->arg_type[arg];
> -	argno_t argno = argno_from_reg(regno);
> +	int regno = reg_from_argno(argno);
>  	enum bpf_reg_type type = reg->type;

[ ... ]

> @@ -8786,9 +8788,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return err;
>
>  	if (arg_type == ARG_ANYTHING) {

check_func_arg() still calls check_reg_arg() unconditionally:

check_func_arg() {
    argno_t argno = argno_from_arg(arg + 1);
    struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, arg);
    enum bpf_arg_type arg_type = fn->arg_type[arg];
    int regno = reg_from_argno(argno);
    ...
    err = check_reg_arg(env, regno, SRC_OP);  /* no guard checking regno >= 0 */
    if (err)
        return err;

The guard that would implement the third changelog item appears 20 commits
later in the same series. Commit a490f49b0c4e ("bpf: Check helper and kfunc
arguments in one path") adds the conditional guard:

-   err = check_reg_arg(env, regno, SRC_OP);
+   if (regno >= 0) {
+       err = check_reg_arg(env, regno, SRC_OP);

with its own changelog explaining it will "skip check_reg_arg() for
stack-passed arguments that check_outgoing_stack_args() already validated."

This matters for the stated goal of preparing check_func_arg() to be shared
with kfunc verification, because the new regno can now be negative.
reg_from_argno() returns -1 for an argno below -MAX_BPF_FUNC_REG_ARGS (for
a stack-passed kfunc argument), and __check_reg_arg() takes a u32 regno and
indexes regs[regno] with no bounds check, so a -1 would become an
out-of-bounds index.

There is no runtime regression at this commit: check_func_arg()'s only
caller is check_helper_call(), whose loop is "for (i = 0; i <
MAX_BPF_FUNC_REG_ARGS; i++)", so arg is always in [0,4] and regno is
always 1..5.

Would it be more accurate to drop the "call check_reg_arg() only when the
argument is held in a register" clause from this commit message, or move it
to the patch that actually implements it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============3345345809899800765==--
