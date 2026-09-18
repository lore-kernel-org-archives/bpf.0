Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD33EB102
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707555; cv=none; b=b09rmoLksvmemIdNfiMunSY4gEeCS2ew1VqCjb1y8T7jEHNZpl7daWOn/nPUxgxjgePKNWCiAL7wyUTgNDqUN9LhQSPqYUyCs1gzEOUp/MgyO6ku3Cn87MIYzqxHCOmwngaqgcB34xhVU6lzU87KGUsuciDvJol4jJG7Q4aW5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707555; c=relaxed/simple;
	bh=Q//EaUB8Ickt4ie+ZEJ8B8mbUiWEqDNcT1u1Y/MzYs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gl99KPtMdoDTOth0k4wm/10xTOb5q2gqv4XNzUQ5+RtIzM8lVZH0TUaR6TMqG3tLoHDpz7Yj1X1X+6sOJuz/iKfHimQ2cE5yZ8jsR+9AXLC8mq6z9ttsNthNyj3gH6iwoO3LDv1L5iI2JDw/Zw+68y0EkxuhOq9a5Wq/P2ohu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk6A8KQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk6A8KQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BB71F000FF;
	Fri, 18 Sep 2026 04:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707552;
	bh=gLKODk4VuqGzm80H6ts02OrYWhsATIoy3K07f4uFIJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk6A8KQ2AsgiQF1oU2Y/mU7YjHA7zd1Regx+s5aAsZ187rcaiUmQlu5qKV6DTXvP4
	 5Ri6pDgxrd0bIILTP43kbMrcrLfQiQqH2jinu3qoQZVQbueg14u8jTk2yUlVzX1Mbk
	 VxK3SAAaTC1Ab+4THy5LK93tcs1CA3zhtufFVi6TKG2dSJfz1NsC7OXha+23pSd9Ae
	 eAQgVXmjfB0iiKvbruWm5VkwuatmnLBsF+r6STeKiVJII4deZUEkeMxnsCCxlhecTx
	 YQwWqNprLOPFXty3wuPC+189xZqEabhb5hTUMKFz6JTtJkWJa7PvRJZG20cW9wFV9z
	 LR215Oai63RsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Add an end-to-end
 .bpf_cleanup exception test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044332.3293447-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044332.3293447-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 04:59:12 +0000
Message-Id: <20260918045912.C6BB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments do not follow modern BPF style
--

commit 8ad5e7ea23b9dcb55029206d5cb36453b231f9c8
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add an end-to-end .bpf_cleanup exception test

This commit adds an end-to-end test for .bpf_cleanup exception handling. It
uses inline assembly to construct precise call-site brackets, landing pads,
and cleanup records that mirror compiler output. It also tests shapes that
the kernel should refuse, ensuring the JIT correctly handles or rejects
different landing pad configurations.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 0000000000000..d1e45b765af26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
[ ... ]
> @@ -0,0 +1,79 @@
[ ... ]
> +	/* foo3 throws; every pad runs and the cookie is delivered at entry. */
> +	if (test__start_subtest("throw_from_foo3"))
> +		run(skel, 101, THROW_COOKIE, PADS_FOO3_THREW);
> +
> +	/* foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second regi=
on;
> +	 * foo3's frame is long gone, so its pad must not run.
> +	 */

[Severity: Low]
Does this comment block follow the proper multi-line comment formatting
for the BPF subsystem?

The BPF subsystem strict guidelines require multi-line comments to have
the opening /* on its own line:

/*
 * foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second region;
 * foo3's frame is long gone, so its pad must not run.
 */

> +	if (test__start_subtest("throw_from_foo2"))
> +		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
> +
> +	exceptions_cleanup__destroy(skel);
> +
> +	RUN_TESTS(exceptions_cleanup_fail);
> +}

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 0000000000000..ce2dac306a84c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
[ ... ]
> @@ -0,0 +1,600 @@
[ ... ]
> +SEC("socket")
> +__failure __msg("reaches an indirect jump")
> +__naked void gotox_in_pad(void)
> +{
> +	asm volatile (
> +	".pushsection .jumptables,\"\",@progbits;"
> +"jt0_%=3D:"
> +	".quad l0_%=3D - socket;"
> +	".quad l1_%=3D - socket;"
> +	".size jt0_%=3D, 16;"
> +	".global jt0_%=3D;"
> +	".popsection;"
> +
> +"1:"	"call gotox_thrower;"		/* cleanup region */
> +"2:"
> +	"r0 =3D 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"r1 =3D jt0_%=3D ll;"
> +	"r1 +=3D 8;"
> +	"r2 =3D *(u64 *)(r1 + 0);"
> +	/* gotox r2. Spelled as a raw insn on purpose: the "gotox" mnemonic
> +	 * only reached the LLVM assembler in llvm 22, and BPF_RAW_INSN()
> +	 * needs <linux/bpf.h>, which this file cannot have -- vmlinux.h
> +	 * already defines the uapi enums.
> +	 */

[Severity: Low]
Does this multi-line comment format conform to the BPF style guide?

As with the previous comment in exceptions_cleanup.c, the BPF subsystem
mandates that the opening /* resides on its own line for multi-line
comments.

> +	".8byte 0x20d;"
> +"l0_%=3D:"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +"l1_%=3D:"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}
> +
> +#endif /* x86 || arm64 */
> +
> +char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D18
