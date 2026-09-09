Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363938F25F
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976307; cv=none; b=RE9oR8Ip5FarVboTA5BI/d9h92qKD/+jkpmf3xTTHxrO8UxpCUlbjdxHalMJydoHmwTbGbmplAIT7fBVsjsInGltfLWg+ORsWeZ9fwL2J+OVpD+2/EJrmP/cQpTed89B6QSALAsYRymvkv6xIUy5ib/25uqpDt20zRqfIlcMcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976307; c=relaxed/simple;
	bh=aq/PKVfZKJmCIP0vQntEh7xY4iPp0Mcck74grYuN11k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=amc8isfHnKMZX1VgKhJnrL9x7ikBuk8CBBbtVb0GWHtP0DU++B+k9d/+nZrdsVxWoDUciYZlVXmh2zrPJdqAXaSamH8EWMGQpDZfxO6NbVNwhSJen7ifQQLiIoU0bW4mgH2Zd3Km6a2oaUkqYbF6gkSx2ToDuEZbSRO+q9Et4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=p20lUFMd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="p20lUFMd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9399d52b1efso206140685a.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1788976304; x=1789581104; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gZN/fqOjYn2gzdjtAN4lO1LY9ZsRrEO//8nK1ex68AY=;
        b=p20lUFMdZnlS+Wz3oCdIcbYz7OeNkWIcxq5I76VGDbEl6mBrZsj/P0jCHJm98p09di
         Y9b5G+FlpxMN1HS3MH7yINWcN7cO/sOg0AKVSZuyr80I2RzqYeXdeiTvZ1xTprUTeV3H
         wRwknRKgrxuJyh4LUMFz8FoFgdyKOw9CAhwyRgCLLLlj04VsuEdk+RkxSKi0ED91TSlC
         lh3nTaZPeZkEOiUWaL+vOhOCffRKlk8SaQ+HBJchioe6kxM9g+HHkXHmnQhlMh9uhV4u
         dCLY+MobLDLN8IB/6M9lA1L5Wkez3KjszATPVUgaC7t4ylQUL81netNkNxrmQVcHYirY
         aENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976304; x=1789581104;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gZN/fqOjYn2gzdjtAN4lO1LY9ZsRrEO//8nK1ex68AY=;
        b=l1jGMnnXPvqySIYR5fJj1TEw9vZjwepGne3h1T1a+sKSw7O81ZkuFEtVGSbHfHs3yp
         LvIdkOZkCuTboAk75sw0a8zGYxlfagt/nLJ2D7zU01Ey518J73U4fc0oy4OPgdVmeI2A
         nG29s6G6Lk6aWuZyj7UdOojuigAHSbTTvQy1gb1U05P31B1rG4A5+5AV5Yk4s4hMo4Sp
         nOxZyeHJUOS762Yy+3d43zzfMbaDzaCF1dSU27cBEat3+q9Do8Kzb2DbSgUvhU+M/xjh
         hwIXmqGmVUp/yD13DyDMe5AdrjSrHQjzWDctol2oqSGSE+xkbYgUvKxpFYqv3kpV3zzA
         6Kqw==
X-Gm-Message-State: AFuF++nhYAoCg2isziIcB/LMzD1OnInyODeXmHXZZba69AGFLp1BbVy2
	widKw3atEubnlmYX6goAkjjvkB2yLdmfW5TmgvYCE6zyDki5WuoGw9I6u9FVz4BUV0U=
X-Gm-Gg: AYBFou0jSIXf/FMsVirGz1EQ8D7q/MArBVOwCNarKmNbDzaaZ8nq9YbSOM4UrX3kq7K
	yQS3q7MkB0shrVA/izfLsiMx9we8s9IuMw85yP22+ywGOPmrvQVOTB+acvDLbvbe1LOOY1EP7mJ
	4UKT4LWlixMrFA+Z7fj6WRFKTA49RXlCWNnQjLSixU1iw0q6oh5TEP/PLcWE5vSP9UzMZpHDqg4
	9aYvmOC/SB3UGDBJ62sG/+El7qRadYVzO/8etLPxFbfRjkb5REQx1V6Y97stJGq28c2nwdXHbyI
	Lp3Yaq9iPtYM93lwJ+unOEb3k8PrTFkFz8g81twZrWVwxZiJFyAE2wUjcgB7RffbHqqsZ5Y0txs
	23fBFaVgPsbVAE+l8OW8MxC9kKXCnA+S47BI+ymt1MGyYPDCESBeGdL9kNuf3mwuXL+lazCH5uU
	6PjM033HRfEglT3ZTj0uBDMAUrTj8L1r+IeEpwlEeodD7Qw1q5F+EOpsPygFQjF8l8fZtYdH4q0
	f3vfAJ2c5PuKR8O8YtZ5pFQi0gSGFwy8nHvNIdiJiAMUMJ55zgg3VKFljOJUjZw7D0=
X-Received: by 2002:a05:620a:7290:b0:939:6cd9:1fa3 with SMTP id af79cd13be357-939803b0a9cmr3153866985a.4.1788976303254;
        Wed, 09 Sep 2026 10:51:43 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93985cffb3dsm1379663685a.18.2026.09.09.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:51:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 09 Sep 2026 17:51:04 +0000
Subject: [PATCH bpf-next v2] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAIecoWoC/6WPwW7CMAyGXwX5jFHTlhY47T0mDnbiLplGipxQF
 aG+O22nSVw47fjL9vf5f0ASDZLgtHmAyhBS6OMcyu0GrKf4JRjcnKEsyqZoiwNyjT4TI1O2HlW
 S9eLQsJVDVdRt0ziYb68qXRhX7ifwtcMoY4bz7yTd+FtsXrDLbqf9BbNXoVfT8Y1pMGiQXEsNV
 1zvTfXxE+Jt3DkZFpgPKfd6X/sMZtX/A3ieZiRTEmSlaP3y318bvFDKojBNT6o7PN1FAQAA
X-Change-ID: 20260708-b4-htab-batch-resched-1bce8304766d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Brian Vazquez <brianvv@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>

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
empty buckets, call cond_resched_tasks_rcu_qs(), and resume at the saved
bucket cursor. No locks are held at that point, and resuming from the
cursor is already the function's behavior for non-empty buckets. Add the
same call to the per-bucket loop after copy_to_user(), where every lock
has been dropped. cond_resched_rcu() is not enough here: sleeping with
bpf_prog_active elevated makes tracing programs on that CPU silently
skip their invocations.

Plain cond_resched() is not enough either. It is a no-op under PREEMPT
and PREEMPT_LAZY, the only models arm64 and x86 have offered since
commit 7dadeaa6e851 ("sched: Further restrict the preemption modes").
It is also never a Tasks RCU quiescent state, in any model: the
reschedule counts as a preemption. The walking task stays a holdout and
stalls every synchronize_rcu_tasks() caller, ftrace and BPF trampoline
teardown included, until the syscall returns [1].
cond_resched_tasks_rcu_qs() is the usual tool for that [2]. It reports
the quiescent state at each yield and still reschedules as
cond_resched() does on PREEMPT_NONE and PREEMPT_VOLUNTARY kernels.

Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/bpf/20260715215314.44423f47@fangorn/ [1]
Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/ [2]
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Changes in v2:
- Use cond_resched_tasks_rcu_qs() at both yield points so the walk
  also reports a Tasks RCU quiescent state, and explain why in the
  commit message
- Put the opening /* of both comments on its own line (sashiko review
  on v1)
- Cc Paul E. McKenney and Rik van Riel, whose thread the message cites
- Rebase onto bpf-next
- Link to v1: https://lore.kernel.org/bpf/20260709-b4-htab-batch-resched-v1-1-ad7a6b3b4513@linux.dev
---
 kernel/bpf/hashtab.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f331c80130d..a72dc5b9f184 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1772,6 +1772,12 @@ static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
 						 flags);
 }
 
+/*
+ * Max consecutive empty buckets to walk in one RCU +
+ * instrumentation-disabled section before rescheduling.
+ */
+#define HTAB_BATCH_EMPTY_RESCHED 64
+
 static int
 __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				   const union bpf_attr *attr,
@@ -1793,6 +1799,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	unsigned long flags = 0;
 	bool locked = false;
 	struct htab_elem *l;
+	u32 empty_cnt = 0;
 	struct bucket *b;
 	int ret = 0;
 
@@ -1971,12 +1978,21 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 next_batch:
-	/* If we are not copying data, we can go to next bucket and avoid
-	 * unlocking the rcu.
+	/*
+	 * If we are not copying data, we can go to next bucket and avoid
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
+		cond_resched_tasks_rcu_qs();
+		goto again;
 	}
 
 	rcu_read_unlock();
@@ -1990,11 +2006,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	total += bucket_cnt;
+	empty_cnt = 0;
 	batch++;
 	if (batch >= htab->n_buckets) {
 		ret = -ENOENT;
 		goto after_loop;
 	}
+	cond_resched_tasks_rcu_qs();
 	goto again;
 
 after_loop:

---
base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
change-id: 20260708-b4-htab-batch-resched-1bce8304766d

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

