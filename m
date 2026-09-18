Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF92367D3
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707821; cv=none; b=XZh88fFRgfb5WW4GpK5eqVRo00GTiGW+LBKApZiEcW6zUTm89YqR/MLTSKf/WM52bTZxQQ+6skHWXISpMrSyB5sFQIHHQLEh7kJI0Nov03ZYy73OU/mMeel3zYl373TtphoRdUyr94TNNYcPSoYiV1sTNW8YqHl1k0pR66inQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707821; c=relaxed/simple;
	bh=sMh3CG3Ppotmifkg8Ye+EFPpOKiejPGDnXMLvFQTyuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c38rwWJB9QbTrbjiwi0kZNDQy7aMpE1044eAQbvF+puONwipHprlBG49UVzt/Qe3sO4NqP1kvdlU4gKfWPnQ5mSLH1REfxxiTz1Q9NHFhIjQ4fJaXW0kVeaNAkmpyLHxJBGDlaB3fjsL3S9Dkstyq76+ClkHu8T8cB6tEr9aJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/X+BWhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/X+BWhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415601F000FF;
	Fri, 18 Sep 2026 05:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707819;
	bh=atuEUq6A6fqTkYsRmXIQahApAxtK8XJfSc5Aa6DQxvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/X+BWhVlMLev1dwkKJmANrnOb0dDFLGQ/15OglGRAwi4VUximcWWK3p6yGp9jFse
	 +SAw6XZHOJjvkkpTQoAiFOObHoOLoZe8irAUu2uQdQCeLVas5e/fm9cdX3UMjKCHJP
	 0UGFlWNTisfaKker4TptmaKm4QBZNnj7C+HAbE+CXuvuxa76US5Jp5AKfMvVjDAAi3
	 1A+kiYi9rv5rs7yckndbwItUNkyzl6QSu6WmnKtPghNW5QCe+2VAzN3zZSzycCPB/d
	 7se3IOOXa8Au6gDjzkqZQVdvV5+Cw251VjUwdGk7nTEtiPDCvjaDoe0NIIlShg3AbF
	 m/vPEtmXCICRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 11/20] bpf, x86: Dispatch exception cleanup
 pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044253.3289522-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044253.3289522-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:03:38 +0000
Message-Id: <20260918050339.415601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf, x86: garbage kfunc stack arguments in exception cleanup pads
--

commit 1e32297a3c2c4f6bbc4d458bc25563bed8167f6c
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Dispatch exception cleanup pads at run time

This commit provides the architecture-specific support for x86-64 exception
cleanup pads. It forces a full callee-saved spill for programs with a clean=
up
table and introduces arch_bpf_run_cleanup_pad to execute the pads.

> diff --git a/arch/x86/net/bpf_cleanup_pad.S b/arch/x86/net/bpf_cleanup_pa=
d.S
> new file mode 100644
> index 0000000000000..da4b448ecf095
> --- /dev/null
> +++ b/arch/x86/net/bpf_cleanup_pad.S

[ ... ]

> +SYM_FUNC_START(arch_bpf_run_cleanup_pad)
> +	ANNOTATE_NOENDBR
> +
> +	pushq %rbp
> +	pushq %rbx
> +	pushq %r12
> +	pushq %r13
> +	pushq %r14
> +	pushq %r15
> +	/* Keep the pad's entry rsp congruent to a normal call's. */
> +	subq $8, %rsp
> +
> +	movq 0(%rdx), %r15
> +	movq 8(%rdx), %r14
> +	movq 16(%rdx), %r13
> +	movq 24(%rdx), %rbx
> +	movq 32(%rdx), %r12
> +	/* rbp is BPF r10, so this is the whole of the pad's frame setup. */
> +	movq %rsi, %rbp
> +
> +	/* CALL_NOSPEC needs the target in a register; rcx is BPF r4, dead. */
> +	movq %rdi, %rcx
> +
> +	/* BPF r0 on the way into a pad, not whatever the kernel left in rax. */
> +	movl $BPF_PAD_ENTRY_R0, %eax
> +
> +	CALL_NOSPEC rcx

[Severity: High]
Does this execution environment cause kfuncs with more than 5 arguments
to read uninitialized garbage stack arguments?

In arch_bpf_run_cleanup_pad, the pad is executed on the unwinder's
stack (rsp), while rbp is set to the original BPF frame.

However, the JIT unconditionally writes outgoing kfunc stack arguments
relative to BPF_REG_FP (rbp), as seen in emit_kfunc_arg_moves in
arch/x86/net/bpf_jit_comp.c:

                else if (dst_mem)
                        emit_stx(&prog, BPF_DW, BPF_REG_FP, reg,
                                 stack_base + (dst - nreg) * 8);

Because rbp and rsp are desynchronized in the pad, the arguments are
written to the old frame. When the kfunc is called, the C calling
convention requires it to read stack arguments from [rsp], which points
to the unwinder's stack instead of the original frame, leading to
garbage reads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D11
