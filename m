Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6C4A49A4;
	Fri, 25 Sep 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344128; cv=none; b=mIxK9NpDLe8mMlPGxKAn8AOOK9LVDOcU6mqAJzL0lq40H+ckkFDPLua1smw6Dpba9H/5K0fXCN88cAp2H0NrxUEU3eeQBUXBHpMuKelHLAzrQjPAKu+AbK2AycStuCnp3b5LznhCYSuTUiEP/uREYBg7MhRnIh3w56MQptZ+zTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344128; c=relaxed/simple;
	bh=UcrWuWhkRMDMY4gnPWAfQUybcFFH3uus77Mh1K3jYTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsWdIV9EE6zAKiivz7D4G6M7JJNwSjawop+5JZwJNnKaKTnEpu/nyfFT1i/JULFJsVcapFE36cVif0H6l6cK1WbHTVEqaUFvPXK4a405jLbIRdOM6zgPIZ9LRRZSzmpL5cCatUIgBwTGEWXaIPjWqpPyYzvejqzqr2wdU3AH7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVzIyaOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVzIyaOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A54B1F000FF;
	Fri, 25 Sep 2026 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344126;
	bh=fPNhIHFch0A4xLlqEVDNSvcYa4zuY/ufThLtXS9JaHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVzIyaOxtU6qTk1UJow5QnvefCqdk1CFRr/0HR2kaN4CKgHJuV+LbsgbewPBfC9IQ
	 xPzVF7oRAxcrn3eZ1t/jjjKU1UhtdXQtdm2GPmeSlcCuAGRzLFN95j2oN5nEKSSsnb
	 yxolG2p+D7bZywp21kld5Z5ZoX1m2bROivdnH9JehBgnSnot0LCUkV6nrgmNimLKFM
	 K2PWY7kcWUOyee9rglM0hSa/Ax4Xd68kiT9fPM8xXac7vy8L6eJ3hMDwPYPEl4Ohur
	 MB5o2tsH10Jlz7nszkk3lYU4BJGbSUrL6KaTyRqZ7atubW08d/i5HvWg22eOb5YGCS
	 uSljaMjJuJXbA==
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
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
Date: Fri, 25 Sep 2026 06:48:22 -0700
Message-ID: <20260925134828.2012199-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925134828.2012199-1-puranjay@kernel.org>
References: <20260925134828.2012199-1-puranjay@kernel.org>
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

It no longer does, and the loop was never the portability fallback its
comment claimed. A JIT that turns down a fetching OR or AND in an arena
turns down CMPXCHG there too: arm64 without LSE rejects every arena
read-modify-write, so the loop does not work there either. riscv without
Zacas is the other way round and rejects only CMPXCHG, which makes the
loop strictly worse than the fetching insn on that configuration.

Native fetching OR and AND are therefore accepted everywhere the loop
was, and in one place where it was not. Use them, and drop
CMASK_CAS_TRIES along with the error paths that could only be reached
from a loop that no longer exists.

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

