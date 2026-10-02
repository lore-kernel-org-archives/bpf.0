Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924B496D52
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946495; cv=none; b=o22Uro6/YzeAqQ2K5Nk7Z7p9Xa7QuNOydi1ma87SxLsEy8pBT9iO89rGlKFW3DnHNXt/u9crssVqOvRJavAmjpQ6x25oGf6qpsSkjsLhjwRmdVZ03f7EKEA5JR1xq3DF5SBfJoMA2t570TZrTLpdN6xCWdth9tOUjom6XjzCMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946495; c=relaxed/simple;
	bh=tECpT6ibgUp1H7DLwczvTeWtYfLYa+5BKIrL3zcA3AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4FZxMMApCnP2zpjydw3cws4RlRNTZXHiIyrbaeggrwusJYGxo82sbCgDe4ZXES2IF4PNUK2qQGW6Pi2TxD1MdhtHoq7BMdkkoq65JtGIKOgY8myffsT7xCk4Y5Xm+IBEqJIK7MK1I46i2rLhHoBzeLI9yADI3UK88FLush24eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVLF4VVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVLF4VVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FFA1F000FF;
	Fri,  2 Oct 2026 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790946483;
	bh=n1s0Kxw9sJBYADcbAMuDUDlgbL8AYpX37hnlALKyGd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVLF4VVsS/m5wf5Bdbnb852ZOrgbbRdbbCyLOp34xNM9EYHnthZ4Up1M/2cUXfdh4
	 ZuYxGRPzmF0P4Y52w0DpHmdtk1+FDgj9DyfupQL3/8E4MmTFGdRwgCFbhizuc4hIoY
	 Jzm4ddOzQqyHFTzk473GIC8zE+z0PIoUmqsztJznjbtiECGfIlw6Gjhqcprgxs6584
	 iQLPHyoo//KPHNp+MwA7l2uO5ubUx82b5bfPOFnGeu5UYLaSa1/y0maeKYwPFgxFVR
	 HT2wsXgHOLh2JaC/ob3iJH7dN89loXrqsr9nhe0DmsKvGXcbpZciPl/H2PFvsAmbxx
	 jYapyjaI1MGOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 02/15] selftests/bpf: Add tests for ALU on
 pointers with CAP_PERFMON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002124714.180012-3-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
 <20261002124714.180012-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:08:03 +0000
Message-Id: <20261002130803.A0FFA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf/selftests: test logic fails to verify ^=3D and *=3D on point=
ers
--

commit f742d8e4562c4f3d08b13ad422c226ac60b38d25
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON

This commit adds BPF selftests to check that various ALU operations
(&=3D, |=3D, ^=3D, >>=3D, *=3D) on a pointer to a map value properly produc=
e a scalar
or are rejected as expected depending on capabilities.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu=
.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> index 9f669cf85c593..31663338866d3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> @@ -165,6 +165,171 @@ __naked void map_ptr_illegal_alu_op(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("tag in the low bit of a pointer, and, shift")
> +__success __retval(0)
> +__failure_unpriv __msg_unpriv("R1 bitwise operator &=3D on pointer")
> +__naked void ptr_tag_and_shift(void)
> +{
> +	asm volatile ("					\
> +	r2 =3D r10;					\
> +	r2 +=3D -8;					\
> +	r1 =3D 0;						\
> +	*(u64*)(r2 + 0) =3D r1;				\
> +	r1 =3D %[map_hash_48b] ll;			\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 =3D=3D 0 goto l0_%=3D;				\
> +	r1 =3D r0;					\
> +	r1 &=3D 1;					\
> +	r2 =3D r0;					\
> +	r2 >>=3D 1;					\
> +	r3 =3D r0;					\
> +	r3 |=3D 1;					\
> +	r3 ^=3D 1;					\

[Severity: Medium]
Does this sequence correctly verify the ^=3D operation on a pointer?

The preceding |=3D operation converts the pointer in r3 to a scalar, which
means the ^=3D operation is subsequently performed on a scalar rather than a
pointer.

Additionally, since this program places multiple unprivileged operations
sequentially, wouldn't the verifier abort at the first failure (r1 &=3D 1),
leaving the unprivileged rejection of the subsequent operations (>>=3D, |=
=3D, ^=3D)
completely untested?

[ ... ]

> +SEC("socket")
> +__description("number op=3D pointer")
> +__success __retval(0)
> +__failure_unpriv __msg_unpriv("R1 pointer arithmetic with *=3D operator")
> +__naked void number_mul_ptr(void)
> +{
> +	asm volatile ("					\
> +	r2 =3D r10;					\
> +	r2 +=3D -8;					\
> +	r1 =3D 0;						\
> +	*(u64*)(r2 + 0) =3D r1;				\
> +	r1 =3D %[map_hash_48b] ll;			\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 =3D=3D 0 goto l0_%=3D;				\
> +	r1 =3D 7;						\
> +	r1 *=3D r0;					\

[Severity: Medium]
Does this actually test the verifier's handling of pointer *=3D scalar?

The multiplication is applied to a scalar destination (r1) with a pointer
source (r0). Would it be more accurate to test if applying *=3D to a pointer
destination correctly downgrades the pointer to a scalar?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124714.1800=
12-1-alexei.starovoitov@gmail.com?part=3D2
