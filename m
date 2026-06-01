Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEA313283;
	Mon,  1 Jun 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336368; cv=none; b=giPFhsfde9oIHIoE4+zjTr/hiS7TJTbFgy5yPKBC/+gV2cpkt/AsANHuRGFMOnEqBItwArgV1fxjSv2vBh9e5wPi7uTOoj/KAYtq2qSZP0MKYxct6C3ajJTh+I1xDDPGzNaEaKNKRKzB1A9hGVKcz/Sgmi19FFjYqAuUixbTKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336368; c=relaxed/simple;
	bh=tkclujgvHkYLTuO23cI6OpVItwnSDjP748IA7FR1ERo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW/4fSwNPOR2r51PtkBndgjewWHljpQAqkVrJFyCuPStc2VICutD4BshC7mtcFpu1xnBTyPDdBqliwyk4JGtLOiPbIQ6LJExvvaEy4x5AS0qSL2Y44ceixLBsNq4Gybzxck2mP55JTHmETV+WYxI3V72wj4JfvIy3yKtOoeg39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D0ocUtQl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D0ocUtQl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zgc4xwnN5oQSA/IeHBtgQm+WBaU/mDcm7IEsfaNf1r8=; b=D0ocUtQltt2fs79KCi4eeQv1rT
	9XkjBRMCAHhgNqX1Bz7zq7/D5X4AOb6sbMA1Vq904svCjDZAbKUGchkOxdawP/F6eQWjIBuaUQAfR
	zUToLDEvTlWbY5N1Ite1hhnzL76m5O/hZvZuRqEVTBiwdV1LBK5PWmt1OoiRrnPsj441iIj6bblnA
	K/WFVA+R18pc7EQ4GMBtm2hYr0ScRkSZclrOXHR44RnEwVRz64OA+Gioyix4kxCQYr6xB9XK+Kpf0
	cXUFB7txWAMy9mUGOlZq5q28IpfqGFT321nynm6NRugDawrRQEw+e85DFLPHbbT8Of62FMs6sWmNu
	xU2448xA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wU6of-002LjO-0i;
	Mon, 01 Jun 2026 17:52:45 +0000
Date: Mon, 1 Jun 2026 10:52:41 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] bootconfig: render embedded bootconfig as a kernel
 cmdline at build time
Message-ID: <ah3Fzof8H3vAvLwQ@gmail.com>
References: <20260527-bootconfig_using_tools-v1-2-b6906a86e7d5@debian.org>
 <20260527173037.5C9061F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527173037.5C9061F00A3D@smtp.kernel.org>
X-Debian-User: leitao

On Wed, May 27, 2026 at 05:30:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The `tools/bootconfig` executable is built using the target architecture's compiler instead of the host architecture's compiler, causing an `Exec format error` during cross-compilation.
> - [Medium] The read-only data section `.init.rodata` is incorrectly marked as writable (`"aw"`).
> - [Medium] Missing 'clean' target hook for tools/bootconfig in the top-level Makefile.
> 
> Pre-existing issues:
> - [High] Pointer arithmetic on a NULL pointer and passing an invalid pointer to `snprintf()` in `xbc_snprint_cmdline()`.
> --
> 
> commit d68de9beacfcd22ccb081a670940139845227254
> Author: Breno Leitao <leitao@debian.org>
> 
> bootconfig: render embedded bootconfig as a kernel cmdline at build time
> 
> Add the build-time pipeline that renders the "kernel" subtree of
> CONFIG_BOOT_CONFIG_EMBED_FILE into a flat cmdline string and stashes
> it in .init.rodata as embedded_kernel_cmdline[].
> 
> > diff --git a/Makefile b/Makefile
> > index d59f703f9797a..3ee259d00a9ae 100644
> > --- a/Makefile
> > +++ b/Makefile
> [ ... ]
> > @@ -1543,6 +1543,11 @@ prepare: tools/bpf/resolve_btfids
> >  endif
> >  endif
> >  
> > +# lib/Makefile invokes tools/bootconfig to render the embedded bconf to cmdline.
> > +ifdef CONFIG_BOOT_CONFIG_EMBED_CMDLINE
> > +prepare: tools/bootconfig
> > +endif
> 
> [Severity: Medium]
> Will this leave stale build artifacts behind? Since tools/bootconfig is
> wired into the prepare phase, should there also be a corresponding cleanup
> step added to the top-level clean target so that make clean removes the
> compiled binary and object files?

Correct, and this is the important one. lib/Makefile runs the binary on
the build host, so it must be built with the host compiler. Plain $(CC)
is the target cross-compiler under an ARCH=... build, so the tool comes
out as a target binary and fails to exec. I'll build it with $(HOSTCC),
matching how tools/objtool and tools/bpf/resolve_btfids do it
(HOST_OVERRIDES := CC="$(HOSTCC)" ...). This also fixes a standalone
cross-build of the tool.

> > diff --git a/lib/Makefile b/lib/Makefile
> > index 6e72d2c1cce71..9de0ac7732a21 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> [ ... ]
> > +quiet_cmd_render_cmdline = BCONF2C $@
> > +      cmd_render_cmdline = \
> > +	$(objtree)/tools/bootconfig/bootconfig -C $< > $@
> > +
> > +targets += embedded_cmdline.bin
> > +$(obj)/embedded_cmdline.bin: $(obj)/default.bconf $(objtree)/tools/bootconfig/bootconfig FORCE
> > +	$(call if_changed,render_cmdline)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but running bootconfig -C at
> build time exposes an issue in xbc_snprint_cmdline().

I will fix it in a different patch.

> 
> When calculating the required buffer size, xbc_snprint_cmdline() is initially
> called with buf = NULL and size = 0. The first snprintf(NULL, 0, ...)
> returns the number of bytes that would be written, and the code then executes
> buf += ret. Doing pointer arithmetic on a NULL pointer is undefined behavior.
> 
> In the next loop iteration, this invalid pointer is passed as the first
> argument to snprintf(), which can trigger host UBSan failures or
> FORTIFY_SOURCE aborts during the kernel build.
> 
> > diff --git a/lib/embedded-cmdline.S b/lib/embedded-cmdline.S
> > new file mode 100644
> > index 0000000000000..7e2e1d81af962
> > --- /dev/null
> > +++ b/lib/embedded-cmdline.S
> > @@ -0,0 +1,16 @@
> [ ... ]
> > +	.section .init.rodata, "aw"
> 
> [Severity: Medium]
> Does this mistakenly mark the read-only section as writable?
> 
> The "w" flag instructs the assembler and linker to make the section writable,
> violating the expectation for .rodata and potentially bypassing memory
> protections. Should this use "a" or the __INITRODATA macro instead?

Agreed -- the "w" flag has no business on rodata. I'll drop it to "a"
(read-only, allocatable) in lib/embedded-cmdline.S.

> 
> > diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> > index 90eb47c9d8de6..4e82fd9553cde 100644
> > --- a/tools/bootconfig/Makefile
> > +++ b/tools/bootconfig/Makefile
> [ ... ]
> > -all: $(ALL_PROGRAMS) test
> > +all: $(ALL_PROGRAMS)
> >  
> >  $(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
> >  	$(CC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@
> 
> [Severity: High]
> When cross-compiling the kernel, does this build bootconfig for the
> target architecture instead of the host?

> 
> Kbuild exports CC as the target cross-compiler (e.g., aarch64-linux-gnu-gcc).
> Because this uses $(CC) rather than a host override like $(HOSTCC) (which
> objtool and resolve_btfids use), the tool is built for the target architecture.
> 
> Later, lib/Makefile attempts to execute this tool on the build host to render
> the cmdline, which will fail with an Exec format error.

Correct, and this is the important one. lib/Makefile runs the binary on
the build host, so it must be built with the host compiler. Plain $(CC)
is the target cross-compiler under an ARCH=... build, so the tool comes
out as a target binary and fails to exec. I'll build it with $(HOSTCC),
matching how tools/objtool and tools/bpf/resolve_btfids do it
(HOST_OVERRIDES := CC="$(HOSTCC)" ...). This also fixes a standalone
cross-build of the tool.
