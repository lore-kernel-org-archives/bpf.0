Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62923E358
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687490; cv=none; b=XSPKrQar7p0G6749/+ckwjMglHLsYn2JpvV14BWzazqlsQiQaUDOP0BR+/YNtjawIIdYULrrXnVpuSdX0Fde6fDFucG9pTcsJrDgtgdCvsEN33+Jval7pz2I8LgU4ughfORcip8gxQJbyLCyzTQC0CTrEZAebcOglQOf8+pT364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687490; c=relaxed/simple;
	bh=1PCskL1UZ2A7ti82OI7P8a9Ptxkfv5kMbkZgIW2SCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxsM2/rSVO0Djs2nEHCPQkIVzMP+u0aOdCJIcNgcMGNi9eunz+O63nPcN2ggpJX/LLwjFndhIzt8PjhbZzxPXAalzvZvUdS6gfdSiA6N2v5G0TSXheaboo79Hw2AocGjcqZnwPOYna2Dl0GTJDKVbfeXWmt8LriDdud/+u0/5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Qsp4wk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Qsp4wk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so5332021b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784687488; x=1785292288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8D1Gp8pfnnkUQW4W1Yf773GP/LJEUPaf09dViFW6dk=;
        b=f/Qsp4wk7AFUn/ExCOfOt9tOwJsqpHu8FW7mXyONaWZdq8h4ADO0c6xrgj3OsOO3cJ
         HwwMW/i6ajZiAPB9DtZ4wnoDEfhGEr7M1LNG2HyUP5iIDWYoIPO2zEumZZ+5DVC7vcjG
         DpzWf1K5gWGrbP0SC/l2GQqvSgclcmIw3MArGw0nkhM0eoVc69nUoynviYjelD/SxQvY
         gKqI3AFTpLtaLpthws+4a+CWRt8Ij/5hXwlqKSafVcRdkFTuIOsDQ+OhzKMcndyWIYoE
         l/qeLfccsjHmW2JP1yyLudRQxbtetWRl8r4T1qd1yp8Bj7RaA960adZFNcS8A7w1S0PG
         kpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784687488; x=1785292288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8D1Gp8pfnnkUQW4W1Yf773GP/LJEUPaf09dViFW6dk=;
        b=pwff4wE+q/huTBBhFpjY19r2jxZF4/Delf6c3s0qTASuFefbhY0S5t+4q4fSny1950
         prXCdUuPJNP+jQey0ApH9ztod3SthHq+FydW9Oz+xFEbIa9ceIAzB9b12FukblhsGVD/
         4vD1IpXuA07+oyzhSKoouJcJqcl6S7nk3IT85lr4s1aYtvdM8zq0JpFuXBoZ7B4+JMdP
         VOVgWP2t+UwTJYzJOpA77OrshOMEPN8J5Mb8qBv8CqFxKWHPtnWPjax5uThs8GoKTfNj
         k6UAAObjOWZ1/j54iCfc0OqHFEvNXx3BRBR0TM/rw2FwhWwYJ+49D9ckLk7ujJKAdnz+
         KCiA==
X-Forwarded-Encrypted: i=1; AHgh+RqXvhvmYw5zVFy7u9sPP93os45rIVi9DiMrwd3+xS2tOjq8pBk+NLX+1DT+9YxXF+6heMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MTXO6w+bRjSTfCxIgOJS3J+9SqrD8CflKa37XMkoZyo539kK
	wVkfi8RNBol99l4x4xvidgS+ea2NlDdFc3mfC0Lb2xlJFCgxoDp/nPKt
X-Gm-Gg: AR+sD11jkpKKlOGv4QVfEOz0t4bexqdAuNnkWZLYcNvMF/yJ+JXss499cfo+1cmTh0n
	P2U6PugGcWfx3JvY8m4nJKjg+/7EgkCd2rbgMNHa+URjScse9HsLqwQrNAQHb+Pds5Rc5LU1M3s
	HVh1RtQptuC3R5ZKQ/jRIrx4lUXyHYonF0lCMSx8jA7xrrVxkNgyRf0qcsB2/uvhNCFchKoii6l
	Sd0kPgQi2diUaiqAgJDmYJhlnNcq6urFURlrXrz7MCDxjArtPnE7qLhFPUb8+szdkL2nR1V8jNZ
	81f8UB6bG133y74uozqnjPC7tTJoNaM50sgcgEWljIvesDY02x08Txg11gCHWAa8PNcniPNKqto
	heGw+nw8CPAVvWxbbaTFIMjCV7bHY9rSd+cdJk2jUbau/AR3Ka2Jg6iHTlf0/YPuu0bgtanX0ki
	bFqD7cYdbOFbeqD/IccKpI26amGpYDIfhpbJVGBjKaEP1NLkmio6W25AbBtwM20XSz1A==
X-Received: by 2002:a05:6a00:1a8b:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-84c29229f58mr20610651b3a.15.1784687487815;
        Tue, 21 Jul 2026 19:31:27 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm356253a12.12.2026.07.21.19.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 19:31:27 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next] bpf: Fix mmap_lock leak in irq_work path
Date: Wed, 22 Jul 2026 11:30:03 +0900
Message-ID: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stack_map_get_build_id_offset() introduced a per-CPU irq_work to defer
mmap_read_unlock() from NMI context, and bpf_find_vma() later reused the
same mmap_unlock_work. Both callers only check whether the work is busy
before taking mmap_lock, so a nested caller can reuse the slot before the
first caller queues it. Two read locks may then be acquired while only one
deferred unlock runs, leaking a read lock and blocking exit_mmap().

Reserve the per-CPU slot before mmap_read_trylock(). Use the same wrapper
in stackmap and bpf_find_vma() so both callers release the reservation on
trylock failure. Release it after the irq_work callback unlocks the mm.

Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cdd6c0925e12b0af60cc
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260630033745.B80201F000E9@smtp.kernel.org
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 kernel/bpf/mmap_unlock_work.h | 37 +++++++++++++++++++++++++++++++----
 kernel/bpf/stackmap.c         |  3 +--
 kernel/bpf/task_iter.c        |  7 +++----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef9..d416e4337635f 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -4,12 +4,14 @@
 
 #ifndef __MMAP_UNLOCK_WORK_H__
 #define __MMAP_UNLOCK_WORK_H__
+#include <linux/atomic.h>
 #include <linux/irq_work.h>
 
 /* irq_work to run mmap_read_unlock() in irq_work */
 struct mmap_unlock_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
+	atomic_t active;
 };
 
 DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
@@ -18,8 +20,8 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
  * We cannot do mmap_read_unlock() when the irq is disabled, because of
  * risk to deadlock with rq_lock. To look up vma when the irqs are
  * disabled, we need to run mmap_read_unlock() in irq_work. We use a
- * percpu variable to do the irq_work. If the irq_work is already used
- * by another lookup, we fall over.
+ * percpu variable to do the irq_work. The active flag reserves the slot
+ * before mmap_read_trylock() and until the irq_work callback consumes mm.
  */
 static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **work_ptr)
 {
@@ -29,9 +31,10 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&mmap_unlock_work);
-			if (irq_work_is_busy(&work->irq_work)) {
-				/* cannot queue more up_read, fallback */
+			if (irq_work_is_busy(&work->irq_work) ||
+			    atomic_cmpxchg_acquire(&work->active, 0, 1)) {
 				irq_work_busy = true;
+				work = NULL;
 			}
 		} else {
 			/*
@@ -46,6 +49,32 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	return irq_work_busy;
 }
 
+static inline void bpf_mmap_unlock_put_irq_work(struct mmap_unlock_irq_work *work)
+{
+	if (work)
+		atomic_set_release(&work->active, 0);
+}
+
+/*
+ * Try to take mm->mmap_lock for reading on behalf of a BPF helper that may
+ * run with IRQs disabled. On success, *work is the slot to hand to
+ * bpf_mmap_unlock_mm() (NULL when the unlock can be done inline); on failure
+ * no slot stays reserved and the caller must fall back.
+ */
+static inline bool bpf_mmap_read_trylock(struct mm_struct *mm,
+					 struct mmap_unlock_irq_work **work)
+{
+	if (bpf_mmap_unlock_get_irq_work(work))
+		return false;
+
+	if (!mmap_read_trylock(mm)) {
+		bpf_mmap_unlock_put_irq_work(*work);
+		return false;
+	}
+
+	return true;
+}
+
 static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
 {
 	if (!work) {
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 41fe87d7302f2..166fc8efab8b2 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -415,7 +415,6 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
 	struct mmap_unlock_irq_work *work = NULL;
-	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
 	bool has_user_ctx = user && current && current->mm;
 	struct stack_map_build_id_cache cache = {};
 	struct vm_area_struct *vma;
@@ -430,7 +429,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	 * fallback is used for kernel stack (!user) on a stackmap with
 	 * build_id.
 	 */
-	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
+	if (!has_user_ctx || !bpf_mmap_read_trylock(current->mm, &work)) {
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++)
 			stack_map_build_id_set_ip(&id_offs[i]);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b256fb9c1214e..e66e3484f923d 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -755,7 +755,6 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 {
 	struct mmap_unlock_irq_work *work = NULL;
 	struct vm_area_struct *vma;
-	bool irq_work_busy = false;
 	bool __maybe_unused mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
@@ -792,9 +791,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	if (!mm)
 		return -ENOENT;
 
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
-
-	if (irq_work_busy || !mmap_read_trylock(mm)) {
+	if (!bpf_mmap_read_trylock(mm, &work)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1191,6 +1188,8 @@ static void do_mmap_read_unlock(struct irq_work *entry)
 
 	work = container_of(entry, struct mmap_unlock_irq_work, irq_work);
 	mmap_read_unlock_non_owner(work->mm);
+	work->mm = NULL;
+	bpf_mmap_unlock_put_irq_work(work);
 }
 
 static int __init task_iter_init(void)
-- 
2.48.1
