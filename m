Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74C29BDBD
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956745; cv=none; b=CSJtwBLQ9GAg5s6ftb6UKKnz2nPkvyV17GgDz8VIvRYFOEvKE/+i5KHxVAXRu9eoIi4DY8FJ8vJWc6HfJG7gvOg5JZUe6AzRtUo+QMuMKyE7mOmA5iDeISbA0dqVgJlDMFXalzyTyxYvzCx7ErzWdP4UyEuqkl6aF7vaRL0WKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956745; c=relaxed/simple;
	bh=shZ0enJ59npB3KE71/s8XOrWBVkaVD9xxM1dGSHiKDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCkKnBnJ9v+IuJnU2oBF8/JMzfoaw9jANvYNaI9cTa/SLz6walRFFYqYwZjgf1dx2TlB1cLXWFKoURqfQqiIP2s3Tdfz1YQBSdVl6uo7iBCbMWqC+kgetftjN9ars4TaOteGiH+inXO/jHZKKsb8c82W+0+9qSOKJ48/eJ4c74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=JJuvDIuz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="JJuvDIuz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35e5770d013so277035a91.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956744; x=1776561544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=JJuvDIuz4t/EH9WlQcdAZ018EyVz1Vg0aLLQ8LOs1BKH1svk5FfxKh05xclwyjigsP
         NQej5fW3pvIX+7EA3omRGATBzs0naJ0uJnSFhAEnJLltLzwyY64EIBz2+9CQtX9WgKwt
         QxaHRqdqhdJOohQzQ/I7SPTdxMmhTXP7u1nIEPUc36veKBd1nzUSHTBDQyopNKsT2lPI
         xx8UJs4XgIE3YBR5rkv1pp2pmuXM5oqqQ0l7XwdqyKIG26316XAmk1tBr1IFJw8HixVQ
         2uunGWn2mnMGrdhy5/htMy57L2S6mltNAoVdl10PJwfORrfJMjCl9hjfoXqE+uL8gRwe
         i8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956744; x=1776561544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UoNDkIE2hbD/9BzKWSon3v0+1U5i/S+jXfXIyK/Mx0=;
        b=G4uqM2wSG8uoWUdH9BgToLxjYIXdrD+f5WCRkcm/x+10B3+yFC7RI7OHhjiacXbt3L
         tKjIrlk1CNoWbeqAb+9jHqyBNiUGuhQMJA9Yd7Dq3TzXyXaUJyaxbNjkmWVVnZnilpZL
         XKIJJHRFIxffnMJJxnU0NcuVRpRY5aR5GdTJIl4IfOzhTSQpc4NDZtizTj08AwZCUFF8
         bCFu1EfSRzqcj5nIi7EbTB7rLuuzZ1I5HWZ1BdMF7w5kwq5Gt7/zNgCkdwJ7dtvn9fd7
         VPTGx8o9KjaFB3dHQIt3C6zRZ+W6H5nP9hEknJFaXEOnVsarKTUd3P6A2O+MvkSKAgHM
         xg3w==
X-Gm-Message-State: AOJu0Yx9ve4SS8ETEMNsml7pFy/3U+xm2Fv/0Ay6hvaaDSgegNz+JioT
	WOxOrkRvfKkkkweA//J/rv7rASkAy62IEhjrFb67ZDsQmrUjK9h7uzFDeO82d9qItwN4mXa61U8
	apZ9xNeY=
X-Gm-Gg: AeBDieta3xrqKW1f03/UATN8kjSRp3VV76xqduHAJtlNJhsL4N81r4Ry+T8zKlJN4jg
	rBffHcVODuj8gWntm3xTnyoFCqs7H1PkYYk2YOrV+DGcIsi2ixQdpfUgcLTfYM5Vrh9tEjc3vBD
	yLxFchRCnF+KGdpSi/hBLkSyNFfo5F4TZyJP0t9s01a+PrjMJRDuWOJ5CvqM9rmn+p6e30BhlgE
	9+rvcDu/LpZrsVDA+1XRMFSlKef0SrGIizD9ofTNmKegGtA/yexq1Ki0TNeA08s6kiFXUj04f9e
	IY75SDEwLQCt3tH+M6ZY8Rv/HpvrQR1z6cAelD6G9jrMK/DO0cRwqMffZnFHQg7RvGxfpnGcC3w
	Q95ZhpuQwkmTDa8P3hVzymX3VYMcaoYPnIdb0RrraooQqm3CpRM25YAtaTMAn8ximTIxNMOA6lr
	V1Ww==
X-Received: by 2002:a17:90a:c09:b0:35f:b116:ff29 with SMTP id 98e67ed59e1d1-35fb1170166mr233178a91.28.1775956743585;
        Sat, 11 Apr 2026 18:19:03 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:03 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
Date: Sat, 11 Apr 2026 21:18:51 -0400
Message-ID: <20260412011857.3387-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412011857.3387-1-emil@etsalapatis.com>
References: <20260412011857.3387-1-emil@etsalapatis.com>
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

