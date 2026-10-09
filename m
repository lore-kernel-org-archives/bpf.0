Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BD2931F5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528682; cv=none; b=PmGmZfq/1fqtRD1NPbQfPJmvfcgRQnoH0zXWx26g2b4x7MFg5rqNpmxBv/+QtBkQvUObijg8JUptzSwQHHu+XPFmnWqN2QQNpYVykOtMYXLOox7tcQNLDCrZBWlquPHjugMp3OTafzx6AZ/YrohlSYC7uI2N2D71VvPxVuBo3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528682; c=relaxed/simple;
	bh=lV4Fw7L5M8ocYO2yN8RmL56rCraFK161h/Ur+mfwHac=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KVeOFq0ZoyRJK60xkcpr0e3CnNn5Yr4xz2JyL+1tTV4nAJwOlBqjQbFEitXaSmeE9H7Z0ONcpWadZAi1l2a/vZDTfGC+634zRTHUZkAaIP3rE8utKlQHu7X+q52f+avNOPNGuTYhSmsDVaWlnymNN55+6xutpLaPSu9dQTLi7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDik/kTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDik/kTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD41F000FF;
	Fri,  9 Oct 2026 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791528677;
	bh=y5mwJb9qeDjHhJTz4J3fJmyIojt1HMnwHDHYQggw0Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDik/kTe1+CJavFdG1IZZql19QyQSFPCJXhdIjJBCaaHbCiK8FHkD507IHRpxf1il
	 GaDWfpxYzS+BVK0LF/Cn5035lYgkKCVYKSOf6pEjWihXTd+kejFhGv+Xfh3cRychW4
	 BV05JuK1oUmhvIVTE8J4egZreN2bN7xl/3lCnBhqMffT+6LSBI0u4XBSVgUkva0rnY
	 1O4W1K2tzymQQEkFJoauoLqEZhfVkrPj4QHvDsW+CJ9ZqfsoAle/4r/eo4rIzpUUsy
	 68GQfnLcpVEl6A+bkFq/wj8ZWLMKrywPiAr1jnmnouq5z9M1excbPP3DFyBgjv3D4/
	 bxMTxeoEBP1DA==
Message-ID: <sashiko-outbox-164968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Test trampoline args around
 a 16-byte aligned stack arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009064228.1240628-1-yonghong.song@linux.dev>
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
 <20261009064228.1240628-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:51:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: endianness mismatch when reading __int128 in selftests on b=
ig-endian
- [Medium] selftests/bpf: data race on bpf_testmod_test_struct_arg_result
--

commit 44831c6b1a0172e1d0713d17a8e105c4b30d6d64
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Test trampoline args around a 16-byte aligned stack arg

This commit introduces two new bpf_testmod functions to test trampoline
argument handling for 16-byte aligned stack arguments, specifically targeti=
ng
__int128 structures. It also adds fentry and fexit programs to verify that
arguments are correctly packed in the context array according to BPF
conventions on x86-64 and arm64.

> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c b/=
tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> index 4638dfec1f38e..5520ee500c01d 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
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
[Severity: Medium]
Will this little-endian assumption cause the selftest to fail on big-endian
systems? On big-endian arm64 (aarch64_be), the high 64 bits of the 16-byte
struct would be at the lower memory address, so reading ctx[7] as the low
64 bits and ctx[8] as the high 64 bits might be reversed.

> +	s_i =3D ctx[9];
> +	return 0;
> +}
> +

[ ... ]

> +long b_f_a, b_f_b, b_g, b_h, b_i_lo, b_i_hi, b_ret;
> +
> +SEC("fentry/bpf_testmod_test_int128_backfill")
> +int test_int128_backfill_fentry(unsigned long long *ctx)
> +{
> +	b_f_a =3D ctx[5];
> +	b_f_b =3D ctx[6];
> +	b_g =3D ctx[7];
> +	b_h =3D ctx[8];
> +	b_i_lo =3D ctx[9];
> +	b_i_hi =3D ctx[10];
[Severity: Medium]
Does this have the same endianness mismatch on big-endian architectures?
Extracting the 16-byte struct here from ctx[9] and ctx[10] also seems to
assume a little-endian memory layout.

> +	return 0;
> +}

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 54a5fc39e0e27..23a2c88d3e7c1 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> +noinline long
> +bpf_testmod_test_int128_stack(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
> +			      u64 g, struct bpf_testmod_struct_int128 h, u64 i)
> +{
> +	bpf_testmod_test_struct_arg_result =3D a + b * 2 + c * 3 + d * 4 + e * =
5 +
> +		f * 6 + g * 7 + (u64)h.a * 8 +
> +		(u64)((unsigned __int128)h.a >> 64) * 9 + i * 10;
> +	return bpf_testmod_test_struct_arg_result;
> +}
[Severity: Medium]
Can concurrent execution of tests (like test_progs -j) lead to a data race =
on
this global variable? If one test thread computes the result in
bpf_testmod_test_int128_stack() and another thread overwrites
bpf_testmod_test_struct_arg_result in a different function before the first
returns, it could cause the BPF fexit hook to read an incorrect return value
into s_ret, leading to flaky ASSERT_EQ failures.

> +
> +/*
> + * x86-64 has no register left for f after e, so f goes to the stack and=
 g
> + * takes R9 back; h goes to the third stack slot and i, aligned to 16
> + * bytes, to the fifth and sixth. arm64 has registers up to g, puts h in
> + * the first stack slot and i in the third and fourth.
> + */
> +noinline long
> +bpf_testmod_test_int128_backfill(u64 a, u64 b, u64 c, u64 d, u64 e,
> +				 struct bpf_testmod_struct_arg_2 f, u64 g, u64 h,
> +				 struct bpf_testmod_struct_int128 i)
> +{
> +	bpf_testmod_test_struct_arg_result =3D a + b * 2 + c * 3 + d * 4 + e * =
5 +
> +		f.a * 6 + f.b * 7 + g * 8 + h * 9 + (u64)i.a * 10 +
> +		(u64)((unsigned __int128)i.a >> 64) * 11;
> +	return bpf_testmod_test_struct_arg_result;
[Severity: Medium]
Since this function also writes to the unprotected global variable
bpf_testmod_test_struct_arg_result and immediately returns it, could this
contribute to the same data race when multiple test processes run
trigger_module_test_read() concurrently?

> +}
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009064206.1238=
047-1-yonghong.song@linux.dev?part=3D4
