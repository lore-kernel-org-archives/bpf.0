Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1193F8248;
	Fri, 26 Jun 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484415; cv=none; b=pmGevf6srCDO+moS0bA68TaPwJqIKvYJHeAvQ05xQt6hHAUXnd7BgF1p7++jV+schxxgvkfHKTE7S0tsUmXr+bvaWPi6EZ+bjs6OrgP2KZ2s9atBfoq+xUs34iiRffmPjHW4wH4gzFFm7DiKCi29jRw+MEtgVNAlQAVYfIGuFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484415; c=relaxed/simple;
	bh=CA/9cuc4Xw92T+X815sAqsIVvXRLhqZME88G48Ncrg0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IZIgAHr5oRrG+Zf00fn4Z5efH9iDj6TAFJSe1uKmEDUOsEOlsvrgpu5L31Zm+dC3dkMdM1+oAqBF2lUuEsvdvIWsLMtY4iEx366igriDe76IvnkubeT81L6Em6i1pul/UGp+YBca12xzufIAvYen7htJbImGYAr6kdUcVVVMe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBwb7/ay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBwb7/ay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0731A1F000E9;
	Fri, 26 Jun 2026 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782484413;
	bh=/h6LR3ABkatbN/GtG7FgNY6HuHtEJ4oLgCHTfcl5Ty4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PBwb7/ayqOgTyVoRNx1qUAPWVELhtYlBLYIr872nkQm9bycofsfBwBpaegtrdmeEo
	 6lMGtBQC1mkZL5AbW2KXDREpSGWQ5ACkPOxf6D5AJ6MMLlvgw8W7D12TA6ycWshYCl
	 5DuN1JPoJczrAPUZ5DzugfcaSO8GsbS08PMd+J/xwG8rN4Ocy1BSPjKqRaNRhGFtgs
	 YYajj9lfeIOxAT4fjv/SZP0gFJ7it2U/6GXRMEUihunXDfd3B3QMp6o6XV1AX6odt9
	 E0ckfEaDHY852mGnuakVna/OcEbEKehnGh+M8/5bd8QiRhMZVa83yGN/zQlaAZlgq5
	 pHFAof6ugtI/Q==
Date: Fri, 26 Jun 2026 23:33:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Nicolas Schier <n.schier@fritz.com>
Subject: Re: [PATCH v7 0/9] bootconfig: embed kernel.* cmdline at build time
Message-Id: <20260626233327.b5c9c8de494acdde4ddf5c02@kernel.org>
In-Reply-To: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 05:50:09 -0700
Breno Leitao <leitao@debian.org> wrote:

> The userspace pieces (xbc_snprint_cmdline() in lib/, tools/bootconfig -C)
> already landed; this series wires the rendered cmdline into the kernel.
> 
> Motivation: today the embedded bootconfig is parsed at runtime, after
> parse_early_param() has already run, so early_param() handlers can't
> see embedded values. Folding the kernel.* subtree into the cmdline at
> build time gives a CONFIG_CMDLINE-equivalent for embedded-bootconfig
> users without forcing them to maintain two cmdline sources.
> 
> Behaviorally, the "kernel" subtree is rendered to a flat string at
> build time and stashed in .init.rodata. setup_arch() prepends it to
> boot_command_line before parse_early_param() runs. Overflow is a soft
> error: the helper logs and leaves boot_command_line untouched rather
> than panicking, so an oversized embedded bconf cannot brick a boot.
> 

Thanks for update!! This looks good to me.
Let me pick it and test it.

Thanks,

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v7:
> - The runtime opt-in now shares one helper instead of open-coding its
>   own. (Masami)
> - bootconfig_cmdline_requested() moved into generic lib code (Masami)
> - Link to v6: https://lore.kernel.org/r/20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org
> 
> Changes in v6:
> - renamed CONFIG_BOOT_CONFIG_EMBED_CMDLINE to
>   CONFIG_CMDLINE_FROM_BOOTCONFIG
> - prepend embedded bootconfig cmdline before parse_early_param
> - Link to v5: https://lore.kernel.org/r/20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org
> 
> Changes in v5:
> - Patch 3 (Kconfig): drop the redundant "depends on BOOT_CONFIG_EMBED"
>   from CMDLINE_FROM_BOOTCONFIG; Julian Braha.
> - Patch 6 (Documentation): spell out how the embedded cmdline interacts
>   with the bootloader cmdline, an initrd bootconfig, and the embedded
>   bootconfig
> - Link to v4: https://lore.kernel.org/r/20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org
> 
> Changes in v4:
> - Patch 3 (build pipeline): clear CROSS_COMPILE= in the kernel-side
>   tools/bootconfig sub-make. Without it, an LLVM=1 cross build
>   inherits CROSS_COMPILE and tools/scripts/Makefile.include injects
>   --target=/--sysroot= into the host clang, producing a target
>   binary that fails to exec.
> - Patch 3 (build pipeline): place embedded-cmdline.S in its own
>   .init.rodata.embed_cmdline subsection ("a") so ld.lld does not
>   see a section-type mismatch against lib/bootconfig-data.S's
>   writable .init.rodata ("aw"). The linker's *(.init.rodata
>   .init.rodata.*) glob still folds it into the init image.
> - Patch 6 (x86/setup): also accept the bootconfig=<anything> form
>   via cmdline_find_option(), matching the runtime parse_args() loop.
>   Without it, bootconfig=0/=off would skip the early prepend but
>   still trigger the late runtime apply -- a split-brain state.
> - New patch 7: document CONFIG_CMDLINE_FROM_BOOTCONFIG in
>   Documentation/admin-guide/bootconfig.rst (semantics, opt-in,
>   precedence, overflow behavior, example).
> - Link to v3: https://lore.kernel.org/r/20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org
> 
> Changes in v3:
> - Patch 3: Move HOSTCC override to the kernel-side rule; tool keeps
>   $(CC) for standalone/cross builds.
> - Patch 6: Drop the false fail-safe wording; document the
>   BOOT_CONFIG_FORCE=y default interaction.
> - Link to v2:
>   https://lore.kernel.org/r/20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org
> 
> Changes in v2 (addressing review of v1):
> - Split out a standalone fix for the NULL-pointer arithmetic in
>   xbc_snprint_cmdline() so the build-time render cannot trip host
>   UBSan/FORTIFY_SOURCE.
> - Rework the leaf-root handling: instead of returning early, skip @root
>   inside the loop so a root carrying both a value and subkeys
>   (kernel = x together with kernel.foo = bar) still renders its
>   descendant keys.
> - Build tools/bootconfig with $(HOSTCC) so cross-compiled (ARCH=...)
>   builds render the cmdline on the build host instead of failing with
>   "Exec format error".
> - Mark the embedded cmdline section read-only (drop the "w" flag from
>   .init.rodata).
> - Add a make-clean hook so tools/bootconfig artifacts are removed by
>   make clean.
> - Gate the x86 prepend on "bootconfig" being present on the command
>   line (or CONFIG_BOOT_CONFIG_FORCE), matching the init.* opt-in
>   semantics documented in bootconfig.rst and preserving fail-safe
>   recovery: dropping "bootconfig" from the bootloader cmdline now also
>   disables the embedded kernel.* keys.
> - Link to v1: https://patch.msgid.link/20260527-bootconfig_using_tools-v1-0-b6906a86e7d5@debian.org
> 
> ---
> Breno Leitao (9):
>       bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
>       bootconfig: render descendant keys when xbc_snprint_cmdline() root has a value
>       bootconfig: render embedded bootconfig as a kernel cmdline at build time
>       bootconfig: clean build-time tools/bootconfig from make clean
>       bootconfig: add xbc_prepend_embedded_cmdline() helper
>       Documentation: bootconfig: document build-time cmdline rendering
>       x86/setup: prepend embedded bootconfig cmdline before parse_early_param
>       bootconfig: skip runtime kernel.* render once prepended early
>       init/main.c: use bootconfig_cmdline_requested() for the runtime opt-in
> 
>  Documentation/admin-guide/bootconfig.rst |  81 ++++++++++++++++
>  MAINTAINERS                              |   1 +
>  Makefile                                 |  27 +++++-
>  arch/x86/Kconfig                         |   1 +
>  arch/x86/kernel/setup.c                  |  14 ++-
>  include/linux/bootconfig.h               |  14 +++
>  init/Kconfig                             |  36 +++++++
>  init/main.c                              |  52 +++++-----
>  lib/Makefile                             |  16 +++
>  lib/bootconfig.c                         | 162 +++++++++++++++++++++++++++++--
>  lib/embedded-cmdline.S                   |  16 +++
>  tools/bootconfig/Makefile                |   4 +-
>  12 files changed, 388 insertions(+), 36 deletions(-)
> ---
> base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
> change-id: 20260508-bootconfig_using_tools-cfa7aa9d6a5a
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
