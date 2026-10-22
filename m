Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628923;
	b=5lSTjelZVWx7VDkHNbn6Yjzw51TTd1Ojf18mmRQ6Y+3gozbqgmnYIq7eFM7YXD3X+eYu
	 HH5g4YAMRewn/KT6JCoGox0s6eN1AQEKNdFV/r175FkEoPp8qad92+FHqTRN7VrLrPf7Z
	 dxoTj2Il1jiT6P/SiyNOPF6etVNYPGs3ziUBIPENmVI/tW8vc6cQYCkcN40cA0TjA/8b5
	 TZI0ow+2PsMzTTGG5GmF8e28doQYf3t0n34waGoDM8RztW95uq8Z1cF+UKFE0ITl25/ua
	 B998G5qTOHfZPFWlYPfdsJrysi+pCfGZj/SZb97KM+Eu/1JS4+fAIlgfoYuv7l+bfLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628923;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Dq8D2FU7KtoeRtknAw5Bmg11QNP3OOaemAPqVHOL+Zo=;
	b=44I/JiT0gM7jmATG8LgbRpJi3W1BJ/I/T9q3CtnpeF3lNn9KFxosFD1Wy7ikXKXZSJfF
	 ssLAU2P5PRIpNhL0EiIcD6sCTL1dGEgyM8vHvUORHlvsqjljHPG8bGLa3BzgDzEVmJTgk
	 JF4+e8vYxxdcgn5XsULxRBOiMEbRCEQZqt2A8dZ9LkKC3GcjXZtCY8c6phdprn9z2HbpL
	 tdbR+Pq0enRtnOmwPy9yehKbRWy1M+928s9yYaJ79wXXL1N/me041NeCMOifUCQ3NgJe5
	 s0Hhy7ZKodoIw0EzirGdJSxNwyIy6ZgR8MRlCcJRmaRKaD6Al7MyasIcdXjFtlSPF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH09QCu4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EA606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH09QCu4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8921F000C1;
	Thu, 22 Oct 2026 00:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628922;
	bh=Dq8D2FU7KtoeRtknAw5Bmg11QNP3OOaemAPqVHOL+Zo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TH09QCu43fGbQ9zmYyzrqQ1gWV5TNkU8uTP7ovy/S9/pLhWFtf1iEE+kFBOjIp2rc
	 ImHayPrR9hufC2pc5NWaLcLM6Qz1yktDiFMP4T5URjeU329uQbyFXzf18EmdrByDUx
	 grlbuM9bPj4sDFITT+oPnFPIRS20ZqaXW2xrVqH0ENssrWzAukLAz466To3UlSo2JN
	 x4cF/Z+RMJVLpZoBBRe1K6FeSowzeCrdBmZjqNvK0dUgisg/Cof2HPxftqA/+TI81b
	 PiEx+wJGvkxHS/s6qCan6R+lASf4QGfm8GBp9PdekjHGTLzu7gcFLNGNklq2xf2Uvc
	 rlezCzHaliX/A==
Content-Type: multipart/mixed; boundary="===============7952187598411175695=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d70930cfeba5ec2950138a3855022e5d2ed2d0740bfaddea770f5db5a839a7ef@mail.kernel.org>
In-Reply-To: <20261022080500.100-4-szwyb123@gmail.com>
References: <20261022080500.100-4-szwyb123@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: say how to fix the missing LLVM skip for jited checks
From: bot+bpf-ci@kernel.org
To: szwyb123@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 00:28:42 +0000 (UTC)

--===============7952187598411175695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: say how to fix the missing LLVM skip for jited checks

TL;DR: The new skip message says installing LLVM libs and rebuilding suffices,
but a stale stub jit_disasm_helpers.o may be kept, so the skip could persist;
a clean rebuild or SKIP_LLVM may need mentioning.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 824e5912ebcb..a45e6c8202eb 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1506,7 +1506,7 @@ void run_subtest(struct test_loader *tester,
>  					     tester->log_buf, tester->log_buf_sz);
>  		if (err == -EOPNOTSUPP) {
>  			printf("%s:SKIP: jited programs disassembly is not supported,\n", __func__);
> -			printf("%s:SKIP: tests are built w/o LLVM development libs\n", __func__);
> +			printf("%s:SKIP: rebuild with LLVM development libs installed\n", __func__);

Is "rebuild with LLVM development libs installed" enough to get the jited
checks running?

The commit message frames the fix the same way, saying the old message "does
not say that installing the libraries and rebuilding is all that is needed".

The stub get_jited_program_text() is chosen at compile time by
-DHAVE_LLVM_SUPPORT, which the Makefile adds only through a target-specific
variable:

    $(OUTPUT)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)

jit_disasm_helpers.o is built by the generic rule:

    $(OUTPUT)/%.o: %.c

and that rule has only the .c file as a prerequisite.  Nothing ties the object
to the LLVM feature detection result or to the CFLAGS used.

If a user sees this message, installs the LLVM development packages and runs
make again, would the existing jit_disasm_helpers.o with the stub be kept, so
that the same -EOPNOTSUPP skip comes back?

A build with SKIP_LLVM=1 would also need that variable dropped, which the
message does not mention.

Could the text say that a clean rebuild may be needed (removing
jit_disasm_helpers.o or running make clean), or name SKIP_LLVM, instead of
implying that installing the libraries and rebuilding is sufficient?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39699006936
--===============7952187598411175695==--
