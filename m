Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF253D1CCF
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073806; cv=none; b=cNDXB8EpCoV7LoDMIS2tozRCOyDfN6pVc35M9GGvB6K1URnbmvD49UNiUr9E0MA5nJJoReAi1VDEBataXDWNclXmKlcpX/cWu2fUZpkURlDIoCxb6+NrF3EUpC5oFxZu+npNryO1F5dPBs5K6basvDGptasCExrDM6mj3VJCbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073806; c=relaxed/simple;
	bh=0r2VyRfKuQvi8Br6PMZE5Ur4xoDTU+UBzGGvjNgxtn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7ZuVwFm/aNRaoVq+6jqddosOedqe6OEVA4P3zUIT+1FYlxqF0ZcNe9/vsyCJi5xmkiSPfk6ynWKFYsJFNR55QqX8m9Z2jlz2HsnKp0Cij4L2QbrRiFBfxsIn3Kuxy8XFhySwo/Al3jYMP0UinYRVOPTFGukTDxyR8Eo+MIPkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd1H+CmL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd1H+CmL"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439ac15f35fso8446407f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073803; x=1773678603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdpDN3cbR4Vo18mFgfjtOYOZ0BTO5Hn4GNbDEChr/aA=;
        b=nd1H+CmLsmRLLyFirY5o7l/GZrBV5oyyss9G/u31GI1lO1zZk7sKrbfCEQpkT1HtNU
         foWw8txSCzpcho4siqL58NNZZ+oJbPWzlDOtXMp89H9PG63zqM8gpea4PyknQpijnz5g
         N97lrr2QPu9qdUfDTdfPA4zlBpmepzzVipqD7ASf01yaFLnsQBie4Y4UjFk9q2/iDzci
         BRLKHbZdZHPgMA4mcVbbskzavwUyQl5+LMHsmi7rnrYpAHC2P5z3HavVtrAv174Rk7yf
         kIjhq4JgKuyjaKs3PxUEPCZlLLJVLqXnRG9S9jVd5Z69ZAYkotKbg1/HUW1jsbjREDjP
         Ib5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073803; x=1773678603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdpDN3cbR4Vo18mFgfjtOYOZ0BTO5Hn4GNbDEChr/aA=;
        b=PW77CZKJ5xdFEofGjhZQOp9XBDW3P6mubc2ebjl9/ekbmI5npSzL0mXp0cREUoqvI5
         YvbBFVUrQ60PSiQOVaUrUF/CrAv1+eO/1IbJMfkCdr4d/+0xqEIkZNosP5/aEOdvo1Q7
         beANcaYxNxK5ri9SBNfvMI+VQfnzg+VIqj9y5VrZXizSrsdpl3ZOsHJEnUqnyewRTs+H
         XqlOsP5/EJg/rmkYnYddlW7Bw3zTxx7jZ7WuDyTnKfX8dxvkyTpisXZ4+9lh4UPO9BK0
         qZESs3wM2jceQfvNgzw2JvpZzEooV5WHUd3CimkV1IAFAYtkGUDxp20MGXADpTdmhY+b
         kpSg==
X-Gm-Message-State: AOJu0YzAyQqwMvGbDOJDxQghLDZY0xUJHJEhYbQpfBFv7odwM3BbX+z3
	5C5+GCg0qeBR9olMFOlwfM0zobGXXK+KcLtgKYLIbGTImlvpwyc830Fo
X-Gm-Gg: ATEYQzyy5o4f/6EU/sXC6Ng9f5+6K4Bh8w0W5iGqX9EkHMIGagNWrbNhGdUA+lUDEUP
	2FoiA16mYHcJO/gxSuypbAa7AfwNZxdV+x4VF4ee3y2N8KOAK2fh7Lcf6pztclbxSnT+WtplpLc
	rkKifxNT3x0ITm34bgz2YYUuKaNn+xsY3hdMvICwDq9j1y5IoAZAk3eVnll7ejfexBDRZ6k4UIV
	YKAEN+2/upf0eqZ9lBzwb2iCJSyHJ4kSFuJ0w4Kdw1QDK+DaqHiF4k1ewlIqLeaORmMxYQaAsUw
	VcXwN3AEqIJfBtENk3h/cEq7QpMLb0aDyiuN6e5rMXRb8vQqncsj9Q/tCvIiSzakZWZjOKOh5YC
	mOvwrnB5lsmtR63Wc8GmK4jTR/fSaKMmss7YCefiXjjWG7sHjSxunxxnFZYuPTGgrrQj0iVvIqs
	LMngn0z1GTd4Y0xPR6Hh1OLXwbM+Uo7bBf
X-Received: by 2002:a05:6000:1a8b:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-439da35f669mr21060331f8f.27.1773073803043;
        Mon, 09 Mar 2026 09:30:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d95dsm30173171f8f.7.2026.03.09.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:30:02 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:38:21 +0000
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
Subject: Re: [bpf-next v8 5/5] bpf, arm64: Emit BTI for indirect jump target
Message-ID: <aa73feA0wPDNmZLC@mail.gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-6-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-6-xukuohai@huaweicloud.com>

On 26/03/09 10:00PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> On CPUs that support BTI, the indirect jump selftest triggers a kernel
> panic because there is no BTI instructions at the indirect jump targets.
> 
> Fix it by emitting a BTI instruction for each indirect jump target.
> 
> For reference, below is a sample panic log.
> 
> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x468
>  bpf_prog_test_run_syscall+0x280/0x3b8
>  bpf_prog_test_run+0x22c/0x2c0
> 
> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 5c785eab4b5a..036ad607720a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1198,8 +1198,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   * >0 - successfully JITed a 16-byte eBPF instruction.
>   * <0 - failed to JIT.
>   */
> -static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> -		      bool extra_pass)
> +static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn *insn,
> +		      struct jit_ctx *ctx, bool extra_pass)
>  {
>  	const u8 code = insn->code;
>  	u8 dst = bpf2a64[insn->dst_reg];
> @@ -1224,6 +1224,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  	int ret;
>  	bool sign_extend;
>  
> +	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
> +		emit_bti(A64_BTI_J, ctx);
> +
>  	switch (code) {
>  	/* dst = src */
>  	case BPF_ALU | BPF_MOV | BPF_X:
> @@ -1899,7 +1902,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  	return 0;
>  }
>  
> -static int build_body(struct jit_ctx *ctx, bool extra_pass)
> +static int build_body(struct bpf_verifier_env *env, struct jit_ctx *ctx, bool extra_pass)
>  {
>  	const struct bpf_prog *prog = ctx->prog;
>  	int i;
> @@ -1918,7 +1921,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>  		int ret;
>  
>  		ctx->offset[i] = ctx->idx;
> -		ret = build_insn(insn, ctx, extra_pass);
> +		ret = build_insn(env, insn, ctx, extra_pass);
>  		if (ret > 0) {
>  			i++;
>  			ctx->offset[i] = ctx->idx;
> @@ -2086,7 +2089,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	if (build_prologue(&ctx, was_classic))
>  		goto out_off;
>  
> -	if (build_body(&ctx, extra_pass))
> +	if (build_body(env, &ctx, extra_pass))
>  		goto out_off;
>  
>  	ctx.epilogue_offset = ctx.idx;
> @@ -2134,7 +2137,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	/* Dont write body instructions to memory for now */
>  	ctx.write = false;
>  
> -	if (build_body(&ctx, extra_pass))
> +	if (build_body(env, &ctx, extra_pass))
>  		goto out_free_hdr;
>  
>  	ctx.epilogue_offset = ctx.idx;
> @@ -2143,7 +2146,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	ctx.write = true;
>  
>  	/* Pass 3: Adjust jump offset and write final image */
> -	if (build_body(&ctx, extra_pass) ||
> +	if (build_body(env, &ctx, extra_pass) ||
>  		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset))
>  		goto out_free_hdr;
>  
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
