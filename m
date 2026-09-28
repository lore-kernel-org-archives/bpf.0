Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC211547042
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562671; cv=none; b=GPYRwcvMSu2DjXGNRv0H22dOa7MEpgb+ZWu+3bh6mK1YGFckIBUF/d3I4bVAKv4UiRIU8+LqMe+QCSzFRYQPAEA6GQmBChWPipXZK5y/XzUiTpf+UGP9BwKJYv1upJ00qlQIm2Onuk3hcyNk3SlhbltWG1zdwbdCLL+X7kN5Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562671; c=relaxed/simple;
	bh=xMBrgwZ8XfaBdx+x2Nhe/6MDtWFFoDxUWCqOzhR3AXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FjhvcghTAqn48ggs9mfkqE4HSYv9BjXKybs3oEUrO02WOFtTr0Z40sbPyskpZAyX3CcV9QkML4InkemLdK++ZK5Y6aXR+YZALO/eKi2xKwM0X8+dA6IH05OgwLy9oYCG9UG4wsgx/gg+O6DpBGFPS6C0ILUayEfmnfW4StBqv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPxxBjdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPxxBjdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B21F000FF;
	Mon, 28 Sep 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790562669;
	bh=ZIn4ssKudH70BFWwq9d8UDnW3c+Qxz1fmXpvWfY4eRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPxxBjdw8yS/RUq+5z+kKwi9TeLa5BBDdq1H+KoWRu+O/n1NNfywj8nrMYDNT51p/
	 erAx/a1jAYg+iuDIRcjrty98nMVKm4tKfXFNa15xdWUMEHeAQdPblGu5tJJVg2+AYn
	 2sp52yt7+ai7R2KlupG/OjwuKdhhHfYdG8GWQL//by9z84SfTuZOAbVIh7LEgfwrvJ
	 RDl+Uz78zW2t398SRCVEP51dkpZTGTjZGQxzR9xW+R49kekMeu2r8dWTMwsl8v02p1
	 mRh1eH3voUdqze4V63kv/wafCrt04rzdDgK6ctGX8k2Q7W3SDisvGDYgrh5Pyv1a3m
	 q0lwfKyI26WXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Enable gotox tests for
 riscv64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928022109.1093-3-cp0613@linux.alibaba.com>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com>
 <20260928022109.1093-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 02:31:08 +0000
Message-Id: <20260928023109.5C1B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: missing architecture guards for riscv64 gotox tests
--

commit 1d33b2e23d145afdb7fdcec7bed2452e5b940956
Author: Chen Pei <cp0613@linux.alibaba.com>

selftests/bpf: Enable gotox tests for riscv64

This commit adds riscv64 to the architecture whitelist in verifier_gotox.c
because the JIT now supports the gotox instruction and jump tables.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/t=
esting/selftests/bpf/progs/verifier_gotox.c
> index f5a9878c7b8d4..96a9d914930ee 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -6,7 +6,9 @@
>  #include "bpf_misc.h"
>  #include "../../../include/linux/filter.h"
> =20
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || define=
d(__TARGET_ARCH_powerpc)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
> +	defined(__TARGET_ARCH_powerpc) || \
> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64)

[Severity: Low]
Are there other files that need their architecture guards updated for riscv=
64
gotox tests to prevent a regression in test coverage?

For example, tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c has:

#if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
static int map_create(__u32 map_type, __u32 max_entries)
{
    ...

This skips the bpf_insn_array test suite on riscv64, which heavily exercises
the gotox jump table logic.

Similarly, tools/testing/selftests/bpf/progs/compute_live_registers.c has:

#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)

SEC("socket")
__log_level(2)
__msg("2: .1........ (07) r1 +=3D 8")
__msg("3: .1........ (79) r2 =3D *(u64 *)(r1 +0)")
__msg("4: ..2....... (b7) r3 =3D 1")
__msg("5: ..23...... (b7) r4 =3D 2")
__msg("6: ..234..... (0d) gotox r2")
...

This prevents the gotox liveness tracking tests from being compiled and run
on riscv64.

Should these architecture guards also be updated to ensure comprehensive te=
st
coverage for the newly introduced JIT feature on riscv64?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928022109.1093=
-1-cp0613@linux.alibaba.com?part=3D2
