Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291418;
	b=twrZCjD/cNI6eoLJqPHWJsRqt+CPFGKRENM7ZTiiApb/RxivOa8l5u+h5t8COGVge9GE
	 noO8xgQimYyY8MbC+tQI1e8QeaOzXBl6JYSZtpRfBmDVmTgvMaUfK8gHqv1BBWfWub04g
	 zcCMioOJUU1hPm63EyZy9vjApDZpVJGWjommu2RFmwQolquHc75+R1BVmlQ1vDA9ynbKq
	 7OxBBr3c0gosYOxzsrEGYV8aXqQci417DJdEHqxcSgQ9+LzrQY/7SySQBgtDTFnWcruBR
	 23Q6oPW2Ewo4f9vioSsU75LjpI81Ah75v3JhjQj1yw/15X7UN4+xnhRSh80qrGfF8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RTCYXgZDAP7kL0c73EPxbRM/Qq3+2h7CL6Elx37qtM4=;
	b=ZNnQHYmVLOJpAGObTeEjvgmgZxQYttRI1ET1OPcsWbSCQcx46puc5wRyJG3actmyiKAi
	 rG9hmVMSqFT3mgVvNuWsj/u+WikwxliitOveqrnUP4uiArP43p7VYn4KvTCwQyiOh5CxA
	 7bQMk7stKT/jZ8K8B9d4shuyDebUURvT4RphqSq8f8Rn5wyhXcdJTd3K0azvGV8RlTWFl
	 zbkSMPd5nSyAsCaN/RL4CCGpdusWy04/GgZ4hy/GFB5a8YtKiDnxwIt79AlgUEH99rUcV
	 9sbcrguKnKhzryyscF2xkFxZiE2IAKEdYcJS/uwEbLiKozsa/3qDKeNXgmgUF18N4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cz3zvFoG;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734760A381D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D734760A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cz3zvFoG
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso2584035eec.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793291416; x=1793896216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTCYXgZDAP7kL0c73EPxbRM/Qq3+2h7CL6Elx37qtM4=;
        b=Cz3zvFoGVxx+n4/1NGNRzbUOxTZxjZnueWzXnAt7fVTlP/+2Vyw+iRO5at6NM2LS4Z
         hpK36ZWQ5MEZPXaBNnRNZTuETMeQgL5BSdRv/b06Os2eNr29CWiUV3UZkOBxQc14vTt1
         9bYUgxKysN7hDzUb6U27ZKX5wdtk/wK3TO0Apv8WHYxnVYu4I/emkA7S7X0l50VOxtbe
         PhNeUfIBDf/0fRMY5Ogqy3O5pG4kl1YsVnnF1AcmsWflJ5oYOYSHY3BadTTgl59yUcPv
         Bx40bF5FE/TRE08DMXq6xjOAdKmJRLO1vww+6WohrtcHR2/ZelJT+VIrX9p/eDhqe46b
         pqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291416; x=1793896216;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTCYXgZDAP7kL0c73EPxbRM/Qq3+2h7CL6Elx37qtM4=;
        b=bLjQkCsdua4biook2iAOqlyCxtFGGlqF43NOyTjQ8Vfvv5Irq7Jubls/oUuQkgetYs
         wyq2lgN8ffj2Cyp/sBjDsJh1d2GuR1HGw1Nth9rkOemyrxzMIaeN6sO0mmjA3x1rzA/0
         b3M0XMyz0MMuZSEXVMELFPoODtgF+lqEsRUVjAGBrpN24JEwWYOOcQXRo/Wa0rggA8oH
         daUMKsZ17UuRnhv+mTPF4ngTIP0OIyKEa/ztqf7ZPmQDAvqVYEzUjbwRhNpyPI+Vw17f
         rSeg5BwFExDdF3Ml1Zfj4TXF/0y6RODlk+sUA9WHPJgQVsKZAcQMFytafWdofusosFgc
         MnKw==
X-Forwarded-Encrypted: i=1; AKwUvBxXipRgB829qyT54UFbKx/XtJczHw1zbM1Ht+liJdNqRjJRzBzUneE+LhtwQOzSKdoQGbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYw7d7F5tvkAsbO9I7+5r9bG6o9E+b/oJVUMlTNfWo7qdECObH
	44V9h9VLvjPpoi3m2d/o2TRVDM/PzeSspXm3GWlG2xJ0/n+VJLKqkdfkegaQx6iljfB84wa4m8X
	WSSZK0cTlSA==
X-Received: from dldyr26-n2.prod.google.com ([2002:a05:701b:451a:20b0:195:cde8:ab41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed0a:b0:168:3243:c907
 with SMTP id a92af1059eb24-1a6ced8f68emr7862817c88.24.1793291415705; Thu, 29
 Oct 2026 09:30:15 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:29:58 -0700
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
Message-ID: <20261029162958.3224280-4-irogers@google.com>
Subject: [RFC PATCH v1 3/3] bpftool: Prefer zlib-rs over zlib when available
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

Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected, falling back to -lz.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/.gitignore |  1 +
 tools/bpf/bpftool/Makefile   | 56 ++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index a736f64dc5dc..ea2222373634 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -6,5 +6,6 @@ bpftool*.8
 FEATURE-DUMP.bpftool
 feature
 libbpf
+libz_rs
 /*.skel.h
 /vmlinux.h
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..a193cf89a034 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 include ../../scripts/Makefile.include
+include ../../scripts/Makefile.arch
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
@@ -16,6 +17,8 @@ else
 endif
 BOOTSTRAP_OUTPUT := $(_OUTPUT)bootstrap/
 
+LIBZ_RS_OUTPUT := $(_OUTPUT)libz_rs/
+
 LIBBPF_OUTPUT := $(_OUTPUT)libbpf/
 LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
@@ -38,7 +41,9 @@ $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DI
 
 $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
-		DESTDIR=$(LIBBPF_DESTDIR:/=) prefix= $(LIBBPF) install_headers
+		DESTDIR=$(LIBBPF_DESTDIR:/=) prefix= \
+		$(if $(ZLIB_CFLAGS),EXTRA_CFLAGS="$(or $(EXTRA_CFLAGS),-g -O2) $(ZLIB_CFLAGS)") \
+		$(LIBBPF) install_headers
 
 $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
@@ -115,8 +120,20 @@ ifneq ($(SKIP_CRYPTO),1)
   CRYPTO_LIBS := -lcrypto
 endif
 
+ifneq ($(CROSS_COMPILE),)
+  ifneq ($(MAKECMDGOALS),bootstrap)
+    ifneq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+      RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
+    else
+      NO_ZLIB_RS := 1
+    endif
+  else
+    NO_ZLIB_RS := 1
+  endif
+endif
+
 ifeq ($(MAKECMDGOALS),bootstrap)
-FEATURE_TESTS := libelf-zstd
+FEATURE_TESTS := libelf-zstd $(if $(NO_ZLIB_RS),,zlib-rs) zlib
 FEATURE_DISPLAY :=
 else
 FEATURE_TESTS := clang-bpf-co-re
@@ -128,6 +145,10 @@ FEATURE_TESTS += libbfd-liberty-z
 FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
 FEATURE_TESTS += libelf-zstd
+ifeq ($(NO_ZLIB_RS),)
+FEATURE_TESTS += zlib-rs
+endif
+FEATURE_TESTS += zlib
 
 FEATURE_DISPLAY := clang-bpf-co-re
 FEATURE_DISPLAY += llvm
@@ -135,6 +156,10 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+ifeq ($(NO_ZLIB_RS),)
+FEATURE_DISPLAY += zlib-rs
+endif
+FEATURE_DISPLAY += zlib
 endif
 
 check_feat := 1
@@ -153,8 +178,27 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
+# Prefer zlib-rs over C zlib when detected. When cross-compiling, the host
+# bootstrap bpftool still links against the host's -lz.
+ifeq ($(feature-zlib-rs),1)
+  $(call feature_rust_lib,zlib-rs)
+  ZLIB_CFLAGS := $(FEATURE_CFLAGS-zlib-rs)
+  ZLIB_LIBS := $(FEATURE_LIBS-zlib-rs)
+  CFLAGS += $(ZLIB_CFLAGS)
+  ifeq ($(CROSS_COMPILE),)
+    HOST_CFLAGS += $(ZLIB_CFLAGS)
+    LIBBPF_BOOTSTRAP_CFLAGS += $(ZLIB_CFLAGS)
+    ZLIB_BOOTSTRAP_LIBS := $(ZLIB_LIBS)
+  else
+    ZLIB_BOOTSTRAP_LIBS := -lz
+  endif
+else
+  ZLIB_LIBS := -lz
+  ZLIB_BOOTSTRAP_LIBS := -lz
+endif
+
+LIBS = $(LIBBPF) -lelf $(CRYPTO_LIBS) $(ZLIB_LIBS)
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) $(ZLIB_BOOTSTRAP_LIBS)
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
@@ -200,7 +244,7 @@ else
   else ifeq ($(feature-libbfd-liberty),1)
     LIBS += -lbfd -ldl -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z),1)
-    LIBS += -lbfd -ldl -lopcodes -liberty -lz
+    LIBS += -lbfd -ldl -lopcodes -liberty $(ZLIB_LIBS)
   endif
 
   # If one of the above feature combinations is set, we support libbfd
@@ -304,7 +348,7 @@ clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
 	$(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
-	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT)
+	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBZ_RS_OUTPUT)
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
 	$(Q)$(RM) -r -- $(OUTPUT)feature/
-- 
2.56.0.313.g2479322e68-goog

