Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4D3839A1
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409965; cv=none; b=ExkXgMpwQlVU1pA7sNGuVXAxPA+wHG1aAdL/SmjYmMDAVgwDIMF7ziejBWr4l1s7yKV70ZAGv/KVZyFICcfGXvHitVCXlrhYnjxnSxJPA+xtlb+gmYq1e8UJNhL5n7tTUCDMteazV4lH9h9QRla37Zr9OzEGxJdV1XVmygj2PLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409965; c=relaxed/simple;
	bh=pxBGJIF1flUnCdORHWoitiu2SpH+jVE2BdYWu9L8ILI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IHyawISZ8G/l5EHHjNjTkemfuAgmFoxdyuzSE4f98RwZZ3762myu0Vi1f5SYuHRPH5GaT4bJops+J2olYXhf2fyZpd3Wdou67Ffq8UmjqH7HBJs9VCMS9cQErzjdEmQ+NHrcBpU/uReQZkz65vjyfI2eOtQIua0NmR9P/9RdRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm557rlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm557rlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C931F00893;
	Mon, 14 Sep 2026 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409963;
	bh=K8yI/VVqwGalSvVMNr/7UUHPkH4dSvNn6dEeDk160c4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hm557rlZf3LEam2u2gZ+cCL+ICV1yGHwNK477ihmBcnhAGUN02gtVv3OlWeQLg5JF
	 XvQ07y3kFZQFj9IqeH9XCNv6pekrW9+Qf4pN0wDqYIMZONb4eDS8eAsFoUFjF+gQrI
	 fSYSJSBzGqppa8GaR3s86KQrI7E6Tn/GMpLDzO4ZZGK/6aGpNMNHrFvAHbiv0wIs1W
	 IXI7ohLuCI7mDmv4WFy55uCH88pR+xS4vWOUiaxtSd8xXS+6jYYxyZ9fc/JrlIkedm
	 Q/g1Bu6tIWvo207evxcBK4SWsytbW3pGvkiRWVw8zxRHCUkT2uxTJTZoBCkxqODvLD
	 njgt/qZ5DY1sg==
Content-Type: multipart/mixed; boundary="===============0792866299318455631=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9e72071befb87bfe1aa000446941f6e682b97ff505a91d6244fd26c58495938@mail.kernel.org>
In-Reply-To: <20260914170326.249953-8-daniel@iogearbox.net>
References: <20260914170326.249953-8-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 07/11] bpf: Retarget indirect jump targets across prologue prepends
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:22 +0000 (UTC)

--===============0792866299318455631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e57af902560c3..8115f307444ad 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4165,7 +4165,7 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
>  int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
>  int bpf_insn_array_ready(struct bpf_map *map);
>  void bpf_insn_array_release(struct bpf_map *map);
> -void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
> +void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
>  void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index aa3fb7b87fb06..e132bd0600c7e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -213,12 +213,18 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
>  }
>  #endif
>
> +enum bpf_patch_mode {
> +	BPF_APPEND,
> +	BPF_PREPEND,
> +};
> +

This isn't a bug, but since BPF_APPEND also covers buffers that prepend
to the original insn (like the BPF_ST_NOSPEC sites where the original
insn is copied to the end of the buffer), would names describing whether
the target index moves be clearer here?

The mode really selects whether the original instruction stays at 'off'
or moves to 'off + len - 1', which is why the BPF_PREPEND sites coincide
exactly with the two adjust_jmp_off() call sites. Something like
BPF_PATCH_KEEP_TARGET vs BPF_PATCH_MOVE_TARGET, or at least
BPF_PATCH_APPEND / BPF_PATCH_PREPEND to match the usual stem pairing in
this subsystem, might read less contradicted by neighbouring APPEND call
sites.

>  /* single env->prog->insni[off] instruction was replaced with the range
>   * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
>   * [0, off) and [off, end) to new locations, so the patched range stays zero
>   */
>  static void adjust_insn_aux_data(struct bpf_verifier_env *env,
> -				 struct bpf_prog *new_prog, u32 off, u32 cnt)
> +				 struct bpf_prog *new_prog, u32 off, u32 cnt,
> +				 enum bpf_patch_mode mode)
>  {

[ ... ]

> @@ -755,7 +769,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
>  						      -subprogs[0].stack_depth);
>  			insn_buf[cnt++] = env->prog->insnsi[0];
> -			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
> +			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
> +							 BPF_PREPEND);
>  			if (!new_prog)
>  				return -ENOMEM;
>  			env->prog = new_prog;
> @@ -778,7 +793,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  			verifier_bug(env, "prologue is too long");
>  			return -EFAULT;
>  		} else if (cnt) {
> -			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
> +			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
> +							 BPF_PREPEND);
>  			if (!new_prog)
>  				return -ENOMEM;

[ ... ]

>    bpf: Retarget indirect jump targets across prologue prepends
>
>    A few patches do not expand in place, they prepend: gen_epilogue and
>    gen_prologue splice their instructions in front of insn 0 in
>    bpf_convert_ctx_accesses(), and bpf_do_misc_fixups() prepends the may_goto
>    counter init at every subprog start.

This isn't a bug, but would the changelog read more precisely if it said
that for the gen_epilogue case, the ctx-save insn is prepended at insn 0,
and that gen_prologue is the one that splices its own instructions there?

In bpf_convert_ctx_accesses() above, when ops->gen_epilogue is present,
the epilogue body is patched in at the BPF_EXIT insn (still BPF_APPEND).
What is actually prepended at insn 0 is the single ctx-saving
'BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1, ...)' plus the copied
insnsi[0]. A reader trying to match the three converted call sites to
the sentence "gen_epilogue and gen_prologue splice their instructions in
front of insn 0" has to re-derive that distinction.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============0792866299318455631==--
