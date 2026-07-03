Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500083C583A
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080037; cv=none; b=pcn7YVmn8aXS/doHoIQrhn2iB4WZTbNngIa6Sq5PhRVxkveoZhF4/MsYmAxKDFP52i50BGXdxogOF3dze5tUvhlnm0LZB8h2sm+31xNh9wNUpoUMUaEreJFN0blIfOPpJLJyQ2GgxMYMikS8dKemaR86biYxvQCuljjPNLMt/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080037; c=relaxed/simple;
	bh=oWx+/yldeq6ipszIa/D+PE2cu8qd0xPAN2YiV0nC4Ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMhGH9Qhn+Vk8cmX+YLtvQxT+VNenebVgf3Qlrg1mqiGWUaC2nU1IsbPePU1b/l3umvtM2DbBgMlkDoPWN5wLwKzSHDGDsGnpuAyhyMvT8VmnFOAiFcTMjWnZRKK3UCwki2UrykdoiWK6c5riorQgpeskDWSu9S1DonteXelh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhkj3pFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhkj3pFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C89B1F000E9;
	Fri,  3 Jul 2026 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080036;
	bh=Z+BuxzyrdgDHkTSm9ylaFlbldw2je4pJqX8fOojbESk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rhkj3pFKRD2DNdTjF/J2c3O9IIxOLll6Jlc+ZS4k8FHecP4UBla0ASinO93sr6yO1
	 iavshMcF5yG3qHFbjdbOY5ZQCAIto0cpeaxJ2MgNp/WJG5ZnkaiP5H6FgnLchhAcNY
	 Ss1h/96sV4qoqpivCjqZNtOZ15pV0GUKLni6ql80bCERKLc8LwCv9mNzQ9dLuDzX60
	 Y5ErOJzTuGYdSbYp2ddZTa9FkBvbphOzUeJFVg+bnYZ1T7VNPz+drzYhykjeFdd64a
	 LMkSGCLNsV7vuE+/FXLc877uRdq1T1DRXDboxT39srt31j2MJBOTBasN6GjIP3sIiJ
	 kFTrmTmEwkGbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 09/13] selftests/bpf: Change uprobe syscall tests to
 use nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260703114917.238144-10-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-10-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:00:34 +0000
Message-Id: <20260703120035.9C89B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The default `USDT_NOP` macro in `usdt.h` was not updated to `nop=
10`, causing `usdt_2.c` to compile with a 6-byte NOP and breaking the selft=
est.
- [Medium] Libbpf's USDT attachment logic is unaware of `nop10`, preventing=
 the IP shift for optimized uprobes and causing them to fall back to unopti=
mized traps.
- [Medium] The `check_detach` function only verifies that the first 5 bytes=
 of the `nop10` instruction are restored upon uprobe detachment, leaving th=
e remaining 5 bytes unverified.
--

commit b3e7e5fee8889d2f95596f44b09c53ec9e3d2d6c
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Change uprobe syscall tests to use nop10
   =20
Optimized uprobes are now on top of 10-bytes nop instructions,
reflect that in existing tests.

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
>  }

[Severity: Medium]
Should check_detach() verify the full 10 bytes?

Since the optimized uprobe modifies a 10-byte instruction sequence, only=20
verifying the first 5 bytes might leave incomplete detachments unverified. =
If=20
the detachment logic fails to correctly restore the last 5 bytes, it could =
lead
to a corrupted memory access when executing the NOP.

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d7..fda3a298ccfc7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
[ ... ]
> @@ -328,8 +328,13 @@ static void subtest_optimized_attach(void)
>  	/* nop stays on addr_2 address */
>  	ASSERT_EQ(*addr_2, 0x90, "nop");
> =20
> -	/* call is on addr_2 + 1 address */
> -	ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
> +	/*
> +	 * lea -0x80(%rsp), %rsp
> +	 * call ...
> +	 */
> +	static unsigned char expected[] =3D { 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe=
8 };
> +
> +	ASSERT_MEMEQ(addr_2 + 1, expected, sizeof(expected), "lea_and_call");

[Severity: Medium]
Does libbpf need to be updated to recognize the new nop10 sequence?

Looking at has_nop_combo() in tools/lib/bpf/usdt.c, it still explicitly
checks for the 6-byte nop combo:

    unsigned char nop_combo[6] =3D {
        0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
    };

If libbpf encounters the new nop10 sequence, it won't advance the instructi=
on
pointer and will fall back to an unoptimized trap instead of using lea and
call. This would cause the ASSERT_MEMEQ here to fail.

> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftes=
ts/bpf/usdt_2.c
> index 789883aaca4c3..b359b389f6c00 100644
> --- a/tools/testing/selftests/bpf/usdt_2.c
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -3,7 +3,7 @@
>  #if defined(__x86_64__)
> =20
>  /*
> - * Include usdt.h with default nop,nop5 instructions combo.
> + * Include usdt.h with default nop,nop10 instructions combo.
>   */
>  #include "usdt.h"

[Severity: Medium]
Does tools/testing/selftests/bpf/usdt.h need to be updated to define the=20
new 11-byte sequence for USDT_NOP?

The test in prog_tests/usdt.c searches for nop1_nop10_combo:

    addr_2 =3D find_instr(usdt_2, nop1_nop10_combo, 11);
    if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop10_combo"))
        return;

Because USDT_NOP in usdt.h was not modified in this patch, it still=20
generates the old 6-byte sequence. This will cause find_instr() to return=20
NULL, resulting in the test failing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703114917.2381=
44-10-jolsa@kernel.org?part=3D1
