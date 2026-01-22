Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF2316190;
	Thu, 22 Jan 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103136; cv=none; b=jFgAQHyQ4FIljtRUlWVvtoEEeWvlN5Nr6vv590tnSwnCiu3o8TCBMqfH6qHuf8Y4C6Jhou8Z+3o/98sp2LKGLQvWCB14x13ewXW/ypKCW6R8T/nRa5n4+jKtBS1fKjwC8qZfj/3M5WlaUvSHuUbYrIeplUaPgH3mNrrfLzqq4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103136; c=relaxed/simple;
	bh=A2CbCQzi9H7Y9xtWAzN3DehfmuNIC6HQVvniPElAetg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HQV5VHnRw+S1ymv8B4YRnTJc1eQtP/EuVyY1ThK9Pq5i6av0rsKPXKVTIF8H3FAgjRo9FgFBn9TBH6Jbejf2N2yZvDLmtdrxGNFF146hZ8feudaljnLLJi1cFOCrHJujCN035LT3eGmvgkfF4D+cDQQcwjOw41sKG2ZiapC1Kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktVDNiW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktVDNiW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D66C116C6;
	Thu, 22 Jan 2026 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769103134;
	bh=A2CbCQzi9H7Y9xtWAzN3DehfmuNIC6HQVvniPElAetg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ktVDNiW4BXGCpe67pIHOpMtbGTBn9xvT4FbWe/HXNT+/v4RPL4mzXjK4no16pIVc3
	 Y9jUuFKKJB2MEIWxBdwxa/o+uJA3EWjDFim8eESGL+U847fXuytv68jA8hHaVw7WMJ
	 DBvtQeGI+YuioHqDNX8Hhez3VXc7cKiFbO0MpJhBsuJQCy+/Hw+EoqHPa1WHuZ030v
	 wBZNRYtddTlGV9uz2F0KjyN5cJW5kRQB2TefI196UxObSTdQ9CmhteAEp0WYS1A5Kp
	 3io0CSaqiB9G5gIzqcS2Qda9XOzX3a1/ypMdp83jrlU/TTzqhlp4rLp/vLw2L8a26D
	 yTGUpoiUOJt4w==
Content-Type: multipart/mixed; boundary="===============5316141756419194533=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c8f39c15a39e7985d17afbd34fd8fd0a8c58e44fa21c1c08e03b27a430fa11b0@mail.kernel.org>
In-Reply-To: <20260122165716.10508-7-adubey@linux.ibm.com>
References: <20260122165716.10508-7-adubey@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] powerpc64/bpf: Additional NVR handling for bpf_throw
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 17:32:13 +0000 (UTC)

--===============5316141756419194533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index d7cd8ab6559c..cbaf811e1a35 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

[ ... ]

> @@ -245,9 +302,25 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>  		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
>  				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
>
> +	if (ctx->exception_cb) {
> +		/*
> +		 * Recover additionally saved non volatile registers from stack
> +		 * frame of exception boundary program.
> +		 */
> +		for (i = _R14; i <= _R25; i++)
> +			EMIT(PPC_RAW_LD(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
> +
> +		/*
> +		 * LR value from boundary-frame is received as second parameter
> +		 * in exception callback.
> +		 */
> +		EMIT(PPC_RAW_MTLR(_R4));
                ^^^^^^^^^^^^^^^^^^^

This sets LR from R4 (the boundary's LR passed as second parameter).

> +	}
> +
>  	/* Tear down our stack frame */
>  	if (bpf_has_stack_frame(ctx)) {
> -		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
> +		EMIT(PPC_RAW_ADDI(_R1, _R1, bpf_jit_stack_size(ctx) + ctx->stack_size));
> +
>  		if (ctx->seen & SEEN_FUNC || ctx->exception_cb) {
                                          ^^^^^^^^^^^^^^^^^^^^^
>  			EMIT(PPC_RAW_LD(_R0, _R1, PPC_LR_STKOFF));
>  			EMIT(PPC_RAW_MTLR(_R0));
                        ^^^^^^^^^^^^^^^^^^^

For exception_cb programs, bpf_has_stack_frame() returns true (the function
explicitly checks ctx->exception_cb). The condition on the inner if statement
also evaluates true because of "|| ctx->exception_cb".

This means for exception_cb programs, LR is first set correctly from R4,
but then immediately overwritten by loading from the stack and issuing a
second MTLR.

The comment above the EMIT(PPC_RAW_MTLR(_R4)) states that LR is received as
the second parameter, suggesting R4 is the authoritative source. If
exception_cb and exception_boundary have different stack_depth values, the
stack-loaded LR value after the ADDI may point to an incorrect location.

Should the inner condition exclude exception_cb, perhaps something like:

    if (ctx->seen & SEEN_FUNC && !ctx->exception_cb) {

Or alternatively, should the EMIT(PPC_RAW_MTLR(_R4)) be moved after the
stack teardown code to ensure it takes precedence?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21257691486

--===============5316141756419194533==--
