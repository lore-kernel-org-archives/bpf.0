Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410133;
	b=3eUskYJKW7vprQZDA1oskIkNnYYXkkoD+uWx0caPF9/jTilwBCqhDoaObVRZ3BQa912H
	 oGSlRy4G1/6AHwPXCXtTAvua74qlor92I/w1Qw76VsCh1OqyTxJILQ+c+9Q2EosjS6BSt
	 8UEkm9/GdRC93WNZczPkT69JaeHRNgnEwKheXiRsgfjPrmjiADexAc0jr+hHwf6X6K39R
	 iYmBd7Bh9HsNRtRkOrYwKzXXv4B1YjKAkuFA4gYEER0XggHvjsF4L9NjSgwHHQat+sicV
	 lEvMVa4rkLZ7u0vbvD5Q8JGkxVttM6cFce9ItNVLKbsUV6LVwxjyYhi6LMo6YePc16w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NIz2Of5sD4JWGT4KkeRt44iJejIdWvM4i6Uv74c0Hps=;
	b=ZTE2XFr+rAQrWRJ4EqjRch7hHXcODcaRuWYBsUqXPGIKD2+39gavKVwc1jwSeozs5RAY
	 xyeKhHU+OLBREs/jhwwndbuuMO4v1UmYJ000likVr5DufnlbAwrooqKPq0mQF+qtF4zWa
	 pDU9pYBTPg34PFnZEwVgbApIajvIi+qKH2rX5X7Q3gQkC5FAWAkOMUYwMGznd3kQk5QkG
	 Jv/xpLwcb+pHTB1cMDxpz2PyoI939jO6GVjFIvQFLbNN2YL6Rh84OUeXFenEKG0amkJZm
	 De41PRIsor2oMzC9pzv2U1C5phqt7bbVCVzZIpqOYqIH7dRM4Yr1VCQz0tdNUot2kTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AipVwBmt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F8606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AipVwBmt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0266F1F000C0;
	Mon, 23 Nov 2026 05:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410133;
	bh=NIz2Of5sD4JWGT4KkeRt44iJejIdWvM4i6Uv74c0Hps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AipVwBmtSCgBXB9nvJ8IDF0hNr6OiKpoMZ0cWCveb98DCrlTa8j3agGpsAgKmG1E9
	 EhgkoofGEpDTO/Sxce6nDgBEKKQO5NJU2rwleOQba6dIjoD0glKYaIkJZfTdRkYxgV
	 vryAnY4HhgMS/y8j1A3DWg67yu6ebITTgedot/MB8B9xAwRkRQ5gsh1NQLKaU70Pfb
	 9n8qG4JE8QzvtaTf/+BL8kUz3JFUhQrDoYs+3PI/Ue1kJMA768dDl+WogtUa222yqw
	 A/mpu7pv7Vk0c719kghnihiVv2h3lF14g+dJxxhClbTy+oJX2tGJ/EXpwBH2AeMasM
	 HWIf1av/5cH0A==
Message-ID: <sashiko-outbox-228693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Enable instruction array
 test for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123045008.23691-2-yangtiezhu@loongson.cn>
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
 <20261123045008.23691-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 05:02:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: enabling bpf_insn_array on LoongArch fails
  without JIT support
--

commit a34406fe396aca3cf00c1518cc4013c6dae7154b
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Enable instruction array test for LoongArch

This commit enables the bpf_insn_array selftest suite on LoongArch by
adding defined(__loongarch__) to the architecture guard.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 4ffe4fe6b78e9..6b1a426aa4cd5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -5,7 +5,7 @@
>  #include <test_progs.h>
> =20
>  #if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__) =
|| \
> -	(defined(__riscv) && __riscv_xlen =3D=3D 64)
> +	(defined(__riscv) && __riscv_xlen =3D=3D 64) || defined(__loongarch__)
>  static int map_create(__u32 map_type, __u32 max_entries)
>  {
>  	const char *map_name =3D "insn_array";

[Severity: Medium]
Does enabling bpf_insn_array on LoongArch depend on a prerequisite JIT
patch that is not in the tree yet?

In arch/loongarch/net/bpf_jit.c, bpf_int_jit_compile() does not call
bpf_prog_update_insn_ptrs(), so insn_array->ips[] stays zeroed and
bpf_insn_array_ready() rejects program loading with -EFAULT.  In addition,
build_insn() only handles BPF_JMP | BPF_JA and BPF_JMP32 | BPF_JA, without
BPF_JMP | BPF_JA | BPF_X (gotox), so the gotox subtests fail to JIT with
-EINVAL (-ENOTSUPP).

Also, HAVE_EBPF_JIT on LoongArch is only selected for 64BIT, while
defined(__loongarch__) matches 32-bit builds as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123045008.2369=
1-1-yangtiezhu@loongson.cn?part=3D1
