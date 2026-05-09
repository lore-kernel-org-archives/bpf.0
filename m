Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A213DDAE
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291524; cv=none; b=riJ/xj9FBz6YrIphV706RaDJUE8gmOOqZ7FKrC1fuaT8H/HgdztU5UFH5x8w2ING300KohD2aSBHXXwGxOR6XZsVkBwjbGnpEYHZW1gCOR/JHy15/wVjkSDUnZFAf/36/Tv6hsEBdQ3na6BgLSa9Yn3jebmT9uTLERO78RQLseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291524; c=relaxed/simple;
	bh=Ysyu03uoH4tw5ugBzMLJ/nDMA0lFzUe3jZJkuSdmk8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMFWaNdA/lII5uD2SGg/nGwz2Ggu1YEKVFkxAXBERd3JTwfJusq+Y9YACrNilh+FrV7l4PXUvtVZ7whe5vxUp1CXwlgkvMbi3PECBZw0tuZYFcQxMJwWWxeXOSOZGS1QKesOoxTt6oVEX5LrT142G99G6+FAu3/SsjOBBIl0Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcRoHRug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcRoHRug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1324AC2BCB0;
	Sat,  9 May 2026 01:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291524;
	bh=Ysyu03uoH4tw5ugBzMLJ/nDMA0lFzUe3jZJkuSdmk8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TcRoHRuguYfUFDE8xzf7tyHmXNpJmeQ/AwzTRs62p3XnM7w3ylJZJ+rIed/Yq+pyz
	 qK6bxlWmL4boIjzmnmoOWoUt0Xe1b9bGA3Z64TvFZ0DUm0oHigoNN2OIxlQRkWDE6r
	 pHl2hmXvoxM/xlQgVqvy/bjkrz+lpQ1c3mLwt5k/qUHhKkB0w8kgkbO5fRDRvfRyIn
	 Ap0c2f4xW8iJtcl5DJSi83lRVB9O+W9PL9huIe2k/kid1SREpD0PUGCsgoccVBbNyf
	 AIBqI+W11hFDadZkZWY//F+nHPR+UlxHSSt0VKqwHprLbi+j7b6rQvi6J5OkfYQaJz
	 ZcQbsKCtCvsgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 20/23] selftests/bpf: Add precision
 backtracking test for stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213150.1139244-1-yonghong.song@linux.dev>
References: <20260507213150.1139244-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 01:52:03 +0000
Message-Id: <20260509015204.1324AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Commit message and code comment incorrectly claim that the subpr=
ogram performs a bounds check.
- [Medium] Non-deterministic branching in the test program can lead to inte=
rmittent flaky failures by returning 36 instead of the asserted 25.
--

commit 953824567df7ff801d99eb6df49d76d95736325d
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add precision backtracking test for stack arguments

This commit adds a test to verify precision backtracking across BPF-to-BPF
calls involving stack arguments. The test aims to ensure precision propagat=
es
from a kfunc's size argument back through a subprogram frame.

> The test passes a size value as incoming stack arg (arg6) to a
> subprog, which bounds-checks it and forwards it as the mem__sz
> parameter (outgoing arg7) to bpf_kfunc_call_stack_arg_mem.

Is the description about bounds-checking accurate?=20

Looking at the inline assembly for subprog_call_mem_kfunc, it appears the
subprogram simply reads the size from the incoming stack slot and immediate=
ly
writes it to the outgoing stack slot without any bounds checking logic.

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/to=
ols/testing/selftests/bpf/progs/stack_arg_precision.c
> new file mode 100644
> index 0000000000000..c94905f07dcc1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
> @@ -0,0 +1,137 @@

[ ... ]

> +/*
> + * Test precision backtracking across bpf-to-bpf call for kfunc stack ar=
g.
> + * subprog_call_mem_kfunc receives a size as incoming stack arg (arg6),
> + * bounds-checks it, then passes it as mem__sz (arg7) to
> + * bpf_kfunc_call_stack_arg_mem.
> + *
> + * 1+2+3+4+5+(1+2+3+4) =3D 25
> + */

This isn't a bug, but should the comment be updated to match the
implementation? As mentioned above, the bounds check seems to be missing fr=
om
the assembly below.

> +__naked __noinline __used
> +static long subprog_call_mem_kfunc(long a, long b, long c, long d, long =
e, long size)
> +{
> +	asm volatile (
> +		"r1 =3D *(u64 *)(r11 + 8);"	/* r1 =3D incoming arg6 (size) */
> +		"r2 =3D 0x0807060504030201 ll;"	/* r2 =3D buf contents */
> +		"*(u64 *)(r10 - 8) =3D r2;"	/* store buf to stack */
> +		"r2 =3D r10;"
> +		"r2 +=3D -8;"			/* r2 =3D &buf */
> +		"*(u64 *)(r11 - 8) =3D r2;"	/* outgoing arg6 =3D buf */
> +		"*(u64 *)(r11 - 16) =3D r1;"	/* outgoing arg7 =3D size */

[ ... ]

> +__naked void stack_arg_precision_bpf2bpf(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 =3D r0;"
> +		"r1 =3D 1;"
> +		"r2 =3D 2;"
> +		"r3 =3D 3;"
> +		"r4 =3D 4;"
> +		"r5 =3D 5;"
> +		"if r6 < 2 goto l0_%=3D;"
> +		"*(u64 *)(r11 - 8) =3D 4;"
> +		"goto l1_%=3D;"
> +	"l0_%=3D:"
> +		"*(u64 *)(r11 - 8) =3D 6;"
> +	"l1_%=3D:"
> +		"call subprog_call_mem_kfunc;"
> +		"exit;"
> +		:: __imm(bpf_get_prandom_u32)
> +		: __clobber_all
> +	);
> +}

Could this lead to intermittent test failures?

The test asserts a strict return value of 25:

__success __retval(25)

If bpf_get_prandom_u32() happens to return 0 or 1, the size argument is set=
 to
6 instead of 4. In that case, bpf_kfunc_call_stack_arg_mem() will sum up 6
bytes instead of 4, returning 36 instead of 25, which would cause the test =
to
fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D20
