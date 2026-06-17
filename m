Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE72E7387
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696223; cv=none; b=dUN/+xnWO/BG8YtQpmU99eRhlGm2iQ0osR9oefAYFkc6PeLZxB7Pt6F2/mq+a6dPrklhezd9SwDYCFNi9QJoe5zytFl1W+HqSVgXRV2YUCxx491SlZBBhhc6C8RTh9Uc5w2qiEyBrMNgqFVSdINwLVuILTLBGSaIlMhhEA0403w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696223; c=relaxed/simple;
	bh=vM57EpACC57135Yr/ck0hQzPX07gdvcNqEMLL/e10pY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dI5O8Bm2c3V3GINOJ2eNlZMHrmcDopJteqtgiHaEOIHAWtU6ZJJ2K0zM3z4IxJ8EdD+vZ30cylYz3Zve11J9O0EYv8Q+DsCSkbrNNHPE+CYhyFusoZBJ8KHfdZHXKLGToqY7kHtNoyEIGItLpO4mHzuA9k34eem2z9SY41PQ9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6SUcXma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6SUcXma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0405E1F000E9;
	Wed, 17 Jun 2026 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781696221;
	bh=NXk+cqdl10TNHJ4/NMES+pKfgsBtH1OPgy13nH1tLoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L6SUcXmacuU5mZO4acO6Cfj4UKsCadapGQH/cve/EAcwNmIwUu37yMR8RavUDTeqS
	 rLux10fH4RvDpwK/o4U2mjU+15jn/Ny7nLH+r67nvfd6OO4CxsiY3tgpuUfaaLgA3g
	 CZwSEbnmX/468eoL2MttNW26ULDpgyGw09JnI6QpA4rT+5Qdcx9Sz0NAFeNDnbKzOn
	 RCC2QH5hy3EVUlNMtuXDAR65a2lPbsZPhfRAew0ugqXiH//LJ+pRYcc6WwTiWlpd9h
	 4LjwSwdAUkwvvpRT7HDfaSzzE1eavxZKx9MgvTbe6nZ0biKZXMo3RR0b/OlrQ2dVWF
	 rA+XcILiLoVXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260617-bootconfig_using_tools-v5-3-fd589a9cc5e3@debian.org>
References: <20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org>
 <20260617-bootconfig_using_tools-v5-3-fd589a9cc5e3@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:37:00 +0000
Message-Id: <20260617113701.0405E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unquoted `CC=3D$(HOSTCC)` in the top-level Makefile breaks the buil=
d when `HOSTCC` contains spaces (e.g., `HOSTCC=3D"ccache gcc"`).
--

commit 9679f5db7f804f330ff90fdcd19d5b8a66732ef3
Author: Breno Leitao <leitao@debian.org>

bootconfig: render embedded bootconfig as a kernel cmdline at build time

This commit adds a build-time pipeline that renders the "kernel" subtree of
CONFIG_BOOT_CONFIG_EMBED_FILE into a flat cmdline string. It wires up
tools/bootconfig in the Makefile's prepare target to generate the
embedded_kernel_cmdline array.

> diff --git a/Makefile b/Makefile
> index 7a9385dab39ab..6cb2bec7bfe78 100644
> --- a/Makefile
> +++ b/Makefile

[ ... ]

> @@ -1549,6 +1549,21 @@ prepare: tools/bpf/resolve_btfids
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
> +# CROSS_COMPILE=3D is cleared so tools/scripts/Makefile.include does not=
 inject
> +# the target's --target=3D/--sysroot=3D flags into the host clang invoca=
tion under
> +# LLVM=3D1 cross builds (which would produce a target binary that fails =
to exec).
> +tools/bootconfig: FORCE
> +	$(Q)mkdir -p $(objtree)/tools
> +	$(Q)$(MAKE) O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/tool=
s/ \
> +		bootconfig CC=3D$(HOSTCC) CROSS_COMPILE=3D

[Severity: Low]
Will this break the build if HOSTCC contains spaces, such as when using a
compiler cache wrapper like HOSTCC=3D"ccache gcc"?

If $(HOSTCC) is unquoted, Make might interpret the space-separated words as
separate command-line arguments to the sub-make. This could result in the
sub-make setting CC=3Dccache and attempting to build a target named 'gcc'.

Could we quote the variable like CC=3D"$(HOSTCC)" to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-bootconfig=
_using_tools-v5-0-fd589a9cc5e3@debian.org?part=3D3
