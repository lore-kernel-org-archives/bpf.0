Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62643DCD8C
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838663; cv=none; b=bOrm4aA63K2vJvGcIgxW4lzEJs3E+NoHH/YM8puK75UvNTcxLcmbhioCcBo47AeZDXTZZidcqZYsdFSH4qLeO3XEqEOrDZBJ7GFcxulIg4HXVW49hugtZAdao/r50mdU9EbrTSbweUkDdJUPNfWQiRN3yswDMEFBZW3MZHMpcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838663; c=relaxed/simple;
	bh=shZ0enJ59npB3KE71/s8XOrWBVkaVD9xxM1dGSHiKDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxQHA4cuhPsbR0YqD7jPuAxMahNQ11LYKJwHYt+yhZPjGt9EhWKEd9gcsJm+4im5nNMNjF4T0roVtm7X5MMbg/viW3MmRTOUp/+Lwa5pMWkkyX9Kz4M5SloT0uoHyc18IBIGzNGc8s3iMjrd3ccPHCwRnXlI1vwj66B73tkqKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NGYbH+hi; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NGYbH+hi"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ce22328930so3327107eec.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838661; x=1776443461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=NGYbH+hi5rQLO1T57q/Q2GgoiFYg4BVyx60YG7fiDx2X4nviaTldLXglE4JrjGnl+C
         rmhrYJq9T0AsdsUo4sZIFZsqpRnpgLJwe8mh6NcJnH5SMxSgS9ZA4JidYyiqNppqP5KC
         +d1GxzMv5wLVE1t8XdtH5OuG6H29dVm5vGGlGTq1gmEeHK5VrHSSO9MopK50Lyxn0i4Y
         GaKIV3y8HcsJqohlO3eC35Rx67nIZ8b5amSA69gv7F+lAky9Coiw48XS7sK3vuVLjq55
         sa3McVRwG6CjtuyCdruLtquN+JyypvCMBqXDIqNXK0fGAckplR7qksORJX4zrsdCdhZ+
         3Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838661; x=1776443461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=hx+Xm4ZYRnNYT7k5WKi4tyNKDcv9UKpenKlLHgwqgXH9pZPNcw/IVeNqBorj+afaZF
         j3Paf8L9uNkGc6a3F3ehd8XOSawMVLVmFdVthNV3LYvyHUIOv7zCugZQlHG43syi74cm
         ugtkCylr8/6EYTbthzLbUS2/f/O2JvLQXEpRdWm22PEGjalxHr9nIIzIz9sjIY1LRDFp
         pjJx4X+nhcUh+VAQcbpCEnQDOrdt5tBjoN6CSpm4JLrioBTVCitn1xhILzdJQUfFBj3b
         jJCWsDWEEMMuzWtXsvNGVn9/70BVX8zHInq+uxlU1PfWJnyrHPUZ5RtpddWs1B3u3QRc
         4mJg==
X-Gm-Message-State: AOJu0YxVXvgnk6hH6+yhVxDDn+AO18hrSIyk+xFRXAbv5ucHFnTbCc55
	fQRP3/TanvJeA7VMSa3mVPkQDOkLZGYMQPdXb+vDQa7xuXmpRHNFXwrUtlh5SkHVX+28oAuoHCf
	0+F+b1NU=
X-Gm-Gg: AeBDieu/hDBw/mEELcPscSftsqIeimwUwgB8oTF0RABgAwgxuJptHpgwqjjYxfclfnJ
	+ri2eGrWkD6Dk9+tBnR7eKNanhsevzWx5KGb+Bx1QIIM8+vI0KDgV/Hn1HKV+zAx4G/x+TndvjW
	qqr50CR8doNDfuNjW5HJX7nA8xt/ShR966wsyn87oOEGkMSgkP6eaXXqXera9RB7VJ09iXjIReA
	DeTJVmDEl0Hl8aFu/Yb+i9ubyH/n0nxN5CVB/9Ile/IAaTHJcfxMrAhOTKm0SlEts+gtwHWQEUj
	AuncYUemZcB57AP6ZDuIZkdDBp2vYY3QV2yfzl7ihauQoqbFy8pHtAeN1v8x+cuu6+qjxBlQy0e
	1LCxn/h0zocSSHGfShr4fi6gXnlxBcvMEqhP2bDyU4ZLfA9OSzFwWhI2oD7lwg/b6b6Z1I52N6u
	u0AgfJ+H/3PzWdiKB94Lo=
X-Received: by 2002:a05:7300:df05:b0:2cb:8d2f:e247 with SMTP id 5a478bee46e88-2d58839f34bmr2764936eec.13.1775838660692;
        Fri, 10 Apr 2026 09:31:00 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:31:00 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
Date: Fri, 10 Apr 2026 12:30:35 -0400
Message-ID: <20260410163041.8063-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
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

