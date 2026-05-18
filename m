Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB6330B07
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102966; cv=none; b=cvVAnEtSngpo8XTzPUUuCRTFFBwI8pUBvGvXfDWPlo3m7drrbo91VCYErZ3s7i1MgnMAkrKsOh99iaTLD2PYJanqLfiVRjsPvewHi257TtYsWW6sdF50ctkTtoS96+RhTjEFPrW8BOplsSbATa+X9la4YXxVU8X3WRRByjH0tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102966; c=relaxed/simple;
	bh=oi74W48Op+2szW+2XDfyEDYJWr1VHfh3PrgOS+umvWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EwdCAnjAk7NSmliDeUIWejAW/UPovxl3AbC1bZ5PtvSlwoddcJHbC2sXh3od4AvgXi+FVwybsueUaOkpXxAjDeSio6xBSnVD3JNaYqZhnrclFk72ELKZ772kG9Pgom4VaKbVRtNpMTy4VIJeYL/k4L28H42Sw/+4GDMDxHahsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSk5dV9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSk5dV9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC731C2BCB7;
	Mon, 18 May 2026 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102964;
	bh=oi74W48Op+2szW+2XDfyEDYJWr1VHfh3PrgOS+umvWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oSk5dV9RcC9EaHdocvGMjX+rq3JlZ54JhHbcioq8HOiI5G495PqEtG6WMpvCRubZl
	 0x7WQ6jVjsXgMqeh2NHMj10TgeSUasWLD0lXwB6VHEtG/+u3bo1LFlSUQBOrJAiUtL
	 HGv3BH9G5E0o+sHAE6kJ4HLglNK6//OhL+HfR0b5uuGRCgtmfpmi7rcyPFgFhdeBa7
	 xV4wJkRsTRACPO+1KqBa87BmsrQ1pgIqS2DLP6m2GUMvQ9wUCU6VUBo3jXvuRCEQoP
	 vky9qs5w3XDEPG9sm2CGeHzNM//+2K5B2AohIAmaEMV+FTQWsdZAl/qhGi+iK2oXtT
	 kaBNgWr6pHNHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 07/11] selftests/bpf: Change uprobe syscall tests to
 use nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518105957.123445-8-jolsa@kernel.org>
References: <20260518105957.123445-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 11:16:04 +0000
Message-Id: <20260518111604.CC731C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing update to USDT_NOP macro causes `subtest_optimized_attac=
h` test failure.
- [Medium] Inadequate search bounds in `find_instr()` may cause false test =
failures.
- [Low] Misleading benchmark and function names referencing `nop5`.
--

commit 1996488ddbe422eb1d441da9b06aafe6bd47e6d1
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Change uprobe syscall tests to use nop10

Optimized uprobes are now on top of 10-bytes nop instructions,
reflect that in existing tests.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 2f22ec61667b9..bcc4820c802e5 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
>  #ifdef __x86_64__
>  __nocf_check __weak void uprobe_target_nop5(void)
>  {
> -	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> +	asm volatile (".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x=
00, 0x00");
>  }
> =20
>  static void *uprobe_producer_nop5(void *input)

This isn't a bug, but should the function and benchmark names also be updat=
ed?

The benchmark exposes names like uprobe-nop5 and uretprobe-nop5, but they a=
re
now testing a 10-byte nop.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d7..a160d7c4fa0d3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -252,7 +252,7 @@ extern void usdt_1(void);
>  extern void usdt_2(void);
> =20
>  static unsigned char nop1[1] =3D { 0x90 };
> -static unsigned char nop1_nop5_combo[6] =3D { 0x90, 0x0f, 0x1f, 0x44, 0x=
00, 0x00 };
> +static unsigned char nop1_nop10_combo[11] =3D { 0x90, 0x66, 0x66, 0x0f, =
0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };

Is the loop in find_instr() adequate to find this instruction sequence?

tools/testing/selftests/bpf/prog_tests/usdt.c:find_instr() {
	for (i =3D 0; i < 10; i++) {
		if (!memcmp(instr, fn + i, cnt))
			return fn + i;
	}
	return NULL;
}

In uprobe_syscall.c, find_nop10() was updated to search up to 128 bytes to
account for compiler-generated prologues. If a modern compiler generates a
prologue longer than 9 bytes for usdt_2(), this will prematurely terminate =
and
cause the subtest_optimized_attach() test to fail.

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

Does this test fail because USDT_NOP was not updated in usdt.h?

The test expects to find the 11-byte nop1_nop10_combo, but usdt_2.c relies =
on
the default definition of USDT_NOP from tools/testing/selftests/bpf/usdt.h.

Because usdt.h was not updated in this patch, usdt_2.c will compile with the
6-byte nop sequence, causing find_instr() to return NULL here and the
ASSERT_OK_PTR to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518105957.1234=
45-8-jolsa@kernel.org?part=3D1
