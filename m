Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5C37204E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653161; cv=none; b=TBR9XA4KGizdEXI+/Xy/Wi9I4IORFc+GIUu62mGSkZFu0CuGR4d1Cavhx4F9n1I7sIF1GdPjdYis9GDoX5Acb3T1lSuRTeTJb2GVJIqHX7//5mQoA4E4IVX8qYOnO/F7IKymqNKYusoaK+i19AcTNF0KynSp/lO589EqffWeSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653161; c=relaxed/simple;
	bh=ctalL7alOssf6g8SfjR7c3SZtN7sUh8+AQvPqbnMrcY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XGaZzRmmLMDuYFliZylUSYZpOACFVxNfTXAhl1QHpOh9h9gEJ80e65vJdmMalmqjCxrhEHwoncYzwhxYh+3ngaSrxyYxCtjvHNGgKDPhRZE8VBpwipbpGi1p4Pzw0cX0iu57GQIOfqcB0kC/VkvvN/WB43BhVtXxYxV+kluFQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Zv8IXBcW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Zv8IXBcW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84867f07d63so12998387b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784653159; x=1785257959; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=22xnVWwcyautWpqTm1Qj41yuVWGwsZxiApP+76IF9XI=;
        b=Zv8IXBcWTO1/6dt+glgPqnj/ztKAQq3OlXzNjjHheeyuGDZdVRATN45Loo22hkHw45
         RQbGgUXSL7g80BAR1/WOkMIxfe08Emm7YV7HY1TVBgWJdo82kEJ88EoQ8BzNvugO7noX
         5uSVMj6CBr9scfyZpo8oBnoDXohe1KmKpigB2HrjRK/C2Xo9JC5LK1ZKGhVRYUDvQPzs
         BtJeKqUXT2x+eO2jcYFJEMtA3TvOVCj6ojoySF2qMgPPwXqUW06MfVMT9rCoQX+zbQQu
         kkwQVGOO59oVS3TaZu7pPyM9cxQkePEVZe0oIMuRNwdKEG/PT1VBjZCdzxDVSOW/Qtn/
         X8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653159; x=1785257959;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22xnVWwcyautWpqTm1Qj41yuVWGwsZxiApP+76IF9XI=;
        b=Oij3TrZSya+Uk6+PhOKudA8sZTD2weY4yEiGVMQKlrM2qn1MZFG2R7levZEY82Io7G
         IJ16ppxUlcUzWBBNeyZfltbZkW9yZiIO1G8jhIY5UhqqyMx2l+VrGhIuvNWVcMtj/xTc
         7kMEtLHi80irc793HPu2b4RYhnczwXZn8LnPI/VATMzOoHCKMPvNwLnwCOrQjAwRLskU
         l48HCoR15geKZY+zGlm7i6LAvfOYaLPu38/JDiwMVZMtR6UliDsSmNTxpAHBDoT146/6
         x4wl4W9+jZWXCZwT5CM515vES6/Z2wrAI5TeSjOT8KjAxAS/3iwIGgJmHXKwNfDqYz2n
         VZtA==
X-Forwarded-Encrypted: i=1; AHgh+Rofdr+tNbNRssCGi4gLcGA9d1WGhFbQWQoLyrImKwOnMTEs11A5uhjdgMO6+CjTyTbv/AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqqidQFbAi2L2PHkUWoXOusnWsABBR8CYxGleRWX0Drg3BF6d
	+RoUOil9zGqTsJWtTZGgNBj2au7kk8ULLyDWC3qKUmsP2U8MPI6ciH2IoqqY8ersU+A=
X-Gm-Gg: AR+sD120961f15tPHydV0XSBIl/5uFRzq5YBcR/TMt7G5elUYtgxkRADeCOOBNL3Bv5
	i2aYHeIl7rOdeu5M3ShBsrnarzA0R3DURn3gvg4BG71oRiWmpj5gLVwaGCBaRTV0ibY4tgqCGSH
	RuRgd9R1+FNlRF9/vhMmFXzsC3Gkgnn2vqWH3zauMcR8sU02GzvjRHBr0J+L3e5rH1nhSRVTfqk
	bRjKQOEEMxvINoBnykfqD9IMeEfugBVOIanF2XWCGvbrSw8jyL8SPTLp7bQiPmdOYVV3LbJYsq0
	P2TXh/iHRT10+/OTahKW+1Ek2QJtDFIUh5i9FzSFKv4zldJoGRa/jbHlcvnCOFXGLZRUtFe0UQO
	p6hqInDUXkuw5NvfIcorSgxVfmPA6KFLEj1OoL1JzI+VYrqmakY+exv2UanW6fDENOVZSJONL3y
	0XRNVLl/2767apFmoe6/272YnF+uVwbmg=
X-Received: by 2002:a05:6a00:4208:b0:845:c906:5ff5 with SMTP id d2e1a72fcca58-84c292d5262mr17916863b3a.30.1784653159290;
        Tue, 21 Jul 2026 09:59:19 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm29191b3a.27.2026.07.21.09.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 12:59:17 -0400
Message-Id: <DK4EQUGQS7SV.2MRWXOMAW0EU7@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>, "Xu Kuohai" <xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next v2] bpf, arm64: Optimize cast_user code
 generation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721105921.1070501-1-puranjay@kernel.org>
In-Reply-To: <20260721105921.1070501-1-puranjay@kernel.org>

On Tue Jul 21, 2026 at 6:59 AM EDT, Puranjay Mohan wrote:
> cast_user converts an arena offset into a user address by combining the
> low 32 bits of the pointer with the upper 32 bits of user_vm_start, while
> keeping a NULL pointer NULL. The current sequence always emits six
> instructions: it materializes user_vm_start >> 32 into a register, shifts
> it into place, and ORs in the offset.
>
> The upper half of user_vm_start is a constant, so it can be written
> directly onto the offset with MOVK. Move the 32-bit offset into dst
> (which also zeroes the upper 32 bits), then MOVK the non-zero halfwords
> of the upper address, branching over the MOVKs when the offset is zero so
> NULL is preserved.
>
> This emits at most four instructions, and only one when the upper half of
> user_vm_start is zero. The generated code is equivalent.
>
> Before:
>   ; bpf_addr_space_cast(page1, 1, 0);
>   7c:   mov     w10, w8
>   80:   mov     w8, #1
>   84:   lsl     x8, x8, #32
>   88:   cbz     x10, 0xffff800087b80c20
>   8c:   orr     x10, x8, x10
>   90:   mov     x8, x10
>
> After:
>   ; bpf_addr_space_cast(page1, 1, 0);
>   7c:   mov     w8, w8
>   80:   cbz     w8, 0xffff800087b80c28
>   84:   movk    x8, #1, lsl #32
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Xu Kuohai <xukuohai@huawei.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>
> Changelog:
> V1: https://lore.kernel.org/all/20260717134817.2868291-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rename upper_32 and upper_48 to upper_low and upper_high (Xu Kuohai)
>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index b0075ece4a6e7..0f61662b900bd 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1284,12 +1284,25 @@ static int build_insn(const struct bpf_verifier_e=
nv *env, const struct bpf_insn
>  	case BPF_ALU | BPF_MOV | BPF_X:
>  	case BPF_ALU64 | BPF_MOV | BPF_X:
>  		if (insn_is_cast_user(insn)) {
> -			emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bi=
ts
> -			emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
> -			emit(A64_LSL(1, dst, dst, 32), ctx);
> -			emit(A64_CBZ(1, tmp, 2), ctx);
> -			emit(A64_ORR(1, tmp, dst, tmp), ctx);
> -			emit(A64_MOV(1, dst, tmp), ctx);
> +			u32 upper =3D ctx->user_vm_start >> 32;
> +			u16 upper_low =3D upper & 0xffff;
> +			u16 upper_high =3D upper >> 16;
> +			int nr_movk =3D !!upper_low + !!upper_high;
> +
> +			/*
> +			 * Build the user address: the low 32 bits are the arena
> +			 * offset, the upper 32 bits come from user_vm_start. A
> +			 * zero offset must stay NULL, so branch over the MOVKs
> +			 * when it is zero.
> +			 */
> +			emit(A64_MOV(0, dst, src), ctx); /* 32-bit mov clears the upper 32 bi=
ts */
> +			if (nr_movk) {
> +				emit(A64_CBZ(0, dst, nr_movk + 1), ctx);
> +				if (upper_low)
> +					emit(A64_MOVK(1, dst, upper_low, 32), ctx);
> +				if (upper_high)
> +					emit(A64_MOVK(1, dst, upper_high, 48), ctx);
> +			}
>  			break;
>  		} else if (insn_is_mov_percpu_addr(insn)) {
>  			if (dst !=3D src)
>
> base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2

