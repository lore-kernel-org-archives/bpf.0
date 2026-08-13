Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4932C0296;
	Thu, 13 Aug 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609562; cv=none; b=nrZyfAuRBEmjbcBL3JLnMuiwMiZ+TcIcAfZ3VLW6asHR1c5bsgshX0/5amvY//hWK6FhXedlBugcty44naOh18liIvlQt6yjh7OpSda9jpVQxBvMnT0TGIuVu37NWwl4DpaI3VUJJTLC+yDvUBLrCCl6f2UcRdhzCj8YT+0lkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609562; c=relaxed/simple;
	bh=Z/QMwEFQ+wfYJwRa7hW/XWEEz7kpdxuoy+8PcpJIaYg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aYuy2D5+a1UiLD//ZSmZsDotpwyVcTVDxgVBW9xlqUkxAdKYPh7t8+bPeZ7h+lhZ9vlBi9LPK9vJLHvrt6vJWKv7DzWeru8xxZU/hzQVlNjmBc02QFW1TG9gywuVRv2rKWMoEwLKMdsz+cmlrS2mxjGTT4EJq0/qvKTGGQK6xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwIu5d1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwIu5d1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950FC1F000E9;
	Thu, 13 Aug 2026 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609561;
	bh=obn/EMEesbhZsX+qKEo8zGOFdBe9hUAb9STi1LPgdJE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nwIu5d1oPa1fXgoPUfp0JTt45Kw7XVmv95W621TXtqNpUXFgCzvkfs73NrSrsap/t
	 wXY38kqLV+ZXugiaP4jgVptA4S/BXmTOLDMHYylTXb0JJ3Ts73XTyyK/bZeD1vKQC5
	 2H5I4ca8iBUbAWlMr5zMNfkW+smRNZ6Of5KjndbSR3OhOoWMEFK4moXm9WWF/aDcRV
	 SXznxGRg5M/YWb4/+AKpSPEoWNwQGCARLeWnXX7LGTZhuBHN0DvmKFK7b4j49ui8Xk
	 Q6ml33v01/Eo5yy5jlA1AYBS6F91Ml44+fvB9/QA3e7FvNd5FCwckHX9/EAeO9Jz1Y
	 fT5f7v3a/B+ug==
Content-Type: multipart/mixed; boundary="===============3986060981658393482=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b9781ebbc70ad4c748f4c08d94bbe6994b4e0fde867a8bf252b5d0f08a985dee@mail.kernel.org>
In-Reply-To: <20260813-bpf-riscv-stack-args-v2-1-efea8f9b3fe1@kylinos.cn>
References: <20260813-bpf-riscv-stack-args-v2-1-efea8f9b3fe1@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, riscv: Add BPF stack arguments support for RV64 JIT
From: bot+bpf-ci@kernel.org
To: jiangfeng@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,jiangfeng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 08:25:59 +0000 (UTC)

--===============3986060981658393482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf, riscv: Add BPF stack arguments support for RV64 JIT
>
>     Add bpf_jit_supports_stack_args() for the RV64 JIT so BPF subprograms
>     and kfuncs can receive more than 5 arguments via the stack
>     (BPF_REG_PARAMS / r11).
>
>     For BPF-to-BPF calls the caller writes outgoing arguments at the
>     bottom of its frame (SP-relative). The callee reads them with
>     FP-relative loads. Its FP is set to the caller SP in the prologue,
>     so the offsets match.
>
>     The RISC-V ABI puts arguments 6-8 in A5-A7 and arguments 9+ at
>     SP+0. Before each kfunc call, load arguments 6-8 from the outgoing
>     area into A5-A7 and copy any remaining arguments down so argument 9
>     lands at SP+0.
>
>     A5 (BPF_REG_0), A6 (TCC) and A7 are safe to clobber here: R0 is not
>     live before a call, TCC is backed up on the stack, and A7 is unused
>     by the JIT.
>
>     Limit the existing kfunc sign-extension loop to MAX_BPF_FUNC_REG_ARGS
>     iterations; otherwise idx >= 5 resolves to S1-S5 (BPF_R6-FP) and
>     corrupts callee-saved registers.
>
>     Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

This looks like a bug fix for stack argument support. The commit message
describes how the sign-extension loop was limited to prevent corruption
of callee-saved registers S1-S5 when idx >= 5. This fixes an issue
introduced by commit 443574b03387 ("riscv, bpf: Fix kfunc parameters
incompatibility between bpf and riscv abi"), which added the
sign-extension loop without limiting it to MAX_BPF_FUNC_REG_ARGS.

Should this include:

  Fixes: 443574b03387 ("riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31677823910
--===============3986060981658393482==--
