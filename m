Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914513;
	b=xaYzf+z2aVzAUaxsteXt7kbMtbmLmmSaqvsIU9hAgzyvxJ5svl/sG0lZMgHeebywhZ66
	 WypVMNjDB0K8uA5WPIU7c898W6cYjL4owXhVjotd4evnwUlAJBG0qxX3lah929Q4o2j+m
	 5EbC53rtenRY/UhQgy3d+VwG/e3Mddcb32+LIGuwYmApiRc+fauw37prYGppyZjrXfsD2
	 rnj3m1vr06BThLNclVSTYaanP7UpGxKvAiLCxwUq0HGiTeHi9kS1J2fkpP5tdTYKhLScz
	 hMabv7xVAAcuPL7cRTtMSyDOxVqAUQwJBOExpzBqp4zY071W6jYhdRqkJe1mzQAV17Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914513;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Z2KAClIBII5tHEMf47HcfT+vg+Bo282+RxaGODSo1Rk=;
	b=5H/2cZHrFuEgmqyvvUVJisq/ygm0sSW57AcDqJKZND+F9rvFXoYFKMPdBdtr0qFOk/9h
	 fdKh0ybXt81pJ1Wtw2q4Y1Ly+TmkEjQrl+DQWRYfhnrGW0biCIEn/nthXIGQIkGD8dugl
	 x8pHfRHi7eW7J8rKsOM1pCgqJwhL40Q8TU1Z3rIwfLs3OfmfD7siJM2R/Y2wcX5pGmM9L
	 DXSC03k52oj58529QmNq6qa7an+JZvz+8fwpn1uTNbtUc1j7e1nLvExQLGwniThWz1sQR
	 u7Tj25FO2mxSvKjJg6QP8a6Xr7t3hJTFYdslu49Vyx55p0qD/T68uTXqj9kQW6JgFEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaJclPUC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B3606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaJclPUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2221F008A1;
	Thu,  5 Nov 2026 21:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914512;
	bh=Z2KAClIBII5tHEMf47HcfT+vg+Bo282+RxaGODSo1Rk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RaJclPUCtvu4ZmQodqODH+APENcGSS8afdT/Smd+5p+ruYbNuHdpOFEq3GgRjg7Lj
	 yZ/YHfskCtHU9pvRwCFaQ1JcF5+HD7rxav3p/LCXI26wM4dbhYcStyxNnuVSy82G5e
	 swAuymKK65UX0/NtNQzjEOgnupf1YVKuCtLQILEhARQei9d45J2QSH+azfXvXXSKDo
	 doTSel+hXgeBr8FymSiqNGubKcYY0Gvreg1eywD4Jew+HODkjRFj4/GfM9n7cgioLr
	 immxBtrM08xGud0k2/obq77Ic1L1soXYKPpLXRArW2nOla4OhGH4/OlxO/EZIQoNMA
	 /voXhczYSXHEA==
Content-Type: multipart/mixed; boundary="===============7277707934895878030=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <00f385d9364efc146c63105939cac33b5b7fd3a8789b13c2d080bf985feb7e36@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-33-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-33-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 32/35] selftests/bpf: Test static subprogs that are verified on their own
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:12 +0000 (UTC)

--===============7277707934895878030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test static subprogs that are verified on their own

TL;DR: Nits only, in the new selftest: a possibly unneeded "r7 = r0" in
TWO_INNER_MAPS and a possibly leftover bpf_get_prandom_u32 import in
INNER_MAP_IMMS.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c b/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c
> new file mode 100644
> index 000000000000..2b847a7723b1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c

[ ... ]

> +#define TWO_INNER_MAPS				\
> +	"r1 = 0;"				\
> +	"call inner_map;"			\
> +	"if r0 == 0 goto 1f;"			\
> +	"r6 = r0;"				\
> +	"r1 = 1;"				\
> +	"call inner_map;"			\
> +	"if r0 == 0 goto 1f;"			\
> +	"r7 = r0;"

This isn't a bug, but is the "r7 = r0;" at the end of TWO_INNER_MAPS needed?
INIT_TIMER_WITH_R6 uses r0 directly ("r1 = r0;") and r7 is never read.

[ ... ]

> +#define INNER_MAP_IMMS				\
> +	__imm(bpf_get_prandom_u32),		\
> +	__imm(bpf_map_lookup_elem),		\
> +	__imm(bpf_timer_init)

Similarly, this isn't a bug, but no instruction in TWO_INNER_MAPS or
INIT_TIMER_WITH_R6 calls bpf_get_prandom_u32.

Is __imm(bpf_get_prandom_u32) here left over from a dropped variant, or
could it go?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============7277707934895878030==--
