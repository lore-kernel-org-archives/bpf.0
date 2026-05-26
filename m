Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080C274B5F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830119; cv=none; b=Q/Fr5m3lOgrucrgTFA7iVe/uDEl+r5RK5MNaaqB77R8eeGkRFgQO6py+XURGVRu+IW/bN0jrV7T6DMywOW+2qbmF9crlZ+V8JoyLd3lMgmeRco7gP+ts3wATcmaJxIj8ciGpxcg23Bs9+QYgkAmoebK5c5oOBH5+Y69CaeDwdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830119; c=relaxed/simple;
	bh=FH5noe86sxovdumF+A6OQodBeqPiuF750cFQhbJwlW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJR5Ys3x+TRi88yEMH7aogOnb5lb4xO/+ohxV/u+YkYJeuae5gu/SXr17RO8tBfKkt/I30HiJ8ARkaPfZPEZhd4NTiA9Yxkz6eJ/GSL0obrKu5Ytx+RGhiFYTiWXQlRQCdQl5KFOWzZsaeeVE4yL/kR378YG0mInSMOMm2RJ8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0WRmQHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0WRmQHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937F1F000E9;
	Tue, 26 May 2026 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830118;
	bh=bKm4Ta1oFCfs+ABn9QoNWMRb2b4R3KG8j0lYdFCVjvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0WRmQHMgd8dYFJL64JUY2l/NYOt/2E9HzNvJPAIuHc1wMMJxjuaL+gktmbrYuqhr
	 oSAsHBAVLueBENoVnGpq7bLWJK94tQ7+PGcXys4etpobtd5A3ISFaD+yYHMK+E8YoS
	 /vNnyqAk3X5+OvLJkYybk2u44QbWem6CDgXJ4NmmFnYL9i6iPk7lGTYKIcUNdLAYuS
	 1WLXvP6lRN1iDMitPMi3sJmyXr5wK4GrLkr+b6juQdBdu/wblhIE1TX6y2yBcVBg5E
	 ZpFCChn2I0IlgF6uzYN9tQN+CPy/qvek4Wc7I1nbM+8YWLD4576aXIIG20SMx+FpV/
	 GKwj/ajA/L3OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 09/13] selftests/bpf: Change uprobe syscall tests to
 use nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526205840.173790-10-jolsa@kernel.org>
References: <20260526205840.173790-10-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:15:17 +0000
Message-Id: <20260526211518.3937F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The usdt.h header was not updated to redefine the default USDT_N=
OP to 10 bytes, which will cause the usdt test to reliably fail.
- [Medium] check_detach() only verifies the restoration of the first 5 byte=
s of the 10-byte NOP and uses a signed char array that can cause compiler w=
arnings.
- [Medium] Benchmark functions and external reporting names were not update=
d to reflect the new 10-byte NOP behavior, producing misleading metrics.
--

commit d8fb3aec4d3eab73b6231c402e78efd3cd47f8f0
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Change uprobe syscall tests to use nop10

Optimized uprobes are now on top of 10-bytes nop instructions,
reflect that in existing tests.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 2f22ec61667b9..a60b8173cdc46 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
>  #ifdef __x86_64__
>  __nocf_check __weak void uprobe_target_nop5(void)
>  {
> -	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> +	asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x=
00, 0x00");
>  }

[Severity: Medium]
This isn't a bug, but the function name uprobe_target_nop5 and the associat=
ed
reporting names in the benchmark registry (like uprobe-nop5) still use the
nop5 suffix. Since they now use a 10-byte NOP, should these be updated to
nop10 to avoid misleading benchmark metrics?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..90851d1e4624f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
[ ... ]
> @@ -430,9 +432,11 @@ static void *check_attach(struct uprobe_syscall_exec=
uted *skel, trigger_t trigge
> =20
>  static void check_detach(void *addr, void *tramp)
>  {
> +	static const char nop10_prefix[] =3D { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
> +

[Severity: Medium]
Is char the correct type here? The value 0x84 exceeds the maximum positive
value for a signed char, which can trigger compiler warnings on architectur=
es
where char is signed. Could this be changed to unsigned char instead?

Also, the optimized uprobe attachment replaces the full 10-byte NOP. Does
verifying only the first 5 bytes adequately test that the detach correctly
restored the original instruction stream?

>  	/* [uprobes_trampoline] stays after detach */
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
>  }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d7..fda3a298ccfc7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -252,7 +252,7 @@ extern void usdt_1(void);
>  extern void usdt_2(void);
> =20
>  static unsigned char nop1[1] =3D { 0x90 };
> -static unsigned char nop1_nop5_combo[6] =3D { 0x90, 0x0f, 0x1f, 0x44, 0x=
00, 0x00 };
> +static unsigned char nop1_nop10_combo[11] =3D { 0x90, 0x66, 0x2e, 0x0f, =
0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };

[ ... ]

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
It appears tools/testing/selftests/bpf/usdt.h was not updated in this patch
to redefine USDT_NOP to 10 bytes for x86_64.

Since usdt_2.c includes usdt.h to build its probes, won't it still compile
with the old 6-byte sequence? This would cause find_instr() in usdt.c to fa=
il
to locate nop1_nop10_combo and result in test failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526205840.1737=
90-10-jolsa@kernel.org?part=3D1
