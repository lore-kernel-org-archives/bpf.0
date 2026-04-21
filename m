Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75E382F04
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806139; cv=none; b=mE3s2JKZqJ42s7GeS4vBi2echtaCDHj7P5wsCj2IGhY7sFJ30D6KKPZQG5sqpqNbIN+zCpCjbscnJOrftEQ4LyHnd7kon6K6uZ6FYK16lL5Ocbl6oo7h4C8GPy0LxuOfDkAvx5PQ8SBGfmHkvzcmFkplgDEA4nmPJz69Ek9TnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806139; c=relaxed/simple;
	bh=pgLYs7oV+rm6/kPIYvBZYHTVgHDu8DPNF+eid0btDuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TizZxy6HkNYmsDQY75qDdjzWPcNZogIQ5kMc7KmbXolncYBGvV5YuIh4FBdJde3kgIN8VGznIt3Y4389J0DyhpoHk0fJ8UIDrFjt4dwhD6GG6kJz64Inrmg8tUQkGd/nPvpJ+t3AviV1TuC0KVJ9NMBQWUE7NPBrvvDnTfI8mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip2KeeiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip2KeeiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCA0C2BCB0;
	Tue, 21 Apr 2026 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776806138;
	bh=pgLYs7oV+rm6/kPIYvBZYHTVgHDu8DPNF+eid0btDuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ip2KeeiAIGp86Ep6Ln1UWcW4O/daa92Nh5IzquTtiY6JGl9PKza4LWKZsNlLS7Rjz
	 kIS0iqLMdfCPtqstNPjYuWPkB+HmG4yJM1r2k3so+YieRjf1ubdvMY/nNOqLuKpC+N
	 sRmAx5PEMDrwk5s+hCetSNHaurULqYDlb4NnJojDEIxG3YqPM0UUwjW0PChWYNSePw
	 tGtmQw9fbioUTQEUbo28SaaKGuF3ZHEF/xXzJCd36imWvPp4szOUbm8sj+XCwht24F
	 TTBnVZ+MHU1vitHIcPy0yzlzpY3x1hHOJ2A6mEoXNXK7oDHlE3lGCypvuffpJKZgUl
	 smn8OoIADMkng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 5/8] selftests/bpf: Add ASAN support for
 libarena selftests
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-6-emil@etsalapatis.com>
References: <20260421165037.4736-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 21:15:37 +0000
Message-Id: <20260421211538.7BCA0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The debug function `print_asan_map_state()` unsafely dereference=
s a potentially poisoned pointer, triggering a secondary ASAN violation.
- [Medium] The global variable `asan_violated` is not reset on error paths,=
 breaking test isolation and causing cascading failures.
--

commit 0afb16788ca62f1167765c685d131935c9f37240
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add ASAN support for libarena selftests

This commit expands the libarena selftest infrastructure to support address
sanitization, adding the necessary compiler flags to compile the library
under ASAN.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_commo=
n.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> new file mode 100644
> index 0000000000000..58b1b0ae6a778
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h

[ ... ]

> +static inline void print_asan_map_state(void __arena *addr)
> +{
> +	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
> +			__func__, __LINE__, addr,
> +			*(s8a *)(addr), ASAN_GRANULE(addr),
> +			asan_shadow_set(addr) ? "yes" : "no");
> +}

Does reading *(s8a *)(addr) risk triggering a secondary ASAN violation?

If addr points to unmapped memory outside the arena, the dereference could
trigger a BPF exception and terminate the test before the debug output is
printed. The __noasan attribute might be needed here to avoid interception
by ASAN instrumentation.

> +/*
> + * Emit an error and force the current function to exit if the ASAN
> + * violation state is unexpected. Reset the violation state after.
> + */
> +static inline int asan_validate_addr(bool cond, void __arena *addr)
> +{
> +	if ((asan_violated !=3D 0) =3D=3D cond) {
> +		asan_violated =3D 0;
> +		return 0;
> +	}
> +
> +	arena_stdout("%s:%d ASAN asan_violated %lx", __func__, __LINE__,
> +			(u64)asan_violated);
> +	print_asan_map_state(addr);
> +	return -EINVAL;
> +}

Should asan_violated be reset to 0 before returning -EINVAL here?

BPF global variables persist across executions on the same skeleton. If left
non-zero, subsequent tests might fail their ASAN validation checks.

> +
> +static inline int asan_validate(void)
> +{
> +	if (!asan_violated)
> +		return 0;
> +
> +	arena_stdout("%s:%d Found ASAN violation at %lx", __func__, __LINE__,
> +			asan_violated);
> +
> +	return -EINVAL;
> +}

Similarly, does asan_violated need to be reset to 0 here to prevent cascadi=
ng
failures in subsequent tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D5
