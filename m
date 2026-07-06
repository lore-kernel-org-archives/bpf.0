Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEB1C84AB
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378259; cv=none; b=W9z1faaAfHO3IU3Tj2bQDqxIGLXHVs3t5R2lH819HKHxua2IT1IJmQPAA1NO1iVp18Pfy6uS5dB9iQriwBTPayVMuslqeHNjw+QNlcKAO6sISyCK39gWsuZxu/Mh7CxJWDM10z0fpyfAeIWtYWwLKxpcyD+Rjj9HSWFQsBa/3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378259; c=relaxed/simple;
	bh=tMyt3Es51+LZD3opnHgBp9wZal/BxU0JHNo4cRNwQeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zt/4a5wsrUuA48IdrEn0yj78aYik6JW6QmgHi4T4sPdEmcinGy1qBPdtFhtV+9l+IjC9nZlY2/RzhqJ6642/WN+1hhryztPEgBhVG/JJG/V027pIVDL6fL8EdMFNS+dM5LQy28w8+PZF7qmXHddZlAYTUPIIzApxhAdBAYbtQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=q0hegzkk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="q0hegzkk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454160043aso3494303b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783378257; x=1783983057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aq+9wion5AudJfiVlMgdurOInEZzgx8YX7d1sZVsmfE=;
        b=q0hegzkkJIoKI7Dovvk/gcdL/XXkYGtAXHKpbmZGEXRPnlnxvAjNjPTXVK6LT/kEKK
         y0SKV+xRmRYIl5Sj4MAm97dkLJQQzBYGdUbLtS/JB0z2OZugJfQ1L2BIOtx7CeD9s3SZ
         xt4jhsLmWhsc+RANZyusCZ+utjHXfci4xp5S/AZ0uBTwF2CJfHDTDbiXBnQD9oqCIRf7
         BU1lt8GqabXm3oCqVGoi1XgSC+wlGm4IgO3w/t7SabTg8DsB+Vx/DIlQmWADNLocgPq0
         ytIw6IOZfJD+yfmMLhtjXE+LDB5Uud+nON16So3SRDEEyin+kSxRfCxRqpqY3n4gG04A
         uIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378257; x=1783983057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aq+9wion5AudJfiVlMgdurOInEZzgx8YX7d1sZVsmfE=;
        b=Gv+P6cqJi09mw6p6U2jYqoMBB4SUSDTD4uVCTQM9P5oM10/qSXsw9B98LWaL+x9HTy
         zvyjLCYc/4PvhIjZJnH+ICkAa0xGgMl0stMB1/TN1XSHefZsDoDzjanvTR5EjGDuxsYy
         kfGlUEN1spetm0B2GAUAunepZGABUvTK2iX/hHkN08QDkktMghYbpgv3HVRjEeP7Ge7G
         gh6rsa3mKtQcUGXnxqZCRuZgwEXDNmXXPErkcWKV3oBMZtlYwZi/5EbeREhIhxZWo4/j
         Lqp6LGKy6+iAeWTTRWUkoZKm6oy+sW327glac224xXBpKj/Fm7lyXaqyMLwuDmtODjXz
         jJ8g==
X-Gm-Message-State: AOJu0Yyk2EIQBWEnOXJVQ0uf5XfymcSI0TuCoU2HYqcieh7p/7yss99h
	b+Ai2aULnbDptbUnuinEIQNWgAkK4BOrBP9VGzh2PqutzDRjK2I/ZczWur18+7bd/otvEiiN6Sd
	xZrjXTbg=
X-Gm-Gg: AfdE7cnUwLzWMu9CG+NboH5b//KwkHgi6H0mO/ftTeF3P2yDPL+uz+n5RJnDY6iAHAP
	X8NaZsIurFKhGKgkKWL1roa2WSiPRcuvzM1OOEscNgZTtZL84LRA9tFyvxo/tEMCgVJVbK7MZ5A
	VlUwmGAxCFdJ89wCXQokdZplPv0k0G59RJ/c/GfNZ0Sc+H2Kn3fMV5FM/PwEZVQM199LDpwxPNG
	vWjX9V7RVv7farKmHhE/OUK+ByDogzzl4IL5PWUCTXT2SO1OyLOKhDqABmu1iGVZLnYU1utD9xe
	rPXVe7SRakt77NieWciBNdipWj4AP3xEZwdxOq3N5k6PkD1plePsESUEtyOPxIm9Tp/4Q1qhwWy
	JFjsHZQF7ncFSMTVj2AgzLcLWFWlYjt3UNt4Vz/8d8dPo1DHeggiMabh+AhzRlVyhsODCvWeeFU
	WiFHaRJZxG4hCQ6NOKoUQGIc27NNhLKnHGsazvDyvJ2CpyAva73ehw5giEKQ==
X-Received: by 2002:a05:6a00:14c3:b0:847:9a16:4a61 with SMTP id d2e1a72fcca58-84826f45ad1mr2453333b3a.61.1783378257042;
        Mon, 06 Jul 2026 15:50:57 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm4520909b3a.28.2026.07.06.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:50:56 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] selftests/bpf: veristat: Minimize map size during verification
Date: Mon,  6 Jul 2026 18:50:52 -0400
Message-ID: <20260706225052.35543-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The veristat tool verifies that BPF objects along with their
maps pass verification for a given kernel version. To do so,
veristat loads the objects and maps into the kernel in order
to pass them through the verifier.

Currently, veristat sizes the maps according to the max_entries
field provided by the program author. Depending on the map type
this field may be irrelevant to the verification process. However,
loading a large map can fail because of -ENOMEM errors.

This is a problem when the map is supposed to run on large machines,
but veristat tests it machines with significantly less RAM (e.g.,
CI). In that case veristat fails even if the program verifies.

Expand veristat to resize maps whose max_entries are not relevant
to verification. Set the max_entries value as low as possible to
avoid -ENOMEM errors.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/veristat.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a7db6f04f7e1..8d374e140653 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -37,6 +37,10 @@
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+#ifndef div_round_up
+#define div_round_up(a, b) (((a) + (b) - 1) / (b))
+#endif
+
 enum stat_id {
 	VERDICT,
 	DURATION,
@@ -1238,6 +1242,17 @@ static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
 	}
 }
 
+/* size of global arena data in pages (minimum 1) */
+static size_t arena_global_pages(struct bpf_map *map)
+{
+	size_t min_bytes;
+
+	if (!bpf_map__initial_value(map, &min_bytes))
+		return 1;
+
+	return div_round_up(min_bytes, sysconf(_SC_PAGESIZE)) ?: 1;
+}
+
 static void fixup_obj_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
@@ -1248,6 +1263,37 @@ static void fixup_obj_maps(struct bpf_object *obj)
 
 		/* fix up map size, if necessary */
 		switch (bpf_map__type(map)) {
+		/*
+		 * if the verifier doesn't use max_entries
+		 * then set to 1 to avoid -ENOMEM
+		 */
+		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_PERCPU_HASH:
+		case BPF_MAP_TYPE_LRU_HASH:
+		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		case BPF_MAP_TYPE_HASH_OF_MAPS:
+		case BPF_MAP_TYPE_RHASH:
+		case BPF_MAP_TYPE_SOCKHASH:
+		case BPF_MAP_TYPE_DEVMAP_HASH:
+		case BPF_MAP_TYPE_LPM_TRIE:
+		case BPF_MAP_TYPE_QUEUE:
+		case BPF_MAP_TYPE_STACK:
+		case BPF_MAP_TYPE_BLOOM_FILTER:
+		case BPF_MAP_TYPE_STACK_TRACE:
+			bpf_map__set_max_entries(map, 1);
+			break;
+
+		/* arenas must be big enough to fit all globals */
+		case BPF_MAP_TYPE_ARENA:
+			bpf_map__set_max_entries(map, arena_global_pages(map));
+			break;
+
+		/* ringbufs must be page-aligned */
+		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_USER_RINGBUF:
+			bpf_map__set_max_entries(map, sysconf(_SC_PAGESIZE));
+			break;
+
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_INODE_STORAGE:
-- 
2.54.0

