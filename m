Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C572621
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786171012; cv=none; b=Sg2y5bqcSwQBi0xvegUN3RwuB3T9LdhPtGwzJNgeYSp+cKdMfvR/M+FnHZwhzcfVkLhkyajMVjWfielPQxKLcU7Khw51obWlu3VMFFFzq/Dsmsh+8XanUiv1+PbvTr50GSyxS0XGHSGD9K56LYMYmpcPP+ztdPKcL3RsudmighQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786171012; c=relaxed/simple;
	bh=vVtPpx8bRs5QyIaMmkKCs1urBeVGSwVEJCr9vkFECwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DER8yqOAAfqVnE/BS2ufpznxYOHw5ihZmGh8tmkML7BULWXY+tB//gCN7/mNXCZNINN2oWp6XmNJEgZjNaNotdVfTo+UP2bm29Y+cwer/WFFHKO6HLrvT0t2eMbnynWAZimhlHomd+uX04MofDxPwM86FhPKi1DN9nsZXAMDDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCZL1xHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCZL1xHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD8F1F000E9;
	Sat,  8 Aug 2026 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786171011;
	bh=2auRkGmOLyp8M47zrVqn73Hx0Ikmk54m/xr1ypJjCl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCZL1xHGdwbBVngS5PW+xxgYgA4rw0JqC6ZuIjTzNXzVTTqPPCRyA3T+ND5MErxQd
	 LvrAAB8+GCzo+/nerEfEhkJuxviqmwDYfWMKp+mnMeV3UabtnUtz5CJDQGlkyHi1O7
	 nRH7GbUsELBZmW9aUcekmZ+mQnDn4ChKuYFx/+NMJdFRKWaNCvOHtd07LcLBebKkx7
	 /D0f028RsWDsD7ovF5wVE2R2HUCHpBPpQzJJr2WANp/tHg0jnLEk1viLfOBVwl+SQs
	 mzbCjaI4K29lV6p8ODx+S3vH4E2jJRTGhZODXHiqwxt/vO2jixiOZTrmI8zy89ktEa
	 Mg0Jij+0KZ+KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: Test subprogram
 instruction statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808062601.1070988-7-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
 <20260808062601.1070988-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 06:36:50 +0000
Message-Id: <20260808063650.DDD8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The expected verifier logs for `stats_async_schedule`, `stats_as=
ync_outer`, and `stats_async_nested_schedule` mandate exactly 7 instruction=
s and `stack 0`. However, because these are standard C functions (lacking `=
__naked`) that use inline assembly with `__clobber_common` (which clobbers =
all caller-saved registers `r0-r5`), the compiler must allocate callee-save=
d registers (e.g., `r6`, `r7`) for their input operands. This forces the em=
ission of prologue and epilogue stack spills, guaranteeing a non-zero stack=
 depth and a higher instruction count. The rigid `__msg` assertions will fa=
il at runtime.
--

--- Patch [6]: [PATCH bpf-next v7 6/6] selftests/bpf: Test subprogram instr=
uction statistics ---
commit af1dc26c02b580a6a5ab3fdfc1f191d5895df8f8
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test subprogram instruction statistics

Add small verifier programs with deterministic instruction streams to
exercise per-subprogram self and inclusive instruction accounting. Use
assembly for normal call chains and straight-line callback bodies containing
only moves, calls, and returns or exits.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stat=
s.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
> new file mode 100644
> index 0000000000000..cbf83ee9f8f2f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c

[ ... ]

> +__noinline __used
> +static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
> +				  struct timer_value *value, void *ctx)
> +{
> +	asm volatile (
> +		"r1 =3D %[timer];"
> +		"r2 =3D %[stats_async_leaf];"
> +		"call %[bpf_timer_set_callback];"
> +		:
> +		: [timer] "r" (value),
> +		  __imm_ptr(stats_async_leaf),
> +		  __imm(bpf_timer_set_callback)
> +		: __clobber_common
> +	);
> +	return 0;
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(4)
> +/*
> + * self: 9 + 7 + 2 =3D 18
> + * totals: leaf 2, scheduler 7, main root 18
> + */
> +__msg("subprog 0 (stats_async_direct) main insns_self 9 insns_total 18 s=
tack 0")
> +__msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_self 7 "
> +      "insns_total 7 stack 0")

[Severity: Medium]
Since stats_async_schedule() is a standard C function (lacking the __naked
attribute) and the inline assembly uses __clobber_common (clobbering r0-r5),
won't the compiler be forced to allocate callee-saved registers (like r6 or=
 r7)
for the input operands?

If the compiler emits prologue and epilogue stack spills for these register=
s,
it would result in a non-zero stack depth and a higher instruction count,
causing the expected "stack 0" and "insns_self 7" verifier log assertions to
fail at runtime.

[ ... ]

> +__noinline __used
> +static int stats_async_outer(void *map, __u32 *key, struct bpf_timer *ti=
mer)
> +{
> +	asm volatile (
> +		"r1 =3D %[timer];"
> +		"r2 =3D %[stats_async_nested_leaf];"
> +		"call %[bpf_timer_set_callback];"
> +		:
> +		: [timer] "r" (timer),
> +		  __imm_ptr(stats_async_nested_leaf),
> +		  __imm(bpf_timer_set_callback)
> +		: __clobber_common
> +	);
> +	return 0;
> +}
> +
> +__noinline __used
> +static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
> +					 struct timer_value *value, void *ctx)
> +{
> +	asm volatile (
> +		"r1 =3D %[timer];"
> +		"r2 =3D %[stats_async_outer];"
> +		"call %[bpf_timer_set_callback];"
> +		:
> +		: [timer] "r" (value),
> +		  __imm_ptr(stats_async_outer),
> +		  __imm(bpf_timer_set_callback)
> +		: __clobber_common
> +	);
> +	return 0;
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(4)
> +/*
> + * self: 9 + 7 + 7 + 2 =3D 25
> + * totals: leaf 2, outer 7, scheduler 7, main root 25
> + */
> +__msg("subprog 0 (stats_async_nested) main insns_self 9 insns_total 25 s=
tack 0")
> +__msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_sel=
f 7 "
> +      "insns_total 7 stack 0")
> +__msg("subprog {{[0-9]+}} (stats_async_outer) static insns_self 7 "
> +      "insns_total 7 stack 0")

[Severity: Medium]
Will these assertions fail for the same reason?

Like stats_async_schedule(), both stats_async_outer() and=20
stats_async_nested_schedule() lack __naked and use __clobber_common, which=
=20
will likely cause compiler-emitted stack spills and exceed the expected=20
"stack 0" and "insns_self 7" values.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808062601.1070=
988-1-memxor@gmail.com?part=3D6
