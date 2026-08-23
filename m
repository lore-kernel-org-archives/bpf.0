Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62A3AFAE4
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514190; cv=none; b=mLEFdCn4McuneUJHNZwxpU+8r6DkQIJUfXZw/xW/E0+wbOzHV+3KMp71wUWeeOwys1hY4xB9rPlkdCyTbntTlVv0073yc0yt9dvbfBOXzMskdf2+MTGQpzEfQoUY3evm4Xkrx5VzwAiIOCNI9coJJJRfgKrk1HG6U7VyB+Py4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514190; c=relaxed/simple;
	bh=dMrdsZKJenOheDg9WQaLqiHxdMA+FRXq7H6yPmllMI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I29u5RagwU22DfA1NQsK5YAGmjpA7YHJ51AaVo6QLHCs1R+QaaX6jysBTn8Y/CN95YypDHOqkTaYOoKxXXW394FOYkV0wIHOmm1+eUYdr/OxDqlwS0+EtYC4u+tmLH3vU3Lntzkm0EYVf05piQUE79UVIdF3W0nP+gLvMliA4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2DfiyBS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2DfiyBS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d049069377so23022185ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514188; x=1788118988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ud9+Fi3SNcM/DJM0MqvJd8OuakwrWgwxDjj0JwElrnc=;
        b=n2DfiyBSmO50o2vG/fP7sLuB0Fb2A7Z4hNnnIPLA+FeH1uC73C8N0waUzhoUvZCwDH
         cZhdOyYz+HKy8KQJUINR/uUxlD4HKUHlnd4nv7/dY4ZYimWmXeA8nezuNDD7G7aBCpUh
         ooXoOMbQdeCt6QoBhERLOSQuHPE2uyXCF72bHKaHd35TmoJS/3RxWjnBItBx1CsPCbkN
         4ON2PicAHdYSIGYPEpequGTIgw+6+yLePYcdiy9HtxyxkMby+/cf7aISkRKKpO492TRY
         dDTGAc0nOf2Bz/xGebx7pILF5AUWMcZbGZqL7hbL1hfI3lxG5hdYh+W3QnVGAhRHhSnP
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514188; x=1788118988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ud9+Fi3SNcM/DJM0MqvJd8OuakwrWgwxDjj0JwElrnc=;
        b=anPmTp/s2OcuJ3qiadcVgJkcJXokw2/npg83qqSNTvQEwW/zYBlPBeWqcDJHOpytyE
         u2SpGVs8xOY3TzDNF/txJIMfkzBKP7Z0QO8jDYyJBj6QiH3PyVHT/lFCLec0byuUegsO
         utpEx2Gi38M2jp/GP/voEpns9EMfOFciK/ilOhVwnRQ8lv04o7QQjnUw/9KekyfaZrsU
         YdKDyZl4JmOexvL7LKRtr4U4YZE1AFyQdL5Xwb3AKtWTMvW/KAHHxugGZPCTnuasSfLl
         TUZMQcd7YVtvIT8E9z0DC4UA3gJ9ikIqEhGhCOh0WCWyXdBE6HTNC/rJTRd8rA8jRO9B
         8Qvw==
X-Gm-Message-State: AFuF++mmxb52zwKwGjI+S8xw25SK/zmMaUORNajEVpRr6fsyJWxypF0u
	0F+HyfNW0iLo7b0L4OBpa+qlkLPcRVDXrC6iLyB3SZtuVPdX+j1hvQI3p32oaJlG
X-Gm-Gg: AR+sD13t7N7c9SVyuPoKkyp395cnuq2Pp4jO3gxve0JalpqKH/5ZzsnuXegbJ3BEz3I
	8MkyuXdKpV+dwDvVUFnLBFYeQIHVieU9loFYI0uuER8IXtZO+jBxuYmTkfrG4dLJ2Z1NS2m4gdp
	AiPVAI19uhVhTczNgdhS6eE+Zqz4ukRCm8iXqv9xt/ULI4YbHdaxeTNicsit2fXyjzWbpki1gCU
	OkRfRRSQn5alWZhPPM0VTakKUzkwrYejb+Age6WcBo8ATUpDmuG7Ei6SbsGGlbUQAxEdqJio8q5
	Ji1ByadIm2QjA5fL93hz/SDpdqnKQ424IFT4QvLS3hrx/IoYNNOjNJpAlt1WgpTssYW/PdZkcq3
	QmmnmmY2/+xIEbgeb5GZmEd9O0QAYZqQyE1/dEsaMHPRbX4j5s4ceJnEjNF398cWcewz95LyJhI
	kYZLuZi/4rlOwtJdDBqhE1TYWsGJKx+1sAJgff26AGw0VwzMctZ4E37aepWuGA7k/4IE+oxgdWf
	upNOwDt0L94JcTFUCYsRtWKZrlTeaqq0oq8p2cxJUNt6TpoZT+1YKV4yo2iNcQPIQ==
X-Received: by 2002:a17:90b:5646:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-395c36fb278mr40750574a91.9.1787514187904;
        Sun, 23 Aug 2026 12:43:07 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/9] selftests/bpf: factor the permissive-mode skip suffix into a helper
Date: Sun, 23 Aug 2026 12:42:35 -0700
Message-ID: <20260823194241.3415152-4-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BPF_STRICT_BUILD=0, eleven recipes append the same "|| { remove
the target, print a SKIP marker, report success }" tail, each spelled
out inline. Factor the tail into skip_on_fail; every call site keeps its
exact message and behavior.

The permissive fragments of other shapes are not suffixes and keep
their current form: the rsync --ignore-missing-args flags, the
missing-input guards in the skeleton recipes, the link rule's
wildcard handling and the test_kmods copy wrapper.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 49 +++++++++++-----------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c7c7f27dd860..e4c8efd1e6f1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -48,6 +48,14 @@ SKIP_CRYPTO	?=
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
@@ -485,26 +493,22 @@ CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
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
@@ -632,10 +636,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -649,10 +650,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -666,10 +664,7 @@ $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -691,10 +686,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TR
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
@@ -727,8 +719,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
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
@@ -1016,8 +1006,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

