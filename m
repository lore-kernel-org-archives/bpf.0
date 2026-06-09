Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424E23507B;
	Tue,  9 Jun 2026 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969578; cv=none; b=LGspabOrJxn0gtRANkNPJlpQFz86IdONHxqQQ9RBi5/HHfB0M3k7dPx+k4sugryinJTCrLd2F+yRtVr6wvodyq8kTPzih6WrInQ6FVzln/Ypkj8BZ2hXkc7Kvt+kkF57yO4ly/L/48Kj4F4CdayXhl0xAUKs6XcToALtBbH7hJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969578; c=relaxed/simple;
	bh=ESmsnl/PdZvZQQWspqi0iQYBPTC3ZPnWZHei3dL1a+M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mw9xBa8aBGcHVskrRo0H1LTmoW1s3eO6jk+c1DG67Dm32lLzPr9KQC/QUG2962FOX5ABajFg77PamoTmfJZxwUCCFo3ALLvowgJiYXBA8E3R7ysMWJZW0/Z5y5f6ApmBqfXRi0Eg9Vpu07ydZUfyr0r8k3Kd8NMim4DuF4htsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGZt7iJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGZt7iJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEA31F00893;
	Tue,  9 Jun 2026 01:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969577;
	bh=LuJDuLHqiCUmDOBQtKk6dTv3wAjkftELoieOPtbOocU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DGZt7iJTzpIXyVLi+fsQ9zjeqrywyYj7D61MGbWrrAcfpJe9/luWcAeZW37ap7TyB
	 1n/45NqVh0LTmnqZ/RaPNlZUuBLRJS6AUUh9SEoQre938J6JP/2cqPkZWFFtAqsS1s
	 ZvO7FPgt6J74dRzFwFwQHNag9JoIR0ujhGwz2C4gcIn1kqd7AhtvFn/+OWDYW/MfAV
	 cTuaGt0xguSIXyc2Xyl8aIOMSSYhMamRRJrRowoOp8lWwgxO0XB7ZR9uw0HKjV4i3D
	 OkaGfpbJvs/rQJrBf9O4hrtUfomuWF2HzijUBmI17HcK0IuCAgdS2lFccMfAde6qMu
	 vwL4QSK41TPAA==
Date: Tue, 9 Jun 2026 10:46:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] bootconfig: embed kernel.* cmdline at build time
Message-Id: <20260609104611.a0a5def510944d12cd0b6dfc@kernel.org>
In-Reply-To: <20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org>
References: <20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jun 2026 09:23:57 -0700
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

Sashiko still leaves some comments. 
https://sashiko.dev/#/patchset/20260608-bootconfig_using_tools-v3-0-4ddd079a0696%40debian.org

BTW, can you also update the document (Documentation/admin-guide/bootconfig.rst)
about what is the expected behavior of this feature (kconfigs, examples)?

Thank you,


> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
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
> Breno Leitao (6):
>       bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
>       bootconfig: render descendant keys when xbc_snprint_cmdline() root has a value
>       bootconfig: render embedded bootconfig as a kernel cmdline at build time
>       bootconfig: clean build-time tools/bootconfig from make clean
>       bootconfig: add xbc_prepend_embedded_cmdline() helper
>       x86/setup: prepend embedded bootconfig cmdline before parse_early_param
> 
>  MAINTAINERS                |   1 +
>  Makefile                   |  24 +++++++++-
>  arch/x86/Kconfig           |   1 +
>  arch/x86/kernel/setup.c    |  16 +++++++
>  include/linux/bootconfig.h |   9 ++++
>  init/Kconfig               |  36 +++++++++++++++
>  init/main.c                |  25 ++++++++--
>  lib/Makefile               |  16 +++++++
>  lib/bootconfig.c           | 112 ++++++++++++++++++++++++++++++++++++++++++---
>  lib/embedded-cmdline.S     |  16 +++++++
>  tools/bootconfig/Makefile  |   4 +-
>  11 files changed, 247 insertions(+), 13 deletions(-)
> ---
> base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
> change-id: 20260508-bootconfig_using_tools-cfa7aa9d6a5a
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
