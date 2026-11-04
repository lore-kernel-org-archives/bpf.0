Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751074;
	b=mJEMJfpcHpyjLqPXpsr9777qH1qEFHLCIHThBb1VQZyQJHTs5zsgF7X9nifTBqti/aHV
	 pyksNmsKgswVh9E81N0KJ5Gi4F30i9S0ZiGdNN+gO78kfCx5Z8QQR+YspyCL6Xir08bMs
	 lxyM0vlrNYN7q2sw8oxEbBHezkPAdiqYXL6k2bieu3kvg7qtwudVdRZU6n207XPm8IMUs
	 ybW4O5K46NbwQiDQ9/BNE90ZmykdumKa8yHEN7UhScrX9xhNhTCJG+aZw9RuWDNl+U0sA
	 yrzsRWSqQlqjoqMqbs4X/IXQWHWv5wSuDnz1abgaZAmene18Ie+nyuYS7NBDBgwMZwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751074;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jgeWAqTW3mCNm/oMwm1hCkX77cfg//uB1x8i+B4HYzE=;
	b=cu/efYeGo98n950/VUtTNOu9X+8SwPpJq5kqgC03quzaWQIVLBvlJsT9ncmpSsH+Oqp2
	 62aXcISlxIMwonVc/2fVGr7Gv619R58eYvGadLjo60sfhQiKc3tuPksZkgCsno/yC9EOI
	 qj+uQ4KTvuCYwmRA1UUWgdtEh+I4bw1hbGxqdBOri+afv1XTRvUDEoVXdTopGp3hTpVeO
	 pPpVxctYpcdsFwkczOiovbpn+0yenvX8p85jXcfenLjJd/Nu2Pjgc+TjmCyqGBDHGuptT
	 oyLEp9ZV2Hn2NJh2McbW+CRWOygD9Omd64ARj9ikiHc99iKwuSoWhPTxs70J4jvTfXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvAMg6FN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA1606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvAMg6FN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3911F000C1;
	Wed,  4 Nov 2026 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751073;
	bh=jgeWAqTW3mCNm/oMwm1hCkX77cfg//uB1x8i+B4HYzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hvAMg6FNNcdO/o9QIaBWHRN4zheNJkMpcdFqDPy0qFFE04F2Wcw+hC5YFTVzTg20P
	 ET4M3aWihNvoom4f+GTAPkUSpwVTRSkfVMBu32qSREJfDS5NuAEI8axNHUGpyI6aXB
	 JL7Eix1pxz7jfM8QR32IkcqnyGskHzwoMt0Hft5PLWdIj07VCVycxK4Im4xViD5T1E
	 3w2ezpertpOnW1aCOcK8x/L07dO0nvWt/IDlkKObsuXThrqbG5gKVrW7eHu8cQlxWp
	 bI5uR0M2dUJNsy87wMUPb1yfGLvkOROiT0Fb4/PcT6YbTdecCdAnFAeogwmJfuy4ar
	 ZDVTWv/fh+LwA==
Content-Type: multipart/mixed; boundary="===============0723896134661938906=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2e3b7163c71acdc345acd3eef28d5c4348e5b4734f5198b586f5fa88f55887af@mail.kernel.org>
In-Reply-To: <20261103231931.89739-2-alexei.starovoitov@gmail.com>
References: <20261103231931.89739-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 00:11:13 +0000 (UTC)

--===============0723896134661938906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64

TL;DR:
- Docs/Kconfig text says x86_64 and arm64 "always" enable JIT_ALWAYS_ON, but
  it still depends on BPF_SYSCALL
- Nit: new sentence in filter.rst breaks the "This is even the case" flow

> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -90,6 +90,9 @@ Values:
>  	- 1 - enable the JIT
>  	- 2 - enable the JIT and ask the compiler to emit traces on kernel log.
>  
> +With CONFIG_BPF_JIT_ALWAYS_ON the value is 1 and cannot be changed. x86_64 and
> +arm64 always enable this option.

Is "always enable this option" accurate here?

BPF_JIT_ALWAYS_ON still has "depends on BPF_SYSCALL && HAVE_EBPF_JIT &&
BPF_JIT", so the new "default ARCH_WANT_BPF_JIT_ALWAYS_ON" is limited by
those dependencies.  An x86-64 or arm64 kernel with BPF_JIT=y but
BPF_SYSCALL=n keeps BPF_JIT_ALWAYS_ON=n and the interpreter, and
bpf_jit_enable (registered under CONFIG_BPF_JIT) can still be set to 0, 1
or 2.

The commit message states the condition ("For a kernel with
CONFIG_BPF_SYSCALL=y and CONFIG_BPF_JIT=y"), but this text, the similar
sentence in Documentation/networking/filter.rst, and the new help text in
kernel/bpf/Kconfig ("x86-64 and arm64 always enable this option.") leave it
out.  Would something like "x86_64 and arm64 enable this option whenever
CONFIG_BPF_SYSCALL is set" be more accurate?

[ ... ]

> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -404,7 +404,8 @@ Example output from dmesg::
>      [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
>  
>  When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set to 1 and
> -setting any other value than that will return in failure. This is even the case for
> +setting any other value than that will return in failure. x86_64 and arm64 always
> +enable it. This is even the case for
>  setting bpf_jit_enable to 2, since dumping the final JIT image into the kernel log
>  is discouraged and introspection through bpftool (under tools/bpf/bpftool/) is the
>  generally recommended approach instead.

This isn't a bug, but the new sentence now sits between "will return in
failure." and "This is even the case for setting bpf_jit_enable to 2".

"This" used to refer to the failed write, so the paragraph now reads as if
x86_64 and arm64 always enabling it is "even the case for setting
bpf_jit_enable to 2".  Could the arch sentence move to the end of the
paragraph, after "...is the generally recommended approach instead."?

The line "enable it. This is even the case for" is also not reflowed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41741570364
--===============0723896134661938906==--
