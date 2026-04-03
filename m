Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B324351C3A
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190447; cv=none; b=USqgBI025sg0bR5hGbLpkOtGzyA5d3MX+pi63Ej/lfJGOmOYx2WTAdb0J4f6nXxxjroJPfeiVQ3Rt00L6yGqCX1tOWlz3My8cwbmuIPF0tkyU5q0/lWd7N7MTl4yL6vP/t7r8yZ//BuVI7q+eMJDSfGJC+I8FT0O9GzphhZyXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190447; c=relaxed/simple;
	bh=097UkMgcK70HYJdiA41N+qwQqusBvK0AO00+DHjsy64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn6EQzIhIKbiX7oXk6AIP0UnJJ7C0mJetEUcDONxQSOMxyDv4suK6YIBhVE5Q/bRAELUNg7KXcrZ9KhzB2Me3O12G7k1x+ISkopOlqJ5mPudH8w4lmYy+jcmQhpR3y5N5UE4dXJW1c68HUq0XBX5yYc4S2CpT9x5H/nAhPfdyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=z7+jHzID; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="z7+jHzID"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1305368a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190445; x=1775795245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl/Ti/FpHPPleZG4gMmW4J4qgPDrrOiRipIRLq9I2QQ=;
        b=z7+jHzIDcr5PyuRCF6VkziRDkvi5re9z0YY3ACEb84nbkFWKvJpt+HCgrhQXVEowWx
         QzkPrBSfW1sXD+GFzGXsY8UXr7K2YjN/eCYCd/aF+wmag/C2OFiunrbXDKY0JTi+jYR3
         IWstIbpjEc62BkiU8vwaKwD59pTEE8C4Z6YA2FaaZfFqDAzwEO5zxhAaQCpC0bvRReBE
         ugN8a4zPgGddw1wy3zrf+7NHnJ4VLQuVc5MCmxhU9OHAosPb7WFJTvvCzsz0Qerf3Jor
         PujB0WU3s5LJ/6oUVd98kwdLxHxhl+BA/uCtaH9I2XIgOr8zed4QHRo2VoPe2WTsEXn4
         C/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190445; x=1775795245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pl/Ti/FpHPPleZG4gMmW4J4qgPDrrOiRipIRLq9I2QQ=;
        b=cKVj/GIZG52KWtvtDRMYnh4WeCO/1TDHc9QWZX7l4h3HvBQvS8ysgMPBX7go8+BEQC
         Nl08pnOGKxKdZ4br281B9QYSjgx9uxW7rRNkN4Rr4uNoh59sXNbN6KRK10/RKRVilcoS
         5rXs1rNUs6uyV4gizVV8H0IeLPwY+cUwmsQQ3E6jyxwiZgRJRwj2mKlM7l0SWjBo0apD
         LV8fcQorRY3+O2q75klh6gwJLuEMBPDqPhEIt0m0rrpV3uPTJds+KBfHcnOMkNvJkMrb
         b/HZHFnDsnm54+0FhJzOpLXyiZZhK2p1bh+V1vyrIzxyDErxPEvQ+LaklcbgJ3sdgbay
         6JxA==
X-Gm-Message-State: AOJu0YwnJtz+nD2WTYaBckwgOHBwFasuKhPHIu6JJZnzgiUFMRVnBXH2
	5ptY2xUt+1NNV9UtEwTCdE2jQOCh1662sqQEDFYF8Pjq2QyaQo2Lf789pFrPuZcybTugL5mCbMo
	aAx24VJOX8w==
X-Gm-Gg: AeBDievJAruMm70UMq3INP8OILB/dZjsOf8YYXgCwDmTFCQ/IsrleKBtxAT+1UTPvRN
	Sxpqbn3CTipX5ZZnWAO6TC1u+WzjW8stIFFZBRwTKEz0fUzqgvL5n5gJNJmW9QRRQPuTi4R2wS8
	HRWa9UMX24cK0XanOetY3Jnw4mI4Xvqs5ap3FzFuFaHsw/uS1A9+6cyn0HU/S7TX1fAMSUhrSdE
	znC5ttydcGM4VvHR3BczroKMkUBhaNDzG5/QZBrOELQzfLT/E80GRDgLFJZIO/wlNIIvwseYjgl
	DD/y17VBFPF4y6kbCVHYZDf1ZbJlsM0s9VHkr0hLfabRN0AEJ8Tr5VrGhl2PG69B8z3SXlidFBF
	CiABxk7yzwzHPGXsqro2+LCrnHVLqFGc/AfNc8suFTHVDwioDOPan8dunCoviK/z2DAeWHeWFyq
	gCqA==
X-Received: by 2002:a17:90b:384e:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-35de68f7b3cmr1340428a91.21.1775190445378;
        Thu, 02 Apr 2026 21:27:25 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
Date: Fri,  3 Apr 2026 00:27:14 -0400
Message-ID: <20260403042720.18862-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_arena_spin_lock.h header is useful for all programs and not
just the selftests. Move it to the top level of the BPF selftests
to make it more readily accessible.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/arena_spin_lock.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)

diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
similarity index 99%
rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index f90531cf3ee5..680c9e6cb35d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -107,7 +107,7 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
 {
@@ -240,7 +240,7 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
 }
 
-__noinline
+__noinline __weak
 int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
 {
 	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index 086b57a426cf..6c04e7707644 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "bpf_arena_spin_lock.h"
+#include "../bpf_arena_spin_lock.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
-- 
2.53.0

