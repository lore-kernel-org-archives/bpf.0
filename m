Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C853E6DF4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191570; cv=none; b=e2b0Zkpf5Gb+3KLe+kDHZBqDx/4W1PCTin+V4/qYt8T3viLRKHFq6TDk3wXOFSZ9K91Mqiqo7oSbcpR1wVh/nEFn45gg+YDvvIIrS+aRHF32+8XX7nX97my1A11WH0lCkkLxXFfasRjT9gAQIx5Fd5aweBS1CA72egcy/y1mSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191570; c=relaxed/simple;
	bh=Qh1CCBCHJp/zokwPP//s9rm1Y6jzv9brzDRep+tVzCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MDAoAn2fDJyHX9kEUP7+08Keuj7voh4Jg3M+ELFLsdqajhhCGx7r8Dm1quS1NHrGk+p8ztPRbyWqr3iSaqwkqXkBB2LTMWggI8CV4oW+Uq+HcEBNl8BkcmDnnmk+w4UJbz8OXsC1JpMmZ241LvaT0cjjnI5JLOCI8mJdRkEAbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzRLthfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzRLthfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC661F000FF;
	Wed, 23 Sep 2026 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191567;
	bh=RNVx5m2vzUBCVEDEYzmh3eOtlAWxx1UkLpEXjwoeJPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzRLthfWUDqzEFCT+gWL7XGCGYUpmhNMaWpnQw+6u6QVXGGYSIB6TIipXCpCh+3rC
	 SJOnCus0tWPdF9g1FgaS+Q1OlwMqhA1Z/YfZsi15yjafETU9cXH5ed6zwxFvrHoE8T
	 W90n/UwEBCg3cLhLAsPpccavFuBDsKbGYAyLTQ0DUbfY9gh3RgdLTcIuuFAcURZHFH
	 XG6ne7UY/2XDvkUQ7NBSCHXtZjRy0XZecu8xYgnIaM4yDIGbzIi2ohLcLfnXB+Jfnk
	 x2dvuCcYrI4kG07inQDnJgiJkPsfBslX8u7cPHjAAv0+VTd1s4o7Fmz+YgWdpMGprk
	 2nx6rzREnyb2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 11/18] selftests/bpf: Check liveness merge
 of masks with different widths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923191139.2816206-12-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
 <20260923191139.2816206-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:26:07 +0000
Message-Id: <20260923192607.8FC661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: merge_keeps_whole_frame_read test is vacuous on some 64-bit ar=
chs
--

commit 1299c778ee1ba2ffa8d447fa3ce55a6d2aec24cd
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Check liveness merge of masks with different widths

This commit adds a selftest to verify that merge_instances() correctly
widens liveness masks of different widths when a function instance is
analyzed through different call sites.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/to=
ols/testing/selftests/bpf/progs/verifier_live_stack.c
> index f8758eb62dac5..a94365decd5f1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> @@ -2861,3 +2861,52 @@ __naked void narrow_store_defines_nothing(void)

[ ... ]

> +SEC("socket")
> +__log_level(2)
> +__msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0=
-9]+}}):")
> +__msg("(79) r0 =3D *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
> +__naked void merge_keeps_whole_frame_read(void)
> +{
> +	asm volatile (
> +	"r1 =3D 0;"
> +	"*(u64 *)(r10 - 8) =3D r1;"
> +	"*(u64 *)(r10 - 16) =3D r1;"
> +	"*(u64 *)(r10 - 264) =3D r1;"

[Severity: Low]
Is this test effectively vacuous on 64-bit architectures with a 512-byte st=
ack
limit?

The precise 8-byte read at offset -264 touches half-slot 66. This means the
mask requires 66 bits, which on a 64-bit architecture occupies 2 words.

The second pass performs an unknown-offset read, forcing a whole-frame mask.
For a 512-byte stack limit, this covers 128 half-slots (128 bits), which
also occupies 2 words.

Because both masks occupy 2 words, the actual widening logic in
widen_frame_masks() is silently skipped, missing the intended test coverage.

While later patches in this series might raise the stack limit for some
architectures, the test remains mathematically vacuous on 64-bit architectu=
res
that retain the 512-byte limit (e.g., RISC-V, s390x, or when JIT is off).

Would changing the precise read to an offset <=3D 256 (e.g., -248) correctly
produce a 1-word mask and test the intended logic universally?

> +	"call %[bpf_get_prandom_u32];"
> +	"r0 &=3D 8;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -16;"
> +	"r1 +=3D r0;"
> +	"call merge_read_all_mid;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -264;"
> +	"call merge_read_all_mid;"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923191139.2816=
206-1-memxor@gmail.com?part=3D11
