Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CA3AB460
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134664; cv=none; b=tS2/NTBlfTLwB64XbJMgfwKHeLRpgR8KrBgYOEiId41sICeDaQToAc2qRpqfpb6LvoBSqFzo0zKjNyYhlOFpauCF8QlTpq6l5NNSG0RenwGNfZ1LgpczMYjyUvlLB2da4s3xVKFFB04yaWdqlihwlLEGi1F+aza3UlBW0YlOM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134664; c=relaxed/simple;
	bh=wjyOdcCcwcT+o01pvjKZ2MhIL6OPJN/JTd+OOhBTd5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OULMHvYZJqUUmnXlgIGBGYh5451OlYuTFtE8NgMaK/Al59AxpvMGwXEzFZf/sUPV4FvuMbbRqD/mvm+KBlJT/YHZMYpLqPzdLw+D3/lpOC1xfaNJTQXgxAwwXC7dOOR2j6GJ+YfAvHSY5Pk8CBW5FvuVq5Fdj//I4uBI8kLZF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFVExIFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFVExIFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45A81F000FF;
	Wed, 23 Sep 2026 03:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790134663;
	bh=ujl3ys1I+Cq/LagAV4IYYWIzhuQ9YuS2TVucKlREAzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFVExIFqdUAfxXSgptUHHRNuWDJYDzSGXo1xj/5LxEhcbsUjKarahz8QbLOFvo+pH
	 vP+rup0sJaeCDbS4Eg9rMdG7XNgV/www1X+YobO7zxZBQY7R/InPfwlBK1Vf1HlkWn
	 d7Q50tEkZQlyw9ihcR43mA+CAe9EBPsrRL2Q/z0ifn1rXwKDP+NbrRk8Kr3Ktfxu+o
	 9RpCVXlvfbmH+RqaRL/MVqQqWtyIIdG8JBaTPVNFHIXeJTQ3lO7/9YsPEoBHFM8Y24
	 2XraV7ZTAyA8zjCZso4uVuuXokG5cphBlC0bZf3QtKDEDzRg78yn3AFrAGPinHCf5m
	 arfuKLt5eFwhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923032703.59816-1-ebiggers@kernel.org>
References: <20260923032703.59816-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 03:37:42 +0000
Message-Id: <20260923033742.D45A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: BPF_CRYPTO is silently disabled if AES libraries are modules
--

commit 1bcee0286f1c7c6c86befd107081ebb8a0fb0eed
Author: Eric Biggers <ebiggers@kernel.org>

bpf: crypto: Use AES-CBC and AES-ECB libraries

This commit reimplements BPF crypto using the AES-CBC and AES-ECB library
APIs instead of the lskcipher API. It adds a new BPF_CRYPTO Kconfig option
to conditionally compile crypto.c based on the new AES library dependencies.

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index d7d25477ef481..a44ecfa3e9ef5 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -91,6 +91,15 @@ config BPF_UNPRIV_DEFAULT_OFF
> =20
>  	  If you are unsure how to answer this question, answer Y.
> =20
> +config BPF_CRYPTO
> +	def_bool y
> +	depends on BPF_SYSCALL
> +	depends on CRYPTO_LIB_AES_CBC
> +	depends on CRYPTO_LIB_AES_ECB

[Severity: High]
Does this dependency logic silently disable BPF_CRYPTO if the AES libraries
are built as modules?

BPF_CRYPTO is defined as a bool in Kconfig but depends on CRYPTO_LIB_AES_CBC
and CRYPTO_LIB_AES_ECB, which are tristate symbols. Under Kconfig rules, wh=
en
a bool depends on a tristate that evaluates to m, the dependency evaluates
to m, which downgrades the bool to n.

Consequently, kernel/bpf/crypto.c might not be compiled, and the crypto
kfuncs could be silently stripped from the kernel. Existing BPF programs
using crypto kfuncs will fail to load with "unknown kfunc". Because the AES
library symbols lack user prompts, users cannot manually fix this by
explicitly setting them to =3Dy in menuconfig.

> +	help
> +	  Provide the kfuncs needed for BPF programs to encrypt and decrypt
> +	  data. The supported algorithms are AES-CBC and AES-ECB.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923032703.5981=
6-1-ebiggers@kernel.org?part=3D1
