Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D0140E5F
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292759; cv=none; b=cKumA9jnnWdTTAfYwhhIJ7La6prYdoIXb2IEoh6foRZ/S6dpS0suQUDwxqBSPjMQ75AFFlTXoVsCTT2zN1ysFw8nL0Q7eW7iybpgrlWdydQh76y6Xr3S6Qnje7vte9hDqJvEyZARVc7XFJj5A6/K09vq5FIutqa9o7ac5dadiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292759; c=relaxed/simple;
	bh=0Mdhq0jLbqqK/fCaAuU0cU845jvz3knpVGjRDB3GCz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QOOVfPwn0u2kd8pEqOqVyaeFi+JCiykIMf9iK/2mUQpAGU6vBO+JBYp69RnM4R+RTYCJaw9FDZWW7K0dQUNhxL7qlKCq3gqYBFIjLJLw6cXfalDkuguvYqR4rv4sPshK1rlLTDLQDvGhPu3TDvPp7/zsLVuf3lP6arizs0n4bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1wgtUOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1wgtUOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE98FC2BCB0;
	Sat,  9 May 2026 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292758;
	bh=0Mdhq0jLbqqK/fCaAuU0cU845jvz3knpVGjRDB3GCz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=C1wgtUOvpg5KBHJq2ZWSiaCYuje0A56HPC/tPV8ZMXMcGRZRVv3eTsdtYKb3xC0eO
	 0Jw+uN74WBfen/YU2GcIaZJ5OdkF//uGu8XR1e/z14G6ZNDLZfvUfVkJF1ZcGGiZws
	 Lfpmx+f9W0T3V0dF+1hIShAPYaCu4xONLiRSMpUbWaANS5IZm0rYhkbskPMnJy+1MM
	 BY67py+H90uZc4TrlRhfbQALUQl/jraRxXWr3p1MLO6MHQ7pSTp2p7+PyIPlb+hRMB
	 2i2HlCFc+MvFqtgkWUt9eIy8a/tQ1E+DFO6G3t7UNnhq3RhMnpXbLcW3pnqFgIxn4T
	 U+H46Ezi4052Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests for uprobe nop5 red
 zone clobbering
Reply-To: sashiko@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260509003146.976844-2-andrii@kernel.org>
References: <20260509003146.976844-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:12:38 +0000
Message-Id: <20260509021238.AE98FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `optimized_red_zone` USDT subtest is brittle and may produce=
 false positive passes because it relies on the compiler arbitrarily placin=
g operands in the stack's red zone.
--

commit 1fbbd69b145cd2d80be83d6482e65179431782ac
Author: Andrii Nakryiko <andrii@kernel.org>

selftests/bpf: Add tests for uprobe nop5 red zone clobbering

This commit adds tests to verify that the uprobe nop5 CALL optimization does
not clobber the x86-64 stack red zone. It introduces an assembly-level test
and a USDT subtest which intends to trigger a probe in a function where the
compiler places operands in the red zone.

> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftes=
ts/bpf/usdt_2.c
> index 789883aaca4c3..fc7e6d220a38b 100644
> --- a/tools/testing/selftests/bpf/usdt_2.c
> +++ b/tools/testing/selftests/bpf/usdt_2.c

[ ... ]

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

Is this test reliable across different compiler versions and optimizations?

The x86-64 USDT macro uses the "nor" inline assembly constraint, which allo=
ws
the compiler to allocate these operands to CPU registers. Because there is =
no
register pressure in usdt_red_zone_trigger(), modern compilers might alloca=
te
the local variables a1, a2, and a3 directly to registers rather than the
stack's red zone.

If the operands are placed in registers, the uprobe CALL optimization
clobbering [rsp-8] will not corrupt them. This could cause the test to pass
even on buggy kernels, creating a false positive.

Would it be safer to explicitly force these operands into the red zone
using inline assembly constraints, rather than depending on the compiler's
register allocator?

> +}
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509003146.9768=
44-1-andrii@kernel.org?part=3D2
