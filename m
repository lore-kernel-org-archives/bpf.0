Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CD2E2852
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618068; cv=none; b=ctqjP8leFWy/EGKDchg7EKA7VoyvhVUFFXdzQo+yyvwq7uG8R9dsWDyeWvx4vkn8TIki+ZgDyqkgt6mKovfQpiMGIao7zp1e270XPQNWUPG0bz9XggV/5mPFmPeqNZrga9IzDVS9jR9kbfMszter7DwnH5aq3MXQV/Q5xoq7cSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618068; c=relaxed/simple;
	bh=CsiBrrpTQnVpbOShEll+RDt1PQM5ywpR0BgwEPQqBKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=orMcpnGs4/fuoKDcZWDVYSVGM94WVaubi66uvi2SoVLBfs5aXigz4s1l5Sfn3fzbcM+0PoVpPglz4vmvoLnTYkTX3nbhh5cC4yGNXon4VjZ33O1RMvlW8RZK3wca9inwvKWQQdiCv0sT/chk/x+op8Zk3DDAuvRyJCRfDCFSde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJmjfLHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJmjfLHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06B71F000E9;
	Tue, 16 Jun 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618066;
	bh=MRQVN4+X44X0eiw2s/2obUsYdlNaU+LJHmXcG9C/oDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJmjfLHA0G/2fLBMe2lw8P/l9FLOqOMgTkpErT+a7+GHRU1Vr07fp4WGp9Qo+EQCd
	 sKwIL6uPYBFvURPc2EtXum5BpZKvkQo0btc5sTR7HSzhmEEOYcoCg0PwZIsrgEXHp1
	 m30fIhKIN14a87LM9iiFYxSItZwT4NZI8vXm6RxbsGETo8gzLxXnnz6tSGUiXpwt5X
	 RV1o3dch3HLmeRHVNOV6GwdJ4A6BkYPu0191iXned1ktfx94UjwKNaepqv4CsvjwJ8
	 /1ZvbpVIFisIzks4TJLaH1NZ37GFTCqnxAPS375tqdAeypOF9BU2iNNH5v4/hVHO/r
	 khvNnn+y17Ovw==
From: sashiko-bot@kernel.org
Subject: Re: [bpf v8 7/7] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616164741.32252-8-adubey@linux.ibm.com>
References: <20260616164741.32252-8-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:54:25 +0000
Message-Id: <20260616135426.A06B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to fully fix the 'branching past the real epil=
ogue' bug because it does not handle code shrinkage during the final JIT pa=
ss, leading to a corrupted epilogue and guaranteed kernel panic.
- [High] The percpu private stack (`priv_stack_ptr`) is leaked on BPF JIT e=
rror paths when compilation fails after the image buffer is allocated.
--

commit a57a77fa21aefd217fa32d1d3d0098dd6df6131f
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix buffer overflow in JIT for large BPF programs

This commit addresses a buffer overflow in the powerpc BPF JIT by ensuring
the alternate inline epilogue instructions are counted during size calculat=
ion
in pass-0. It also resets alt_exit_addr and recomputes the epilogue address
at the end of each pass.

Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ib=
m.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index c5a2874469221..baacb2855c072 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
[ ... ]
> @@ -347,6 +347,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verif=
ier_env *env, struct bpf_pr
>  			bpf_jit_binary_pack_free(fhdr, hdr);
>  			goto out_err;
>  		}
> +		addrs[fp->len] =3D cgctx.idx * 4;
>  		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);

[Severity: Critical]
This is a pre-existing issue, but does the fixed 2-pass compilation
loop fail to handle code shrinkage during the final JIT pass?

It seems the PowerPC JIT uses a fixed 2-pass compilation loop rather than
looping until the program size converges. While adding the assignment of
addrs[fp->len] updates the epilogue offset for the next pass, during pass 2,
an early exit that was out-of-range in pass 0 might now be within the 32MB
range of the pass 1 epilogue offset.

If this happens, it will emit a jump instead of an inline epilogue, causing
pass 2 to shrink. The pass 2 epilogue is then written at an earlier offset,
mathematically guaranteeing that it overwrites the first 4 bytes of the pas=
s 1
epilogue.

When executed, a jump targeting the pass 1 epilogue offset would immediately
execute the instruction that replaced it (often a return instruction like b=
lr),
returning without restoring the stack pointer or non-volatile registers. Co=
uld
this lead to memory corruption and a kernel panic?

Also, looking at the error handling path later in bpf_int_jit_compile():

arch/powerpc/net/bpf_jit_comp.c:bpf_int_jit_compile() {
[ ... ]
out_addrs:
		if (!image && priv_stack_ptr) {
			fp->aux->priv_stack_ptr =3D NULL;
			free_percpu(priv_stack_ptr);
		}
[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code leak the percpu private
stack (priv_stack_ptr) on BPF JIT error paths when compilation fails after
the image buffer is allocated?

If bpf_jit_build_body() fails during pass 1 or 2 (for instance, due to an
unsupported instruction or a branch remaining out of range), the code frees
the image buffers and jumps to out_err.

The cleanup logic at out_addrs uses the condition if (!image && priv_stack_=
ptr)
to determine if the percpu stack should be freed. Because the image was
successfully allocated earlier, !image is false, and the free_percpu() call
is bypassed.

Since the JIT compilation failed, fp->jited remains 0. When the program is
subsequently destroyed via the standard bpf_jit_free() which checks
if (fp->jited), the function completely skips freeing priv_stack_ptr.

Could unprivileged users repeatedly load large BPF programs that pass the
verifier but intentionally fail JITing to exhaust percpu memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616164741.3225=
2-1-adubey@linux.ibm.com?part=3D7
