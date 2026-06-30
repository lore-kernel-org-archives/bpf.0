Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9103749FF
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789958; cv=none; b=u5hTj0pDD1NgSb8qrcOg0DCpv7BLuM67FH9/oJZ3cZfENJrxyV+Y7A8eyyCJaOYHIqdzIQn1W7FiUBC8Se/TXdKi5ZJOCPQ/3kebUW6aF3zwCXPSAbgzm44ZkSPs067LAoLshvSHgdMFCgqf8RqUdZLQalz12e4mEndGTQbqEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789958; c=relaxed/simple;
	bh=XwH6NThYMinPP36EFibx6F0RV7Vl6Xfco3EIFG7ffPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxOvL76/kCr3Dp5pZ7b3iiHypMUrN/jq6DD2UrXeaEeDpZzbdIdzjqRSi7f8mhdWfaQXGdrbqyQ+zeQmeBHsa0cDuvX3TMRD5hNUuEUgckKioMxghqke/qV+aQQMQdsi1WMgm8TXD8xmvHK2ajkRYKBGXXIyiClhU8SA8gG4MjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnx4oODD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnx4oODD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so3367855a91.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 20:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782789957; x=1783394757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVNL3/hk98TBDtSoWE17YorAJ0cawqKnCozuniDcbs=;
        b=Nnx4oODDVcyabtxWyyZEWFErBSXcWEXxRR7Yodb2uJ31+tsboHnBP3HH1XuVx4w9fA
         eXvooVQVrBLXCbBu2jegqvXsBShncks7NEkQjuDBcK/oqhtOZNucAxejvV+Stc+R1yZx
         /qtEhR33Q0IAQy2npuPyEq9r4jSrGLHdY/HGxGDP/32Mz8/9jssZ8XNMo7IBrS0G+zzF
         sMHK9OdTImuYi/iEFdwmOmMH2NneD9KhCPivozXcQDgC4KP/+hJh7LGzHrYshAr7UqFf
         OGYffn8htZ3kiuXOJAZNpct2iXEix4Nj3gq1IjJ3aETttcvshlE08LOpk6T7lV6m+qX0
         IQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782789957; x=1783394757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKVNL3/hk98TBDtSoWE17YorAJ0cawqKnCozuniDcbs=;
        b=mP8RmphuBXuJ9ShP5WZbQ/JiFR7dFuTJRi7WOItFnlyHrEVKIiifC3Kh+G2wovf4mS
         3C0XMBL2+kFBI3yjjWjHk3cOuq+DXqGcjtFlr+dcvtuK+O191Gf1whOuGsCQRjsPR04A
         /eKJnycMPi/cIQ/4DxyJOAXxTrIkUrV+BbZtCHiRatV6td5lCd4c6gbnrUclOL84lpr/
         JWpf5sEuOQNekbtNaFcC/nz64q0vYNg69qkcS9sBdHrV4zHM5twkqlDxoP9LN+t+4p40
         7Z6MMGnKXdC6DtOTM+GmcbleKI3d3plDSuKLmxD7AERAT5VuraTgTutxXRdHa00uc97J
         sWzw==
X-Forwarded-Encrypted: i=1; AHgh+Rocx52zyvalU7m0l7h5mwlMwVcZ2QKhAxDDBQX/skGkSKXUbsKJTrWNLIOzJTI2HyPx+kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJvoIFZ13HcHzAs4MyCL7cOB4G8OXzzZ9KqalKBhvhlPaQpQc
	QWnJw9Dcl6DUKKmJ+0MfeJI9N3O+AESU3OSKHRfcL2XqoYragD/l6UHm
X-Gm-Gg: AfdE7ckesXVORuRo6pDX7S0eOVTD9UfVTO0f4KhZQDYs0jJFhn3b3VWfP3Q0xOczacA
	wYdf8wrssBI9Le5Gc4oiouyh03wQufkH59pbdkdVGG7MkXL5JdihyLdRw/jnjuCLpYXYsNyLFrU
	sG7lM2e4ytaodEexays67VqIfbrUsPfP/FxEjviRjLsFHkNt+Hi+Y/mJbMOmPHk5m++b6HvGhC6
	CQZ0/dvGHnsGX42B88MS0RJJOMoBVzvqI+sD3QSHiAnxYUY8tbbXFuP7wTQL6XZAXLOdcwn7Znw
	EKf4QrDuV+Fm+HXpyB34hW7X7pMM0aVLd6TKwAG3Y9Msl/c8PYLHsHmrCtw1SgWepSLVYMJzyF+
	zHchWnEYMEZmZ+ZGSYuiBkC+UbkROw8X9nki6y6/GhIYCl6TYsPUHcQx63AFlYExTejN557dDTS
	3irM2C8cR0QxG9kLJNl/xWxUVBjTY9bDrAu3fB28pL3plBaB+pNjaMdtzklXIzFto5auR+EwKhj
	K50zeMR7Tu53Ns=
X-Received: by 2002:a17:90b:380a:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-3805251a2e6mr1419456a91.6.1782789956606;
        Mon, 29 Jun 2026 20:25:56 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm644936a12.19.2026.06.29.20.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 20:25:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Tue, 30 Jun 2026 12:25:43 +0900
Message-ID: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
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
v6:
 - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy()
   still uses it.
 - Keep the direct mmput_async() call in bpf_find_vma(), but guard it with
   CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU builds.
v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.park.cnu@gmail.com/
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

 kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index fc5f463ca529a..1d56193caf5e4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	struct mmap_unlock_irq_work *work = NULL;
 	struct vm_area_struct *vma;
 	bool irq_work_busy = false;
+	bool mmput_needed = false;
 	struct mm_struct *mm;
 	int ret = -ENOENT;
 
@@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
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
 
@@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		ret = 0;
 	}
 	bpf_mmap_unlock_mm(work, mm);
+out:
+#ifdef CONFIG_MMU
+	if (mmput_needed)
+		mmput_async(mm);
+#endif
 	return ret;
 }
 
-- 
2.48.1
