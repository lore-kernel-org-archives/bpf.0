Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC2C21FF;
	Tue, 23 Jun 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236618; cv=none; b=SlA70GStf2D8CKY+j2s0Ph3zWMHpFYLGcCQrzxh2J+4LMaYppDecj9OJyhl0Ts9CVhgeMsNn5JHfgiozeIDsmLq9s8Jp2q1zjfN0STu8G5FoR5S0YMGUi8M/JsKQlJxb2j//yjxLGxztcd134mOAhk4gyFZS4ONUJL257izPt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236618; c=relaxed/simple;
	bh=fTMRDaZ1dEaOgb0LJQ8RJ0AHGIsv7YBfFNkhhO0C5kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzdAWVlSgZK2D5YIZL5Yb3PWsaE/d1ytYdrpeJG/rHRB9YdDMY3aFKZ+rv86ACAbIMdeYVg4aF5Nte8slLP4HwUIx/tnzKA3IcDz3jwuuAofwrWmro13/gNxMtW8yCwbyjasx0E1QI2xk4ZjOfBqag+dT5OyT9r6kgGAv313DTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOK1NNqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOK1NNqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3DD1F000E9;
	Tue, 23 Jun 2026 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236617;
	bh=2AcaM2HELAI3l0dakGI4halPNZVPRXDKC6CHntC2TDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOK1NNqa4Z5ZoPk8or2334I0laMM3hklAyQkR1lXrbTFbTzKjoRho9roqn3NVCt9a
	 d3CK3Imh/AThu9bFsfvfwhpXMTuyIGUhvmpM7qpMMLhLxTxu9Qjfp9Ahh0rBjJQ4gO
	 Hsp0Y1SWMuNwhsH1yp991ix+1/6ejDg+eJmcId+2GZgWuYdT8KJcX1ky+QFQm0O9Z8
	 rcFFsqrYXIo7KeL3ZLe6SbegYwKqB4jop4UIs5XUWMXtEdSy1jUP0vX6wml58XPsG1
	 DpMIsdRNcs7L2OURp4xFa/JgSRlW6iEnDUqPq0/oCMw081Wht2cAgxzlquTHpaagkP
	 RO1HPz+6tccZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/12] x86/vmscape: Move mitigation selection to a
 switch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: kvm@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260622-vmscape-bhb-v12-5-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-5-76cbda0ae3e5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:43:36 +0000
Message-Id: <20260623174336.CF3DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of a `default:` label in the `switch` statement defeats =
the compiler's ability to ensure all mitigation modes are explicitly handle=
d.
--

commit 5e3a6ba10ff7b033ea17daee7432bcf9168f3b13
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/vmscape: Move mitigation selection to a switch()

This commit refactors the vmscape mitigation selection logic to use a switch
statement. The stated goal is to explicitly handle all mitigation modes and
group the logic for each mode together in preparation for future additions.

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
[ ... ]
> @@ -3088,17 +3088,33 @@ early_param("vmscape", vmscape_parse_cmdline);
> =20
>  static void __init vmscape_select_mitigation(void)
>  {
[ ... ]
> +	switch (vmscape_mitigation) {
> +	case VMSCAPE_MITIGATION_NONE:
> +		break;
> +
> +	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
> +		if (!boot_cpu_has(X86_FEATURE_IBPB))
> +			vmscape_mitigation =3D VMSCAPE_MITIGATION_NONE;
> +		break;
> +
> +	case VMSCAPE_MITIGATION_AUTO:
> +		if (boot_cpu_has(X86_FEATURE_IBPB))
> +			vmscape_mitigation =3D VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
> +		else
> +			vmscape_mitigation =3D VMSCAPE_MITIGATION_NONE;
> +		break;
> +
> +	default:
> +		break;

[Severity: Medium]
Does including a default case here defeat the stated goal of the patch?

The commit message notes this refactor "ensures that all mitigation modes a=
re
explicitly handled". However, including a default block suppresses compiler
warnings about unhandled enum values.

If future mitigation modes are added to the enum but forgotten in this swit=
ch,
they will silently fall through to the default case rather than generating a
compile-time warning.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-vmscape-bh=
b-v12-0-76cbda0ae3e5@linux.intel.com?part=3D5
