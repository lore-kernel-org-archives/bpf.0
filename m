Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008131E531
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400727; cv=none; b=RCg6wP03tzZ4BboCyJKz78+OA1ufZlZ9cB2VWAxTxGXBtFeJNqabw4gnC1aitgs3dfJyvO3J7hKAOYtKktH/dNUrsSNf/vBXTjfO8MHffXCmKmhboz7Yp0biLiRcFDXsZN8kShmlLXoJGW6hAaedIwR8rYct6cbqPmPrj8kxW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400727; c=relaxed/simple;
	bh=n7SIxW71I0R1WTFgSOmCk7Ju58sriVEPsXSK1zkOfvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cAU7eEGE0khAxaRK1NjC33RszFi4ETEaWgPIKxwFO/D3QlIdrppOSqbokJ69vokIqKnSVk5yOGTtLqho5erEu5xiSMwDPUfMQJbiw2K2/ERaHdmjHv5FpKg/442FDkY2NpEZemK/kFcJMXrUQkB1wTYM/yx8qbJ3hlTGt0NCezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv77fzfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv77fzfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CFEC2BCB0;
	Fri, 17 Apr 2026 04:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400726;
	bh=n7SIxW71I0R1WTFgSOmCk7Ju58sriVEPsXSK1zkOfvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dv77fzfYknyTF7m+dYdgQFC+1Zp7pqM6DPXYAyE/flIB01SbFuk3t+tiKnguRzhPt
	 f5UlLwQk1D0eOOoF0NVCcYbWEFKP1Z/SKD86l6tu89NMIOuU4tEeCEe9R8pKej1hzg
	 l7pSxTGV9v3UE5WynvR0I6vx1GsptdofhhzBpOmv4aaC8ZuvpzUTdLHlQH+FWQ2Dzy
	 Pejdp5fXb/Di3RGpAG5agmOQHxUPzqLf9Q6Px6DwCPwyUp0imKPxjUaY3W7ncLaRm7
	 3ev6DLSxNNC4WuLKbtvffa90KQkk0oZzipPGp0aZ1jJK5dgzKtdNkPHKWYSWme0cWY
	 Z0IlIeskTIRFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 16/16] selftests/bpf: Add verifier tests for
 stack argument validation
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034838.2638137-1-yonghong.song@linux.dev>
References: <20260417034838.2638137-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:38:45 +0000
Message-Id: <20260417043846.66CFEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Negative verifier tests for stack arguments use inherently inval=
id memory accesses, causing them to pass even if the verifier has bugs.
- [Medium] `stack_arg_read_uninitialized` reads from `r11 + 8` instead of a=
 valid negative offset, failing to properly test uninitialized stack argume=
nt slots.
- [Low] Unused `subprog_8args` function defined in the test file.
--

commit 24b1eb352e7d04e7c35a9fbc88c6b91d08b17832
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add verifier tests for stack argument validation

This commit adds inline-asm based verifier tests to directly exercise
stack argument validation logic.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
> new file mode 100644
> index 0000000000000..d212b6c3cac75
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c

[ ... ]

> +__noinline __used
> +static int subprog_8args(int a, int b, int c, int d, int e, int f, int g=
, int h)
> +{
> +	return a + b + c + d + e + f + g + h;
> +}

Is subprog_8args intended to be used in any of the tests? It does not seem
to be called anywhere in this file.

[ ... ]

> +SEC("tc")
> +__description("stack_arg: read from uninitialized stack arg slot")
> +__failure
> +__arch_x86_64
> +__msg("invalid read from stack arg")
> +__naked void stack_arg_read_uninitialized(void)
> +{
> +	asm volatile (
> +		"r0 =3D *(u64 *)(r11 + 8);"
> +		"r0 =3D 0;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}

Should this read from r11 - 8 instead? Since outgoing stack arguments are
at negative offsets from r11, reading from r11 + 8 is out of bounds and
might be rejected for the wrong reason, rather than testing an uninitialized
but valid stack argument slot.

[ ... ]

> +__noinline __used
> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, l=
ong *f)
> +{
> +	return *f;
> +}

[ ... ]

> +SEC("tc")
> +__description("stack_arg: release_reference invalidates stack arg slot")
> +__failure
> +__arch_x86_64
> +__msg("R1 invalid sock access")
> +__naked void stack_arg_release_ref(void)
> +{
> +	asm volatile (
[ ... ]
> +		/* Release the reference =E2=80=94 invalidates the stack arg slot */
> +		"r1 =3D r0;"
> +		"call %[bpf_sk_release];"
> +		/* Call subprog that dereferences arg6 =E2=80=94 should fail */
> +		"r1 =3D 1;"
> +		"r2 =3D 2;"
> +		"r3 =3D 3;"
> +		"r4 =3D 4;"
> +		"r5 =3D 5;"
> +		"call subprog_deref_arg6;"

Can this test pass even if the verifier fails to invalidate the stack slot?

subprog_deref_arg6() performs an 8-byte read on the argument. Since BPF
sockets only allow up to 4-byte reads, an 8-byte read is always invalid.
If the reference isn't correctly invalidated, the valid socket pointer
will still be rejected with "R1 invalid sock access".

To properly test the invalidation, should the subprogram perform a valid
4-byte read instead?

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pkt pointer in stack arg slot invalidated afte=
r pull_data")
> +__failure
> +__arch_x86_64
> +__msg("invalid access to packet")
> +__naked void stack_arg_stale_pkt_ptr(void)
> +{
> +	asm volatile (
> +		"r6 =3D r1;"
> +		"r7 =3D *(u32 *)(r6 + %[__sk_buff_data]);"
> +		"r8 =3D *(u32 *)(r6 + %[__sk_buff_data_end]);"
> +		/* check pkt has at least 1 byte */
> +		"r0 =3D r7;"
> +		"r0 +=3D 1;"
> +		"if r0 > r8 goto l0_%=3D;"
> +		/* Store valid pkt pointer to outgoing arg6 slot */
> +		"*(u64 *)(r11 - 8) =3D r7;"
> +		/* bpf_skb_pull_data invalidates all pkt pointers */
> +		"r1 =3D r6;"
> +		"r2 =3D 0;"
> +		"call %[bpf_skb_pull_data];"
> +		/* Call subprog that dereferences arg6 =E2=80=94 should fail */
> +		"r1 =3D 1;"
> +		"r2 =3D 2;"
> +		"r3 =3D 3;"
> +		"r4 =3D 4;"
> +		"r5 =3D 5;"
> +		"call subprog_deref_arg6;"

Similarly, does this properly test packet pointer invalidation? The test
verifies 1 byte of the packet pointer, but subprog_deref_arg6() reads 8 byt=
es.
If bpf_skb_pull_data() fails to invalidate the pointer, the 8-byte read wou=
ld
still be rejected as out-of-bounds, yielding the expected "invalid access to
packet" message.

Should the packet bounds check verify at least 8 bytes so that a valid read=
 is
guaranteed if the pointer isn't invalidated?

[ ... ]

> +SEC("tc")
> +__description("stack_arg: null propagation rejects deref on null branch")
> +__failure
> +__arch_x86_64
> +__msg("R1 invalid mem access")
> +__naked void stack_arg_null_propagation_fail(void)
> +{
> +	asm volatile (
[ ... ]
> +		"call %[bpf_map_lookup_elem];"
> +		/* Store PTR_TO_MAP_VALUE_OR_NULL to outgoing arg6 slot */
> +		"*(u64 *)(r11 - 8) =3D r0;"
> +		/* null check on r0 */
> +		"if r0 !=3D 0 goto l0_%=3D;"
> +		/*
> +		 * On null branch, outgoing slot is SCALAR(0).
> +		 * Call subprog that dereferences arg6 =E2=80=94 should fail.
> +		 */
> +		"r1 =3D 0;"
> +		"r2 =3D 0;"
> +		"r3 =3D 0;"
> +		"r4 =3D 0;"
> +		"r5 =3D 0;"
> +		"call subprog_deref_arg6;"

Does the __msg() substring match accept the wrong failure mode here?
Dereferencing an unrefined PTR_TO_MAP_VALUE_OR_NULL yields "R1 invalid mem
access 'map_value_or_null'", while dereferencing SCALAR yields "R1 invalid =
mem
access 'scalar'".

The substring match "R1 invalid mem access" accepts both, allowing the test=
 to
pass even if null propagation fails and the register is still tracked as a =
map
pointer. Should it match the exact scalar error, or perhaps test the non-nu=
ll
branch for success instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D16
