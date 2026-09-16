Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7D3D16EF
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535880; cv=none; b=nuQsakZaYsfiP+QjXnTTe9GqBqAcA/KAkOoEOjQY0UgULRF2sK/lNxjtt8Z1o4oXfDjsSYGEkRDiGoKyuy4nPj9xwKaXdcsxJrCwCbUNFNrAeTyVUZo39GbWtsnEDoR03MGUtpGeW7K/FNCGDaJuy618rEkBTvqRytD2BIQtFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535880; c=relaxed/simple;
	bh=mj2L1163t+xcemBtRm04iY/98uCjxldV6m8VrEk73FY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8AlM3tz6uXM4MINkWKtCXmiXFeO0pQrzZLU7M3J6SzNt076AupxMSoj3JN6jsf5FCzzG5MMwv2NZf1U6E3hbO0sXr7/yrjiP90cTz1dt2UmnOAlZVOauiMzJv7JpWHADc+2oMj7IqQvmJsGGIZPqvQVTPoS22ksgwfKutvCJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grtJbKIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grtJbKIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0DC1F000FF;
	Wed, 16 Sep 2026 05:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789535877;
	bh=jJ0tlRWM7ar5eTVnviOF+otemKU4d+uCR/ypTDODZyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grtJbKIMAsXj6Md+CcIi2thFRwHLer8hwrxLKpIQ3TawDMQyXM8n1gCWfHTzltubh
	 guojbQMl6enNZK0YBlphuBBZRogEs8VQZsYQkNjWyHorJMq/bEO9YCVKwfMjSq6oR5
	 mNp7yJmKbVYmJloNi4tEE/9Ea1beLUpb1JHjXyUCY8+eEW+c1O++voTjq4hGTcBO+T
	 xoK7tlRMktIu894H4+KfpfGlnP0QqwTlq/eqF33q41ZbXkcRh90zgxSFbqEGmRum4+
	 Byqa5roHmCvz/Ls+Gv6nJP4S1RVDj8ShbxFEi0PJd4dAki5A4TBqny3R9Tr76cKTR+
	 4J2YYfkL1QPTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 08/11] selftests/bpf: Test for mixed arena/nonarena
 code paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916050830.8774-9-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-9-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:17:56 +0000
Message-Id: <20260916051757.0C0DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: verifier tests for mixed-type CFG paths are vulnerable to c=
ompiler optimizations
--

commit 2865d7b4af7e52310b9ec10118abb32164639af3
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Test for mixed arena/nonarena code paths

Add a selftest to confirm the verifier rejects ALU operations
that return arena or non-arena results depending on code path.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index 332322c9b54cf..1ce9c4b784816 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -561,6 +561,55 @@ int arena_ptr_add_arena_ptr(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("syscall")
> +__failure __msg("same insn cannot be used with and without arena pointer=
")
> +int mixed_arena_scalar_alu64_scalar_first(void *ctx)
> +{
> +	volatile register __u64 reg asm("r3");
> +	__u32 pick_arena =3D bpf_get_prandom_u32();
> +
> +	reg =3D 1ULL << 32;
> +
> +	if (pick_arena) {
> +		asm volatile (
> +			"r9 =3D %[arena] ll;"
> +			"%[reg] =3D 0;"
> +			"%[reg] =3D addr_space_cast(%[reg], 0x0, 0x1);"
> +			: [reg] "=3Dr"(reg)
> +			: __imm_addr(arena)
> +			: "r9"
> +		);
> +	}
> +
> +	reg +=3D 1;
> +
> +	return 0;

[Severity: Medium]
Are these tests vulnerable to compiler optimizations?

Since these tests rely on the control flow converging to evaluate a single
instruction with mixed types (SCALAR_VALUE and PTR_TO_ARENA), could compiler
optimizations like Clang's tail duplication duplicate the reg +=3D 1; retur=
n 0;
block into both branches?

If the tail block is duplicated, the verifier would evaluate two separate
addition instructions, each with a uniform type, bypassing the mixed-type
check entirely and causing the test to fail to produce the expected
__failure __msg(...).

Should these functions be written using __naked and explicit assembly (like
mixed_arena_stack_atomic) to guarantee the exact instruction sharing
required for this test?

> +}
> +
> +SEC("syscall")
> +__failure __msg("same insn cannot be used with and without arena pointer=
")
> +int mixed_arena_scalar_alu64_arena_first(void *ctx)
> +{
> +	volatile register __u64 reg asm("r3");
> +	__u32 pick_scalar =3D bpf_get_prandom_u32();
> +
> +	asm volatile (
> +		"r9 =3D %[arena] ll;"
> +		"%[reg] =3D 0;"
> +		"%[reg] =3D addr_space_cast(%[reg], 0x0, 0x1);"
> +		: [reg] "=3Dr"(reg)
> +		: __imm_addr(arena)
> +		: "r9"
> +	);
> +
> +	if (pick_scalar)
> +		reg =3D 1ULL << 32;
> +
> +	reg +=3D 1;
> +
> +	return 0;

[Severity: Medium]
Similarly, could the tail addition here be duplicated into both execution
paths by the compiler, invalidating the test's mixed-type validation logic?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916050830.8774=
-1-emil@etsalapatis.com?part=3D8
