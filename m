Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B633E34B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447384; cv=none; b=n85hyBrzSUU9VwYRWdINp0xh4/SQhMdgDAZ5rnbJCLC43HkCXblSTKXN1xpb9BRJnoJwo6jxgJCLzVpMQNvy0SXpqatYZWh6tOS45ZxLUtGWyIMgGjbpl9vZduzRHmtbQgTWzx3/2zaYyw/lg09BgEYo2ZaB7szy2MDOJ4B3qXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447384; c=relaxed/simple;
	bh=6yw/wo3cwevegSmF5bLlqsqIzIScAeJYsD9wUe/ZPVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehL5N9aZeAknoDJMphpiq8fGGjbK/E1ennvpvLI/sPmrea4Mqbdg8ks59nWhjQzvXweAi01NKZBXYtglHWTMXYA2/nmZbIxotHSI/yyBtNEZJ3o2fdhgg66m/TgwINo1Fq8HRcKVmdgRVTEL4xXRPhSan5VcWWrBcrWF5hgwoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW6nhz07; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW6nhz07"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d58efc7356so25886805ad.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447374; x=1788052174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JlVmT5fjC0de4SsMxy/18MiZHgBMFcaknUQZDRuKdg=;
        b=GW6nhz07t2HmZz1ZwJuZunWIxPfKUdPm6PU2WwibN8orXpvcGfvQ0hOz9RHdieGVId
         DJU7RzbJfct1tHejOOITm5J/i7VEc/0gqsjkK93NsJd+33cHNP1aFsvSUWf6VBwpKny/
         npBPlRkrxNg6ooHUdV1RXtnNLm/VoHBI39iiZRCw+qkll8P58fqXdJ7aYi75O8SZUXGe
         yRozf1tw5bEiUcD+1HCdWp8lhGsG6FvY5l0RsgjbD5KlWJDgHUgMUwwFMLduo1b/gY+y
         cPnbqhycdfbLpdHmcVVQ+qPet31mgMUwTlREXSIcaxEL2FwwS6SsBb3SRIKwwEiSvDEM
         N6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447374; x=1788052174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/JlVmT5fjC0de4SsMxy/18MiZHgBMFcaknUQZDRuKdg=;
        b=EP7jIb4jyfFucRAckGQizbnHK3s1z65WMtZclb7kZjQJhyMtzbsPZnhaiC3trqEYN7
         Je4tmge23yc1XbkQf4IClibrjOF9rL7LH77vvZLTv/i4Yj6alq/QiWGZBtgPsXKpgQ4W
         3X0qd/uo54QOszClL4X2esV1220PWV/6m0xHgJLn0IiOQc2yguRTowefp3rLf9Lb3YEr
         3CrF9kRwkd7g6hLqG7FF7qBlSaEjuThYosGX/g/1QX7LLFdo8gMPoPO1lZrZRTsQHb70
         06aWa7DLnKVchtbMHdb4NGX6EgS/90t35bj2A8pwK2yuYnqzoLD6fpmdhRAkxaBdp6DY
         4BXw==
X-Gm-Message-State: AFuF++kODEC6HAB9pNt2xkAHO5FArSlVP9nuNzSXVZ4nDbLDTdb5j8Vq
	9ES5Du9UAJQJrufteX0RAYRScECA9A1L21y9dbvI+73VtsNR9I0GxKtXmZGO3IMv
X-Gm-Gg: AR+sD11QKdQGAnTsRRER/zCNSdTbDHpmH2T39KeKCxk9P2qG8uK6N6SvGawmrZwHcSf
	WXo+eZJVhYISczD69eV4I8JWrha3vVAWflsPwa0veaXTBsprF6Mc1U3plH0lqrTMsrfFEPlAJ45
	UpwnzUkI6mx0ifLCNTG+YZBcvB/tprkFeZ5Q1T2l1jiCsYeUdDCOnrtI1p0+aZ/0TqTFECqoRLk
	DSRYmVTIEw6yRjp6c0hIbDaxKTYRW259eHZMGE2WoWnHP9IIhceXeUrXMhFcDDjBfF+UYxz1w5V
	NoS6d8zknYUqzU0F7VRZP1yXJMf+7/bUExRRtQZP6WLfgk0DyV8bZTos3YAM2s2bIaXhvXdov7w
	OX1frXyDlT7euD3MbPF3+IIiQzAkomRvnfbnhvscC/4LYOn5bdMO2hnEO2YAFPpGSfRanulR0id
	0ZD3b8mNMV87i7DlSxMmZ0YsJZilrJPT9irl+p4msGYhK1a93PeBq0DHW7qtquf4zUtbYd5puUm
	i6SRmW4W33TZfVqGA00phw0oXRCwLuwcuX4nKtofU32E5JzKipiAWoFYr1Hz8JEBQ==
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-395df24e757mr15972345a91.9.1787447374168;
        Sat, 22 Aug 2026 18:09:34 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/9] selftests/bpf: derive the bench object list from the sources
Date: Sat, 22 Aug 2026 18:08:57 -0700
Message-ID: <20260823010900.1730708-7-nickolay.lysenko@gmail.com>
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

The bench binary links every benchs/bench_*.c object, but the link
rule names them one by one in a hand-maintained list - adding a
benchmark means writing its name three times (source file, skeleton
dependency line, link list). Derive the list with a wildcard, as the
per-object skeleton dependency lines already imply: any bench_*.c
placed in benchs/ is compiled and linked in.

The derived list is sorted, which changes the link order of the bench
objects (previously roughly chronological) and with it the symbol
layout of the binary; no benchmark behaves differently. The trailing
'#' terminator goes away: the list now ends in a variable, so the
append-friendliness it provided no longer applies.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2a99b040301a..fdedfab25d72 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -956,7 +956,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
 	$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
-# Benchmark runner
+# Benchmark runner. Every benchs/bench_*.c is compiled and linked in.
+BENCH_OBJS := $(sort $(patsubst benchs/%.c,$(OUTPUT)/%.o,$(wildcard benchs/bench_*.c)))
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(call skip_on_fail,BENCH)
@@ -987,30 +988,9 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

