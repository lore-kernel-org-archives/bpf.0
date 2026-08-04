Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1302375F96
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876765; cv=none; b=EwSJYCqsxz8Y3GgZWIGrGRkoEKfPYgPf9/DGBabK1Bv2xMmcQZ+rORB14Di2sfvO7pi1WomVXY1UOur5PxYLO72HACV/fcjlEKbFPK268HCzj8+jRjtFfDDIZHmvduBy63/epdsr0LpT1wX0vsMqLxM2MMEI1QKV94/Q5QUAwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876765; c=relaxed/simple;
	bh=Xf0Y6bKfXK0AcsDX0M1jfFgZiDfjAD4LqDrOH9wFsMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPxioMcO4IwegLyutW2i1vbbO6oyL6cPWInt2EsipV8kAOx2PQdakVsElFz3Dx2dlPbrToqhqbLyjA6EtI/b+zGX78i/fHB84voXdrlnAp7EReiea/mQzR9Yd3GeX2sUGmtFFYoO0vOwZCTasm2K2UuyjxoF7vpm/L3LioTJFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft4wtysB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft4wtysB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E71F000E9;
	Tue,  4 Aug 2026 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785876763;
	bh=bNFnJtXGSz0xCkR6jXfvoAcY1tj0YLrChhOO2ddJcKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ft4wtysBDl1wRnNZosn4w/iz7KAwHIze4h6bD3YcSmyQZ04ZDY3v8ciivQ3D+Ryoc
	 pbSHvsjUVkZO63DzuwPIyk6mvxXZWdsPeKYI/7flexXEI469z5I334BKENC7lViMBT
	 tNcvhXzJBq4xsqDF626QwMlEEvRbjno698aA6IerEnilJNCim+9wR3zYDrmB5XIoVw
	 JE5JjoOmLKRhugElwrWnngiLWc84Vm0Qg3s38wEwvGmmEYlolbwQoF7jt9hcMudfBZ
	 2np0Yy6m4f3gSvT+N980qMtFxbDBv/beeJaH58bt3W/SvFOpuOG5ekjdwQ9FhkrUOS
	 q7wA7dgckfeDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804203618.1878749-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203618.1878749-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:52:42 +0000
Message-Id: <20260804205243.5F7E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The inline assembly tests verifying kfunc struct returns and __i=
nt128 values incorrectly assume little-endian register packing, which will =
cause deterministic test failures on big-endian architectures.
--

--- Patch [11]: [PATCH bpf-next v2 11/13] selftests/bpf: Add inline-asm and=
 subprog tests for R0:R2 returns ---
commit 43d5815a2f48399212b5d17d74ef9350c219fc0e
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns

Add inline-asm tests, which do not depend on the compiler lowering a
register-pair return and so run regardless of the LLVM version, covering
what the C tests cannot reach.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c
> new file mode 100644
> index 0000000000000..fac813531b4fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c

[ ... ]

> +SEC("tc")
> +int aggregate_ret_asm_kfunc_test(struct __sk_buff *skb)
> +{
> +	__u64 a =3D skb->len;
> +	__u64 b =3D skb->len ^ 0xdeadbeefULL;
> +	__u64 lo, hi;
> +
> +	asm volatile (
> +	"r1 =3D %[a];"
> +	"r2 =3D %[b];"
> +	"call %[kfunc];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_i128)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"
> +	);
> +	if (hi !=3D a + b)
> +		return 1;
> +	if (lo !=3D a - b)
> +		return 2;

[Severity: Medium]
Does this assume little-endian register packing for the __int128 return val=
ue?

On big-endian architectures, the high bits typically occupy the first regis=
ter
(R0) and the low bits occupy R2, which would cause this check to fail when
testing kfunc __int128 returns.

[ ... ]

> +SEC("tc")
> +int aggregate_ret_struct_test(struct __sk_buff *skb)
> +{
> +	__u64 a =3D skb->len;
> +	__u64 b =3D skb->len ^ 0xdeadbeefULL;
> +	__u64 lo, hi;
> +
> +	/* struct { u64 hi; u64 lo; }: R0 =3D hi, R2 =3D lo. */
> +	asm volatile (
> +	"r1 =3D %[a];"
> +	"r2 =3D %[b];"
> +	"call %[kfunc];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_pair)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"
> +	);
> +	if (lo !=3D a + b)
> +		return 1;
> +	if (hi !=3D a - b)
> +		return 2;
> +
> +	/* struct { u64 a; int b; }: R0 =3D a, low 32 bits of R2 =3D b. */
> +	asm volatile (
> +	"r1 =3D %[a];"
> +	"r2 =3D %[b];"
> +	"call %[kfunc];"
> +	"%[lo] =3D r0;"
> +	"%[hi] =3D r2;"
> +	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_li)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"
> +	);
> +	if (lo !=3D a)
> +		return 3;
> +	if ((int)hi !=3D ~(int)b)
> +		return 4;

[Severity: Medium]
Will this check fail deterministically on big-endian systems?

The test expects the 32-bit integer b to be in the lower 32 bits of R2. On
big-endian platforms, b would occupy the upper 32 bits of R2, leaving the
lower 32 bits as padding.

> +	/* struct { int a; int b; }: 8 bytes, packed into R0; R2 is not used. */
> +	asm volatile (
> +	"r1 =3D %[a];"
> +	"r2 =3D %[b];"
> +	"call %[kfunc];"
> +	"%[lo] =3D r0;"
> +	: [lo]"=3Dr"(lo)
> +	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_ii)
> +	: "r0", "r1", "r2", "r3", "r4", "r5"
> +	);
> +	if ((int)lo !=3D (int)a)
> +		return 5;
> +	if ((int)(lo >> 32) !=3D (int)b)
> +		return 6;
> +
> +	return 0;
> +}

[Severity: Medium]
Could the layout of this 8-byte struct in R0 differ depending on endianness?

The hardcoded cast to (int)lo reads the lower 32 bits of R0. On big-endian
architectures, the first member of the struct (a) is located in the upper 32
bits, so reading the lower 32 bits will yield b instead, causing a spurious
test failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203522.1869=
244-1-yonghong.song@linux.dev?part=3D11
