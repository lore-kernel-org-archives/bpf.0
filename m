Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1273EE1D4
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903039; cv=none; b=mqVQfx6oVBYT1AHREIo2ZzynMe67ZM3SFWM4UtADYmg88J8Z3nbZvdF+jjXGBOG2W52//WqBQDuctsFMoCydD2fldiV1Qz9n4PYgPF2BASlvDLMjkdMhXpIlp3hdWt8f+YDXmC8kOY+DltORWYlRqdQtrRiE/zTv1R5VOwNiG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903039; c=relaxed/simple;
	bh=JdvDVxd8zroF8iNbI4SmPcN6AltT07FJYHnx7jVIP3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGuE+MZTGosOxVYEIFoLkMwQV13nqMaQvN7SH9DFM8NbMjkgLPWIddbAK6nJyx5Q59N8OGQzi+tOdCIVc/9QDNMZMANlus3doePJVT75jjppjqfo8C0vAdWxW+mzWtKKsY83B4oS5mXqO4oIVClYIi7lXaKx3B9dYyDtHwaFuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4DMfboL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4DMfboL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9061F00A3D;
	Wed, 27 May 2026 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903037;
	bh=+fpm2MpwyYBWmMD40Ka/wQN6bQDVm8FEh2ccGZ2mXpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4DMfboLDMd5V24SCwG8D62ejF1WM9DpN9Iwsmuui5x3kbHGWjRK2pTtHM8HFB7qR
	 76/n3M+0D3p61PMxGtMmz9JNuBZxPGt/ztGUuqYpxIuiFroKiUWWpVo0PWhhJDyXAg
	 giVc59JDvn2TCOQ8brGODMTv9zjMuTLmjXINckRpzLV1doNecOLOEyGvQLiY6yZqyG
	 Up9Qn++1R05vHe0wS+C232FI+/Xp6vOyVtI5VIWHsbmo1fpE4O51eY8CHWh5G1nITH
	 HPLCXhG9qD3w1VyxulcOMP6HEGv9wfEvRj9spSuB8m/XEKf8O7lDuqhO5lwPGnSyv9
	 T+jaeYcy3BZeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] bootconfig: render embedded bootconfig as a kernel
 cmdline at build time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-bootconfig_using_tools-v1-2-b6906a86e7d5@debian.org>
References: <20260527-bootconfig_using_tools-v1-2-b6906a86e7d5@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 17:30:36 +0000
Message-Id: <20260527173037.5C9061F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `tools/bootconfig` executable is built using the target archit=
ecture's compiler instead of the host architecture's compiler, causing an `=
Exec format error` during cross-compilation.
- [Medium] The read-only data section `.init.rodata` is incorrectly marked =
as writable (`"aw"`).
- [Medium] Missing 'clean' target hook for tools/bootconfig in the top-leve=
l Makefile.

Pre-existing issues:
- [High] Pointer arithmetic on a NULL pointer and passing an invalid pointe=
r to `snprintf()` in `xbc_snprint_cmdline()`.
--

commit d68de9beacfcd22ccb081a670940139845227254
Author: Breno Leitao <leitao@debian.org>

bootconfig: render embedded bootconfig as a kernel cmdline at build time

Add the build-time pipeline that renders the "kernel" subtree of
CONFIG_BOOT_CONFIG_EMBED_FILE into a flat cmdline string and stashes
it in .init.rodata as embedded_kernel_cmdline[].

> diff --git a/Makefile b/Makefile
> index d59f703f9797a..3ee259d00a9ae 100644
> --- a/Makefile
> +++ b/Makefile
[ ... ]
> @@ -1543,6 +1543,11 @@ prepare: tools/bpf/resolve_btfids
>  endif
>  endif
> =20
> +# lib/Makefile invokes tools/bootconfig to render the embedded bconf to =
cmdline.
> +ifdef CONFIG_BOOT_CONFIG_EMBED_CMDLINE
> +prepare: tools/bootconfig
> +endif

[Severity: Medium]
Will this leave stale build artifacts behind? Since tools/bootconfig is
wired into the prepare phase, should there also be a corresponding cleanup
step added to the top-level clean target so that make clean removes the
compiled binary and object files?

> diff --git a/lib/Makefile b/lib/Makefile
> index 6e72d2c1cce71..9de0ac7732a21 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
[ ... ]
> +quiet_cmd_render_cmdline =3D BCONF2C $@
> +      cmd_render_cmdline =3D \
> +	$(objtree)/tools/bootconfig/bootconfig -C $< > $@
> +
> +targets +=3D embedded_cmdline.bin
> +$(obj)/embedded_cmdline.bin: $(obj)/default.bconf $(objtree)/tools/bootc=
onfig/bootconfig FORCE
> +	$(call if_changed,render_cmdline)

[Severity: High]
This isn't a bug introduced by this patch, but running bootconfig -C at
build time exposes an issue in xbc_snprint_cmdline().

When calculating the required buffer size, xbc_snprint_cmdline() is initial=
ly
called with buf =3D NULL and size =3D 0. The first snprintf(NULL, 0, ...)
returns the number of bytes that would be written, and the code then execut=
es
buf +=3D ret. Doing pointer arithmetic on a NULL pointer is undefined behav=
ior.

In the next loop iteration, this invalid pointer is passed as the first
argument to snprintf(), which can trigger host UBSan failures or
FORTIFY_SOURCE aborts during the kernel build.

> diff --git a/lib/embedded-cmdline.S b/lib/embedded-cmdline.S
> new file mode 100644
> index 0000000000000..7e2e1d81af962
> --- /dev/null
> +++ b/lib/embedded-cmdline.S
> @@ -0,0 +1,16 @@
[ ... ]
> +	.section .init.rodata, "aw"

[Severity: Medium]
Does this mistakenly mark the read-only section as writable?

The "w" flag instructs the assembler and linker to make the section writabl=
e,
violating the expectation for .rodata and potentially bypassing memory
protections. Should this use "a" or the __INITRODATA macro instead?

> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index 90eb47c9d8de6..4e82fd9553cde 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
[ ... ]
> -all: $(ALL_PROGRAMS) test
> +all: $(ALL_PROGRAMS)
> =20
>  $(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
>  	$(CC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@

[Severity: High]
When cross-compiling the kernel, does this build bootconfig for the
target architecture instead of the host?

Kbuild exports CC as the target cross-compiler (e.g., aarch64-linux-gnu-gcc=
).
Because this uses $(CC) rather than a host override like $(HOSTCC) (which
objtool and resolve_btfids use), the tool is built for the target architect=
ure.

Later, lib/Makefile attempts to execute this tool on the build host to rend=
er
the cmdline, which will fail with an Exec format error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-bootconfig=
_using_tools-v1-0-b6906a86e7d5@debian.org?part=3D2
