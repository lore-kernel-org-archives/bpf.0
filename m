Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B233485515
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430465; cv=none; b=CmF7TnlDSGwNyL2jXaluyQ1ywDvRelYqrvuk5AH4c7z9iaYfiYBNNTiCFglyRYTpyBc3a8AqTuqto+UvP8DEkdI07067fgecqZtNVE9AIAgczLBroDiZPVgTfxF/mkhfoFj2Ecn3waLtncYYN+eB780A6yua/QATMW/7uxXwWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430465; c=relaxed/simple;
	bh=ze03433GmpAES8btVs3kDXUB6vJ7fGMi4itnAZ61/7M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BLcR5ZUxMq0pjyOMql4e/k0laeVBA47doOQL+eAVdAHx2lDIz1LUTfkBaGapRhMCCeZtXvnPNtFx5rxP4hixOffVCkVLw85xHkJwEIE0DGeltNH+n3+oX4JpAY8DYXa/ePll5sQfbpBzoGNe3EUsG/0q1LcIhLZxyMuwyVAIhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7w1/1/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7w1/1/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE631F00A3A;
	Thu,  3 Sep 2026 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788430451;
	bh=im6MpGOZLGUgV27SC4pFwPLhEUbsGrOnfw/VX1/5XfA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d7w1/1/9pWFFsqwBdJr0kb8q7m2z1wxFU//nDHswkuyNaDoGzE09pl7Ai0gqhuTQx
	 eEmn+TVH3E+u4n1dwhGETPszMY1E+SZzilNBBE54xh3P/WKcWH8ugQVFFt/yWgHBSN
	 UM8NHn5itPSdQM0eGMu8ywxNBZk5vXaL3N8dla498qYvpi75ASsJqyWrTmdk7yQpYV
	 e0SlUGPHGPsFiuXdvKNqvHU4BhnCvYaC18++jD6e245Vxqy/+xc/htv8EFX4kCoQQx
	 tCmV8DD7WaKOCwLAcdYqCMczAUx9qF6fYQPghtH7AEZlP+1z6qkoYbbV1P++zQytPt
	 1OTHbHvncRBMw==
Content-Type: multipart/mixed; boundary="===============7705880716505234125=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec9884fd40996fe0aeaa271e9759e4b7539fea1a12bd08a35c0556f1ec9e47ca@mail.kernel.org>
In-Reply-To: <20260903092039.477827-3-jolsa@kernel.org>
References: <20260903092039.477827-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/3] bpf, x86: Introduce JIT emission context
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,rppt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 10:14:11 +0000 (UTC)

--===============7705880716505234125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5922bb4728aad..ee2ddeba3de10 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -23,6 +23,10 @@
>
>  static bool all_callee_regs_used[4] = {true, true, true, true};
>
> +struct jit_emit_context {
> +	u8 *prog;
> +};
> +

[ ... ]

> @@ -634,27 +597,27 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>  				void *old_addr, void *new_addr)
>  {
>  	const u8 *nop_insn = x86_nops[5];
> +	struct jit_emit_context jit = {};
>  	u8 old_insn[X86_PATCH_SIZE];
>  	u8 new_insn[X86_PATCH_SIZE];
> -	u8 *prog;
>  	int ret;

[ ... ]

> @@ -3486,12 +3361,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
> +	struct jit_emit_context jit_ctx = {}, *jit = &jit_ctx;
>  	void *orig_call = func_addr;
>  	int cookie_off, cookie_cnt;
>  	u8 **branches = NULL;

[ ... ]

> @@ -3850,9 +3729,10 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	return ret;
>  }
>
> -static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
> +static int emit_bpf_dispatcher(struct jit_emit_context *jit, int a, int b, s64 *progs, u8 *image,
> +			       u8 *buf)
>  {
> -	u8 *jg_reloc, *prog = *pprog;
> +	u8 *jg_reloc;
>  	int pivot, err, jg_bytes = 1;

[ ... ]

> @@ -3932,10 +3809,10 @@ static int cmp_ips(const void *a, const void *b)
>
>  int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs)
>  {
> -	u8 *prog = buf;
> +	struct jit_emit_context jit = { .prog = buf };
>
>  	sort(funcs, num_funcs, sizeof(funcs[0]), cmp_ips, NULL);
> -	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
> +	return emit_bpf_dispatcher(&jit, 0, num_funcs - 1, funcs, image, buf);
>  }

This isn't a bug, but would it read more uniformly to use the same
'struct jit_emit_context jit_ctx = {...}, *jit = &jit_ctx;' form in
__bpf_arch_text_poke() and arch_prepare_bpf_dispatcher() too?

Currently __arch_prepare_bpf_trampoline creates both a jit_ctx object
and a jit pointer alias, because EMIT() expands to emit_code_jit(jit,
...) and requires an in-scope pointer literally named 'jit'. The other
two functions declare 'jit' as the struct itself, which works for them
because they only call emit_call/emit_jump/emit_bpf_dispatcher and
never use EMIT() directly.

The inconsistency is invisible until someone adds an EMIT() to
__bpf_arch_text_poke() or arch_prepare_bpf_dispatcher(), at which point
it would fail to build with a confusing message about jit_emit_context
vs jit_emit_context *.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33739511576
--===============7705880716505234125==--
