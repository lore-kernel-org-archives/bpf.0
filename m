Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287467;
	b=hKh+fA4aZ1Bj8Kjm2BsdSbd7VGsNE3ZR4hnG0KvEo2Bh6RV4aHRt3GY0XawZkIxchpQy
	 QJTyBvw8/w/7DayQUSe9Yjfh5B2WlGgPHcRabuZyBZl2OiAI3lDm/3bNwSA4AvWfjQUBP
	 YN7XuosXdOnoC+5nJJyd6OrcEWXEpQS7rTXVoMO/bZh0fZ2/OwuO8FO7sAve5W0YZw80Y
	 XX8JAl3vmW2Svjt1fq+g+mxMagABsiKe3qo1HBOReLg3UuUVFdnqhZlWKE3F93NHKCKll
	 SGxN2r5p9f+YNvPmPy07qhGHpttr865f4i+hFifJeEf/tH+eSSHJn/punVxxMo8iUEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=LqUQbtPft1j46GYypYCN7/YQGyvs+Nf1fNrdAmWoWxc=;
	b=f0wItVsHYeRfv9Ni4M7ZtURbcYVIlAsLjUhjaE6L+ZVHjPEtJmH58mtrhlha2EsjpiPb
	 2UcfINazGazWnzNbOKPIOIZQ5VwULww3lleI/lu5p3S0d550457olatenyY0NRuDUO6Xm
	 PQ0Rbjl8qsugNSNlCku/8/vGm6MapP4Oc7pW3j8w9tPc6iuXicuRs72xyxqBOTwgubFYC
	 xuBgIkobXUU8AIHhnYTMzNHNfTtp35SCLBEkmslnN9fOmYYHLoFWmI36NYkcjOKXRhYN9
	 ed8McJfirFGAT9aN293n6SB1xWRd1eBqeWSIwAkDI+ZRuYWVQkJ+z2w/Uj35TkNfIqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM6QC3jI;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA1606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM6QC3jI
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae702d28c4so425485a91.3
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793287464; x=1793892264; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LqUQbtPft1j46GYypYCN7/YQGyvs+Nf1fNrdAmWoWxc=;
        b=LM6QC3jI1tgj22lK6Gy0qBKpgnNnhX2yvMeR62egvL8DqeZV8E/dj3BK9uQkOKO09S
         RUjK/wGTneatYkolZgEtAI0iPJ4CmndfoGfBLLbNpKhaDjMFTAZ9XdpNVadCTau7k0fH
         LL9VTOxdx97US5kAx3vLbAlTQSqV+8OAOP1mMQ2UITDAjQqgz3pRfLEbZHJkl6h9GD4f
         vvjrNWKbdrX4Ixyov3dYvASHHBkEisB3ICewF9NdxxBB5nO/t9TIExUFKcmkAX1lIF+m
         RBZMzzYWgguX13ou3inQldk8tu+cfaRstb5e6K+bsSIOxQfdSH5IrCIKiJ6hcP/syn+D
         MeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287464; x=1793892264;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqUQbtPft1j46GYypYCN7/YQGyvs+Nf1fNrdAmWoWxc=;
        b=W3x2MLgVyaYxJsm62XAd8UgCiw0e5TpKTg9Kt9cQPukHyHEpUy/qTH6OEvAHMq/q9C
         jT7xFzhoGk+8/qF/KGNznLluoB5LWwjdC+ma0sbH2k5D7ftWEhrPgEX/2bc/Yu0r0PmR
         AhhBorvpwSC8oJ+ZPMXlN8Txmxd1vjvjt+gan3ROqXDkwwmJAZWMwABfOvBvBRjdzNnu
         MtrOYChN/a1T1HRMODTdymGB0+wcw9JIDHgo0bDSOW1b4XkZWxhDTNX84lFKil8HlOHI
         OQbnthQvUz9uIS5eErZ5fx1Jd8HsGG4FUpYW7Yp9fqPmr+hjz6TddJ64nCW6dLXhVr+A
         EwHg==
X-Forwarded-Encrypted: i=1; AKwUvByy6zSzWpHXmNyUGzAfYjQLuoSwqxN80qGPpJ8dosEdVssATZhkcr8+fS5FDXnJkvCI3l0=@vger.kernel.org
X-Gm-Message-State: AFq9FYITF1gXVHkcmUsRFZYw1zBzz4qVoRJDxQtU2M4OZBQVbTXog+an
	zAb+xNGi7Wvw/xHUtcj/Sm3cAILNIvrUmOcUmSYQKsFq0YY6pcnuItmj
X-Gm-Gg: AYBFou2qUsnAHmKl8JAFuHQUVng8WzZzIedZm/kufm8zrfqmXoHhiksS7OwLKzGNT6l
	pNHfFwFsKB/QhusFXqpC4C9PtNlPe8bk0mwJ/zChO9jpUTPyKpF6M7RWqt8hVQky0/rSx1l8QGW
	1AAuWHVZBCklXJkbemGk0b8dOSFnfdMoK7Oo1C+P/Qyfr1X54lVONJeISnu1Py9w9C5YnN+huzA
	uHKfcSe/S/3H+qzI7+W69TjdBHroC7sMbJpIZswYnWXTM3S454LJjFBlgy2sjjrxH1bHBFcnOQV
	AmsT6+UCm3xcyM1Qs5oafcJ85k9QWvipvhk86qyh8h43PLWDR17PnBg1TGa0Ig/YSBqDqjNRtiR
	4l0Ywf1Vqfb9C0tu701Hp45fJpTloD/JsiK2LYXnePQusH9kYMlbBvvEUZYqAuS7drZYRG0Y9FD
	iYApyOzKAp780ulqzgzMU9CyEA3bhhmmYzG3X6VkdGXw28BijGBhqkIx4gHMe/BGQxSCERQuGtR
	H9Tv8Zrv3a/yMXOluHsov3fcU6eOuzYpxhi9KhPjn6nm7P95M9J6IL5moWqdYkM8CvTihbh/SbE
	nphJCKxDV+xvesXsbKuac2zLUuThtXK4KtNKOU4RfIQF3RuJbIjEAiFCGOFtlDWQgnQGkVcP9UJ
	+XUoqtvEjKr/Dy++aWTTPJZ7Pu3VEjtfQ0A==
X-Received: by 2002:a17:90b:48c7:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3ae57e346ffmr4072955a91.9.1793287463471;
        Thu, 29 Oct 2026 08:24:23 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c59a6sm3481124a91.3.2026.10.29.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:24:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 15:24:22 +0000
Message-Id: <DMHFCN3J36VN.2JJEE30A07C0Z@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <llvm@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <socketpair@gmail.com>, "Quentin Monnet" <qmo@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Nick Desaulniers" <ndesaulniers@google.com>
In-Reply-To: <20261029-bpftool-plugin-v3-2-87af799da40a@gmail.com>
References: <20261029-bpftool-plugin-v3-0-87af799da40a@gmail.com> <20261029-bpftool-plugin-v3-2-87af799da40a@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 06:05 AM Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org> wrote:
> Move the LLVM disassembler to a plugin, $(libdir)/bpftool/bpftool-llvm.so,
> that bpftool loads with dlopen() only when disassembling JITed programs.
> Distributions can then ship it as an optional package.
>
> The plugin exports a single structure of callbacks, with an ABI version
> checked by bpftool. bpftool looks for the plugin next to its own binary,
> then in its install directory, but not in the current directory since it
> usually runs as root. "bpftool version" reports "llvm" only if the plugin
> can be loaded.

This is overkill.
The plugin wraps 7 llvm-c functions and the target init calls.
bpftool can dlopen() libLLVM.so itself and dlsym() them.
perf does that for libcapstone. See
commit b5c9bcde61b8 ("perf capstone: Support for dlopen-ing libcapstone.so").

                     this patch                  dlopen(libLLVM.so)
  -----------------  --------------------------  ------------------
  installed files    bpftool, bpftool-llvm.so    bpftool
  who finds the lib  llvm_plugin_find()          ld.so
  ABI to maintain    struct bpftool_llvm_ops     none
  Makefile           libdir, llvm-plugin-dir,    one -D
                     install, uninstall rules

v1, v2 and v3 each look for the plugin in a different way.
The bpftool that the selftests build still doesn't find it.
selftests/bpf, selftests/hid, selftests/sched_ext and tools/sched_ext do:

  make -C tools/bpf/bpftool prefix= DESTDIR=<dir>/ install-bin

  bpftool           <dir>/sbin/bpftool
  plugin            <dir>/lib/bpftool/bpftool-llvm.so
  bpftool looks in  <dir>/sbin, then /lib/bpftool

"prog dump jited" fails there with this patch.
"make install" in selftests/bpf copies only bpftool. The plugin stays behind.

In the diff below llvm-config gives the name of the library at build time.
ld.so finds it the same way as today.
The distro package recommends the LLVM libs and doesn't require them.
"bpftool version" keeps "llvm" as a compile time feature.
That's what common_options.rst says.
LLVM built with BUILD_SHARED_LIBS=ON is not handled.

Something like this (not even compile tested):

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168..7a49182 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -186,10 +186,15 @@ ifeq ($(HAS_LLVM),1)
   # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
   # compilation error due to redefinition. Let's filter it out here.
   CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
-  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
+    LIBS += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LIBS += -lstdc++
+  else
+    # Don't link with libLLVM.so. "prog dump jited" loads it with dlopen().
+    LIBLLVM_SO := $(shell $(LLVM_CONFIG) --libfiles $(LLVM_CONFIG_LIB_COMPONENTS))
+    CFLAGS += -DLIBLLVM_SO='"$(notdir $(realpath $(LIBLLVM_SO)))"'
+    LIBS += -ldl
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 0454115..cca02cd 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -25,6 +25,7 @@
 #include <bpf/libbpf.h>

 #ifdef HAVE_LLVM_SUPPORT
+#include <dlfcn.h>
 #include <llvm-c/Core.h>
 #include <llvm-c/Disassembler.h>
 #include <llvm-c/Target.h>
@@ -47,6 +48,88 @@ static int oper_count;

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
+#define LLVM_TARGET(t) "LLVMInitialize" #t "TargetInfo", "LLVMInitialize" #t "TargetMC",
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
@@ -135,6 +218,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
 	return count;
 }

+#ifndef LIBLLVM_SO
 int disasm_init(void)
 {
 	LLVMInitializeAllTargetInfos();
@@ -142,6 +226,7 @@ int disasm_init(void)
 	LLVMInitializeAllDisassemblers();
 	return 0;
 }
+#endif
 #endif /* HAVE_LLVM_SUPPORT */

 #ifdef HAVE_LIBBFD_SUPPORT

Keep patch 1.

Also pls don't respin in 22 minutes only because a bot said something.

pw-bot: cr
