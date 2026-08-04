Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749C481A8F
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862977; cv=none; b=cxaF6K1RJ+JgiK00t87NLBbOLY8LbEJkF6h5iWw1JS/mcd9AmvwzivtmtSH995nv3gJY6yxmgsi9LLVRQaiGL8/hpKf7/qlYRVuODV2F3B/U5cbY7gt9+2zOYHszOrla3UBVWbA47rYykSJMFNzeZwylblPlHeVbLRakVPkxZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862977; c=relaxed/simple;
	bh=JKPdx4AfxQMKtTcZgijXo3YVKiupPcEX/K9j/EZzF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlfMus+VY5jdzRXHN0ettIUEnLGz2tGg/wXDWmQxt3VfQzFS7owRF113H9VApWdyQXykhuHeY984xV86C3RJFZC9mabLzEtTZdqiAi3TRebLDSfoHXTnWmP4bMCNxZD40rIWR01/ZF8NSgE5eaJj1Ow1wh9C2rjLhz+OWMR30F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+hJIYnL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+hJIYnL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so18892b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862944; x=1786467744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOwsOKm3HYbVnO5VByqQ2oE6zU3ayzZcT5Uap3Ftpq0=;
        b=k+hJIYnLlM3x9NG/k/Hxw1/x0jxlsm8SkaoGC85I3lBQ8NqSO0hkx3dX+k97VZI1At
         Szf86al1W1H0XRJq6lHyyA5I9vBBgOTFndkSkK0oI8U0caq8/8uN2Zrx+SCdXRbLsrsz
         Fr4xwcPGFC6oqhjhgzLJlesJAiMyN7z7vh2wPKpG7TiLnYcOkg0/6yyuYUh2dTFCuu6F
         ksrHH81pXhUqMkhr2bWIxk9QCNloPbF6FRIqvjGYfMYv+VgPVLVTlnLr+dhahQe2/OYx
         8evXrcCSslk3jn/gENI+M7otfQ7wO7uPXfBwh1pyGj/Tes7XJoExEbyOn4KbQrgPYDAR
         d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862944; x=1786467744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOwsOKm3HYbVnO5VByqQ2oE6zU3ayzZcT5Uap3Ftpq0=;
        b=nWP5dLJguAlbnZZscaBGe4/tSviNthTY9DWO8DwGjo0QQV0tv4ePik0WPyJM7h5tBv
         mGm4uMfsZ+zqsg34qD/OUInYPb6t/opkgKyIj3cTnxbH+m80RFpM69/z8LIffb/kQdnU
         FATR340Avn5RVMm8AqsObVT4zMfMv4PudQqHhfzDFjstbQRk6pLQ1SDrbH8kFAsTHdw9
         v9MWnplTv8/5tA6E/vf/sLEFtsfQY3Nv7id758duc0i+NH69kEPew699L1oNio0SMCxP
         F/9RIgzWU0tWCAv5f1jIVraDVZEj+034o/gzBAf8LKHfKesSWQJRnLxuvgZ0Ch+Ip62O
         RM8w==
X-Gm-Message-State: AOJu0YzmmUR6qw7lO03sBkA8pSe82R2SS0LKJI5ySC2oLk9XV8iUZvKI
	z27hOmktRBJacZ0SzPFNwoGzcuAPKLyOor52FGyBQQia6bmcXrtjAG3falL+VWltmfQ=
X-Gm-Gg: AR+sD11+4IXNenjDfg3MAr5wbvXSbLJ15iRKra6UhNjIEHmuEIK2WrzvUegS42n7ZoV
	3q/uJ/Ba17px4QwoncXfm2itHmc40MP9QLNwQ8R0CQtmoB7RmjfJ8hRCEmbspTrwdFC/mLAuZzc
	4EcC4FYSnGpl4iidtV1Q2fscuvI/UgPGceA7RAhJC3g3N1YlHRzP1Q1E4LoFciXcXSx7706PNzl
	7753nA0T+bgi5XIosUfwE8L2Qn0AupCu3NuopPvSSMCdFnHaHPsZLyKcwxC295iH84SbViZhKzS
	0nmTVslKKsyfXFmCDZ54ELnBrFiiDlsFIRFsV12M5R94mY3uHZJVbpRytOn26j7zQza+eKRMzBT
	iNgXTR4Orwp1iCr/GjnmTGQXe3mLy5lil4+WMkG3CFnkVX4O5DvIFLUNk/QnM0yAVtepnLVYJsW
	GCp52jjyfmrHhN/pS/DV//hV9GWvFdvTjPuY/ZJBdhvT3TKSWUomKXwUFZvtMPF202dVVz7MBP0
	6lK8JcWri8=
X-Received: by 2002:a05:6a00:3a0f:b0:848:3f07:c5a2 with SMTP id d2e1a72fcca58-84f2dfd0a06mr291758b3a.4.1785862943923;
        Tue, 04 Aug 2026 10:02:23 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:23 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the permissive-mode skip suffix into a helper
Date: Tue,  4 Aug 2026 10:01:51 -0700
Message-ID: <20260804170156.1709916-4-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BPF_STRICT_BUILD=0, eleven recipes append the same "|| { remove
the target, print a SKIP marker, report success }" tail, each spelled
out inline. Factor the tail into skip_on_fail, parameterized by the
SKIP tag, optional extra files to remove alongside the target and an
optional note appended to the message - every call site keeps its
exact message and behavior.

The permissive fragments of other shapes are not suffixes and keep
their current form: the rsync --ignore-missing-args flags, the
missing-input guards in the skeleton recipes, the link rule's
wildcard handling and the test_kmods copy wrapper.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 49 +++++++++++-----------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 69093fba3..565862247 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -49,6 +49,14 @@ SKIP_CRYPTO	?=
 BPF_STRICT_BUILD ?= 1
 PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
 
+# Permissive-mode recipe suffix: on failure, remove the target, emit a
+# SKIP marker and report success so the rest of the build continues.
+# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
+# $(2) - optional extra files to remove alongside the target
+# $(3) - optional note appended to the SKIP message
+skip_on_fail = $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
+	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; })
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -495,26 +503,22 @@ $(addprefix $(OUTPUT)/,cgroup_getset_retval_hooks.bpf.o \
 # $4 - binary name
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 $(call skip_on_fail,BPF)
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 $(call skip_on_fail,BPF)
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 $(call skip_on_fail,BPF)
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$4,$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
+	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 $(call skip_on_fail,BPF)
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -645,10 +649,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
 	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
 	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
+	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) && \
 	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
@@ -662,10 +663,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
 	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
 	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@; \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
+	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
 	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
@@ -679,10 +677,7 @@ $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
 	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
 	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@; \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
+	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
 	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
@@ -704,10 +699,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TR
 	diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o) &&	\
 	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2 && \
 	$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) &&									\
+	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) &&									\
 	rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
 
 # When the compiler generates a %.d file, only skel basenames (not
@@ -740,8 +732,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
-		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
+	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$$(call skip_on_fail,TEST))
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
 		$(Q)if [ -f $$@ ]; then						\
 		$(if $(filter 1,$(V)),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
@@ -962,8 +953,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
-		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(call skip_on_fail,BENCH)
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -1012,8 +1002,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
-		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benchmarks may have been skipped)' 1>&2))
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(call skip_on_fail,LINK,,(some benchmarks may have been skipped))
 
 # This works around GCC warning about snprintf truncating strings like:
 #
-- 
2.43.0

