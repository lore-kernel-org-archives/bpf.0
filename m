Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70081136672
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876472; cv=none; b=dUIbxy45/wiuNFuTE8iQIICZ0SbGTFQ5eltO3974VtaCWuv2xraRGbswa2MdRAtNsMyzR0zxhIovuj6w6+Jpg0pRSlJb1KCiVkzaVZg7YCU9kcVokKIwoZ1cUtFJglx35Ev+ufRuV9VwK0w9VHaM1FbGlnP02U4ULeh7w+Z7IBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876472; c=relaxed/simple;
	bh=WokrmbIDW3V2irhCek3eOSKak8xJidw7L3hpb4/7pM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4X9fGiiQptbjghKYeS6dKK29DUXB5BG8hfzjSzVZdDWaYG+U7z1cB1+uFY1tYxxUGFgruwwaDkeS3VIHH8NNeFXCfvP6Djt5fC90hDzNrGO9wXvKeZpTShmdDqIuvWRFIE7VnVCSWlcSTt59LqcVHpEODE6ne39ljTuvzTW8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFeb+3dY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFeb+3dY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1C31F000E9;
	Tue,  4 Aug 2026 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785876471;
	bh=uQOX92DhOOObVVWky8lbi919AFAg7RrgdfdCK+6Xd2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QFeb+3dY+UNw7+LbzGDrvluZPL+nOFeRowuWYF8o9IImj+KoY4D189WIIN9JcEAnK
	 Ep47cwUUjjn0zjM0kHB+5fitbobC+3YrJeAYjwhXE1v15i6v0s0cVcKVpX70iUyXVN
	 rT+Gml2l4j3usT7aViPa7Yk3DZW0NDVIKnJ5zXJtGPaCMUbXFsUu0y6y0w5o9GudF1
	 oDDjXpusWZKE+fcg/IebNFIXPNK7vO8+PELbbwZ4R2a6h8RMjHjK0ABydAIFAqkbPH
	 P1vGUd5B4FmZxarIrNoRca/MAjSQs9TtA8Q0bICMSfXU9DoKQ9TH3CicaQm4Eb35Yi
	 lR4p3a2rB669w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: Add C tests for
 16-byte returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804203613.1877773-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203613.1877773-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:47:49 +0000
Message-Id: <20260804204750.DD1C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional use of `__int128` in the `bpf_testmod` kernel modu=
le causes build failures on architectures lacking 128-bit integer support.
- [Low] Redundant BPF program FD validation after successful skeleton load.
--

--- Patch [10]: [PATCH bpf-next v2 10/13] selftests/bpf: Add C tests for 16=
-byte returns in R0:R2 ---
commit 9e3dc1e0617b6a9acfcd02529cae781809d11bbc
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add C tests for 16-byte returns in R0:R2

Add selftests that exercise a 16-byte return value passed in the R0:R2
register pair, written in C so that they depend on the compiler lowering
the register-pair return. Covered are an __int128 return, a 16-byte struct
return (from a static and from a global subprogram) and a 16-byte union
return, plus __int128 and 16-byte struct returns from a kfunc, for which
bpf_kfunc_call_test_i128() and bpf_kfunc_call_test_ret_pair() are added to
bpf_testmod.

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
> new file mode 100644
> index 0000000000000..42017f89c4da6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> @@ -0,0 +1,125 @@
[ ... ]
> +static void run_prog(struct bpf_program *prog, bool supported)
> +{
> +	char buf[64] =3D {};
> +	int err, prog_fd;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .data_in =3D buf,
> +		    .data_size_in =3D sizeof(buf),
> +		    .repeat =3D 1,
> +	);
> +
> +	if (!supported) {
> +		test__skip();
> +		return;
> +	}
> +
> +	prog_fd =3D bpf_program__fd(prog);
> +	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
> +		return;

[Severity: Low]
Is this manual FD validation necessary here? According to the BPF skeleton =
API
guarantees, after a successful skeleton load, skeleton-generated program
fields are guaranteed to have valid FDs. Since run_prog() is called using
programs from successfully loaded skeletons, the extra validation appears to
be redundant.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index eb0f9b5e18d85..2ceb34df472e6 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -857,6 +857,18 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
>  	return 0;
>  }
> =20
> +__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
> +{
> +	return (__int128)(((unsigned __int128)(a + b) << 64) | (a - b));
> +}

[Severity: Medium]
Will this unconditional use of __int128 cause build failures on 32-bit
architectures? It appears bpf_kfunc_call_test_i128 is not protected by
an #ifdef __SIZEOF_INT128__ guard, which might break compilation of the
bpf_testmod module on platforms lacking 128-bit integer support.

[ ... ]
> @@ -1390,6 +1402,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)

Should this BTF ID registration also be guarded to prevent compilation
or pahole errors when the function is omitted on 32-bit builds?

> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
[ ... ]
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index c36bb911defa7..e6e59fdce33cf 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -118,6 +127,8 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __=
u32 b) __ksym;
>  struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>  int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
> +__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;

Does this unconditionally declared prototype also need to be wrapped
with an #ifdef __SIZEOF_INT128__ guard?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203522.1869=
244-1-yonghong.song@linux.dev?part=3D10
