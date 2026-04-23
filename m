Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C263F4A
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985953; cv=none; b=ZJg3GhsUwgxBpsmrWBOUQ0NluyUW5qnAOEuvfxYSg/graLOmENIGdlQobP6FDpUAIzznbYd/D3SWP6cLfWWd5YoTTBhALjg62xXo+6EcJsQt7H2AEly63egAHNSp/TysKzgl5P1QLnUKRyFH2IL/kCwZ+c5gbkQ6jWMgW2rYj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985953; c=relaxed/simple;
	bh=jmSM14PyT5GeBytIH/HziUJ3I3CHILernO+bnIfjbvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQGSErRpV+JJbU6//YxAm4ioXMfhcF1qGX3IoiLl8nCz7mty1XDYSM6gV+ZpHrW6vHWrvc1eqBGwYAcGjG+ymlnIOfwJhbo+r8co0SMNdSBvfNrTcvVx1f4dLChUx+XfD6YigB2HhvKzVnXe9FXxgZyj+ZJELZRC/K6eacj0wYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsc5BdOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsc5BdOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AE5C2BCAF;
	Thu, 23 Apr 2026 23:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776985953;
	bh=jmSM14PyT5GeBytIH/HziUJ3I3CHILernO+bnIfjbvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rsc5BdOa77YF7KN8sLBsATPsqThmTQMMmeirRzP0zdPcp3J1wH8OD+VLc+iDuHOhy
	 M3WPz5ZPSN0PACL6O4ZkF6mh60zUJWf1449bkdHLtfqqWvXslwfjbOGLHB1Gg5s2de
	 bal5nJ9n0hLKFM8mWHlvz7+TEEQeb52liMn59wei5n68byxF0Tp333A0cqUvgAsqyM
	 TQyND30xB8GEZq+3uhDNONoAL93lPUL5SPktOP0ZaHfjUQqicVxFdgE6Cjo5yf4rQs
	 UrxSgld63EbgBkdH0lgl0LcNoLIqGjuFl7Kox0gUChU36KszujJnY21aMxcxoubz8r
	 H2+JNwbcDhU5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: crypto: snapshot params before string
 validation
Reply-To: sashiko@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424070105.1-bpf-crypto-v2-pengpeng@iscas.ac.cn>
References: <20260424070105.1-bpf-crypto-v2-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 23:12:32 +0000
Message-Id: <20260423231232.C8AE5C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Cryptographic key material is left on the kernel stack without b=
eing zeroized.
- [Low] Unnecessary and technically incorrect file descriptor validation fo=
r a skeleton-generated program.
--

commit 4025cf60c980030df8d7712c14d6f5b70e1660b8
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

bpf: crypto: snapshot params before string validation

This commit updates bpf_crypto_ctx_create() to snapshot the BPF-provided
parameters into a local stack variable before validating them. This prevents
issues where BPF programs might modify the memory during validation. It also
adds a selftest for testing invalid crypto algorithms.

> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 51f89cecefb4dc..e2dc3dfb4d8540 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
[ ... ]
> @@ -147,31 +147,46 @@ bpf_crypto_ctx_create(const struct bpf_crypto_param=
s *params, u32 params__sz,
>  		      int *err)
>  {
>  	const struct bpf_crypto_type *type;
> +	struct bpf_crypto_params params_copy;
>  	struct bpf_crypto_ctx *ctx;
[ ... ]
> +	params_copy =3D *params;

Does this leave plain-text cryptographic keys on the kernel stack?

The struct bpf_crypto_params contains key material. By copying the caller's
structure into the local params_copy variable, the key is placed on the
stack. Should params_copy be cleared using memzero_explicit() before the
function returns on both success and error paths to prevent potential
information leaks?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/too=
ls/testing/selftests/bpf/prog_tests/crypto_sanity.c
> index 42bd07f7218dc3..044711e7263a8f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
[ ... ]
> @@ -117,6 +117,19 @@ void test_crypto_sanity(void)
>  	udp_test_port =3D skel->data->udp_test_port;
>  	memcpy(skel->bss->key, crypto_key, sizeof(crypto_key));
>  	snprintf(skel->bss->algo, 128, "%s", algo);
> +
> +	pfd =3D bpf_program__fd(skel->progs.skb_crypto_setup_bad_algo);
> +	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup_bad_algo fd"))

Is this file descriptor check necessary?

After a successful skeleton open_and_load(), the skeleton-generated program
fields are guaranteed to contain valid file descriptors, making manual
validation redundant.

Additionally, 0 is a valid file descriptor in Linux. If the test program
received FD 0, using ASSERT_GT(pfd, 0) would incorrectly cause the test to
fail. Could this be removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424070105.1-bp=
f-crypto-v2-pengpeng@iscas.ac.cn?part=3D1
