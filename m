Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD738C427
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791897; cv=none; b=djuSdA5wHG3GjsJnKQix+6HpuHUzYvAPqM2Oa6GRzhIAwkWVNdRoBG5DxEWBRUqcvb/RZ7kJQ50S/eAWLOW1NRFTki2oGjtGOWUIjoiJqC54FlTF4+u5Hg5HXDWXtSPmV3f7Kqt77pw6KQDRAD7fp3R5gR1/ztjnavqS07ZWdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791897; c=relaxed/simple;
	bh=hNV3IZgj0KS/6fZ3Tiglj3itI35P9P61kz/m5Ck4lAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nRF1uXy/x4PbXdNK2uMl/M4hNDXAUEl76DfL+f9XorntBQhKw5ycC3WG4tL97bY3XARv2TJj1e024BAlZ3V3hN5ARFivbMZoFjB78Nbh5NuHR5xSL8LVcNWMErQQJ6556ZQR92hXrUgvl/5F22zxOBWm90Rfviw9HpyUAGXk5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W19fGPgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W19fGPgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE0EC2BCB3;
	Thu, 14 May 2026 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778791896;
	bh=hNV3IZgj0KS/6fZ3Tiglj3itI35P9P61kz/m5Ck4lAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W19fGPgzIibcMKDiccCasuAL0iFE6x1Tw4MPFVMs+cuEE3961yUxqMB4U/vKd5Clh
	 H62jnTsjgpbweRwtmxD9gfU2PqCO/jys3F6zSfJEyrSLkDn5smzqo52zTU9ZgnDOAp
	 xczJEeInd3r1Rh2mYquaEqIQpmAE5rpMk5SlUwqr6XnuI8YFqQCoFH6lCHxvfTUHRw
	 reuxDgv60wAU4rxBfMUHzuOdN5D8HHoN5yjvZycg0ZqxKSC6tjqSiPbF98Kgjf3JRM
	 RkdY/rcU+JE/hG10+FAv8zgBKRzc1ehymonxuggMrwteOQZiOPOTpmR1ww0J+1ns0r
	 /EZjyk5J8Kp/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] selftests/bpf: Change uprobe syscall tests to use
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514135342.22130-5-jolsa@kernel.org>
References: <20260514135342.22130-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:51:36 +0000
Message-Id: <20260514205136.CEE0EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Multiple test validation checks use hardcoded, incorrect byte le=
ngths when comparing instruction sequences, leaving trailing bytes unverifi=
ed.
--

commit ca88e95623000540d5b706ce364d5b5abf75b4c1
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Change uprobe syscall tests to use nop10

This commit updates the uprobe syscall tests to reflect that optimized
uprobes are now placed on top of 10-byte nop instructions rather than
5-byte nop instructions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..c2e9e549c737d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
[ ... ]
> @@ -388,14 +388,16 @@ static int find_uprobes_trampoline(void *tramp_addr)
[ ... ]
> -static void *find_nop5(void *fn)
> +static void *find_nop10(void *fn)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < 10; i++) {
> -		if (!memcmp(nop5, fn + i, 5))
> +	for (i =3D 0; i < 128; i++) {
> +		if (!memcmp(nop10, fn + i, 9))

Is this memcmp() checking enough bytes? The nop10 sequence is 10 bytes long,
but this only compares the first 9 bytes, leaving the final byte unverified.

>  			return fn + i;
>  	}
>  	return NULL;
> @@ -420,7 +422,8 @@ static void *check_attach(struct uprobe_syscall_execu=
ted *skel, trigger_t trigge
>  	ASSERT_EQ(skel->bss->executed, executed, "executed");
> =20
>  	/* .. and check the trampoline is as expected. */
> -	call =3D (struct __arch_relative_insn *) addr;
> +	ASSERT_OK(memcmp(addr, lea_rsp, 4), "lea_rsp");

Does this memcmp() skip verifying the displacement byte? The lea_rsp array
is 5 bytes long, and the 0x80 (-128) byte proves the red zone is bypassed
correctly. Comparing only 4 bytes seems to miss this detail.

> +	call =3D (struct __arch_relative_insn *)(addr + 5);
>  	tramp =3D (void *) (call + 1) + call->raddr;
>  	ASSERT_EQ(call->op, 0xe8, "call");
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
[ ... ]
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d7..be34c4087ff56 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
[ ... ]
> @@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
>  	__u8 *addr_1, *addr_2;
> =20
>  	/* usdt_1 USDT probe has single nop instruction */
> -	addr_1 =3D find_instr(usdt_1, nop1_nop5_combo, 6);
> -	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> +	addr_1 =3D find_instr(usdt_1, nop1_nop10_combo, 6);

Should this length parameter be updated to match the new array size? The
nop1_nop10_combo array was increased to 11 bytes, but find_instr() is still
being called with length 6.

>  	addr_1 =3D find_instr(usdt_1, nop1, 1);
>  	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
>  		return;
> =20
> -	/* usdt_2 USDT probe has nop,nop5 instructions combo */
> -	addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
> -	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
> +	/* usdt_2 USDT probe has nop,nop10 instructions combo */
> +	addr_2 =3D find_instr(usdt_2, nop1_nop10_combo, 6);

Could this cause the test to miss verifying the full sequence? It looks like
it is still passing 6 instead of 11 for the updated nop1_nop10_combo array.

> +	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop10_combo"))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514135342.2213=
0-1-jolsa@kernel.org?part=3D4
