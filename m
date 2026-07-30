Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2E2F39C7
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390554; cv=none; b=rERba+xBBASUf15S8o3ZpSnRCG6vSgWlbiydtaWawsrfni/BWzfqq/D1vOYUPWSlt0O92QadVKDVOKeHHAJyiS13Gan0LZGQi7MmP10ns91s5Iw+wNry/Ec+UVJdR/OMwU4B3TnvvRpf8iw3JmKuatQIG8N8YcgWVa+C5Pdwg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390554; c=relaxed/simple;
	bh=S8RdeLBZBSsOSzrH2uwszC1gOOSchHfzoq+EYGxqYRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPsZt1PvboL4bB7IKTrj93+xr2Xt8MzvLaL70gNAN+/rOawjuXprcEcZaX3TzW42zkio/sg4P++Lcf1GwVm4QGiOdKzhUeeEpcquC5FtfWHO/RHH2/vxiDo2JNbgSEX29nqKwvyTw7MTU1ZEtujeoSVa4DF1hoDEPhzapz7Nl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/Ca/JT6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/Ca/JT6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so1970202b3a.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785390553; x=1785995353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgTLvLq5r4peV5A59CWX+4UEP1YvBL+wMwrXXFEeKtc=;
        b=H/Ca/JT6VfV21bguc3d8HMywbkznL+eWd8TKI1iFU7gha/3ntj8OzW3YpA/XftnT6C
         hDIwULNOKeCjC+3CwpJcwszSo9vZyaoe1lWypxnnu8pD9vn2YAGLw/OfavAYvYHam0fv
         Y6BBtX8YWyBTgBGplby5oXpHFQTxNlBjgu3e2PSEawCkOoDkA2cQU1mgmyXr7ny+29tY
         eu+cQTIQN9RQv/6v6fVBcvzRaCsIJkPSFlqQ5Nd/OXI7Pmq4f99MPpRaoa45asu+80dh
         srzbcWblqEekcM4or7t9AK6qP+eS/Bg5cGaX/LplW/mtVB4FGjmBH+6oY4MlWjRI0Hh/
         8Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785390553; x=1785995353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgTLvLq5r4peV5A59CWX+4UEP1YvBL+wMwrXXFEeKtc=;
        b=ZIcsUTXY9yPLYjPxr1+ywXYAGHPGhn1CRTxkMySo4VWGQ1FBriNy5RMmRl2su/JdIQ
         GRCxc/MhbGaCkcjAN8R6+dYERWy+ALOvn8qna6NsuNbBtizrAwXvnRkpq90NRdsfG9sr
         EVzqnlrnPiAVZDC6rIhQGMk4dNNAfQzyy6NR2WGcQaYVrpdnKXb36Soljev5dd0QWLrl
         LpMC+c5ZrFHGNhBWYffLb1IDznZ2nyflq+hC+ayh7Ed18A1o7tcWAHGauPIvF25f/c56
         khkdUDgU3F0YrHcYO1rJ0xNMSe2YqT16MwrD1X8yQtlbs7xuV56h2jM0p6geaGmmv7bN
         irrg==
X-Forwarded-Encrypted: i=1; AHgh+Rrjnq3ghbbu6/QjPaHuhsaDwgW0XP91ipmlAU6OUjfykrgKhmRN4L7sUHtDWlLfhWUkW0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVeoLhKgwrXNdr49W+jkS+q+3/vKRuvNuXRKnaGxQA6Ult4nU
	XY3uB8v7QoIpbpIt6gadlqNlGjIeKVgalUa5ZQ2G/1I1LvufA6jgNKxP
X-Gm-Gg: AR+sD120IUTFMXkbJqEeJKRdsfgNAORzD7Lyqo8JXH3KgDTXqRJ/TwJZ9IRe47wrWKq
	tRdyP0GkwZz3HGRflg1BKzOTvUkRMIgecI9fCeOIgGCnVehkqSc3ehvkhtusBYPU+T0jHZVRuVx
	zTj3iE6pXyGMtIyCZtE/A2bfZD7uDFpXjezaGaeDMR5KAphWFxQS630MfAjcFIMwMGFG2DGvpt1
	6g9vI/fxn75XsDpdj6ViAZ9i+AdBH/bGKxoqBn6VKNFegASwXLw13Nx73eMGrP5ZC9nLSWaaVW1
	EYyELIGsUUobyT2VAAKTzmhbFpU6M4HqNS+V/XGy3pqRelSHIRTfVkv/lv0zCZoI0lCAH6jaxe/
	IMU632z1TxITFYiuMPz59/KZIuaVd4gNfdzXxSY+DbzgV+ka5bBOG6QEKt/wziG0Gs9wyfoodVi
	QMbvaSb3ytvKkSy9IJwt17raQHMonwycmtC4Mny/J8L7D8GcErJAzEikD+l5dX57beWG2kMHH7o
	dub8+ffQkHYB8LPN+dmsL4VURgsLhprijdFJZt0kR/nTAjm1b4n
X-Received: by 2002:a05:6a00:a205:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-84ebc1ee5c9mr1389275b3a.15.1785390552732;
        Wed, 29 Jul 2026 22:49:12 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00eb265sm2431615b3a.25.2026.07.29.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:49:12 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
Date: Thu, 30 Jul 2026 14:48:58 +0900
Message-ID: <20260730054858.209807-2-sanghyun.park.cnu@gmail.com>
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
Tested-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v2:
 - Drop irq_work_is_busy() and rely exclusively on active, as suggested by Ihor.

v1: https://lore.kernel.org/bpf/20260722023004.1497923-2-sanghyun.park.cnu@gmail.com/

 kernel/bpf/mmap_unlock_work.h | 37 +++++++++++++++++++++++++++++++----
 kernel/bpf/stackmap.c         |  3 +--
 kernel/bpf/task_iter.c        |  7 +++----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef9..d6e2b65f6d052 100644
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
@@ -29,9 +31,9 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&mmap_unlock_work);
-			if (irq_work_is_busy(&work->irq_work)) {
-				/* cannot queue more up_read, fallback */
+			if (atomic_cmpxchg_acquire(&work->active, 0, 1)) {
 				irq_work_busy = true;
+				work = NULL;
 			}
 		} else {
 			/*
@@ -46,6 +48,33 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	return irq_work_busy;
 }
 
+static inline void
+bpf_mmap_unlock_put_irq_work(struct mmap_unlock_irq_work *work)
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
