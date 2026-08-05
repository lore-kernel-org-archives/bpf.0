Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AE3C3F7B
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899759; cv=none; b=VCdd152bNQJEFEBiAnGVnxfaUJ1F8uJYXkydQWinsNpaG7m+9oLwcqXpEC2DtRUS7slU5t3EX9asgTYNVcesBTz00Fy6SJ07gfHBW9v5T0fxCTcJgHn8aHEdhT6tCUtBSYSEGJF/aHi9ujBuo0SOF5MSyGFdiEHyZpi5nrM0Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899759; c=relaxed/simple;
	bh=E9fmzVPEhc0FHQUnTqsdKOMryIMDqrwX5DamxWU2EYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUf1QEE8r5Y0IRLbD8To/3gaMWm1Ek5i/BRJ/TmtMwsMVn9QFdLrhO6W2/NsBiU8yXGXZI4gfYLxSHAASJvFSr6u2Nf/BJKgm1vTofKGlKbKaFIHc5QIkQrttQfZyDl/Wh6peX0VovEywHh0wGQPY8sFVVlRHbEtIOgSCodrPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1cOd41a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1cOd41a"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84867f07d63so559729b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899757; x=1786504557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JWpXQSVlmsFGWTkJETCzoI7IiXAWiXm3VeZqV6jTpY=;
        b=M1cOd41aLL0Kj62y+W14k2wBlFkulWDBEFevxX6VAxTtSTdbQYs0xSv6L6hWEf8JvB
         EkTxoeK2mJHeCa1OSRiIU+/hXEIdCXOydAcfHj6K7lmJtxbhFBqfUltyvj9fHJfdvK8U
         FlGveLKH8gAC32wFJP0SOwvh/1tWHXCKARtbf4wsLRxyb8aA6mDqSP4YtkQXQ2128J3w
         VMqdrMaiQQV4EJsSlwH9XhB59K+oOIWvKewyg3qucnxAkCd3LR2p1TfEqixot/yfywWz
         guPPMRZ9kYIpPYeCEIg5DzFwisnDbYYRFSYSn2hWYnj0XK+ncZmyF4Dj1uiwzzZwOrpN
         sC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899757; x=1786504557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JWpXQSVlmsFGWTkJETCzoI7IiXAWiXm3VeZqV6jTpY=;
        b=LP8vxjCiN9H8dsMfAY7jAEYRZTi65oT4VKuC46UIV7Z4pgajfwoVRvB8bYTqB+gbuE
         QOlJYu54mtPYG1G8cO62+n/f5S61+r+Iuyt5/COUEidKcKtOBpzBTbJHfGhX1jB41eYM
         GHxrHBzoV7JcdO/CjgTMv/3eWXEGHnqdzupTXvgEnSpdzeGkepsTiMFr0shTD1YVUpQV
         yiKUkb23yOFhzZbTZ6I2IfgaSSSR+Bz2cDInstkpYkM61WKpDRpUo9gL61iUjBGN5CEl
         YPzOQGnsL1Ij3blsgJ9zugJrISYKVp7SMHY5EgVB0+9Szjz4VQ2Yiy06larJ0gdLUWMk
         NiUg==
X-Forwarded-Encrypted: i=1; AHgh+RpMwYWumnW6YS8eQEZ3svYmcbfG2Ni4IFiiF+UO2lrYxer9yRYiPx21NELUHyDRMZE4urE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+fvwxuryOziOzS17GDM5Oy3GSPdHW4V7CO3fGhQnodl32PCU
	LWXGFp6uqz5uqqyfDElnkdJ3B6CQTYk7ehgtydOo7OXBWS9dxCmCiV0H
X-Gm-Gg: AR+sD12hlm9KNs5TbMccPwsu98//Kh9tx9jI9XQRuSOkBhej2JDzNWaYto0RyjSYYcN
	6OAUiaUw4NpN8pfK9z4S4yR+qvnILFaEo9JVPQIO2A/i5UEFM8qjrZxxi42XaOzAq4Y8tE3mFeJ
	v2jl64jjsijShwQkOjx0b2v8vHpGvT7bm1ctYpHv6Ej1KGRNtQHqlBp6vfNxv4zcBWaZmMOqu3/
	zuSJhtLWORS+MGY2S/9HG1BjA3ccdU4+hsv8cN0eF3VOLJp879dU/5ih4lOvVJR2cD1jcNE6LJB
	+UEyFjzoto4ydrRPIGOi3rlTKIanZi+X2ZcmP5t7hcq0x/zzoFmPLgQWe3wQLFXYdhbRbBisUNr
	tw/WNIOpkVqIsJYbF5zh6bifAH/iPTCmp1bDcOdK+zpIUXPJuLU5Yp4nxFTOmF+UaAJZDjcJaz7
	QQTEJGsVDsFeQ0GO5L1RbvZ9py7IlFRrzU7HLZ/5/eu/JC8sinTwIXhShuoJ33wJH6oz62wiChJ
	c2VK5qnh3WWbARbaC9+2v2AEvdGOhPC5UpQ1feIXjPzQv+C8EcpL+Dgw6bLSRU=
X-Received: by 2002:a05:6a00:4488:b0:848:56ff:6ce4 with SMTP id d2e1a72fcca58-84f2dfc533fmr4208442b3a.5.1785899757288;
        Tue, 04 Aug 2026 20:15:57 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe706e1c03sm536727a12.0.2026.08.04.20.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:15:56 -0700 (PDT)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v3] bpf: Fix mmap_lock leak in irq_work path
Date: Wed,  5 Aug 2026 12:14:25 +0900
Message-ID: <20260805031425.2157475-2-sanghyun.park.cnu@gmail.com>
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
trylock failure. Keep rejecting the slot while the irq_work remains busy.
Release it after the irq_work callback unlocks the mm.

Fixes: eac9153f2b58 ("bpf/stackmap: Fix deadlock with rq_lock in bpf_get_stack()")
Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cdd6c0925e12b0af60cc
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260630033745.B80201F000E9@smtp.kernel.org
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v3:
 - Return the reserved work item directly and use ERR_PTR(-EBUSY), as suggested
   by Andrii.
 - Keep irq_work_is_busy() alongside the active reservation.
 - Update the Fixes tag.

Sun, Puranjay, Ihor,

I dropped the Tested-by, Reviewed-by, and Acked-by tags because v3 changes
the helper interface and restores the irq_work busy check. If you have a
chance, could you please review or retest this version?

v2: https://lore.kernel.org/bpf/20260730054858.209807-2-sanghyun.park.cnu@gmail.com/
 - Drop irq_work_is_busy() and rely exclusively on active, as suggested by
   Ihor.

v1: https://lore.kernel.org/bpf/20260722023004.1497923-2-sanghyun.park.cnu@gmail.com/

 kernel/bpf/mmap_unlock_work.h | 51 ++++++++++++++++++++---------------
 kernel/bpf/stackmap.c         | 28 +++++++++++--------
 kernel/bpf/task_iter.c        | 14 +++++++---
 3 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef..1834db20b861 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -4,12 +4,15 @@
 
 #ifndef __MMAP_UNLOCK_WORK_H__
 #define __MMAP_UNLOCK_WORK_H__
+#include <linux/atomic.h>
+#include <linux/err.h>
 #include <linux/irq_work.h>
 
 /* irq_work to run mmap_read_unlock() in irq_work */
 struct mmap_unlock_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
+	atomic_t active;
 };
 
 DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
@@ -18,32 +21,36 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
  * We cannot do mmap_read_unlock() when the irq is disabled, because of
  * risk to deadlock with rq_lock. To look up vma when the irqs are
  * disabled, we need to run mmap_read_unlock() in irq_work. We use a
- * percpu variable to do the irq_work. If the irq_work is already used
- * by another lookup, we fall over.
+ * percpu variable to do the irq_work. The active flag reserves the slot
+ * before mmap_read_trylock() and until the irq_work callback consumes mm.
  */
-static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **work_ptr)
+static inline struct mmap_unlock_irq_work *bpf_mmap_unlock_guard_get(void)
 {
-	struct mmap_unlock_irq_work *work = NULL;
-	bool irq_work_busy = false;
+	struct mmap_unlock_irq_work *work;
 
-	if (irqs_disabled()) {
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			work = this_cpu_ptr(&mmap_unlock_work);
-			if (irq_work_is_busy(&work->irq_work)) {
-				/* cannot queue more up_read, fallback */
-				irq_work_busy = true;
-			}
-		} else {
-			/*
-			 * PREEMPT_RT does not allow to trylock mmap sem in
-			 * interrupt disabled context. Force the fallback code.
-			 */
-			irq_work_busy = true;
-		}
-	}
+	if (!irqs_disabled())
+		return NULL;
+
+	/*
+	 * PREEMPT_RT does not allow to trylock mmap sem in interrupt
+	 * disabled context. Force the fallback code.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return ERR_PTR(-EBUSY);
+
+	work = this_cpu_ptr(&mmap_unlock_work);
+	if (irq_work_is_busy(&work->irq_work) ||
+	    atomic_cmpxchg_acquire(&work->active, 0, 1))
+		return ERR_PTR(-EBUSY);
 
-	*work_ptr = work;
-	return irq_work_busy;
+	return work;
+}
+
+static inline void
+bpf_mmap_unlock_guard_put(struct mmap_unlock_irq_work *work)
+{
+	if (work)
+		atomic_set_release(&work->active, 0);
 }
 
 static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 463f94ba1cc4..0384b32d88b5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -414,8 +414,7 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
-	struct mmap_unlock_irq_work *work = NULL;
-	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
+	struct mmap_unlock_irq_work *work;
 	bool has_user_ctx = user && current && current->mm;
 	struct stack_map_build_id_cache cache = {};
 	struct vm_area_struct *vma;
@@ -426,15 +425,16 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		return;
 	}
 
-	/* If the irq_work is in use, fall back to report ips. Same
-	 * fallback is used for kernel stack (!user) on a stackmap with
-	 * build_id.
-	 */
-	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
-		/* cannot access current->mm, fall back to ips */
-		for (i = 0; i < trace_nr; i++)
-			stack_map_build_id_set_ip(&id_offs[i]);
-		return;
+	if (!has_user_ctx)
+		goto fallback;
+
+	work = bpf_mmap_unlock_guard_get();
+	if (IS_ERR(work))
+		goto fallback;
+
+	if (!mmap_read_trylock(current->mm)) {
+		bpf_mmap_unlock_guard_put(work);
+		goto fallback;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
@@ -465,6 +465,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 						      vma->vm_pgoff);
 	}
 	bpf_mmap_unlock_mm(work, current->mm);
+	return;
+
+fallback:
+	/* cannot access current->mm, fall back to ips */
+	for (i = 0; i < trace_nr; i++)
+		stack_map_build_id_set_ip(&id_offs[i]);
 }
 
 static struct perf_callchain_entry *
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b256fb9c1214..13e1aabe6f88 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -753,9 +753,8 @@ static struct bpf_iter_reg task_vma_reg_info = {
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
 {
-	struct mmap_unlock_irq_work *work = NULL;
+	struct mmap_unlock_irq_work *work;
 	struct vm_area_struct *vma;
-	bool irq_work_busy = false;
 	bool __maybe_unused mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
@@ -792,9 +791,14 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	if (!mm)
 		return -ENOENT;
 
-	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
+	work = bpf_mmap_unlock_guard_get();
+	if (IS_ERR(work)) {
+		ret = PTR_ERR(work);
+		goto out;
+	}
 
-	if (irq_work_busy || !mmap_read_trylock(mm)) {
+	if (!mmap_read_trylock(mm)) {
+		bpf_mmap_unlock_guard_put(work);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1191,6 +1195,8 @@ static void do_mmap_read_unlock(struct irq_work *entry)
 
 	work = container_of(entry, struct mmap_unlock_irq_work, irq_work);
 	mmap_read_unlock_non_owner(work->mm);
+	work->mm = NULL;
+	bpf_mmap_unlock_guard_put(work);
 }
 
 static int __init task_iter_init(void)

-- 
2.48.1
