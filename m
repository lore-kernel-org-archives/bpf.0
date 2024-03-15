Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E097475
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469135; cv=none; b=KQYVmDQBzRLiWqJaSlOJWGj6BHvHBRKKWEKH0ZaMZSdSdJ3+7Aq61IlfeIS2tY1UUR+7NIpmEFzPnz74oqlSBP092GAiG6ldW8Q/hKmLQNX0NrWhjk6G8Z/0HboTGTngG8hjv2ajGheSd3GQ9KBaYAQ7mdpq/fX1lXZ9W/oA/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469135; c=relaxed/simple;
	bh=fRGxwgZJgIun9WG2Q0eGtrpe2RH7X+Ujdo3jnRHJpIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0BOl8IIqaVXSj3Hm3WSMMh9EeQO+HQiYShSVgTiqNAbjvM9stA0Tj9Cd7tUVj4JmmDh830arVzxZRI7iKa65xX6dcCeUp10URm2YPEPkQ3M7grDeoF5wV/RrFCu5/VlgfDc50HS725JKVZlD0kNWGrLzmN/3XzkUz3Bgxf6fwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRl36ZQu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRl36ZQu"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ca3fc613so1495853b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469131; x=1711073931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw9HNpkPu3M15nlqCUXDEG9a1OTpQP39gAEymrsi8BA=;
        b=QRl36ZQuyQ7NNRLSZ+hvTeD+MFk/elkKcaWmaXVIqCByxNzyDoheBEwcHbOWobNut6
         APwGGT/tED/HOTVLmmE+X3OHOl7bz/gn/BbtoXRw1O/WKYd+A7RwoVqXcaZ3n0rlzf85
         UYRT8aqTlSWN5akpTUTXsY0igHqeUFSzTJVCUKc8Lfs/TlqOwKHAWvp2Nycel57wLT3q
         /JPXIDjUiPtNMCPn7LHIeJH1Z32FI3PVnuYihOHmFThKRg4LWWLCgXwy3R1C2LhHiaF0
         Nol4S44cCpucBoa/fCcMISeprx3FxY3gEzRib7dsKHvc1KwMdeorBPXUW4dfJb1+UY3v
         RAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469131; x=1711073931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw9HNpkPu3M15nlqCUXDEG9a1OTpQP39gAEymrsi8BA=;
        b=bB6ZHO3PJCO61LEcOQUE5Bp8jLZDzW87nqnPMLGcdttmCLC7ucu76zZ19ZFxp264GG
         QhD+BOI8HkOezVTL0wkDWKyzVcaHFUB/hPnAT4A2g1Jq6WGMQCZhrSv+vf79qp/KHIGz
         sGHY2oY4DWe9nlzdIpxIgkSIZfXsD6fpTFrvsdSbdI9sy2VoOOJCrTGMRFCjwbtS9pr6
         iJR+/z7J49PFE7ZccylKBmbjsANtOovXO8/eLEp/4z+q/nr3o+B9yGOCEiHXiKZAwJZP
         zDCuKJcnzJ4hpgDLkYNY+LVuObBDwiE+XmmX0a01Xm8L2aS6t4waVQHbOBRtzPnKA4Rt
         2H3A==
X-Gm-Message-State: AOJu0Yx7Qyk0MEhQ8rAsEusEHFlgbIHCt3HPBjaHQLXd2thMlE3CBJIt
	3721WpYKVzSPMuRCeQGswzoDRsiWPnRe9Yf4VfobvUHs+tt3DmTjSNfOgqn2
X-Google-Smtp-Source: AGHT+IHVv7qMAuZXk6yisA4UZYvIHHSKJGRUPaOWUd9/fJij/X++y8wP21hB1Q8juuFBninv0yPwtA==
X-Received: by 2002:a05:6a21:1a4:b0:1a3:4859:1ac5 with SMTP id le36-20020a056a2101a400b001a348591ac5mr2126755pzb.3.1710469131018;
        Thu, 14 Mar 2024 19:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:12e])
        by smtp.gmail.com with ESMTPSA id qn8-20020a17090b3d4800b0029a4efc0231sm1695675pjb.56.2024.03.14.19.18.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 19:18:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 4/4] selftests/bpf: Add arena test case for 4Gbyte corner case
Date: Thu, 14 Mar 2024 19:18:34 -0700
Message-Id: <20240315021834.62988-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that 4Gbyte arena can be allocated and overflow/underflow access in
the first and the last page behaves as expected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_arena_large.c          | 68 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_large.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 985273832f89..c4f9f306646e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -5,6 +5,7 @@
 #include "cap_helpers.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
+#include "verifier_arena_large.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
@@ -120,6 +121,7 @@ static void run_tests_aux(const char *skel_name,
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
+void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
new file mode 100644
index 000000000000..ef66ea460264
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+#define ARENA_SIZE (1ull << 32)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_SIZE / PAGE_SIZE);
+} arena SEC(".maps");
+
+SEC("syscall")
+__success __retval(0)
+int big_alloc1(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile char __arena *page1, *page2, *no_page, *page3;
+	void __arena *base;
+
+	page1 = base = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	*page1 = 1;
+	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
+				      1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+	*page2 = 2;
+	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
+					1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 3;
+	if (*page1 != 1)
+		return 4;
+	if (*page2 != 2)
+		return 5;
+	bpf_arena_free_pages(&arena, (void __arena *)page1, 1);
+	if (*page2 != 2)
+		return 6;
+	if (*page1 != 0) /* use-after-free should return 0 */
+		return 7;
+	page3 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page3)
+		return 8;
+	*page3 = 3;
+	if (page1 != page3)
+		return 9;
+	if (*page2 != 2)
+		return 10;
+	if (*(page1 + PAGE_SIZE) != 0)
+		return 11;
+	if (*(page1 - PAGE_SIZE) != 0)
+		return 12;
+	if (*(page2 + PAGE_SIZE) != 0)
+		return 13;
+	if (*(page2 - PAGE_SIZE) != 0)
+		return 14;
+#endif
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

