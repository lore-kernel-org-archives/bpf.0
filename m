Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09D8248B
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365600; cv=none; b=fS+hTav3ewB+LvoEJC2P2oUsM6GeLSgWn+3fbd/9nfcYZGzW5KKAk0VzO+KlB/BMyQClTKxWucfM2kyCe3h1qjjObCHXgWNX2TQKr0eQPLBa85Wt9FrsnBMYBPFdAoCGYwK8+9AUXeicpMD9mMbYs3M8wjfofaf/s9cjzjSzu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365600; c=relaxed/simple;
	bh=/r8Rd/hpqoIocaRq4e/YLwAoCue46AOgUJ7i8y2CJoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2ednMOKsvXbuyl82gFy8bkL74Dkwg2ccVtRrqKu3FvPNPmXZ5vnPpStYQGUEO2YygcXS8wzc1yZSO/F753cjcIrzWFmNQNOaAesazSuzX+Vcis6Kz0l/fbV8pQOa34jAMQ9v2bIHFOuXyvUz+q9eJPNo9VLK7no+6OR3EPujZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2d8rkOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2d8rkOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2262BC2BCAF;
	Thu, 16 Apr 2026 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776365600;
	bh=/r8Rd/hpqoIocaRq4e/YLwAoCue46AOgUJ7i8y2CJoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i2d8rkOHE14ImcbcSxgYDEWWtLjKL0BvjPMiSFry7kdPFi+XKoujzhGD5Im4bKBOT
	 0ZDU54zZbyCAK+JK9jy8wtZkvg7/Uydia4IkmlQ4mNXjpp8VAkMLjfJGfIDi8P1oLB
	 kY28GFyVnCQXvnfd3w2Y+aHyShJw0KP9wamiI+yPGGWpKyoNw/8vvbDfkC77HfZvKp
	 p8djveXA5RS5n7O9aIs54b/IF0iDvr/bl5aOhxs84E4faCxcAoPAzPkcG+BZzKkRi6
	 9ZxIca5IM1LOyA4Hh3EMq+kui/USISwEZljCCTmxH+v4+a6wPhT/XFc0p+60fLfkAP
	 zTHRYkEeT5kaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/7] selftests/bpf: Test for empty
 intersection of tnum and u64
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <cf4061f2e91d271f1f44160a0b87a87ec6df5428.1776344897.git.paul.chaignon@gmail.com>
References: <cf4061f2e91d271f1f44160a0b87a87ec6df5428.1776344897.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:53:19 +0000
Message-Id: <20260416185320.2262BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Fragile test design relies on verifier's ignorance of `bpf_get_p=
random_u32()` bounds, risking silent test decay.
- [Low] Misplaced and factually incorrect inline comments misrepresent veri=
fier state.
--

commit 8da3729bc39d37f67823aa031e7ba1b8b0d69fe0
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Test for empty intersection of tnum and u64

This patch adds a verifier selftest for the case where tnum and u64
don't intersect on a branch, allowing the verifier to deduce that the
branch is dead code.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index c1ae013dee29c..151c7a479a6b8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void =
*ctx)

[ ... ]

> +SEC("socket")
> +__description("dead branch: tnum and u64 don't intersect on true branch")
> +__success
> +__naked void empty_tnum_u64_intersection(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	r6 =3D r0;									\
> +	r1 =3D 0xe00000002 ll;								\
> +	r2 =3D 0xf00000000 ll;								\
> +	if r6 s< r1 goto +2;								\

Will this test silently decay if the verifier improves its tracking of help=
er
return values?=20

bpf_get_prandom_u32() returns a 32-bit unsigned integer. If the verifier is
updated to track that this helper returns a value bounded by 0xffffffff, it
will statically deduce that the condition r6 s< 0xe00000002 is always true.=
=20

This would prune the fallthrough path as dead code, causing the test to
silently pass without ever exercising the complex tnum vs u64 intersection
logic it was explicitly created to test.

Could we use a true 64-bit unknown scalar, such as bpf_ktime_get_ns(), to
ensure the test remains robust?

> +	/* On fallthrough, r6's u64=3D[0xe00000002;0xf00000000] */			\
> +	/*                      tnum=3D(0xe00000000; 0x1ffffffff) */			\
> +	if r6 s> r2 goto +1;								\

Are these inline comments misplaced?=20

The upper bound of 0xf00000000 is only established after the=20
if r6 s> r2 goto +1 instruction falls through, not before it.=20

> +	/* On fallthrough, r6's tnum=3D(0xe00000001; 0x100000000) */			\
> +	/* It doesn't intersect with the u64 so the condition is always false *=
/	\
> +	if w6 =3D=3D 1 goto +1;								\

Does this tnum state actually exist on the fallthrough?=20

According to the verifier log in the commit message, the tnum state of
(0xe00000001; 0x100000000) only exists on the true branch of=20
if w6 =3D=3D 1 goto +1, not on the fallthrough.=20

Describing the taken branch as a fallthrough and placing the state annotati=
ons
before the instructions that actually establish them might make the test co=
de
confusing for maintainers trying to understand the exact verifier state at
each step.

> +	exit;										\
> +	r10 =3D 0;									\
> +	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1776344897.gi=
t.paul.chaignon@gmail.com?part=3D2
