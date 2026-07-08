Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD63ACA41
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542512; cv=none; b=TltvRw23CtwAixrlWvmqrg1MKt2kHMqTTWNwVGnjPXTf+wMXYtC9b8J4KJ5JgczBsR52KIMcFmyzLj/zt1j0f/2LcSrLuJE9H19Lypv29fSkrlfjUJH2SQFv5uiTtcNr88JKEYPjSHcZcEsgZxX5gei1YU/5w1Dd/5fiVm5yqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542512; c=relaxed/simple;
	bh=mjokCchFw8ljRB86sL9OAu5+ikzod9jcenoDCJskDW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Eibyo3THAoTcfZolkaGcpzvyWZldffS/yNigHzv/vd1HuGHE3/vxRn9GBTMA9nItHshi8SQEKIrKELf0Z6XU7i4KF/67JqsROqb+3kTNkCDhkoy5diKC8bkV9snhsxBfN/bWvjG+tU0huuW5KlyCRHRG5kLDNxuV8B7Dl1l9v9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMaqUErH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMaqUErH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDE1F000E9;
	Wed,  8 Jul 2026 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783542510;
	bh=7HuErWhxcW7znwXnCKpoDCSeRGzhd2ResnJT3ttmook=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMaqUErHB8uZS1noZOAUmSuAXs+jC4wYP3pAT8zzIch7J+ij+xkCm9kcjleRFFy06
	 VSYpn9r6MIpf4qFeDxbUcxY0ykXF+mREDHyxI4IqHTPptx6uusTKjyTy/i7ma9NR51
	 ZEY+2v6bS+IMSn21o/s0KMZLcPpFwzOvqQKi4F+XzKUe8e3UY8MMBTjQTfis0dvfUx
	 JYRfcOXU3iMIu8wfHB06hDvdDWdXBAYWcjMdaUUgVKzyyPZFgKcDJ3sYDGywpTutrG
	 hEW++/X2gg5pfrCY2Yh+vWb8NV+RS5SlCzNDEVLJFU9Iom3pnlUamiPaGlChZPbQY+
	 l3L52LRj1TIVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708201030.2161016-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201030.2161016-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:28:29 +0000
Message-Id: <20260708202830.4BBDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded little-endian assumptions in struct and `__int128` reg=
ister unpacking will cause selftest failures on big-endian architectures li=
ke s390x.
--

--- Patch [10]: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and su=
bprog tests for R0:R2 returns ---
commit dcf423ead16608630f40807ad0cde33d495c941d
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns

Add inline-asm and subprogram tests for more coverage, including
BPF-to-BPF cases, kfunc cases, backtracking and liveness. Both positive
and negative tests are added.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c
> new file mode 100644
> index 0000000000000..d6300b31733d8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c

[ ... ]

> @@ -0,0 +1,160 @@

[ ... ]

> +SEC("tc")
> +int aggregate_ret_asm_test(struct __sk_buff *skb)
> +{
> +	__u64 a =3D skb->len;
> +	__u64 b =3D skb->len ^ 0xdeadbeefULL;
> +	__u64 lo, hi;

[ ... ]

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
> +	if (hi !=3D a)
> +		return 3;
> +	if (lo !=3D b)
> +		return 4;

[Severity: Medium]
The test expects the high 64 bits (a) in r2 and the low 64 bits (b) in
r0. On a big-endian ABI, the most significant 64 bits (a) will be returned
in the first register (r0).

Will this cause the test to fail on big-endian architectures like s390x?

> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +int aggregate_ret_struct_test(struct __sk_buff *skb)
> +{
> +	__u64 a =3D skb->len;
> +	__u64 b =3D skb->len ^ 0xdeadbeefULL;
> +	__u64 lo, hi;

[ ... ]

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
> +	if ((int)hi !=3D (int)b)
> +		return 4;

[Severity: Medium]
The bitwise extraction (int)hi assumes the 4-byte b is in the lower 32
bits of r2. On big-endian, wouldn't b be placed in the upper 32 bits of
the register, causing this assertion to fail?

> +
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

[Severity: Medium]
The bitwise extraction (int)lo and (lo >> 32) assumes a little-endian
register layout for the returned 8-byte struct. On big-endian, wouldn't a
be in the upper 32 bits and b in the lower 32 bits?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708200939.2153=
664-1-yonghong.song@linux.dev?part=3D10
