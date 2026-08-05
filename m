Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40624A35
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892993; cv=none; b=PtemIJ218OAh8sN5iQKZHAyz6F/8aOQnHbjU8qTKXhtphgwwFYKlfkwTfcR1TXpa0cPfWB4yOVftyYKmjUXj5pN3Cdqcbzi+FAJUsBtgXXgi2u3rPUxpYBO9b2EUA3tIBSq2HSLRRY4wOaILJsev42C0pfjml6z7vaFEHMKVN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892993; c=relaxed/simple;
	bh=v/VCQ+LSWEdOSPE81WtbfdSDJjb+l41wOecXxvxzSZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=npKjb9f8pRo1rnoFY4IEWgRy2+/yzofAkrqHyB8FZJ//Be+OSxED0l5sFlF8BODQB3DHefGGUYk7T4DXeyoqcsZB4CjqtRu8n0/9L5h1IIvbofIp0DMwoWx7acTi5+yLd8m08wPQuQ6c9p7z2BRrslVm6eolUEVeyDPTmDJ/08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRvuLBXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRvuLBXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4491F000E9;
	Wed,  5 Aug 2026 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892992;
	bh=d+5e3mEIqISNK7V+3lVpArMgClDBTVRtJNPCRnDTQSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRvuLBXDam+5K9WJ9286dCBlmLAwQ//WUJnOl2Av99Z9xTGIcfCHIieBcRJ3DkS9z
	 aIoPJoPtGCTC8eCOhAqNGo6E7HPoOU5cNTVyNuDyMsuzDznuab6IVW60SbFdrm2RAi
	 fVOS/6NBPsVo099e0xYyij1z6FLhGg3Xa9GkjEZj6C3IPhgFIly85AlGJSYSKWJNA9
	 mU3WfGeudYs213WKQlmgQan2D1tYgqFkDokxoXOQKpJBhLq8fprBbil4PBCudjkr0O
	 nCEnQv/xFbTG1ociGTBlcijK2cLVJjGNmRRBFJdEnBVVC1dlKkygIN+V3zoVnahzPF
	 zrNaiz3qLqRbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 6/6] selftests/bpf: Test subprogram
 instruction statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805011517.1717238-7-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
 <20260805011517.1717238-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:23:10 +0000
Message-Id: <20260805012312.4D4491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inline assembly in non-naked C functions implicitly reads argume=
nt registers, risking register corruption and test failures due to unstable=
 instruction counts.
--

--- Patch [6]: [PATCH bpf-next v6 6/6] selftests/bpf: Test subprogram instr=
uction statistics ---
commit 567cc6b8313bad87d8db2a9e9b28df5026767381
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test subprogram instruction statistics

Adds small verifier programs with deterministic instruction streams to
exercise per-subprogram own and inclusive instruction accounting.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stat=
s.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c

[ ... ]

> +__noinline __used
> +static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
> +				  struct timer_value *value, void *ctx)
> +{
> +	asm volatile (
> +		"r1 =3D r3;"

[Severity: Medium]
Because stats_async_schedule() is not marked __naked, could the compiler
emit prologue or epilogue instructions that change the exact instruction
count, causing the strict test assertions (e.g., insns_own 6) to fail?

Also, since r3 is implicitly read here without an input constraint, is
there a risk that the register allocator could clobber r3 before the
assembly block executes?

[ ... ]

> +__noinline __used
> +static int stats_async_outer(void *map, __u32 *key, struct bpf_timer *ti=
mer)
> +{
> +	asm volatile (
> +		"r1 =3D r3;"

[Severity: Medium]
Similarly, does the lack of __naked on stats_async_outer() risk unexpected
prologue instructions breaking the exact instruction counts?

Could the implicit use of r3 without an input constraint result in register
corruption?

[ ... ]

> +__noinline __used
> +static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
> +					 struct timer_value *value, void *ctx)
> +{
> +	asm volatile (
> +		"r1 =3D r3;"

[Severity: Medium]
Could the compiler emit extra instructions here for
stats_async_nested_schedule() since it is not marked __naked, breaking
the expected instruction counts?

Does reading r3 without constraints here also risk register corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805011517.1717=
238-1-memxor@gmail.com?part=3D6
