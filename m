Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556F326942
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937522; cv=none; b=WWeA4dMlHJ65IGLtndABXPl+nk3QBi16LSq7K6p7M8hhxbVLJfiv/L4pH0xZ+s4GMQqFS/VZStuhWxE529EB4qKmZHBxY+Z/1Femk5ZDP75fQ8GDbpcUu6gqxZnWj3updGj6cmyQeZsKJJztkd55tjiYr8u6+iUdpO5CQ6EJtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937522; c=relaxed/simple;
	bh=OSyPv8MKRhLMHXi7b3pNpLECZnq4VhsexcvWsxXfSYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htmoHHRMCY1I4we1IACEe/fAJNKR7MHy6B7SIo7frme/i5bKBvt5ty/6vssMpDaNF2m6AazWoC3x1RlsGfdzcnzC4y95rmlbm+unRxUEOTp6qIJQTBI05Ycxi2l8rz1zcoVnY76CrD+Syn7xzgrqahY/PDNbSWvhFtCGF8SAVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtBfwzj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtBfwzj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2111F00893;
	Mon,  8 Jun 2026 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937521;
	bh=p59nL6WsMTcj2voephxY7wHR4jdACb8iX9EhIOkZPFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtBfwzj0VNNkKZTYmDH97PvOW+4yp8LM6XOSzY3u+nxS2IgHSND+fYxHS8qXvFyC7
	 PfhPx49s5qfAqr56m6PtIq+JDLgj/sVX+ZDZ5CCziYQflWBgdf92q3+5An85gta8xr
	 kGAcjGrKxzpFyErjiNBBb9hIvtznJgpaTBOklr8ZYD3VkxHwCdOWG6QFElzd2mGqmV
	 JSeqwE1QvWzXP65DnGNU6tjr2N0L+dBqj1Y285bJNMZ+UNY9/NSqwTpD5bb2M/pLD+
	 ZTpyCp7jQiSa2iRx6AT+2EwZmdUaisvn2B+1pHgXcYrsCyM4M3TPjw3lmPcbkXM5iD
	 beuvd1uV4wqYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608-bootconfig_using_tools-v3-3-4ddd079a0696@debian.org>
References: <20260608-bootconfig_using_tools-v3-3-4ddd079a0696@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:52:00 +0000
Message-Id: <20260608165201.7E2111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Cross-compiling the kernel with LLVM/Clang will fail with an "Exec =
format error" when building `embedded_cmdline.bin`.
- [Low] Mixing different access flags (`"aw"` vs `"a"`) for the same `.init=
.rodata` section causes a fatal section type mismatch error with `ld.lld`.
--

commit 53ecb8492a80850833ff3357341fcf9ac0a1298e
Author: Breno Leitao <leitao@debian.org>

bootconfig: render embedded bootconfig as a kernel cmdline at build time

Add the build-time pipeline that renders the "kernel" subtree of
CONFIG_BOOT_CONFIG_EMBED_FILE into a flat cmdline string. This involves
adding tools/bootconfig to the make prepare step and adding
lib/embedded-cmdline.S to embed the rendered text.

> diff --git a/Makefile b/Makefile
> index bf196c6df5b92..a7572703f9ce8 100644
> --- a/Makefile
> +++ b/Makefile
[ ... ]
> @@ -1545,6 +1545,17 @@ prepare: tools/bpf/resolve_btfids
>  endif
>  endif
> =20
> +# tools/bootconfig renders the embedded bootconfig into a cmdline at bui=
ld time.
> +ifdef CONFIG_BOOT_CONFIG_EMBED_CMDLINE
> +prepare: tools/bootconfig
> +endif
> +
> +# tools/bootconfig is run on the build host during prepare, so force a h=
ost
> +# binary here; its own Makefile keeps $(CC) for standalone and cross bui=
lds.
> +tools/bootconfig: FORCE
> +	$(Q)mkdir -p $(objtree)/tools
> +	$(Q)$(MAKE) O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/tool=
s/ bootconfig CC=3D$(HOSTCC)

[Severity: Low]
When cross-compiling with Clang (e.g., LLVM=3D1 CROSS_COMPILE=3Daarch64-lin=
ux-gnu-),
will this build the tool as a host binary?

Since CROSS_COMPILE isn't unset and CFLAGS aren't overridden with host flag=
s,
it appears tools/scripts/Makefile.include will still append target flags li=
ke
--target=3D$(CLANG_TARGET). This can result in the tool being erroneously
compiled as a target-architecture binary.

> diff --git a/lib/Makefile b/lib/Makefile
> index 7f75cc6edf94a..4ace86a5cb6de 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
[ ... ]
> @@ -273,6 +273,22 @@ filechk_defbconf =3D cat $(or $(real-prereqs), /dev/=
null)
>  $(obj)/default.bconf: $(CONFIG_BOOT_CONFIG_EMBED_FILE) FORCE
>  	$(call filechk,defbconf)
> =20
> +obj-$(CONFIG_BOOT_CONFIG_EMBED_CMDLINE) +=3D embedded-cmdline.o
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
If the bootconfig tool was accidentally cross-compiled due to target flags
bleeding into the host build above, could executing it here on the build
host fail with an Exec format error?

> diff --git a/lib/embedded-cmdline.S b/lib/embedded-cmdline.S
> new file mode 100644
> index 0000000000000..740d7ad2dc016
> --- /dev/null
> +++ b/lib/embedded-cmdline.S
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Embed the build-time-rendered bootconfig "kernel" subtree as a flat
> + * cmdline string. setup_arch() prepends this to boot_command_line on
> + * architectures that select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG.
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
> + * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
> + */
> +	.section .init.rodata, "a", %progbits

[Severity: Low]
Does this cause a section type mismatch with the existing bootconfig data?

The existing lib/bootconfig-data.S places embedded bootconfig data into
.section .init.rodata, "aw" (allocatable and writable). When both files are
compiled together, modern linkers like ld.lld enforce section attributes
and will fail the build if the same section name mixes writable ("aw") and
read-only ("a") flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-bootconfig=
_using_tools-v3-0-4ddd079a0696@debian.org?part=3D3
