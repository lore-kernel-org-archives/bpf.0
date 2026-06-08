Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922A29AB02
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940033; cv=none; b=dGx4hC5hO+EfuL86fvay2+Fs7TrEFGXxW8uZP+rbofJ+PrOjfj6fd88jZUC2TmEtFXcVl3dF8XMmYuFVRhv1vsaRRal8EXDtwpnyFWTGZwnFSqW1SQPCMIee8QhJZPezrbk33sKLhznb3WYn1WpydoN9F/e2ilflISsUShMKPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940033; c=relaxed/simple;
	bh=GEvEU7XaI0Gxhljio87/3WSnMu6QqXfwp6/5ORJGX/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1jYy4mAwPVTR8pKILIyTysguUCj7HO6vg+6c+3iEnOvuqejXBEGFkeOHU9OoPsVEaeCsAO+9UapKIFN1/A6YgusZ37ALYVpAUJAdvxxXVK6Rh5JR6C8ZkvElhQkp0E6PZyvoyjcKTOLZUW1bc11dJDELQO0VhCuMd4nYdOdFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og0pZarg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og0pZarg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CE01F00893;
	Mon,  8 Jun 2026 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940032;
	bh=Saluy0BJuusVGzJ1sCQMNteNenfne0+ZHMmGt2sgyrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=og0pZarg3OXDbuhyGt9M6oSGHCMinMGWvsvs/+X+NDcRFBraCrUrYtQKwinN2nbUT
	 oy7BgTZYjGvhu+B+p0dnVR7ploKFrMqvWxrOMMHeL0IGEvbyI++Y9y6ctGtrupeH+T
	 UDXNz+tczoMlmE7DyvIjGG1W/s/Rnljx6SEYoT6LLpk3OtbOiSFMvoNVIeO4pu/odi
	 CLsaN5CslVmJP9A4PNSLBhtMCb7nwCt2uGNEUL75C8OzTPM8K521f64NJVHnFsdmbv
	 Ldys7iSpHE4Ui/wPsc/vtuzgGVtpNI+KNQiSuYLgsQ00hoVGlECkwBucUMs9o/UCer
	 LbmI/Z/3DdZ6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608-bootconfig_using_tools-v3-6-4ddd079a0696@debian.org>
References: <20260608-bootconfig_using_tools-v3-6-4ddd079a0696@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:33:51 +0000
Message-Id: <20260608173352.03CE01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The patch selects `ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG`, but thi=
s Kconfig symbol is not defined anywhere in the kernel.
- [High] Unconditionally prepending the embedded bootconfig in `setup_arch(=
)` breaks the precedence rule where an initrd bootconfig must completely ov=
erride and replace an embedded bootconfig.
- [High] Prepending embedded bootconfig keys in-place to `boot_command_line=
` can silently truncate user-supplied bootloader arguments.
- [High] The 'bootconfig' command line parameter is parsed differently by `=
setup_arch()` and `setup_boot_config()`, causing a split-brain state where =
`bootconfig=3D0` disables early parameter application but still enables lat=
e parameter application.
--

commit 3b4a5034917523d388052b505ac2245c0d663702
Author: Breno Leitao <leitao@debian.org>

x86/setup: prepend embedded bootconfig cmdline before parse_early_param

Call xbc_prepend_embedded_cmdline() in setup_arch() right after the
CONFIG_CMDLINE merge and before strscpy(command_line, ...) so the
build-time-rendered embedded bootconfig "kernel" subtree is part of
boot_command_line by the time parse_early_param() runs. early_param()
handlers (mem=3D, earlycon=3D, loglevel=3D, ...) now see values supplied via
CONFIG_BOOT_CONFIG_EMBED_FILE without parsing bootconfig at runtime.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0de23e6471973..8ab11199c16d5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -127,6 +127,7 @@ config X86
>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <=3D 4096
>  	select ARCH_SUPPORTS_CFI		if X86_64
> +	select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG

[Severity: High]
Does ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG exist?=20

This selects a Kconfig symbol that is not defined anywhere in the kernel. T=
his=20
is a Kconfig subsystem violation that can cause silent build failures or le=
ave=20
required features disabled because the selected symbol has no definition in=
 any=20
Kconfig file.

>  	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 46882ce79c3a4..003f8651db6c3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
[ ... ]
> @@ -924,6 +926,20 @@ void __init setup_arch(char **cmdline_p)
>  	builtin_cmdline_added =3D true;
>  #endif
> =20
> +	/*
> +	 * Match the runtime bootconfig parser's opt-in: only fold the
> +	 * embedded kernel.* keys into the cmdline when "bootconfig" is
> +	 * present on the command line, or CONFIG_BOOT_CONFIG_FORCE is set.
> +	 * setup_boot_config() bails out under the same condition, so the
> +	 * early prepend stays in lockstep with what the late runtime parser
> +	 * would have applied. CONFIG_BOOT_CONFIG_FORCE defaults to y when
> +	 * BOOT_CONFIG_EMBED is set, so on the default config the embedded
> +	 * keys are applied unconditionally.
> +	 */
> +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) ||
> +	    cmdline_find_option_bool(boot_command_line, "bootconfig"))

[Severity: High]
Could this result in a split-brain state for "bootconfig" parsing?

In setup_arch(), cmdline_find_option_bool("bootconfig") accurately rejects
boolean-false values like bootconfig=3D0 or bootconfig=3Doff.

However, in init/main.c:setup_boot_config(), the lax pre-existing parser us=
es=20
parse_args() which merely checks for the presence of the "bootconfig" key a=
nd
ignores its value.=20

Passing bootconfig=3D0 will therefore skip the early embedded parameter inj=
ection
here, but mistakenly apply the embedded bootconfig later at runtime, causin=
g an=20
inconsistent system state.

> +		xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);

[Severity: High]
Can this unconditionally prepend the embedded bootconfig, breaking the
precedence rule where an initrd bootconfig must completely override it?

The intended logic in init/main.c:setup_boot_config() allows an initrd=20
bootconfig to completely override the embedded one:

init/main.c:setup_boot_config() {
	if (!data) {
		data =3D xbc_get_embedded_bootconfig(&size);
		from_embedded =3D true;
	}
    ...
}

By prepending the embedded keys directly to boot_command_line early in=20
setup_arch(), these keys bypass the override check and are inevitably proce=
ssed=20
by parse_early_param(). This permanently leaks the embedded keys into the b=
oot=20
parameters, causing conflicting or unwanted early parameters to be applied =
even=20
when a valid initrd bootconfig is present.

[Severity: High]
Will prepending embedded bootconfig keys in-place to boot_command_line=20
silently truncate user-supplied bootloader arguments?

boot_command_line is a fixed-size buffer bounded by COMMAND_LINE_SIZE. When=
=20
xbc_prepend_embedded_cmdline() prepends the embedded bootconfig string, it =
must=20
push the existing content to the right.=20

If the combined length exceeds the buffer, the tail-end arguments=20
(such as root=3D or init=3D) will be silently truncated, resulting in a ker=
nel panic=20
on boot.

> =20
>  	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p =3D command_line;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-bootconfig=
_using_tools-v3-0-4ddd079a0696@debian.org?part=3D6
