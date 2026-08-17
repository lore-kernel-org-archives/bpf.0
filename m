Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A44B049F
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941944; cv=none; b=J8w+eJYMPKRvnSpp/+XLl6YzIwJ6s8xuS/gQuwwpnUMvq3RxoKaXWX4AO7Pz30SOPf6HliPqeVR+3S9fDAcPVyxYuD39hG3xHze1gOcBc39Gh5kbOgPlNRp+6+VCFpVIJVFrY/zElgFk9lgLaM05dmYf9vwdpaPCXWnAWLJI200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941944; c=relaxed/simple;
	bh=FM4FLSS5nuukhulEnTNedl75if2KZuF1TXxRJXledck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDoappdxy1Yt91nz9AATWgZfk6cM6lnbvcF0l/yitD8mPh3KObewnWDIw4kPipy5SL3kjxPzEG1VdBd4tb2TZGdxyAAJGdvN7qBxiu+pevPsNGfOf954vkFHDHC79ZALZEnIEro+Ewu2MJTfCYp2OjYfOl2LV6Pj/HUcZrZryIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF4Inx2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF4Inx2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255FA1F000E9;
	Mon, 17 Aug 2026 04:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941943;
	bh=GB093qdH6NDILUDeXBhXnpD+fx+pp3OWCUlE+sevWtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NF4Inx2LZQgV4lVaenZ40kEM3Sj6TjK64es/3zxPPvxfSRoiC2OaZLkgmHCwSgDsv
	 NUY6BcnsOZBdSwdiIoV/JQMbCUy0JQ6ba7pCE2KK3Mueufy47FRpwHiqOB1yZctqX8
	 4bI6+ftNJCPc3QsIgjGa9D5p308KzbfxBwMbct46BWrDa3y2A+2JB1NV4A/PdjSwam
	 A/DdM4z/fKmOm1MTSLJ70uDNINgVHfcv6usKfEof+6mApNc5cvxAm6epledO79+tDG
	 aePK1shBHu2KoVcv6QydPqJxMhjlCTQ5z+OiFnoAZ5jXs/q6xGqeFA+gMw+L9W5nNq
	 9Isce8o71wC4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 08/10] selftests/bpf: Add C tests for
 16-byte returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042222.2295525-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042222.2295525-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:45:42 +0000
Message-Id: <20260817044543.255FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The kfuncs `bpf_kfunc_call_test_i128` and `bpf_kfunc_call_test_r=
et_pair` are conditionally compiled out of `bpf_testmod.ko` on architecture=
s other than x86_64 and arm64, but are unconditionally compiled and declare=
d as strong `__ksym` externs in the selftest object `verifier_aggregate_ret=
.c`. This will cause libbpf to fail loading the entire object on unsupporte=
d architectures (when compiled with LLVM 23+), failing the entire test suit=
e even for programs that don't use the kfuncs.
--

--- Patch [8]: [PATCH bpf-next v6 08/10] selftests/bpf: Add C tests for 16-=
byte returns in R0:R2 ---
commit 00f68ada7c423dbadb8514b3c5f6c309f446bc99
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add C tests for 16-byte returns in R0:R2

Add selftests that exercise a 16-byte return value passed in the R0:R2
register pair, written in C so that they depend on the compiler lowering
the register-pair return.

The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
aggregate return does not compile at all before that, so the programs sit
behind a __clang_major__ guard. An older compiler builds the dummy test in
the #else branch instead, which keeps the object non-empty and says in its
description why nothing was exercised.

The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
Those are the architectures whose JIT advertises
bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() requires
before it accepts a kfunc returning more than 8 bytes, and they are also
the only ones building the kfuncs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 7d81070eefe7f..426000f9a14fa 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
[ ... ]
> @@ -131,6 +136,10 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, _=
_u32 b) __ksym;
>  struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>  int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
> +#ifdef __SIZEOF_INT128__
> +__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
> +#endif
> +struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(__u64 a, __u64 b)=
 __ksym;

[Severity: Medium]
Should these kfuncs be declared with the __weak attribute?

While the test programs in verifier_aggregate_ret.c use the __arch_x86_64 a=
nd
__arch_arm64 tags, they still unconditionally reference these kfuncs in the
C code. Without the __weak attribute, Clang emits them as strong externs in
the BPF object file.

When libbpf attempts to load the verifier_aggregate_ret object on unsupport=
ed
architectures (when compiled with LLVM 23+), won't it fail to resolve these
strong externs because they are conditionally compiled out of bpf_testmod.k=
o?
This could cause the entire object load to fail, preventing even the
non-kfunc tests in the same object from running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D8
