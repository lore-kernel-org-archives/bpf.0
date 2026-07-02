Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4B30C176
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960575; cv=none; b=t2JSSwYeJhVcwcrOSG1URCXtlXf9hrmyNP3PcJ/yFjON2YXAIwR09AvPL6YJstzcV+z463PSufBIOhctmIVvIbvgbtlXAZeT3q+ZH6+5PbS27dX9nQUmhRHpiMg7W5ZCqByu9/qPyaOQa/ZAk5+VxdR5LQYiN0jMHq6BFP+gulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960575; c=relaxed/simple;
	bh=caY6ZZdepdghKQ35DYzS0Ul0YujcJjyL2K7fHEXEvGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHV+967oaPZXaGSvPEUqg9PNaiWYciYyXq/QiFVi/CIy3EdDbRtijVK7FW0vaUPbzWsrY7hYIom9ZWxfGWK0cT/URjZ6xukBgee1z2T4u5Ui05NUwyiNs+rEezkq+F/4pf34EHakG1sFkqRNdSSBhUcPkffDUfHUsIdFo577pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mboPkBiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mboPkBiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31311F000E9;
	Thu,  2 Jul 2026 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782960573;
	bh=pok59/EXacOYm4dElZ+k7xHTqwqDZzE10Y7OxpaxJOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mboPkBiF09GHiTfwdUyvjJBBvC6u8Lc//TnEMuAP1Vh6mYduBupeDOBMKrVMXkNb8
	 oUHPx17oFDCVIdN4S2woTu7E+siVyywxq5Nf4QmGLZlKdtgCxY2Q6YPrgpGgxTFWEP
	 8L5XLsld3tiIZER6tde0CMuEai1HIbltbMW3zAFHqIOnlr0+xN82Q4agzaHF9bOecb
	 J5Luy+diK2UwCEdLbZS+gVin68biKKZXfiVuh9Hyg3fGXmMMKfI1gLUoZabEXMILjc
	 +pLYqDh3m1/rrjwuH1Aq6xjRI2zDDNbC2yIYGPcGDgXtgWtX/jjKv8uAwDBcKGw1KJ
	 7HAfCHTAKI6Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 10/11] selftests/bpf: Enable arena atomics
 tests on LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702022322.51033-11-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-11-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:49:33 +0000
Message-Id: <20260702024933.B31311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch enables arena atomics tests for LoongArch in `arena_at=
omics.c` but misses the identical architecture guard in `test_parallel_spmc=
.bpf.c`, failing to enable the libarena SPMC parallel tests.
--

commit 6a78ab7798074b26b2ec91b91c15b4a58e0531a1
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Enable arena atomics tests on LoongArch

This patch adds LoongArch to the arena_atomics load-acquire/store-release
architecture guards so those subtests are executed.

> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
> index 2e7751a853999..38a628b4ee241 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -29,6 +29,7 @@ bool skip_all_tests =3D true;
>  #if defined(ENABLE_ATOMICS_TESTS) &&		  \
>  	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
>  	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64))

[Severity: Medium]
Should this patch also update the architecture guard in
tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c?

It looks like spmc_tests_enabled() in that file has an identical architectu=
re
guard for arena atomics that currently misses LoongArch. Without adding it
there as well, those parallel SPMC arena atomics tests will be skipped and
return -EOPNOTSUPP.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702022322.5103=
3-1-dongtai.guo@linux.dev?part=3D10
