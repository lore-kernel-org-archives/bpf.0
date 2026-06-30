Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8531E5B88
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786937; cv=none; b=LL7At6Iuf+tF5+LEUNdSCAJT/Z5vo9wfTctBCz4sUjLjzoB9cUSoneMo0AyUSWiEt4ziIJ1Q6YuCPP7feAWjm243P4Jrx/bW16wOf3OIKxIrv4jn3Vcp4bbceoQRSt6Vv20v5EjQwZh+1WN9HYIHRS3XPDeYFPKfeTOs2GmeVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786937; c=relaxed/simple;
	bh=TYf0wT8Bp6qvyBbNkLYWwv8GzxC08BfjBgN+SxryCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYW3Gdz7tKr4H5wYotHSvKjZMPKY9OB2USEbolb9cJK/r79jjlkEgh9OCQsk0Im9KSaa2YXxOtJCZplk/SWyqamT/bUpdug8uK9figHrnZ18VfM5NgfEqHYAipkSwQ36oaGQt3Z0YeEJXMIXS2ynWfRvCtM60OiDd4VT8QYqRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtP/hTqR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtP/hTqR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c8017e981fso20448395ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782786934; x=1783391734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXb5N62lj+bL3Tqd6oAXeBut9W5nuI9WyRds8dvqbcc=;
        b=BtP/hTqR3984yt8zBXQRmsmJWw91ilJI+hp/NRaUYxDCrCX5prvxsf8qgnImDoM740
         5q899ES3C/cvRkepnA31t02bTSCm3ez0W9yFU5EplaIXAVZZ/raPJHwOC0B0iP3Ab4Fa
         eA3tMWriwBuQ/NSpNXHu5fjnv/ZnORDbwzSHqX7JziTmogCJbaaoArixXUUnGZj65/pI
         qGMp5kpUVfvXY51O0QmqO+Dr/yOsrcjkYY2htZKe9Q9gPImTmr5qeVQTbYR254TRLrVY
         VeurFGpYNoTZMvbJARZwHs4q5vqyJ/UuWCm1Y75EO92PUhcpLiuJopBUVd9TIij1rp0T
         hW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782786934; x=1783391734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXb5N62lj+bL3Tqd6oAXeBut9W5nuI9WyRds8dvqbcc=;
        b=bSBVgfCR6Zs8E+FIxAZaswCQ0snywjuzag66LX8euTiVHP4hXSLCW7RFAvvfxUUR1N
         vWNv/C3EMaNACvccSIAIwiCPDBd1oUTqLb1e249Q3USXpcOumt/q5Y/jZQbKpt/GlsR+
         aHHfpP8ACzG2ZrpbHNJbfQlrZl5FUn4TbdoiwTLaDZEGMawvfFLemlz9OURm9ajePn0I
         LX64Vaw+t3HvujFC/QWebEO/+pHixk4CB1dyW5UbvHI/F+6o5WQNNbGEQKxP+qpSNnWr
         48AP61+W8dsGD9Pryegfc15/P4XZ6NoT3jdbx23nZ4ibUBinCcYU6O8QbQdTLhr2ioeI
         0bfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYgW2ToWLJjf8Xun4yQWbkdYjppskUheOxuFRViLJiexnkGSwXlWP43AL1lkxzqn0CoKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWk58w7BustkKChVOcg6OLpespXt3VWtUVQ51RuavpkzUbPuT6
	lS8HeiqtuMYxpYkcykRxiXpAt4EM5MWtMnm6G524Hj+H8UZ1RAmAJl/1
X-Gm-Gg: AfdE7ckMotgsK23D8tX2bpdgqcHiW7gZBAWv2ooXqr1YNXwPDSkI4JQFMdsa0iWBca4
	NTxEukuSw6U3BQXgJ5pQRt19HyUhhy3ML3WBbLPJV7DBUhMmSkmny9XF1+/rhgQOzCy5CeorhPy
	gpQL9RNz0SQBXH3NO1xfnkwlzF0+7LGyqKspp1SHKyYvDrvME7jjA0nXkaZWm1L87MyZWYGFRFd
	Oqhgc11KkgadhpmrEPqJRo62IcwHDdqB9DZ4GZFILCLKQwlDjSEmE6c6DbP46G3fRIe4a5gcJro
	GNcbnR6hqhYOSvjaG0Lm0YEjpicPzIQHrDztGuO8PV9ATbC6NivIGhect89bM9O/t/t+ms/oE0V
	PpsOFxeIzcd6MQL5t5QU4qwnVNbxi2ecIb73luIUHmulmWnYdNH6TlKb9VGS1HNu0sQrmL+k8q7
	0jcpmXSKP+EeE07OdHNp377a470VulS3Xa9uit3yEHIoju2Zg5mkIpSzr5R4qcBQXcikrWkZdeD
	yRu
X-Received: by 2002:a17:903:166e:b0:2c7:f7bc:633e with SMTP id d9443c01a7336-2ca2d5628d6mr13165715ad.13.1782786934398;
        Mon, 29 Jun 2026 19:35:34 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382b9e92sm3254445ad.65.2026.06.29.19.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:35:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v5] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Tue, 30 Jun 2026 11:34:43 +0900
Message-ID: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v5:
 - Replace bpf_iter_mmput_async() with mmput_async() directly as suggested
   by Yonghong.
 - Add Yonghong's Acked-by.
v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.park.cnu@gmail.com/
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

 kernel/bpf/task_iter.c | 43 ++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e791ae065c39b..27ceead874651 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -756,6 +756,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	struct mmap_unlock_irq_work *work = NULL;
 	struct vm_area_struct *vma;
 	bool irq_work_busy = false;
+	bool mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
 
@@ -765,14 +766,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
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
 
@@ -782,6 +807,9 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		ret = 0;
 	}
 	bpf_mmap_unlock_mm(work, mm);
+out:
+	if (mmput_needed)
+		mmput_async(mm);
 	return ret;
 }
 
@@ -796,15 +824,6 @@ const struct bpf_func_proto bpf_find_vma_proto = {
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
