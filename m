Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8B35F5E3
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015956; cv=none; b=bZiYyDWeU26P+AzTL0prHKCmnPLJtBWs4NaPv4HYomjVJphkp/jgpHMgmR/hwyQmx/RgvoZA27eGfUQNTpAV6NrkW19gTYdEodQ6KJXd6WQ+5OOKw4S+PvfYdDgMGGG86mfiMoStJVt4kmZFWbuK3m6iMCP+BUUkE6lJ7VE1tmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015956; c=relaxed/simple;
	bh=r15iiIOfOJ1pQmzR+P3E2oK7pjlkypxsnbC+ljvW0z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqyDEvlFhvIHHlViXZ4uaKWGnx2rcuGaBLhglKnoqjXHpvAZbjpFxt05GJ/AdZIGXJeL7FezvNAdMWADgQpHxEg1Lcnrya4u3K+WKNX7N1leaWketN79RnF6Ns6iZPcLAAsZE2FdDulEeoH8FYYigZSW3DNr7hrAqmjdYwt1pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OumicFIU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OumicFIU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1344008a12.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015955; x=1776620755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwSeRF+OBZVsSZNxdTdFm/Y99y07LgP2iFoERbBkdqc=;
        b=OumicFIUU/Yctalx/0fEFoeoOXQLF/oMRMcNk2c14OwT7R0mNSiw4eHGTU76X6yp7D
         t8cSQxqWzzU09RevV3ZDt+/l87dgyqCZ8Byehr9T5l7UAv84yKq833GJk3jmL2bMPLuf
         8o1+z6JBi/EV/RMM4SP7Gz7gGsWgA8ZItPqb6jcj99KTNhTedplBQ32vQkt1ELgfzrRs
         KW4nBLikZhtuCK/OSDsEsgCDybEoHkGZDCstGjqLoyHLf3PESBq8FACI0spIsFRzxPU/
         WfC2E6sUbo80IFyPL6TLlbzr+hndPOAxs501yUIqJclJJcHYneaH3BRBBJaKzn27Ha6l
         Agcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015955; x=1776620755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwSeRF+OBZVsSZNxdTdFm/Y99y07LgP2iFoERbBkdqc=;
        b=q0zG7dKip7afIJ9t3ShChnlLKp2RWApiUlB0MG5Cg198GngZLFKusiwxLzpeZH8VSk
         A4Zf7wJiM0NZ/bV84Kcf+U/LcxIgoK3JWqU7ASdWRb2/Fl/Pdh/DMRq/Qkyxa5TsR0gB
         5pJ7G96ETaN981OUrIpMpprWsFp0p2eLEHx0dCGnrVolRmgpfutdS8P6IVndKoSqOZtC
         lIR7BdXO6JIdYii7FeCgMAbJzFuDk3fC8/P6Zw73oyGm3NQwbIzKWugX9Zii4X8GjvMw
         khwVR7JFlIOtpGKcPFOFo3h8rZZ3FkPMzkaSaQP5+6whdFLdrcwwcyEh9Cb2A872I6ZI
         nmXQ==
X-Gm-Message-State: AOJu0YzAjf7+H4I7mJgngn5EN8CMUqmyXOl3Wom22sY5wbd3Us1JKwn3
	PILUoJ6Qe+lGiGS7wXzHkIUeaX/A0QIXVC/UoW9MStrP4T5FsmQ+o3cS3bY03Vi+EkhNsPbYQuJ
	oQJftbEg=
X-Gm-Gg: AeBDieu73zim3iPkVsJEPQGu/mlyTQHiZW6HySVdlEb/OqaQa1idB1bxhnBLS8i9ify
	dNYgnu3XTb2wb5OD721U+evvdp4AQEurDkWwjiGkSUCu3cY9qrua2vUXCLpQDilPlYMymWS7WfB
	ga8C4LYdgh/tGJ6PjodgwL1tT2KJ3flQkhlJpqkuUoyBe6JkdvVxOMZSgp5pvA39M0TzcOzYpv9
	nCbUHqq2OzVWS1VuEeJwLAQ92bPnHJlzbq5qwWa7FMojpRNiyV8u+CULhVTpPmcsJqjGCGVItV3
	9dGFAPJ+xHwN3Ne7gRKASxHXPvgktbJoQvoyjWXollj+QmHdh+PBlCvwD3oLRAuF1IJOKdmTAfh
	vRw3v4n96dShMLvsfnJLgQ10s0MgjDYPX794CLlqV/N5c/u5y+68hm4AFoJPPL+xpE4tAGKPiSs
	Kruxl81zZloKEY
X-Received: by 2002:a05:6a20:1586:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-39fe3d0e3edmr11046032637.20.1776015954696;
        Sun, 12 Apr 2026 10:45:54 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:54 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
Date: Sun, 12 Apr 2026 13:45:41 -0400
Message-ID: <20260412174546.18684-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. Deduplicate the definitions by moving
the macro to the commonly used bpf_experimental.h header. Also
move the READ_ONCE macro to the same file for uniformity.

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

