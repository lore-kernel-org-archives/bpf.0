Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6182F7F1F
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457058; cv=none; b=QIymGFaRzdhYY3zaYKhHUvbYAF1XbhoDf+BWTXZ2stVk8p48G1UFhbxyoJMx5/CyalnBVS8Y+Y5VOQIafv3Izh/kxaNcVFf8RIJUdOignzOU4j1CvcJdXepQu4yOEjUDWAhra9tohNCGTgjKm2t9rzJad9RIym9VGO1DginR9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457058; c=relaxed/simple;
	bh=mif3gOEoWl8VuMEp6Wz6D8WUxMF+dtckAcbzP5u8Qy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUYpqAR+mBbQrnX7Si+CpdK3HhfYI+mPzZQKC9m5MQCMyB0k9nf7kBeuPxvqOpUrV8/Yjyv7mLpT7mM8KarwBmgamjIfQMRUtTxJ9D18zGML7LXN4oaO/+cC2/2ae+iV6cFyEVSYPU9Bxz2RgDVPYOiHlB74vDq0/8tVvFQvKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4MDS1iU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4MDS1iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD81F00A3A;
	Sun, 14 Jun 2026 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457056;
	bh=d8y6Z3uKOxku73yuz86fnJExt917NPcDe9B9lyOWZ1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4MDS1iUfJ+Y5sqjEQGYLDRke4rlXBn/79ggq519BRtBrmv9uTIVTF8OVTOLcpl4Y
	 2L9hztyaWEob9KCdu67zwX8z2GlY77Cff4f4GleHD3uJ4J4w3+t+6Z6EiIFTmp15Wr
	 WxSfRGTVKz/Aolh0X8/1WVx7SAdAxuBzR0p5mJeiGtT9tarIR+uF1fqcmcBHUma4Gs
	 WCciniaIZwL/tI+C3xAiCRFrDRFSt5o5b97cLrQEDJEHgeoBuzpg6cXY+0uPUtQuTr
	 5E2+yRQ3PWWDqmmyl0i6hfZFy66RK4cZywlHQIY5ISKc4xvr9sH0413D9crTumpwTK
	 nsuCL3kPrRFGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v3 3/4] selftests/bpf: Tests for per-insn
 sync_linked_regs() precision tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <7701766e65ee2b13c8951e918ebde4cc3fc1263f.1781194510.git.jt26wzz@gmail.com>
References: <7701766e65ee2b13c8951e918ebde4cc3fc1263f.1781194510.git.jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 17:10:55 +0000
Message-Id: <20260614171056.16DD81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Newly added multi-line comments violate the strict BPF subsystem co=
mment style by placing text on the same line as the opening `/*`.
- [Low] A comment in `linked_regs_bpf_x_dst` incorrectly claims to force `r=
0` to be precise, but the corresponding code actually targets `r3`.
- [Low] A comment in `linked_regs_too_many_regs` incorrectly states that `r=
{0-4}` will be precise, missing `r5`.
--

commit 85ad29f2c85dcd0b0ee951c5fc1bc2711d79a7a5
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking

This commit adds test cases to verify precision tracking for scalars gaining
range because of sync_linked_regs(). It includes checks for when more than 6
registers might gain range, precision propagation, and adds a reproducer
for a precision tracking bug.

Link: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/to=
ols/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index f70392bf696c6..2eb85eb3a06cc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> @@ -47,6 +47,72 @@ __naked void linked_regs_bpf_k(void)
>  	: __clobber_all);
>  }
> =20
> +/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
> + * check that verifier marks r{1,2} as precise while backtracking
> + * 'if r1 > ...' with r0 already marked.
> + */

[Severity: Low]
This isn't a bug, but the BPF subsystem multi-line comment style requires
the opening /* to be on its own line, rather than starting text on the first
line.

> +SEC("socket")
> +__success __log_level(2)

[ ... ]

> +/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
> + * check that verifier marks r{0,1,2} as precise while backtracking
> + * 'if r1 > r3' with r3 already marked.
> + */

[Severity: Low]
This isn't a bug, but here's another instance where the multi-line comment
starts text on the opening line instead of placing the /* on its own line.

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
This isn't a bug, but should the comment here say "force r3 to be precise"
instead of "force r0"? The code actually targets r3, so this appears to be
a copy-paste error from linked_regs_bpf_x_src.

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
> + * collect_linked_regs() can't tie more than 6 registers for a single in=
sn.
> + */

[Severity: Low]
This isn't a bug, but just a quick note that this multi-line comment also
doesn't follow the preferred BPF style of having the opening /* on its own
line.

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
This isn't a bug, but could the comment mention r{0-5} will be precise inst=
ead
of r{0-4}? The __msg assertion properly verifies regs=3Dr0,r1,r2,r3,r4,r5, =
so
the text might be accidentally omitting r5.

> +	"r7 =3D r10;"
> +	"r7 +=3D r0;"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_ktime_get_ns)
> +	: __clobber_all);
> +}

[ ... ]

> +/* Check that mark_chain_precision() for one of the conditional jump
> + * operands does not trigger equal scalars precision propagation.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment starts text on the opening
line, similar to the ones above.

> +SEC("socket")
> +__success __log_level(2)
> +__msg("3: (25) if r1 > 0x100 goto pc+0")
> +__msg("frame0: regs=3Dr1 stack=3D before 2: (bf) r1 =3D r0")
> +__naked void cjmp_no_linked_regs_trigger(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781194510.gi=
t.jt26wzz@gmail.com?part=3D3
