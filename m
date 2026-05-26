Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DF2D9787
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825425; cv=none; b=uamLHww7NCzgXDNF/uQ8yr3ri6sPbdcBgFfmZOrXB0ZcTl+q29m/ctXmmJBwV4gskgzqLPpEr81K+t9uzudUUF3fS3MRBZtBX3Jiv3diSQjQIul9fc0ocZf+rA4r9zcGH9oIIDwZJiXiQkyyRSOANXuB9W4ZS3yAeTF/CLBRosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825425; c=relaxed/simple;
	bh=pwfANUtm1TiYKQmfkGcHgUC3jGK8Lo2ixqCvjqFYhwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WKbZWwuEtysPf8xCT+IWOkp61tphHIrZ84DcCksawfttsFHQh4oVxOpNyQtpaX9kvce+qwpOkiQaARG+2LEjmNuKwpGYlAzVDzpcjxBH2qoAvKI7qA4sENuUIt3kWVtge0GfNa17XcKa3O/8LD+9tYMOmwqlj30D9QgOsT1Hbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwjSg7yK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwjSg7yK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E31F000E9;
	Tue, 26 May 2026 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779825423;
	bh=Ui1SXJ2b0Uy8gvBLOpeGMjY0gAz1MqLqHwGf3cvYS0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwjSg7yKVs6VLOkn01n8Gr+XgF6aD4fxC0kVT2/aASOxpC2Y6lrxW9Gni3ic+4fRX
	 YmLgs7mS5dEf4wBmU+MiE9MQFaXYrdhY1lfO6TnzyTREuVwa5oblP2lqfiNmKFdrdC
	 hirASVFbSWu4M4ISEkkWYaSZq68WqBAYVHL5Aznq86gNCeaBJPiwVyfe3dVqAM4wVn
	 I2ERgmlWRw5kMO/BVzDLaPyb3ZZndPl8MJsc6Xvbv7cvy8j9rNtiwt1yOrF1SvZ7ol
	 BbR5rCGSQqnTB+lNTR4jmWCFYJmYFvwL8iIkZ3UjkwhyOqyQTFq0R2TO2EqMYD//Ci
	 hJj2qfx275tEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] preempt: Introduce
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260526152148.30514-11-boqun@kernel.org>
References: <20260526152148.30514-11-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:57:03 +0000
Message-Id: <20260526195703.C90E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Using `select HAS_SEPARATE_PREEMPT_RESCHED_BITS` in arch/x86/Kconfi=
g violates Kconfig dependencies and causes build warnings when PREEMPT_COUN=
T is disabled.
--

commit 0d7b7073a61462aad1916eef1d66b478cea3f90c
Author: Boqun Feng <boqun@kernel.org>

preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS

This patch introduces HAS_SEPARATE_PREEMPT_RESCHED_BITS to allow architectu=
res
with 64-bit preempt count support to keep NMI nesting bits in the 32-bit co=
unt,
avoiding the need for a separate cache line. It also enables this new
configuration for x86_64.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3f7cb01d69d0..bf8288b3d52be 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -327,6 +327,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select HAVE_ARCH_KCSAN			if X86_64
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS		if X86_64

[Severity: Low]
Will this select cause a Kconfig warning about unmet direct dependencies wh=
en
PREEMPT_COUNT is disabled?

HAS_SEPARATE_PREEMPT_RESCHED_BITS depends on PREEMPT_COUNT and 64BIT, as
defined in kernel/Kconfig.preempt. Kconfig's select statement forces the ta=
rget
symbol to 'y' without inheriting or checking its dependencies.

If the kernel is built with CONFIG_PREEMPT_NONE=3Dy and lock debugging disa=
bled
(leaving PREEMPT_COUNT disabled), this select will produce an unmet depende=
ncy
warning.

[ ... ]

> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 88c594c6d7fcd..35f546a042b10 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -122,6 +122,10 @@ config PREEMPT_RT_NEEDS_BH_LOCK
>  config PREEMPT_COUNT
>         bool
> =20
> +config HAS_SEPARATE_PREEMPT_RESCHED_BITS
> +	bool
> +	depends on PREEMPT_COUNT && 64BIT

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526152148.3051=
4-1-boqun@kernel.org?part=3D10
