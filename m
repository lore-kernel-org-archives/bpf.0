Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277821;
	b=S99o+8qqtayaE4vd/GrYC9IJJi2gDF0fBJ2dsg7d+QhqIjnTOYkG4HjPCerTDIBClFKu
	 JcPH+5afH09S+R2PcS9PF0Mv3fpQfcSp+xeu4Sym4g4VqGt3YWciVWAbXuGFSonCNzADe
	 EZXkv3vh4QUGGeHegQ+61MyUmFsFavElAuxZJjh8ukFfneSkMNaRdbsw/ow4+pQOJ1/A+
	 x30SFVp3Icwv65E6SfMygCrhbrsYD2cFGgO3vK12c4HdUSD2SpjswHc4sLIEgs6QzAAFE
	 kvi19pNj0wcadDdGsyI8yR7v8vlGz4jBhWH0XXrp/RYkvisr8wyvvIUOL/K3v4OQZ5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277821;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hg28rtrOGjFELOx3dbl+ZN1Ma7yCgZvatc0SYPUgKBc=;
	b=Jz39wvaH3KKUilnDw8ahIzIJU1lHl8nEOI2bCULOD8TJbvi/j9e7ABCyNmt9JjtuSn4D
	 e6fFunVvNYf/66sEpZ6u5uj6DBgd40icISVwQRjweqsb5fTPL7Rz76HxsxC4ewxDWEfTa
	 Rb6ZMj5a6coyx/rqqIEb7nTd2BCiSQQwjc9GPEbymwxgRaVnHyZEtdKcZFrQ5c3IdAhyz
	 daD1Xg0PuonIs3DP17JiIH7xthbKJIlIOPuEwSBjaU0AVjwBYMjYeQti7Y5BZxsPcLUeE
	 lW4AG4F1Eu2Ym5kze2NjRwDVTG3AlcB+fSOoM37ZZ5QO0Vg6zx9oSQoHuvHRK4Q4bCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvA46Dqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B312606A327;
	Thu, 29 Oct 2026 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvA46Dqv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793277821;
	b=y5kNXpTVBsEd0vnEcFGNjot6gr6NhdjReS9tfIEHZZhQ9TXOlzhsynQ2prkMR15NZnKm
	 r1XoAbbvdw0si200aFcXO78bbXQcCTBmOaVo/7TQcw4Ad8PtKmG7KlaX55iKPe/1kGai6
	 ZCXRvAB+5MHNO3Blnx66ZQqNdxl/oWCWYdhWRM1uK9zEHiWLHiYvJ9VXVdGTOcltsloKW
	 oSziKkY4vpboRtiOGiZ3AW7amSZS00l/x5Yx/45DPXo1Ed6LXS1dsC73Ln3x9jr3XMY+Y
	 1LPHRksH0OHZkJVnidQtA3m5y89I42bjMU41Jc9Xvn/ACxOxzcR9R3wtOzP4tUPJUmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793277821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hg28rtrOGjFELOx3dbl+ZN1Ma7yCgZvatc0SYPUgKBc=;
	b=KEe5eQ8Q2KaAaVu8M6SH8VreN/qE/h8i7hUC6MeD1OFpSi0VNHjOv7GaAOlq2wN88x/L
	 p2YPIj8IBquQKCu4zdrVJ8YGaybMzjY3y4YYImjWwh3vQj8WmJFS9mNofFfVHwlrwnHz+
	 YfnXXjPBN8uHMUYYxGdzTN2/RWRA40wNyPNuF4E/u2RtNelFbn5LM7ArIFh/ISYtq7HcC
	 V40+24foQzWYBXIzkiNhHMEOtIUQ0tWgpQgFZFnwd77xPPXdxWlXeHYVTniaBzQ70C/50
	 QkYQeOBZHOzUGgn9RtvSVHQRuI0M0IXA5MuuXQqVKzJTW0NWGVcub62oii9784Jc2HA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DBE071F031E0;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793277821;
	bh=hg28rtrOGjFELOx3dbl+ZN1Ma7yCgZvatc0SYPUgKBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TvA46DqvaPHiVTqnftK/JT8EIQmdD+qi4HAXQMoglAMdsxnHFNtEeo83GLYFHxv9O
	 Ls1uaWEJZHS7BSSjYC+slYIqO024clgNsEqzWrJSRMDUgQUV7Z03HgOQ5azPw6EQ2U
	 yQt7Oticu0PJfRC7at3DfRGFnd9Untuz5ow4I4IjHGzONLrpxWUy2H5g0ctAstEeYy
	 uuc8tbfmMag16Hu3JPk0Q618v8aZYgHI2pZ6rQSU3OeWGls44lyR88KNKquhlEoph0
	 Br41ZWHPqMV9XJ3Cy8Yg3rfZ2e37VC849zY1tpmQnVlCLYCFMYjYPELPVrZUx4Olo4
	 ln7vDEwDriiYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 583914585F;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Thu, 29 Oct 2026 17:43:19 +0500
Subject: [PATCH bpf-next v2 2/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-bpftool-plugin-v2-2-1a47b2391b0b@gmail.com>
References: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
In-Reply-To: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793277817; l=16262;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=wcFNaUMQfgZ7HhTzuS/rQFb/W9GAq0HK9KYly9fQMp4=;
 b=q/msuS9B8FoRwRfrSHWM1CU9g8XJa/MJggjbHWN/5ez/SUxLpjMfpuac+mdoqLqjOp/qxvgG3
 34YeaXKYALwBtpTHylEE0W/ydLTiszOQ/XI93jB3CF80pBmNbdwy4Aq
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com
Content-Transfer-Encoding: 7bit

From: Mark Korenberg <socketpair@gmail.com>

libLLVM is only needed for "bpftool prog dump jited", yet it is a hard
dependency of bpftool: on Fedora 43, installing the ~730 KiB bpftool pulls
in ~140 MiB of llvm20-libs.

Move the LLVM disassembler to a plugin, $(libdir)/bpftool/bpftool-llvm.so,
that bpftool loads with dlopen() only when disassembling JITed programs.
Distributions can then ship it as an optional package.

The plugin exports a single structure of callbacks, with an ABI version
checked by bpftool. bpftool looks for the plugin in its install directory,
then next to its own binary, but not in the current directory since it
usually runs as root. "bpftool version" reports "llvm" only if the plugin
can be loaded.

If libLLVM is static, as required for a static bpftool, the disassembler is
linked into bpftool as before.

Link: https://github.com/libbpf/bpftool/issues/262
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 tools/bpf/bpftool/Makefile      |  38 +++++++++-
 tools/bpf/bpftool/jit_disasm.c  | 161 ++++++++++++++++++++++++++++------------
 tools/bpf/bpftool/llvm_disasm.c |  84 +++++++++++++++++++++
 tools/bpf/bpftool/llvm_disasm.h |  41 ++++++++++
 tools/bpf/bpftool/main.c        |   3 +-
 tools/bpf/bpftool/main.h        |   3 +
 6 files changed, 279 insertions(+), 51 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..dc8e4be86296 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -63,6 +63,7 @@ $(LIBBPF_BOOTSTRAP)-clean: FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) clean >/dev/null
 
 prefix ?= /usr/local
+libdir ?= $(prefix)/lib
 bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
@@ -170,7 +171,7 @@ include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool
 
-SRCS := $(wildcard *.c)
+SRCS := $(filter-out llvm_disasm.c,$(wildcard *.c))
 
 ifeq ($(feature-llvm),1)
 ifneq ($(SKIP_LLVM),1)
@@ -186,10 +187,19 @@ ifeq ($(HAS_LLVM),1)
   # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
   # compilation error due to redefinition. Let's filter it out here.
   CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
-  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
+    # No libLLVM.so dependency to avoid, link the disassembler into bpftool
+    SRCS += llvm_disasm.c
+    LIBS += $(LLVM_LIBS)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += -lstdc++
+  else
+    # Build the disassembler as a plugin, the only object linked against
+    # libLLVM, that bpftool loads only to disassemble JITed programs
+    LLVM_PLUGIN := $(OUTPUT)bpftool-llvm.so
+    CFLAGS += -DLLVM_PLUGIN_DIR='"$(libdir)/bpftool"'
+    LIBS += -ldl
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
@@ -290,6 +300,21 @@ $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
 
+ifneq ($(LLVM_PLUGIN),)
+all: $(LLVM_PLUGIN)
+
+$(LLVM_PLUGIN): CFLAGS += -fPIC
+$(LLVM_PLUGIN): $(OUTPUT)llvm_disasm.o
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -shared $< $(LLVM_LIBS) -o $@
+
+# The plugin directory, $(libdir)/bpftool, is compiled into jit_disasm.o.
+# Recompile it if libdir changes, e.g. on "make" then "make install libdir=...".
+$(OUTPUT)llvm-plugin-dir: FORCE
+	$(Q)echo '$(libdir)/bpftool' | cmp -s - $@ || echo '$(libdir)/bpftool' > $@
+
+$(OUTPUT)jit_disasm.o: $(OUTPUT)llvm-plugin-dir
+endif
+
 $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS) | $(BOOTSTRAP_OUTPUT)
 	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
 
@@ -303,16 +328,21 @@ feature-detect-clean:
 clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) -- $(OUTPUT)bpftool-llvm.so $(OUTPUT)llvm-plugin-dir
 	$(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
 	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT)
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
 	$(Q)$(RM) -r -- $(OUTPUT)feature/
 
-install-bin: $(OUTPUT)bpftool
+install-bin: $(OUTPUT)bpftool $(LLVM_PLUGIN)
 	$(call QUIET_INSTALL, bpftool)
 	$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(prefix)/sbin
 	$(Q)$(INSTALL) $(OUTPUT)bpftool $(DESTDIR)$(prefix)/sbin/bpftool
+ifneq ($(LLVM_PLUGIN),)
+	$(call QUIET_INSTALL, bpftool-llvm.so)
+	$(Q)$(INSTALL) -m 0755 -D -t $(DESTDIR)$(libdir)/bpftool $(LLVM_PLUGIN)
+endif
 
 install: install-bin
 	$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(bash_compdir)
@@ -321,6 +351,8 @@ install: install-bin
 uninstall:
 	$(call QUIET_UNINST, bpftool)
 	$(Q)$(RM) -- $(DESTDIR)$(prefix)/sbin/bpftool
+	$(call QUIET_UNINST, bpftool-llvm.so)
+	$(Q)$(RM) -r -- $(DESTDIR)$(libdir)/bpftool
 	$(Q)$(RM) -- $(DESTDIR)$(bash_compdir)/bpftool
 
 doc:
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 5ff144ce84a1..2691252a115b 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -25,10 +25,10 @@
 #include <bpf/libbpf.h>
 
 #ifdef HAVE_LLVM_SUPPORT
-#include <llvm-c/Core.h>
-#include <llvm-c/Disassembler.h>
-#include <llvm-c/Target.h>
-#include <llvm-c/TargetMachine.h>
+#ifdef LLVM_PLUGIN_DIR
+#include <dlfcn.h>
+#endif
+#include "llvm_disasm.h"
 #endif
 
 #ifdef HAVE_LIBBFD_SUPPORT
@@ -45,7 +45,105 @@ static int oper_count;
 #ifdef HAVE_LLVM_SUPPORT
 #define DISASM_SPACER
 
-typedef LLVMDisasmContextRef disasm_ctx_t;
+typedef void *disasm_ctx_t;
+
+static const struct bpftool_llvm_ops *llvm_ops;
+
+#ifdef LLVM_PLUGIN_DIR
+#define LLVM_PLUGIN_NAME "bpftool-llvm.so"
+
+static const char *dl_error(void)
+{
+	const char *err = dlerror();
+
+	/* The error may already be consumed, e.g. by an LD_PRELOAD-ed library */
+	return err ? err : "unknown error";
+}
+
+/*
+ * Look for the plugin in its install directory, then next to the bpftool
+ * binary so that bpftool also works from its build directory. Do not look
+ * in the current directory: bpftool usually runs as root, and would then
+ * load any library planted in the directory it is run from.
+ */
+static int llvm_plugin_find(char *path, size_t size)
+{
+	char exe[PATH_MAX];
+	ssize_t len;
+	char *dir;
+	int n;
+
+	snprintf(path, size, "%s/%s", LLVM_PLUGIN_DIR, LLVM_PLUGIN_NAME);
+	if (!access(path, F_OK))
+		return 0;
+
+	len = readlink("/proc/self/exe", exe, sizeof(exe) - 1);
+	if (len < 0)
+		return -1;
+	exe[len] = '\0';
+	dir = strrchr(exe, '/');
+	if (!dir)
+		return -1;
+	*dir = '\0';
+
+	n = snprintf(path, size, "%s/%s", exe, LLVM_PLUGIN_NAME);
+	if (n < 0 || (size_t)n >= size)
+		return -1;
+	return access(path, F_OK);
+}
+
+static int llvm_load(bool verbose)
+{
+	const struct bpftool_llvm_ops *ops;
+	char path[PATH_MAX];
+	void *handle;
+
+	if (llvm_ops)
+		return 0;
+
+	if (llvm_plugin_find(path, sizeof(path))) {
+		if (verbose)
+			p_err("%s not found in %s or next to bpftool, it is required to disassemble JITed programs",
+			      LLVM_PLUGIN_NAME, LLVM_PLUGIN_DIR);
+		return -1;
+	}
+
+	handle = dlopen(path, RTLD_NOW | RTLD_LOCAL);
+	if (!handle) {
+		if (verbose)
+			p_err("failed to load LLVM disassembler plugin: %s",
+			      dl_error());
+		return -1;
+	}
+
+	ops = dlsym(handle, BPFTOOL_LLVM_OPS_SYM);
+	if (!ops) {
+		if (verbose)
+			p_err("invalid LLVM disassembler plugin: %s", dl_error());
+		goto err_close;
+	}
+	if (ops->abi_version != BPFTOOL_LLVM_ABI_VERSION) {
+		if (verbose)
+			p_err("%s has ABI version %u, expected %u",
+			      path, ops->abi_version, BPFTOOL_LLVM_ABI_VERSION);
+		goto err_close;
+	}
+
+	/* Keep the plugin loaded until bpftool exits */
+	llvm_ops = ops;
+	return 0;
+
+err_close:
+	dlclose(handle);
+	return -1;
+}
+#else
+static int llvm_load(__maybe_unused bool verbose)
+{
+	llvm_ops = &bpftool_llvm_ops;
+	return 0;
+}
+#endif /* LLVM_PLUGIN_DIR */
 
 static int printf_json(char *s)
 {
@@ -63,48 +161,13 @@ static int printf_json(char *s)
 	return 0;
 }
 
-/* This callback to set the ref_type is necessary to have the LLVM disassembler
- * print PC-relative addresses instead of byte offsets for branch instruction
- * targets.
- */
-static const char *
-symbol_lookup_callback(__maybe_unused void *disasm_info,
-		       __maybe_unused uint64_t ref_value,
-		       uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
-		       __maybe_unused const char **ref_name)
-{
-	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
-	return NULL;
-}
-
 static int
 init_context(disasm_ctx_t *ctx, const char *arch,
 	     __maybe_unused const char *disassembler_options,
 	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len,
 	     __maybe_unused __u64 func_ksym)
 {
-	char *triple;
-
-	if (arch)
-		triple = LLVMNormalizeTargetTriple(arch);
-	else
-		triple = LLVMGetDefaultTargetTriple();
-	if (!triple) {
-		p_err("Failed to retrieve triple");
-		return -1;
-	}
-
-	/*
-	 * Enable all aarch64 ISA extensions so the disassembler can handle any
-	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
-	 */
-	if (!strncmp(triple, "aarch64", 7))
-		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
-						   symbol_lookup_callback);
-	else
-		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
-	LLVMDisposeMessage(triple);
-
+	*ctx = llvm_ops->create_context(arch);
 	if (!*ctx) {
 		p_err("Failed to create disassembler");
 		return -1;
@@ -115,7 +178,7 @@ init_context(disasm_ctx_t *ctx, const char *arch,
 
 static void destroy_context(disasm_ctx_t *ctx)
 {
-	LLVMDisasmDispose(*ctx);
+	llvm_ops->destroy_context(*ctx);
 }
 
 static int
@@ -125,7 +188,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
 	char buf[256];
 	int count;
 
-	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
+	count = llvm_ops->disassemble(*ctx, image + pc, len - pc, func_ksym + pc,
 				      buf, sizeof(buf));
 	if (json_output)
 		printf_json(buf);
@@ -135,12 +198,16 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
 	return count;
 }
 
+bool disasm_llvm_available(void)
+{
+	return !llvm_load(false);
+}
+
 int disasm_init(void)
 {
-	LLVMInitializeAllTargetInfos();
-	LLVMInitializeAllTargetMCs();
-	LLVMInitializeAllDisassemblers();
-	return 0;
+	if (llvm_load(true))
+		return -1;
+	return llvm_ops->init();
 }
 #endif /* HAVE_LLVM_SUPPORT */
 
diff --git a/tools/bpf/bpftool/llvm_disasm.c b/tools/bpf/bpftool/llvm_disasm.c
new file mode 100644
index 000000000000..b92df1e8966f
--- /dev/null
+++ b/tools/bpf/bpftool/llvm_disasm.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * libLLVM-based disassembler for JITed programs.
+ *
+ * This file is usually built as bpftool-llvm.so, the only bpftool component
+ * linked against libLLVM, which bpftool loads only when it needs to
+ * disassemble JITed programs (see jit_disasm.c). It is linked into bpftool
+ * directly when libLLVM is a static library.
+ */
+#include <string.h>
+
+#include <llvm-c/Core.h>
+#include <llvm-c/Disassembler.h>
+#include <llvm-c/Target.h>
+#include <llvm-c/TargetMachine.h>
+
+#include "llvm_disasm.h"
+
+/*
+ * This callback to set the ref_type is necessary to have the LLVM disassembler
+ * print PC-relative addresses instead of byte offsets for branch instruction
+ * targets.
+ */
+static const char *
+symbol_lookup_callback(void *disasm_info, uint64_t ref_value,
+		       uint64_t *ref_type, uint64_t ref_PC,
+		       const char **ref_name)
+{
+	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
+	return NULL;
+}
+
+static int llvm_init(void)
+{
+	LLVMInitializeAllTargetInfos();
+	LLVMInitializeAllTargetMCs();
+	LLVMInitializeAllDisassemblers();
+	return 0;
+}
+
+static void *llvm_create_context(const char *arch)
+{
+	LLVMDisasmContextRef ctx;
+	char *triple;
+
+	if (arch)
+		triple = LLVMNormalizeTargetTriple(arch);
+	else
+		triple = LLVMGetDefaultTargetTriple();
+	if (!triple)
+		return NULL;
+
+	/*
+	 * Enable all aarch64 ISA extensions so the disassembler can handle any
+	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
+	 */
+	if (!strncmp(triple, "aarch64", 7))
+		ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
+						  symbol_lookup_callback);
+	else
+		ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
+	LLVMDisposeMessage(triple);
+
+	return ctx;
+}
+
+static void llvm_destroy_context(void *ctx)
+{
+	LLVMDisasmDispose(ctx);
+}
+
+static size_t llvm_disassemble(void *ctx, uint8_t *bytes, uint64_t size,
+			       uint64_t pc, char *buf, size_t buf_size)
+{
+	return LLVMDisasmInstruction(ctx, bytes, size, pc, buf, buf_size);
+}
+
+const struct bpftool_llvm_ops bpftool_llvm_ops = {
+	.abi_version		= BPFTOOL_LLVM_ABI_VERSION,
+	.init			= llvm_init,
+	.create_context		= llvm_create_context,
+	.destroy_context	= llvm_destroy_context,
+	.disassemble		= llvm_disassemble,
+};
diff --git a/tools/bpf/bpftool/llvm_disasm.h b/tools/bpf/bpftool/llvm_disasm.h
new file mode 100644
index 000000000000..34123a80df02
--- /dev/null
+++ b/tools/bpf/bpftool/llvm_disasm.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef __BPFTOOL_LLVM_DISASM_H
+#define __BPFTOOL_LLVM_DISASM_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+/*
+ * Interface between bpftool and its libLLVM-based JIT disassembler.
+ *
+ * The disassembler is usually built as a plugin, bpftool-llvm.so, that
+ * bpftool loads with dlopen(); bpftool then looks up the
+ * BPFTOOL_LLVM_OPS_SYM symbol in it. The plugin can come from a different
+ * build than the bpftool binary, so bump BPFTOOL_LLVM_ABI_VERSION on any
+ * incompatible change to struct bpftool_llvm_ops, and always keep
+ * abi_version as its first member.
+ */
+#define BPFTOOL_LLVM_ABI_VERSION	1U
+#define BPFTOOL_LLVM_OPS_SYM		"bpftool_llvm_ops"
+
+struct bpftool_llvm_ops {
+	unsigned int abi_version;
+	/* Initialize libLLVM targets and disassemblers. Returns 0 on success. */
+	int (*init)(void);
+	/*
+	 * Create a disassembler context for @arch, or for the host if @arch
+	 * is NULL. Returns NULL on failure.
+	 */
+	void *(*create_context)(const char *arch);
+	void (*destroy_context)(void *ctx);
+	/*
+	 * Disassemble the instruction at @bytes, located at address @pc, into
+	 * @buf. Returns the size of the instruction, or 0 if it is invalid.
+	 */
+	size_t (*disassemble)(void *ctx, uint8_t *bytes, uint64_t size,
+			      uint64_t pc, char *buf, size_t buf_size);
+};
+
+extern const struct bpftool_llvm_ops bpftool_llvm_ops;
+
+#endif /* __BPFTOOL_LLVM_DISASM_H */
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index d15fec71b64e..321e928d651c 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -124,7 +124,8 @@ static int do_version(int argc, char **argv)
 	const bool has_libbfd = false;
 #endif
 #ifdef HAVE_LLVM_SUPPORT
-	const bool has_llvm = true;
+	/* The LLVM disassembler may be a plugin that is not installed */
+	const bool has_llvm = disasm_llvm_available();
 #else
 	const bool has_llvm = false;
 #endif
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b1eb4b5d991b..96d7b147aa9d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -214,6 +214,9 @@ static inline int disasm_init(void)
 	return -1;
 }
 #endif
+#ifdef HAVE_LLVM_SUPPORT
+bool disasm_llvm_available(void);
+#endif
 void print_data_json(uint8_t *data, size_t len);
 void print_hex_data_json(uint8_t *data, size_t len);
 

-- 
2.56.0


