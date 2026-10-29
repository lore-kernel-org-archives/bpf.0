Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291412;
	b=xSR3/h4xJK9jhW0ln0teJObaSafDo0i9xz6y1AJ5SesWD3xsDqUR46QggjqzkdPeBz/R
	 iig7jYG+duKadCz/tAkKlwgVIv92N7OanRGEDd8TRAinWPl9/8a4+faNNvftba8RUEaGv
	 bTjQQiffWpU5SXDkItlz5SDCKrizUSTB+zDom0PsYcXOLTo07rRE8zvl3jIJcAmd9PZA0
	 ftbmm2AZOwJkK8OhYEmpvT7FkS71v/MwTnOldbx1TnhYOiSdAk5WCkD7CuasEhAKwuqu+
	 7Ie9JNFTgxlf2xusRcpwkWUQFT4TBC0YlFL0HhAMw2plnMMz4Qvt05nF/Z6sZBrtTVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=S42PX1tAWc2hW5QlTv4Vth3uzTG8jc+BIDEQLZi1wuM=;
	b=qoTp4XDFhKym8a+2NJm1KmdZQvNt9FbIiUdxCuz5kfxy0LYBo9gsfOIwxD5nQYzaqzTZ
	 i57WY4iMlA3mhTPFQVvKHaGMru19zW2kQvQv81MhgbDKjSQkWV71tjfPrNSh9WaILib7M
	 QTI8GgjUy+DCf0wE9ccnu6gC7ryo877epLjhQ0fsZ0vV54yCbTUO8t0hksXety2YywWBh
	 gRFi02oktjRLIIU2VDF54IAgQU2ulY5sYqniQmyEbt/We+TNPetb3p0Wmz55sbxIw7CmD
	 /9hruwSGOAb4UhiBelzlmHyGAEPXeHLBRa7V0vyc/MGA1Dxq9XA5CTWkKawGd2WR+jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V+xf9yhk;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15460A2629
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F15460A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V+xf9yhk
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so4721779eec.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793291412; x=1793896212; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S42PX1tAWc2hW5QlTv4Vth3uzTG8jc+BIDEQLZi1wuM=;
        b=V+xf9yhk5oDzRPyig7o2rUpqESHx9yBXvctsISy3UPowl+3e2wNaat2gcoSUFPuwMy
         tHKfTnClUwYlAqLZgARdC91yO2lpHNWuLgTUfWdyGjrad6rBkLDDmXi60HhXxDFb94Su
         yKlXHJZ/n3gECUKgaiOa5xlQ1mEY9yfF6msVca+MzRVkZw8MiNW7CeHKH3/X/mMy4wwL
         M84TX1/CHq2VoPYnmjgVTP/rgyXoel2/erQWzbHFo2Tx7niXb05m3pDclqK2f1XiRXYL
         ZkErdZSwVYSlPfsFKITpdCqC+mN5lTLFoHDBJncwBdOY1IBffxMkqXAV19DOYQKbqrFY
         FUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291412; x=1793896212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S42PX1tAWc2hW5QlTv4Vth3uzTG8jc+BIDEQLZi1wuM=;
        b=AP4v1dmLjZunLnjOdZTB4zpRmuwWbsx8Zx+UAjsH98C7hg+hsqgX7JWQpemdE5hsJS
         QaXAxx/VsqypbG6sxqhy9NS3m+cA9gsfSLU37Mfd4LYwx8D2zyRfPojmPnpDeqsN3Sae
         1V9nq/U2rqYUb3TgxqPy+ui9vyGXeBUoA7bpnqiZKjzMIufuYwDbIpIenCJlo28BrLT+
         RJ0GxbiFiN9bmyi5ZuCRQkUcAV/3X96bbf6jSUZaJxT7fXjZNRd0ei/DTkRA9ssxBeNa
         Otxtpg3y8M1OSFMf4C6Omc89vBM/hm2ESwOP3jBzEbxW9kyRikf6DtMDVSZnzVf4cW7V
         dQqg==
X-Forwarded-Encrypted: i=1; AKwUvBwab010ujCOAwnq9R6Kbnsac7hYyj5SpNpfp53bvMVFl813qpZNpo8aSAfGH+d+wlzcmFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYImgXAneT15K+7gfiFai5GqtUZ7VQ0WPRWIV2sv/S4X4/38MJjD
	oHK0KxxVC0X4Wob5fBrz99fedYcEGrub3SCajUVoDO/98aaazVCndnD7+s43cDaqdCPVPeCvcDF
	JPKbByyFtPw==
X-Received: from dycoy6.prod.google.com ([2002:a05:7301:fc06:b0:35a:f5b8:c8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fc0d:b0:368:9553:f2da
 with SMTP id 5a478bee46e88-36a204402d7mr8693177eec.31.1793291411212; Thu, 29
 Oct 2026 09:30:11 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:29:57 -0700
In-Reply-To: <20261029162958.3224280-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029162958.3224280-3-irogers@google.com>
Subject: [RFC PATCH v1 2/3] perf build: Prefer zlib-rs over zlib when available
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Quentin Monnet <qmo@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Detect and prefer zlib-rs over C zlib in the perf build unless disabled
with NO_ZLIB_RS=1 (or NO_ZLIB=1 / NO_RUST=1):

- Move Rust compiler detection ahead of zlib detection in
  tools/perf/Makefile.config and use feature_check + feature_rust_lib for
  zlib-rs, setting both HAVE_ZLIB_SUPPORT and HAVE_ZLIB_RS_SUPPORT when
  zlib-rs is used and falling back to C zlib (-lz) otherwise.
- Build and clean libz_rs.a in $(OUTPUT)libz_rs/, pass ZLIB_CFLAGS when
  building static libbpf, and share RUST_OUTPUT with the host bootstrap
  bpftool build in tools/perf/bpf_skel.mak.
- Expose 'zlib-rs' in 'perf check feature' / 'perf version --build-options'
  and document it in perf-check.txt.
- Add zlib-rs package mappings to tools/perf/scripts/install-build-deps.sh
  and NO_ZLIB / NO_ZLIB_RS build tests to tools/perf/tests/make.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore                    |  1 +
 tools/perf/Documentation/perf-check.txt  |  1 +
 tools/perf/Makefile.config               | 89 ++++++++++++++----------
 tools/perf/Makefile.perf                 | 32 ++++++++-
 tools/perf/bpf_skel.mak                  |  8 ++-
 tools/perf/builtin-check.c               |  1 +
 tools/perf/scripts/install-build-deps.sh |  6 ++
 tools/perf/tests/make                    |  9 +++
 8 files changed, 105 insertions(+), 42 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3b968c5158b8..8a5df9c9e8ae 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -55,6 +55,7 @@ libbpf/
 libperf/
 libsubcmd/
 libsymbol/
+libz_rs/
 fixdep
 Documentation/doc.dep
 python_ext_build/
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 1406a41c5d09..dda75b1d9cbd 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -66,6 +66,7 @@ feature::
                 numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
                 python-module           /  HAVE_PYTHON_MODULE_SUPPORT
                 zlib                    /  HAVE_ZLIB_SUPPORT
+                zlib-rs                 /  HAVE_ZLIB_RS_SUPPORT
                 zstd                    /  HAVE_ZSTD_SUPPORT
 
 OPTIONS
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f..4313fca53aa7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -532,13 +532,57 @@ ifdef CORESIGHT
   endif
 endif
 
-ifndef NO_ZLIB
-  ifeq ($(feature-zlib), 1)
-    CFLAGS += -DHAVE_ZLIB_SUPPORT
-    EXTLIBS += -lz
-    $(call detected,CONFIG_ZLIB)
+ifndef NO_RUST
+  $(call feature_check,rust)
+  ifneq ($(feature-rust), 1)
+    $(warning Rust is not found. Test workloads with rust are disabled.)
+    NO_RUST := 1
   else
-    NO_ZLIB := 1
+    NO_RUST := 0
+    CFLAGS += -DHAVE_RUST_SUPPORT
+    $(call detected,CONFIG_RUST_SUPPORT)
+  endif
+
+  ifneq ($(CROSS_COMPILE),)
+    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+      $(error Unknown rust cross compilation architecture $(ARCH))
+    endif
+
+    RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
+  endif
+endif
+
+# Building zlib-rs from Cargo crate sources requires a working rustc.
+ifneq ($(NO_RUST), 0)
+  NO_ZLIB_RS := 1
+endif
+
+# Prefer zlib-rs over C zlib when available, unless disabled via NO_ZLIB=1 or
+# NO_ZLIB_RS=1. Both provide the standard zlib C API (HAVE_ZLIB_SUPPORT), while
+# HAVE_ZLIB_RS_SUPPORT records that zlib-rs is the implementation in use.
+ifndef NO_ZLIB
+  ifndef NO_ZLIB_RS
+    $(call feature_check,zlib-rs)
+    ifeq ($(feature-zlib-rs), 1)
+      ZLIB_RS := 1
+      $(call feature_rust_lib,zlib-rs)
+      ZLIB_CFLAGS := $(FEATURE_CFLAGS-zlib-rs)
+      ZLIB_LIBS := $(FEATURE_LIBS-zlib-rs)
+      CFLAGS += -DHAVE_ZLIB_SUPPORT -DHAVE_ZLIB_RS_SUPPORT $(ZLIB_CFLAGS)
+      EXTLIBS += $(ZLIB_LIBS)
+      $(call detected,CONFIG_ZLIB)
+      $(call detected,CONFIG_ZLIB_RS)
+    endif
+  endif
+  ifndef ZLIB_RS
+    ifeq ($(feature-zlib), 1)
+      ZLIB_LIBS := -lz
+      CFLAGS += -DHAVE_ZLIB_SUPPORT
+      EXTLIBS += $(ZLIB_LIBS)
+      $(call detected,CONFIG_ZLIB)
+    else
+      NO_ZLIB := 1
+    endif
   endif
 endif
 
@@ -908,7 +952,7 @@ ifdef BUILD_NONDISTRO
   else ifeq ($(feature-libbfd-liberty), 1)
     EXTLIBS += -lbfd -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z), 1)
-    EXTLIBS += -lbfd -lopcodes -liberty -lz
+    EXTLIBS += -lbfd -lopcodes -liberty $(ZLIB_LIBS)
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
@@ -1132,37 +1176,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   endif
 endif
 
-ifndef NO_RUST
-  $(call feature_check,rust)
-  ifneq ($(feature-rust), 1)
-    $(warning Rust is not found. Test workloads with rust are disabled.)
-    NO_RUST := 1
-  else
-    NO_RUST := 0
-    CFLAGS += -DHAVE_RUST_SUPPORT
-    $(call detected,CONFIG_RUST_SUPPORT)
-  endif
-
-  ifneq ($(CROSS_COMPILE),)
-    RUST_TARGET_FLAGS_arm	:= arm-unknown-linux-gnueabi
-    RUST_TARGET_FLAGS_arm64	:= aarch64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_loongarch	:= loongarch64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_m68k	:= m68k-unknown-linux-gnu
-    RUST_TARGET_FLAGS_mips	:= mipsel-unknown-linux-gnu
-    RUST_TARGET_FLAGS_powerpc	:= powerpc64le-unknown-linux-gnu
-    RUST_TARGET_FLAGS_riscv	:= riscv64gc-unknown-linux-gnu
-    RUST_TARGET_FLAGS_s390	:= s390x-unknown-linux-gnu
-    RUST_TARGET_FLAGS_x86	:= x86_64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_x86_64	:= x86_64-unknown-linux-gnu
-
-    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
-      $(error Unknown rust cross compilation architecture $(ARCH))
-    endif
-
-    RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
-  endif
-endif
-
 # Among the variables below, these:
 #   perfexecdir
 #   libbpf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..baad492277df 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -75,6 +75,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_ZLIB if you do not want to support compressed kernel modules
 #
+# Define NO_ZLIB_RS if you do not want to use zlib-rs for zlib support
+#
 # Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer support
 # for CTF data format.
 #
@@ -417,6 +419,15 @@ ifdef LIBBPF_STATIC
   CFLAGS += -I$(LIBBPF_OUTPUT)/include
 endif
 
+ifneq ($(OUTPUT),)
+  LIBZ_RS_OUTPUT = $(abspath $(OUTPUT))/libz_rs
+else
+  LIBZ_RS_OUTPUT = $(CURDIR)/libz_rs
+endif
+ifdef ZLIB_RS
+  LIBZ_RS = $(filter %/libz_rs.a,$(ZLIB_LIBS))
+endif
+
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
 else
@@ -741,6 +752,11 @@ ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
 endif
 
+ifneq ($(LIBZ_RS),)
+prepare: $(LIBZ_RS)
+bpf-skel-prepare: $(LIBZ_RS)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
@@ -808,12 +824,22 @@ $(LIBAPI)-clean:
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		EXTRA_CFLAGS="-fPIC" $@ install_headers
+		EXTRA_CFLAGS="-fPIC $(ZLIB_CFLAGS)" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT)
 
+ifneq ($(LIBZ_RS),)
+$(LIBZ_RS): | $(LIBZ_RS_OUTPUT)
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.rust LIBZ_RS_OUTPUT=$(LIBZ_RS_OUTPUT)/ \
+		RUSTC="$(RUSTC)" RUST_FLAGS="$(RUST_FLAGS)" $@
+endif
+
+libz-rs-clean:
+	$(call QUIET_CLEAN, libz_rs)
+	$(Q)$(RM) -r -- $(LIBZ_RS_OUTPUT)
+
 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
 		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
@@ -1026,7 +1052,7 @@ python-clean:
 		$(RM) $(OUTPUT)python/perf.pyi; \
 	fi
 
-$(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
+$(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT) $(LIBZ_RS_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 bpf-skel-clean:
@@ -1050,7 +1076,7 @@ else # When an OUTPUT directory is present, clean up the copied pmu-events/arch
 endif
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
-		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
+		libz-rs-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
 		pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index f2559de39f96..d2ac4c4a7402 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -39,9 +39,15 @@ ifneq ($(WERROR),0)
   CLANG_OPTIONS += -Werror
 endif
 
+# When not cross-compiling, share the top-level $(OUTPUT)libz_rs/ directory
+# with the host bootstrap bpftool build so libz_rs.a is not compiled twice.
+ifeq ($(CROSS_COMPILE),)
+BPFTOOL_RUST_OUTPUT := RUST_OUTPUT=$(abspath $(or $(OUTPUT),.))/
+endif
+
 $(BPFTOOL):
 	$(Q)mkdir -p $(SKEL_TOOL_TMP_OUT)
-	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ bootstrap
+	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ $(BPFTOOL_RUST_OUTPUT) bootstrap
 
 # Paths to search for a kernel to generate vmlinux.h from.
 VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 1e43e097e7a7..fe1fc40561a9 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -59,6 +59,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
+	FEATURE_STATUS("zlib-rs", HAVE_ZLIB_RS_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
 	FEATURE_STATUS("rust", HAVE_RUST_SUPPORT),
 
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 3e53c7bf0f85..605dd9073589 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -146,6 +146,9 @@ fedora_pkg_for() {
 	zlib)
 		echo "zlib-devel"
 		;;
+	zlib-rs)
+		echo "rust-libz-rs-sys-devel"
+		;;
 	lzma)
 		echo "xz-devel"
 		;;
@@ -305,6 +308,9 @@ debian_pkg_for() {
 	zlib)
 		echo "zlib1g-dev"
 		;;
+	zlib-rs)
+		echo "librust-libz-rs-sys-dev"
+		;;
 	lzma)
 		echo "liblzma-dev"
 		;;
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..96567d9ea2a4 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -99,6 +99,8 @@ make_no_babeltrace2 := NO_BABELTRACE2=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_libpfm4     := NO_LIBPFM4=1
+make_no_zlib        := NO_ZLIB=1
+make_no_zlib_rs     := NO_ZLIB_RS=1
 make_with_gtk4      := GTK4=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
 make_tags           := tags
@@ -193,6 +195,8 @@ run += make_no_sdt
 run += make_no_babeltrace2
 run += make_with_coresight
 run += make_no_libpfm4
+run += make_no_zlib
+run += make_no_zlib_rs
 run += make_refcnt_check
 run += make_help
 run += make_doc
@@ -302,6 +306,11 @@ test_make_install_pdf_O  := $(test_ok)
 test_make_libbpf_dynamic :=   ldd $(PERF_O)/perf | grep -q libbpf
 test_make_libbpf_dynamic_O := ldd $$TMP_O/perf | grep -q libbpf
 
+test_make_no_zlib             := test -x $(PERF_O)/perf && ! $(PERF_O)/perf check -q feature zlib && ! $(PERF_O)/perf check -q feature zlib-rs
+test_make_no_zlib_O           := test -x $$TMP_O/perf && ! $$TMP_O/perf check -q feature zlib && ! $$TMP_O/perf check -q feature zlib-rs
+test_make_no_zlib_rs          := test -x $(PERF_O)/perf && ! $(PERF_O)/perf check -q feature zlib-rs
+test_make_no_zlib_rs_O        := test -x $$TMP_O/perf && ! $$TMP_O/perf check -q feature zlib-rs
+
 # Feature tests are allowed to fail, so a broken C++ compiler command line
 # doesn't fail the build, it just quietly turns off everything that needs a
 # C++ compiler. Check a feature that does, otherwise these tests would pass
-- 
2.56.0.313.g2479322e68-goog

