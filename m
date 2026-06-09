Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CF3F39C6;
	Tue,  9 Jun 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000962; cv=none; b=cMIsBpql6zsbG99zqBySKOk/vBls3a6VaC7k/ENep3H5+L26Lwtv/zAiu9jzFWDWp0Row8shC/gRxd+hJQZ5iqlwPRiwHjJ2lToIkYoTjDPOV5QZrj3TqA8eOEsjN70UJiwWbpCegAyc1ebTjWfYOk8J7K52KHwKjRLS8lXpPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000962; c=relaxed/simple;
	bh=SgWVd3DFgOxwhQI8SXvXPP+pToSq9yRG60TurUSNiV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX8akgVu7fsJnmcn5hgtArRcwMAgoQEbaT8xi48u0nh1ZOIblZGBUVlhEtzOQFyPqJpr2ASZ/AcvWhLc2pSjvbTg1+qoocwTvn4lrxsvLmflC9+L3NMY7ZDG9d6UhI+Bpi1gf7clRqsi46bLXsDTKiZWrFmcaFrYpZOyVsSDD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GjJV2vwA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GjJV2vwA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fveKo/ArUELsguqNauoSDBrPUcMaabksHqjPg8uoepc=; b=GjJV2vwAKD9zWAR+lameMpNBZM
	bvmEiYeiyuo26X4yoYd13lsRyaC6fYFcxHszU7IEKysWybdX3wjHhTPcjR9+TBQJaJfWmICo+4iAg
	yLhrvKfWItcMpI9Bd8gIA48lDQSWqD/EbWBx5pn49cp/6XjDBJ36L8oKwyW3/Zmg1HYvQefzkCJcs
	BG7fb/dUhzVzZq9F7LLHQbyw5Wzzoh+w2vDI7crrRAE/lRyslVzaM5NWwbGFKbud+msmd2pAxSMrG
	TIH+vRSMpTG5FH6OI0+r5B7nV1sCaw4jm0gt2LKJn1EVTS/edtFweRh3B6bDDhPCDifsuC7HXdOoz
	yp/LKfDg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWtho-008Kv9-2n;
	Tue, 09 Jun 2026 10:29:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:28:34 -0700
Subject: [PATCH v4 7/7] x86/setup: prepend embedded bootconfig cmdline
 before parse_early_param
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-bootconfig_using_tools-v4-7-73c463f03a97@debian.org>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
In-Reply-To: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5718; i=leitao@debian.org;
 h=from:subject:message-id; bh=SgWVd3DFgOxwhQI8SXvXPP+pToSq9yRG60TurUSNiV8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ+rRp7KklqgOH8X78COolam8wSpgL0FLVlLdq
 09+JfqRjBOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifq0QAKCRA1o5Of/Hh3
 bRSQD/oCif5myVm/BIHl1V4e9WC19/ZnXgDr+5BdXjkk3/1768kPwXn5TH/d3sNKPUEBoVjoNiv
 BE3qd6zZ9P6KIo4UbqwTz/2Os7usjawYIPKmc1JrhZRz7ArqIrmC7+XbTOHThgT6dWitbJtIGpz
 TfOWYFLegmF4oGxpONlEcBCPa1N/o1kytcwwouYpGvrUPRs3SkWwRj8wtYrgws1SsCJL+1IUMYm
 5AMBWGWdBPRsdfVYbe79h0xiMP4rYAW2LW695qTpzMkim/s7MG+S9yIdoxInpV6/qbcc4so9zjp
 XFJBNl6qkuHhx8KydO7fBsjjvN17Czc96w20XUaGmgoewCNBdqPUGK/FcrDgcFW+NIf3J0gki+m
 1A3LzgJDhMmvSr9mhba84xtkMrWMC01rAPhSnzF3wyeAV9TB+QGkFdT/O/9HWv0JAaCYrBUmLuo
 hvLcdwQ9dOyig0fbhCq6uZRRWscmbEmxXiLXCKjyMEKMDI61vX2iVNeXYZKBcOr9I5nI2F7IVlf
 1YagR1/EKSybCCIaACzBF4E34Gey/aIzZapMDfrDTSFJWMjT3adWktzi88rTRggRvqDbVA5bup0
 rSfWGTbMjv+xCBIhVgo+9+gpInJtxM9Sc08Xq78tUV0LbMjxqe6u/EH+4IOSDB9O3axkzAF8B/c
 8HcwgM0ArQIcLDA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Call xbc_prepend_embedded_cmdline() in setup_arch() right after the
CONFIG_CMDLINE merge and before strscpy(command_line, ...) so the
build-time-rendered embedded bootconfig "kernel" subtree is part of
boot_command_line by the time parse_early_param() runs. early_param()
handlers (mem=, earlycon=, loglevel=, ...) now see values supplied via
CONFIG_BOOT_CONFIG_EMBED_FILE without parsing bootconfig at runtime.

Gate the prepend on the same opt-in the runtime parser uses: prepend
when "bootconfig" is present on the command line, or when
CONFIG_BOOT_CONFIG_FORCE is set. setup_boot_config()'s parse_args()
loop treats any presence of the "bootconfig" key as opt-in regardless
of value, so check both cmdline_find_option_bool() (matches the bare
key) and cmdline_find_option() (matches "bootconfig=<anything>").
Without the latter check, "bootconfig=0" would skip the early prepend
yet still trigger the late runtime apply, leaving the embedded keys
invisible to early_param() but applied to saved_command_line.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig        |  1 +
 arch/x86/kernel/setup.c | 27 +++++++++++++++++++++++++++
 init/main.c             | 25 ++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0de23e647197..8ab11199c16d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -127,6 +127,7 @@ config X86
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_CFI		if X86_64
+	select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 46882ce79c3a..d69ba84c203f 100644
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
@@ -924,6 +926,31 @@ void __init setup_arch(char **cmdline_p)
 	builtin_cmdline_added = true;
 #endif
 
+	/*
+	 * Match the runtime bootconfig parser's opt-in: only fold the
+	 * embedded kernel.* keys into the cmdline when "bootconfig" is
+	 * present on the command line, or CONFIG_BOOT_CONFIG_FORCE is set.
+	 * setup_boot_config()'s parse_args() loop treats any presence of
+	 * the "bootconfig" key as opt-in (bare, =0, =1, ...), so check both
+	 * forms here: cmdline_find_option_bool() matches the bare key,
+	 * cmdline_find_option() matches "bootconfig=<anything>". Without
+	 * the second check, "bootconfig=0" would skip the early prepend
+	 * but still trigger the late runtime apply -- a split-brain state.
+	 * CONFIG_BOOT_CONFIG_FORCE defaults to y when BOOT_CONFIG_EMBED is
+	 * set, so on the default config the embedded keys are applied
+	 * unconditionally.
+	 */
+	{
+		char buf[8];
+
+		if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) ||
+		    cmdline_find_option_bool(boot_command_line, "bootconfig") ||
+		    cmdline_find_option(boot_command_line, "bootconfig",
+					buf, sizeof(buf)) >= 0)
+			xbc_prepend_embedded_cmdline(boot_command_line,
+						     COMMAND_LINE_SIZE);
+	}
+
 	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
diff --git a/init/main.c b/init/main.c
index e363232b428b..2ecb6aa536dd 100644
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
@@ -421,8 +424,24 @@ static void __init setup_boot_config(void)
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
+		 *
+		 * On arches that do not select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG,
+		 * CONFIG_BOOT_CONFIG_EMBED_CMDLINE is unselectable and
+		 * xbc_embedded_cmdline_applied() collapses to a stub returning
+		 * false, so this path still runs and the embedded "kernel"
+		 * keys reach the cmdline via the runtime parser exactly as
+		 * before this series.
+		 */
+		if (!from_embedded || !xbc_embedded_cmdline_applied())
+			extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
 	}

-- 
2.53.0-Meta

