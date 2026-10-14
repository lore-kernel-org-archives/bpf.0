Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAA4E432E
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982299; cv=none; b=PuYkEoyYi+JGrTly0cAXQ7l6rcbr94/3GJKEUcOUldfby0J1BWcGAf4O1tX18g2q2OqqXZFnUDyVFNoVY1zd5PgFfYGo8YmXwegmDbTN0W6xbdsytMg2qJT8ce4QPenzUyu/kJ+mcqMx+XgXhnQZdei0d1d98pxwT445g5ivG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982299; c=relaxed/simple;
	bh=eP7FANi918AKeSfEQqnG91JvROMNyBvALx/WU0+lV8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuTHXTLTK2wfxIEyRI59eFfePgDHF68KS/wH9tU/a9DJXOPR9PAx5ahRRqejtW6TVTSu9UpGvvykw+/K2A180uBPKETwBEEZYc1HG0Dzjvwr288HfkOhmvx1cAre/DKTbFM992CnUvYTCoanv3XFdHt4AX4U0dGTyMAYR/Vmslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRsQSpp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRsQSpp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB21F0089B;
	Wed, 14 Oct 2026 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982237;
	bh=ar+7zQ9sdKxV7dYXCGrPH9SgZXn8ywU76LAmKytClco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRsQSpp6vl/uyNN8As6jditN6paVxUz/BNKzEYpHidqpvxrIwGcoJDwMJBLxYC48P
	 F4JRncRCCxb83IAglQUzNCQY8H1v/rNQVYyGb4Aq50nvcCW44cznSJF9DwtGsk4iAE
	 6jZ3U6MoFG7XZKXVqZybXykjUplbmqUIouhoiykh1zJMey1P4gvd7FoUq9sD78aRyB
	 I49EHeFUfqgz4tSI7MpNm6LAU9peoP9fuXUiM2wIO1tChvWcCgcdJAdbyfApH+M228
	 HYvEzUZ0zEzeomquSmatEBYrcYyudLS01c06mtwgKbRwuIr1Bx6roRDz3fQn5PDQwP
	 sD7z42SlM2pNA==
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
	"Tejun Heo" <tj@kernel.org>,
	"David Vernet" <void@manifault.com>,
	"Andrea Righi" <arighi@nvidia.com>
Subject: [PATCH bpf-next v4 3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
Date: Wed, 14 Oct 2026 05:50:13 -0700
Message-ID: <20261014125017.1426212-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014125017.1426212-1-puranjay@kernel.org>
References: <20261014125017.1426212-1-puranjay@kernel.org>
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

