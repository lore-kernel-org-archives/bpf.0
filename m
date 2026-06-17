Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2902E7387
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696589; cv=none; b=ux7VQN+eCQlO9u0Ynr8Lb0kYAW8ZBZNC0rfe9v1aZlRriZFZHQvijc3DPvjGsHm4k93aHKZ7Qu+c116My7+CigMw63eBSiXFBYQbOc5v9UlqoaT571dktPWvZmRG5KjLbX6oxjZqO5LCP1zkQ1L/3j2ljLq6vF6i8MwoLqQbuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696589; c=relaxed/simple;
	bh=Bke0GXKzlvtElmhtrORrXGNbHuHWsri/xRLwe/E1iOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=or3YvbisTR/ZWGuYn6n+wgTi+FlKPh2/ZAjQA/6sLlVS69Q3kFvKkYCkpPBWDaNzWQtuVl5weHxwiV0eQ9nfq81ykkPSBm6brzG7P4+ItEJ66074SgQUn1Qe39O1LMxV0P1t0qPz4qyfo1cbFc480P02adHg+N5M6OaApipSWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/amrcCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/amrcCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AA81F000E9;
	Wed, 17 Jun 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781696588;
	bh=9iOf4gqd94N03VvdpHIe43f/sVZbKXfbImRTzVFw+x4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/amrcCKMZEL5jOe9heS9TuhU+sE6HIWvrhFj1jqvGlS+iqetUQouH1PsoOMpfrNW
	 q5HEPjSBVvCZuIRRVofYraUC2bY+ewZlcc0obSVujyDh+3iM6Cs4gqNqAtAYa7bBnl
	 cPeDztfYcl3a8/G6vDSp/VXYQPoXRlXNTHl3KsF4Trn25ZKQJcJyk31euD22bwGfav
	 R63+B7FHCfQnaMvRM6q9Q92T4FTjQ92pDXkW3nFP3vudN16qFzEBuRq/HjKGOsiKiI
	 pjyjgL0rmg8EBqvoSYdmygQJBUzBogzdz7Q1R2UHgoMMCB6yZ55804EGefmKBPuQGe
	 RxaACPbkyJp5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260617-bootconfig_using_tools-v5-7-fd589a9cc5e3@debian.org>
References: <20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org>
 <20260617-bootconfig_using_tools-v5-7-fd589a9cc5e3@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:43:07 +0000
Message-Id: <20260617114308.08AA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Split-brain and silent loss of embedded bootconfig when an initrd =
bootconfig is present.
- [High] The check for 'bootconfig' in setup_arch() does not stop at the '-=
-' separator, leading to a split-brain state if 'bootconfig' is passed stri=
ctly as an init argument.
--

commit 8df914967d65efb57f129f5003c1c8d584ad9df9
Author: Breno Leitao <leitao@debian.org>

x86/setup: prepend embedded bootconfig cmdline before parse_early_param

This patch modifies the x86 boot sequence to prepend embedded bootconfig
parameters to the kernel command line early in setup_arch(). It manually
checks for the "bootconfig" parameter before parse_early_param() runs,
and adjusts setup_boot_config() to avoid duplicating the command line
prepend later.

> The prepend necessarily runs before setup_boot_config() detects an
> initrd bootconfig, so an initrd cannot override the embedded "kernel"
> keys for early_param(). This is intentional: the embedded cmdline acts
> like a build-time CONFIG_CMDLINE. An initrd bootconfig's "kernel" keys
> never reached early_param() anyway (they apply late via
> extra_command_line), so nothing is lost -- the initrd keys still apply
> late, with last-wins keeping the embedded values in effect.

[Severity: High]
Does this accurately reflect the behavior when an initrd bootconfig is
present?

If both an embedded bootconfig and an initrd bootconfig are present,
setup_boot_config() handles it like this:

init/main.c:setup_boot_config() {
    data =3D get_boot_config_from_initrd(&size);
    if (!data) {
        data =3D xbc_get_embedded_bootconfig(&size);
        from_embedded =3D true;
    }
    ...
}

This means the embedded bootconfig data is entirely ignored for the runtime
tree, silently discarding any tree-structured configuration (like ftrace or
IMA) from the embedded bootconfig.

Furthermore, extra_command_line from the initrd is placed before
boot_command_line in saved_command_line. Since the embedded keys were
already prepended to boot_command_line in setup_arch(), they appear
after the initrd keys.

With last-wins semantics, the embedded kernel parameters override the
initrd kernel parameters, while the tree data comes exclusively from the
initrd.

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 46882ce79c3a4..d69ba84c203f1 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c

[ ... ]

> @@ -924,6 +926,31 @@ void __init setup_arch(char **cmdline_p)
>  	builtin_cmdline_added =3D true;
>  #endif
> =20
> +	/*
> +	 * Match the runtime bootconfig parser's opt-in: only fold the
> +	 * embedded kernel.* keys into the cmdline when "bootconfig" is
> +	 * present on the command line, or CONFIG_BOOT_CONFIG_FORCE is set.
> +	 * setup_boot_config()'s parse_args() loop treats any presence of
> +	 * the "bootconfig" key as opt-in (bare, =3D0, =3D1, ...), so check both
> +	 * forms here: cmdline_find_option_bool() matches the bare key,
> +	 * cmdline_find_option() matches "bootconfig=3D<anything>". Without
> +	 * the second check, "bootconfig=3D0" would skip the early prepend
> +	 * but still trigger the late runtime apply -- a split-brain state.
> +	 * CONFIG_BOOT_CONFIG_FORCE defaults to y when BOOT_CONFIG_EMBED is
> +	 * set, so on the default config the embedded keys are applied
> +	 * unconditionally.
> +	 */
> +	{
> +		char buf[8];
> +
> +		if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) ||
> +		    cmdline_find_option_bool(boot_command_line, "bootconfig") ||
> +		    cmdline_find_option(boot_command_line, "bootconfig",
> +					buf, sizeof(buf)) >=3D 0)
> +			xbc_prepend_embedded_cmdline(boot_command_line,
> +						     COMMAND_LINE_SIZE);
> +	}

[Severity: High]
Could this create a split-brain state if "bootconfig" is passed strictly as
an init argument (e.g., after the "--" separator)?

The cmdline_find_option_bool() and cmdline_find_option() functions search
the entire command-line string and do not stop at the "--" separator.

If a user passes "-- bootconfig", setup_arch() will detect it and
prematurely prepend the embedded kernel parameters to the command line.

Later, the runtime parser parse_args() in setup_boot_config() strictly
stops parsing at "--". It will fail to find "bootconfig" and exit early
without initializing the bootconfig subsystem.

This leaves the system in a state where the embedded kernel parameters are
fully applied, but the bootconfig tree itself remains completely
uninitialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-bootconfig=
_using_tools-v5-0-fd589a9cc5e3@debian.org?part=3D7
