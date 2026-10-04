Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8C1DDA18
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122047; cv=none; b=hVi0yFwtX3HLNwBUwyckmJtH5fKxLs9Zwwsh/n0QepnFiVIRTpXZr2yD6WFD5b7qRf7fR9fA6CcF6/6oX4fQLxM4iiNmnz7nxojfA/en0r2/U3y6B3EnRjvqn2Ff5vAgZgJCONkDySQJpJj1Izkk+QTpdyzdrQzzY82iFjDq3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122047; c=relaxed/simple;
	bh=UGUcLmb2mYYdlrultNxVzNu1uJhxAbUEdUUTB5F484s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GVooozOx+LrTv7UZ4mnfC6xIBD5c62pR5vRJMNUZwheKsFvESQ0La4VDjOeyOvCCcEro2yKYt1EmNT6322kLoZ+irwoTyL9nwNmK5Rkk5dAyvhxJu3536R7qEzs4IUn7oUBTLgUs52lIH6Qgnt97MUyVpt9XYzQ2TUkhHumLBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQYVT9rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQYVT9rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D341F000FF;
	Sun,  4 Oct 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122046;
	bh=5utwy4+peitted5HnTqKeDGiHQA6zMOk5xXR3ycoenU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQYVT9rnT0Q7i2gGdbvXHUkGo/q4pFHKXyzFZUErgRUxV02v2UVa0h9abwfY9CZof
	 EUissnhBcbNuMdqR5bFqvtsdpAGN4C56ZOPLjJtte/z2ZGrJW/nzW2iERyfyIb0Hl5
	 SjXUshAzMlZ5UR/7+M6Nd25KjOUs1PfFhrqLgQPdu5987pVgGcSGGsnq6feqZGv6Yt
	 ++OJmCpLWQGv+afCJikz788RbXfa8OM3YgMu6Ppqmjvr49lacSFUQ0wQM08bV1INve
	 hoyNFg9EMm/a8JeGpJXds/qczDk6mJq2XDEXFWI/KTb23GuEROP22zwQ6bln6RwCnh
	 7eVFwKSSE1YJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 39/43] selftests/bpf: tests for register
 base/step state pruning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-39-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-39-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:54:05 +0000
Message-Id: <20261004135405.D9D341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: leaked stack pointer on exit in step_prune_hit_multiple()
- [Low] bpf: unused inline assembly operands in step_prune_hit_multiple()
--

commit 5e4048fc2e6297e557be720eceffc54196686ad8
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: tests for register base/step state pruning

This commit adds BPF selftests to verify base/step reasoning in
states.c:range_within(). It includes tests for step pruning hits and misses,
including multiple steps and constant boundary scenarios.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/t=
ools/testing/selftests/bpf/progs/verifier_bounds_step.c
> index 079e34820a8f1..f1d8e36b39e35 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
[ ... ]
> +SEC("socket")
> +__success __log_level(2)
> +__msg("7: (27) r6 *=3D 4                       ; R6=3Dscalar({{.*}}umin3=
2=3D8,{{.*}}umax32=3D68,{{.*}},step=3D0+4)")
> +__msg("10: (27) r7 *=3D 2                      ; R7=3Dscalar({{.*}}umin3=
2=3D4,{{.*}}umax32=3D130,{{.*}},step=3D0+2)")
> +__msg("11: (25) if r0 > 0x2a goto pc+1")
> +__msg("from 11 to 13: safe")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void step_prune_hit_multiple(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 =3D r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r7 =3D r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 &=3D 0x0f;					\
> +	r6 +=3D 2;					\
> +	r6 *=3D 4;					\
> +	r7 &=3D 0x3f;					\
> +	r7 +=3D 2;					\
> +	r7 *=3D 2;					\
> +	if r0 > 42 goto 1f;	/* can't predict */	\
> +	r6 =3D r7;		/* step=3D2 explored first, step=3D4 explored next */ \
> +1:	r0 =3D r10;					\
> +	r6 =3D -r6;					\
> +	r0 +=3D r6;					\
> +	*(u8 *)(r0 + 0) =3D 7;	/* force r6 precise */	\
> +	exit;						\

[Severity: Medium]
Does this code leak a stack pointer on exit?

It appears r0 is set to r10 (the stack pointer), modified, and then we hit
the exit instruction without resetting r0 to a scalar. While the verifier
permits this in privileged test code due to allow_ptr_leaks, returning a
stack pointer from a socket filter seems like an unintended test logic
defect.

Could r0 be reset to zero here before exiting, similar to how it is handled
in other tests?

> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  __imm(bpf_map_lookup_elem),
> +	  __imm_addr(step_map)

[Severity: Low]
This isn't a bug, but do we need the bpf_map_lookup_elem and step_map
operands in this inline assembly block?

They are declared as input operands but appear to remain entirely unused
within the assembly code for step_prune_hit_multiple. Could they be removed
to simplify the test definition?

> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D39
