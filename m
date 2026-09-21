Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E193DEFE7
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025738; cv=none; b=K26NNCTfgPfIFflhBayf/eMbL8wKH0Whge8dUsW9w7fQlhdboPmIShl7bIU00kpxpNR5ICyguH8WPpq1tg/CrMYawbz/+mw5mFFqz+NtDUFy7PKjhZSlvFxwAQ4h8IZKhTCGL5GSUhW6xwFCFcwa3308qa/RYsdNP/EMUWuBItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025738; c=relaxed/simple;
	bh=L4tiXsSzKGSaWL0JqsEaVuokRPDpdToyWD9tvuvcK5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kH2ReEgV4cQFqXMsw/vKGznfa6iU4UwIorEM57qwIJpTA6+HLNT2x2gt3eyl2omUllcmv1PUF8RqYYZzPR48YngPAYTtp2sro0eH9RIk95WbptIzmkKYV8BGBC16ifnfl47AiP1M3GYgHWETySXgOu59H27L9t5Qc2HklHHEQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWEd7+8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWEd7+8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D8F1F000FF;
	Mon, 21 Sep 2026 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025733;
	bh=K1NSoEhn9d2Kodx+J0bGbw2TV6xS7BE4tnEX4kfBYTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWEd7+8NvcbJD6KnPANSO2KnjwTVYotVkJllzUsy9O5bCTA37VVSJUblgIqi4Opil
	 4Xklp5Xn0jHzIZ4zT1SAuRieaFG1WqJKYU3bHrXXi+t7QGPIodKtEI6PaZNMNm8Tji
	 BA63Ghr9bUfA6hS0idVauqGhC6lJXHAxcqTNVtp22KUxiBaSOvwFMbFjRPN/oHpcOL
	 7j6MNaqHrgZERuWMSKHqztFTJLrjXj2acmal2+ocs00BQfpb8kxOD30fZ39hQrmkNd
	 ydBF0paFQc2QJ1+weMrGK6X61IEwRFRrF83MFR/BMDQK3fScLLG4jzWirC7KxMmcbE
	 ZDPt3qB3lc3zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 18/20] selftests/bpf: Add an end-to-end
 .bpf_cleanup exception test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210205.1724656-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210205.1724656-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:22:13 +0000
Message-Id: <20260921212213.B2D8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: endianness bug in raw BPF instruction emission
- [Low] bpf: BPF Comment Style Violation
--

commit 322ad0f798ee8015c8f51c953009198fc70b2b9b
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add an end-to-end .bpf_cleanup exception test

This commit adds an end-to-end test for exception cleanup using .bpf_cleanup
records. It defines inline assembly constructs mimicking compiler output to
evaluate how the kernel handles and optionally rejects various landing pad
combinations and malformed paths.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 0000000000000..c932da7cbec16
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> @@ -0,0 +1,121 @@
[ ... ]
> +/* A table with more records than the program has instructions: no valid=
 one
> + * can look like that, and it is refused before the kernel allocates for=
 it.
> + */

[Severity: Low]
Does this code adhere to the BPF comment style guidelines?

The BPF subsystem requires multi-line comments to have the opening '/*'
on its own line, with the comment text starting on the next line. In
test_cleanup_info_cnt(), the text starts on the same line as the opening.

> +static void test_cleanup_info_cnt(void)
> +{
[ ... ]
> +	/* Turned away on the count, rather than on whatever the records past
> +	 * the one below happen to hold.
> +	 */

[Severity: Low]
This isn't a bug, but there's another multi-line comment in
test_cleanup_info_cnt() starting on the same line as the opening '/*'.

> +	ASSERT_HAS_SUBSTR(log, "cleanup info has 1048576 records for 2 instruct=
ions",
> +			  "log");
> +}
> +
> +void test_exceptions_cleanup(void)
> +{
[ ... ]
> +	/* foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second regi=
on;
> +	 * foo3's frame is long gone, so its pad must not run.
> +	 */

[Severity: Low]
This isn't a bug, but this multi-line comment in test_exceptions_cleanup()
also starts the text on the same line as the opening '/*'.

> +	if (test__start_subtest("throw_from_foo2"))
> +		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
> +
> +	exceptions_cleanup__destroy(skel);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/too=
ls/testing/selftests/bpf/progs/exceptions_cleanup.c
> new file mode 100644
> index 0000000000000..a3a8c14e0db28
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
> @@ -0,0 +1,157 @@
[ ... ]
> +/* Called from foo1, which owns nothing and has no cleanup record: a cal=
l an
> + * exception may leave with no landing pad to run on the way. The throw =
is
> + * never taken -- @never is a global, so the verifier cannot prune it --=
 and
> + * the bit says the ordinary return path ran.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment before bump() in
exceptions_cleanup.c also violates the BPF comment style requirement.

> +static __used __naked __noinline void bump(void)
> +{
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 0000000000000..db6ac7d8bd6de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> @@ -0,0 +1,662 @@
[ ... ]
> +/* 1. A subprogram that may unwind, also used as a helper callback:
> + * bpf_loop()'s own kernel frame would end the walk before it found a
> + * boundary.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment before throwing_cb() in
exceptions_cleanup_fail.c starts text on the same line as the opening '/*'.

> +static int throwing_cb(__u32 idx, void *ctx)
> +{
[ ... ]
> +	/* gotox r2, as a raw insn: the mnemonic only reached the LLVM
> +	 * assembler in llvm 22, and BPF_RAW_INSN() needs <linux/bpf.h>, which
> +	 * vmlinux.h rules out.
> +	 */
> +	".8byte 0x20d;"

[Severity: Medium]
Will this raw instruction emission work correctly on big-endian architectur=
es?

The inline assembly in gotox_in_pad() emits a 64-bit integer literal. On a
little-endian target, 0x20d places the correct opcode bytes at the start
(offset 0). However, on a big-endian target, the 64-bit value is emitted wi=
th
leading zeros, placing 0x00 in the code byte. This corrupts the instruction
stream and will cause the BPF verifier to reject it.

> +"l0_%=3D:"
> +	"call bpf_unwind_resume;"
> +	"exit;"
[ ... ]
> +	/* r0 =3D *(u32 *)skb[0]. Spelled as a raw insn because BPF_LD_ABS()
> +	 * needs <linux/filter.h>, which this file cannot have -- vmlinux.h
> +	 * already defines the uapi enums.
> +	 */
> +	".8byte 0x20;"

[Severity: Medium]
Similarly here in ld_abs_in_pad(), does emitting 0x20 as an 8-byte literal
corrupt the instruction stream on big-endian architectures?

On big-endian targets, this will evaluate with 0x00 at the code byte instead
of BPF_LD_ABS (0x20), causing malformed instructions to be passed to the
verifier.

> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D18
