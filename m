Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DE30DEA6
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977587; cv=none; b=HIgHkekoBJHdl7x4DH/zzMsyHan87Mb/BKVOrcZNPGxIfBWGohhD4VLqyvL7wDYwhO3TFkm5O1CJGZvmoP154XVUgFAb5EiBAprMoIbwyqZQHoHAwMl3prSiNZUVDqXU+iUt68YFLYeuEq+mkkPx5T44fchkIy35gTQCiR4uYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977587; c=relaxed/simple;
	bh=cNEAhccFxK7ECb49KDgLHHMvIxpr0he2lkGTONekjfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWgzXatnZp6bb0HlhgdDP4CJ8/6TOSujLe2DG66a99l85Ia6/2wH9Zqc5zw2dtjr50w+fsjJDX8QqMqjeYB+/WLzMSpJZ/aWpKgTpRQbmq34IvATHrksJqHnoI1pbTQ623wANK1PN6QWQR/g3I9xOLvjptCDYy0+fVuJmkOIL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhYinYkw; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhYinYkw"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so799674a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977585; x=1790582385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfpO5FEPxmdK7lE9IAY9fAaLr4IOsZrDtgEtwNko6kw=;
        b=nhYinYkwYBkfCTqDPyRk4zFk7juASxnee1nW1D57dB/52T7y8Vyjv+LuGlnZhDP230
         KxJyA4yubsXbj0tG8sHqblpsrx6PH7CSQKzPNRj06/sHyHhGPDNoU/aOC0oXqt0BVRHU
         iXke3D8yXN3WX8iGj8f3+/f9QYuatn+0gz6Gwpx10g8lZniG+oQp83x6dfvfIhd6ysSQ
         GKMzI6wHMt9h8FCZumOAWA8+ZPTXvkgEyVBAej2ZudqujUqhD5EjJ4J+ZXmv+bkl7LKj
         0XLGzmnXaiSTDzqrI3J2dtoZwcTI+2ATVaS4WOByCzJ08nRplw7571heNN0s3y6p8jdy
         x0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977585; x=1790582385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfpO5FEPxmdK7lE9IAY9fAaLr4IOsZrDtgEtwNko6kw=;
        b=yOQ6T5jXX844l0cFTUxZUDD5UqZ3wCqhJqj6A+VVdOvcaMckgwiL5x7e/SKH10JMF4
         QgXbHEodKwi+mY9yKQBI1u/PgNuRQvkJZbDKkUI3ZWc5YOsAag1LrwtEyKWNIFogY24O
         IUayYael9WZq6je+wFjZTFjg4jRoeNiokX/GiEwkkLTTCNRgyEXVwqEtW5acyKe+TOFC
         HrAeGPXk7FnG8jUldstdjoghFgFoQRf7bxpG+OL3I/f4H7WocZ8phnvE0bEUsjuaBzRH
         twAGievXvUklhrVffWtTeegyFcY4ZAKuggYcSIW7QbqSYuSPCs5a6zZ22r4asQ6nN1/7
         QIzA==
X-Gm-Message-State: AFuF++l3PY/Y0+e1IZsMF9KbabNTx7V9/EkSTfZWJtZv1NSdIwKjIgQE
	8Jpi5NiPY3cRhPVWc9C83JnZwSDn10Eq5iYuUti9U8mQ1BUY0v7AVkibf8S/5Td0JQg=
X-Gm-Gg: AYBFou11bHiyP212vZ7r79GuPvT/pFCTxmmvTB3pFN8uQfojpzludEgJRasKBslbHoP
	8cReDFCZgwAxZD33xosx8vdXPwU67XHUl+zUn3ZDdDrhUEgzDJ+ABnGazBMXLXL6ne/P47JCOv+
	3NtZpEf0EP1lgbxTJya2CmioxI0aoc25IrkZPpEXP2PdQj0vU/E4VFwxdHFo3b7fU4Gg/MctS37
	DbfqT8Wq1t8bUyqKD9Yxu/Kqi1XHMBcweFWj/ntVYamJ6U++sUWabAj1Och+CwmFn64vSi/LNiF
	SYlu+G7zguXflWHJqktjWJs0S9uhOBSKW/dNvmFFxLK+9ec7CcBNdKqgVm39kEOBmGyDN6nyZOt
	BRAL2qihp6mdfLb/S7dXj6nMTn1u5JQXmP6JHPF07oi5vIeAQNeRZ9IlqTZcTa1EHw7PhoFVFim
	va9n1Gr5yKRlbYk4skmWZtKhqVtgWaJz/P6C8gLKsXcTnYtrwfQGLy8oCkmoF+sZ9/mcrhzOL4T
	2WYlUcvMEwQinVQaOUf2eDhDIOelJSWHNZGcKL8xxxdxMMJn+Cu1ldawBV5QBIT3Q==
X-Received: by 2002:a17:90a:1057:b0:39f:d323:c988 with SMTP id 98e67ed59e1d1-39fd323d93fmr5427357a91.48.1789977585132;
        Mon, 21 Sep 2026 00:59:45 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 6/9] selftests/bpf: derive the bench object list from the sources
Date: Mon, 21 Sep 2026 00:58:52 -0700
Message-ID: <20260921075855.2065871-7-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bench links every benchs/bench_*.c object. Derive the object list with a
wildcard so adding a benchmark no longer requires updating the link
rule. Skeleton prerequisites remain explicit.

The sorted list changes object link order and the binary's symbol
layout; no benchmark behaves differently.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0e23cb506777..99237c3b32d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -951,7 +951,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
 	$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
-# Benchmark runner
+# Benchmark runner. Every benchs/bench_*.c is compiled and linked in.
+BENCH_OBJS := $(sort $(patsubst benchs/%.c,$(OUTPUT)/%.o,$(wildcard benchs/bench_*.c)))
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(call skip_on_fail,BENCH)
@@ -982,30 +983,9 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(TESTING_HELPERS) \
 		 $(TRACE_HELPERS) \
 		 $(CGROUP_HELPERS) \
-		 $(OUTPUT)/bench_count.o \
-		 $(OUTPUT)/bench_rename.o \
-		 $(OUTPUT)/bench_trigger.o \
-		 $(OUTPUT)/bench_ringbufs.o \
-		 $(OUTPUT)/bench_bloom_filter_map.o \
-		 $(OUTPUT)/bench_bpf_loop.o \
-		 $(OUTPUT)/bench_bpf_for.o \
-		 $(OUTPUT)/bench_strncmp.o \
-		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
-		 $(OUTPUT)/bench_local_storage.o \
-		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
-		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
-		 $(OUTPUT)/bench_local_storage_create.o \
-		 $(OUTPUT)/bench_htab_mem.o \
-		 $(OUTPUT)/bench_bpf_crypto.o \
-		 $(OUTPUT)/bench_sockmap.o \
-		 $(OUTPUT)/bench_lpm_trie_map.o \
-		 $(OUTPUT)/bench_bpf_timing.o \
-		 $(OUTPUT)/bench_bpf_nop.o \
-		 $(OUTPUT)/bench_xdp_lb.o \
-		 $(OUTPUT)/bench_libarena.o \
+		 $(BENCH_OBJS) \
 		 $(OUTPUT)/usdt_1.o \
-		 $(OUTPUT)/usdt_2.o \
-		 #
+		 $(OUTPUT)/usdt_2.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(call skip_on_fail,LINK,,(some benchmarks may have been skipped))
 
-- 
2.43.0

