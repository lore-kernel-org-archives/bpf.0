Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0A2D3A75
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447377; cv=none; b=IFW6kDqdNxEUPQIwNkmLxUnm0b5GFq6zEHYxhDjqB9U4b5rlnsMpZRWqernaay9XH5b22DBBmWZGqGJ5Rbs0IsM63iT7yu1IMDQsv2Ez7uf88tDnrHDt3/SeVdiulZqFfBCrdkpqUoUnBNWumhYPtV0psDmBMoAMQitV+N60AZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447377; c=relaxed/simple;
	bh=5f2xwpxx/udb+igxeyIps10/ySKVxGkDsBT2dVwQkJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuDZ/8hkMZJtwV8r2TiQKf67piEx3dgHXJR/FXSX1JGdoJW1FZ2y2pE+hNDmtf1uV57bwegnrDrjKRVmS68YQX/fHoXPMdFFi4icnSpl6hWqWDhTUSnCCAfNd0DM011JLhudA1DbBoYLGvt7N18eKp8bSjA8dL8zmuNmNyjjRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwQI8SRS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwQI8SRS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cab973140bso29951165ad.3
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447370; x=1788052170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCksv6wbEbiyVD5H7lyg/UloWl/rvSd+JzZBN8Uu0Gk=;
        b=XwQI8SRS9e1LJT+bTrU7icYOzlxH4yqM1gHhOxV51X3O8qvYs2sz1CZbVyULzehQKk
         HrM/UmTngBS991QNwZWx0fUN7LMgj+ck/lsa/XLf60UrTsuwCLF8xz+2ns1h+fIEWa0q
         4GqrLRzd65ONOR+uOYUNgpSSDzWSmEfJemQmTJPXsJHhldRXv+WV9DEFgOORxR/accg3
         /QSB5oyR0X5iG7Zt+2ECnzdCEqACtduDXosiobVazPzeFRdNOs2f7Ekvb+MU4HYKtNHn
         iHTrxIt7axafwbp600kjI2wDxQxkwc7bF1IWG/5khGkgC5HVOgX0DcGtqJ4F5ROYrgH3
         vcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447370; x=1788052170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCksv6wbEbiyVD5H7lyg/UloWl/rvSd+JzZBN8Uu0Gk=;
        b=UxRMqLZF1RsBifVqv75b+UpQVDdUEUxCLJEtMiwAJ6zbBkdE7HmUaSZk95O6Lb/9pZ
         wJ6KiN2PFVgiAyVArPXKVUfu4ARL9Rwk7XG8ADgWKBxl6S8irlokbxrNZp3kTYXyBRRR
         YvZx7V0NCQQec18xcVvGQj2ahprZ9QXoZNnSMfuhjXr5RZidrL+8WT6Cw/uBncoPeqGV
         RmxIVZvxG/RVbBAs6mAkNpLq2CdvqdKy2n+DEhvdXXVNzWjQK0Ty0M035Xtr9ReCGjVa
         Mwsb5yqoX0Q9juYO6MfFewPa+vhmN0dL6gN/150Kbt3N/gol7p8d9MVZZ4qj6DXZUMli
         ptbg==
X-Gm-Message-State: AFuF++lrZTHM4aEYmk0yKOlJSEkkdOq1mSoSw6wB17AdWA2kkZI8o9qU
	Ybbj8Y7EH2z9sSdQPbpbP/GcdbOzD11gh2lGIZu/IE7RxcgT72tDCleyPRwksHmS
X-Gm-Gg: AR+sD11iGc1z1fHzKU0M/E8U1ep2a0y2wHPndayg82/ZFpQJ4aNsYd1HDfykD8aUjHi
	xJIxbxmm5UN4LPpN6LrL7WX9ioodb4//fL/ORPuz7hnaK0glNEzatQat+Q/ATx8kCMq2vkFncDa
	akpmfKg02TC6cWe8BKjKdByVeOUG6EiW2pLtTenmqe4rTqoWZl3YhWDVTxKWEOYABw3QSOnIgG3
	GkuFqwgwsf8YBbLMdi99daw/XiOeLCzrkqmHOcod6uZbwsFSasiGElcz7mMs1/pcoohuxZDgAEp
	PxIXuoWD9LrJ1PnT0bSRGNgPfF1hbaSLLFAIm4oYvTd+cZJDu8KUZ4C3SmO1XCBU4o8pB0D6qu0
	NAaiJdrejJeOf1L+A1MSlOttx3q/YjRhkEGdU72WjKRWiWNwb1GdH9qApbKiN77Lgs//+3EcRq1
	kZ55p+E3lniXNRpLwvXbNTD6uLsjplRujlYWCDHcp0bZ0dJ467cVE5S8DaSauNZRFFYWMC9LHRn
	ubqyCatwWibh5a4Y0f4zgZdHPl/IyXM93KMCATqO7qTMobZZ3N69Ij8YReud76tuZuG8qs=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr17110032a91.15.1787447369490;
        Sat, 22 Aug 2026 18:09:29 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/9] selftests/bpf: factor the permissive-mode skip suffix into a helper
Date: Sat, 22 Aug 2026 18:08:54 -0700
Message-ID: <20260823010900.1730708-4-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 49 +++++++++++-----------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d71345c2e86..04eea6ebc75c 100644
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
@@ -487,26 +495,22 @@ $(OUTPUT)/flow_dissector_load: flow_dissector_load.h
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
@@ -634,10 +638,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -651,10 +652,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -668,10 +666,7 @@ $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
@@ -693,10 +688,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TR
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
@@ -729,8 +721,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
-		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
+	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$$(call skip_on_fail,TEST))
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
 		$(Q)if [ -f $$@ ]; then						\
 		$(if $(filter 1,$(V)),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
@@ -964,8 +955,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
-		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(call skip_on_fail,BENCH)
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -1018,8 +1008,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

