Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDAE28373
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708684; cv=none; b=lqiAgUsyLdFAw4dtfE64QJR8LD+o8bVI7s5Ctqnbok3BBBKnz6PYMs39fZDOHoeo8CcFeQ48o78RRDob3EA/0HFVa9nGLc3zeVbVSHokSbUyFrLGCrjGJee2sSQ4hLF521Ve6v7IMUGHfyoYKD9XBxn96G0VwV1tr49NT6q5Dak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708684; c=relaxed/simple;
	bh=iAiEoxN91yxoY7uqhMEcicBIapi35JtgsB+POm65zro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGZo2xLlK8LlGgIvFu8Izy0M/r50kW6ITxu3vDKvTHFKyjShLRccK7uY0jfVtHyFcGJ6yaZR5mAEjGeLZM7Q/FMVUYwmZOdVRqQYM9Lzx6Mfl8RcOukPI0Ub/tiKCpLBEvIbB6+bIb+jEW1VMisLo4B9awFhUk2EXJgmRqYkkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPQ2r1NL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPQ2r1NL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34681F000E9;
	Fri, 10 Jul 2026 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783708683;
	bh=P1zUK3UkQWe4fZdxjPb570vR1bBDPsNKtVKMpV9RLj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPQ2r1NLBBJLmrW2HTQHwKAjn+BrLVETOdV4RaXfSOIDfzOFdLjxqKUoqmWUHiRKU
	 /nimd6bb9HV76cNXtRslEGsRQFQa0JlZyciXXpuYDr0Q0VyUD1JEjacek0hqr1zLhH
	 Q04Q8wdVwOYjsb+qmE5l9DFrWnr/9FHCPOVpsnd7h0WoQBj0PCQYf76W53niUBlLzk
	 A0YlICB1SSGwp9vd+QhhCHX9YNPEvMzCTpNdHq2gvZyFXvylr0HAGVGxkzCHcHpC6p
	 0Qaoykzl7V/K8A7uWH8tmTIX+qk9wfLoR+YzMPGc+nAtgfXqVvuCbOLpAwr+NMlG/Y
	 s3BhYrnMcAizQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Add tests for >8 byte return
 value and 128-bit arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710182219.1092246-1-yonghong.song@linux.dev>
References: <20260710182204.1085329-1-yonghong.song@linux.dev>
 <20260710182219.1092246-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 18:38:02 +0000
Message-Id: <20260710183802.D34681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `test_int128_args` selftest will predictably fai=
l on `aarch64` due to an unhandled ABI alignment requirement in the ARM64 B=
PF trampoline.
--

--- Patch [3]: [PATCH bpf v2 3/3] selftests/bpf: Add tests for >8 byte retu=
rn value and 128-bit arguments ---
commit c4e66c7551048f829ca6d77d8b1b2e6467e4525e
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add tests for >8 byte return value and 128-bit arguments

The BPF trampoline preserves only 8 bytes of the target's return value
(R0), so attaching an fexit/fmod_ret/fsession program to a function that
returns a >8 byte value is now rejected by the verifier. Add a bpf_testmod
function returning __int128 and an fexit program that targets it. The
program is expected to fail to load with the "with a >8 byte return value
is not supported for this attach type" message.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
> index 6f8c0bfb04155..d32198ee02dff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
[ ... ]
> @@ -112,6 +113,39 @@ static void test_struct_many_args(void)
>  	tracing_struct_many_args__destroy(skel);
>  }
> =20
> +static void test_int128_args(void)
> +{
> +	/*
> +	 * __int128 arguments are passed in a register pair on x86_64 and
> +	 * arm64, which the trampoline packs into two context slots. Other
> +	 * architectures pass a __int128 differently (e.g. s390x passes larger
> +	 * arguments by reference), so only exercise this on x86_64 and arm64.
> +	 */
> +#if defined(__x86_64__) || defined(__aarch64__)
> +	struct tracing_struct_int128 *skel;
> +	int err;
> +
> +	skel =3D tracing_struct_int128__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_struct_int128__open_and_load"))
> +		return;
> +
> +	err =3D tracing_struct_int128__attach(skel);
> +	if (!ASSERT_OK(err, "tracing_struct_int128__attach"))
> +		goto destroy_skel;
> +
> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
> +
> +	ASSERT_EQ(skel->bss->t_a, 1, "t:a");
> +	ASSERT_EQ(skel->bss->t_c, 3, "t:c");
        ^^^^

[Severity: Medium]
Will this test predictably fail on AArch64?

The test calls bpf_testmod_test_int128_arg(1, 2, 3). According to the AAPCS=
64
calling convention, a 16-byte aligned argument (__int128) must be passed in=
 an
even-odd register pair. Thus, the integer 'a' goes to w0, x1 is skipped for
alignment padding, the __int128 'b' goes to x2 and x3, and the long 'c' goes
to x4.

However, the pre-existing logic in the ARM64 BPF trampoline fails to account
for this padding. It solely calculates register usage based on argument siz=
es:

arch/arm64/net/bpf_jit_comp.c:calc_arg_aux() {
	...
	for (i =3D 0, nregs =3D 0; i < m->nr_args; i++) {
		slots =3D (m->arg_size[i] + 7) / 8;
		if (nregs + slots <=3D 8) /* passed through register ? */
			nregs +=3D slots;
	...
}

Because it incorrectly assumes the arguments use exactly 4 contiguous
registers (x0 through x3), it only saves those.

As a result, when the test's BPF program reads ctx[3] expecting 'c', it
actually reads x3 (the upper 64 bits of 'b', which is 0).

Would it be better to fix the ARM64 trampoline padding handling first, or
exclude AArch64 from this test for now to prevent CI failures?

> +	ASSERT_EQ(skel->bss->t_ret, 6, "t ret");
> +
> +destroy_skel:
> +	tracing_struct_int128__destroy(skel);
> +#else
> +	test__skip();
> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710182204.1085=
329-1-yonghong.song@linux.dev?part=3D3
