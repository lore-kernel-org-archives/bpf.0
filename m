Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1F4DBD7D;
	Fri,  5 Jun 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661067; cv=none; b=upW0bksFExjZR7czdmMw6ee8Xewd0OnPVr+2ct/wxxJgVB94XpjO0mV7czA2cxtA2c3/ZGJZwi4rETdPsVhOzfCCbqDlJNz53+sj1jYa7w6NR8Kp1Vqy9/Z3HJOGMQO7vDA6mq96xn5zrzRe55oxNyRMR7YxpYW7Iw5SmqC4nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661067; c=relaxed/simple;
	bh=I0OdXy6FEp71NFvv+bDXTFaDIxx23MCYNaRhxq58Q2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bICO0T05Y7mrdsIZKMhlhTpQcP7mFT/vSFmvJlUsPsjo/4T4zIO7QJnTWaPsiCkrQ1BbB1ccYo3UKphzDXcQW0EXuGetr0ImYJIMvXio2bx0CRoJRtsBjpCr+TSiMBsSMCTOrXM2hye/5bq037Jg4GMLbrE35w74jI51NkW+5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dE3hoo0v; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dE3hoo0v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=B1K18S07Behr2dPLcs6pjimCBF6grfM9DcwV9KSISms=; b=dE3hoo0vU5ci/tgSCdMkGb/lVZ
	7e5kk04dHiMyj76oF/XNlbWtiYSpkQ4uLBnKOvQXtb4UtvB4T3ETHDkLzdeEo6Z2iODCy1wXAhozs
	Mf2qNhRG+MPrWjU/HY+st55PvhvSSw8lvyR1pAaZjoK+xtEdfz59Io2bid6nqFviRCFwg0V4uwZPn
	K6Co0rlonE+6Gjc+eSTUed0i4ZEoI1GDe8vHs6vkXhM+5jSWqLwbI0z75MGckHsi2LaT+UDCz86BV
	+tg+AS1rdxnClQkgS+hHjvSryqxGZvA3E5P5/ZmzYC5R/5IeuTMNiQFk6xdVyN/WHnMLD8OHxTCKX
	q1yamxcw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTHe-005HIJ-1Y;
	Fri, 05 Jun 2026 12:04:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 05:03:37 -0700
Subject: [PATCH v2 6/6] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-bootconfig_using_tools-v2-6-d309f544b5f7@debian.org>
References: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
In-Reply-To: <20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5839; i=leitao@debian.org;
 h=from:subject:message-id; bh=I0OdXy6FEp71NFvv+bDXTFaDIxx23MCYNaRhxq58Q2o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIrsfTYkPu/ZtQ/7DE3oaO0MeQE1sA/iBzYZ3B
 tYHw/cM5ICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiK7HwAKCRA1o5Of/Hh3
 bUzhD/4/OsdRyuXYsOrgKzNmWGdy9klHFtbGxXvat9iO6TvOSy7uqndACjJbkl7G5AtpbhKr5kG
 6L/0MFbBzIoqPrSI8zdYWMPDr26Tv+T9l40KviV7/mTOc9M+RWgeV2//DDi90dIm8KiyHwfhOLK
 +gnrMrsSCtDv+vkak/AqJdbfr96j5rj0g1sM4Q2HUPnCSgd0LB9hV/PAgO2OO0Q/4Pg345HCR0z
 LOBI2uWx8rK4oFiI2f9UeA2gqzeKobWM2LWYp/0mmLZRuGvbyl7emavW+O9uLReeRIgBcMCXv78
 VHmNbHu4xONHdR55viiGH/RQOajHT9Fs+VmqNB+RRzq04G/hdiLC+dV0ZwQyOiEg/kbhNJVactS
 w6z+kPEX+VlxwVAPJoIHnHyF4N061IDl34B3bpe/T9kRTpB8C/xl1OOeLqCyeXDVnWhcd5vOh0s
 ux4Nufdx7YMZCJHPehOq+WxuhVUvhxVjYKAvDD6jRaie6TaF2T707MakEmy8uXAnHA5euyL27U+
 nhWe5G7GXyAjgaq8jDoT1kAoCoqRsvW766VSJ7xnZ9mr42ulmPI9n4TEFCznqFz8+DdBTssxXTY
 URxlPPgm7K9D1fccN0k9DKICWOctwc8UlOnFMtcbjJqIgMf/PkXbGsY8gJV5Ow8p5PyNhXbw6vC
 j+QHC4RkPv73vfQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Call xbc_prepend_embedded_cmdline() in setup_arch() right after the
CONFIG_CMDLINE merge and before strscpy(command_line, ...) so the
build-time-rendered embedded bootconfig "kernel" subtree is part of
boot_command_line by the time parse_early_param() runs. early_param()
handlers (mem=, earlycon=, loglevel=, ...) now see values supplied via
CONFIG_BOOT_CONFIG_EMBED_FILE without parsing bootconfig at runtime.

Gate the prepend on the bootconfig opt-in: only fold in the embedded
kernel.* keys when "bootconfig" is present on the command line, or
CONFIG_BOOT_CONFIG_FORCE is set. Applying the embedded cmdline
unconditionally would (a) diverge from how embedded init.* keys are
treated and (b) break fail-safe recovery: a malformed embedded
console=/mem= could panic the boot with no way for the admin to disable
it by dropping "bootconfig" from the bootloader cmdline.
cmdline_find_option_bool() runs before parse_early_param(), so the gate
is cheap and correctly ordered.

Select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG so the user-visible
CONFIG_BOOT_CONFIG_EMBED_CMDLINE option becomes selectable on x86.

With this select in place, setup_boot_config() in init/main.c would
otherwise render the embedded "kernel" subtree a second time via
xbc_make_cmdline("kernel") into extra_command_line, duplicating every
embedded kernel.* key in saved_command_line and making accumulating
handlers (console=, earlycon=, ...) register the same value twice. Skip
that render only when xbc_prepend_embedded_cmdline() actually prepended
the keys, reported by xbc_embedded_cmdline_applied().

Keying the skip on the prepend itself, rather than re-deriving the
opt-in, keeps the two paths consistent even when setup_arch() and the
runtime parser detect "bootconfig" differently (e.g. "bootconfig=1"):
the keys are then rendered at runtime instead of being dropped.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig        |  1 +
 arch/x86/kernel/setup.c | 16 ++++++++++++++++
 init/main.c             | 18 +++++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f24810015234..f839795692b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_CFI		if X86_64
+	select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 46882ce79c3a..26a82a41f44c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -6,6 +6,7 @@
  * parts of early kernel initialization.
  */
 #include <linux/acpi.h>
+#include <linux/bootconfig.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/crash_dump.h>
@@ -36,6 +37,7 @@
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cacheinfo.h>
+#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
@@ -924,6 +926,20 @@ void __init setup_arch(char **cmdline_p)
 	builtin_cmdline_added = true;
 #endif
 
+	/*
+	 * Honor the same opt-in as the runtime bootconfig parser: only fold
+	 * the embedded kernel.* keys into the cmdline when "bootconfig" is
+	 * present on the command line (or CONFIG_BOOT_CONFIG_FORCE is set).
+	 * This keeps fail-safe recovery working -- dropping "bootconfig" from
+	 * the bootloader cmdline disables the embedded keys -- so a malformed
+	 * embedded console=/mem= cannot brick a boot with no way out. It also
+	 * matches setup_boot_config(), which bails out under the same
+	 * condition before parsing the embedded bootconfig at runtime.
+	 */
+	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) ||
+	    cmdline_find_option_bool(boot_command_line, "bootconfig"))
+		xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);
+
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
diff --git a/init/main.c b/init/main.c
index e363232b428b..567f641a5731 100644
--- a/init/main.c
+++ b/init/main.c
@@ -378,12 +378,15 @@ static void __init setup_boot_config(void)
 	int pos, ret;
 	size_t size;
 	char *err;
+	bool from_embedded = false;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data)
+	if (!data) {
 		data = xbc_get_embedded_bootconfig(&size);
+		from_embedded = true;
+	}
 
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -421,8 +424,17 @@ static void __init setup_boot_config(void)
 	} else {
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
-		/* keys starting with "kernel." are passed via cmdline */
-		extra_command_line = xbc_make_cmdline("kernel");
+		/*
+		 * keys starting with "kernel." are passed via cmdline. When
+		 * this bootconfig came from the embedded source and
+		 * setup_arch() already prepended the rendered "kernel" subtree
+		 * to boot_command_line, rendering again here would duplicate
+		 * the keys in saved_command_line and make accumulating handlers
+		 * (console=, earlycon=, ...) re-register the same value. Skip
+		 * only when the prepend really happened.
+		 */
+		if (!from_embedded || !xbc_embedded_cmdline_applied())
+			extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
 	}

-- 
2.53.0-Meta

