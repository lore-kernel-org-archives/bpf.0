Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5251FCCB
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799986; cv=none; b=VbeHObekEgfPtTy5azkC0Fr4JTYKGtXm/s1LZu3R/AVY00jpyK+i3JM/ZlWO8fQ/xBJ3t4pvlE3VEV/rJqQJncqxadvnaVrgXS8onOefbrHzA7+c8AF5dDK+PFVmL6YG1xjXySNFchsdLPxBIEKswQ9J2aEvv7TPZWQrgp6nOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799986; c=relaxed/simple;
	bh=mSyr5ubBmdluKcCLSrzLFo733QFcQsmlfRW8JWiocpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyjpBNnIZ5oPGOf//29gFmVgbHuxpvSjXw53jAjRCz32wJ0KFaoOGV37cEZlIGSX7OTnvZ7HqPKo0Y0p0KB2i8/SRGkJfwzGkUnPO4gSA7ehJkNff8/36n9S1OTn6xVTbePpa98MT0eBLeUk8N5tP34iy5hniecBNAT71k/fuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmd3/vPH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmd3/vPH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so18034455e9.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799982; x=1789404782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsJst8PFRStuSDVwSJV/FL2xzbq9iEwS7FDAi7P/CCA=;
        b=Jmd3/vPHlMNlIXCIv42F3gv4nKW8TAf2xV3YcAgVtta4Z3J/0ndsuCK4SXOrK9wfKr
         gfVyGN08Fv8qQoH5SlpJrEJs9J9YZezxO9z3PablBebYEMmpvGcR5mBNiolnG+yO8QNc
         qCbJha8S5ccRcUoMzv6st+LvVEOblPgdPKMOTj/yiqlcUZAH9C6Gtt841mK2uZ6y2ank
         wmw4lrxjyH9McrrkvStuhKJFza+yMLKn5aBB/uVHw3HTnqKbRcU73kCpsET8LGlm/srF
         rYG/kx2Q11O4UADfB91ul2pCZ3TG2MLiG1xJjR3XjorGcCKa3qpJhZJKBTMOvDJV76sY
         2U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799982; x=1789404782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsJst8PFRStuSDVwSJV/FL2xzbq9iEwS7FDAi7P/CCA=;
        b=ODoD6HVOBymJ+X3tjUKdgBVeBHqjB+zvGHUOXIyOIlTOv4qsRvtpsH3I4INFpXET9U
         +UT2MzHQcOckbHgMORnq6aBC2ANFrWzWdtNHzTZeXZvXGPUVZLiFgMhZqsIy/SIOkbSz
         LsLCsZ3ivvSIJg2bqjzZmLMfXg2sNuFQqM7+6K+G6C5DRGiZymrfdgU5JigL81fPVwfP
         9d8GSf7ujJ2FA8lMSDhMHvscwqLrdt0+Rz107HGXrpX8gfCESc3uIb+KmZUi7PveEB49
         5sneW8FeHoStTC5bNyE2DGs0UPtKfVEmkloLf71F9iGdnsJAS74t3QM7IJU+1/mr/jPS
         WYQg==
X-Gm-Message-State: AFuF++nbVSzjW3zpuq/xZyNrtrstTX1fQ371y/OX6jrEevYQg6kPX49v
	6qLx1p6y3g/fpITJQYgJ66a0pr6sRcWaD+gtFkm/HEkBScC9QX74N+6A8QBBiIEJwoo=
X-Gm-Gg: AYBFou2rayQEnV5DlzQytNuuXWH+7esG01ayHpc62WEedh5dhECpP5AdqSKuY4G4WHp
	mMv4kT6saZTOaGpf+o2nhMSPgZlOEJdD0CwweYtps8vB9l5ElIcsbSIvlGQChbTsj3cbLN9spQp
	pYEdGnmr8AkU+du/Qm0i8TE20/BDgZIWuR6c+R6lBcQSsIxe7MKNu0+DvXgv6U4FcvIA85Hrrw4
	bJmVSbTYuAkYrL8iCb7FDI6Zf1M8Quyn5TJ876GeZTsFcPiBAKFyrmVgnfzwXGWcsNCdXNp4wpX
	aaSmZ+Yx5eAGWkfbXMefdNB6VM/qeUGaABflsQOFKl4j5VfDP57rF8++9gbE8VYlotQzCyhAQwU
	UMGSqp6fV+AIMRtwu2gh2289F9zB5U4psymb6WCBfClsZRG8vDrQM3doqkinGVY6kfGKRz0L7vv
	SqPCptyhA9lZXPX3GCpUBtYrUqH2NIGWJ+1q5JobmVIioa3DIbcdj9zv+2j1Pm975iL/NXnH0V2
	g==
X-Received: by 2002:a05:600d:6451:10b0:49c:fa21:1c8c with SMTP id 5b1f17b1804b1-49cfa211d1amr150738145e9.33.1788799981617;
        Mon, 07 Sep 2026 09:53:01 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:53:01 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH bpf-next v5 3/7] bpf: Add user memory access kfuncs for mm_struct
Date: Mon,  7 Sep 2026 19:52:16 +0300
Message-ID: <20260907165220.52431-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_MMU kernels, when security_bprm_check() runs, the argument and
environment strings for the exec have been copied into bprm->mm. The new
address space is not associated with a task_struct until exec_mmap(), so
existing BPF user memory helpers cannot access it.

Add bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() kfuncs. Both
take a struct mm_struct pointer directly, allowing callers to access
trusted address spaces that are not associated with a task_struct.

bpf_copy_from_user_mm() has similar semantics to
bpf_copy_from_user_task(). bpf_copy_from_user_mm_str() copies one
NUL-terminated string and returns its size including the NUL terminator.
It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.

Refactor bpf_copy_from_user_task() and bpf_copy_from_user_task_str() to
acquire the task's mm with get_task_mm() and delegate to the corresponding
mm-based implementations. No behavior change is intended for the existing
task-based interfaces.

Register both new kfuncs and mark them KF_SLEEPABLE because accessing a
remote address space can fault.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 kernel/bpf/helpers.c | 142 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..d3c564437ad0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -32,6 +32,10 @@
 
 #include "../../lib/kstrtox.h"
 
+__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
+				      const void __user *unsafe_ptr__ign,
+				      struct mm_struct *mm, u64 flags);
+
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should return
  * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
@@ -682,22 +686,15 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
 {
+	struct mm_struct *mm;
 	int ret;
 
-	/* flags is not used yet */
-	if (unlikely(flags))
-		return -EINVAL;
-
-	if (unlikely(!size))
-		return 0;
-
-	ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
-	if (ret == size)
-		return 0;
+	mm = get_task_mm(tsk);
+	ret = bpf_copy_from_user_mm(dst, size, user_ptr, mm, flags);
+	if (mm)
+		mmput(mm);
 
-	memset(dst, 0, size);
-	/* Return -EFAULT for partial read */
-	return ret < 0 ? ret : -EFAULT;
+	return ret;
 }
 
 const struct bpf_func_proto bpf_copy_from_user_task_proto = {
@@ -3658,6 +3655,100 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+/**
+ * bpf_copy_from_user_mm() - Copy data from an address space
+ * @dst:             Destination address, in kernel space
+ * @dst__sz:         Number of bytes to copy
+ * @unsafe_ptr__ign: Source address in the address space
+ * @mm:              Address space to copy from
+ * @flags:           Reserved for future use; must be zero
+ *
+ * Copies data from the user address space associated with @mm. The destination
+ * is zeroed if an attempted copy cannot be completed in full. Unsupported
+ * flags return -EINVAL without modifying @dst.
+ *
+ * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
+ * fails or is partial.
+ */
+__bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
+				      const void __user *unsafe_ptr__ign,
+				      struct mm_struct *mm, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	if (unlikely(!mm)) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
+			       dst, dst__sz, 0);
+	if (ret == dst__sz)
+		return 0;
+
+	memset(dst, 0, dst__sz);
+	return ret < 0 ? ret : -EFAULT;
+}
+
+/**
+ * bpf_copy_from_user_mm_str() - Copy a string from an address space
+ * @dst:             Destination address, in kernel space. This buffer must be
+ *                   at least @dst__sz bytes long
+ * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
+ * @unsafe_ptr__ign: Source address in the address space
+ * @mm:              Address space to copy from
+ * @flags:           The only supported flag is BPF_F_PAD_ZEROS
+ *
+ * Copies a NUL-terminated string from the user address space associated with
+ * @mm. If the string is too long, @dst is still NUL-terminated unless @dst__sz
+ * is zero.
+ *
+ * If the flags are valid and BPF_F_PAD_ZEROS is set, the unused portion of
+ * @dst is cleared on success and all of @dst is cleared on a copy failure.
+ * Unsupported flags return -EINVAL without modifying @dst.
+ *
+ * Return: The number of copied bytes including the NUL terminator on success,
+ * or a negative error code on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
+					  const void __user *unsafe_ptr__ign,
+					  struct mm_struct *mm, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(dst__sz == 0))
+		return 0;
+
+	if (unlikely(!mm)) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		else
+			*(char *)dst = '\0';
+		return -EFAULT;
+	}
+
+	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign, dst, dst__sz, 0);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, dst__sz - ret);
+
+	return ret + 1;
+}
+
 /**
  * bpf_copy_from_user_task_str() - Copy a string from an task's address space
  * @dst:             Destination address, in kernel space.  This buffer must be
@@ -3681,25 +3772,16 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
 					    const void __user *unsafe_ptr__ign,
 					    struct task_struct *tsk, u64 flags)
 {
+	struct mm_struct *mm;
 	int ret;
 
-	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
-		return -EINVAL;
-
-	if (unlikely(dst__sz == 0))
-		return 0;
+	mm = get_task_mm(tsk);
+	ret = bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
+					mm, flags);
+	if (mm)
+		mmput(mm);
 
-	ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_ptr__ign, dst, dst__sz, 0);
-	if (ret < 0) {
-		if (flags & BPF_F_PAD_ZEROS)
-			memset(dst, 0, dst__sz);
-		return ret;
-	}
-
-	if (flags & BPF_F_PAD_ZEROS)
-		memset(dst + ret, 0, dst__sz - ret);
-
-	return ret + 1;
+	return ret;
 }
 
 /* Keep unsigned long in prototype so that kfunc is usable when emitted to
@@ -4924,6 +5006,8 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
-- 
2.55.0

