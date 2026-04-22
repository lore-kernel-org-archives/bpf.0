Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F52D060B
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839104; cv=none; b=TJK2St0Q1HQeNZKnle4z6pQ140qxz1LkxI90X36ufuoZNBKDW2guWdCPGKxVDkGR+IX1NLPu/PCYB5SZ/eqJHpUFMddkSfgmo+DQMRwPf/W1RzIM37ZXkMmvJXXJAYBp4eGpwGZn2bPjikV0JlqwylNWZjrtfD/LaI3q8xrd47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839104; c=relaxed/simple;
	bh=VkjtJKgWqc/RpMBncouhL0i21sijz6wWxXFbVsi0Xtk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m/vh6wBfITgaJEbOS6AHO1tRxOz77+Ut9X1LIwJ9ec476RAzi4JKudxZ7TjCV4OiJ26IKlTfGLK9Qokk/7qJU0vSc+4MmvFnhUZaALkLaASxMv2jcA4QII7wsfx4CVqKzkrRDih754DAWlTjt4fg+ArJwWDq2LV6NwsBY9tbbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJJn5Cz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJJn5Cz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E21C19425;
	Wed, 22 Apr 2026 06:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776839103;
	bh=VkjtJKgWqc/RpMBncouhL0i21sijz6wWxXFbVsi0Xtk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PJJn5Cz+VX7icHI88sYWFAncSLS0E5DRawCxD8RrQGdgoeB8aLIW55XjiE3lnaT86
	 VJ8AVNcoHDEXpNJQBcKgmxJpXQxmgvNL0ZMBqICZWo+3e+azFH/3GHTQ2WCXSqGWgJ
	 wo/V7sR22PW3x2xU2SLKBTkLZtyqRxs5lFb+IkuOtKkzv2dRazuggPb4YhNFMezmq6
	 jnTRrwR1i4831pyl61y48AUbFc1NbVly3JhjFhE6UN+Q79gzYk1aJF8iPEbHumzcm0
	 l9UQsfYfuOIDhwjP6+LXgGcYYcFP87RpuwYpfHOqGZNosy0d+6tw2z0FXtzaB7WabX
	 Jf928vyQPoYug==
Content-Type: multipart/mixed; boundary="===============4719798464291472339=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25c10a6b1a6f9703f2b2c943ab42245cb9de30d2004eb301d85d9de0ca6ca7b3@mail.kernel.org>
In-Reply-To: <20260422054224.3127905-1-yonghong.song@linux.dev>
References: <20260422054224.3127905-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 7/9] bpf: Prepare verifier logs for upcoming kfunc stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 06:25:03 +0000 (UTC)

--===============4719798464291472339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..d5b4303315dd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>  	 * e.g., in reg_type_str() to generate reg_type string
>  	 */
>  	char tmp_str_buf[TMP_STR_BUF_LEN];
> +	char tmp_arg_name[32];
>  	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>  	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>  	struct bpf_scc_callchain callchain_buf;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c777a294302a..e7f5f0bb499b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -261,6 +261,30 @@ struct bpf_kfunc_meta {
>
>  struct btf *btf_vmlinux;
>
> +typedef struct argno {
> +	int argno;
> +} argno_t;
> +
> +static argno_t argno_from_reg(u32 regno)
> +{
> +	return (argno_t){ .argno = regno };
> +}
> +
> +static argno_t argno_from_arg(u32 arg)
> +{
> +	return (argno_t){ .argno = -arg };
> +}
> +
> +static int reg_from_argno(argno_t a)
> +{
> +	return a.argno >= 0 ? a.argno : -1;
> +}
> +
> +static int arg_from_argno(argno_t a)
> +{
> +	return a.argno < 0 ? -a.argno : -1;
> +}

[ ... ]

> @@ -7026,8 +7068,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
>   */
>  static int check_mem_size_reg(struct bpf_verifier_env *env,
>  			      struct bpf_reg_state *mem_reg,
> -			      struct bpf_reg_state *size_reg, u32 mem_regno,
> -			      u32 size_regno, enum bpf_access_type access_type,
> +			      struct bpf_reg_state *size_reg, argno_t mem_argno,
> +			      argno_t size_argno, enum bpf_access_type access_type,
>  			      bool zero_size_allowed,
>  			      struct bpf_call_arg_meta *meta)
>  {

[ ... ]

> @@ -7052,31 +7094,31 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>  		meta = NULL;
>
>  	if (size_reg->smin_value < 0) {
> -		verbose(env, "R%d min value is negative, either use unsigned or 'var &= const'\n",
> -			size_regno);
> +		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
> +			reg_arg_name(env, size_argno));
>  		return -EACCES;
>  	}
>
>  	if (size_reg->umin_value == 0 && !zero_size_allowed) {
> -		verbose(env, "R%d invalid zero-sized read: u64=[%lld,%lld]\n",
> -			size_regno, size_reg->umin_value, size_reg->umax_value);
> +		verbose(env, "%s invalid zero-sized read: u64=[%lld,%lld]\n",
> +			reg_arg_name(env, size_argno), size_reg->umin_value, size_reg->umax_value);
>  		return -EACCES;
>  	}
>
>  	if (size_reg->umax_value >= BPF_MAX_VAR_SIZ) {
> -		verbose(env, "R%d unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
> -			size_regno);
> +		verbose(env, "%s unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
> +			reg_arg_name(env, size_argno));
>  		return -EACCES;
>  	}
> -	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
> +	err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
>  				      access_type, zero_size_allowed, meta);
>  	if (!err)
> -		err = mark_chain_precision(env, size_regno);
> +		err = mark_chain_precision(env, reg_from_argno(size_argno));
>  	return err;
>  }
                                     ^^^^^^^

Does mark_chain_precision(env, reg_from_argno(size_argno)) properly handle
kfunc size arguments?

Before this patch, check_mem_size_reg() was called with size_regno being a
u32 register number. For kfuncs with KF_ARG_PTR_TO_MEM_SIZE, the pre-patch
call at check_kfunc_args was check_kfunc_mem_size_reg(env, reg, size_reg,
regno, regno+1), passing real register numbers like R2..R5.

After this patch, check_kfunc_args constructs size_argno via
argno_from_arg(i+2) for the size parameter of a KF_ARG_PTR_TO_MEM_SIZE
pair. The argno_from_arg() helper creates a negative encoding (-.argno).
When reg_from_argno(size_argno) is called, it checks a.argno >= 0 and
returns -1 for negative values.

mark_chain_precision(env, -1) then reaches bpf_mark_chain_precision in
backtrack.c, where the "if (regno >= 0)" guard causes it to skip marking
the register, and the subsequent "if (bt_empty(bt)) return 0;" silently
returns success without doing any precision tracking.

For helpers, this works correctly because check_func_arg calls
check_mem_size_reg with argno_from_reg(regno), which produces a non-negative
encoding that reg_from_argno() correctly extracts back to the register
number.

Can you verify whether the loss of precision tracking for kfunc size
registers might cause programs that previously verified to hit the
BPF_COMPLEXITY_LIMIT_INSNS threshold? Kfuncs with __sz/__szk size
arguments are widely used in-tree.

>
>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -			 u32 regno, u32 mem_size)
> +			 argno_t argno, u32 mem_size)
>  {

[ ... ]

> @@ -7157,7 +7199,7 @@ enum {
>   * env->cur_state->active_locks remembers which map value element or allocated
>   * object got locked and clears it after bpf_spin_unlock.
>   */
> -static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int regno, int flags)
> +static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int flags)
>  {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24762480405
--===============4719798464291472339==--
