Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146403;
	b=Fku4fQgauM9uFK4PmKl415fRbGXicT/vfjBJf02QiKDc10sghB6ftQ8NM7NcF7lnVnVX
	 18HNnzWEfTEEpv9np39rt+FmiIL9CK4cijeh7gIUXiHJTXCWkw3ejUJdpAHPva2BkEZS8
	 V7oygrMpXKru+0EQP/wPiDn6v1GX9LjDGTq1yb4F6J96Kw1GMRV5ylY/fNHLhIfPcuJZB
	 hfLnwcs/xmoT9uCuHuvlbi4pHOhtOOOmUAheYJlmIrfgN2t3VrrtnBAiDsnjiMW34vx3u
	 u2qQb1p8wFVMulcTqVB2MnGNU98S1R+dZ3NZ8v8QQJsvlA+aWeC2nRd/mKW0OOYr37A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9W2x8SvSAMS892x/ZligPLzUAW6gRF9w8HbBlWDqEjU=;
	b=ayTjcSYYZZqoRRiuEo/kgpSbsZNc0jKmQSRzLa4X0zqJJY20cNbr7Pb5qAN7NOQLfNI5
	 ks9DqJbwJTn3VzIDbK9CNooCURt0eCGuYu3HHVm0iH6o5DtJjzxjH+d0wfTGKUcnK52lv
	 HuLkyIaYlVSns3CaRSYgrQsmxlGU2+lMu4zE1D6q2+3t1NxJPniSWporGI33QfAFb/bVV
	 osI6+i/ZXiDnaH4sEZwj0I4Cs1SrkLRK+hgrrmYmX48RchKHAhD9UvmsqQghUGTz27FlZ
	 mc4CHr/zl7HxgqRWmpRTDTuOxt1wqV3jokL2T7kUv14/OFTy/EGY4Pq8Aca7WHOk43A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Juqf/BWO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AC606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Juqf/BWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437581F01825;
	Wed, 28 Oct 2026 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146402;
	bh=9W2x8SvSAMS892x/ZligPLzUAW6gRF9w8HbBlWDqEjU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Juqf/BWOx1+edykgOGBtHZIMflH55MDiscbK6EZ8nLsSNHGhbTn9a9JDvk1Pf93Ht
	 YtUk6uktjSEm7Yr827MgrP3Qqs1C49YotTVl5syaCee94ufBUrg0nRsEto8/OiZCpa
	 W4KUobdyk7luA6CicX2dFZc1lCM9aO+oXDfnyDrj2zmLip1aZYAatHoQqYNe+iy0ZK
	 euNznwRd4rmaXoHIqsKClfEzJuBZl/EUJKm+9JyM8YZj4uYUta3ESmqDp3y/GjGBfX
	 M+beTKUtNNvNyqz6YqQzn6kKzbXUYu9aF6a7YWI+v8lDP/+sbRaBNpftvDdcOyek6R
	 7fcvwcRyw6wCw==
Message-ID: <sashiko-outbox-187262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/7] selftests/bpf: report SKIP for arena
 tests a compiler cannot build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261028000411.4010967-4-vineet.gupta@linux.dev>
References: <20261028000411.4010967-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:13:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing __skip_without_arena fallback in jit_insn=
s_arena.c
--

commit f37e4c1aa3e5f2decfc920dfa156617c4a66522b
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: report SKIP for arena tests a compiler cannot build

This commit adds a __skip_without_arena macro and #else fallback programs
to BPF selftest files guarded by __BPF_FEATURE_ADDR_SPACE_CAST so that
test_progs reports those subtests as skipped when built with a compiler
that lacks arena address space support.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 1b264480e128f..ed1ed1b5bd097 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -156,6 +160,16 @@
>  #define __success		__test_tag("test_expect_success")
>  #define __description(desc)	__test_tag("test_description=3D" desc)
>  #define __skip(reason)		__test_tag("test_skip=3D" reason)
> +
> +/*
> + * Without compiler arena support, report the test as SKIP rather than l=
et it
> + * pass vacuously or fail to load.
> + */
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +#define __skip_without_arena
> +#else
> +#define __skip_without_arena	__skip("compiler does not support the arena=
 address space")
> +#endif

[Severity: Medium]
Should tools/testing/selftests/bpf/progs/jit_insns_arena.c also receive an
#else fallback with a dummy arena_unsupported() program marked
__skip_without_arena?

In tools/testing/selftests/bpf/progs/jit_insns_arena.c, both BPF programs
in the file (arena_zero_off() and cast_to_user()) are inside a
__BPF_FEATURE_ADDR_SPACE_CAST guard without an #else branch:

tools/testing/selftests/bpf/progs/jit_insns_arena.c:
    #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
    SEC("syscall")
    __success __retval(0)
    int arena_zero_off(void *ctx)
    {
        ...
    }

    SEC("syscall")
    __success __retval(0)
    int cast_to_user(void *ctx)
    {
        ...
    }
    #endif

    char _license[] SEC("license") =3D "GPL";

When built with a compiler that does not define
__BPF_FEATURE_ADDR_SPACE_CAST, such as stock bpf-gcc, jit_insns_arena.c
compiles to an object with zero BPF programs. When test_jit_insns() in
tools/testing/selftests/bpf/prog_tests/jit_insns.c runs:

    test_jit_insns() -> RUN_TESTS(jit_insns_arena) -> test_loader__run_subt=
ests()

it silently executes zero subtests for jit_insns_arena instead of reporting
a skipped subtest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028000411.4010=
967-1-vineet.gupta@linux.dev?part=3D3
