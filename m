Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F729D27D
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059671; cv=none; b=S43A/mSS8vxf02prsT7N66DW3cyiC5Z+MlUPP1Jz0nnENmLAoLtwpcg2bU8KstzoF6Fahx3FvqFWo0iUbI/eYg3LQ91f3Rv5FgKwGDnB9ielNiZBvHHRggzEvVwswxJQ4LjRoxDbCEjmwo12dKpE5IFhytoqzyeFvttjhYvTekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059671; c=relaxed/simple;
	bh=EmwEENtoFqSJaXhbeXaOdb7JSa4NSdl6KFlGyf8RnLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hu2K6LLtWHGxuxn5WOat6JcfRIUHv9e5ziehccpd3Gh5IuWDLXS0bL5k3DAAov9p07N9dU+iPFYGYDe2nStB2zHrh8a/+AeQX8VO7/OAbb/dCjVcm3VOjL1QMtOCFtNKJ9yDxaep5hRionAAQHZQ5lbmHJBfnrQxbPPpr/tBdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngKwHOEU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngKwHOEU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84229481d44so2541076b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781059669; x=1781664469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35TuUoWijKrP5hbQ/BkJXPLs6qJVhLfUp5AnFRUjILI=;
        b=ngKwHOEUXKl9B9XPmrN2507ShuluPuI0i9DPfyk17QHQhEWrBAJcEIFwGSs6PBKTLx
         ZLJyIRTp4uc2qFP6uiiUOvrK84AO7yW/ththK4LU+AB+lrOb7M7DnfWoMFZMigUToMiS
         Xwj+cHliJUusrh9E4+Kpgw9G3tV2gyOD1wccprZhoVXwR2ycbzEkEy1Yp6X+Wo7WUSwg
         PjeLvxk1STg6xxQrGSo+HsJy9FEvPK2rEmgZbs5owvUSwAGr0dBkL30jaRXrAlfZSTgd
         B66l5FA4k/24fdYnPu5UEw4uhHTYyonpFheX0xsd3oEmWJtVlOFB1qNdZcwWFkTE/5/Q
         q57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781059669; x=1781664469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35TuUoWijKrP5hbQ/BkJXPLs6qJVhLfUp5AnFRUjILI=;
        b=YXGf4bnOb6xYFrdhzq32XVZBrIeJK3hJKs8Vx3wVBFEDBXJp4udK5BwIa3hYAecUd+
         GqWcKC5B0za+idf3KcYbM6fb6vePCANzDDd82MF3RFBWc+rr7R7TXU4nNtZ3WMqCVQL6
         4eWgf/dNBSPeofgntPaAvsGKsTAGdikmRHQ8wOlffQyE9ND1rnXPKlyh7PKpGEExQI9w
         qU0A9tfVJnC6YLK59N0Q71G1RxFV9Z6ORKvXYZ1DZsTGjiz9MVUVmIIjqlBjOSVA7+VB
         O1Pf/QSNGDFguKAtA+Kwxy4El82kW3q3Y7umsHc706BEX+4hj0FJNsY4unNeTrAHTO0T
         HVJg==
X-Forwarded-Encrypted: i=1; AFNElJ8AHqdTr9lExU8do7dv/iYMr57hpeYY4unAYJsXgkMlIg4iVyvzyfOW6BHa6Pte27VCCYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoekVvCSrRnb+9HjPhKymTgTdYIlbu6UoO/DB2RBGnomv7II0
	Sk+FzBE3dvknHYwsuTUisxnFLbqyTiLklDKkkTGH/HNoMDt87LF53mkV
X-Gm-Gg: Acq92OGRGNcSf7BsHDmxtMETivASsQgm4WYXYV3tdfORcjUamQOH1Ehm0NtEXEv9z77
	lXfz4CpeR54BV/h4oBk2Jjnbzpiib7qCdGWPZson8cFMNXbXE+OiGwz1/UXU50LkollzZGBjArY
	oWyycXYKZIx/xCEM8uyiPJQbTvnjs1AbvvINfHhT779ZV4TD0YydzVv08lwkg/3/n8GhKibprY9
	mXPHt76Nwua1CzU0otIH1HYbvWTAj7WZHqKd8NY3zwgJuTUeMwPkJ2mRn/LAcLBIS71Kv2GfhJW
	0LsXa7rCQAE+z/zXsxA8vJrEX1feYMhbgHPvS1t9XE5eEgAzQlrir+2Vlw2J5nC0mzJvGigaObk
	XIg7BL8pzNHImcEFZ3qqPQoTxjUVfxfSAUyjB+z6FCIgWzh854JpAjMujlliXkfKgT9RW/gPrRt
	RYhJVRGWpFN/0I3M7Ue9iti3sujI5WKOnVQsBzWdBASIjKSKs9CS7AARrAI14fUYrwoF2VYreAx
	NXBVLr6Xo0qxECSzHtDVhAUyABJ1O7UkBtD
X-Received: by 2002:a05:6a00:12de:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-842b0a7d365mr23486559b3a.0.1781059669465;
        Tue, 09 Jun 2026 19:47:49 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282916b10sm22882799b3a.58.2026.06.09.19.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:47:48 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Wed, 10 Jun 2026 11:46:36 +0900
Message-ID: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
holding a reference on the mm. On a foreign task, a concurrent exit_mm()
can free the mm_struct between the lockless read and the trylock,
resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.

For the current task, task->mm is stable. For a foreign task, pin the mm
under task->alloc_lock and release it with mmput_async(), mirroring commit
d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
Use spin_trylock() instead of get_task_mm() so BPF context does not block
on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
foreign-task path because dropping the mm reference is not safe there.

Race:

  CPU0 (BPF program)                  CPU1 (exiting task)
  ============================        ==========================
  bpf_find_vma(foreign_task):
    mm = task->mm
                                      exit_mm():
                                        task->mm = NULL
                                        mmput(mm) -> frees mm_struct
    mmap_read_trylock(mm)
	// UAF on mm

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v4:
 - Use [PATCH bpf-next] subject as requested by Alexei.
 - Add the missing BPF maintainers/reviewers to Cc.
v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.park.cnu@gmail.com/
 - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
   trylock + mmput_async(). (Yonghong Song)
 - Reject irqs-disabled contexts on the foreign-task path.
 - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
   falls back to mmput() which may sleep, and bpf_find_vma() can run
   in non-sleepable context.
 - Shorten the foreign-task rationale comment and trim the changelog body.
 - Fix the v2's whitespace damage.
v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com/

 kernel/bpf/task_iter.c | 50 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index fc5f463ca5..baee813290 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -754,12 +754,22 @@ static struct bpf_iter_reg task_vma_reg_info = {
 	.show_fdinfo		= bpf_iter_task_show_fdinfo,
 };
 
+static inline void bpf_iter_mmput_async(struct mm_struct *mm)
+{
+#ifdef CONFIG_MMU
+	mmput_async(mm);
+#else
+	mmput(mm);
+#endif
+}
+
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
 {
 	struct mmap_unlock_irq_work *work = NULL;
 	struct vm_area_struct *vma;
 	bool irq_work_busy = false;
+	bool mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
 
@@ -769,14 +779,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	if (!task)
 		return -ENOENT;
 
-	mm = task->mm;
+	if (task == current) {
+		mm = task->mm;
+	} else {
+		/*
+		 * Foreign task: pin task->mm against a concurrent exit_mm().
+		 * Use trylock on alloc_lock instead of get_task_mm()'s
+		 * blocking task_lock() to avoid deadlocking the target task.
+		 */
+		if (!IS_ENABLED(CONFIG_MMU))
+			return -EOPNOTSUPP;
+		if (irqs_disabled())
+			return -EBUSY;
+		if (!spin_trylock(&task->alloc_lock))
+			return -EBUSY;
+		mm = task->mm;
+		if (mm && !(task->flags & PF_KTHREAD)) {
+			mmget(mm);
+			mmput_needed = true;
+		} else {
+			mm = NULL;
+		}
+		spin_unlock(&task->alloc_lock);
+	}
 	if (!mm)
 		return -ENOENT;
 
 	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
 
-	if (irq_work_busy || !mmap_read_trylock(mm))
-		return -EBUSY;
+	if (irq_work_busy || !mmap_read_trylock(mm)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	vma = find_vma(mm, start);
 
@@ -786,6 +820,9 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		ret = 0;
 	}
 	bpf_mmap_unlock_mm(work, mm);
+out:
+	if (mmput_needed)
+		bpf_iter_mmput_async(mm);
 	return ret;
 }
 
@@ -800,15 +837,6 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-static inline void bpf_iter_mmput_async(struct mm_struct *mm)
-{
-#ifdef CONFIG_MMU
-	mmput_async(mm);
-#else
-	mmput(mm);
-#endif
-}
-
 struct bpf_iter_task_vma_kern_data {
 	struct task_struct *task;
 	struct mm_struct *mm;
-- 
2.48.1
