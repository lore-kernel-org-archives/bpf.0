Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7456A001
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242563; cv=none; b=BaOf9N9KWoD1OphLAvLcs4ix6HNkFn+etgMcu5AVsJUjYM4Vzow3Mf7ERUk0WZG0olWixMC4qkEQHpUw3RaSpeIBfEIMaQ0PzSr3OXLZ86ZDKVPEnQtXovhlCqinyGLiX1siKSX4OHn0+SvD1wN4gdrCwc0hCK5fdGrJpvFo1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242563; c=relaxed/simple;
	bh=q2NYEQxiA+6NCUkgbfeGnFvQwygkCxZdIkhPfKWWew8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=m7HnQKS/iezndYkuBd8VCeqGeErTtTDn9nlr5ZqhZyNPhjepREDiJo1SnHid+1H3h9c9lzUZllt7tBH8IF1h+hzflh3SoBYZT80qANLevfr8vsH1cXvzu4wy4x53XSfJkxsND0ZD2o0XQ5z0Dxy9BuEWaUEQSNvAd8WsvwCjfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eRbhylVE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eRbhylVE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2addb31945aso15947045ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775242562; x=1775847362; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUEap9ZtLAOWWOdMbJTcGPlnUuslrijse69P0jdZIjA=;
        b=eRbhylVEedFabLWpJLxklxa3ZSQWmw0PSuWti1svTxnRrQUhW7G3aOPhbYcb58w+RJ
         kI+pK9bmuPIKtcBdQMpFzZjLRZ9Jq+FyTdEQ1ktBVcWKPwbN9l+1HmFStMoLoD0feyYr
         lhHPKL33GANHZwSK/odJLbZabXhP0c5GuAcDGw9JbHTMbnaBZuvIipnedy42+R9lSNqX
         23Zj8cUsSfjr06nLeW/1ujU2aa+ugu82ujqs4Nvtj1PbpzBGqad8DQ7IOQzz7OzFtgMA
         vGQffCW71vgEkJCSNakHmAW1DgnHJL4aPHvdMjIJRi87rSZCIch+z5t/Wrjfpo2kMFDa
         6mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242562; x=1775847362;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUEap9ZtLAOWWOdMbJTcGPlnUuslrijse69P0jdZIjA=;
        b=OMIgDTskq2nkcyVRnIJX9FwIMcRPkBWRbNM+l8twJKavEgXwSG4ybUPXXuCIvasCvP
         iSDrHk9B0k5yBHITzwmCMWyu7ZwofJTX60HiND+juH3NXF3g0wigVGE3ile7sQDcuSnp
         C9pZM9Cwg4HrDCV2+XWAgr5YlnpLjjVqOFEMeneJP+SpfEtRr9/JA/H0blwug5v4qV8V
         kkdQNZQg4Nhd/OnwH5ddysZS9bhcLKOeJyu76L6iT05EnMkY0oJ41HR0J0cVQ4WEskOr
         EDgEyDraloIeHVNbVn8M70n42m30HeRdCvOeOJ6Bb1IXT3asApQqB1BOtHzqOAfch5yC
         FZHA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ys/fxXsAdHhbm+k5cVRllCbZM7sOyp9L/9hLGSEaoiYgG4/3wRjrF4h38W35TMmgMbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGu3cMtvcEDWxPK9ReLQmPdouertY2KPcELJA6cf2HEihhgoI
	+nblfoiA0deHS4zk9Pwqc8TNjOwSNqmablx4EyJhj4tcM12OQoM5LMNY8s3LSI2bQWI=
X-Gm-Gg: AeBDietJRe5wvKnW7W/oxp54G43crTEXTwo/xBDuEzxp6/mF04NxqOnLwmk0qsyxxNC
	mTUi7Ba7rk9FfpBenjLRbfZq2lg8IKAYzsxpHtPdn0KIOncgPtzAVwFdtBo9IaaKrF/OaKRLj6g
	q5th2hIMBkFNrY9tS5tjqd9aKcXifx8xtgWx99s+GKbD1L4a+ph48Rrc0/58skw4RamkeM62BPb
	/FWfzKo7BmNVu3bV/HqpQdN77+91WW8TqyC0sjto2FbRLsYJfG0WnRrcq94TWavpO1bAxJ5spUp
	HM0SJiMBV35cTnS3NLzvXLT2FWTWemePQxQODnEL6gpnk5qEbHKzZWGYS1Ose+8SisMsCZcHayO
	JNnI4u5sot1s5Z1tCU8W2bB+u0UzxZAlHtrzI1m/PeLweG+E1vGeztzJz9Io9oVMjelkwggq2JU
	Nq6cG7ync=
X-Received: by 2002:a17:902:e78c:b0:2ae:c916:511 with SMTP id d9443c01a7336-2b2819173d3mr42659205ad.24.1775242561526;
        Fri, 03 Apr 2026 11:56:01 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475ff56sm63177805ad.22.2026.04.03.11.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 14:56:00 -0400
Message-Id: <DHJQYTHUJH8L.2757EBVNFL6PZ@etsalapatis.com>
Subject: Re: [PATCH bpf-next v12 5/5] bpf, arm64: Emit BTI for indirect jump
 target
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Anton Protopopov" <a.s.protopopov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Shahab
 Vahedi" <list+bpf@vahedi.org>, "Russell King" <linux@armlinux.org.uk>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, "Johan Almbladh"
 <johan.almbladh@anyfinetworks.com>, "Paul Burton" <paulburton@kernel.org>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>, "Luke Nelson"
 <luke.r.nels@gmail.com>, "Xi Wang" <xi.wang@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, "Wang YanQing" <udknight@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403132811.753894-1-xukuohai@huaweicloud.com>
 <20260403132811.753894-6-xukuohai@huaweicloud.com>
In-Reply-To: <20260403132811.753894-6-xukuohai@huaweicloud.com>

On Fri Apr 3, 2026 at 9:28 AM EDT, Xu Kuohai wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x468
>  bpf_prog_test_run_syscall+0x280/0x3b8
>  bpf_prog_test_run+0x22c/0x2c0
>
> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 7212ec89dfe3..aa5cd240cdda 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1198,8 +1198,8 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>   * >0 - successfully JITed a 16-byte eBPF instruction.
>   * <0 - failed to JIT.
>   */
> -static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> -		      bool extra_pass)
> +static int build_insn(const struct bpf_verifier_env *env, const struct b=
pf_insn *insn,
> +		      struct jit_ctx *ctx, bool extra_pass)
>  {
>  	const u8 code =3D insn->code;
>  	u8 dst =3D bpf2a64[insn->dst_reg];
> @@ -1224,6 +1224,9 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx,
>  	int ret;
>  	bool sign_extend;
> =20
> +	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
> +		emit_bti(A64_BTI_J, ctx);
> +
>  	switch (code) {
>  	/* dst =3D src */
>  	case BPF_ALU | BPF_MOV | BPF_X:
> @@ -1899,7 +1902,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx,
>  	return 0;
>  }
> =20
> -static int build_body(struct jit_ctx *ctx, bool extra_pass)
> +static int build_body(struct bpf_verifier_env *env, struct jit_ctx *ctx,=
 bool extra_pass)
>  {
>  	const struct bpf_prog *prog =3D ctx->prog;
>  	int i;
> @@ -1918,7 +1921,7 @@ static int build_body(struct jit_ctx *ctx, bool ext=
ra_pass)
>  		int ret;
> =20
>  		ctx->offset[i] =3D ctx->idx;
> -		ret =3D build_insn(insn, ctx, extra_pass);
> +		ret =3D build_insn(env, insn, ctx, extra_pass);
>  		if (ret > 0) {
>  			i++;
>  			ctx->offset[i] =3D ctx->idx;
> @@ -2079,7 +2082,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  	if (build_prologue(&ctx, was_classic))
>  		goto out_off;
> =20
> -	if (build_body(&ctx, extra_pass))
> +	if (build_body(env, &ctx, extra_pass))
>  		goto out_off;
> =20
>  	ctx.epilogue_offset =3D ctx.idx;
> @@ -2127,7 +2130,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  	/* Dont write body instructions to memory for now */
>  	ctx.write =3D false;
> =20
> -	if (build_body(&ctx, extra_pass))
> +	if (build_body(env, &ctx, extra_pass))
>  		goto out_free_hdr;
> =20
>  	ctx.epilogue_offset =3D ctx.idx;
> @@ -2136,7 +2139,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  	ctx.write =3D true;
> =20
>  	/* Pass 3: Adjust jump offset and write final image */
> -	if (build_body(&ctx, extra_pass) ||
> +	if (build_body(env, &ctx, extra_pass) ||
>  		WARN_ON_ONCE(ctx.idx !=3D ctx.epilogue_offset))
>  		goto out_free_hdr;
> =20

