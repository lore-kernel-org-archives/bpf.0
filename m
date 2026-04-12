Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661826E6E1
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015955; cv=none; b=q14x4AZj1aGYtO2sAx8OEX5uwQhHddny4/rld0Yid7FFi5ratWj0z1rw60mt7rgO2/ZY0R37D5YA2adPTBHHNoeyEkKJSwOTDCAIAqie7SKsJxjPwR6cO93laCn4bW9EZx7hismjyC033vZS4ZdKg7CdmbPRa9l9YOjJmbSolhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015955; c=relaxed/simple;
	bh=shZ0enJ59npB3KE71/s8XOrWBVkaVD9xxM1dGSHiKDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/TwTE6w/3jB2+LQ5sz/J5V4e3vPf3Q8rBVInQHrc8/s6pFxbFiMofk9kdNd30vfUESzjz1FWu9ixV3QW/siVE70EBRPDo7HuRPUsZPi1oBdvfaXBifgYl/kV0C4OTj49elRAfvDyR2nnDs7GiOSteGLKgREX8AsUUpJatFl/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=An8YzYUl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="An8YzYUl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f41fce3e6so16192b3a.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015954; x=1776620754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=An8YzYUlpFMY0cc1k8j3xkRVtZM4dZBazAmYPlBcqUHT0STReBTidiGca3HF9lpqPw
         e5Ia7kha+/CO9Mzb7cH/yFpMNkOm+RozT1ig7IOvSECf5OMaBru9Ys1El/UI5S5fSAF4
         Hjj2bC/L+FKqw7QhEJuZN9ygBvh3tpHAP/ZKGtn7B5ho1nSvnbXGxh5ggvQ4VvNpaurl
         rLqVy2pk9RjP8+AGk4BMfuq774TFJEmm4EaBYftTDUM50eikElPS+EMJsj5d9sHXj9wd
         OhX3FiSM3cn/OiCfHfNxvwQ4QuuQvpGybofRfbsWajC6u1Rc5RAmf98269HchL2IBdAb
         Xc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015954; x=1776620754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=q/gHpCWNrMWQ5TjwPRwYmCwmzRWE25/HABgxeNeRbslS7tQSKoUoBdW3s6qHI9lSA1
         f6j00McSNfhVq7zpqOeLkRFb18pS3OZSq4hJFk5EbzsEIUvMEhsRtKa1auI6AzWOK4Bh
         RojkOCFpHM1mIWtYCqu9rkeci1AfF0gpF1EvNDmey+L82/UaEVQpUI1J5TGrweEl35uT
         2AZcgZE261I4yj4w/vEAk6488zf/BIVBOUaOL2o1HL1+BMeMAs9410Bu1kwoKMPFkTdZ
         57gGwE2gNjK7CT8ZOIk2cmHhRqwZn2on40Jnw6CWq48xYAQ11IJFZqpWKiEZqJ4ZqPn9
         pLtQ==
X-Gm-Message-State: AOJu0YzOjw/etkj0ekgsGVukOpHHh9yaLdn1WWd1GsDSGR6zPHlRESBg
	ZcnuVcchRE94qTIcFE5XbmX/s9y3Md4stU21aO2WbjaOnGTOd8mH1SW4I+2IJEJvAdojRgvORcI
	fYos2+4I=
X-Gm-Gg: AeBDiesy1+OXM3yrZjCuWa50NTZd9wed85FSGgiO1NF1XYqBUInl/q79SzpLVyH4hRO
	GGBShw6WsFTqaLSQG67fia3Gem28oZaJkjQ6m40+N2dk81gsTMWshyaSoIjU9p2iA+5mwJz5sdo
	DrzM1i9PQH0suJXbgUBd7OyidHcQvhSd8PoyLMytBe+nosoqqSbdoCC8Od4R7Mo57MZXylbOAgd
	uce3s68BIiNy2cXWrcyMtXjQkArPTDlbwgmb82p1CZeCom6UuKNyRFT8b3w2DYn6pgHqCHkUNZo
	/zsX1i/mm3ctNoDGSUArGxFlbSeNEFEDjeJJ98aXG01ROdmq4OTnokoLm9ar4QaalbCCEghWm+u
	mBQIag78/4dlzLrff2pph0i97XZpE5DqyO3c9QqMukMfdBNWy55cThAlWEuOOerFQkC9Bj3l+aD
	lSKg==
X-Received: by 2002:a05:6a00:114e:b0:82c:e1aa:21e3 with SMTP id d2e1a72fcca58-82f0c24e91bmr11380702b3a.10.1776015953640;
        Sun, 12 Apr 2026 10:45:53 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
Date: Sun, 12 Apr 2026 13:45:40 -0400
Message-ID: <20260412174546.18684-4-emil@etsalapatis.com>
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

The bpf_arena_spin_lock.h header is useful for all programs and not
just the selftests. Move it to the top level of the BPF selftests
to make it more readily accessible.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/{progs => }/bpf_arena_spin_lock.h        | 4 ++--
 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c   | 7 -------
 tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)
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
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 693fd86fbde6..acb9d53b5973 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -5,13 +5,6 @@
 #include <sys/sysinfo.h>
 
 struct __qspinlock { int val; };
-typedef struct __qspinlock arena_spinlock_t;
-
-struct arena_qnode {
-	unsigned long next;
-	int count;
-	int locked;
-};
 
 #include "arena_spin_lock.skel.h"
 
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

