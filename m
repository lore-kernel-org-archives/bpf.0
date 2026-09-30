Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5036F905
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797710; cv=none; b=iHAJZJJzQHIuaCw2uOO2IwuXtM6w9+r1uXzVs0iVZ7VFA0SfoxtHXk85HOcSAURNlTwY/bD9KnUvqIuHQdzweE2lpKbOW8BqFUWEmRt1mYzVbJAo2xxOqVLY6+jRBYe4zwMX/aqlzCUqh8MmGZMFBIcWYCqta61tAGbnQ28TZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797710; c=relaxed/simple;
	bh=MMluh5Pm7qfU6KM5DFTv+Bg6YkjopC+fS0qoN6ERu0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+dCWuL99oKSFwnUbS9pEmztiMZdfid7/d9eq+3unY+AZwu7vPuhHXz1VPq17Ogj3+Ud+bQvVnnHEk0ag10w/63myhhtFwLFZHQjyJphi24FWhvIFD7EciWrfxjPyuuUJw94n9P9oP+73N4t7PWZQhjT/dqJ+0ftr3Gs1xbSS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQiYKgwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQiYKgwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A601F000FF;
	Wed, 30 Sep 2026 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797707;
	bh=V5uD3fYCHmqAq/OlBKptMq5kjSyzUKqbRVT8oqo/eAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQiYKgwZPRRgFaNWrXl4SGA3tZsumZVtc6J/Tse07it4Ldw/eAWJOflC29gfwZFZR
	 P4Q1EcuXtiIcP5CfZBseKmuzPZf2+ftYWL7x5Zl1oT9NvDZSKax+9zJ2Beo2o6uhk3
	 OIKrxZe6Q3kV1NnUE2LBcDqMhgMDuOjNFU82SD7Pv/lxrjo1kWb1ffLj53bixmSruR
	 LM71QLqeNAvgEtFMiSbUCZpY/D78nj1iCF4YP8hvPve0YV/KEB23vBqpl3MsV/sVmg
	 519RPNF0T/Z94PWIcAOoUu4M3BJTY8Um039Ho2hh+kectmfaMcf8Q+SxlUjyZM1cOY
	 bzVisGYpKcFbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 04/14] selftests/bpf: Add tests for arena
 access through numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930193127.2181684-5-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:48:26 +0000
Message-Id: <20260930194827.05A601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: verifier rejects valid atomic RMW due to register aliasing =
in check_atomic_rmw
--

commit 3887e0dd2a26cbc2d80c4f160a7eb98315fcc18d
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add tests for arena access through numbers

This commit adds various tests for loading and storing through addresses
returned by bpf_arena_alloc_pages() without cast_kern. It includes tests
covering different sizes, atomic operations, and boundary conditions for
arena and non-arena pointers.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/=
tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
> new file mode 100644
> index 0000000000000..bebc37f501b7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c

[ ... ]

> +SEC("syscall")
> +__arena_scalar
> +__description("arena_scalar: xchg into the register that holds a pointer=
 to stack")
> +__failure __msg("misaligned access off (0x0; 0xffffffffffffffff)+0 size =
8")
> +__naked void xchg_into_stack_ptr(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D %[arena] ll;				\
> +	r1 =3D 0;						\
> +	*(u64 *)(r10 - 8) =3D r1;				\
> +	r1 =3D r10;					\
> +	r1 +=3D -8;					\
> +	.8byte %[xchg_insn]; /* r1 =3D xchg_64(r1 + 0, r1) */ \
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm_addr(arena),
> +	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_=
REG_1, 0))
> +	: __clobber_all);
> +}

[Severity: Medium]
Does this test codify an incorrect verifier rejection?

It appears the BPF verifier incorrectly rejects valid atomic read-modify-wr=
ite
operations (like xchg r1, [r1]) on non-arena pointers (like PTR_TO_STACK)
due to in-place register corruption.

Looking at kernel/bpf/verifier.c:check_atomic_rmw() at line 7312:

    /* load_reg may be dst_reg. Look at dst_reg before it's marked as unkno=
wn. */
    dst_reg =3D mem_access_reg(env, insn->dst_reg, &arena);

    load_reg =3D bpf_atomic_load_reg(insn);
    if (load_reg >=3D 0) {
        /* check and record load of old value */
        err =3D check_reg_arg(env, load_reg, DST_OP);

Since kernel/bpf/verifier.c:mem_access_reg() at line 7162 returns a live
reference to the register state for non-arena pointers:

    if (!is_arena_scalar(env, regno))
        return cur_regs(env) + regno;

Could this cause an aliasing bug when the live register is later mutated by
check_reg_arg(), leading to this test's misaligned access failure message?

This is where the verifier attempts to snapshot the destination register st=
ate
but fails to isolate it from the source register mutation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930193127.2181=
684-1-alexei.starovoitov@gmail.com?part=3D4
