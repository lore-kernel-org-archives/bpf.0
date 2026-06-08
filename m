Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B173C1984;
	Mon,  8 Jun 2026 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913975; cv=none; b=auvGdStxXJQ0d5xS7mpXBfJWxXXjdKcUkVem7hld/tZeMY4I7nvqEX8XaCDTuIqdp2BbnBWIV8tOTrUBqQvHqZ15vNNj8wvmQoXUfts2vkIzc69F58tDpaecnyXOnlO37qHO/C8ZWIimQ7/zFPts4io0YJT+2bQZydAkkacozws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913975; c=relaxed/simple;
	bh=f7eLZc/IcHT5GqFj5jujnTXujqX51uaz+wAaa3DATI4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uzm+1j/pKGQzOniIauFp+Blm6oPAqEQAUUYnmh5iDqjV4NhGwCEMxu8ha0ZKNhs8jocE9/emCXNXSlVBsu+c/nQj570hl+P0MHYSgSuxqr/tq1k9CMXGqiDF9hFpW0rMxjLNW7v9GUeUDNTB3GGeFmHxcnBQQJiiweziIPPep6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igvi1hOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igvi1hOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501C1F00893;
	Mon,  8 Jun 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780913974;
	bh=xrtlRFuiFzACaPUvDm3r3nLqN434Rs35tM7jQeJ31MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=igvi1hOkDTsC3TCzgw5kQLirJqXjKfYp+StSBUbew7x7SB+Haxv4OEjgNg0BWlgrB
	 wRZ8ix4u0MsAm3+KiEbxV+OiHnsiq0xmjkMRM5jqy1wxsbMaNK9lYw6/Xm1gQMWF3r
	 eEJF5NRE4DP/VZnvkSzesE1gVmVLWRgOmdxSFiWNSD7GueUngYKKL6Af22fuXaLqzs
	 DjQmUICaIO5WKYPg1v0/6at8tXcVfAXxNOSjxgD+6hxgTz/xJ89qIRW3UEawVe4NB+
	 1U/6EsvW9oM+XvKvRjFA0KE7clLvMpj5E3FbYXhgGC1AfEZ1Vd84VyIgCpUJ7GLWn5
	 6ILCsrzRZV78Q==
Date: Mon, 8 Jun 2026 19:19:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Message-Id: <20260608191928.d7d2dea899b94f05d397f891@kernel.org>
In-Reply-To: <20260605-bootconfig_using_tools-v2-6-d309f544b5f7@debian.org>
References: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
	<20260605-bootconfig_using_tools-v2-6-d309f544b5f7@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jun 2026 05:03:37 -0700
Breno Leitao <leitao@debian.org> wrote:

> Call xbc_prepend_embedded_cmdline() in setup_arch() right after the
> CONFIG_CMDLINE merge and before strscpy(command_line, ...) so the
> build-time-rendered embedded bootconfig "kernel" subtree is part of
> boot_command_line by the time parse_early_param() runs. early_param()
> handlers (mem=, earlycon=, loglevel=, ...) now see values supplied via
> CONFIG_BOOT_CONFIG_EMBED_FILE without parsing bootconfig at runtime.
> 
> Gate the prepend on the bootconfig opt-in: only fold in the embedded
> kernel.* keys when "bootconfig" is present on the command line, or
> CONFIG_BOOT_CONFIG_FORCE is set. Applying the embedded cmdline
> unconditionally would (a) diverge from how embedded init.* keys are
> treated and (b) break fail-safe recovery: a malformed embedded
> console=/mem= could panic the boot with no way for the admin to disable
> it by dropping "bootconfig" from the bootloader cmdline.
> cmdline_find_option_bool() runs before parse_early_param(), so the gate
> is cheap and correctly ordered.
> 
> Select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG so the user-visible
> CONFIG_BOOT_CONFIG_EMBED_CMDLINE option becomes selectable on x86.

This seems like a dummy config. what code does depend on this flag?

> 
> With this select in place, setup_boot_config() in init/main.c would
> otherwise render the embedded "kernel" subtree a second time via
> xbc_make_cmdline("kernel") into extra_command_line, duplicating every
> embedded kernel.* key in saved_command_line and making accumulating
> handlers (console=, earlycon=, ...) register the same value twice. Skip
> that render only when xbc_prepend_embedded_cmdline() actually prepended
> the keys, reported by xbc_embedded_cmdline_applied().
> 
> Keying the skip on the prepend itself, rather than re-deriving the
> opt-in, keeps the two paths consistent even when setup_arch() and the
> runtime parser detect "bootconfig" differently (e.g. "bootconfig=1"):
> the keys are then rendered at runtime instead of being dropped.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/Kconfig        |  1 +
>  arch/x86/kernel/setup.c | 16 ++++++++++++++++
>  init/main.c             | 18 +++++++++++++++---
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f24810015234..f839795692b4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -126,6 +126,7 @@ config X86
>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
>  	select ARCH_SUPPORTS_CFI		if X86_64
> +	select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
>  	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 46882ce79c3a..26a82a41f44c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -6,6 +6,7 @@
>   * parts of early kernel initialization.
>   */
>  #include <linux/acpi.h>
> +#include <linux/bootconfig.h>
>  #include <linux/console.h>
>  #include <linux/cpu.h>
>  #include <linux/crash_dump.h>
> @@ -36,6 +37,7 @@
>  #include <asm/bios_ebda.h>
>  #include <asm/bugs.h>
>  #include <asm/cacheinfo.h>
> +#include <asm/cmdline.h>
>  #include <asm/coco.h>
>  #include <asm/cpu.h>
>  #include <asm/efi.h>
> @@ -924,6 +926,20 @@ void __init setup_arch(char **cmdline_p)
>  	builtin_cmdline_added = true;
>  #endif
>  
> +	/*
> +	 * Honor the same opt-in as the runtime bootconfig parser: only fold
> +	 * the embedded kernel.* keys into the cmdline when "bootconfig" is
> +	 * present on the command line (or CONFIG_BOOT_CONFIG_FORCE is set).
> +	 * This keeps fail-safe recovery working -- dropping "bootconfig" from
> +	 * the bootloader cmdline disables the embedded keys -- so a malformed
> +	 * embedded console=/mem= cannot brick a boot with no way out. It also
> +	 * matches setup_boot_config(), which bails out under the same
> +	 * condition before parsing the embedded bootconfig at runtime.
> +	 */
> +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) ||
> +	    cmdline_find_option_bool(boot_command_line, "bootconfig"))
> +		xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);
> +
>  	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p = command_line;
>  
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..567f641a5731 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -378,12 +378,15 @@ static void __init setup_boot_config(void)
>  	int pos, ret;
>  	size_t size;
>  	char *err;
> +	bool from_embedded = false;
>  
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
>  	data = get_boot_config_from_initrd(&size);
>  	/* If there is no bootconfig in initrd, try embedded one. */
> -	if (!data)
> +	if (!data) {
>  		data = xbc_get_embedded_bootconfig(&size);
> +		from_embedded = true;

Even from embedded bootconfig, if the arch set 
ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG=n, this must be applied to
the cmdline as we are doing.

> +	}
>  
>  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -421,8 +424,17 @@ static void __init setup_boot_config(void)
>  	} else {
>  		xbc_get_info(&ret, NULL);
>  		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> -		/* keys starting with "kernel." are passed via cmdline */
> -		extra_command_line = xbc_make_cmdline("kernel");
> +		/*
> +		 * keys starting with "kernel." are passed via cmdline. When
> +		 * this bootconfig came from the embedded source and
> +		 * setup_arch() already prepended the rendered "kernel" subtree
> +		 * to boot_command_line, rendering again here would duplicate
> +		 * the keys in saved_command_line and make accumulating handlers
> +		 * (console=, earlycon=, ...) re-register the same value. Skip
> +		 * only when the prepend really happened.

Also, this should mention ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG=n case.

Thank you,

> +		 */
> +		if (!from_embedded || !xbc_embedded_cmdline_applied())
> +			extra_command_line = xbc_make_cmdline("kernel");
>  		/* Also, "init." keys are init arguments */
>  		extra_init_args = xbc_make_cmdline("init");
>  	}
> 
> -- 
> 2.53.0-Meta
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
