Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAC3F9260
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002105; cv=none; b=jwX9xdbOkEmKDSyn8E/xWVLxujF9/2XxugyDDSQxFu36DgJdKmr+OdCT7Mr6LDQqpfnlCJMw+gUoBiZeFTkKz0qSLi4M154PppPD/5Gh17zXQgKEcAk73cZjGJzYhs29CuYcj65aQdFHBYmz2YLfgEBcsO91EyS2N/t7fd63Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002105; c=relaxed/simple;
	bh=oLu51c8N6b2uC18aLLsE9SagrbvdTVkXBlcnlJt9/BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuLAmxgPrB1lIEKrY19Hq8+w8JIR1PG+0SKm/nAlmgMwnrtYSYpp/HLh77RA91yQlZHq7AGKt8ZMD+9yoGOgG928f70ZW+6846fvZQmO6iRWKLooLL+AgIceWdDG0yLqBP7DcbJ3b0gsoL5HXtkCmMdx1XnWyCppwaYHuIMKj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHJGWBDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHJGWBDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F79F1F0089C;
	Tue,  9 Jun 2026 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781002104;
	bh=0JNtuDOm5cMhUfL1N8xJtUOB/+GsKHQvPpxTOPNkMmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHJGWBDk4YJT1WX5r8qxAnwNcY9B/Ito+N2W4CmykCJB+Bv93u3JRRtiYpoZpyXjx
	 tYhAw6JVNYYIMjhpueRxZHSjNH6exvhGoHnrfpO4VLC1ekTiCYRk9Vf4H08lcyp5Bl
	 FBxSiHjTVicHYzCebnZ6NGM0uSYrHuFdfpPzVm/y2AAdQTo9t4PuWvKTo0QLOG3jdj
	 PUO7vcPHSnyZKotk+OgqTs7Ilwh2p0J3uBxh6OU8+3na49XNat3S494MFH9TQlXyY+
	 Ulx0yhjccMOwxxnc2hfjLSsVNxLhv+lhZJ0Nmub/iiewgA5PLcm7u6xx3Gdl+sB6yu
	 Z2RDpzXpJBTkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609-bootconfig_using_tools-v4-7-73c463f03a97@debian.org>
References: <20260609-bootconfig_using_tools-v4-7-73c463f03a97@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:48:23 +0000
Message-Id: <20260609104824.5F79F1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Embedded bootconfig parameters leak into the kernel command line w=
hen an initrd bootconfig is provided, violating the override priority and c=
reating duplicate keys.
--

commit 9c00cec56ea23ba4a68bbf333ebf81d192d7c851
Author: Breno Leitao <leitao@debian.org>

x86/setup: prepend embedded bootconfig cmdline before parse_early_param

This commit modifies setup_arch() to fold the embedded bootconfig
"kernel" subtree into the boot_command_line early. This allows
early_param() handlers to see values supplied via the embedded
bootconfig without parsing bootconfig at runtime.

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
[ ... ]
> @@ -924,6 +926,31 @@ void __init setup_arch(char **cmdline_p)
>  	builtin_cmdline_added =3D true;
>  #endif
> =20
> +	/*
> +	 * Match the runtime bootconfig parser's opt-in: only fold the
[ ... ]
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

[Severity: High]
If an initrd bootconfig is present, does prepending the embedded bootconfig
here in setup_arch() defeat the ability for the initrd bootconfig to
override it?

Because the embedded bootconfig is prepended to boot_command_line before
the initrd is checked, early parameters (like mem=3D or earlycon=3D) will o=
nly
ever see the embedded bootconfig values.

> +	}
> +
>  	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p =3D command_line;

> diff --git a/init/main.c b/init/main.c
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -378,12 +378,15 @@ static void __init setup_boot_config(void)
>  	int pos, ret;
>  	size_t size;
>  	char *err;
> +	bool from_embedded =3D false;
> =20
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
>  	data =3D get_boot_config_from_initrd(&size);
>  	/* If there is no bootconfig in initrd, try embedded one. */
> -	if (!data)
> +	if (!data) {
>  		data =3D xbc_get_embedded_bootconfig(&size);
> +		from_embedded =3D true;
> +	}

[Severity: High]
When setup_boot_config() discovers an initrd bootconfig, data will be
non-NULL and from_embedded will be false.

Won't this lead to extra_command_line containing the initrd keys, while
boot_command_line already contains the embedded keys prepended earlier?

This seems like it would cause both sets of keys to be merged into
saved_command_line, potentially creating conflicting or duplicate
arguments. Is there a way to defer or override the embedded keys if an
initrd bootconfig is provided?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-bootconfig=
_using_tools-v4-0-73c463f03a97@debian.org?part=3D7
