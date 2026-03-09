Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689D3E5ED7
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076350; cv=none; b=FnOaxq9ovDa94soRnvib1NnSabc4X9ZRPA3ulBlOLCP1gYQu7ifzNXkdo2flkrfhuXmCic8hPUVc5awFlpw+0wWYx/6Xb5coTLhnvwc+jd7jJWZ5kfAomAntjWhrVutZEYWxlGDYzUlwHSH417ur65ziVyxwNVJ6/di74yRUuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076350; c=relaxed/simple;
	bh=ChhyLcbB9uDL8+YSOt6o/N4evhGatyNnLusn2MsPqxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqkj99xboi4eTOvObmKVERGW47mRW2YRX03JvCuRbgZBluGZX0Dc52JxPEP0SJl7TGQFEFjsrlcvy/vCEOUMaseKQTXMF2QsvmmyoJGCVzoAaOFRG0n0Cwb7bEfxpgvHY1ScH0zt14q70+Qnbj2xDof6x8Jf6M0whN9G8J6F/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASxpHwgi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASxpHwgi"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a1322af04fso5045077e87.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076346; x=1773681146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXQYIhDvvL9OfWzptw6euEoNMcwAFxj917pJAI/SfdY=;
        b=ASxpHwgiBEoNYbx7BDnXxn70nfnMaHwlcF+pgrnrV+Cv89eB944B0OaN1CH86fECqK
         SIhVsLHOArjSAc+MuX+T4h7Q0T6xsWwtk6tHICqcR3aDOUh0ssgTlSTRdN5NCx9SgnWZ
         kdi4j37PPm7CYkOsmhPv7JAWx4EaOCEeqvRJCuoUxyn2SboJRkAkqyFM76C6tWXZtnt/
         sqYKU7DTYPFcPYML+tAZX+kJmonHtzL3PkKK8rvLMYoYznO8KQkvCPapb0u8CzB8iKmn
         /dS+QFtdKvgGfaqIvr8e/br1aqWirXgSyMDiOpCmu92rxjn0H0CgVSDwc1S6AC0Cr3U3
         8IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076346; x=1773681146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXQYIhDvvL9OfWzptw6euEoNMcwAFxj917pJAI/SfdY=;
        b=xUXVzcy9YOpnLr59jZECMs63vK5DeA4sEY8e01IsZh8/XLQyhPNNv7zY19E0lvVqsG
         kdwUsII4hbUYsTNCBp0vmYF303uprNLjWhapfJJ3KZOuccSXD98wBE/4pLw5ZWok/8Zj
         rP/BeOof+ouZnjnFEam36ds6MUC6QA0KH9Al3o2acebINxTZFQUXz5EHRf2hpWJA5O1Z
         52j8oxJuGm4UQSYtz1Z3pbaCmR1Cb5MJezokN8LuGGJxNoqOI5W+ESBxhRbZ9noNK2n2
         76P/6wGuCvbQrAUJF0Fop1CzwPmWnlChyEoBtEfmSpUVFoIspVITPDwBdZn7pKAii2CN
         Zq6Q==
X-Gm-Message-State: AOJu0YyAFgNrJzIhB1K/Lxx2NtnGZ/YyIcMiwiOILG+0SIT5l6lwc2UQ
	RaRBZx2b5Wv1oMji39986cCaeN82yFHm9fzt5VsbR7prjueT7mQDlMLe
X-Gm-Gg: ATEYQzxIW3dWDLeJ9JIBVRkaxrqRUupmiL1/RypSx1/8IgcHSgtruJB/zOXFHnATttG
	MketwQOTOsg0pyS3TIat6PEp5dJk7rjSsGkNVGoa0oFIppb5B1yCa4a8QquvAw7piT2pSblfac7
	lcX5vjk41czxx+o9GJfNFDyww3NbzTvLtXM6Q+hhTkZVOead3CZxOJuJ2R1adfArnKeqCY7ur+1
	FSRF1v8Giq3EcK6NXFesImub4W9opmywI2X3pbvXXLE6+jVNykzvpw7YQ1vakw2ZA/79cT+KUaN
	UlkFD0V3vPWAXKcxw1TWJM5TKGJk8wD3UgAMCir4XHWScO77AHSMQqGWOirBStZvxRGMzkcRiDL
	YfTls5XZBq6KlwcFkte+G5Q4ssiprnmiECO3X1titvkFMemMCVJkZ+WXvW4LvyJViaCzVdmIDuy
	PuMr+9zRQoRzi3ofXU1VW2HHn2gveJMSDyCdLR2jNf2ok=
X-Received: by 2002:a05:6512:1388:b0:5a1:19a7:f922 with SMTP id 2adb3069b0e04-5a13ccf7787mr5284630e87.29.1773076345043;
        Mon, 09 Mar 2026 10:12:25 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13ea86499sm2063465e87.48.2026.03.09.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:12:23 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:20:55 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to
 verifier
Message-ID: <aa8Bd0GQdEj960iP@mail.gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-2-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-2-xukuohai@huaweicloud.com>

On 26/03/09 10:00PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> During the JIT stage, constants blinding rewrites instructions but only
> rewrites the private instruction copy of the JITed subprog, leaving the
> global instructions and insn_aux_data unchanged. This causes a mismatch
> between subprog instructions and the global state, making it difficult
> to look up the global insn_aux_data in the JIT.
> 
> To avoid this mismatch, and given that all arch-specific JITs already
> support constants blinding, move it to the generic verifier code, and
> switch to rewrite the global env->insnsi with the global states
> adjusted, as other rewrites in the verifier do.
> 
> This removes the constant blinding calls in each JIT, which are largely
> duplicated code across architectures.
> 
> And the prog clone functions and insn_array adjustment for the JIT
> constant blinding are no longer needed, remove them too.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arc/net/bpf_jit_core.c      | 20 +------
>  arch/arm/net/bpf_jit_32.c        | 41 +++----------
>  arch/arm64/net/bpf_jit_comp.c    | 71 +++++++----------------
>  arch/loongarch/net/bpf_jit.c     | 56 +++++-------------
>  arch/mips/net/bpf_jit_comp.c     | 20 +------
>  arch/parisc/net/bpf_jit_core.c   | 38 +++---------
>  arch/powerpc/net/bpf_jit_comp.c  | 45 ++++-----------
>  arch/riscv/net/bpf_jit_core.c    | 45 ++++-----------
>  arch/s390/net/bpf_jit_comp.c     | 41 +++----------
>  arch/sparc/net/bpf_jit_comp_64.c | 41 +++----------
>  arch/x86/net/bpf_jit_comp.c      | 40 ++-----------
>  arch/x86/net/bpf_jit_comp32.c    | 33 ++---------
>  include/linux/filter.h           | 11 +++-
>  kernel/bpf/core.c                | 99 +++++---------------------------
>  kernel/bpf/verifier.c            | 19 +++---
>  15 files changed, 127 insertions(+), 493 deletions(-)
> 
> diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
> index 1421eeced0f5..12facf5750da 100644
> --- a/arch/arc/net/bpf_jit_core.c
> +++ b/arch/arc/net/bpf_jit_core.c
> @@ -79,7 +79,6 @@ struct arc_jit_data {
>   * The JIT pertinent context that is used by different functions.
>   *
>   * prog:		The current eBPF program being handled.
> - * orig_prog:		The original eBPF program before any possible change.
>   * jit:			The JIT buffer and its length.
>   * bpf_header:		The JITed program header. "jit.buf" points inside it.
>   * emit:		If set, opcodes are written to memory; else, a dry-run.
> @@ -94,12 +93,10 @@ struct arc_jit_data {
>   * need_extra_pass:	A forecast if an "extra_pass" will occur.
>   * is_extra_pass:	Indicates if the current pass is an extra pass.
>   * user_bpf_prog:	True, if VM opcodes come from a real program.
> - * blinded:		True if "constant blinding" step returned a new "prog".
>   * success:		Indicates if the whole JIT went OK.
>   */
>  struct jit_context {
>  	struct bpf_prog			*prog;
> -	struct bpf_prog			*orig_prog;
>  	struct jit_buffer		jit;
>  	struct bpf_binary_header	*bpf_header;
>  	bool				emit;
> @@ -114,7 +111,6 @@ struct jit_context {
>  	bool				need_extra_pass;
>  	bool				is_extra_pass;
>  	bool				user_bpf_prog;
> -	bool				blinded;
>  	bool				success;
>  };
>  
> @@ -161,13 +157,7 @@ static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
>  {
>  	memset(ctx, 0, sizeof(*ctx));
>  
> -	ctx->orig_prog = prog;
> -
> -	/* If constant blinding was requested but failed, scram. */
> -	ctx->prog = bpf_jit_blind_constants(prog);
> -	if (IS_ERR(ctx->prog))
> -		return PTR_ERR(ctx->prog);
> -	ctx->blinded = (ctx->prog != ctx->orig_prog);
> +	ctx->prog = prog;
>  
>  	/* If the verifier doesn't zero-extend, then we have to do it. */
>  	ctx->do_zext = !ctx->prog->aux->verifier_zext;
> @@ -214,14 +204,6 @@ static inline void maybe_free(struct jit_context *ctx, void **mem)
>   */
>  static void jit_ctx_cleanup(struct jit_context *ctx)
>  {
> -	if (ctx->blinded) {
> -		/* if all went well, release the orig_prog. */
> -		if (ctx->success)
> -			bpf_jit_prog_release_other(ctx->prog, ctx->orig_prog);
> -		else
> -			bpf_jit_prog_release_other(ctx->orig_prog, ctx->prog);
> -	}
> -
>  	maybe_free(ctx, (void **)&ctx->bpf2insn);
>  	maybe_free(ctx, (void **)&ctx->jit_data);
>  
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454..e6b1bb2de627 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2144,9 +2144,7 @@ bool bpf_jit_needs_zext(void)
>  
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	struct bpf_binary_header *header;
> -	bool tmp_blinded = false;
>  	struct jit_ctx ctx;
>  	unsigned int tmp_idx;
>  	unsigned int image_size;
> @@ -2156,20 +2154,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * the interpreter.
>  	 */
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	/* If constant blinding was enabled and we failed during blinding
> -	 * then we must fall back to the interpreter. Otherwise, we save
> -	 * the new JITed code.
> -	 */
> -	tmp = bpf_jit_blind_constants(prog);
> -
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	memset(&ctx, 0, sizeof(ctx));
>  	ctx.prog = prog;
> @@ -2179,10 +2164,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * we must fall back to the interpreter
>  	 */
>  	ctx.offsets = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
> -	if (ctx.offsets == NULL) {
> -		prog = orig_prog;
> -		goto out;
> -	}
> +	if (ctx.offsets == NULL)
> +		return prog;
>  
>  	/* 1) fake pass to find in the length of the JITed code,
>  	 * to compute ctx->offsets and other context variables
> @@ -2194,10 +2177,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * being successful in the second pass, so just fall back
>  	 * to the interpreter.
>  	 */
> -	if (build_body(&ctx)) {
> -		prog = orig_prog;
> +	if (build_body(&ctx))
>  		goto out_off;
> -	}
>  
>  	tmp_idx = ctx.idx;
>  	build_prologue(&ctx);
> @@ -2213,10 +2194,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.idx += ctx.imm_count;
>  	if (ctx.imm_count) {
>  		ctx.imms = kcalloc(ctx.imm_count, sizeof(u32), GFP_KERNEL);
> -		if (ctx.imms == NULL) {
> -			prog = orig_prog;
> +		if (ctx.imms == NULL)
>  			goto out_off;
> -		}
>  	}
>  #else
>  	/* there's nothing about the epilogue on ARMv7 */
> @@ -2238,10 +2217,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	/* Not able to allocate memory for the structure then
>  	 * we must fall back to the interpretation
>  	 */
> -	if (header == NULL) {
> -		prog = orig_prog;
> +	if (header == NULL)
>  		goto out_imms;
> -	}
>  
>  	/* 2.) Actual pass to generate final JIT code */
>  	ctx.target = (u32 *) image_ptr;
> @@ -2278,16 +2255,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  #endif
>  out_off:
>  	kfree(ctx.offsets);
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
> +
>  	return prog;
>  
>  out_free:
>  	image_ptr = NULL;
>  	bpf_jit_binary_free(header);
> -	prog = orig_prog;
>  	goto out_imms;
>  }
>  
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index adf84962d579..566809be4a02 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2006,17 +2006,22 @@ struct arm64_jit_data {
>  	struct jit_ctx ctx;
>  };
>  
> +static void clear_jit_state(struct bpf_prog *prog)
> +{
> +	prog->bpf_func = NULL;
> +	prog->jited = 0;
> +	prog->jited_len = 0;
> +}
> +
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>  	int image_size, prog_size, extable_size, extable_align, extable_offset;
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	struct bpf_binary_header *header;
>  	struct bpf_binary_header *ro_header = NULL;
>  	struct arm64_jit_data *jit_data;
>  	void __percpu *priv_stack_ptr = NULL;
>  	bool was_classic = bpf_prog_was_classic(prog);
>  	int priv_stack_alloc_sz;
> -	bool tmp_blinded = false;
>  	bool extra_pass = false;
>  	struct jit_ctx ctx;
>  	u8 *image_ptr;
> @@ -2025,26 +2030,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	int exentry_idx;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	/* If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return prog;
>  		prog->aux->jit_data = jit_data;
>  	}
>  	priv_stack_ptr = prog->aux->priv_stack_ptr;
> @@ -2056,10 +2048,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
>  				      2 * PRIV_STACK_GUARD_SZ;
>  		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 16, GFP_KERNEL);
> -		if (!priv_stack_ptr) {
> -			prog = orig_prog;
> +		if (!priv_stack_ptr)
>  			goto out_priv_stack;
> -		}
>  
>  		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
>  		prog->aux->priv_stack_ptr = priv_stack_ptr;
> @@ -2079,10 +2069,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.prog = prog;
>  
>  	ctx.offset = kvzalloc_objs(int, prog->len + 1);
> -	if (ctx.offset == NULL) {
> -		prog = orig_prog;
> +	if (ctx.offset == NULL)
>  		goto out_off;
> -	}
>  
>  	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>  	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
> @@ -2095,15 +2083,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * BPF line info needs ctx->offset[i] to be the offset of
>  	 * instruction[i] in jited image, so build prologue first.
>  	 */
> -	if (build_prologue(&ctx, was_classic)) {
> -		prog = orig_prog;
> +	if (build_prologue(&ctx, was_classic))
>  		goto out_off;
> -	}
>  
> -	if (build_body(&ctx, extra_pass)) {
> -		prog = orig_prog;
> +	if (build_body(&ctx, extra_pass))
>  		goto out_off;
> -	}
>  
>  	ctx.epilogue_offset = ctx.idx;
>  	build_epilogue(&ctx, was_classic);
> @@ -2121,10 +2105,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
>  					      sizeof(u64), &header, &image_ptr,
>  					      jit_fill_hole);
> -	if (!ro_header) {
> -		prog = orig_prog;
> +	if (!ro_header)
>  		goto out_off;
> -	}
>  
>  	/* Pass 2: Determine jited position and result for each instruction */
>  
> @@ -2152,10 +2134,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	/* Dont write body instructions to memory for now */
>  	ctx.write = false;
>  
> -	if (build_body(&ctx, extra_pass)) {
> -		prog = orig_prog;
> +	if (build_body(&ctx, extra_pass))
>  		goto out_free_hdr;
> -	}
>  
>  	ctx.epilogue_offset = ctx.idx;
>  	ctx.exentry_idx = exentry_idx;
> @@ -2164,19 +2144,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  
>  	/* Pass 3: Adjust jump offset and write final image */
>  	if (build_body(&ctx, extra_pass) ||
> -		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
> -		prog = orig_prog;
> +		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset))
>  		goto out_free_hdr;
> -	}
>  
>  	build_epilogue(&ctx, was_classic);
>  	build_plt(&ctx);
>  
>  	/* Extra pass to validate JITed code. */
> -	if (validate_ctx(&ctx)) {
> -		prog = orig_prog;
> +	if (validate_ctx(&ctx))
>  		goto out_free_hdr;
> -	}
>  
>  	/* update the real prog size */
>  	prog_size = sizeof(u32) * ctx.idx;
> @@ -2193,15 +2169,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
>  			pr_err_once("multi-func JIT bug %d > %d\n",
>  				    ctx.idx, jit_data->ctx.idx);
> -			prog->bpf_func = NULL;
> -			prog->jited = 0;
> -			prog->jited_len = 0;
> +			clear_jit_state(prog);
>  			goto out_free_hdr;
>  		}
>  		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
>  			/* ro_header has been freed */
>  			ro_header = NULL;
> -			prog = orig_prog;
> +			clear_jit_state(prog);
>  			goto out_off;
>  		}
>  		/*
> @@ -2245,10 +2219,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
>  	}
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
> +
>  	return prog;
>  
>  out_free_hdr:
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..57dd24d53c77 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1911,43 +1911,26 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
> -	bool tmp_blinded = false, extra_pass = false;
> +	bool extra_pass = false;
>  	u8 *image_ptr, *ro_image_ptr;
>  	int image_size, prog_size, extable_size;
>  	struct jit_ctx ctx;
>  	struct jit_data *jit_data;
>  	struct bpf_binary_header *header;
>  	struct bpf_binary_header *ro_header;
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  
>  	/*
>  	 * If BPF JIT was not enabled then we must fall back to
>  	 * the interpreter.
>  	 */
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	/*
> -	 * If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter. Otherwise, we save
> -	 * the new JITed code.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return prog;
>  		prog->aux->jit_data = jit_data;
>  	}
>  	if (jit_data->ctx.offset) {
> @@ -1967,17 +1950,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>  
>  	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
> -	if (ctx.offset == NULL) {
> -		prog = orig_prog;
> +	if (ctx.offset == NULL)
>  		goto out_offset;
> -	}
>  
>  	/* 1. Initial fake pass to compute ctx->idx and set ctx->flags */
>  	build_prologue(&ctx);
> -	if (build_body(&ctx, extra_pass)) {
> -		prog = orig_prog;
> +	if (build_body(&ctx, extra_pass))
>  		goto out_offset;
> -	}
>  	ctx.epilogue_offset = ctx.idx;
>  	build_epilogue(&ctx);
>  
> @@ -1993,10 +1972,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	/* Now we know the size of the structure to make */
>  	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr, sizeof(u32),
>  					      &header, &image_ptr, jit_fill_hole);
> -	if (!ro_header) {
> -		prog = orig_prog;
> +	if (!ro_header)
>  		goto out_offset;
> -	}
>  
>  	/* 2. Now, the actual pass to generate final JIT code */
>  	/*
> @@ -2016,17 +1993,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.num_exentries = 0;
>  
>  	build_prologue(&ctx);
> -	if (build_body(&ctx, extra_pass)) {
> -		prog = orig_prog;
> +	if (build_body(&ctx, extra_pass))
>  		goto out_free;
> -	}
>  	build_epilogue(&ctx);
>  
>  	/* 3. Extra pass to validate JITed code */
> -	if (validate_ctx(&ctx)) {
> -		prog = orig_prog;
> +	if (validate_ctx(&ctx))
>  		goto out_free;
> -	}
>  
>  	/* And we're done */
>  	if (bpf_jit_enable > 1)
> @@ -2041,7 +2014,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
>  			/* ro_header has been freed */
>  			ro_header = NULL;
> -			prog = orig_prog;
>  			goto out_free;
>  		}
>  		/*
> @@ -2073,13 +2045,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		prog->aux->jit_data = NULL;
>  	}
>  
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
> -
>  	return prog;
>  
>  out_free:
> +	if (prog->jited) {
> +		prog->bpf_func = NULL;
> +		prog->jited = 0;
> +		prog->jited_len = 0;
> +	}
> +
>  	if (header) {
>  		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->size));
>  		bpf_jit_binary_pack_free(ro_header, header);
> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index e355dfca4400..d2b6c955f18e 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -911,10 +911,8 @@ bool bpf_jit_needs_zext(void)
>  
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	struct bpf_binary_header *header = NULL;
>  	struct jit_context ctx;
> -	bool tmp_blinded = false;
>  	unsigned int tmp_idx;
>  	unsigned int image_size;
>  	u8 *image_ptr;
> @@ -925,19 +923,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * the interpreter.
>  	 */
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -	/*
> -	 * If constant blinding was enabled and we failed during blinding
> -	 * then we must fall back to the interpreter. Otherwise, we save
> -	 * the new JITed code.
> -	 */
> -	tmp = bpf_jit_blind_constants(prog);
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	memset(&ctx, 0, sizeof(ctx));
>  	ctx.program = prog;
> @@ -1025,14 +1011,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	prog->jited_len = image_size;
>  
>  out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>  	kfree(ctx.descriptors);
>  	return prog;
>  
>  out_err:
> -	prog = orig_prog;
>  	if (header)
>  		bpf_jit_binary_free(header);
>  	goto out;
> diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
> index a5eb6b51e27a..4d339636a34a 100644
> --- a/arch/parisc/net/bpf_jit_core.c
> +++ b/arch/parisc/net/bpf_jit_core.c
> @@ -44,30 +44,19 @@ bool bpf_jit_needs_zext(void)
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>  	unsigned int prog_size = 0, extable_size = 0;
> -	bool tmp_blinded = false, extra_pass = false;
> -	struct bpf_prog *tmp, *orig_prog = prog;
> +	bool extra_pass = false;
>  	int pass = 0, prev_ninsns = 0, prologue_len, i;
>  	struct hppa_jit_data *jit_data;
>  	struct hppa_jit_context *ctx;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return prog;
>  		prog->aux->jit_data = jit_data;
>  	}
>  
> @@ -81,10 +70,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  
>  	ctx->prog = prog;
>  	ctx->offset = kzalloc_objs(int, prog->len);
> -	if (!ctx->offset) {
> -		prog = orig_prog;
> +	if (!ctx->offset)
>  		goto out_offset;
> -	}
>  	for (i = 0; i < prog->len; i++) {
>  		prev_ninsns += 20;
>  		ctx->offset[i] = prev_ninsns;
> @@ -93,10 +80,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
>  		pass++;
>  		ctx->ninsns = 0;
> -		if (build_body(ctx, extra_pass, ctx->offset)) {
> -			prog = orig_prog;
> +		if (build_body(ctx, extra_pass, ctx->offset))
>  			goto out_offset;
> -		}
>  		ctx->body_len = ctx->ninsns;
>  		bpf_jit_build_prologue(ctx);
>  		ctx->prologue_len = ctx->ninsns - ctx->body_len;
> @@ -116,10 +101,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  						     &jit_data->image,
>  						     sizeof(long),
>  						     bpf_fill_ill_insns);
> -			if (!jit_data->header) {
> -				prog = orig_prog;
> +			if (!jit_data->header)
>  				goto out_offset;
> -			}
>  
>  			ctx->insns = (u32 *)jit_data->image;
>  			/*
> @@ -134,7 +117,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
>  		if (jit_data->header)
>  			bpf_jit_binary_free(jit_data->header);
> -		prog = orig_prog;
>  		goto out_offset;
>  	}
>  
> @@ -148,7 +130,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	bpf_jit_build_prologue(ctx);
>  	if (build_body(ctx, extra_pass, NULL)) {
>  		bpf_jit_binary_free(jit_data->header);
> -		prog = orig_prog;
>  		goto out_offset;
>  	}
>  	bpf_jit_build_epilogue(ctx);
> @@ -183,13 +164,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
>  	}
> -out:
> +
>  	if (HPPA_JIT_REBOOT)
>  		{ extern int machine_restart(char *); machine_restart(""); }
>  
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>  	return prog;
>  }
>  
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 52162e4a7f84..7a7c49640a2f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -142,9 +142,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	int flen;
>  	struct bpf_binary_header *fhdr = NULL;
>  	struct bpf_binary_header *hdr = NULL;
> -	struct bpf_prog *org_fp = fp;
> -	struct bpf_prog *tmp_fp;
> -	bool bpf_blinded = false;
>  	bool extra_pass = false;
>  	u8 *fimage = NULL;
>  	u32 *fcode_base;
> @@ -152,24 +149,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	u32 fixup_len;
>  
>  	if (!fp->jit_requested)
> -		return org_fp;
> -
> -	tmp_fp = bpf_jit_blind_constants(org_fp);
> -	if (IS_ERR(tmp_fp))
> -		return org_fp;
> -
> -	if (tmp_fp != org_fp) {
> -		bpf_blinded = true;
> -		fp = tmp_fp;
> -	}
> +		return fp;
>  
>  	jit_data = fp->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			fp = org_fp;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return fp;
>  		fp->aux->jit_data = jit_data;
>  	}
>  
> @@ -194,10 +180,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	}
>  
>  	addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
> -	if (addrs == NULL) {
> -		fp = org_fp;
> +	if (addrs == NULL)
>  		goto out_addrs;
> -	}
>  
>  	memset(&cgctx, 0, sizeof(struct codegen_context));
>  	bpf_jit_init_reg_mapping(&cgctx);
> @@ -211,11 +195,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	cgctx.exception_cb = fp->aux->exception_cb;
>  
>  	/* Scouting faux-generate pass 0 */
> -	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> +	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>  		/* We hit something illegal or unsupported. */
> -		fp = org_fp;
>  		goto out_addrs;
> -	}
>  
>  	/*
>  	 * If we have seen a tail call, we need a second pass.
> @@ -226,10 +208,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	 */
>  	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>  		cgctx.idx = 0;
> -		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> -			fp = org_fp;
> +		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>  			goto out_addrs;
> -		}
>  	}
>  
>  	bpf_jit_realloc_regs(&cgctx);
> @@ -250,10 +230,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  
>  	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
>  					      bpf_jit_fill_ill_insns);
> -	if (!fhdr) {
> -		fp = org_fp;
> +	if (!fhdr)
>  		goto out_addrs;
> -	}
>  
>  	if (extable_len)
>  		fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
> @@ -272,7 +250,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  				       extra_pass)) {
>  			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>  			bpf_jit_binary_pack_free(fhdr, hdr);
> -			fp = org_fp;
>  			goto out_addrs;
>  		}
>  		bpf_jit_build_epilogue(code_base, &cgctx);
> @@ -301,7 +278,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  
>  	if (!fp->is_func || extra_pass) {
>  		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
> -			fp = org_fp;
> +			fp->bpf_func = NULL;
> +			fp->jited = 0;
> +			fp->jited_len = 0;
>  			goto out_addrs;
>  		}
>  		bpf_prog_fill_jited_linfo(fp, addrs);
> @@ -318,10 +297,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		jit_data->hdr = hdr;
>  	}
>  
> -out:
> -	if (bpf_blinded)
> -		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
> -
>  	return fp;
>  }
>  
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index b3581e926436..c77e8aba14d3 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -44,29 +44,19 @@ bool bpf_jit_needs_zext(void)
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>  	unsigned int prog_size = 0, extable_size = 0;
> -	bool tmp_blinded = false, extra_pass = false;
> -	struct bpf_prog *tmp, *orig_prog = prog;
> +	bool extra_pass = false;
>  	int pass = 0, prev_ninsns = 0, i;
>  	struct rv_jit_data *jit_data;
>  	struct rv_jit_context *ctx;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
>  		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> +			return prog;
>  		}
>  		prog->aux->jit_data = jit_data;
>  	}
> @@ -83,15 +73,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>  	ctx->prog = prog;
>  	ctx->offset = kzalloc_objs(int, prog->len);
> -	if (!ctx->offset) {
> -		prog = orig_prog;
> +	if (!ctx->offset)
>  		goto out_offset;
> -	}
>  
> -	if (build_body(ctx, extra_pass, NULL)) {
> -		prog = orig_prog;
> +	if (build_body(ctx, extra_pass, NULL))
>  		goto out_offset;
> -	}
>  
>  	for (i = 0; i < prog->len; i++) {
>  		prev_ninsns += 32;
> @@ -105,10 +91,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
>  		ctx->prologue_len = ctx->ninsns;
>  
> -		if (build_body(ctx, extra_pass, ctx->offset)) {
> -			prog = orig_prog;
> +		if (build_body(ctx, extra_pass, ctx->offset))
>  			goto out_offset;
> -		}
>  
>  		ctx->epilogue_offset = ctx->ninsns;
>  		bpf_jit_build_epilogue(ctx);
> @@ -126,10 +110,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  							  &jit_data->ro_image, sizeof(u32),
>  							  &jit_data->header, &jit_data->image,
>  							  bpf_fill_ill_insns);
> -			if (!jit_data->ro_header) {
> -				prog = orig_prog;
> +			if (!jit_data->ro_header)
>  				goto out_offset;
> -			}
>  
>  			/*
>  			 * Use the image(RW) for writing the JITed instructions. But also save
> @@ -150,7 +132,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  
>  	if (i == NR_JIT_ITERATIONS) {
>  		pr_err("bpf-jit: image did not converge in <%d passes!\n", i);
> -		prog = orig_prog;
>  		goto out_free_hdr;
>  	}
>  
> @@ -163,10 +144,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx->nexentries = 0;
>  
>  	bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
> -	if (build_body(ctx, extra_pass, NULL)) {
> -		prog = orig_prog;
> +	if (build_body(ctx, extra_pass, NULL))
>  		goto out_free_hdr;
> -	}
>  	bpf_jit_build_epilogue(ctx);
>  
>  	if (bpf_jit_enable > 1)
> @@ -180,7 +159,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
>  			/* ro_header has been freed */
>  			jit_data->ro_header = NULL;
> -			prog = orig_prog;
> +			prog->bpf_func = NULL;
> +			prog->jited = 0;
> +			prog->jited_len = 0;
>  			goto out_offset;
>  		}
>  		/*
> @@ -198,11 +179,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
>  	}
> -out:
>  
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>  	return prog;
>  
>  out_free_hdr:
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 1f9a6b728beb..d6de2abfe4a7 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2305,36 +2305,20 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
>   */
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  {
> -	struct bpf_prog *tmp, *orig_fp = fp;
>  	struct bpf_binary_header *header;
>  	struct s390_jit_data *jit_data;
> -	bool tmp_blinded = false;
>  	bool extra_pass = false;
>  	struct bpf_jit jit;
>  	int pass;
>  
>  	if (!fp->jit_requested)
> -		return orig_fp;
> -
> -	tmp = bpf_jit_blind_constants(fp);
> -	/*
> -	 * If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_fp;
> -	if (tmp != fp) {
> -		tmp_blinded = true;
> -		fp = tmp;
> -	}
> +		return fp;
>  
>  	jit_data = fp->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			fp = orig_fp;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return fp;
>  		fp->aux->jit_data = jit_data;
>  	}
>  	if (jit_data->ctx.addrs) {
> @@ -2347,33 +2331,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  
>  	memset(&jit, 0, sizeof(jit));
>  	jit.addrs = kvcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
> -	if (jit.addrs == NULL) {
> -		fp = orig_fp;
> +	if (jit.addrs == NULL)
>  		goto free_addrs;
> -	}
>  	/*
>  	 * Three initial passes:
>  	 *   - 1/2: Determine clobbered registers
>  	 *   - 3:   Calculate program size and addrs array
>  	 */
>  	for (pass = 1; pass <= 3; pass++) {
> -		if (bpf_jit_prog(&jit, fp, extra_pass)) {
> -			fp = orig_fp;
> +		if (bpf_jit_prog(&jit, fp, extra_pass))
>  			goto free_addrs;
> -		}
>  	}
>  	/*
>  	 * Final pass: Allocate and generate program
>  	 */
>  	header = bpf_jit_alloc(&jit, fp);
> -	if (!header) {
> -		fp = orig_fp;
> +	if (!header)
>  		goto free_addrs;
> -	}
>  skip_init_ctx:
>  	if (bpf_jit_prog(&jit, fp, extra_pass)) {
>  		bpf_jit_binary_free(header);
> -		fp = orig_fp;
>  		goto free_addrs;
>  	}
>  	if (bpf_jit_enable > 1) {
> @@ -2383,7 +2360,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	if (!fp->is_func || extra_pass) {
>  		if (bpf_jit_binary_lock_ro(header)) {
>  			bpf_jit_binary_free(header);
> -			fp = orig_fp;
>  			goto free_addrs;
>  		}
>  	} else {
> @@ -2402,10 +2378,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		kfree(jit_data);
>  		fp->aux->jit_data = NULL;
>  	}
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(fp, fp == orig_fp ?
> -					   tmp : orig_fp);
> +
>  	return fp;
>  }
>  
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
> index b23d1c645ae5..86abd84d4005 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -1479,37 +1479,22 @@ struct sparc64_jit_data {
>  
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	struct sparc64_jit_data *jit_data;
>  	struct bpf_binary_header *header;
>  	u32 prev_image_size, image_size;
> -	bool tmp_blinded = false;
>  	bool extra_pass = false;
>  	struct jit_ctx ctx;
>  	u8 *image_ptr;
>  	int pass, i;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	/* If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			prog = orig_prog;
> -			goto out;
> -		}
> +		if (!jit_data)
> +			return prog;
>  		prog->aux->jit_data = jit_data;
>  	}
>  	if (jit_data->ctx.offset) {
> @@ -1527,10 +1512,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.prog = prog;
>  
>  	ctx.offset = kmalloc_array(prog->len, sizeof(unsigned int), GFP_KERNEL);
> -	if (ctx.offset == NULL) {
> -		prog = orig_prog;
> +	if (ctx.offset == NULL)
>  		goto out_off;
> -	}
>  
>  	/* Longest sequence emitted is for bswap32, 12 instructions.  Pre-cook
>  	 * the offset array so that we converge faster.
> @@ -1543,10 +1526,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		ctx.idx = 0;
>  
>  		build_prologue(&ctx);
> -		if (build_body(&ctx)) {
> -			prog = orig_prog;
> +		if (build_body(&ctx))
>  			goto out_off;
> -		}
>  		build_epilogue(&ctx);
>  
>  		if (bpf_jit_enable > 1)
> @@ -1569,10 +1550,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	image_size = sizeof(u32) * ctx.idx;
>  	header = bpf_jit_binary_alloc(image_size, &image_ptr,
>  				      sizeof(u32), jit_fill_hole);
> -	if (header == NULL) {
> -		prog = orig_prog;
> +	if (header == NULL)
>  		goto out_off;
> -	}
>  
>  	ctx.image = (u32 *)image_ptr;
>  skip_init_ctx:
> @@ -1582,7 +1561,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  
>  	if (build_body(&ctx)) {
>  		bpf_jit_binary_free(header);
> -		prog = orig_prog;
>  		goto out_off;
>  	}
>  
> @@ -1592,7 +1570,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		pr_err("bpf_jit: Failed to converge, prev_size=%u size=%d\n",
>  		       prev_image_size, ctx.idx * 4);
>  		bpf_jit_binary_free(header);
> -		prog = orig_prog;
>  		goto out_off;
>  	}
>  
> @@ -1604,7 +1581,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	if (!prog->is_func || extra_pass) {
>  		if (bpf_jit_binary_lock_ro(header)) {
>  			bpf_jit_binary_free(header);
> -			prog = orig_prog;
>  			goto out_off;
>  		}
>  	} else {
> @@ -1624,9 +1600,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
>  	}
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
> +
>  	return prog;
>  }
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e9b78040d703..de51ab3a11ee 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3717,13 +3717,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>  	struct bpf_binary_header *rw_header = NULL;
>  	struct bpf_binary_header *header = NULL;
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	void __percpu *priv_stack_ptr = NULL;
>  	struct x64_jit_data *jit_data;
>  	int priv_stack_alloc_sz;
>  	int proglen, oldproglen = 0;
>  	struct jit_context ctx = {};
> -	bool tmp_blinded = false;
>  	bool extra_pass = false;
>  	bool padding = false;
>  	u8 *rw_image = NULL;
> @@ -3733,27 +3731,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	int i;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	/*
> -	 * If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	jit_data = prog->aux->jit_data;
>  	if (!jit_data) {
>  		jit_data = kzalloc_obj(*jit_data);
> -		if (!jit_data) {
> -			prog = orig_prog;
> +		if (!jit_data)
>  			goto out;
> -		}
>  		prog->aux->jit_data = jit_data;
>  	}
>  	priv_stack_ptr = prog->aux->priv_stack_ptr;
> @@ -3765,10 +3749,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 8) +
>  				      2 * PRIV_STACK_GUARD_SZ;
>  		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERNEL);
> -		if (!priv_stack_ptr) {
> -			prog = orig_prog;
> +		if (!priv_stack_ptr)
>  			goto out_priv_stack;
> -		}
>  
>  		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
>  		prog->aux->priv_stack_ptr = priv_stack_ptr;
> @@ -3786,10 +3768,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		goto skip_init_addrs;
>  	}
>  	addrs = kvmalloc_objs(*addrs, prog->len + 1);
> -	if (!addrs) {
> -		prog = orig_prog;
> +	if (!addrs)
>  		goto out_addrs;
> -	}
>  
>  	/*
>  	 * Before first pass, make a rough estimation of addrs[]
> @@ -3820,8 +3800,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  						   sizeof(rw_header->size));
>  				bpf_jit_binary_pack_free(header, rw_header);
>  			}
> -			/* Fall back to interpreter mode */
> -			prog = orig_prog;
>  			if (extra_pass) {
>  				prog->bpf_func = NULL;
>  				prog->jited = 0;
> @@ -3852,10 +3830,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
>  							   &image, align, &rw_header, &rw_image,
>  							   jit_fill_hole);
> -			if (!header) {
> -				prog = orig_prog;
> +			if (!header)
>  				goto out_addrs;
> -			}
>  			prog->aux->extable = (void *) image + roundup(proglen, align);
>  		}
>  		oldproglen = proglen;
> @@ -3908,8 +3884,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		prog->bpf_func = (void *)image + cfi_get_offset();
>  		prog->jited = 1;
>  		prog->jited_len = proglen - cfi_get_offset();
> -	} else {
> -		prog = orig_prog;
>  	}
>  
>  	if (!image || !prog->is_func || extra_pass) {
> @@ -3925,10 +3899,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
>  	}
> +
>  out:

small nit: is the label 'out' necessary now?

> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>  	return prog;
>  }
>  
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index dda423025c3d..5f259577614a 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2521,35 +2521,19 @@ bool bpf_jit_needs_zext(void)
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>  	struct bpf_binary_header *header = NULL;
> -	struct bpf_prog *tmp, *orig_prog = prog;
>  	int proglen, oldproglen = 0;
>  	struct jit_context ctx = {};
> -	bool tmp_blinded = false;
>  	u8 *image = NULL;
>  	int *addrs;
>  	int pass;
>  	int i;
>  
>  	if (!prog->jit_requested)
> -		return orig_prog;
> -
> -	tmp = bpf_jit_blind_constants(prog);
> -	/*
> -	 * If blinding was requested and we failed during blinding,
> -	 * we must fall back to the interpreter.
> -	 */
> -	if (IS_ERR(tmp))
> -		return orig_prog;
> -	if (tmp != prog) {
> -		tmp_blinded = true;
> -		prog = tmp;
> -	}
> +		return prog;
>  
>  	addrs = kmalloc_objs(*addrs, prog->len);
> -	if (!addrs) {
> -		prog = orig_prog;
> -		goto out;
> -	}
> +	if (!addrs)
> +		return prog;
>  
>  	/*
>  	 * Before first pass, make a rough estimation of addrs[]
> @@ -2574,7 +2558,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  			image = NULL;
>  			if (header)
>  				bpf_jit_binary_free(header);
> -			prog = orig_prog;
>  			goto out_addrs;
>  		}
>  		if (image) {
> @@ -2588,10 +2571,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (proglen == oldproglen) {
>  			header = bpf_jit_binary_alloc(proglen, &image,
>  						      1, jit_fill_hole);
> -			if (!header) {
> -				prog = orig_prog;
> +			if (!header)
>  				goto out_addrs;
> -			}
>  		}
>  		oldproglen = proglen;
>  		cond_resched();
> @@ -2604,16 +2585,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		prog->bpf_func = (void *)image;
>  		prog->jited = 1;
>  		prog->jited_len = proglen;
> -	} else {
> -		prog = orig_prog;
>  	}
>  
>  out_addrs:
>  	kfree(addrs);
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> -					   tmp : orig_prog);
>  	return prog;
>  }
>  
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 44d7ae95ddbc..2484d85be63d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1184,6 +1184,10 @@ static inline bool bpf_dump_raw_ok(const struct cred *cred)
>  
>  struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>  				       const struct bpf_insn *patch, u32 len);
> +
> +struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
> +				     const struct bpf_insn *patch, u32 len);
> +
>  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
>  
>  static inline bool xdp_return_frame_no_direct(void)
> @@ -1310,8 +1314,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>  
>  const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
>  
> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
> -void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
> +int bpf_jit_blind_constants(struct bpf_verifier_env *env);
>  
>  static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
>  				u32 pass, void *image)
> @@ -1451,6 +1454,10 @@ static inline void bpf_prog_kallsyms_del(struct bpf_prog *fp)
>  {
>  }
>  
> +static inline int bpf_jit_blind_constants(struct bpf_verifier_env *env)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BPF_JIT */
>  
>  void bpf_prog_kallsyms_del_all(struct bpf_prog *fp);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 229c74f3d6ae..c692213b1fdf 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1427,82 +1427,19 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  	return to - to_buff;
>  }
>  
> -static struct bpf_prog *bpf_prog_clone_create(struct bpf_prog *fp_other,
> -					      gfp_t gfp_extra_flags)
> -{
> -	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
> -	struct bpf_prog *fp;
> -
> -	fp = __vmalloc(fp_other->pages * PAGE_SIZE, gfp_flags);
> -	if (fp != NULL) {
> -		/* aux->prog still points to the fp_other one, so
> -		 * when promoting the clone to the real program,
> -		 * this still needs to be adapted.
> -		 */
> -		memcpy(fp, fp_other, fp_other->pages * PAGE_SIZE);
> -	}
> -
> -	return fp;
> -}
> -
> -static void bpf_prog_clone_free(struct bpf_prog *fp)
> -{
> -	/* aux was stolen by the other clone, so we cannot free
> -	 * it from this path! It will be freed eventually by the
> -	 * other program on release.
> -	 *
> -	 * At this point, we don't need a deferred release since
> -	 * clone is guaranteed to not be locked.
> -	 */
> -	fp->aux = NULL;
> -	fp->stats = NULL;
> -	fp->active = NULL;
> -	__bpf_prog_free(fp);
> -}
> -
> -void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
> -{
> -	/* We have to repoint aux->prog to self, as we don't
> -	 * know whether fp here is the clone or the original.
> -	 */
> -	fp->aux->prog = fp;
> -	bpf_prog_clone_free(fp_other);
> -}
> -
> -static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
> -{
> -#ifdef CONFIG_BPF_SYSCALL
> -	struct bpf_map *map;
> -	int i;
> -
> -	if (len <= 1)
> -		return;
> -
> -	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> -		map = prog->aux->used_maps[i];
> -		if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> -			bpf_insn_array_adjust(map, off, len);
> -	}
> -#endif
> -}
> -
> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
> +int bpf_jit_blind_constants(struct bpf_verifier_env *env)
>  {
>  	struct bpf_insn insn_buff[16], aux[2];
> -	struct bpf_prog *clone, *tmp;
> +	struct bpf_prog *prog = env->prog;
>  	int insn_delta, insn_cnt;
>  	struct bpf_insn *insn;
>  	int i, rewritten;
>  
>  	if (!prog->blinding_requested || prog->blinded)
> -		return prog;
> -
> -	clone = bpf_prog_clone_create(prog, GFP_USER);
> -	if (!clone)
> -		return ERR_PTR(-ENOMEM);
> +		return 0;
>  
> -	insn_cnt = clone->len;
> -	insn = clone->insnsi;
> +	insn_cnt = prog->len;
> +	insn = prog->insnsi;
>  
>  	for (i = 0; i < insn_cnt; i++, insn++) {
>  		if (bpf_pseudo_func(insn)) {
> @@ -1523,35 +1460,25 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  		    insn[1].code == 0)
>  			memcpy(aux, insn, sizeof(aux));
>  
> -		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff,
> -						clone->aux->verifier_zext);
> +		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff, prog->aux->verifier_zext);
>  		if (!rewritten)
>  			continue;
>  
> -		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
> -		if (IS_ERR(tmp)) {
> -			/* Patching may have repointed aux->prog during
> -			 * realloc from the original one, so we need to
> -			 * fix it up here on error.
> -			 */
> -			bpf_jit_prog_release_other(prog, clone);
> -			return tmp;
> -		}
> +		prog = bpf_patch_insn_data(env, i, insn_buff, rewritten);
> +		if (!prog)
> +			return -ENOMEM;
>  
> -		clone = tmp;
> +		env->prog = prog;
>  		insn_delta = rewritten - 1;
>  
> -		/* Instructions arrays must be updated using absolute xlated offsets */
> -		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
> -
>  		/* Walk new program and skip insns we just inserted. */
> -		insn = clone->insnsi + i + insn_delta;
> +		insn = prog->insnsi + i + insn_delta;
>  		insn_cnt += insn_delta;
>  		i        += insn_delta;
>  	}
>  
> -	clone->blinded = 1;
> -	return clone;
> +	prog->blinded = 1;
> +	return 0;
>  }
>  #endif /* CONFIG_BPF_JIT */
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7aa06f534cb2..e290c9b7d13d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22070,8 +22070,8 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
>  	}
>  }
>  
> -static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
> -					    const struct bpf_insn *patch, u32 len)
> +struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
> +				     const struct bpf_insn *patch, u32 len)
>  {
>  	struct bpf_prog *new_prog;
>  	struct bpf_insn_aux_data *new_data = NULL;
> @@ -22846,7 +22846,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	struct bpf_insn *insn;
>  	void *old_bpf_func;
>  	int err, num_exentries;
> -	int old_len, subprog_start_adjustment = 0;

nice :)

>  
>  	if (env->subprog_cnt <= 1)
>  		return 0;
> @@ -22918,10 +22917,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  			goto out_free;
>  		func[i]->is_func = 1;
>  		func[i]->sleepable = prog->sleepable;
> +		func[i]->blinded = prog->blinded;
>  		func[i]->aux->func_idx = i;
>  		/* Below members will be freed only at prog->aux */
>  		func[i]->aux->btf = prog->aux->btf;
> -		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
> +		func[i]->aux->subprog_start = subprog_start;
>  		func[i]->aux->func_info = prog->aux->func_info;
>  		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
>  		func[i]->aux->poke_tab = prog->aux->poke_tab;
> @@ -22977,15 +22977,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
>  		if (!i)
>  			func[i]->aux->exception_boundary = env->seen_exception;
> -
> -		/*
> -		 * To properly pass the absolute subprog start to jit
> -		 * all instruction adjustments should be accumulated
> -		 */
> -		old_len = func[i]->len;
>  		func[i] = bpf_int_jit_compile(func[i]);
> -		subprog_start_adjustment += func[i]->len - old_len;
> -
>  		if (!func[i]->jited) {
>  			err = -ENOTSUPP;
>  			goto out_free;
> @@ -23136,6 +23128,9 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  
>  	if (env->prog->jit_requested &&
>  	    !bpf_prog_is_offloaded(env->prog->aux)) {
> +		err = bpf_jit_blind_constants(env);
> +		if (err)
> +			return err;
>  		err = jit_subprogs(env);
>  		if (err == 0)
>  			return 0;
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
