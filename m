Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6404DE72D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170829; cv=none; b=qHMUnT+gNFQ8ZUFI4g8j6/r0fDv47EmV1boI+KLqNJLTJSP6sU1WDr2OWlrHJK5I4uWaE09n/84PbyvJRXlAnSkJaXC5tt9h7iaMAzotjGkL/A9UBKL47n1kgp1QNwtv1tzTWgfLhv8FlClrZSXV6mh7styFM0tUc0vHh8vfEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170829; c=relaxed/simple;
	bh=eP7FANi918AKeSfEQqnG91JvROMNyBvALx/WU0+lV8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6BEimP0sOvzIsiWYoYxTe2ix7nDPl9ujgHcDA0c/Elo8s+RLqxIaMbzPTnHH/iO4nHeEOJLM14A+TaCYajprSESApBfB+XEZitT92hR9PE0/K2s3Hw/+ifx6d7aXVLDCq8Wq2PeB5cWSghv4tIOVaRgCm1rQ/4c6SwyHglJhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZTEOdDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZTEOdDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2CC1F000C5;
	Fri, 16 Oct 2026 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170826;
	bh=ar+7zQ9sdKxV7dYXCGrPH9SgZXn8ywU76LAmKytClco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZTEOdDkuMOpIBpnh+cnaJEd0/rnxnqjy3NBw3c9Xi1F08TVMiutbp3Df7aR4BfM7
	 sJrJnCxrWe54gH4KDCuTqTSwboge4g59W853Q6A9NTm9WGbtdDEVyf5svqjzzeDgrI
	 Lv5o2ISw/vV8mX4zPT5Ta+mQNVwRw7KIfhbPhQIGr6KjSAZo9U0di3NkO67Qq84hx0
	 f1Ikj2wx6TrEj6gSNo5y8rfMy4VBAnI1jMOAo0iSQK9anWxnwW61wZZLy4IHLaHjWg
	 KPsPlSLHIUL+NNKAcqhUsdW402yEBKNJBHFhl5li4MxGMqLVsHRamuunuqZ4EWNhuU
	 QQhwb7LH23gxQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Tejun Heo" <tj@kernel.org>
Subject: [PATCH bpf-next v5 3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
Date: Fri, 16 Oct 2026 10:13:14 -0700
Message-ID: <20261016171319.1623447-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016171319.1623447-1-puranjay@kernel.org>
References: <20261016171319.1623447-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cid.bpf.h implements cmask_set(), cmask_clear() and the test_and_
variants with a bounded cmpxchg loop, because the x86 BPF JIT used to
reject BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena pointers.

The x86 JIT accepts them now, and the loop was only ever an x86
workaround, not a fallback for the JITs that still reject these. arm64
without LSE rejects every arena read-modify-write, CMPXCHG included, and
riscv without Zacas rejects only CMPXCHG, where a fetching OR or AND is
accepted and the loop is not.

Use the fetching atomics directly, and drop CMASK_CAS_TRIES along with
the error paths that could only be reached from the loop.

Clang emits the fetching form even when the result is unused, so all four
helpers now need an x86-64 kernel whose JIT accepts fetching AND/OR/XOR in
an arena; schedulers built from this header no longer load on older
x86-64 kernels. When the bit is already as wanted, the helpers now also
do a locked write of the unchanged value where the loop returned after a
plain load.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h | 79 +++------------------------
 1 file changed, 8 insertions(+), 71 deletions(-)

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 69fb4e97bc771..d0d4cea19e29f 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -3,8 +3,8 @@
  * BPF-side helpers for cids and cmasks. See kernel/sched/ext/cid.h for the
  * authoritative layout and semantics. The BPF-side helpers use the cmask_*
  * naming (no scx_ prefix); cmask is the SCX bitmap type so the prefix is
- * redundant in BPF code. Atomics use __sync_val_compare_and_swap and every
- * helper is inline (no .c counterpart).
+ * redundant in BPF code. Atomics use the __sync_* builtins and every helper
+ * is inline (no .c counterpart).
  *
  * Included by scx/common.bpf.h; don't include directly.
  *
@@ -129,101 +129,38 @@ static __always_inline bool cmask_test(u32 cid, const struct scx_cmask __arena *
 	return *__cmask_word(cid, m) & BIT_U64(cid & 63);
 }
 
-/*
- * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
- * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
- * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
- * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
- *
- * CMASK_CAS_TRIES is sized so exhausting it means seconds of real spinning
- * on one word - past any plausible contention. Abort hard.
- */
-#define CMASK_CAS_TRIES		(1U << 23)
-
 static __always_inline void cmask_set(u32 cid, struct scx_cmask __arena *m)
 {
-	u64 __arena *w;
-	u64 bit, old, new;
-	u32 i;
-
 	if (!__cmask_contains(cid, m))
 		return;
-	w = __cmask_word(cid, m);
-	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
-		old = *w;
-		if (old & bit)
-			return;
-		new = old | bit;
-		if (__sync_val_compare_and_swap(w, old, new) == old)
-			return;
-	}
-	scx_bpf_error("cmask_set CAS exhausted at cid %u", cid);
+	__sync_fetch_and_or(__cmask_word(cid, m), BIT_U64(cid & 63));
 }
 
 static __always_inline void cmask_clear(u32 cid, struct scx_cmask __arena *m)
 {
-	u64 __arena *w;
-	u64 bit, old, new;
-	u32 i;
-
 	if (!__cmask_contains(cid, m))
 		return;
-	w = __cmask_word(cid, m);
-	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
-		old = *w;
-		if (!(old & bit))
-			return;
-		new = old & ~bit;
-		if (__sync_val_compare_and_swap(w, old, new) == old)
-			return;
-	}
-	scx_bpf_error("cmask_clear CAS exhausted at cid %u", cid);
+	__sync_fetch_and_and(__cmask_word(cid, m), ~BIT_U64(cid & 63));
 }
 
 static __always_inline bool cmask_test_and_set(u32 cid, struct scx_cmask __arena *m)
 {
-	u64 __arena *w;
-	u64 bit, old, new;
-	u32 i;
+	u64 bit;
 
 	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
-		old = *w;
-		if (old & bit)
-			return true;
-		new = old | bit;
-		if (__sync_val_compare_and_swap(w, old, new) == old)
-			return false;
-	}
-	scx_bpf_error("cmask_test_and_set CAS exhausted at cid %u", cid);
-	return false;
+	return __sync_fetch_and_or(__cmask_word(cid, m), bit) & bit;
 }
 
 static __always_inline bool cmask_test_and_clear(u32 cid, struct scx_cmask __arena *m)
 {
-	u64 __arena *w;
-	u64 bit, old, new;
-	u32 i;
+	u64 bit;
 
 	if (!__cmask_contains(cid, m))
 		return false;
-	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
-		old = *w;
-		if (!(old & bit))
-			return false;
-		new = old & ~bit;
-		if (__sync_val_compare_and_swap(w, old, new) == old)
-			return true;
-	}
-	scx_bpf_error("cmask_test_and_clear CAS exhausted at cid %u", cid);
-	return false;
+	return __sync_fetch_and_and(__cmask_word(cid, m), ~bit) & bit;
 }
 
 static __always_inline void __cmask_set(u32 cid, struct scx_cmask __arena *m)
-- 
2.53.0-Meta

