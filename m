Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B613AFCE4
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514193; cv=none; b=toWtnnjmBB6wUowvucP8icNUqlDLR5H8NkFhVoqUWxOqKT2vJhBgN9WvX7P9/CQimmcG0JG29+UUUVhmPotsgUun5zPy0jOrr0LWIEfm96wBoRPSkJbHyZg+XO9UMehpP+eMuX3FyS4aqovSdC3+estQHwD5fll6VYZgKGXcRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514193; c=relaxed/simple;
	bh=ysEdNoFJVdvMvNfk1JddM5cz/UCDVtvo53ifuzRNvTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twBTjnQW2rEr4UdxhzYNfaEIkIw3YOrvyJqxiyEVDw+XGqJVz6ihpYn1IwGpIh3F7ZGmTFOwg2rn03ynKV6PtTOoNsWcd4+bEk+F/X3xjhPJ4Vw6DluJtk3RyI0j1f1V7pmC7D7eQlVxCy6HYhpunZAtEkcUiFjT92MDuCkEfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF8OhJ7c; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF8OhJ7c"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbeea240819so1557211a12.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514191; x=1788118991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sCkvQv6VPcgfhVqueJg1l5jw4hva86meRvSj5neYow=;
        b=VF8OhJ7cf1289bP7+QNP0s9VNIq76zDPuYoV6x79F+MxJ75PPV53sdBWM0dbercxE9
         W6izPT9pMbgCPWhtMiDINrN6s7cZLWd/ueUWSVbwQa+wHMYo2BxxQs6lWW4TvPAyroRg
         zleU4YyBc7VZtxHSTzYDIaQNKr6a6WRxAmHhBmI8MGUBAqT2l4+/6mnLyjCJ4UQW+FEn
         TSA/czxz1zwjSlnuutnth+qms2/IwA9uckmlIe/A7BiDj5gCX0iDbtn56pp00o0cybEo
         +INeOM0asZDgNyKnJJnEk+l7hno/G5bAolXqb7MgO4VFRRy7NsRhau5QCOdOgMDC0nna
         nxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514191; x=1788118991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+sCkvQv6VPcgfhVqueJg1l5jw4hva86meRvSj5neYow=;
        b=jOPwysqfDGudiKBZVYbXGLOglr/z64O0b0Fh+iaQ5iEPrpFLc45lru+VLT61bt3CoK
         UNA9akxu75Km+q6ffh6rQh5ZJjjKntCliiYzi/V8I7bnjPe9IpjSqkaMcpRvwvRMo6Vp
         DXXcL3a+ZwZ+Tpg0LvV39kzGCdznlMRheOGlVopECQ1bFDrx21aMQ6JDfvUDZMnycCd7
         FXeipQAXnyUqHqTfJYdRsZvzlwM3sSLjZalhK51QkJ949/f8G4eIGH40COf48fCpyiRj
         L52CtbxlOYiDANXy830RYm1U7ObRqWgxOLwArfYbp9YpaiaV/v2nBYb9SPm721FmAkjg
         Rb8w==
X-Gm-Message-State: AFuF++m3Dw5MiDuYXcJrLvLOlvjXE+s3nu8Sf63XNcQ8cIzDE/n8Q/k5
	XJfqvpeGB+FdoOadhyOVZcD/75EdXbg1LWWFJjttBh4NfaeT0oVrD9MIyORLadA2
X-Gm-Gg: AR+sD11tUL6ftYjyETMUByneX3F3D0zWVEohpNdL2oNk1yJGZKtec+TOufbj3O++col
	If/kGGDgrcMmnhARdsvig22ykCUPZVWQUobZgPWt/J9I30E85s6Lzsd+TZv7VXtrzdEF30NmEe+
	EFrH+NSAyMm06DIOSenO7cakQZjczmOeS82cgpPoUM+H+SemOUtjIeftoCpAul4YmGaO8o3K9eA
	rxT0Qox9dw2B3Ea3ZMQvO0O7rALivy82+I9TekXZZKApuwIaRrONkwUAZhslLokD6PHHy9VqmS1
	MpkVLHpzjRdT8IyVjKtd1MlFvlz5XVnzvXrgd2zF0ee6F60KxOzDe0vGbOc6ysTYM+jixo1fHo9
	fi0P/Ye7nWvZIlxOq5C23JqJiS6Qly9EqtQTdbZRb+vRrAc7xBgnFqJvkU6VeHLWLC2lrZynuo1
	Jt4KwjPZHCHq53+luIJnRTlOLkHEloy1RGkOVDxj7ncPx84vq4Vo54UAYTVqoocntzeYwi82dWn
	c2V4Jx+3A1hf6WdeKIIxA9qA+gHq5NgvtMQ0v+Rsaiz7TZDMCO3c2Y=
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-395c33cf295mr38056848a91.6.1787514190802;
        Sun, 23 Aug 2026 12:43:10 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 6/9] selftests/bpf: derive the bench object list from the sources
Date: Sun, 23 Aug 2026 12:42:38 -0700
Message-ID: <20260823194241.3415152-7-nickolay.lysenko@gmail.com>
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

The bench binary links every benchs/bench_*.c object, but the link
rule names them one by one in a hand-maintained list, which has to be
extended by hand for every new benchmark although the pattern rule
already builds any bench_*.c placed in benchs/. Derive the list with
a wildcard instead: a new benchmark is compiled and linked in by
dropping its source there (its skeleton dependency line, when it has
one, is still declared next to the others).

The derived list is sorted, which changes the link order of the bench
objects (previously roughly chronological) and with it the symbol
layout of the binary; no benchmark behaves differently. The trailing
'#' terminator goes away together with the block it closed: the two
remaining entries after the variable are fixed, so the append
friendliness it provided no longer buys anything.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2070a07015ae..9f18dd291736 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -955,7 +955,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
 	$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
-# Benchmark runner
+# Benchmark runner. Every benchs/bench_*.c is compiled and linked in.
+BENCH_OBJS := $(sort $(patsubst benchs/%.c,$(OUTPUT)/%.o,$(wildcard benchs/bench_*.c)))
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(call skip_on_fail,BENCH)
@@ -986,30 +987,9 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

