Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209043CBE84
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368748; cv=none; b=GGlQubti/El+mYnwqZTE68Mq3X6Ut4hFrXFnVTcHCmT2D97bq2Z1n+beVHst+as0qsx+ssO2u2gjvVecH/mcJgJf4w8liAqtxNG1rr5JzGv4cul/9R9I6j6PgSBfVnqzSAfBfQbA2l4D2p7+T4d+HTUoVkt/z1Os0xJCwKz5Mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368748; c=relaxed/simple;
	bh=e0bdPk60vr9hq4WomkltltpLglSdBQxGoyboIM6WWzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l0RxtEliRhOIKMQLe5e4ZyGCNZyOZuMZwiq7LX7wf0O+yIBYjPyDo1Ndly3WkFr4c2pk/VQOvS1Ievxseqcu1wuK0TcYqyeQGIqEDxqLQ/XzLE6lMRmnOtJAVR96DKrA2Uc2pc8WidgQ3NHLe/suR6h211BgLzEvw1RHYXGfr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvs2e3QA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvs2e3QA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5936D1F000E9;
	Thu, 21 May 2026 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368746;
	bh=4pF4AFVD/0lg+ayW8oan/+aJ34y4Hdq1/5n6m0ociZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jvs2e3QAgEEBMcF1F68cdRCcgHOTgHo1RMBG3QH4Ju+acZwoeacGmnr/PKED3C4Kb
	 QEikfiOIhvhTjMaCZuQNP3yabbJganT2KhGxV/7oSix4yiuTAHGHYY8rMyJh8QyzeT
	 4MEZ68awRpqIp7nD7eOApR4lTxboehS4Sp3jwmmKIamuMj0hoxjTDVO5UUHtk3Fc1N
	 LcbOo+H3hFQBIMlu/zSwUjndJi35jvhi24Si9eCKdXQF69+1BK7ncpflA2IdcU7FGS
	 Yfh2UQcLmXqsmAMyUQ4AXY9kPCo0XhMOk2b9h/oikbIHfLnulZSPrt0pKSCneJyPXP
	 4f51W9rdthhwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 08/12] selftests/bpf: Change uprobe syscall tests to
 use nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521124411.31133-9-jolsa@kernel.org>
References: <20260521124411.31133-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:05:45 +0000
Message-Id: <20260521130546.5936D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `usdt.h` header was not updated to provide the 10-byte NOP, =
causing `usdt_2` to be compiled with the old 5-byte NOP and failing runtime=
 assertions.
- [Low] The identifier `jmp2B` is undeclared in `check_detach()`, which wil=
l cause a compilation error.
- [Low] Benchmark functions and test configurations still use 'nop5' in the=
ir names despite executing 10-byte NOPs.
--

commit f5ad4c4a3a063831f82fef22be662049ca3b7fbc
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Change uprobe syscall tests to use nop10
   =20
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

[Severity: Low]
This isn't a bug, but since this benchmark function now executes a 10-byte =
NOP
sequence, should the names be updated from nop5 to nop10 here and in the
related benchmark configurations to prevent confusion?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..8e5ab135248f9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -432,7 +434,7 @@ static void check_detach(void *addr, void *tramp)
>  {
>  	/* [uprobes_trampoline] stays after detach */
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +	ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
>  }

[Severity: Low]
Is the jmp2B variable missing a declaration? It is used here in memcmp(), b=
ut
it does not appear to be defined anywhere in this file or the included head=
ers,
which will cause a build failure.

[ ... ]

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
>  		return;

[Severity: Medium]
Will this assertion fail at runtime because usdt_2 is still compiled with a
6-byte NOP sequence?

usdt_2.c includes usdt.h without overriding USDT_NOP:

tools/testing/selftests/bpf/usdt_2.c:
#include "usdt.h"

However, usdt.h still defines the x86_64 default as a 6-byte sequence (nop,
nop5) rather than 11 bytes:

tools/testing/selftests/bpf/usdt.h:
#elif defined(__x86_64__)
#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, =
0x0 /* nop, nop5 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521124411.3113=
3-9-jolsa@kernel.org?part=3D1
