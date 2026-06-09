Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319E3F8235
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002349; cv=none; b=r8qC9Mkbg7hbT86Ec5dgUUTSvmVMl3cGiO3B90XbjA515qCOjSbbnREJIuLAP1cstpysIYIvvh2p49hH9vnnbEC2O1brxZWsLlfFDv4kN5RosFmEwLHw2s5HqsjPQ4bcKO7OqRm7xDAZJ7bwjQ4lvnt2CAdGp12RJxr6vZChD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002349; c=relaxed/simple;
	bh=RZzq7ExpUU9wC47Ve3L3KUD1CkBYNwVCR2D4znP3Sxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl/SfazT0JqgCA+g2dPvDyhjYlDtlTJ5VeFUbcanfxnrPVe7bjF0ZKUlKprROaYUD4HOQSg81LAsQi+3ufIRa4TX435aQ5j1sjoDxxbc9fwmUt6LuQuLhhiGSS8kgHxuLWRo815RQ6ljhRpxXxEnM9zQVfvIEd3A57L0ar6trao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exkde0dC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exkde0dC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3543590so35788925ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781002348; x=1781607148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGUP+nY8atVWZ4c0uc/v5kGflzxhXTS04zywvM16XsA=;
        b=Exkde0dCPLh/HhLcncMoYUKbIWbRMEp4010rXattar6pm02sqBNiUhXrPXsI8pPtG6
         3Wpa+jB6eh3MMpOivfkxRy9uO55fDOwGYqgc441gM51AWh8QEcdrH+/N3ABaC9Iyr0xC
         CnwoZPRCK/h1H/ADQQvhmMBdw0ixboIoZRBn0GBjasqsEUP3gK5xHvs81YEnL1XBQVbU
         NIVNMHk74KHehufitjOVmSFSJHjJlIfmqHqQRWbrNFT8jkRTHRAgU4iotkU78P24a0Gz
         CaxOm+BHCMKzED4JiCAUGnBcxBnTgPC8I+cD6Ul8hkA/QpHpxQce4U32bz1zOSGrLeRd
         VyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002348; x=1781607148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGUP+nY8atVWZ4c0uc/v5kGflzxhXTS04zywvM16XsA=;
        b=J0GPljXVsD1julDjnFmW+dVHRi5ShrRk7TmMUTFYsHD5QkEu5mjbN6QvbhjwDVL8sD
         JAPpM0kSR1ylZ1GN4Igh1buzv0DeWjWg6Ej+8fZtsPNpo2NYhV6M7A33FUTaXB1yVBmm
         EX7XwSjbQlwFgTFnBTXkkH+Y/rVFZeyMyYgJTJIYOP+hcJTuoy7bRjUh2Pv+OJz2Tw6H
         SitTl7zEpYMXPECIcLfYIOF7BaMWEDMmIDzPP4bERHNSjfGuw6Jts7HL6xp+/H3susI8
         CjQOG+9giDFXwXeZNJiPT2L0ImKPgN57e5NVfu00SA9W/FIo/xQO5Yp2w2XwkRFdNx9n
         leQg==
X-Forwarded-Encrypted: i=1; AFNElJ+T/oOTen2nCIBbZ7uFSM87ubsRNwjdfEZS9uX3sANdVrf6XpgmcIT6CGLzBzIm146dhFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26NbxkSefUzPXkZO7Y4ui76eL9clrfMtaSpLOHohQbAU1UAo/
	rCdY8UpbKjQS4NVwH4RCn+JzZHRXT6L1xdJ4o1UqStCvOkvt8pTlVs+/
X-Gm-Gg: Acq92OH14580gQW88VyjBur/rbVF5M3/g9BFB5ZDdk6gKgME8zu1XUvxvP8UDPevNwD
	7hoimYG8RyeDLmuVdtpCrj/kMFn4eRr8LL5KYwrkVvGcSwzzcbkdvsBzkzoj9KOv3SSuwyJbwNa
	f27Emq8CeD3evcnAv+RxIFFSbmIurDju+58m9xrVQXA9UOr99BmQwq0O1Fb5gKyOzDdfRt1y3dh
	x7rz+jrOHpMckC9V8BWpk2xdPPaeqwlOEM+kI0Ha5UuFR+Uh9B97xx/Go6jRTPGtQCcc4N8vfmv
	+09NnbF/uImHZZHXbL2utP26LefvoJ7bANr8EuHbbJk68lUCJ9TWpziXCE3dKor2B/EjqeHeqH+
	VVDfI4DqsmkhDMpp5wkQVtm0DiVYvqTitu11nMkgkpfuaendqm+iuuYl/yDXHM/YASIQQ/xZ0Jq
	FuMkTfqaur9CSyJS1KErlmqnrZruDwtMZaT1+lCF7Fqtdkp7J3SXovEukQeCGp/AZOVg9lpLKQW
	knt+lvSJUywmV5iIFw6EWRGEvUYfb6DXlIz
X-Received: by 2002:a17:902:c947:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c1e776ff40mr240039825ad.0.1781002347676;
        Tue, 09 Jun 2026 03:52:27 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f96b3fsm216887635ad.29.2026.06.09.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:52:27 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: [PATCH bpf v3] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Tue,  9 Jun 2026 19:52:13 +0900
Message-ID: <20260609105216.3536839-1-sanghyun.park.cnu@gmail.com>
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
v3:
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
