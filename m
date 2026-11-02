Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793623455;
	b=SW0Z9zZd9a5fExxPuT+IimKnqW0Pt/ZPeP/qQQQWOb3zBVS+jgPmjyew39GzAHOyjBal
	 tpV6OkCsdRWx8sHTEfGDeiU25c7X6Op8DHfFarN3xTfzt66cJ+P8m0GkGQXG68HqPYJSo
	 UP9VKNRCxS3fXcUZcROJfRqKYIbkc0TA0oPplHb2oZXkpz9P13sVPAELjaO9kvJIW7iTM
	 nxW8SwQ3GdVy4pSuXQabT+lfn6cb+FV7c3uFbNu3BzCeeHhKKbWly0OAA5M2IINGXENR0
	 OWqT8/ViJt6Ut9Qz0RGD9SBkzEJ7E2OzjenwmLBfYegpZZbf194wAC+N2MqZu9eI5vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623455;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YJ0MEdP/OpEvDHQppLVI3yiWJWVlPZMuIhPkYtaqjuY=;
	b=0Uohw8fQck8x0jy8rKlI6IV6318n+jayNlfnx4+vDSW+6p454n8qQVDO73yovBkpqym2
	 355sZ8vSdV6cRjnltRZW4QWy8FvybfUP5R/OQPGrBqZ+gmRiP76YAm+YycltzJvaZeo3D
	 qA6HuhniTvwr9fLcAaq2DlwYZ/BW+vQaY1HsSOGhfpRoWLtowVTuk6pXhwdIAAcqbC0cQ
	 iZ2K9ZkW9WhY6aTOZH2kATeBKMua3A72fBjYKJRa2yQsRT+tfDln0JUzH4Ah1p9Wri8Rk
	 d9HuAVsOLg2kaHCKQkJK0bInVFf9vPEIOIJdy6CI6aPZkeOCb/ree/tLO7HGZr3O1Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBiVf7yO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21173606A337;
	Mon,  2 Nov 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBiVf7yO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793623454;
	b=UUj+NdoBjby6NzBwktSsJIyjMhbKvZPJcq6WTyMl+9MfBi57q9BJ1JiPjBdCeu0NyKzK
	 BfUQHfRXFYVcGdxIwFzPX0LeFK0Uj5yWf++x42qqFJ4CPrMkIQB7Yp/2/ksBayNBpubcu
	 76s2Pvj8o5xD1KgjnG+7MFsH3b0HpzP6rmHPWrOG/8L6JP0PGnMR8t61YDAOk4PtPT6Zq
	 q2Ry7ztyWIes+ay19YxFn/FUiBKECyuv0AKim2n7vQXIiWXB4TJiz6Va6ColTDyheVaad
	 Ue5gI1+nWMwGQhMssYc2COOwkFYPdRusrR2gKHYtLCthc5pzxpmnQ5hdGc3FONwC6vw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793623454;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YJ0MEdP/OpEvDHQppLVI3yiWJWVlPZMuIhPkYtaqjuY=;
	b=jMOdLV8qAc1sApLFpsEXblw0SLFrvxXpyH6FuYbsicyc9A4VsonyAsFbAC0pAiazTF1l
	 7y4Mqh7TsdZ1zM9agSitn3jx9u1UJ0MZEGAPYBgrWBRsyWw4Ie2L/oyCrxXIfVoNLxFZt
	 +hqhSsRus+Qah/maCUbOev82FbP1k0+2bg9gG5ufMaoHG4cC9GCvg176IkB1uYNr8wIPU
	 zSYjYGh6CJ0+Zg+Oi/remwCzRb2bl8oZM7iKsXPSsFdPuCFTH5Uz9ynZZzh+XzB6e9ulM
	 rVtrrHZSy96r5UsmkXwDZLDZu9tm9z1GsfYCLWeP95QBVMlIqQEQ3GHbwjCXXRBgYYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 381BA1F00A18;
	Mon,  2 Nov 2026 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623453;
	bh=YJ0MEdP/OpEvDHQppLVI3yiWJWVlPZMuIhPkYtaqjuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EBiVf7yOlNu9FSLXGJG62bKkVhlqKaNvNT194/ynr+LBQ5yqWHBnv5NEs2jrIQb4j
	 Gpjs7YhO9c4T12JLx1OnmBn7ND6MhivbWTSdFmOx911yLlqUNcpGFae3ab3vQks1qO
	 eg6pw05hVClymlFgNwUtERIvrUBponiQ/C3YbPMAAdZsEjbe7CFIW1oAEffrT7ydzv
	 C9qsC3KwgLdscmhla1Lg6/EvuBzNXGarO2Qrl3/aCT7DBu5HrB4uDYkfm/LEmrYrWe
	 rbxdMwVD0ni45nm2/r+gkETbny7gbow9/Do4n2Kska9Nw+TUJaDFFRHM1OQDu1MrAW
	 Li1h8yUNcYPyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B3A64464E1;
	Mon,  2 Nov 2026 12:44:12 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 17:44:12 +0500
Subject: [PATCH bpf-next v4 2/2] bpftool: Make the LLVM disassembler an
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
Message-Id: <20261102-bpftool-plugin-v4-2-5a853e973db9@gmail.com>
References: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
In-Reply-To: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793623450; l=5400;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=qS1vKaFei4x8R94EkIEUARWR3+po+AM+0LwZ2fhdRwI=;
 b=DNm+NtiRFKG+RSciLvDX559sC0GrIYDdYnL2qPt+IKL5zKx+0iMyqn0CBZAVELjXXTAkdhIu1
 8sxvHbnAnGlBEziRcM7aURaLhfVE0dh0psKHGRwu8ty6NrxUeylN0oB
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
disasm_init() loads it with dlopen(), under the name llvm-config reports
at build time, and resolves the few llvm-c functions bpftool uses with
dlsym(), like perf does for libcapstone. Distributions can then make LLVM
an optional dependency of bpftool.

"bpftool version" still reports "llvm" as a build time feature. Static
LLVM, and LLVM built with one library per component, are linked as before.

Link: https://github.com/libbpf/bpftool/issues/262
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 tools/bpf/bpftool/Makefile     | 10 ++++-
 tools/bpf/bpftool/jit_disasm.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..876bf3cf93e3 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -186,10 +186,18 @@ ifeq ($(HAS_LLVM),1)
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
+    # Don't link with libLLVM.so. "prog dump jited" loads it with dlopen().
+    CFLAGS += -DLIBLLVM_SO='"$(notdir $(realpath $(LIBLLVM_SO)))"'
+    LIBS += -ldl
+  else
+    # LLVM built with BUILD_SHARED_LIBS=ON, one library per component
+    LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 5ff144ce84a1..2c646626e256 100644
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


