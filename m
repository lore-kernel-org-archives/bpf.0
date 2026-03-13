Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA82C9D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360307; cv=none; b=BPHu3kJYZUnZcgVCJhhTysO1fJ38wVBGqos8F+X0VP9hJpe1zApNWsbuYxCwsEb4EYYyOXY0dFKiZM5Y3iloPmjiwUkMa3s/+LkxHeAgI7GlOf4X4Od2eTHa0xQFEeu0/AJwvo5p+eAAPk5QWfcHtraNKBaBXV+6KaGGcvUv0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360307; c=relaxed/simple;
	bh=RTsD39qRwlFZ6tdizywyD8c4rmsVN3E7HW+majXnv20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ryfIadDc7DVX67Vj60/sErczfz2v7/3kNUAOCscSY4o001drsJCZexqpnxdnO1thqEGHmVQr7YJVAkQNax6jiaOpjPxjFEzl1V+38W6ZragnYAr1+ZQ7dqbKzus03ynA4uYZ8fZn2dO7+s5OSnxvpfmRuyavdXUx8W07Qef5uMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo+B1cfW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo+B1cfW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c4bde55cso1068127f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360304; x=1773965104; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gDXER59xD/AB474tfwHGRxtTYUpOfcsU+ewoYvI2Xk=;
        b=Yo+B1cfWLVTIWMzNrjSQpQ+qozY2RUY9FKHPZekq+aVAsBKjM8gyshQRwbPZU/NMzQ
         81Jevr8/rC8z9NvLv8S5fsJEGIhCcZNjaoKqTf3PgjI70Fc3k9KPCDniOH/b+pkVQKMG
         kuTV1BbsL22r/d8MQhHpmUECT3drNXNaQuUZlzh6DaYropPM0RQtmTlxkax9X+OsMXJK
         s3VIfyDxVzWJ7aISDqfhBtod8KvHwvs90zhU+LfYvZLd0ovMxkPZM0gPe/ScYusf7yTk
         NEuo4OcDPxl+p7RS8F88X09HKphpA+NroU1sBS28DxelNQE79HX52l8MKaZ43tLn9Q/A
         LNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360304; x=1773965104;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gDXER59xD/AB474tfwHGRxtTYUpOfcsU+ewoYvI2Xk=;
        b=DEXQHnrJQFc1JX/L9PGDkqUAShKntfOsRyM4dl9HuqzBGmbmdXv2xo0EUDBSIfl0Q/
         rHXF1u+XVB/KEUyCH1URLaHUNGpm4+C06hMLX0piUeUf/EZL3v5B5Nw1+YEDAasFYvVR
         4EEot0Pnz/LouebKlzR/pcPE4dlESn+VgcBAYFkIzlGAiacmaoL7rcjqSbTXyiaxdBMT
         NBryTKDDp6g+bu5QeXC69lFPjf3qQOmZH7oA+IM+r9XMDq538RY92TiSfb3k6C544A6I
         3BvgPj4y1BcsUeb8WiQcRC0W0BZy9+0bSD8L/ch9O3xvtksyvTM/shCi8VZM/rbfWHVf
         K2uA==
X-Gm-Message-State: AOJu0Yz8OZM3bjYIlAwOiXtDNNT4T82L2PHmCAz/bfPTzpUCJDnnNP2U
	B/j/345n4w8gDzw5y5+FJB04cGltEGuKF0W+yqNU9FlXxpyeYHtIFFKi
X-Gm-Gg: ATEYQzxBQdwhsT0d0JBXrrkwENoyECTLvj9n5uaNb8aWs9gBstTATE/4U0Mm/uSFbip
	ird991Nz7l++mCTgknoEeIT8tYzJg4ogwLCH0HZRIgYcMGKGPLN4ZGt+WiCrvvJlTsrrY6+OsSe
	WkBVuSVS+C/ycXYo0+zRFZEk+EXlbp5gGiQtFtpWlBewqntaFt2e4Aj6cekL8O/x4+CoUDQMqLR
	9HtF5xcgjpJSxHEDhVMKDKRpjjpwgq20nEMN7IpEQO23I3G3FDf7EHoOx/6rSjL40URdHbV3iqN
	AYrQxCWyihtMRdsS+7zIiJged/pRw3PLMt28Nw2ej80VGIQ2Kl8j7v22OWJ2g/aOkg2Im4MYVqi
	QDPYs7kHVZhOxrTp1Iwy3ZZXxWaOuWUGMllpm3TR2jbvAW8b6myf9IXV6W+DfFtiwZzw5kJ8V7L
	nAFFvlsOOJsYVe
X-Received: by 2002:a05:600c:a08:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-485566ca978mr20517115e9.2.1773360303619;
        Thu, 12 Mar 2026 17:05:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66dedfsm166974345e9.12.2026.03.12.17.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:05:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 12 Mar 2026 17:03:27 -0700
Subject: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
X-B4-Tracking: v=1; b=H4sIAE9Us2kC/3WNwQqDMBBEf0X23BRNtEJP/Y8iJXE3dUGNJGmwS
 P69wXuZ0zAzbw4I5JkC3KsDPCUO7NZi5KWCcdLrmwRj8SBreatVI4VphdlsdG5+mQ/PKCz1qHr
 sVGcQymzzZHk/kU8oVbHSHmEoycQhOv89v1Jz5v+xqRFFWqOlUdtOtY+For6OboEh5/wDEgprM
 7kAAAA=
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773360302; l=7548;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=+PX7XoEzOWmWek4KYvC6DL/DoWZ+HVouK8y7sNhlp6M=;
 b=prR6wxlqX+lGjaBIImEy/POcd06sLuXZw7EGXeAkWbe4Uk3kVZGrQ0sACtTZZJf9P1VML/31u
 9ZkPcToyxn2CSHpW/buyVeTc8uxjCUkJus5QvbSEelgtnZ/w5gxc1c2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
users build bpftool without these optional dependencies.

SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
libbfd JIT disassembly fallback when LLVM is absent. Together, they
produce a bpftool with no disassembly support.

SKIP_CRYPTO=1 excludes sign.c and removes the -lcrypto link dependency.
Inline stubs in main.h return errors with a clear message if signing
functions are called at runtime.

Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
proper feature detection in the future.

All three flags are propagated through the selftests Makefile to bpftool
sub-builds.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- CRYPTO_LIBS defined before use
- Error messages updated — stubs now say
"bpftool was built without signing support" instead of "program signing
requires libcrypto".
- Link to v1: https://lore.kernel.org/r/20260312-b4-bpftool_build-v1-1-1aadfecaf534@meta.com
---
 tools/bpf/bpftool/Makefile           | 30 ++++++++++++++++++++++++++----
 tools/bpf/bpftool/main.c             |  7 +++++++
 tools/bpf/bpftool/main.h             | 14 ++++++++++++++
 tools/testing/selftests/bpf/Makefile |  8 ++++++++
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 519ea5cb8ab1..0febf60e1b64 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -97,6 +97,15 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 
+# Skip optional dependencies: LLVM (JIT disasm), libbfd (fallback
+# disasm), libcrypto (program signing).
+SKIP_LLVM ?=
+SKIP_LIBBFD ?=
+SKIP_CRYPTO ?=
+ifneq ($(SKIP_CRYPTO),1)
+  CRYPTO_LIBS := -lcrypto
+endif
+
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -130,8 +139,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lcrypto -lz
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
+LIBS = $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
@@ -150,7 +159,12 @@ all: $(OUTPUT)bpftool
 SRCS := $(wildcard *.c)
 
 ifeq ($(feature-llvm),1)
-  # If LLVM is available, use it for JIT disassembly
+ifneq ($(SKIP_LLVM),1)
+HAS_LLVM := 1
+endif
+endif
+
+ifeq ($(HAS_LLVM),1)
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
@@ -165,6 +179,7 @@ ifeq ($(feature-llvm),1)
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
+  ifneq ($(SKIP_LIBBFD),1)
   # Fall back on libbfd
   ifeq ($(feature-libbfd),1)
     LIBS += -lbfd -ldl -lopcodes
@@ -186,15 +201,22 @@ else
       CFLAGS += -DDISASM_INIT_STYLED
     endif
   endif
+  endif # SKIP_LIBBFD
 endif
 ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
   # No support for JIT disassembly
   SRCS := $(filter-out jit_disasm.c,$(SRCS))
 endif
 
+ifeq ($(SKIP_CRYPTO),1)
+  CFLAGS += -DBPFTOOL_WITHOUT_CRYPTO
+  HOST_CFLAGS += -DBPFTOOL_WITHOUT_CRYPTO
+  SRCS := $(filter-out sign.c,$(SRCS))
+endif
+
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o $(if $(CRYPTO_LIBS),sign.o))
 $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a829a6a49037..c91e1a6e1a1e 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -131,6 +131,11 @@ static int do_version(int argc, char **argv)
 	const bool has_skeletons = false;
 #else
 	const bool has_skeletons = true;
+#endif
+#ifdef BPFTOOL_WITHOUT_CRYPTO
+	const bool has_crypto = false;
+#else
+	const bool has_crypto = true;
 #endif
 	bool bootstrap = false;
 	int i;
@@ -163,6 +168,7 @@ static int do_version(int argc, char **argv)
 		jsonw_start_object(json_wtr);	/* features */
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
 		jsonw_bool_field(json_wtr, "llvm", has_llvm);
+		jsonw_bool_field(json_wtr, "crypto", has_crypto);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 		jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
 		jsonw_end_object(json_wtr);	/* features */
@@ -181,6 +187,7 @@ static int do_version(int argc, char **argv)
 		printf("features:");
 		print_feature("libbfd", has_libbfd, &nb_features);
 		print_feature("llvm", has_llvm, &nb_features);
+		print_feature("crypto", has_crypto, &nb_features);
 		print_feature("skeletons", has_skeletons, &nb_features);
 		print_feature("bootstrap", bootstrap, &nb_features);
 		printf("\n");
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 1130299cede0..78b6e0ebb85d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -293,6 +293,20 @@ struct kernel_config_option {
 int read_kernel_config(const struct kernel_config_option *requested_options,
 		       size_t num_options, char **out_values,
 		       const char *define_prefix);
+#ifndef BPFTOOL_WITHOUT_CRYPTO
 int bpftool_prog_sign(struct bpf_load_and_run_opts *opts);
 __u32 register_session_key(const char *key_der_path);
+#else
+static inline int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
+{
+	p_err("bpftool was built without signing support");
+	return -ENOTSUP;
+}
+
+static inline __u32 register_session_key(const char *key_der_path)
+{
+	p_err("bpftool was built without signing support");
+	return -1;
+}
+#endif
 #endif
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 869b582b1d1f..e27501c06b56 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -41,6 +41,8 @@ LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
 SKIP_DOCS	?=
 SKIP_LLVM	?=
+SKIP_LIBBFD	?=
+SKIP_CRYPTO	?=
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
@@ -333,6 +335,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
+		    SKIP_LLVM=$(SKIP_LLVM)				       \
+		    SKIP_LIBBFD=$(SKIP_LIBBFD)				       \
+		    SKIP_CRYPTO=$(SKIP_CRYPTO)				       \
 		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
 
 ifneq ($(CROSS_COMPILE),)
@@ -345,6 +350,9 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
+		    SKIP_LLVM=$(SKIP_LLVM)					\
+		    SKIP_LIBBFD=$(SKIP_LIBBFD)					\
+		    SKIP_CRYPTO=$(SKIP_CRYPTO)					\
 		    prefix= DESTDIR=$(SCRATCH_DIR)/ install-bin
 endif
 

---
base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
change-id: 20260312-b4-bpftool_build-fe7d37d535bd

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

