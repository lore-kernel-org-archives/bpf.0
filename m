Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE145106F
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905279; cv=none; b=hWI2S97APUHvMejps+6VIkBN3tw6JUGnV2HOH/MLrMtd7GBE2vXidsNzXkTzeB6CBMv5iZL8T8ZLUrr2PBN72gLyWi8xA80p0pp9AUB8DglvfSRpcKlzdb1gDxcq3pC1yGoJghYGSLaDK08pW5PYtci4IiVlAA2jzRu4mL56avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905279; c=relaxed/simple;
	bh=oG/YfU6vpOzLUxoCYyT+JIRQ3SCMPv60omqcVfRXTO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mOTuFpfK4dzZSFttMwvgVcJO+32MnfbZqYEQz+4c8efSJv6Iz7NGZBf8KLiCmuHJOMkhAThsYVtiyIHnA8TUJLY0Xg5Ksal8Sz+Sxh40CbbVs2CQc695S/skSHX7TUws3nqR9cuAcMr7vS2MyObWIeNxfbxTL8GVVbnZDISv8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3EgSA9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3EgSA9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CEC1F000E9;
	Wed, 27 May 2026 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905277;
	bh=pg6miN1E9av1/tI8OIzk2W3jO5AZvhMS29E+7E1hyPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3EgSA9N/2x6GBN9vuZ4M609HNqkBv8H64433BtyFv/vuIzV8y9TxUwRnjoOeJWnr
	 sZLtoTUlzOwLIXem6oBj3bDGidAQUpKW3H/cu+LlY3zJTz4c0T8/nvIGVc05dMi1kA
	 guW1hBWas+31MjNbB++55a1LreftltmhwQ4GPtcX6ygj7EqvhHuQiEEF1xX9kX7cEO
	 gDMlzdN+1zvPoI+6mBcdx0JWa9O81Z9j/2gSSD64DWYwzegxlQsnv4tO7Y6AswNd6H
	 UKjqn3WgI0MLfhM7UEcoSCU+rcVDfhV9ZShBGk0aIhGUfBzYucjBbA28smdSZm9D2C
	 VuOr80iHe83+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-bootconfig_using_tools-v1-4-b6906a86e7d5@debian.org>
References: <20260527-bootconfig_using_tools-v1-4-b6906a86e7d5@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 18:07:57 +0000
Message-Id: <20260527180757.B4CEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional application of embedded bootconfig `kernel` keys byp=
asses the `bootconfig` parameter opt-in requirement.
--

commit 571add72b0db9b7dbd9f5c179025b85435fd8e31
Author: Breno Leitao <leitao@debian.org>

x86/setup: prepend embedded bootconfig cmdline before parse_early_param

This commit prepends the embedded bootconfig kernel subtree to the command
line in setup_arch() before parse_early_param() runs. It allows early
parameter handlers to see bootconfig values without runtime parsing, while
avoiding duplicate registrations in setup_boot_config().

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 46882ce79c3a4..592c4c79c974b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c

[ ... ]

> @@ -924,6 +925,8 @@ void __init setup_arch(char **cmdline_p)
>  	builtin_cmdline_added =3D true;
>  #endif
> =20
> +	xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);
> +

[Severity: High]
Does this unconditional call bypass the bootconfig opt-in requirement?

Documentation/admin-guide/bootconfig.rst specifies that embedded bootconfigs
must be explicitly enabled via the bootconfig command-line parameter, unless
CONFIG_BOOT_CONFIG_FORCE is set.

Could this create a semantic inconsistency if a user boots without the
bootconfig parameter? It appears setup_boot_config() would correctly ignore
the embedded init.* keys, but these embedded kernel.* keys would still be
forcefully applied.

Furthermore, does this impact the bootconfig fail-safe recovery mechanism?
If a malformed embedded kernel.* key (such as an invalid console=3D or mem=
=3D)
causes a kernel panic, would an administrator be unable to disable it by
removing bootconfig from the bootloader command line?

>  	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p =3D command_line;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-bootconfig=
_using_tools-v1-0-b6906a86e7d5@debian.org?part=3D4
