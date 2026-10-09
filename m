Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028D3D7D74
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548532; cv=none; b=sKN+GsFQuDxAF9yB2vqudWFNHVRlI2its9pokjM192yKS7qwZjIkL3Ej2GkKxc8Z76UzwFz1GelmSGn7geooplUvQGPuPToQR1ulC8Gwgz97WCGC9cqoFB0sJBiShQMn2tyCb6k1/AVKRykN9uzXT1QmhfUz7o7/vBwzv/y1YmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548532; c=relaxed/simple;
	bh=cA3E91syAcUyeorL2SpagnISUa4Ngujv+3xkHfogm5s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Wx7m2qemGu358pEmYlqdJh1QFXBrBdaDugWTXgFA1fKFRzRuc56dJME8rrZSNaFow4qUVr1gVr94BYr7tyBf/DoRlOHPTNYqSBvU5M0MkbDSYkvynMarPYHc6CV+XpMZVO6BewDihUxopl4X2XsUAYKrF1VJVyWKwKSgls2RLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzecWWvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzecWWvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AFF1F000FF;
	Fri,  9 Oct 2026 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548525;
	bh=jOrE+lhVfyuRAKWwY787LY0Ty9QXG9/M4ag8KjFSGo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzecWWvrZ8uVmYShIXvy+Jr0vQGbV5A/+QahfERdSe0AS3Jp5ej8SyUYNWeIoNJjd
	 J59PQQtdFK2+rdJ5BpEpcdMeTCY8/wnaircTCs4GVElR6Yjw5tD2Oz5uznPUMl5UxZ
	 uvF4TaFFL9s+lymWrOx+dkTgE0JZ2JyPDLQzNqP+U6x5C5QlbaI1rK5BmP8K0C/pA3
	 qyLTp4ej61Iozopy4cKfhdR5xa/NL42vSshV/UA/qGL0bV4XwnPBuijGXHJILLct0U
	 vJ3lOj7Z0AbFxHisEoEVenfmgPlF/j0MvLHl1eEM9N6HZSx9yEw4f0bPLJk32fCFBT
	 /qBsgy1Dg0T5w==
Message-ID: <sashiko-outbox-165524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 47/51] selftests/bpf: tests for register
 base/step state pruning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-scev-minimal-rebase-v3-47-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
 <20261009-scev-minimal-rebase-v3-47-bcba9bc53ac9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:22:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftest step_prune_hit_multiple fails verification due to =
R0 leaking stack pointer
--

commit f9da8ee53b52465f66b36e329c27712344008e2e
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: tests for register base/step state pruning

This commit adds tests for base/step reasoning in range_within(), including
tests like step_prune_hit_multiple and step_prune_miss_non_multiple.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/t=
ools/testing/selftests/bpf/progs/verifier_bounds_step.c
> index 3a0d22aa4fb89..c9ee1c7efcbb8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c

[ ... ]

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
Will this selftest fail verification due to leaking a stack pointer?

It appears that r0 is assigned a stack address (r0 =3D r10; r0 +=3D r6;), b=
ut is
not reset to a valid scalar value before the exit instruction. As a
SEC("socket") program, the verifier requires r0 to be a valid scalar upon
exit, and returning a pointer to the stack will cause the verifier to reject
the program with an 'R0 leaks addr' error.

Since this test is marked with __success, wouldn't this verifier rejection
cause the test case to fail? Should r0 be reset (e.g., r0 =3D 0;) before ex=
it,
similar to how it is done in step_prune_miss_non_multiple()?

> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-scev-minim=
al-rebase-v3-0-bcba9bc53ac9@gmail.com?part=3D47
