Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22232C11DE;
	Tue, 10 Feb 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749436; cv=none; b=cifv1JKkQ+hAIlUFxQ02p3SVRKyUmJMnC8YOCHJu0NSW55aVp8XCRR0nKL+gBur+t0eQ0oRar8fdrxd6BT2R+ztYE6Tt9TPDWA91jMePtqdnpcLf3tabUoMIKl6os10wrQbAbvawNGjD7tq54CS7xln5xLTlhDxAn4wiSjM5QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749436; c=relaxed/simple;
	bh=zDR5srkIDvMFQqCdbq54Pzg7cM9Na16eVLnG0oEimSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgGVR9OuVNWb+4MQ5ApUHIkju9TzidCCnrKLmr7WoXlImjoQVeVO6MOfPned9t9XKNGjqch3hjzGGwJ6hqolYzX9j2V2NKGIFfrKEn6UDiB3JsSKmXb/YrD8m4KE4OB87m1KuX8Z2b4QY2P31XSWQIMMu6HkUa7en8SnoyBgUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMfeJjuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMfeJjuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D3FC116C6;
	Tue, 10 Feb 2026 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770749436;
	bh=zDR5srkIDvMFQqCdbq54Pzg7cM9Na16eVLnG0oEimSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMfeJjuUKyBZGySKT7tLqVzR6K1Ih8oiEl/Qo7Emb05MV6gS/YeZrRAw3aYLSaE3e
	 cZ8Hzzzk+X3AeH7uL/AS97Cxqpibu3bLYVeht9GcEkFC6mXDOzQznNng5OBhiAwCFn
	 owIlNyTqXsMZpC/eVT9g+oMzRiwErwRzfaYz2gw8uZzwxV9kckpzcXuE/BAPgHNdDB
	 Ir1Hk9k7jF95XibMoKoUaPNiUpTHjyXRE94lIDl2fKdhdw6dubGaN8bQri/Gdr673r
	 baQU/BUYLV9XEi4lAVqgWzgv0uSRJO/1cHNAq4bgH9nWRugfIqM+43oKnZrmTIdTF1
	 MXvPshvDMz06g==
Date: Tue, 10 Feb 2026 10:50:33 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v8 6/6] x86/vdso: Enable sframe generation in VDSO
Message-ID: <p24gmtzkxrybebcmn4bsw5puqzjebcy2neetotib6g3pixnj7w@x44ke24v5sjs>
References: <20260206193642.1580787-1-jremus@linux.ibm.com>
 <20260206193642.1580787-7-jremus@linux.ibm.com>
 <15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com>

On Tue, Feb 10, 2026 at 05:46:33PM +0100, Jens Remus wrote:
> On 2/6/2026 8:36 PM, Jens Remus wrote:
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Enable sframe generation in the VDSO library so kernel and user space
> > can unwind through it.
> > 
> > SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
> > those VDSOs.
> > 
> > [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
> > table entry to empty .sframe section. ]
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> 
> > @@ -479,6 +479,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
> >  	  It uses the same command line parameters, and sysctl interface,
> >  	  as the generic hardlockup detectors.
> >  
> > +config AS_SFRAME
> > +	bool
> > +
> > +config AS_SFRAME3
> > +	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,-Wa$(comma)--gsframe-3)
> 
> Above tests whether the assembler supports --gsframe-3 to generate
> .sframe in SFrame V3 format.  GNU assembler only supports to generate
> SFrame for x86-64.  If the assembler is built for i386 (x86-32) the test
> will fail unless option --64 is specified.  I wonder whether that could
> happen in (the rather hypothetical?) case, when the kernel is cross built
> for x86-64 on i386?  Should this therefore be changed to the following?
> 
> config AS_SFRAME_64
> 	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,$(m64-flag) -Wa$(comma)--gsframe)
> 
> An alternative would be to enable as-instr64 to accept an optional flag
> operand, similar to as-instr, and use as-instr64 instead of as-instr.
> 
> Or is this not required, as in a cross build for 64-bit on a 32-bit
> platform (or inverse) a respective cross toolchain is a prerequisite and
> the m64-flag (or m32-flag) is not used?
> 
> I tried to simulate this using docker and an i386 image and then using
> the i386 tool in the container to switch "uname -m" to "i686".  But both
> of my following attempts to build for x86-64 on i386 fail with fixdep
> not found:
> 
> $ docker run -it --rm -v "$HOME/linux:$HOME/linux" --platform i386 public.ecr.aws/docker/library/debian:13.3
> # sed -i -s 's/^Types: deb/& deb-src/' /etc/apt/sources.list.d/debian.sources
> # apt update
> # apt -y build-dep linux
> 
> # make mrproper
> # i386 make ARCH=x86_64 defconfig
> # i386 make ARCH=x86_64 arch/x86/entry/vdso/
> 
> # make mrproper
> # apt -y install gcc-x86-64-linux-gnu
> # i386 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- defconfig
> # i386 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- arch/x86/entry/vdso/

Hm, I think I broke that with

  a808a2b35f66 ("tools build: Fix fixdep dependencies")

... though it's been broken almost a year, maybe nobody cares.

Regardless, we do need to fix "make clean" and "make mrproper" for
objtool, which would be something like so:

diff --git a/Makefile b/Makefile
index d3a8482bdbd0..ed850044491d 100644
--- a/Makefile
+++ b/Makefile
@@ -1474,6 +1474,15 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
+PHONY += objtool_clean
+
+objtool_O = $(abspath $(objtree))/tools/objtool
+
+objtool_clean:
+ifneq ($(wildcard $(objtool_O)),)
+	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) clean
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
@@ -1637,7 +1646,7 @@ vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
 	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
-clean: archclean vmlinuxclean resolve_btfids_clean
+clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean
 
 # mrproper - Delete all generated files, including .config
 #
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index a40f30232929..6964175abdfd 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -29,6 +29,8 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
+RM ?= rm -f
+
 LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
