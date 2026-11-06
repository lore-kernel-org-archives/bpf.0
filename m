Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998337;
	b=JtkNLdbqfdCyCf0c2/jve3gMH/QKz1R8sOhKryYGoajDnp9cEVFz9J9JFFZGsfmrzZyP
	 k36vwHMlm2omVQRWMKwP00xrrvfbyPQmn7n6Yvs9q/ST3XAuk9NxxanCllsRw/1+9AV/d
	 FAhE/M5q10X3w0j7LPeekfMEr95n1oYfy6YjmTwR7CtTwxRTd34FVdIOHfHOPVN6nWRfi
	 RQJBVpXUyWIJ0JodhkOMWhqi6SVCEKaUjzBPbmgwT+jjHX2lDA1o/ELdNxL1OUpof+5fS
	 5K6w9Y21UkgQGe/Nhjxel3g5hVg41le0boQVjIvGvtmDQyBlb8zDe6vW5EPkCa4CjDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qyl271xS4NaUQkQEDfJP7TOW84m77rHK/njFeThb4gM=;
	b=1N8uU1T4bJoNa0JGeK4tBXLMUXBMNzweROR0FoYKlrc0w8XlKOfKkW2jR83JrZ+Puyqh
	 YT2roIP+VsZ1zOhAIo5kZ0xp2Yp4t/fBIsM/tWw4hS/Zi366GiNnoxOmHGg5BljTf42kX
	 3NrHpoutItDGcR4V6mLMChpoArpgFWPnvmxM2PZNP3EJMNJ2C9KoR3mrWGK5W/QOpz4Sp
	 r7ivgiKyD96wlQTxKg2eiwATupXaeoTRtqTlggX1Tye+oq9fLReXM4IpOIOlgPO5oiUqy
	 SzkdV7MOCHyIXqn1L+2ibklFTwKrLeyPnXa/FRrcCushlxuLVsn/bIwkjrjtt1WnOoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6JYYw9K;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564F606D80F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E564F606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6JYYw9K
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so10077325e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998328; x=1794603128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyl271xS4NaUQkQEDfJP7TOW84m77rHK/njFeThb4gM=;
        b=B6JYYw9KHytgcsKRViIv702sJvZ13LITWymvU2GUgmjrKUaq/34AS+ZLL3ysWVLSLI
         RJXl9Q9YqcwzD2rlx6xKf6dx41WgKvGiW0uMLEcdV+iI0e/8Gykut8ZaYfLCJyn8McBU
         Kf2E46f8OrV2dtE0E+bp5xnDsudqH9wlOvjwL+ctwbcd9xgdgJ/mhbqI6N36LWAHumFf
         J7h3qs6oBplssT9Iw3Q2hQdl9yAGulkfQRG41NX6q4/AB7CjTkX4BR/v+oVPNwslm5uW
         ZRL4V7Biv0wgO6T4HV6FI6te4JC76snnf4I5eGfuexdLqirM7sjzMDOYj+2Nz+m38+FF
         /Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998328; x=1794603128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyl271xS4NaUQkQEDfJP7TOW84m77rHK/njFeThb4gM=;
        b=Gzr/IbKb95I7snhyo+MHwDruNcfAw/Kp0duwZ/QtAyA1KN12y3jdn8rPkHEp5G92A4
         HPUI4KtsI7UC7/p75V3RjeuqtY92xzuUqJkLNV7mbi9a9pooVI9MeMXPZRuvA/twedj6
         cASBhdjbwWALtjKfj/PeLIv0AqXtb8+YcBu64alnYD9G+de6MaXL2wbdMYyytx3p+MFe
         6XoIH1lVyZ1B7vJCJzy5ggcSE2Gh8YSjwWG54dqLezfpTho0CDSemUBk42WeqPDs66th
         0NSLfiDXO3v47XIbAin6LZukG675FHgowJo02r7OhX6ftfDZyrkMzZ+t7K31ziB8mcFy
         Vftw==
X-Forwarded-Encrypted: i=1; AKwUvBzfXiVp1rB1IE8tTKgkXuITdW9cvr/9lzOKw1Xakc0VUHsT7XRQL8BfzcVQdMsm+e0o8iU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qi1XvHx6jLTfeA+1qgwSEWi780a2k4Pava+gdsfiNskYTYzvk
	lMfqHw4YmJ2HYMDZkwUjg8Mxo4Hw+5wS7TXxeX3y9lE/M37gqp5TdYNs
X-Gm-Gg: AYBFou1DkvMMQTGrhmvyCaRZd9uT4hCqYsrev5tT6o/H7XfdjUgfHsVb9pvJJIxVVFb
	MNjy/vXOz4sJWuzA7GE9dyKXrdKaz5PBJPtRD+8XtcZnc5Q0v/BS8KRdpMRenTNLyeakkmN+y0x
	dsEBoHhsDSNwT/V4YH+jEXsT3ulNjZ/gxZVH/tECSR6yboND/iaPrR9IUxPp9DY+rmCxIkKOvTC
	Vf9LimZ3+mzILDEX6ONQnh+ieFjPWbmXbfXU5BztsMLYBkfQw60BRfsyL7UY/IiZ+QluVzrkxP4
	uSz3uTnbIBnqjVIlQjOxBdg0S1vutG01Fq2k66briJt0q5sV0y9EHWPr0N3Shktf0ZYOcY8vhRY
	CZ/FOxo0JJVesPnUDIh467YqDOCFUmbET4HLjUHU87dke29bS+GzP8B6/jgXX9bPXkKgfQu/ikA
	k7QF+LJR9guQ+LzvmRlrL9itpJShdH6A9CKJs44uUYryU1/k/EzHVUcwvqzQu6sQV4lZisGljdr
	mkn5mCsab0MIZDHr5PoeY2UUqjZDlMEoDJjZD5fIcH4OuZW7vZHzISFPIlx/cNG2uaQNH+wvOE7
	z7StfMzvrfk1IMPYMMlp6TLxZCIAnefJ9Mn5rroKMzrc76w=
X-Received: by 2002:a05:600c:5289:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4b6dea695f8mr70229315e9.11.1793998328189;
        Fri, 06 Nov 2026 12:52:08 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:07 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 07/18] scripts: Add LLVM plugin infrastructure
Date: Fri,  6 Nov 2026 21:02:56 +0000
Message-ID: <20261106210314.1767267-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scripts/llvm-plugins and the corresponding Makefiles and Kconfig for
LLVM IR passes loaded with -fpass-plugin, similar to the GCC plugins.
Individual plugins register their configuration and shared objects
separately. No plugin is added yet.

Use LLVM_CONFIG to obtain the host compiler and linker flags. Require
llvm-config of the same major version as clang, which loads the plugins:
unlike GCC, clang does not provide the headers for its plugins. Require
also a host C++ compiler which accepts the headers and flags of
llvm-config.

Build plugins without linking LLVM component libraries; their LLVM
symbols are resolved by the compiler loading the shared library. Include
a generated header so objects are rebuilt when enabled plugins change.
Track the headers of a plugin, LLVM ones included, with a dependency
file, as the GCC plugins do.

Export LLVM_PLUGINS_CFLAGS so vDSO, EFI stub and early boot builds can
exclude the plugins, as they exclude the GCC plugins.

Add the plugin infrastructure to the CLANG/LLVM BUILD SUPPORT entry in
MAINTAINERS.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 MAINTAINERS                           |  2 ++
 Makefile                              |  6 +++++-
 arch/Kconfig                          |  1 +
 arch/arm64/kernel/pi/Makefile         |  1 +
 arch/x86/boot/startup/Makefile        |  2 ++
 arch/x86/um/vdso/Makefile             |  2 +-
 drivers/firmware/efi/libstub/Makefile |  2 +-
 include/linux/compiler-version.h      |  5 +++++
 lib/vdso/Makefile.include             |  3 +++
 scripts/Makefile                      |  1 +
 scripts/Makefile.llvm-plugins         |  8 ++++++++
 scripts/llvm-plugins/Kconfig          | 17 +++++++++++++++++
 scripts/llvm-plugins/Makefile         | 21 +++++++++++++++++++++
 13 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 scripts/Makefile.llvm-plugins
 create mode 100644 scripts/llvm-plugins/Kconfig
 create mode 100644 scripts/llvm-plugins/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..02b6c8963c63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6562,7 +6562,9 @@ C:	irc://irc.libera.chat/clangbuiltlinux
 F:	Documentation/kbuild/llvm.rst
 F:	include/linux/compiler-clang.h
 F:	scripts/Makefile.clang
+F:	scripts/Makefile.llvm-plugins
 F:	scripts/clang-tools/
+F:	scripts/llvm-plugins/
 K:	\b(?i:clang|llvm)\b
 
 CLK API
diff --git a/Makefile b/Makefile
index f895752d4b05..2fcad8109572 100644
--- a/Makefile
+++ b/Makefile
@@ -457,10 +457,13 @@ endif
 
 HOSTCC	= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
 HOSTCXX	= $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
+LLVM_CONFIG ?= $(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX)
 else
 HOSTCC	= gcc
 HOSTCXX	= g++
+LLVM_CONFIG ?= llvm-config
 endif
+export LLVM_CONFIG
 HOSTRUSTC = rustc
 HOSTPKG_CONFIG	= pkg-config
 
@@ -1211,10 +1214,11 @@ include-$(CONFIG_AUTOFDO_CLANG)	+= scripts/Makefile.autofdo
 include-$(CONFIG_PROPELLER_CLANG)	+= scripts/Makefile.propeller
 include-$(CONFIG_WARN_CONTEXT_ANALYSIS) += scripts/Makefile.context-analysis
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
+include-$(CONFIG_LLVM_PLUGINS)	+= scripts/Makefile.llvm-plugins
 
 include $(addprefix $(srctree)/, $(include-y))
 
-# scripts/Makefile.gcc-plugins is intentionally included last.
+# The compiler plugin Makefiles are intentionally included last.
 # Do not add $(call cc-option,...) below this line. When you build the kernel
 # from the clean source tree, the GCC plugins do not exist at this point.
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f9..4f1f36d3e82d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1772,6 +1772,7 @@ config HAVE_GENERIC_TIF_BITS
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
+source "scripts/llvm-plugins/Kconfig"
 
 config FUNCTION_ALIGNMENT_4B
 	bool
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index a273ab5af805..5813bb75c992 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -10,6 +10,7 @@ KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
 		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
 		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
 		   $(CONFIG_CC_OPT_NO_ADDRSIG)
+KBUILD_CFLAGS	:= $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 
 # this code may run with the MMU off so disable unaligned accesses
 CFLAGS_map_range.o += -mstrict-align
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..7036e939097e 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -12,6 +12,8 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 # disable ftrace hooks and LTO
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+# LLVM plugins may add data with absolute addresses
+KBUILD_CFLAGS	:= $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 KASAN_SANITIZE	:= n
 KCSAN_SANITIZE	:= n
 KMSAN_SANITIZE	:= n
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 7664cbedbe30..0e32c9ae2b5a 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -37,7 +37,7 @@ CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
        -fno-omit-frame-pointer -foptimize-sibling-calls
 
-$(vobjs): KBUILD_CFLAGS += $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index bbab12b8eb4b..6f69d5d67731 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,7 @@
 # enabled, even if doing so doesn't break the build.
 #
 
-cflags-y			:= $(KBUILD_CFLAGS)
+cflags-y			:= $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 
 # x86 links the stub into the decompressor rather than the kernel proper, so
 # drop the kernel's code model, calling convention, and stack alignment, and
diff --git a/include/linux/compiler-version.h b/include/linux/compiler-version.h
index ac1665a98a15..e6a5a9f3fbcd 100644
--- a/include/linux/compiler-version.h
+++ b/include/linux/compiler-version.h
@@ -24,6 +24,11 @@
 #include <generated/gcc-plugins.h>
 #endif
 
+/* Rebuild objects when an LLVM plugin changes. */
+#ifdef LLVM_PLUGINS
+#include <generated/llvm-plugins.h>
+#endif
+
 /*
  * If the randstruct seed itself changes (whether for GCC plugins or
  * Clang), the entire tree needs to be rebuilt since the randomization of
diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
index cedbf15f8087..848d58296ba2 100644
--- a/lib/vdso/Makefile.include
+++ b/lib/vdso/Makefile.include
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# vDSO code executes outside the kernel.
+KBUILD_CFLAGS := $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
+
 GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
 GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
 
diff --git a/scripts/Makefile b/scripts/Makefile
index d7fbb7ca098b..bc5dacc29207 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -66,6 +66,7 @@ hostprogs += unifdef gen_packed_field_checks
 targets += module.lds
 
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
+subdir-$(CONFIG_LLVM_PLUGINS) += llvm-plugins
 subdir-$(CONFIG_GENKSYMS) += genksyms
 subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
diff --git a/scripts/Makefile.llvm-plugins b/scripts/Makefile.llvm-plugins
new file mode 100644
index 000000000000..e18f4907b015
--- /dev/null
+++ b/scripts/Makefile.llvm-plugins
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+LLVM_PLUGIN := $(llvm-plugin-y)
+LLVM_PLUGINS_CFLAGS := $(strip $(addprefix -fpass-plugin=$(objtree)/scripts/llvm-plugins/, \
+	$(LLVM_PLUGIN)) -DLLVM_PLUGINS)
+export LLVM_PLUGIN LLVM_PLUGINS_CFLAGS
+
+KBUILD_CFLAGS += $(LLVM_PLUGINS_CFLAGS)
diff --git a/scripts/llvm-plugins/Kconfig b/scripts/llvm-plugins/Kconfig
new file mode 100644
index 000000000000..37db99159b9c
--- /dev/null
+++ b/scripts/llvm-plugins/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menuconfig LLVM_PLUGINS
+	bool "LLVM plugins"
+	depends on CC_IS_CLANG
+	depends on $(success,$(LLVM_CONFIG) --version)
+	# The plugins are built against the headers of llvm-config and loaded
+	# by clang, so both must come from the same LLVM release
+	depends on $(success,test "$(shell,$(LLVM_CONFIG) --version 2>/dev/null | cut -d. -f1)" = "$(shell,$(CC) -dumpversion | cut -d. -f1)")
+	# The host C++ compiler must accept the LLVM headers and flags
+	depends on $(success,echo '#include <llvm/Config/llvm-config.h>' | $(HOSTCXX) $(shell,$(LLVM_CONFIG) --cxxflags 2>/dev/null) -x c++ -fsyntax-only -)
+	default y
+	help
+	  LLVM plugins add compiler passes to kernel and module builds.
+	  Building them requires LLVM development headers and llvm-config
+	  of the same major version as clang. Each plugin has its own option
+	  below and is built only if that option is enabled.
diff --git a/scripts/llvm-plugins/Makefile b/scripts/llvm-plugins/Makefile
new file mode 100644
index 000000000000..a1f8503c8bcd
--- /dev/null
+++ b/scripts/llvm-plugins/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+always-y += $(LLVM_PLUGIN)
+targets += $(LLVM_PLUGIN)
+clean-files += *.so
+
+# Run llvm-config only to build a plugin, not when this Makefile is parsed
+llvm_cxxflags = $(shell $(LLVM_CONFIG) --cxxflags)
+llvm_ldflags = $(shell $(LLVM_CONFIG) --ldflags)
+
+quiet_cmd_llvm_plugin = HOSTCXX $@
+      cmd_llvm_plugin = $(HOSTCXX) -Wp,-MD,$(depfile) $(KBUILD_HOSTCXXFLAGS) \
+		$(llvm_cxxflags) -fPIC -shared $(KBUILD_HOSTLDFLAGS) -o $@ $< \
+		$(llvm_ldflags)
+
+$(obj)/%.so: $(src)/%.cpp FORCE
+	$(call if_changed_dep,llvm_plugin)
+
+$(obj)/../../include/generated/llvm-plugins.h: $(addprefix $(obj)/, $(LLVM_PLUGIN)) FORCE
+	$(call if_changed,touch)
+always-y += ../../include/generated/llvm-plugins.h
-- 
2.43.0

