Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C4431E4F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693890; cv=none; b=aMnYARthHazK6SCUf5t2II0VvimfoXLJcZJt9cYZGT3+rgj68YRkpLOwe/FObNwCdPeQTKOmSR5BcUatREcO4K3A5fbDuMLwT00QznMvsdZIltu/wIjCjoOEn6Nvvb5X7EKxt98EFCjrcTIDZxXUAfUKCRqSg6HpgVizHk+lNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693890; c=relaxed/simple;
	bh=kVn96FqvMwMBuSVn/zBD+oSFhXhkjnJo2LaWSB69ZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGpmn2iG4i+e7bdVwSe88Vyr6vKE18KXlUWc6svtSkRkqU8HDaoicMq9eagcHegNjJIiOlc6CEH0OjfAo1mCWw6fulu35djn+7sNVgZYmIClTwUz57wHE8UvPe3gbw4+9O1z31/Tj/KKsjQC6kRoIm76WXIVWIjRKDh9c0EkT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGYcL0CA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGYcL0CA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedda4c154so439825a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693878; x=1787298678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Tw7QssqNwPoq9ncdKoV/ppucaSKUcHYQcUv1PyBsN0=;
        b=SGYcL0CASBfJBIHZiSy4uLKidJ6O6QUJfw+zPJK2deg2tV7WeJqzB9HI2GvgBN38IN
         9JBQ0Bdktvc95twgu4JEFfY3iJQhelZiRaiuCxZYH6rkfCXuz/gCpP58IQuhxIOaGQ27
         VMwvHkEUisOXEHhN1yM+iXw+P4Q8wr1hKL/yVdJ6/FQ/LM05uvRBevYsTezfK1PCRN0X
         G+kfeXsccYlQoVoCaiq+CCAAVzaeRxqBqyDch+2MKGXpSErdsYf5YypZ6936Vuq5Mo4z
         ite/OX/loheJaToSgNDlVzPZbAahPFBed+aMRCmr8SlKeWwDyv+pgaoegMznB+3uoFS/
         uDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693878; x=1787298678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Tw7QssqNwPoq9ncdKoV/ppucaSKUcHYQcUv1PyBsN0=;
        b=I3syBh93co2dUBrfuzdr7qBgNHTYEnE+ubQUbVqB6mwTNJuG71nZ/RynoFn35V2ylm
         5PhtK8vzP7+kJkhvKEB1lPt1Zt6FNBqHjjzlEvmjUnInmKBaa9B14frgmhifg3JquAQu
         C5BrFv83evkGl7p2Nt27fX4Xw3JTADFbq+TLDFAybP/mqKOPOgHIlwfPltQcWTv5fFuR
         VI8BtbM7Vkd/ycm3ySCHgC5gLNCmpGJP1qM+IoBvI+V3hxB9FQeA8Z6vVHOhu/Klgu2c
         E9OMiYKHsQAz1xljlISE7KG3nyJ21lHt4F78hpCBJXu30gYMVF6IULCkLlNUSNyc2W2Q
         zOsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2dN3jLBzwuxu5lCG2NV3p/ND3GmgGJCZoKIyaOt6iAgqoQ1cFmEmPFRqcuNmLn3FIdCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoT13+Vbshe7ZRA/14vlw6MPxnQF+S1o8b5EIm7ELgfvBgiy+H
	Y65FO0Zzu9Bw+O/nQvV1hMUzxRautXi2qntmknpYFm4vWgGakHbcnvbR
X-Gm-Gg: AR+sD11MzGwuDI7fOJT3eEhAl0PvwwjRpiYLuAjNDoj3nu1AoVv2IAHANxDwfH0x5E3
	afpTxu4aLVYRR41+ORyojIArOG3tF7ubNK84Sm4kXTO/oGvdvtiTtuubn6MFo4iJEzB8gArPWvP
	b0Zm0WpAt6x5aStvoqgdiq/JFQ1fSsPufOWapbWr/sSyEZHuELwN/VFF+86qFUOYg5htMdtlAMc
	ZQh2Q2YtSDoOKk4mQ37L6UWEyqUalP2ykGcagIWTPvUMRA1xIScU9AKJKbYlEHdIEAkdVD4Zvlv
	4guNboEKKifbtRWlp4x3JA6dMutyBWd/jEoEtysNZ5fo/hXENld7j9AxYM6ZdGd4FN+nDfAdARv
	3Ync+RGnQhc3kyLuUDii2TdurLrYlxmvHRjNEA95f4nFDFUAtQVc7+ZUeFBgNdFGq1vmzNh96bJ
	rt4DmDt2+5A3gSHqy/X9NOADdahaUbRVhbLvtTdd2CYbuI2xeCxgIgdKg=
X-Received: by 2002:a05:6a20:cd90:b0:3bf:c28f:8afc with SMTP id adf61e73a8af0-3cc71707793mr4594413637.0.1786693877991;
        Fri, 14 Aug 2026 00:51:17 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:74::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea302649sm1331437eec.24.2026.08.14.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:51:17 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ziyang Men <ziyang.meme@gmail.com>,
	kernel-team@meta.com,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] selftests/sched_ext: build BPF schedulers via the shared lib.bpf.mk
Date: Fri, 14 Aug 2026 00:50:54 -0700
Message-ID: <20260814075054.507089-5-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814075054.507089-1-ziyang.meme@gmail.com>
References: <20260814075054.507089-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext carried its own ~130 lines of libbpf + bpftool + vmlinux.h +
BPF-object + skeleton build machinery.  Replace it with an include of the
shared tools/testing/selftests/lib.bpf.mk, making sched_ext the third
in-tree consumer of that fragment, after selftests/cgroup and
selftests/hid.

All 28 skeletons and 28 subskeletons keep a same public API before and
after, the runner builds and links the same way.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Mykola Lysenko <mykolal@meta.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile | 146 +++++----------------
 1 file changed, 30 insertions(+), 116 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e91..620e8cb31e6f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -14,48 +14,32 @@ CURDIR := $(abspath .)
 REPOROOT := $(abspath ../../../..)
 TOOLSDIR := $(REPOROOT)/tools
 LIBDIR := $(TOOLSDIR)/lib
-BPFDIR := $(LIBDIR)/bpf
 TOOLSINCDIR := $(TOOLSDIR)/include
-BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 APIDIR := $(TOOLSINCDIR)/uapi
 GENDIR := $(REPOROOT)/include/generated
 GENHDR := $(GENDIR)/autoconf.h
-SCXTOOLSDIR := $(TOOLSDIR)/sched_ext
 SCXTOOLSINCDIR := $(TOOLSDIR)/sched_ext/include
 
-OUTPUT_DIR := $(OUTPUT)/build
-OBJ_DIR := $(OUTPUT_DIR)/obj
-INCLUDE_DIR := $(OUTPUT_DIR)/include
-BPFOBJ_DIR := $(OBJ_DIR)/libbpf
-SCXOBJ_DIR := $(OBJ_DIR)/sched_ext
-BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
-LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
-
-DEFAULT_BPFTOOL := $(OUTPUT_DIR)/host/sbin/bpftool
-HOST_OBJ_DIR := $(OBJ_DIR)/host/bpftool
-HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/host/libbpf/
-HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/host/
-HOST_DESTDIR := $(OUTPUT_DIR)/host/
-
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
-		     ../../../../vmlinux					\
-		     /sys/kernel/btf/vmlinux					\
-		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
+# The schedulers are built by ../lib.bpf.mk: modern *.bpf.c layout, a
+# .bpf.skel.h suffix, and subskeletons.
+BPF_SRCS        := $(wildcard *.bpf.c)
+BPF_SKEL_EXT    := .bpf.skel.h
+BPF_GEN_SUBSKEL := 1
+# Keep the generated files under build/ as before.  SCXOBJ_DIR (userspace
+# objects) reuses the BPF object dir.
+BPF_OBJ_DIR  := $(OUTPUT)/build/obj/sched_ext
+BPF_SKEL_DIR := $(OUTPUT)/build/include
+SCXOBJ_DIR   := $(BPF_OBJ_DIR)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
+include ../lib.bpf.mk
 
 ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
 endif
 
 CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
-	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
-	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include -I$(SCXTOOLSINCDIR)
+	  -I$(GENDIR) -I$(LIBDIR) -I$(TOOLSINCDIR) -I$(APIDIR)			\
+	  -I$(CURDIR)/include -I$(SCXTOOLSINCDIR)
 
 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
@@ -64,102 +48,30 @@ endif
 
 LDFLAGS = -lelf -lz -lpthread -lzstd
 
-IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
-			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-
-# Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
-# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
-#
-# Use '-idirafter': Don't interfere with include mechanics except where the
-# build would have failed anyways.
-define get_sys_includes
-$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
-	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
-endef
-
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
-
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-
-BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
-	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+# The schedulers need scheduler-specific includes, so override BPF_CFLAGS
+# wholesale and keep the flag set this directory used, rather than pin -Werror
+# across clang versions.  The recipe adds -O2/--target/-mcpu.
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)				\
 	     -I$(CURDIR)/include -I$(CURDIR)/include/bpf-compat			\
 	     -I$(INCLUDE_DIR) -I$(APIDIR) -I$(SCXTOOLSINCDIR)			\
 	     -I$(REPOROOT)/include						\
-	     $(CLANG_SYS_INCLUDES) 						\
+	     $(CLANG_SYS_INCLUDES)						\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -Wno-incompatible-function-pointer-types				\
 	     -Wno-microsoft-anon-tag						\
 	     -fms-extensions							\
-	     -O2 -mcpu=v3
-
-# sort removes libbpf duplicates when not cross-building
-MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
-	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
-	       $(HOST_OBJ_DIR) $(INCLUDE_DIR) $(SCXOBJ_DIR))
-
-$(MAKE_DIRS):
-	$(call msg,MKDIR,,$@)
-	$(Q)mkdir -p $@
-
-$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
-	   $(APIDIR)/linux/bpf.h						\
-	   | $(OBJ_DIR)/libbpf
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(OBJ_DIR)/libbpf/	\
-		    ARCH=$(ARCH) CC="$(CC)" CROSS_COMPILE=$(CROSS_COMPILE)	\
-		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
-		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
-
-$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
-		    $(LIBBPF_OUTPUT) | $(HOST_OBJ_DIR)
-	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
-		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
-		    EXTRA_CFLAGS='-g -O0'					\
-		    OUTPUT=$(HOST_OBJ_DIR)/					\
-		    LIBBPF_OUTPUT=$(HOST_LIBBPF_OUTPUT)				\
-		    LIBBPF_DESTDIR=$(HOST_LIBBPF_DESTDIR)			\
-		    prefix= DESTDIR=$(HOST_DESTDIR) install-bin
-
-$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
-ifeq ($(VMLINUX_H),)
-	$(call msg,GEN,,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
-else
-	$(call msg,CP,,$@)
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
+	     $(BPF_EXTRA_CFLAGS)
 
-$(SCXOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h	| $(BPFOBJ) $(SCXOBJ_DIR)
-	$(call msg,CLNG-BPF,,$(notdir $@))
-	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
-
-$(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL) | $(INCLUDE_DIR)
-	$(eval sched=$(notdir $@))
-	$(call msg,GEN-SKEL,,$(sched))
-	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
-	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
-	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
-	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
-	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $@
-	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+EXTRA_CLEAN += $(OUTPUT)/build
 
 ################
 # C schedulers #
 ################
 
-override define CLEAN
-	rm -rf $(OUTPUT_DIR)
-	rm -f $(TEST_GEN_PROGS)
-endef
-
-# Every testcase takes all of the BPF progs are dependencies by default. This
+# Every testcase takes all of the BPF progs as dependencies by default. This
 # allows testcases to load any BPF scheduler, which is useful for testcases
 # that don't need their own prog to run their test.
-all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
+all_test_bpfprogs := $(BPF_SKELS)
 
 auto-test-targets :=			\
 	create_dsq			\
@@ -195,7 +107,8 @@ auto-test-targets :=			\
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
 $(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR) $(BPFOBJ)
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
 
 # Create all of the test targets object files, whose testcase objects will be
 # registered into the runner in ELF constructors.
@@ -204,15 +117,16 @@ $(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR) $(BPFOBJ)
 # compiling BPF object files only if one is present, as the wildcard Make
 # function doesn't support using implicit rules otherwise.
 $(testcase-targets): $(SCXOBJ_DIR)/%.o: %.c $(SCXOBJ_DIR)/runner.o $(all_test_bpfprogs) | $(SCXOBJ_DIR)
-	$(eval test=$(patsubst %.o,%.c,$(notdir $@)))
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
 
 $(SCXOBJ_DIR)/util.o: util.c | $(SCXOBJ_DIR)
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
 
 $(OUTPUT)/runner: $(SCXOBJ_DIR)/runner.o $(SCXOBJ_DIR)/util.o $(BPFOBJ) $(testcase-targets)
-	@echo "$(testcase-targets)"
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
 .DEFAULT_GOAL := all
 
-- 
2.53.0-Meta

