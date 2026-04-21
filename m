Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28016377016
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790249; cv=none; b=pWzsjZVlRDA2AbQmVQFdapkRuC5Hpp0k+TwBPZkIP/lcgen7ODejfgK1nSJVVQIhcC8A+0IIhsA+dPLh6TS7O4+BPwmdK1w1ajF8NE8BgYjnMIHX+4J+FPURkdkndd1iUrFuODYpw1dq9oJyQ0bbcyfOnYHC1+oy23dspWCWbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790249; c=relaxed/simple;
	bh=Fktcvkv8KQKx398ThTZqhozUH5eNBpJFJ5fS2um+6NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1DIqbUDyAmXV5Kax9irBqlj4V6JwB/xCf0BAWsQfX/wz1LwpGPFUCVWjU9QqHH6EtBFzOWm4px7+eV0sfssYsesuovKFxkzBlQFnOOcfFo+ANjZ4RoGaHtQ6uV/YxBuYnkY+AAF9+inv1wSFPlRC5LfjTkjMKMubaCEt/8iLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CvaUsA7L; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CvaUsA7L"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2dec803f9f0so2607254eec.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790246; x=1777395046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lady2FfeDBHdGNgFlANayqvr3EaxlPEZ7YkKzBxJAj4=;
        b=CvaUsA7L+n67ijRDadJ4C+42NOosQp9RO4anPwOGEqsU0MGAcaB7qGK9Sk5omkaHk2
         wzle2ipbRWfzyOH97HeZicsdPFxCFPsd4SFlq9+YvY0BPiCsju3yDpbeyOF8ygwIpsZ7
         q+L/x93Sj+jqSjgyoQxankF+Sjz80t6x4f3dmcACzS6E/m/AXTakBRkP+b+0IYqDXvN4
         nZsc9x4W4pDj6G14f01/UYT8ADARwmGoEw7OJSL9yEbOJlk+fq5qsSKwEhmBT4bZxEFs
         bhAlaDkj60cplCRG86uYwwyhyCtYVt8hMdp/HxTGbIKjYlMofOVt3AaXrq/VqjiT9x/y
         HHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790246; x=1777395046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lady2FfeDBHdGNgFlANayqvr3EaxlPEZ7YkKzBxJAj4=;
        b=Ztp0Qm7773cfiCwjGsuiRlZ0hB/8LHBlxjTOGOuzpzw2l71CGO7LLwMQV0A5AcMi43
         Uaq8OYONAh0fA63QmKyVAYbSKBfdww6VJDLT5mHpp3baXDEH6C8N10r6yZle+Zgypi5D
         g5zdasMD/9erL85fxTxdGj1vmI5BuwVSTl7j2Jm+Gij7W5TgDGcWPYt3rM422OVLkGH4
         FQePge4E4zgQGmukd+G5fkEAo61fQBmCCt+Yd3cKb4vErfP7sOyaCCR6zpkw8tta5sBo
         A457DHFcqslB7lynCNzqdb6D/Z7XIZNrpao8zwunEPF7Aq86Zj2oAesdMNouvh1yDTws
         YjOw==
X-Gm-Message-State: AOJu0YwdmNRJ/P/jxkc/7gXffYCXekcvW6cwlsMwg0tFA2q/IwjxghH6
	jeiy0KgroA3gpkk40pRgO1+41zC5ycQXUbygEmvmnQmBqiySBQdPjGGB4Wp7YDZ9NQc3I45B/ta
	XSo+/HrZhsK5p
X-Gm-Gg: AeBDieuCWBDqWzkPjDUBMAh2NOZsO764AXhIe/15Nz02++vwOdX1cSAsFZuiiXk2qRd
	ZjC5hNGot+1uZhUxS6TtYsdxkwRi5pt+iuFa0rkRJlAe/1HNDkFJyzlZbAb4WgJ8+FYWc+86CW8
	5AsBSuQ98RCD4J/efbNSqwtBltpYoyhRkxJTyuXmSoLRizNEr7ZNmQnuWOJrOFmTCWmK0D2h49d
	ymc81zGEawYgMAhBrvlyf6WITwHE1AVRYEati4Jz+MDmCFsMySSZJOWHNL531kAx4ZmM3/xAdPj
	7iJySKPUhpsH+DtqozA7jFxWSZq4WfaJszpNkP/E5LWpureSwlyhdvr4bzj2PwJw5jLYLzWgtQ4
	wkeUZnZpy7OSmbCheQemrSGKxtySvtO7y+gxzDIwLnxzgwhsf8HL44ndcQF+TO02hvV51CSASqE
	f2G5afeiwKMWcqiyjSeCm38769ll50f2wTgWvSm+KK
X-Received: by 2002:a05:7300:e12a:b0:2d3:9c91:6c45 with SMTP id 5a478bee46e88-2e42c84c585mr8240415eec.6.1776790245957;
        Tue, 21 Apr 2026 09:50:45 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 3/8] selftests/bpf: Move arena-related headers into libarena
Date: Tue, 21 Apr 2026 12:50:32 -0400
Message-ID: <20260421165037.4736-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF selftest headers include functionality that is
specific to arenas and is required by libarena. Keep libarena
self-contained by moving all functionality into its include/
directory. Also add libarena/include to the standard include
paths for the selftests to make the moved headers easy to
access by existing selftests.

Some functionality is required by libarena but not strictly
arena-related. We still move it to the libarena/include path,
which is an upgrade from directly accessing them from the
selftests/bpf directory using relative paths.

A new bpf_may_goto.h file is split off of bpf_experimental.h.
bpf_arena_spin_lock.h and bpf_arena_common.h are moved to
libarena/include. bpf_atomic.h is also moved to libarena
because it is necessary for arena spinlocks.

For bpf_arena_spin_lock.h, mark the spinlock state array as __weak
to define the spinlock state array in the header while also
being compatible with multi-compilation unit programs. While
we're at it, we remove unnecessary definitions from existing
test programs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/bpf_arena_alloc.h |  2 +-
 tools/testing/selftests/bpf/bpf_arena_list.h  |  2 +-
 .../selftests/bpf/bpf_arena_strsearch.h       |  2 +-
 .../testing/selftests/bpf/bpf_experimental.h  | 84 +------------------
 .../{ => libarena/include}/bpf_arena_common.h |  0
 .../include}/bpf_arena_spin_lock.h            | 11 ++-
 .../bpf/{ => libarena/include}/bpf_atomic.h   |  2 +-
 .../bpf/libarena/include/bpf_may_goto.h       | 84 +++++++++++++++++++
 .../selftests/bpf/libarena/include/common.h   |  4 +-
 .../bpf/libarena/selftests/selftest.c         |  6 --
 .../bpf/prog_tests/arena_spin_lock.c          |  7 --
 .../selftests/bpf/progs/arena_atomics.c       |  2 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |  2 +-
 .../bpf/progs/compute_live_registers.c        |  2 +-
 .../selftests/bpf/progs/lpm_trie_bench.c      |  2 +-
 tools/testing/selftests/bpf/progs/stream.c    |  2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  2 +-
 .../bpf/progs/verifier_arena_globals1.c       |  2 +-
 .../bpf/progs/verifier_arena_globals2.c       |  2 +-
 .../bpf/progs/verifier_arena_large.c          |  2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |  2 +-
 22 files changed, 112 insertions(+), 116 deletions(-)
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_arena_common.h (100%)
 rename tools/testing/selftests/bpf/{progs => libarena/include}/bpf_arena_spin_lock.h (98%)
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_atomic.h (99%)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a8d94f23a9c6..9cf197c077f6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -56,7 +56,8 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
 	  -Wno-unused-but-set-variable					\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
+	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
+	  -I$(CURDIR)/libarena/include
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
@@ -446,6 +447,7 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
+	     -I$(CURDIR)/libarena/include				\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -std=gnu11		 					\
 	     -fno-strict-aliasing 					\
diff --git a/tools/testing/selftests/bpf/bpf_arena_alloc.h b/tools/testing/selftests/bpf/bpf_arena_alloc.h
index c27678299e0c..cda147fd9d25 100644
--- a/tools/testing/selftests/bpf/bpf_arena_alloc.h
+++ b/tools/testing/selftests/bpf/bpf_arena_alloc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #pragma once
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 #ifndef __round_mask
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
index e16fa7d95fcf..1af2ffc27d9c 100644
--- a/tools/testing/selftests/bpf/bpf_arena_list.h
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #pragma once
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 struct arena_list_node;
 
diff --git a/tools/testing/selftests/bpf/bpf_arena_strsearch.h b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
index c1b6eaa905bb..f0d575daef5a 100644
--- a/tools/testing/selftests/bpf/bpf_arena_strsearch.h
+++ b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 #pragma once
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 __noinline int bpf_arena_strlen(const char __arena *s __arg_arena)
 {
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..d1db355e872b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
+#include <bpf_may_goto.h>
 
 #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
 
@@ -204,89 +205,6 @@ l_true:												\
        })
 #endif
 
-/*
- * Note that cond_break can only be portably used in the body of a breakable
- * construct, whereas can_loop can be used anywhere.
- */
-#ifdef __BPF_FEATURE_MAY_GOTO
-#define can_loop					\
-	({ __label__ l_break, l_continue;		\
-	bool ret = true;				\
-	asm volatile goto("may_goto %l[l_break]"	\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: ret = false;				\
-	l_continue:;					\
-	ret;						\
-	})
-
-#define __cond_break(expr)				\
-	({ __label__ l_break, l_continue;		\
-	asm volatile goto("may_goto %l[l_break]"	\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: expr;					\
-	l_continue:;					\
-	})
-#else
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-#define can_loop					\
-	({ __label__ l_break, l_continue;		\
-	bool ret = true;				\
-	asm volatile goto("1:.byte 0xe5;		\
-		      .byte 0;				\
-		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
-		      .short 0"				\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: ret = false;				\
-	l_continue:;					\
-	ret;						\
-	})
-
-#define __cond_break(expr)				\
-	({ __label__ l_break, l_continue;		\
-	asm volatile goto("1:.byte 0xe5;		\
-		      .byte 0;				\
-		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
-		      .short 0"				\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: expr;					\
-	l_continue:;					\
-	})
-#else
-#define can_loop					\
-	({ __label__ l_break, l_continue;		\
-	bool ret = true;				\
-	asm volatile goto("1:.byte 0xe5;		\
-		      .byte 0;				\
-		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
-		      .short 0"				\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: ret = false;				\
-	l_continue:;					\
-	ret;						\
-	})
-
-#define __cond_break(expr)				\
-	({ __label__ l_break, l_continue;		\
-	asm volatile goto("1:.byte 0xe5;		\
-		      .byte 0;				\
-		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
-		      .short 0"				\
-		      :::: l_break);			\
-	goto l_continue;				\
-	l_break: expr;					\
-	l_continue:;					\
-	})
-#endif
-#endif
-
-#define cond_break __cond_break(break)
-#define cond_break_label(label) __cond_break(goto label)
-
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_arena_common.h
rename to tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
similarity index 98%
rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
rename to tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index f90531cf3ee5..164638690a4d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -5,7 +5,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_atomic.h"
+#include <bpf_atomic.h>
 
 #define arch_mcs_spin_lock_contended_label(l, label) smp_cond_load_acquire_label(l, VAL, label)
 #define arch_mcs_spin_unlock_contended(l) smp_store_release((l), 1)
@@ -107,7 +107,12 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+/*
+ * The qnodes are marked __weak so we can define them in the header
+ * while still ensuring all compilation units use the same struct
+ * instance.
+ */
+struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
 {
@@ -240,7 +245,7 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
 }
 
-__noinline
+__noinline __weak
 int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
 {
 	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
similarity index 99%
rename from tools/testing/selftests/bpf/bpf_atomic.h
rename to tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
index d89a22d63c1c..b7b230431929 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
@@ -5,7 +5,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_experimental.h"
+#include <bpf_may_goto.h>
 
 extern bool CONFIG_X86_64 __kconfig __weak;
 
diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
new file mode 100644
index 000000000000..9ba90689d6ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
@@ -0,0 +1,84 @@
+#pragma once
+
+/*
+ * Note that cond_break can only be portably used in the body of a breakable
+ * construct, whereas can_loop can be used anywhere.
+ */
+#ifdef __BPF_FEATURE_MAY_GOTO
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#else
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#else
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define __cond_break(expr)				\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: expr;					\
+	l_continue:;					\
+	})
+#endif
+#endif
+
+#define cond_break __cond_break(break)
+#define cond_break_label(label) __cond_break(goto label)
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
index 338a5b4b19e4..0146a0858111 100644
--- a/tools/testing/selftests/bpf/libarena/include/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -6,8 +6,8 @@
 
 #include <vmlinux.h>
 
-#include "../../bpf_arena_common.h"
-#include "../../progs/bpf_arena_spin_lock.h"
+#include <bpf_arena_common.h>
+#include <bpf_arena_spin_lock.h>
 
 #include <asm-generic/errno.h>
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index bd4794be18fc..bd6527c9ca72 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -18,12 +18,6 @@
 #include <common.h>
 #include <selftest_helpers.h>
 
-struct arena_qnode {
-	unsigned long next;
-	int count;
-	int locked;
-};
-
 #include "../libarena.skel.h"
 typedef struct libarena selftest;
 #define selftest__open libarena__open
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
 
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index d1841aac94a2..2e7751a85399 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
 #include <stdatomic.h>
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index 086b57a426cf..7236d92d382f 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "bpf_arena_spin_lock.h"
+#include <bpf_arena_spin_lock.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index f05e120f3450..d055fc7b3b95 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -3,7 +3,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "../../../include/linux/filter.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 #include "bpf_misc.h"
 
 struct {
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
index a0e6ebd5507a..2831cf4445e8 100644
--- a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
+++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
@@ -7,7 +7,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
-#include "bpf_atomic.h"
+#include <bpf_atomic.h>
 #include "progs/lpm_trie.h"
 
 #define BPF_OBJ_NAME_LEN 16U
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 6f999ba951a3..92ba1d72e0ec 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 62e282f4448a..89d72c8d756a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -8,7 +8,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
index 83182ddbfb95..45d364b0bc85 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -6,7 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_experimental.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 #include "bpf_misc.h"
 
 #define ARENA_PAGES (1UL<< (32 - __builtin_ffs(__PAGE_SIZE) + 1))
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
index e6bd7b61f9f1..b51594dbc005 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
@@ -7,7 +7,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 #define ARENA_PAGES (32)
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 5f7e7afee169..6ab8730d4878 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -7,7 +7,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 #define ARENA_SIZE (1ull << 32)
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index c8494b682c31..1026524a1983 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -3,7 +3,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "bpf_arena_common.h"
+#include <bpf_arena_common.h>
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-- 
2.53.0

