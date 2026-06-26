Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FF2C11D5
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479064; cv=none; b=hNBIEeUu7z4VcibMbfXDWF3ZJlq8eQ7r5fxYLPRDYOWgHT4dK06pENa1L4EGwH3/a4Rmbp6HLwLNoPIEp/HV9VpGgQU+Tor1aC1spXfp7puioanowDudQsOnTlGFKmIZIrstlXkLYBKNYcHzkjqGPgyz1UY9j7ItyOdi8Khh7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479064; c=relaxed/simple;
	bh=4WdUm4u31sk/N0AmJt0QHMEAv+eaCxffsAiFyDZsChg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o8NlMtme9fBJ6Vp6qX91r3vDYiyas2M4sgkSSWMYCs7+1xlPYoO6zo3SPWI+kmhTCeFK9o2yjvIRg13Mk7dc/q/xyHQ6p6VKdVdISmRaF2D0frWW4xtyVVaMbTFywhARiV0vtqC8ixyBghAGgmOryWavE4LImjQ+9uQzZSvixGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9uatuh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9uatuh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7CC1F000E9;
	Fri, 26 Jun 2026 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782479063;
	bh=Y2qABWnvBmEShbh8x7Emy3GlC6lV6ihjtDdn/1mcJpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9uatuh+43Bmx0HUJ9G/q71Gn7QDcL4g49xub6yNhboufCyKHmk9tGBBvmS/aE3/N
	 I8r99WyriUP6j811NMEIsxqAORHv299WGSyWBnTxoc7s7K3Kg3KlMym7dz9Se09/wJ
	 rht+JsSgoENPDdskfRpe+UHO0TIeFBD+cNIEAeBG7ptTNr0ZSDtsL1242IInf73eJ3
	 pYdjwzcdspe+/hdWCasYLD5uqRipNgwh4SWKCtqcB6zcKBFpd/uCJjDcGa32vy0xrO
	 etU/W7PS7AKWzxXSQQe2UcQD7OHUyjfvYjHY2ek0/PMTmfAhnVb0xLLlY0PIleGBZK
	 pjtdqpFDTserg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-bootconfig_using_tools-v7-3-24ab72139c29@debian.org>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
 <20260626-bootconfig_using_tools-v7-3-24ab72139c29@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:04:22 +0000
Message-Id: <20260626130423.2A7CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The host-built tools/bootconfig binary shares the same output direc=
tory as the target-built tool, causing an 'Exec format error' when intermix=
ing builds.
--

commit c67f0035f4bd8f4051e26e40c1dccfbeef9c755f
Author: Breno Leitao <leitao@debian.org>

bootconfig: render embedded bootconfig as a kernel cmdline at build time

This commit adds a build-time pipeline to render the embedded bootconfig
kernel subtree into a flat command line string. It wires up the userspace
bootconfig tool to run during the prepare phase on the host to generate
this string.

> diff --git a/Makefile b/Makefile
> index 12fd3d2d47b58..2bb1b44256b5f 100644
> --- a/Makefile
> +++ b/Makefile

[ ... ]

> @@ -1552,6 +1552,22 @@ prepare: tools/bpf/resolve_btfids
>  endif
>  endif
> =20
> +# tools/bootconfig renders the embedded bootconfig into a cmdline at bui=
ld time.
> +ifdef CONFIG_CMDLINE_FROM_BOOTCONFIG
> +prepare: tools/bootconfig
> +endif
> +
> +# tools/bootconfig is run on the build host during prepare, so force a h=
ost
> +# binary here; its own Makefile keeps $(CC) for standalone and cross bui=
lds.
> +# CROSS_COMPILE=3D is cleared so tools/scripts/Makefile.include does not=
 inject
> +# the target's --target=3D/--sysroot=3D flags into the host clang invoca=
tion under
> +# LLVM=3D1 cross builds (which would produce a target binary that fails =
to exec).
> +tools/bootconfig: export CC :=3D $(HOSTCC)
> +tools/bootconfig: FORCE
> +	$(Q)mkdir -p $(objtree)/tools
> +	$(Q)$(MAKE) O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/tool=
s/ \
> +		bootconfig CROSS_COMPILE=3D

[Severity: Low]
Will this cause a build failure if the tool is cross-compiled for the target
before the kernel is built?

Since the tool shares the same output directory for both target and host bu=
ilds,
and its Makefile does not use dependency tracking files to detect compiler
changes, is it possible make will consider a previously cross-compiled bina=
ry
to be up to date and skip rebuilding it with the host compiler?

> diff --git a/lib/Makefile b/lib/Makefile
> index 7f75cc6edf94a..4ccdce2fd5e5b 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile

[ ... ]

> @@ -273,6 +273,22 @@ filechk_defbconf =3D cat $(or $(real-prereqs), /dev/=
null)
>  $(obj)/default.bconf: $(CONFIG_BOOT_CONFIG_EMBED_FILE) FORCE
>  	$(call filechk,defbconf)
> =20
> +obj-$(CONFIG_CMDLINE_FROM_BOOTCONFIG) +=3D embedded-cmdline.o
> +$(obj)/embedded-cmdline.o: $(obj)/embedded_cmdline.bin
> +
> +# Render the bootconfig "kernel" subtree to a flat cmdline string using
> +# the userspace tools/bootconfig parser (-C mode). The runtime prepend
> +# helper enforces COMMAND_LINE_SIZE at boot, so no build-time size
> +# check is performed here (COMMAND_LINE_SIZE is an arch header
> +# constant, not a Kconfig value).
> +quiet_cmd_render_cmdline =3D BCONF2C $@
> +      cmd_render_cmdline =3D \
> +	$(objtree)/tools/bootconfig/bootconfig -C $< > $@

[Severity: Low]
If the prepare phase skips rebuilding the tool because a cross-compiled
version already exists, will this execution fail with an Exec format error
when it attempts to run a target architecture binary on the build host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-bootconfig=
_using_tools-v7-0-24ab72139c29@debian.org?part=3D3
