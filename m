Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CC3009E2
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050572; cv=none; b=JHdr3cUxnTqNYVSYCtrkQrupFxvyMrU5GR2Mum6xot7SpTeZekWGvV2x95S0uIVNS4lEarjIqKMrQ/l2arE1egJh6mEdtI0d7pqDxVX0i4MYz22bEuVu6h3w5AEcWExu4fSQKSSUdcJ3FnE/uFP/V87Ok8T1RR+25Psp7t95vXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050572; c=relaxed/simple;
	bh=ky9TWVlgkjWPkLlclmRWX/Kpl60AxqTmO+r1kr3xJqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fM7w0od+DaVpnhZ6ryCTSHYi9T18h9ClnUGhuYpRC/1mOkfEFmk/RdABdvO/2Qd87KV7tHK2+6y5/NQL9N5+AEpqyMCjikMHeA8XmswP3EGxNKA+Y4fPKSCJNeEJANyCo8tKufu9cU6hSB26NAGiRwlT9CqtzAYLfr+W86hz/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHZu9g4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHZu9g4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4BB1F000FF;
	Tue, 22 Sep 2026 04:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050569;
	bh=hZ/YqWRONIGalYbXGcLbTviW9GhnDjhUCYpnb1psHgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHZu9g4WuYs2FwlQLXdAERyHNqpg/lQqpUKTPP24RLD+xMVNN1FGkrqk85t2aUzMH
	 BZOGN1HWgaC/WoH08laeE5vIdYQgv2pbevEvTBVcVMbQclic5l6aONtR789vrPWDpA
	 A/StRJL0NddPPbw07LmT80IDzGagG5vN/0V2MdJkDp17Kbawp+dGxtfUlxYHJErzsq
	 spiTG/snBz31jzFTt4Nyl+Ynp/DxvdI4tiGwzAhfBMGvkBlB+vGJ1Dk2xu4PDgfcYo
	 lYboLO2u1+e4xHw9wFRSlRqhFFLF7RRpzjcQHuOEj7JyrbaL8eCGKgCnzBLLlsH8zM
	 BSa9ocuIRZ4cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922040413.28885-1-ebiggers@kernel.org>
References: <20260922040413.28885-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:16:09 +0000
Message-Id: <20260922041609.CE4BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: BPF_CRYPTO is silently disabled on modular kernels
--

commit 4eaa15850cd54db254c7280e28e3b2a751a2c186
Author: Eric Biggers <ebiggers@kernel.org>

bpf: crypto: Use AES-CBC and AES-ECB libraries

This commit reimplements BPF crypto kfuncs to use the AES-CBC and AES-ECB
library APIs instead of the lskcipher API. It removes the bpf_crypto_type
abstraction layer and simplifies the crypto implementation.

Link: https://lore.kernel.org/r/d1cdfc23-b336-49a9-8833-29f05b5b9fec@linux.=
dev/
Link: https://lore.kernel.org/r/5f9c3aab-5339-463c-a86d-edac297e1e95@linux.=
dev/

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
Will this silently disable BPF_CRYPTO on modular kernels?

In kernel/bpf/Kconfig, BPF_CRYPTO is defined as a boolean symbol. If the
kernel is configured with CONFIG_CRYPTO_AES=3Dm (which is common for many
distribution kernels), the hidden library symbols CRYPTO_LIB_AES_CBC and
CRYPTO_LIB_AES_ECB evaluate to 'm'.

Because a 'bool' config cannot be set to 'm', the 'depends on' directives
here will force BPF_CRYPTO to evaluate to 'n', completely disabling it.
Furthermore, because BPF_CRYPTO lacks a prompt string, users cannot see
why it was disabled or enable it manually.

This causes the BPF crypto kfuncs to be silently omitted from the build,
which would cause programs relying on them to fail to load.=20

Would it be better to conditionally select these libraries or find another
way to express this requirement to ensure BPF_CRYPTO remains enabled?

> +	help
> +	  Provide the kfuncs needed for BPF programs to encrypt and decrypt
> +	  data. The supported algorithms are AES-CBC and AES-ECB.
> +
>  source "kernel/bpf/preload/Kconfig"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922040413.2888=
5-1-ebiggers@kernel.org?part=3D1
