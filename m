Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484F33E373;
	Thu, 22 Jan 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118045; cv=none; b=ag2Q5Y2H6LqXSYObeWv+jF3Ucd4WZ1EqjPC8XeMd4tuAyXbyCIrTl+eURLW1jj1gYqT/20nqCpu8RzuD9Stbbgy6WTDtE+wOCYMlbIHkqy//ED4JG+P9ASqOVgz6/JLdbq3t+cCQq2GlerkAkpkR2/iJM0WX8RGaR86LBj+BMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118045; c=relaxed/simple;
	bh=1Nnhn/yFdXfGhXqZb6rKEAIzjm4Y+H9DE9pNT3uRZvI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SWcV7bznAHfEItppVKH5hh2+56Kfhrun54V0o4mfXk1cvqFD2xNOwkMkKlLRBXAIpn2iUZSETpe+WGcorTysOCSjZoC7wGanaVKmNhnj2UnwIDjBhfihBA8reLda7gUBO4JOx0ktz0KLGi77UFvAaYwTI8jb8NpJlTKLqVBaJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkL2AwkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkL2AwkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EDC116C6;
	Thu, 22 Jan 2026 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118043;
	bh=1Nnhn/yFdXfGhXqZb6rKEAIzjm4Y+H9DE9pNT3uRZvI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WkL2AwkMslaNibmLrcuMqERxGf5wKIAOdkx8o4us6eZVCdZdz8edkbgVTZcR+xgTx
	 1SMhj7+EFi69sKB/pjAkBud0b7QX26Iye6Sk6gFoAVzktEX2XyiaLLdBzyrkBy8jbh
	 geoD9FYejgS90O/fRgoq788IywfDy/wnHMHx2sYAC6ui7u/+xmcoe5g2mthh3nTblO
	 H48fFg8AbRVMcPmuuMj0bP2PyHxVfoKzwiQEw0sLOAGonq8tCFxahgNKR2xtnGk2+w
	 +5fQEkzEduhsi4AeNsAefe/VmSMqLyCdHKgMu+fCiblaye7NiCJI6haIOHmxB+g99O
	 hiuUW9ldBWDpA==
Content-Type: multipart/mixed; boundary="===============4329220787654898227=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e63a916bd44b8352aace4fd47fdeb459dc75cceb71615f44e6234cc1b6ffbd69@mail.kernel.org>
In-Reply-To: <20260122211854.5508-7-adubey@linux.ibm.com>
References: <20260122211854.5508-7-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] powerpc64/bpf: Additional NVR handling for bpf_throw
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 21:40:42 +0000 (UTC)

--===============4329220787654898227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index c284a12fce6e..98780a15fc69 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> @@ -125,9 +149,19 @@ int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
>
>  static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
>  {
> -	if (reg >= BPF_PPC_NVR_MIN && reg < 32)
> +	int min_valid_nvreg = BPF_PPC_NVR_MIN;
> +	/* Default frame size for all cases except exception boundary */
> +	int frame_nvr_size = BPF_PPC_STACKFRAME;
> +
> +	/* Consider all nv regs for handling exceptions */
> +	if (ctx->exception_boundary || ctx->exception_cb) {
> +		min_valid_nvreg = _R14;
> +		frame_nvr_size = BPF_PPC_EXC_STACKFRAME;
> +	}
> +
> +	if (reg >= min_valid_nvreg && reg < 32)
>  		return (bpf_has_stack_frame(ctx) ?
> -			(BPF_PPC_STACKFRAME + ctx->stack_size) : 0)
> +			(frame_nvr_size + ctx->stack_size) : 0)
>  				- (8 * (32 - reg)) - BPF_PPC_TAILCALL;

For the redzone case (no stack frame) with exception_boundary, this
formula computes R23 at offset -80 and R24 at offset -72 from R1.

However, bpf_stf_barrier() uses hardcoded offsets -80(1) and -72(1) to
temporarily save R21 and R22 during STF barrier execution:

    asm (
    "	bpf_stf_barrier:		;"
    "		std	21,-80(1)	;"
    "		std	22,-72(1)	;"
    "		sync			;"
    "		ld	21,-80(1)	;"
    "		ld	22,-72(1)	;"
    ...
    );

When an exception_boundary program without its own stack frame executes a
memory load that triggers STF_BARRIER_FALLBACK, can bpf_stf_barrier()
corrupt the saved R23 and R24 values? The hardcoded offsets would overlap
with the extended NVR save area.

If exception_cb later restores these registers, it would get R21/R22 values
instead of the original R23/R24 values.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21265643939

--===============4329220787654898227==--
