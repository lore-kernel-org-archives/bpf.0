Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752022BE7DC
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495353; cv=none; b=fdhAmHD7Z5jpiNvqZMnocmkypTA+DO1aEmIT1fXkGkCIQKG1ZvsJzAepbYCgFtclFwVLeP+ooK5tsKzjpHxgI9mBOySoVMKcZZ1Mfc6jAcegoFScKJg+e8418UrUc1M7YsXBeoBjptBB8M0iTGwYPQiiXUUUAFIhumSzQz/pFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495353; c=relaxed/simple;
	bh=p/0O9SSzQ9mSYaO0UPw4RrNra/6W1MxQrmNP0Kz8aoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLJ/D1/+KlsWvTpdvvjpzy+YsH90fyqG4eow6/fMgEfC52SVB/HXjLY77puRCfKVJCLJU4We7b5LWn1DNLkcuD8d/U6IFGbwaIanaQvVDXSjRe9siuvRkQv4t96Hk98D9/D/MEEZRckCGOBlRiog5l8suKoGq92jIrw7DLfZm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0AZNkVK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0AZNkVK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso3482235ad.1
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783495340; x=1784100140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABGZvOuLiWoxRSjZ3PNYnG6X2wEe+pNBW/beoBLeqy0=;
        b=q0AZNkVKKl/lhZ08CUp9I0GU9+G9XvMcTrOvAX5ao1vmdcUXb+a6TPVMRrX71+HEn7
         z9Kyx9NxfoO3/MK9IWFbjRGpnLg7IIm92aduiLV1gv/lAgCWjGakkxMi13HqvdZPqgyt
         4zwmi3HOyRGv7oE3FrDOevFgBSUsmWe+oJhdq9nQcBgUBpGdxr9qD2etWtJiv4PpR/NA
         PjgI6lpNJOi7UZpTa69UjaEYJBw+IJPxVJkR28Uex7jC7IRlmgBWOp8zcQdKtRgMcWFA
         UwO+ocPmT5qlBYk/nLGSj+y/TZtzPVS+uKSiqn3B/rQd5VJEZtvH72xj1mj3RSDLLDPh
         H/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783495340; x=1784100140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABGZvOuLiWoxRSjZ3PNYnG6X2wEe+pNBW/beoBLeqy0=;
        b=ogVvZCzaP48EVQPKOl2fPZDuMqjx2oRAFOL8KdjrmqNx8/k5DC2Gx+V250NySJspJp
         5ey+EyXPXpub/gPtDcCfC8xf5aL/Yo9xapxSvD5rwC6p8JMc8QCgnqc91iHFDfeEhvNt
         6fag/zuixSxqW/1qfU28yMvsJhzjWjtxXk1lIXmVPVnPYw1Y5lsNVwa/B8THnkN2TKLe
         XQfCl1MroZEq4NcrHrm3ckxjVXrhcKJuKWw35BXk9NQtAo7LbvGrKnHZNJIkaSZ/wy8X
         lOtYfKhmF07AngsYM5kL2dVoHI0SrlaPJ42/Mi+tIitdof/Ojahp6M85oLR7g5sHSybc
         YIeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2uM8cQEQW7/Gl0jzAs76+mDSqOHsUI7Y4zRTCTop6ApkUKjoChXsZRKdRYRdvRQQ0ifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAyNETH3eNKigs8WR3NWCcbkSgdyfmAaqtJuHaGYQuSxtoSg5
	+VmEqmZQ+oPQfqktDxC3EJ23cr2E6igduwVvKY0I/XNmW8e9aGEqt7Kn
X-Gm-Gg: AfdE7ckcCCTM+1SBnNyS80sEdbNojdWCOAsALQ0IT0xaSZmGyVaWZcKnieQiZLlF7I/
	4cynrs+rZVp1wlOa4Yt9B1icnOCJcyYUDjUEQbksAxlyJRAakYbgDeDDts44CYy0em9AH9UCzTD
	dURAaqt0upG2uTPTXDgcBjE1645di6oX7FaqWrqmsbLwQ3OUtETFVOk94TFnyXX0Ansja0zwY/i
	XqpqWvmq/UDGggIRuq2EUXc7AdZjqM5c3bFV/GQ4MOH7iIcgX2UaDjm+jgsWzjRg/b+L89wOnWF
	pUU9s/QaSL2dVVbVFvIW0K6v97I3KrBmFY9w1A0nd/Gc/QlTCvAGFL+TwO8Ch8SKG9F8BmtR53T
	ldYOZ4kKv3r3MAwqHQhOgKFKg0WyrEAmXtn4Y8Z4HIgLmLaEGWuPlVCKJhXSwKNNqdSEWFIGQaM
	FAcTMSzK9PBimurss+tUBpNGvtdLYI5uUOREi/VbLBnz2KYCaCW/jp/LcB8VDdbyYQ6BnE2r+JK
	zx2
X-Received: by 2002:a05:6a21:4e02:b0:3bf:c126:bb02 with SMTP id adf61e73a8af0-3c0bd0f8fdemr1412682637.47.1783495339766;
        Wed, 08 Jul 2026 00:22:19 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5946sm1935131a12.7.2026.07.08.00.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:22:19 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Wed,  8 Jul 2026 16:21:04 +0900
Message-ID: <20260708072106.199637-2-sanghyun.park.cnu@gmail.com>
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
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v7:
 - Fix the sh/NOMMU W=1 "variable set but not used" warning by
   marking mmput_needed as __maybe_unused.
 - Add Puranjay's Reviewed-by.
v6: https://lore.kernel.org/r/20260630032543.3165720-1-sanghyun.park.cnu@gmail.com
 - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy()
   still uses it.
 - Keep the direct mmput_async() call in bpf_find_vma(), but guard it with
   CONFIG_MMU because the foreign-task path rejects !CONFIG_MMU builds.
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
index e791ae065c39b..b256fb9c1214e 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -756,6 +756,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	struct mmap_unlock_irq_work *work = NULL;
 	struct vm_area_struct *vma;
 	bool irq_work_busy = false;
+	bool __maybe_unused mmput_needed = false;
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
 
@@ -782,6 +807,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
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
