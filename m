Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E72397323
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793740; cv=none; b=H5zrGXaZ0VcGr/OcIk/iBV3pWOtoYUekke+O+QqhTvQZkXsZd0tf2FQSs94Qq/KH9+kfQ0W+BHGoL44ixL09v8GgATMRmoUk1aUG5onEQKepTyTVSrJVerFIXK59Op3Fss27mLcb7X8TJs3dM28MFtKnSULOH5IB6OFkpiRwVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793740; c=relaxed/simple;
	bh=MU78KTDiSqEbU0pZu2/gdOoYLuB4S2tj5KlqceP+py0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYEeGuMAQuqhwvCgFAoq+4m5qbzmW1sBYsQ43l8yD7udImGc+q4L23+ocpCQOb27+qqvALpXErQW55GCW+DlWNnTrCBzBe2Fyh3nL3TBlYOOl+EIHshMsZ0EP0oAqY9iD+VZxay+WyNyi8ExQPqsMd1d9qu+QvE2APY4TIqStNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uphOge/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uphOge/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F3C2BCB3;
	Thu, 14 May 2026 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778793739;
	bh=MU78KTDiSqEbU0pZu2/gdOoYLuB4S2tj5KlqceP+py0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uphOge/hgaY1Ca3TcvVQuPXSytmOtLw6+seBjNtV11JTJOFGcDCzR4BtYWL3ppEQ1
	 525IYIupsr5JxbqgdZ8DePbaxP0GRMdrziFxxUrB4U5blNO9qoVMMCjWv/SeDoJ/PN
	 aXRG9XXrsrnD8hoWQttL4lD4euUfD0TwbIm0DJMD1Bzbw5dNI2xsNu0n3xPUPZwozp
	 ZLFEWCyeAzfjCkD0j0b/UZVytAZLHWQ9JcFS3h+PoZjpqVDyESuZy3IWfNZ99lojE/
	 DC+9oarRPCh5PhBfoqxjVkPKd8ArLDKLHrY0ZkiU1SFg0X9liBBmYbfdrHw9O81W6f
	 yoYb0yk5IhzQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] selftests/bpf: Add tests for uprobe nop10 red zone
 clobbering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514135342.22130-8-jolsa@kernel.org>
References: <20260514135342.22130-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:22:19 +0000
Message-Id: <20260514212219.BF1F3C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `optimized_red_zone` USDT subtest does not guarantee that its =
arguments are placed in the stack's red zone, rendering it ineffective as a=
 regression test.
- [High] The uprobe regression tests loop too quickly to guarantee that the=
 asynchronous uprobe optimization has completed, making them prone to false=
ly passing on unfixed kernels.
--

commit c8c0580fb53dfbfe85e78c3bfddc6256a6a88b56
Author: Andrii Nakryiko <andrii@kernel.org>

selftests/bpf: Add tests for uprobe nop10 red zone clobbering

This commit introduces tests to ensure the uprobe nop10 optimization avoids
clobbering the stack's red zone on x86-64. It adds an assembly-level test
that checks for red-zone data integrity and a USDT subtest checking for
correct argument delivery over 10 invocations.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
[ ... ]
> @@ -855,6 +897,37 @@ static void test_uprobe_race(void)
>  #define __NR_uprobe 336
>  #endif
> =20
> +static void test_uprobe_red_zone(void)
> +{
[ ... ]
> +	for (i =3D 0; i < 10; i++)
> +		ASSERT_EQ(uprobe_red_zone_test(), 0, "red_zone_intact");

Does this loop execute too quickly to guarantee the uprobe optimization has
completed?

Uprobe optimization is performed asynchronously by a worker thread. Since
this is a tight loop with no delays or blocking, the 10 iterations might
finish before the background worker patches the code.

If all hits execute on the unoptimized INT3 path, the test could falsely
pass on kernels where the CALL-based optimization bug is present.

> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	uprobe_syscall_executed__destroy(skel);
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftes=
ts/bpf/usdt_2.c
> --- a/tools/testing/selftests/bpf/usdt_2.c
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -13,4 +13,17 @@ void usdt_2(void)
>  	USDT(optimized_attach, usdt_2);
>  }
> =20
> +static volatile unsigned long usdt_red_zone_arg1 =3D 0xDEADBEEF;
> +static volatile unsigned long usdt_red_zone_arg2 =3D 0xCAFEBABE;
> +static volatile unsigned long usdt_red_zone_arg3 =3D 0xFEEDFACE;
> +
> +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> +{
> +	unsigned long a1 =3D usdt_red_zone_arg1;
> +	unsigned long a2 =3D usdt_red_zone_arg2;
> +	unsigned long a3 =3D usdt_red_zone_arg3;
> +
> +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> +}

Is it guaranteed that the compiler will place these variables in the
red zone?=20

On x86_64, the compiler will typically allocate these three arguments
to general-purpose registers rather than spilling them to memory.=20

If they are placed in registers or a standard stack frame above rsp, the
uprobe bug wouldn't clobber them, which might allow the test to falsely
pass on an unfixed kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514135342.2213=
0-1-jolsa@kernel.org?part=3D7
