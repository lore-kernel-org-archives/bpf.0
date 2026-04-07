Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DA36CDE3
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537858; cv=none; b=gjGuP4GE/5ZErtDnwKIZOR82xv5Uc1BMcP4/ErZQiHVGTbQiJN8XO6TT5ssdlio0B3w3YRH2gHnwUWruKUlWXVH6i+ZL9TatgKvc3wLB99z96yMEou9HChLqaXylYH7dEHe1cWQCG/IYX0t2BuZotfu6ASPZygimMXl4dzwVRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537858; c=relaxed/simple;
	bh=qf0RBOV2DBi8ccuopXLgz95L3fS68pTpglJpoI0eMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtoS8zAFJ4p5DPeLgizXyWTmlYARKygAq4z4HVEyYfHYQZ+rv2wd/471ynA6uPmNR71MhhmqOGbJShjeNaDZAYGGtXeqQgdxcLbXJAb0ku8F2PpFJH5IyFeZQ2P0Zw+l3Wbx/fnwNFViWU+Ufz0XcSmMSKMBCuf14rs1DQ0ficQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HKTrhFuF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HKTrhFuF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cf83bf375so1849941b3a.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537857; x=1776142657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=HKTrhFuFMPqta/6jHxKM3e3z8RhgbLPmnwJpuGvwdmlTbZWMnPzgjTzLl+vbsEhFv4
         pSg00tZs/BO3Q9fZdEEy56og9w02voWU4CXCNpM1Gu4cEhDrt9DSR44/R9UoDtKH5puS
         A+3nXtt3iKELJVIsZ/QVSf3h0EKbh5jqLxRidaBo149UhENRMf+Ygdtuz0D8+XveA8ox
         +eryrtBao3eoDWvG9O7Td5it6fUjvR6WL9l3a2mGR6Y7ahJ5LqonD15rE7BNKgu6cHmy
         JmlzICdt0Jht2CTeF4OAz5ieFCoxNZ2JXlFBZekzuKd9FNT2RTdl92hxsfuYDxCwWnu4
         +Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537857; x=1776142657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=Es1Fvf+gu3dLm26ldA+cQEgKXHTXrlJbmRZkcSctq+8swXSoZtMof80hNY4f8fhfQq
         EXJBpCtI40VQMQ/6ZZIKhju9c31AEyuUz1kfUwbVeinbccbfgTruVOu++WROQU4fFIDZ
         H5SZB80H2nWx6nnbDnqfZKvmZlxhZ1Tf7sNOfuIcpAyr5LWwbG/B6ImXELGFz5vCK6kx
         WMOYUp3cI3nw16kSLga0ZnODEPZcelM9mmgs/UaPTC8DuZKVYhzAT3mR34+rg03v9IJp
         R91gC8Ib2pxWphIKFnNmslIHTXntiE/Xvr/H87Su5i0W2vCANrdBJZhj6qKF/jHjNIG0
         sQMw==
X-Gm-Message-State: AOJu0YyA6L4bePmJ1ls5UXU7aI+4STdMFMHz85JZFo/tla7c+VAyENVJ
	hdYRAAhFiYIMJO0AL5kEc1c0FgAJc65XJtQ+1En6HH86dISLpwXX7BEKp1YOV3vg5UK7/Fc5ibQ
	cxJxrZxmNCA==
X-Gm-Gg: AeBDieuCMjuYYUNJXXm+vYU4+jJt2P9rg/r2ZEYapjQBFvjyB4Jh7v0VWrfXFPn65Md
	DvptfIEFEaq49IlQOGc1n+CBwt13+gHJ6ksj3EM9Jt+FyDvHTn5jHUNrC0q1YWCOULC0ynlFIIM
	gScTVTFaMXmNfFNzVvIK1BlPCfju/3LxHqZ+jH8opIGX6gPQIeR9QGOgIzUPrO2taPoEsTi6dU7
	j6dJMVAqX4+DAF+eBY4v5U5nyTsAFomeP/NIZqOTVMBB3+q3bcUfxDfY1gJlNSwt5umAxYJ6bor
	zdoBcMYZM97Ff3ZoRkTdgB81YmRthUBuXpXMG7ODtfRgGltNCiwBuc/4+inHt+Mj/USO3FGu9H3
	z1NJDzFzNG6a716Tc9577oBZ62dMSubOJXfgJoWAhfINlqlr1P400Fx4/Ns97h/S/C9mnvq4plk
	oFYw==
X-Received: by 2002:a05:6a00:3cd5:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82d0da33ed3mr15503749b3a.9.1775537856624;
        Mon, 06 Apr 2026 21:57:36 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 4/9] selftests/bpf: Deduplicate WRITE_ONCE macro between headers
Date: Tue,  7 Apr 2026 00:57:25 -0400
Message-ID: <20260407045730.13359-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. Deduplicate the definitions by moving
the macro to the commonly used bpf_experimental.h header.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_common.h | 4 ----
 tools/testing/selftests/bpf/bpf_atomic.h       | 4 ----
 tools/testing/selftests/bpf/bpf_experimental.h | 3 +++
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index 16f8ce832004..a0503ecbc315 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -2,10 +2,6 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #pragma once
 
-#ifndef WRITE_ONCE
-#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
-#endif
-
 #ifndef NUMA_NO_NODE
 #define	NUMA_NO_NODE	(-1)
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d77338ac7e6b 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -40,10 +40,6 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 /* No-op for BPF */
 #define cpu_relax() ({})
 
-#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
-
-#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
-
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
 #define try_cmpxchg(p, pold, new)                                 \
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..56214f7051c6 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -11,6 +11,9 @@
 /* Convenience macro to wrap over bpf_obj_new */
 #define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
 
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+
 /* Convenience macro to wrap over bpf_percpu_obj_new */
 #define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
 
-- 
2.53.0

