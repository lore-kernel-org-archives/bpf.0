Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BD23909C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867758; cv=none; b=AwAIQuYv/bXr9iL+FevgEQSCUnDNdAaGiXGff2Q1+grKHjfYfaDZUWvF8Ky9yAD3g3g94b2IsrpG1w6RPc00rtQ97ZUzv5xT2Ea9GnnQEcjbKz8hTlP8PKnO68pxjmIrBsvmuBw0ZVA97wTcLOph0p0tetpstUYPP2lTR3QSqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867758; c=relaxed/simple;
	bh=VpTyOrYqLMBJGPK+ft4lpodpLzty818ur02Zvngzo80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYDEHUrJ1hlcBgu+NGnqnt1ZlUEKeu75KD/QzUFsg8nR5z0LH3ionEo+BLhuHJuoG7V48jB4RuS5wg2avoKNuBwdAC1LD+RxYRLkAguRbg/dxByB2LcE65+MQuKYMMQMrNLkrcZftGleWkmRtQJhImlBleyxGnTbGfPrSFoiQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeJjcukp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeJjcukp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB5A1F000E9;
	Fri, 24 Jul 2026 04:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784867757;
	bh=+iAvgyFv8gDn+6uG5SUw9r+gcpe70TrTpwt35FZtycI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YeJjcukpk3eEuwouyNE1iaq5lk26Um9M4y53ixJTuf/jz2qJ12jUXgWGR42JalaJw
	 IOpKDLrqGjc+NG1YmChdZVDSGxyrz7NbQTKmGSGX/P1zybWOE2fS6NynJz62bROqay
	 pzKz7axDHD3200LyppKgv6r84b7QyxnwhZwxj3vTW1EFqgugOlICJue9fWPhj/Gj35
	 j3N38HuPt2XqDeuERCsmbWAU4I6th2Vt+6KBw/i0468Cqk5U1dTk26vP2lt+KBcxks
	 1UbdnRAtGmdeJjqzS0tclbdcON5oGa+Jkbq/BL6BOTbPWxAadEhMeP6hU49bPifyAa
	 yjvclFZiZfxrA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v4 3/3] selftests/bpf: build each test
 runner instance in its own sub-make
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724042600.175440-4-nickolay.lysenko@gmail.com>
References: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
 <20260724042600.175440-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 04:35:56 +0000
Message-Id: <20260724043556.BEB5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims that light-skeleton demand lists are d=
erived dynamically, but the implementation retains hardcoded lists.
--

--- Patch [3]: [RFC PATCH bpf-next v4 3/3] selftests/bpf: build each test r=
unner instance in its own sub-make ---
commit a1ebeec9064cd1ef457a1d6c67e818e26521e31b
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: build each test runner instance in its own sub-make

This commit replaces the double-expansion test runner logic with a
Makefile.runner script invoked per test runner instance. It aims to simplify
the build system and fixes a latent parallel-build race condition.

>     standalone binaries and the kselftest lib.mk contract - and delegates=
 to
>     the runner through explicit per-instance rules. Light-skeleton demand
>     lists are derived from the tests' own '#include "*.lskel.h"' lines; t=
he
>     bench object list is derived from $(wildcard benchs/bench_*.c).

[Severity: Medium]
The commit message mentions that the light-skeleton demand lists are derived
dynamically, but the implementation in Makefile.runner retains the hardcoded
lists.

Was the dynamic derivation logic dropped from this patch, or does the commit
message need to be updated to match the code?

For reference, Makefile.runner still hardcodes the lists here:

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/=
selftests/bpf/Makefile.runner
> new file mode 100644
> index 0000000000000..ced44aad7eded
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner
[ ... ]
> +LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c =
	\
> +	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> +	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> +	test_ringbuf_overwrite.c
> +
> +LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
> +
> +# Generate both light skeleton and libbpf skeleton for these
> +LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> +	kfunc_call_test_subprog.c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724042600.1754=
40-1-nickolay.lysenko@gmail.com?part=3D3
