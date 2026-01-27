Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CD325735
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537790; cv=none; b=reeWQc1tU0bGxgoNNrUlXxMC5zHmjVUMx5qMAvC7MMzDmD32wFc32YUp9kRHNTuijhcuvNyHAHM8g+lVgc+f9j0RdDHw2Tk4ytm+b3DKXovlZwrnrBi3BY773kqX02n9eTSVR2y+bRAUDcgUQnTwukJ+EQ1wEHv6KKxLSsOD1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537790; c=relaxed/simple;
	bh=cOQhmYuTWxPfKp0Y0ZNK0H2Z44mvMLjMEh281Ag7q5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeZMSAHBIZM+mpbOerzR0gbYJ9Mh+CxIpUiRb53aDJzrhbKtoPUufmCJTei9b3Wel1DbwqNFfsmkAFfSkiaEdHyZd+iRP/btFZjZSN44UORpKUfDqLm3caMieKd9aVn6FaiuRiOxmHuPq3buPRiddnvYjYoxr5I3bq/gfwPdAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ML03lO3p; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ML03lO3p"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501488a12cbso79098191cf.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537788; x=1770142588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhQy4YBt5STqxJHFB1/TP8YaKIdvTw9R6JrZKycFDsQ=;
        b=ML03lO3pzDKCctEqN/LRzp9pwQ16LMf8DEwI++ZIfom/gewRytNufWiEWVQEPbcG7a
         m6elaU+0yZPntk+LcEedat0U5VigAri1JxL1JztoYgu0HHI8Q26CPhYiYKFM0e39IefV
         hPEu2D0AGozZ5oornfo/1nrgZN+wmXpvYbxf+os7eeApumCIetti8LIS0wWU+bmHlkBg
         KuNiyoDAzImBHcILG8yaVYASUmz57bu4U2lHnjp5i+M7mhmd+dn/maS0ZxNUNlNda1Zs
         hdympnUOcZ7AubOhG2clh06kHk/TejTiCttwNU1EAxrFlOI2sX20FWh13Khmx4mazShI
         f2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537788; x=1770142588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhQy4YBt5STqxJHFB1/TP8YaKIdvTw9R6JrZKycFDsQ=;
        b=IsZuzuSK+wuocOanwC9FHXDTVhMeLxFWXD6SqGM5caGfib86rIVvIj7AS6JINAkgoP
         uEIIllsuKtdLNOWbB7gG1IlfuOE6wjgP5AwtRgEYcMIzPZJ26IuDTWkqjs+euIKloEmt
         ho4B/ynlElpsZbge2M+RF6n4RXdtyJ8pE6pKsLt1iXfbcn0eodmgFoozLKu+cCercEg9
         yxtcDrcQoedBPZcUSdVm0OwL/94eBnhfatxb5+daszrrwNko0Nh0FEzxXSisWn+FOY2W
         W2PDGdh7eDElkzUjp+FdAlha7K4ytvBP5rqUleDhJ0gRRDODIDQJK/NXLUuUrCNuS7Il
         Trkg==
X-Gm-Message-State: AOJu0YxWkLBdK+0twzdxH9Sus9Vso/qYN3S+Ryu8jzJqj6EWITa3TLAy
	C0iJ2ybnIMQi+U0Qu008wwi3df+u7ySOT6Kd0Cy72K6nDUoGL6yH5e1hJoz6p4CyYcRgQb7Txn3
	D+YPU
X-Gm-Gg: AZuq6aLpXMPVMYs6l2kI5wmgxnKeKnqo4Gm9MZ6qd5/7ptQVoWK5yK1OX8sDV3Y9ZCG
	mnCtDWsCi1TrXytoHOUDAu97WoAu+uGHWLC0CdhUxIyLHDJfzzEpyQC0kUwgpdFWJHyWqJc27Wb
	WcSlWyZrDc+68jDqOZx/nGuIR2USU74jNqVdabOTtSsIb+rReUUsUA20sYRwr/vmZypSKFJ8x6n
	5hknVsKA5SR30fKZ9hpFHmA01OacvAtClnN2ORcrrZd4sEbfRR6apzWqnvzwf4AMACHdluwIQnd
	8exoJoUtv7rLeBz4kFBss3VlInJuJRfMVBRKChdBdhA7lp+zUKmzmRjOIGJUn81ahvPxRY0dCjB
	zls7z0VX+F6cBlyiMUb6oo72VLM/iKK0/pDNK2noxEO6WGy8Tej3Mum7xfeRU/vigkml6ixASBh
	C6MUXwLfDkgkyz/pZ97VA9
X-Received: by 2002:ac8:5902:0:b0:4ee:2074:4b6e with SMTP id d75a77b69052e-5032fa034e6mr33329351cf.45.1769537787963;
        Tue, 27 Jan 2026 10:16:27 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:27 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 03/13] selftests: bpf: Move bpf_arena_spin_lock.h to the top level
Date: Tue, 27 Jan 2026 13:15:59 -0500
Message-ID: <20260127181610.86376-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

The bpf_arena_spin_lock.h header is useful for all programs and not
just the selftests. Move it to the top level of the BPF selftests
to make it more readily accessible.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
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
2.49.0

