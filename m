Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714398;
	b=2PcFYJAGbzrdfKZ0CR2SsSI9VszqSFYgG3Qte2O+TlaDWWohwwVLQguF0hxLwT41rzqm
	 LAkjkzZqw8VFkNnlvd1mCXsJW435pdCp0HDAuwWFiFYgjdE06YcKCGzjvQ3Dttzf5xy1K
	 nPp1/r0Kocp8vMbp96Z5G6CCxnb/FWax0VsaAYglUnrKC7V1R8MEUpHsTc5VZU1lmG3Z3
	 Zv04wqNphcQIqirmwa5xuNjBEPr98b5J/l19gjeTnjNf0P3nqdNvi3OPlUVYemMTqT5uy
	 gq4Oeu3UAJiKLSHJWOx8+0e027lXAyEfrDzHmtfrG+BJxAUSixNGb6SRq4BS2nWddSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714398;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pN16lm3Ao82FPCCts1vS1JNs/B2bSmoMmxwOs808HJg=;
	b=nB+WBp1daZQZsapJ+kWZrkQp3c6f3MnYJQ0jGuM09Vo+h1tZhiUyjh7sIJitsWHg8BsC
	 fWD7rqeVB4St2SnHbsj0jJScDjeKWOz6tWwZHSxe0IwONFt2nx5xSOcSQcwXNJ9NlECZc
	 emQsM2OmkgqnVUiN8GdTt31SpOFs2Ji42+b8beVJQIj5DWUECj8Y62vg/4hoMXIPzL6ew
	 jGpORVdNDOftyisEXcgCghk8Sr6etnSmo1vHXXF7P9teCFN2SkwCrOjpr961nor9StARF
	 yQ2Bt8hJPAP9J86Acy8/rYbaFU2fJicz07DuGbGuEXwo5sX2dhjdtI58Fdr2rTu3GwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9aRIEkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA4606EE90;
	Tue,  3 Nov 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9aRIEkG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793714396;
	b=hZ1rjVbvbdlZHW9mDRwIVjc92bykTB4213txWtU4LCi8u3YMVYpMBX/fPjMHGZN+Y4Z3
	 zWAd54PvPRFp9PeIlCfKipymTbj19+v8/d2zUmN51G1PmiSR44UpY1kGoHP8W+HpglOTE
	 jmceAc2aiGB6mGbpx5452HN1q0WO1j5rWG9JJ5h6vi8X66zQHyAMB1m7mmpAuG9fEhi2h
	 vQXwYzrtOvCuAGqf0qk436Ue96NeigQLzN0qdfsbgvFMpuoJzAldcbeDcSnDYYi3Mf9+b
	 cDeG/iiENfsqeBsUkB66tA0ovg3uvzTsY6YalHM9skhACDhhTXrUmjOYRxFJRz4jwYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714396;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pN16lm3Ao82FPCCts1vS1JNs/B2bSmoMmxwOs808HJg=;
	b=hw38sa5hUq2Sd8fqWTxVAbPehM0bEtxZoz42P5ro0mDN8Rk33BWVpJLY84Vd6FWogiq8
	 NVuR6B8pCIIjH1nrI17n+8j2T94gjJ9gI52/AP8Sqayg61jIk2ePjQC+TBo2jRJfMf8vE
	 77Ru25eQkMQxGXZmLcirruT1un8AJgVD/v+kt8gmWjgA6M/+YDy29QGxxAxrHzq71D4/N
	 VZ7JlLTEz1SSn8joTuKZe/RhruDiBHdtOotQWZP+quY3CJNP5keJt23DJfetR+JWHrj14
	 HbhbflbEaEqJGCwhAQt/UTAo/z7DoaJy4HeqZBF+MIdxo9KzCLXLx+m9LoMmera5llw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BAA411F00A02;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714396;
	bh=pN16lm3Ao82FPCCts1vS1JNs/B2bSmoMmxwOs808HJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X9aRIEkG85ANfcM3h4hVrRcHYV0tHwGmb+C3kiA89xvK1r85q0bSxNqFXOnz/jNkL
	 qW7SKXjlTsL1MHlXCHnxf86AN+6Ywkc1RsEZMiWwSMOpA2bwPNHCdDZKMNg6zXTXEv
	 Pr26LbvMtZ/g43BsWC7gFqI38tqVnciJrwy8k/1dTjr4sHmuua3zj/8HIxVYc2bT1G
	 pSHMyo3d4rpOmiGBTZDVm9QXhZD2WKbt9qv/aAiheZYC0FNCwDGRi4ALC9PcTi4Coy
	 03rNawIA9h4wOpXxrUdFfN+WYTvkatUayH7gmvEe0b1zgJfXWm0spV5FyD0+XTYgq3
	 xEjV9w4sfcsOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 48DDD46989;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 18:59:55 +0500
Subject: [PATCH bpf-next v5 3/3] bpftool: Make the LLVM disassembler an
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
Message-Id: <20261103-bpftool-plugin-v5-3-683e08a25df0@gmail.com>
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
In-Reply-To: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
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
 Nick Desaulniers <ndesaulniers@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793714393; l=7039;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=3dDAosnyE94NMtj/8b2EU45HkmtEBU2i9iXb/AyeRnI=;
 b=WrSxL7L+pULTJafcSdpjC3Ucgo+owqxvUhcEpiYDpZNZpvwXJl+87DHg8qPMVDuKYRXGHFnWx
 Kl899Vt5naSAKyRuCdIRboORqK1NgRCSDdZBkzGoiO/R6Q4aq3oXF6H
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

When libLLVM is a shared library, don't link bpftool with it. Instead,
disasm_init() loads it with dlopen(), under its soname read at build
time, and resolves the few llvm-c functions bpftool uses with dlsym(),
like perf does for libcapstone. Distributions can then make LLVM an
optional dependency of bpftool.

"bpftool version" still reports "llvm" as a build time feature. Static
LLVM, and LLVM built with one library per component, are linked as before.

Link: https://github.com/libbpf/bpftool/issues/262
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 tools/bpf/bpftool/Documentation/common_options.rst | 10 ++-
 tools/bpf/bpftool/Makefile                         | 16 +++-
 tools/bpf/bpftool/jit_disasm.c                     | 86 ++++++++++++++++++++++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
index 9234b9dab7682..b00fff6195e51 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -6,10 +6,12 @@
 -V, --version
     Print bpftool's version number (similar to **bpftool version**), the number
     of the libbpf version in use, and optional features that were included when
-    bpftool was compiled. Optional features include linking against LLVM or
-    libbfd to provide the disassembler for JIT-ted programs (**bpftool prog
-    dump jited**) and usage of BPF skeletons (some features like **bpftool prog
-    profile** or showing pids associated to BPF objects may rely on it).
+    bpftool was compiled. Optional features include LLVM or libbfd to provide
+    the disassembler for JIT-ted programs (**bpftool prog dump jited**) and
+    usage of BPF skeletons (some features like **bpftool prog profile** or
+    showing pids associated to BPF objects may rely on it). A shared libLLVM
+    is only loaded to disassemble JIT-ted programs, so "llvm" is listed even
+    if it is not installed.
 
 -j, --json
     Generate JSON output. For commands that cannot produce JSON, this option
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e79432..49dabf2eded04 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -186,10 +186,24 @@ ifeq ($(HAS_LLVM),1)
   # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
   # compilation error due to redefinition. Let's filter it out here.
   CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
-  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  LIBLLVM_SO := $(shell $(LLVM_CONFIG) --libfiles $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
+    LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += -lstdc++
+  else ifeq ($(words $(LIBLLVM_SO)),1)
+    # Don't link with libLLVM.so. "prog dump jited" loads it with dlopen(),
+    # under the name the linker would put in DT_NEEDED.
+    LIBLLVM_SONAME := $(shell LC_ALL=C $(READELF) -d $(LIBLLVM_SO) | sed -nE \
+	's/.*\(SONAME\).*\[(.*)\]/\1/p')
+    ifeq ($(LIBLLVM_SONAME),)
+      $(error Cannot read the soname of $(LIBLLVM_SO))
+    endif
+    CFLAGS += -DLIBLLVM_SO='"$(LIBLLVM_SONAME)"'
+    LIBS += -ldl
+  else
+    # LLVM built with BUILD_SHARED_LIBS=ON, one library per component
+    LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 5ff144ce84a1c..2c646626e2560 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -25,6 +25,7 @@
 #include <bpf/libbpf.h>
 
 #ifdef HAVE_LLVM_SUPPORT
+#include <dlfcn.h>
 #include <llvm-c/Core.h>
 #include <llvm-c/Disassembler.h>
 #include <llvm-c/Target.h>
@@ -47,6 +48,89 @@ static int oper_count;
 
 typedef LLVMDisasmContextRef disasm_ctx_t;
 
+#ifdef LIBLLVM_SO
+/*
+ * libLLVM.so is big and only "prog dump jited" needs it. bpftool is not linked
+ * with it. disasm_init() loads it.
+ */
+#define LLVM_FUNCS(F)			\
+	F(LLVMCreateDisasm)		\
+	F(LLVMCreateDisasmCPUFeatures)	\
+	F(LLVMDisasmDispose)		\
+	F(LLVMDisasmInstruction)	\
+	F(LLVMDisposeMessage)		\
+	F(LLVMGetDefaultTargetTriple)	\
+	F(LLVMNormalizeTargetTriple)
+
+#define F(fn) static __typeof__(&fn) p_##fn;
+LLVM_FUNCS(F)
+#undef F
+
+static const struct {
+	const char *name;
+	void *ptr;
+} llvm_funcs[] = {
+#define F(fn) { #fn, &p_##fn },
+	LLVM_FUNCS(F)
+#undef F
+};
+
+/* The functions that LLVMInitializeAll*() in llvm-c/Target.h call */
+static const char * const llvm_init_funcs[] = {
+#define LLVM_TARGET(t)	"LLVMInitialize" #t "TargetInfo",	\
+			"LLVMInitialize" #t "TargetMC",
+#include <llvm/Config/Targets.def>
+#define LLVM_DISASSEMBLER(t) "LLVMInitialize" #t "Disassembler",
+#include <llvm/Config/Disassemblers.def>
+};
+
+#define LLVMCreateDisasm		p_LLVMCreateDisasm
+#define LLVMCreateDisasmCPUFeatures	p_LLVMCreateDisasmCPUFeatures
+#define LLVMDisasmDispose		p_LLVMDisasmDispose
+#define LLVMDisasmInstruction		p_LLVMDisasmInstruction
+#define LLVMDisposeMessage		p_LLVMDisposeMessage
+#define LLVMGetDefaultTargetTriple	p_LLVMGetDefaultTargetTriple
+#define LLVMNormalizeTargetTriple	p_LLVMNormalizeTargetTriple
+
+static void *llvm_sym(void *lib, const char *name)
+{
+	void *sym = dlsym(lib, name);
+
+	if (!sym)
+		p_err("%s is not in %s", name, LIBLLVM_SO);
+	return sym;
+}
+
+int disasm_init(void)
+{
+	void (*init)(void);
+	void *lib, *sym;
+	size_t i;
+
+	lib = dlopen(LIBLLVM_SO, RTLD_NOW);
+	if (!lib) {
+		p_err("failed to load %s: %s", LIBLLVM_SO,
+		      dlerror() ?: "unknown error");
+		return -1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(llvm_funcs); i++) {
+		sym = llvm_sym(lib, llvm_funcs[i].name);
+		if (!sym)
+			return -1;
+		*(void **)llvm_funcs[i].ptr = sym;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(llvm_init_funcs); i++) {
+		init = llvm_sym(lib, llvm_init_funcs[i]);
+		if (!init)
+			return -1;
+		init();
+	}
+	return 0;
+}
+#endif /* LIBLLVM_SO */
+
 static int printf_json(char *s)
 {
 	s = strtok(s, " \t");
@@ -135,6 +219,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
 	return count;
 }
 
+#ifndef LIBLLVM_SO
 int disasm_init(void)
 {
 	LLVMInitializeAllTargetInfos();
@@ -142,6 +227,7 @@ int disasm_init(void)
 	LLVMInitializeAllDisassemblers();
 	return 0;
 }
+#endif
 #endif /* HAVE_LLVM_SUPPORT */
 
 #ifdef HAVE_LIBBFD_SUPPORT

-- 
2.56.0


