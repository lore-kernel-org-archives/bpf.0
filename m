Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87125A655
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542298; cv=none; b=H6MkgMkw/NOBtFzGTF1xfqcEer+ZFx0NPc5YiYiwoPBiVae7WmYIPUXlgbwQ7n1iOAJrvl6q63PsTZtzvWlrZldk1o3mLKFbxYwygvOVMZc3eLwA286aMEQ9IKdWS1JtrhdvXaO4ZaV7weXklnPQMN3D4ZTTJck0obwpLlIFp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542298; c=relaxed/simple;
	bh=1oHy+TLSON0YSTEfXDVVXlVWHoeC8PRxc0HAympFt7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vCTcjluEzLzkbopS1xmokNj6cnrEPMgWeZr7CeFmJMZZDavuyS7RlckbX0AS/gyhZRhPJB0NyQUA2K5jwLyQ3NtQOeV3puVYIjUY2noKZbr9GBuYO+TQKEmFo8eshLHWIVIQQMnSxKkuVZ5ZM2pMM5R6U+LX8YxASjfhjdl4ZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np+MTl8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np+MTl8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E91F000E9;
	Wed,  8 Jul 2026 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783542296;
	bh=qUGmXjqHgHhMGBTF/BkBF+HsbWvNIUZCV6XrHp61H4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Np+MTl8d6dE1hYRerwxWrGwmZ5WSW5dGWI5vekV9U38usVUwrjF2ZZ7o6iNkJd950
	 DyYTvOS0XJCBKTpMTTX+y+c+L3C6KbfNHn5v+LBDUwpOBao4nDlKEbgbiP16WclJWg
	 1bOeYZPH9ieyyxPjkCAWcOBU+DPa5YQuYxLf+wBrKwjhcSLtU5bXTiVPx61vgihw5t
	 mrsXYzzTumIZIv7i2r6M7dw7SqHMrG2QJqd8/+nMfzkMgNrhZydqLeNYlcvVcbTa9Y
	 0o6PlcxZnx8ZrKzB4BU0y3N3PhpBrrghvfMnYUcLWwQ4xMwcxaFhf7tI/ZHi/FhH1L
	 AwS4SDw5ZzPBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708201025.2160583-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201025.2160583-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:24:56 +0000
Message-Id: <20260708202456.8A5E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional use of `__int128` in `bpf_testmod` breaks compilation=
 on 32-bit host architectures.
--

--- Patch [9]: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byt=
e returns in R0:R2 ---
commit 5ed3844739f04c920bb1c37cdf474501b3ca9fef
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add C tests for 16-byte returns in R0:R2

This commit adds selftests to exercise 16-byte return values passed in the
R0:R2 register pair. The tests include an __int128 return, a 16-byte struct
return, and a 16-byte union return.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> @@ -825,6 +825,18 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
>  	return 0;
>  }
> =20
> +__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
> +{
> +	return ((__int128)a << 64) | b;
> +}

[Severity: Low]
Will this unconditional use of __int128 break the build on 32-bit host
architectures?=20

The __int128 type is a compiler extension that is typically only available
on 64-bit systems.

[ ... ]

> @@ -1358,6 +1370,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)

[Severity: Low]
If bpf_kfunc_call_test_i128 needs to be conditionally excluded for 32-bit
builds to fix the issue above, should this BTF ID registration also be
conditionally excluded to prevent a missing symbol error during the build?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h

[ ... ]

> @@ -118,6 +127,8 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __=
u32 b) __ksym;
>  struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>  int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
> +__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;

[Severity: Low]
Does this declaration also need to be guarded for 64-bit architectures,
so that including this header doesn't fail on 32-bit host compilers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708200939.2153=
664-1-yonghong.song@linux.dev?part=3D9
