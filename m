Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F8480335
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905634; cv=none; b=BeNtfgGY1OPWmYf8xTNYnAZmFGYwtyRHlNMWngiVpM9d0XBpD1gI4KCbjnOtfnYWIvwK4OpUhq1W+WsJbDo/8FYyUsNGEUunF9zNzOmH+xqy3OKVx48u1ouZHmUx83Lb+ezqaNHyqOMLYEetbKtW/yIZhtzE5RO4hCU1ucVvLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905634; c=relaxed/simple;
	bh=6LyT9UzqmzhAne075mBEV6vkKFO/WJR6KSAh/mqvD5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YMWaocw9S77tGxQGYAYKZA39VEiRj+ZkVj5/2iqqDqV90H6sxvTaRV4kUnv/whsQYn6oHTT6AynImg3RVuBjDfSPYToYAZCOpDLI/4ElGwTaXcJSFrTdBzu+84OoJy85vlQohzk4/U9cMFPIkbhXMzFM9Hp3x7sOrmY0ZmGz2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G79i1o71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G79i1o71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1141F000E9;
	Wed,  1 Jul 2026 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905632;
	bh=B+LEJrQ9nCs/6HXEITW2Vgk1vXx9MLO7ogBtD2oVpo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G79i1o71dW2ShlEoxPEidQNLpxvUFoMveSrAORE8yKfs3G0DNUJcc4NJ/5dy/L26F
	 2vCEEgXZFQQ0E6Ja3IuLoK4EVrkkVSYrt0XDrf3KuELUvaxKw7x4PPPI2q/auQhTiF
	 ilLvCJhWa0QCh82QYf6zHj0sJaJXssF5TNe8t6g33DajWfokJVzMdwJUphSQrVydy8
	 IFS1yhwYx8ka/THFSSRvSVR9tdPu/nyf79GXg7otRwHMEizVJYKPu86GxDwODp3Opj
	 9NU32tXSBlz9ApomPCzewQkwXJOuwek1yngf9O3Xgdcb7pMAPyenPEJ7ikde5VEUpS
	 v2rD0mGYRMAXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 09/13] selftests/bpf: Change uprobe syscall tests to
 use nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701111337.53943-10-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <20260701111337.53943-10-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:33:52 +0000
Message-Id: <20260701113352.8D1141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch updates test expectations to look for an 11-byte NOP s=
equence but fails to update the default `USDT_NOP` in `usdt.h`, causing a g=
uaranteed test failure.
- [Medium] `check_detach()` only verifies the first 5 bytes of the restored=
 10-byte NOP instruction, potentially masking an instruction stream corrupt=
ion bug in the kernel.
--

commit 6e149e271696edf6debf9408dedc04512556082d
Author: Jiri Olsa <jolsa@kernel.org>
Subject: selftests/bpf: Change uprobe syscall tests to use nop10

This patch updates the uprobe syscall tests to reflect that optimized uprob=
es
now operate on top of 10-byte nop instructions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..0bb37435ce97b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
[ ... ]
> @@ -430,9 +432,11 @@ static void *check_attach(struct uprobe_syscall_exec=
uted *skel, trigger_t trigge
> =20
>  static void check_detach(void *addr, void *tramp)
>  {
> +	static const unsigned char nop10_prefix[] =3D { 0x66, 0x2e, 0x0f, 0x1f,=
 0x84 };
> +
>  	/* [uprobes_trampoline] stays after detach */
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");

[Severity: Medium]
Does checking only the first 5 bytes mask potential kernel-side unpatching =
bugs?

The optimized uprobe logic patches a 10-byte sequence, but check_detach() o=
nly
verifies the first 5 bytes of the restored instruction. If the kernel's
unpatching logic fails to restore the remaining 5 bytes, they will still
contain part of the call instruction, leaving the execution stream corrupte=
d.

Could we verify the full 10 bytes to ensure the instruction is correctly
and completely restored?

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d7..fda3a298ccfc7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
[ ... ]
> @@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
>  	__u8 *addr_1, *addr_2;
> =20
>  	/* usdt_1 USDT probe has single nop instruction */
> -	addr_1 =3D find_instr(usdt_1, nop1_nop5_combo, 6);
> -	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> +	addr_1 =3D find_instr(usdt_1, nop1_nop10_combo, 11);
> +	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop10_combo"))
>  		return;
> =20
>  	addr_1 =3D find_instr(usdt_1, nop1, 1);
>  	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
>  		return;
> =20
> -	/* usdt_2 USDT probe has nop,nop5 instructions combo */
> -	addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
> -	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
> +	/* usdt_2 USDT probe has nop,nop10 instructions combo */
> +	addr_2 =3D find_instr(usdt_2, nop1_nop10_combo, 11);
> +	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop10_combo"))

[Severity: Medium]
Will this test fail because usdt.h wasn't updated?

It appears the default USDT_NOP in tools/testing/selftests/bpf/usdt.h for
x86_64 is still defined as a 6-byte instruction:

#elif defined(__x86_64__)
#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, =
0x0 /* nop, nop5 */

Since usdt_2.c relies on this default macro, won't it still compile with th=
e old
6-byte sequence, causing this find_instr() check for 11 bytes to return NUL=
L?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701111337.5394=
3-10-jolsa@kernel.org?part=3D1
