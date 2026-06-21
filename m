Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E43009D4
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063444; cv=none; b=S/BJtiSVb9cbgU5WgX2zWUQJV0QY8W4YQcFC7xX/yfJNepvwQLLgz5nDCAjC0Iw/LJZYc2792Hu5tVJft1O6ZXEyMaJR+Xkvc/TggG2YidIYeEcPuwsC1xwOf+HLe575kP7Xr1J6qfp6AJrme682YKBkOPch8bO2J/WPWiD7RqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063444; c=relaxed/simple;
	bh=jwweCPeIfTj7PEVLXeXwZAvdXPsfSY34SvQ243bdOt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAm8fOu1GpPNtaqWhYfvB6Z5M5WGuv87kZJgT8jQwiZJdW/MK/wqpI+wHtwktmPPdHahTFV5i5w8kxRbhNbZp7PRxYRBbzoMbWOlvWdhzyxgzVzqTjMlBfFjM2naO16CAtJE5bZBsrAyNoQTu7QVwv3Hz9dfzdqCBQmik9AyJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsxDn5SC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsxDn5SC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B8E1F000E9;
	Sun, 21 Jun 2026 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063442;
	bh=O2Kwb/6E27Jenb5JpUKuKhUwRXwPIIokX4dO0qVvVao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsxDn5SC228pzn5pCSBXwAaYVXsvvlWF7uLqzTX6DTLtLiXPNG4a8vKjioagUFafK
	 h5CgINuj1N9dopAwuaPbT6TaDOCsl9RcAq6Yo6zybj7nqKwScdCdkwrt/CyrJ8jknc
	 dqSTPE58QLc5I9+UVxbV30KaXpQho6Pq+UNGIyQUC69RZYy/JwPjqflsxsdffPA2OU
	 l74bO+hXp6s+UQIJdgN4TjnErr/+Gj4tOTXGUMednebyIYiICjHggtT/YvEY4w3DPw
	 3kzhvoKqTRUGkpMe9WfP1tI1VbwwxC4j2moCUhVlFQbYJpu0WRbK1bRpHhHxvQvw3u
	 d0EvaxKzfh+Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v4 3/4] selftests/bpf: Tests for per-insn
 sync_linked_regs() precision tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621172735.409355-4-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
 <20260621172735.409355-4-jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 17:37:21 +0000
Message-Id: <20260621173722.05B8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Comments in the BPF inline assembly test code do not match the actu=
al code behavior.
--

commit 8cfad280c9480026408fc730009d851cebb78323
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking

This commit adds several test cases to verify precision tracking for
scalars gaining range because of sync_linked_regs(). It checks limits
on linked registers, precision propagation across conditional jumps,
and includes a minimized reproducer for a reported precision tracking bug.

Link: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/to=
ols/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index f70392bf696c6..2eb85eb3a06cc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

[ ... ]

> +SEC("socket")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("frame0: regs=3Dr3 stack=3D before 5: (2d) if r1 > r3 goto pc+0")
> +__msg("frame0: parent state regs=3Dr0,r1,r2,r3 stack=3D:")
> +__msg("frame0: regs=3Dr0,r1,r2,r3 stack=3D before 4: (b7) r3 =3D 7")
> +__naked void linked_regs_bpf_x_dst(void)
> +{
> +	asm volatile (
> +	/* r0 =3D random number up to 0xff */
> +	"call %[bpf_ktime_get_ns];"
> +	"r0 &=3D 0xff;"
> +	/* tie r0.id =3D=3D r1.id =3D=3D r2.id */
> +	"r1 =3D r0;"
> +	"r2 =3D r0;"
> +	"r3 =3D 7;"
> +	"if r1 > r3 goto +0;"
> +	/* force r0 to be precise, this eventually marks r1 and r2 as
> +	 * precise as well because of shared IDs
> +	 */
> +	"r4 =3D r10;"
> +	"r4 +=3D r3;"

[Severity: Low]
This isn't a bug, but the comment states it forces r0 to be precise, while
the code actually uses r3 here. Is this a copy-paste error from
linked_regs_bpf_x_src?

> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_ktime_get_ns)
> +	: __clobber_all);
> +}

[ ... ]

> +SEC("socket")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +/* check thar r0 and r6 have different IDs after 'if',

[Severity: Low]
This isn't a bug, but there's a typo here ("thar" instead of "that").

> + * collect_linked_regs() can't tie more than 6 registers for a single in=
sn.
> + */
> +__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=3Dscalar(id=3D1")
> +__msg("9: (bf) r6 =3D r6                       ; R6_w=3Dscalar(id=3D2")
> +/* check that r{0-5} are marked precise after 'if' */
> +__msg("frame0: regs=3Dr0 stack=3D before 8: (25) if r0 > 0x7 goto pc+0")
> +__msg("frame0: parent state regs=3Dr0,r1,r2,r3,r4,r5 stack=3D:")
> +__naked void linked_regs_too_many_regs(void)
> +{
> +	asm volatile (
> +	/* r0 =3D random number up to 0xff */
> +	"call %[bpf_ktime_get_ns];"
> +	"r0 &=3D 0xff;"
> +	/* tie r{0-6} IDs */
> +	"r1 =3D r0;"
> +	"r2 =3D r0;"
> +	"r3 =3D r0;"
> +	"r4 =3D r0;"
> +	"r5 =3D r0;"
> +	"r6 =3D r0;"
> +	/* propagate range for r{0-6} */
> +	"if r0 > 7 goto +0;"
> +	/* make r6 appear in the log */
> +	"r6 =3D r6;"
> +	/* force r0 to be precise,
> +	 * this would cause r{0-4} to be precise because of shared IDs
> +	 */

[Severity: Low]
This isn't a bug, but should this comment say r{0-5}? The __msg expectation
above checks for r0 through r5 since the verifier ties up to 6 registers.

> +	"r7 =3D r10;"
> +	"r7 +=3D r0;"
> +	"r0 =3D 0;"
> +	"exit;"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621172735.4093=
55-1-jt26wzz@gmail.com?part=3D3
