Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D353D75D3
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909992; cv=none; b=k8xi9Ts2Snb3Mq4K1IOpdxt9AJHmufxMASdV4Ugj2ix6fRVWnLm6KKiuy+LfpCa3NICS5JIeWLehmbnn+MtIUTY6LrOsX6R07pZjJG8da3fs0IN02sBCI0xTiLGH44zc90fhTV1wlWZV0chFA3HURapyDeaLkh4A6siETKG3gNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909992; c=relaxed/simple;
	bh=cHN3nT6iq+CinS3SuNKci06qmun6GBopGC/U1yKx3DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKkWamihrjgV+j1mL8U6SUVCJGDyTo1A3GYHeKEwYbHnf8f4v0XeOaU7zlVXg6H9ZFf3UmiE9d1n5Jt35hVMt5NBx2uVWCCDlFMdEntgQGEUE2Hzwdy/EoMckyK9v9y1MLo9SRpafZ+Tcna18rHjb7u42+WinDy9zl7VgwuwjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNajjD65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNajjD65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E671F000E9;
	Wed,  1 Jul 2026 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909991;
	bh=CNCxUtrncQrfpIOkGslvquH1t8s5EBpbepOmdg1DdR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNajjD65276sOY9DhKZbuNY9n87t0/5yZAjPJAex072UUOJ0qLq3VCUVsCxZ4NM2m
	 GeZ348kIW41N47AVUYKF7/8gClp8bzMKU5I1hCPDKQE+flwK1tA0EVedCNymaCaJZ2
	 1sGV4g2D820gUOQ29YiYDd40qlQJldVVGvJoAuvI3yPm5iXP3H2rUCazV6dsyOgGG+
	 2XxUV8GhWZnRjRFd3rN5150qeKgJErZgxsCdT14oqSu3KUvzSkjdc1OzM0npkZJ0Y9
	 nbR+0IHsqjjyf291S9uhdPjnbC/52aAlLPu19RAD+VC2ulmG4YimYEWws1L9eKP9oW
	 rd/JxXKcMw0rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] riscv: introduce percpu.h into include/asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701122948.57584-3-cuiyunhui@bytedance.com>
References: <20260701122948.57584-1-cuiyunhui@bytedance.com>
 <20260701122948.57584-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:46:30 +0000
Message-Id: <20260701124631.32E671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Inconsistent naming and semantics for 8/16-bit vs 32/64-bit 'andnot=
' percpu operations.
--

commit 8c96e5a266e5953bcbbc15476c253fbdd307508b
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: introduce percpu.h into include/asm

Add RISC-V specific this_cpu helpers so common percpu operations can use
short architecture sequences instead of the generic implementation.
Native-width operations use AMOs, while 8/16-bit operations use Zabha when
available and a local 32-bit LR/SC fallback otherwise.

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/per=
cpu.h
> new file mode 100644
> index 0000000000000..34483253e946f
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +#ifdef CONFIG_64BIT
> +#define PERCPU_OP(name, amo_insn)					\
> +	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
> +	__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
> +#else
> +#define PERCPU_OP(name, amo_insn)					\
> +	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)
> +#endif
> +
> +PERCPU_OP(add, add)
> +PERCPU_OP(andnot, and)

[Severity: Low]
This isn't a bug, but is the naming here intentional? This defines
__percpu_andnot_amo_case_32 and __percpu_andnot_amo_case_64, but since it
passes the 'and' instruction and operates on the value directly, it performs
a standard bitwise and rather than an and-not.

> +PERCPU_OP(or, or)

[ ... ]

> +#define PERCPU_OP_8_16(op_name, op, expr, final_op)			\
> +	PERCPU_8_16_OP(op_name, op, 8, .b, u8, expr, final_op);		\
> +	PERCPU_8_16_OP(op_name, op, 16, .h, u16, expr, final_op)
> +
> +PERCPU_OP_8_16(add, add, val, add)
> +PERCPU_OP_8_16(andnot, and, ~(val), and)

[Severity: Low]
Conversely, for 8-bit and 16-bit operations, the andnot operation actually
performs an and-not by passing ~(val).

> +PERCPU_OP_8_16(or, or, val, or)

[ ... ]

> +#define this_cpu_and_1(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_8=
, pcp, ~(val))
> +#define this_cpu_and_2(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_1=
6, pcp, ~(val))
> +#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_3=
2, pcp, val)
> +
> +#ifdef CONFIG_64BIT
> +#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_6=
4, pcp, val)
> +#endif

[Severity: Low]
Because of the semantic difference between the underlying helpers, the 1 an=
d 2
byte wrappers pass ~(val) while the 4 and 8 byte wrappers pass val.

Would it be clearer to harmonize the semantics across all sizes so the
wrappers do not have to compensate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122948.5758=
4-1-cuiyunhui@bytedance.com?part=3D2
