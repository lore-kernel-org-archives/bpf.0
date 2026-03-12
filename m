Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4753CC9F1
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335630; cv=none; b=Dxl2eF9CpiCdGsGSYBEPYR6ssUsSTKUa4EaM319tO/8V63IpJ5iD5H+2qN4Fb8mpqJ1SOVAvMUnYtdZzsnSzRLOVUNbONbheyfSDy/AB+Hh6yhvLZAREXl2VCllP9dayQkIsv4whqILHcE6UzdtY/NJx5qk+MQkLcmFFAs2u+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335630; c=relaxed/simple;
	bh=Lc7YJEuAUVOqWE81U0HI/1coZNXmZzfISLKE36iptAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GHelNGYE0ggf1pJV5FbnKEN0vMNk9lBL2iKqvWx5qh2b5SBxpgD3f+MWrsP3jSn878tzJiuL8+JxssoMJc8XB6oIH9oleYCQP+iNxJE+LpbSHeq1GqwMUPkHpnphZ9AMvecaTepuLvsjvB9ywJofmbCfGT+3kle/pODxzac/GWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0cZbq1p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0cZbq1p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c5b40f60so1157045f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335626; x=1773940426; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epKbyhVoePGh2R5wFHOngUtJeBBZFqY3FTPNJS7DyTk=;
        b=G0cZbq1pvxukB8iwgypFZTMGhS954asRbzsoDuZV8exo6ocEm6ig5OInyBqGDfDF+x
         aUUhzhMk7Q7XApR4JzDAIXjMYb7BjvYIvyOA5GknyIAt9t4amoinOlfnAL22nCM7SdHu
         gxdd+OiMoE8zmExvu6Y0DRgIW/7BvOrlij85HaxVTsBrGY5DDJVURS4+pSEM9Cp0F76w
         psfaadK2m0v7AK4CBbHZJJIXsttEZXsCpj0yxo1x4EHURsi7HEdNEPo903GomP7SM9qk
         RvJN8nV8s/rbUOIwSFV9xqiMPC55KvQKZq4qHawHRxXnEhNwu0+N9Pmn3qOKflb1QCrS
         HlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335626; x=1773940426;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epKbyhVoePGh2R5wFHOngUtJeBBZFqY3FTPNJS7DyTk=;
        b=GJ8ly3FHZV6I2vdogDHG5ErLpWy3HbvmTs7ggRWBwxi5pkkz21eGjYOwby1dzO64dv
         iQ3qqO3LQ6iLukCxg6n33fD3X3khkadFTkuZrO4Frry4wPThuLWSguMvILT5jzluKhe5
         EMg668brRFyyTtGSQqzemr/OvxBqyTzsr3icF1NLuG4VZxDiWxf76yjolaJOIeHY61HV
         Ms2KNSTOrpFAlxAmd8GDTwk8FTZ6+2AYJnz/IGeE08EhPcz+5gLQG2cuM+ZseaFP1N5d
         vBxwj3Jf3XWjR6JqkktzPZR2ELEpfmYyGA6+0MmhOW9wmUG1EKPKevn/qPTfISTya50W
         8pbw==
X-Gm-Message-State: AOJu0YxyIzvk254G0TQ194/GE3pRmoonFr2fAMUnJMN3J1/fCoQgyF3S
	FXdSYS4TCsSbQuxsBfe0CaPHrNKjgLwqyGUJmKy8pU+j9F5atkf75KDQ44adG4zs
X-Gm-Gg: ATEYQzwgnh2n2RwACH3yd8aG5WlihVN2QDKbjxFCJhFcFv+ia2qX1U2kpR7zBzG8GJ9
	3E2oishBXRBrFZTfxTFxf6tmv6QEqXF9EUL7DbVnTeW0XjT9+1oTeja1cBGc99ukERwT5/iZixt
	QCVs49ZPhEs7OYLXlL/uiOhggpyqcmNbhClmJ/+yoYrQVO7mD4aSG52XUN20/8RMwyCF8owOX/I
	lwi0O7wWYynmPN+rIz5P9K3/B7fUNNoowMI9eB5/h7ozhOkB7KOh86XRlDBLXDE/bBkLf5DFlw2
	byy/2jCyomkykFhry9580uXyzl9feZgsGynz9977fbMCD0rFeiVkc4vSffvRh+3aO3i9LZgbbQ3
	0O2WBP0GVEbqSQFVpvGdESGmJE7BN+x9Hp6KwJlBv6QbuIpORgdNEKW91W+zPc/e23RN6S/yMKj
	/f3WMtv6ULDJcjJMJxdQ==
X-Received: by 2002:a5d:5f82:0:b0:439:bdba:56c9 with SMTP id ffacd0b85a97d-43a04d7c255mr920825f8f.2.1773335625293;
        Thu, 12 Mar 2026 10:13:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm11107724f8f.25.2026.03.12.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:13:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 12 Mar 2026 10:13:37 -0700
Subject: [PATCH bpf-next] bpftool: Allow explicitly skip llvm, libbfd and
 libcrypto dependencies
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-bpftool_build-v1-1-1aadfecaf534@meta.com>
X-B4-Tracking: v=1; b=H4sIAEH0smkC/x2MWwqAMAzAriL9tqCbD/AqIuJspwXZZFMRxLs7/
 AwkeSByEI7QZQ8EviSKdwnKPIN5ndzCKJQYVKGaQpcKTYVmt4f322hO2Qgtt6RbqnVtCFK2B7Z
 y/8sekoqO7wOG9/0AjiJnBGwAAAA=
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773335623; l=7217;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=nBMIp2HcB7TzupcldF4UbeZvDrYZuRebEcDKDBJ8xGs=;
 b=oIwYu9TiInG+DH1Dv/xolBrBSVr1j4aY+8rzerc3LxDmgk0n2Q4/MdPYZ/nTmd9EsQJ5vHfJ0
 CXRJZP1931/CnSS910n18y3npGIw7sX00uigLxyj5E2GSnuaLVxL4by
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
 tools/bpf/bpftool/Makefile           | 29 +++++++++++++++++++++++++----
 tools/bpf/bpftool/main.c             |  7 +++++++
 tools/bpf/bpftool/main.h             | 14 ++++++++++++++
 tools/testing/selftests/bpf/Makefile |  8 ++++++++
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 519ea5cb8ab1..4f83a7ec81a5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -97,6 +97,12 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 
+# Skip optional dependencies: LLVM (JIT disasm), libbfd (fallback
+# disasm), libcrypto (program signing).
+SKIP_LLVM ?=
+SKIP_LIBBFD ?=
+SKIP_CRYPTO ?=
+
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -130,8 +136,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lcrypto -lz
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
+LIBS = $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
@@ -150,7 +156,12 @@ all: $(OUTPUT)bpftool
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
@@ -165,6 +176,7 @@ ifeq ($(feature-llvm),1)
   endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
+  ifneq ($(SKIP_LIBBFD),1)
   # Fall back on libbfd
   ifeq ($(feature-libbfd),1)
     LIBS += -lbfd -ldl -lopcodes
@@ -186,15 +198,24 @@ else
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
+else
+  CRYPTO_LIBS := -lcrypto
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
index 1130299cede0..169392a4552d 100644
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
+	p_err("program signing requires libcrypto");
+	return -ENOTSUP;
+}
+
+static inline __u32 register_session_key(const char *key_der_path)
+{
+	p_err("program signing requires libcrypto");
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

