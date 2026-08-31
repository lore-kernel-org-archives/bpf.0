Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538B3E959C
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218773; cv=none; b=n4tYjeWyj4KxqgO8X/PJcP5gmI2eGFOcETz1mKI14ctrsu/ZAl7FiGhO/1gEIM57MzTjBqiEF9jrbjHz+S+N4pmGj/cB8ySBU3zG2FJp0p2DPdldLbtC7BqbkGqTyRgjMV7csRAP3M56l60+3oZ8/vzgl5jiazeuSRFDZu4WX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218773; c=relaxed/simple;
	bh=NfUr8IwNYev2wBGhmJwdF298Adel71EtCymeXaRGmPo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tCB0MzIlx1klqrftlmNCin3O74d1bxS1ZgWE+9+e6L4aLWa7fyPJ2FHqUSQVzE+f9Gx32fpPPXIAtz1DtWRxPd8apRR1+3WiTQRWeTucW6nVaYP0+yQLamz7Ld8AG073UqQE+Cw8vCNGBGXoaEafeXIIkNnVbfgxa/0r3ie2iIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3gNZw72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3gNZw72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870F31F000E9;
	Mon, 31 Aug 2026 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218771;
	bh=XeWedXMyOTO7WEABne4ZSCFMOKQsiv1yalq157uO57I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N3gNZw72Zje19iH5yIl1rucbDKL2EFbEIldJierZxTNP46QLPHUMVJsIjOr/+c55n
	 2pLMTRedbY0/yio9wVIF/XZhowxrLE45VVNjZh5cwm2OmxM1ohvu8CBtcXO1+fFcaN
	 KT/9+q96nMzULo3NmNWoe10oVC0OEEt48z+XabsWaggEGlhWRs5mUZH394eVbURBXi
	 Px/N1xJwYuKyvd+hJ2ycmDOfFKL2qISV46HAeDhnfgVmJjCAufcRtcdxkc44zVkttC
	 emYzoRlD84mH8pwAp6UZO+8fJHncACOcIQJ6+6Tpjd/1TMNbyBgJ5cP2HImP9qkQVR
	 2E82N8ABe0Fgw==
Content-Type: multipart/mixed; boundary="===============0407461669275565627=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <882f92965fedba779d677b2b8600682bb0ea33673121e42b81a430d3a3636745@mail.kernel.org>
In-Reply-To: <20260831223314.89787-2-sidchintamaneni@gmail.com>
References: <20260831223314.89787-2-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test terminal gotox instructions
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,rlmenge@gmail.com,hargar@microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 23:26:10 +0000 (UTC)

--===============0407461669275565627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717b..89067ab7baaa4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -47,6 +47,67 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>
> +SEC("socket")
> +__success __retval(0)
> +__naked void jump_table_terminal_gotox(void)
> +{
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:							\
> +	.quad ret0_%= - socket;					\
> +	.size jt0_%=, 8;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 = *(u64 *)(r0 + 0);					\
> +	goto end_%=;						\
> +ret0_%=:							\
> +	r0 = 0;							\
> +	exit;							\
> +end_%=:							\
> +	.8byte %[gotox_r0];					\
> +"	:
> +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> +					    BPF_REG_0, 0, 0, 0))
> +	: __clobber_all);
> +}
> +
> +static __naked __noinline __used
> +void terminal_gotox_subprog(void)
> +{
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:							\
> +	.quad ret0_%= - .text;					\
> +	.size jt0_%=, 8;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 = *(u64 *)(r0 + 0);					\
> +	goto end_%=;						\
> +ret0_%=:							\
> +	r0 = 0;							\
> +	exit;							\
> +end_%=:							\
> +	.8byte %[gotox_r0];					\
> +"	:
> +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> +					    BPF_REG_0, 0, 0, 0))
> +	: __clobber_all);
> +}

This isn't a bug, but terminal_gotox_subprog() differs from
jump_table_terminal_gotox() above only in the jump-table base symbol
(- .text vs - socket). The file elsewhere factors similar shapes into
macros (DEFINE_SIMPLE_JUMP_TABLE_PROG, DEFINE_INVALID_SIZE_PROG,
DEFINE_JUMP_TABLE_USE_REG). Would a small macro parameterised on the
base read better here?

Also, since libbpf appends the only called subprogram last, this
subprogram's gotox ends up as the final instruction of the whole loaded
program. Would adding a further subprogram after it give coverage of the
fall-through-into-the-next-subprog case that the relaxed check in
check_subprogs() guards?

> +
> +SEC("socket")
> +__success __retval(0)
> +__naked void jump_table_terminal_gotox_subprog(void)
> +{
> +	asm volatile ("						\
> +	call terminal_gotox_subprog;				\
> +	exit;							\
> +"	::: __clobber_all);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33447655511
--===============0407461669275565627==--
