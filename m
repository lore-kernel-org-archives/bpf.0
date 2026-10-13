Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F938C2A7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852226; cv=none; b=oG5fZ0setiqyKH3Rp/Zu7tNGgGUVe1LQzPppS/KFOJyiG8C01GSnQIsj6UuUt64kTGNKF+cOz+Knf92SscEjjQNanr96hTkDd78DHHjXVlnkUMqmYMzUcFE2tlTxlRn3gS8KpmIo1INwQl+HDxSYAOAuyiGUy27PhcM5fLpRWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852226; c=relaxed/simple;
	bh=wRMTFkDO005rbwD+ka9Rl4nsgKZaPQPelwk2rD67wOs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SvXwFuFhitCLGoyuQ04izuBBiwtEwbnfmrj/ug80ETZP2dnDyFDHf3qkv+6V8Lok8jmOQgc9SUXbxCMdttCzt2BYcnRUvOa543q14gD+mZLCP6SgUyQhDpFHqbHkSHKfYlus5vclNCvLHFybzwNIxBLl/5PjtEw9M+jGbf4UzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAQrpwyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAQrpwyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFFB1F0089B;
	Tue, 13 Oct 2026 00:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791852225;
	bh=mY7hr+jXHqJkYMOAhinzAq4O6KyQShobFWI/EnYwDR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAQrpwyUrkRr1dhbZclfSrIoHm2Gkb2MF7FBGzl7EMxdUabr/oVJR4aMWIN853lqh
	 /K+h9KWO+cKMjdPshS7a0cB8IRwyIF7Azmi6VW9yM9Jh8SqPWFIcn2xiBq0mBaUSR6
	 Q4BePoWNARM4COqJQFZdAmIB23AMkNUpKSRiVjiR3Ilq8dT0AS5dX2Ogfqp0ZXH0sR
	 MYxfkt1DMUw3630wm3PMvdCbn+KM92wIvHYzpdtGnkE6cTC3nYm2gXNGtZxxzRIpAS
	 zfUMmFaFJr7AvkFPNjbg3GLBn64tYrNf+Fu9wCnriT4gL/ID29ao6ZRd53mvC9G9Nw
	 zL2v3xdLLSfyg==
Message-ID: <sashiko-outbox-168812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/11] selftests/bpf: Test trampoline args
 around a 16-byte aligned stack arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013003459.1857895-1-yonghong.song@linux.dev>
References: <20261013003429.1853052-1-yonghong.song@linux.dev>
 <20261013003459.1857895-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:43:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: endianness assumption causes selftest failure on aarch64 big-e=
ndian
--

commit df1efd6b9c0e934bad453d07e6efe674bda8e1e6
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Test trampoline args around a 16-byte aligned stack arg

This commit adds tests for bpf_testmod functions taking a 16-byte aligned
struct containing an __int128. It checks that the BPF trampoline packs
these arguments correctly according to the BPF calling convention.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
> index 8086586d3e196..a2da219e14769 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
[ ... ]
> @@ -141,6 +143,20 @@ static void test_int128_args(void)
>  	ASSERT_EQ(skel->bss->t_c, 3, "t:c");
>  	ASSERT_EQ(skel->bss->t_ret, 6, "t ret");
> =20
> +	ASSERT_EQ(skel->bss->s_g, 7, "s:g");
> +	ASSERT_EQ(skel->bss->s_h_lo, 8, "s:h.lo");
> +	ASSERT_EQ(skel->bss->s_h_hi, 9, "s:h.hi");

[Severity: Low]
Does this code assume a little-endian memory layout for the __int128
argument?

The test passes a 16-byte struct containing ((__int128)9 << 64) | 8.
On big-endian architectures like aarch64 (when configured with
CONFIG_CPU_BIG_ENDIAN), the most significant 64 bits (9) are placed at the
lowest address, and the least significant bits (8) at the higher address.
This hardcoded expectation for the little-endian layout appears to cause the
test_int128_args selftest to fail its assertions on big-endian systems.

> +	ASSERT_EQ(skel->bss->s_i, 10, "s:i");
> +	ASSERT_EQ(skel->bss->s_ret, 385, "s ret");
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c b/=
tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> index 4638dfec1f38e..5520ee500c01d 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
[ ... ]
> @@ -15,4 +15,49 @@ int test_int128_arg_fexit(unsigned long long *ctx)
>  	return 0;
>  }
> =20
> +/*
> + * The arguments come packed in the BPF convention whatever holes the
> + * kernel convention left between them: an eightbyte each, and two for t=
he
> + * struct holding an __int128.
> + */
> +long s_g, s_h_lo, s_h_hi, s_i, s_ret;
> +
> +SEC("fentry/bpf_testmod_test_int128_stack")
> +int test_int128_stack_fentry(unsigned long long *ctx)
> +{
> +	s_g =3D ctx[6];
> +	s_h_lo =3D ctx[7];
> +	s_h_hi =3D ctx[8];

[Severity: Low]
Is this direct array indexing in test_int128_stack_fentry() subject to the
same endianness assumption?

When the BPF trampoline projects the struct onto the u64 ctx[] array on a
big-endian system, ctx[7] receives 9 and ctx[8] receives 8, rather than the
little-endian projection expected here.

> +	s_i =3D ctx[9];
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013003429.1853=
052-1-yonghong.song@linux.dev?part=3D6
