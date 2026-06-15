Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CE3DB635
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519143; cv=none; b=payiqUWIe/H6XPE1i5f8jnAOnso1xGL54CLX8avzXumdpwFalTgV5vks6iUUhpKrqTqF7UzGhLL0Helo+fwhfwGT27lfNeXGmPdlTDIhfnI8gsW8G1E7hMpUD+ojp98Ee2axHuAdd1vixHbGb25caTozhHx/GJROEGEGs53w1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519143; c=relaxed/simple;
	bh=T+ZeaBKqkpB9Rc1KVtbFaC1VeczpvrQOxFt8xKDacnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mlb2alm6E+IZrEKwTCthh9J8B/UFVxbUBl4MqS+KIw64cFfKAXFDkjHVyY5eqo3IEU2C0xVQKF5FuXPesbnWKqxtivAkL0S6FrbxqJ/8FPIy+54/85NdyqETKkEXxZeihff+qp6iCMDEtTNX/xV1pp/EmaJNFk3YerXlBJa8HAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5GaqZ7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5GaqZ7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9011F00A3A;
	Mon, 15 Jun 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781519142;
	bh=osWsZWzWrCtNIhz0fNAitCTuYbLzHLCWkCE2ZZHa6Tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5GaqZ7/8tABtgYBe7zePoItdBuPVYDQDqhAzHDoC7+DbdileCbx1F9b6wA+etnBd
	 Cx877ghumoZoEwaxGQf30de1qdNQfmTnakL/jm5s9n/tYyQuihU6frJCCg/bNrVDTi
	 LSq/zSv5YMlUCySP4yGFzca4MAILh/DMZzqI4mH5w03NDBCT/mvegf9rMEtVscypHU
	 GnE/qrz96pGqRMTB9O7ZrQgkm4CxovZumb5rcqlootE8of8IS2C2tMKgL7EbMAgnjR
	 C7ULHFqKI6wZTsS4bUAGmeseTC9agP2STquucxkZyDrdEe5AxG3rwhjHt7yhQStEgS
	 CRDQoBeixQRzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test jited inline of
 bpf_get_current_task() for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615100506.19558-4-yangtiezhu@loongson.cn>
References: <20260615100506.19558-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 10:25:41 +0000
Message-Id: <20260615102542.4B9011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest expects `bpf_get_current_task()` to be JIT-inlined =
to `move $a5, $tp` on LoongArch, but the required kernel JIT implementation=
 is missing, causing the test to fail.
--

commit f8173ba138660b46dd1d6b8e58aa91f97cddc7a8
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Test jited inline of bpf_get_current_task() for LoongArch

This commit adds a selftest expectation for the JIT-inlined version of
bpf_get_current_task() on LoongArch.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> index 76d80605ec7fd..8560577f25576 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -12,6 +12,8 @@ __arch_arm64
>  __jited("	mrs	x8, SP_EL0")
>  __arch_riscv64
>  __jited("	mv	a5, tp")
> +__arch_loongarch
> +__jited("	move	$a5, $tp")

[Severity: Medium]
Is the corresponding kernel patch implementing this JIT inline missing from
the tree?

Without the logic in arch/loongarch/net/bpf_jit.c to inline
BPF_FUNC_get_current_task, the BPF JIT emits a standard helper function
call rather than the expected instruction sequence.

Will this cause the selftest to unconditionally fail?

>  int inline_bpf_get_current_task(void)
>  {
>  	bpf_get_current_task();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615100506.1955=
8-1-yangtiezhu@loongson.cn?part=3D3
