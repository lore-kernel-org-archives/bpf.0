Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233A3BF67E
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641510; cv=none; b=e0Nw9BfPR9NRLNH9pU2STQJL5eUKWE3PJz2Pnf7BEI/QgT61mfvUTHttpgfI20WG4Y/GZGEqnI/mnElYqLr32kkLmSNMbuRQ9sLIB1hr/10+SiB3W0C+JBplxNwI4cvdcLm3d4ELl2X374KVJ9qmzEo8totfiNw1bryjF0qQeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641510; c=relaxed/simple;
	bh=nEX8EiOiM5oDYBbHnBGFbUmYUDGuUomG1BPJr5P5+CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nc/ongk8t3KNbZblilRDOHT8TmGPnCu+TNyfVIdDX/o4Zz7PcI3gVLgar90a2Jzj5X5easQ0P2HYQuZtz1ldXHgTRVpEJ9Kn6a+dAmRnUZIUTI33ALqFK+9s3UJIdN/DjonB+QKtU8CHBN709hFgbk3Uh3rTqBDxpaF6nwg0BqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcvxZsYY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcvxZsYY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783641496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMg5+V70ET+LwmUtIv1O0gOzGmuC80IGO9iv3tkecmA=;
	b=gcvxZsYYPLF9IcBcdgM72yIrui/q9AfsRw9Evu8EFATvusjpgdSuPlZejR8IVIV2ExET9A
	WEVvNk3yMYkfxeyGIOlpNq4JinHnk2auBcYj0H/eUGSMkyS18eWNDRGVn+2w4gy2GPD51I
	a92k6/XbILgvZwXzkd9R+gatKdpDiFU=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Thu, 09 Jul 2026 23:57:50 +0000
Subject: [PATCH bpf] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-b4-htab-batch-resched-v1-1-ad7a6b3b4513@linux.dev>
X-B4-Tracking: v=1; b=H4sIAH01UGoC/yWMQQrCMBBFr1Jm7WBaS1q8irjITKYmgrFkogild
 zfR5Xu8/zdQyVEUzt0GWd5R4zNV6A8dcHDpJhh9ZRjMYM1kZqQRQ3GE5AoHzKIcxGNPLPPJjJO
 1Hup2zbLEz+/3ArQucP1LfdFduLTHlpFTQcoucWiqhseH0yIZ9v0LMwq3dpsAAAA=
X-Change-ID: 20260708-b4-htab-batch-resched-1bce8304766d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Brian Vazquez <brianvv@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT

__htab_map_lookup_and_delete_batch() has no rescheduling point. The
batch count bounds how many entries are copied out, not how many
buckets are visited, so one BPF_MAP_LOOKUP_BATCH call can walk the
map end to end. The empty-bucket fast path is worse: it stays inside
a single rcu_read_lock() / bpf_disable_instrumentation() section for
any run of consecutive empty buckets.

That holds up on small maps, but it falls apart at scale. On a
144-CPU arm64 host running a CONFIG_PREEMPT_NONE kernel, periodic
BPF_MAP_LOOKUP_BATCH calls against an LRU hash map with 16,777,216
buckets held a CPU inside the batch op for 77+ seconds and triggered
the soft lockup watchdog.

Commit 75134f16e7dd ("bpf: Add schedule points in batch ops") fixed this
same problem in the generic batch ops, but not in this htab-native path,
which every htab-based hash map variant uses for its lookup[_and_delete]
batch ops.

Complete that fix here. Leave the critical section after 64 consecutive
empty buckets, call cond_resched(), and resume at the saved bucket
cursor. No locks are held at that point, and resuming from the cursor is
already the function's behavior for non-empty buckets. Add a
cond_resched() to the per-bucket loop after copy_to_user(), where every
lock has been dropped. cond_resched_rcu() is not enough here: sleeping
with bpf_prog_active elevated makes tracing programs on that CPU
silently skip their invocations.

Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 kernel/bpf/hashtab.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..b208a567892a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1769,6 +1769,11 @@ static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
 						 flags);
 }
 
+/* Max consecutive empty buckets to walk in one RCU +
+ * instrumentation-disabled section before rescheduling.
+ */
+#define HTAB_BATCH_EMPTY_RESCHED 64
+
 static int
 __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				   const union bpf_attr *attr,
@@ -1790,6 +1795,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	unsigned long flags = 0;
 	bool locked = false;
 	struct htab_elem *l;
+	u32 empty_cnt = 0;
 	struct bucket *b;
 	int ret = 0;
 
@@ -1969,11 +1975,19 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 next_batch:
 	/* If we are not copying data, we can go to next bucket and avoid
-	 * unlocking the rcu.
+	 * unlocking the rcu. Bound the walk though: after
+	 * HTAB_BATCH_EMPTY_RESCHED consecutive empty buckets, fully exit
+	 * the critical section (no locks are held here) and reschedule.
 	 */
 	if (!bucket_cnt && (batch + 1 < htab->n_buckets)) {
 		batch++;
-		goto again_nocopy;
+		if (++empty_cnt < HTAB_BATCH_EMPTY_RESCHED)
+			goto again_nocopy;
+		empty_cnt = 0;
+		rcu_read_unlock();
+		bpf_enable_instrumentation();
+		cond_resched();
+		goto again;
 	}
 
 	rcu_read_unlock();
@@ -1987,11 +2001,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	total += bucket_cnt;
+	empty_cnt = 0;
 	batch++;
 	if (batch >= htab->n_buckets) {
 		ret = -ENOENT;
 		goto after_loop;
 	}
+	cond_resched();
 	goto again;
 
 after_loop:

---
base-commit: d2c9a99135da931377240942d44f3dea104cedb8
change-id: 20260708-b4-htab-batch-resched-1bce8304766d

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

