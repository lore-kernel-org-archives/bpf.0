Received: from mail-wr2-f21.google.com (mail-wr2-f21.google.com [74.125.225.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A64F3EA6
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737514; cv=none; b=j8YG6vmgDMpqOG0MXoA2sN0QdKQhzk3D4gGzVriRRGgX/kXu8VUGRq6/xc8BMC9eWYPXHiEVtOoKlpCag8ttvuJAgNIExMcNLdsLjfctHxQJbETV/KgMuz+WULrljUFyriJyke9AVQap8qbjGYQgAC8DUR08KKRjP24TF04rlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737514; c=relaxed/simple;
	bh=+IXRF+gxbR99W9XyJ7A4LutWdhORNAD9G05Fo0xKDts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6lrdYXnTVdHXFWut9RPGqtuXWMEz3as/+6UpoAtR2c/zPOEJT5JqoOiiOJMzIP5Z0SUNrqGDVSIVebY+xdycuEvV48R9AHTXom/1rkq3AqySemgw2GXJp0bF17x+PidTlmuqalzCTaelwPT0XQx18x33F/9mU/EWpB4Ybq8pM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qks8P6ny; arc=none smtp.client-ip=74.125.225.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qks8P6ny"
Received: by mail-wr2-f21.google.com with SMTP id ffacd0b85a97d-482f633cd80so365540f8f.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737508; x=1790342308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtBPLqwC7VJbXcngjda2oQbwhTixdm4j9JpsXuMGn8M=;
        b=Qks8P6nyrw2bjISS6Harh4axmDj1JOKUU32YGdG8NqGI9E/e5i/9wYvcHPNE6bTuIz
         kav2o9CIQqjpGTOkbabYHkRA1v9gwosKj00nuxjOv0GmxKzS0Y+SrzSE1GNlG7THcGJG
         0VU1PL3M9rGQ8n18hdHdlsd7oSaikusaPR6nuVGgPxzWC0Kidfw2hrB4MWePb2unPVKa
         vJ9zsBrH8IN/XSkP7SoN0r4IO13jYD/8qmLH5N2iLx4UhievBwQeiE2U9tz3kB6Os0cH
         YR+o+9ShmJA+fIlLYfsrUUDRcT2+ZqdBGPD7ZxNh8HBEQyZW78/YtaxiPj1+/zC7g+P3
         Hz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737508; x=1790342308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtBPLqwC7VJbXcngjda2oQbwhTixdm4j9JpsXuMGn8M=;
        b=pW7lbR4Su/H26GcSTKqXrhWSVt2BSxJWjZ855OUrNHfrEbNsrhlQ3K6IAUF45/9ZSA
         Lmgghk1yXQAXwVi/ninVTi7pup2nh0tks9bAGlA0DhLqqSxDIECHjlW0Qc9THen8XU+P
         Pa+hX1JOidWRl2vvmi8MZY2lPADYCz3ZfkUIjgvCir/SZS+Glj1IiYPF4UmEi+DJDDSi
         dyxWR0epHJR0eZ49YsgxY7CPh4MjFQu+i93O61K1048ZNCXrDcA5aPPe5WjUN1LJxF/a
         eZXMA92hB/zZMPomPeu8I9DVwi0Nv3DhSsax1uoJIPGJ5HhGFsulCFfOeIRAHJjzgZ/f
         V+8A==
X-Gm-Message-State: AFuF++lIx6d/uO70vYBT/PqvwSzBS9LyrIes4Fm76lgR5c+0/i7VM42D
	lGWmSVgU2qAGiTLhGuttfjqJdv3QDUpVzKugfzmRCSsExELIOGQ22d8NpQh48JZ4
X-Gm-Gg: AYBFou1vv2u9NQMDlWKbQCotfU2RewdORv0zYhT5UyIiUWgokgmd+NqYmiZyegzcoKI
	m2TwFqSBPUEhnfX0194v5FjfMz6cmuC+JnASK3vNFN/Jys/YbROW8bIHcPYMoEjD427gUvwovgh
	b4a8SPxhDkvvqRvhHlHBnDx4aXuLxDyNB193QLW1mlnSt99VHc5Q6wGG6jWw9Hfcgh2+bj05Sor
	E0w/IOy95i375cQIpKBFkVuWX82Fq5DFOEuLTQVrQIqPznX59PnAvsZG9OmF5YwwphpbyQajkmg
	W92XFXdY1NA8W2aRXG2+nglCd0mTf9PXQLAw7rvnqOFEQxI5AQza8DDBgIs6xZa1MT06lbXgnwY
	rLd1OE3keeHrLuQzmeC3I9iLUz6aRH+MafZINEXEFG41E1fqzJQjcMEjANWPYRcAlbnwEryBwL0
	iCclTgC/34mFOGIxUmOL2JarYNdXzOimi53/dSZjv+u2jHl8tP3jI9/4AIYS+R6Ko07QEjfTGl8
	a74C9jHtl2v4hs=
X-Received: by 2002:a05:6000:40e1:b0:482:fd9c:3740 with SMTP id ffacd0b85a97d-4871e227ccfmr3468864f8f.22.1789737507607;
        Fri, 18 Sep 2026 06:18:27 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:26 -0700 (PDT)
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
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v9 3/5] bpf: Add user memory access kfuncs for mm_struct
Date: Fri, 18 Sep 2026 16:17:55 +0300
Message-ID: <20260918131757.42802-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
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

Refactor the task-based helpers and the new mm-based kfuncs to share
static internal implementations. The task-based interfaces validate their
arguments before acquiring and holding a reference to the task's mm for
the copy. No behavior change is intended for the existing task-based
interfaces.

Register both new kfuncs and mark them KF_SLEEPABLE because accessing a
remote address space can fault.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/helpers.c | 154 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 142 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 051b6654e57c..82402d97ce67 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -679,9 +679,44 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static int __bpf_copy_from_user_mm(void *dst, u32 size,
+				   const void __user *user_ptr,
+				   struct mm_struct *mm)
+{
+	int ret;
+
+	ret = access_remote_vm(mm, (unsigned long)user_ptr, dst, size, 0);
+	if (ret == size)
+		return 0;
+
+	memset(dst, 0, size);
+	/* Return -EFAULT for partial read */
+	return ret < 0 ? ret : -EFAULT;
+}
+
+static int __bpf_copy_from_user_mm_str(void *dst, u32 size,
+				       const void __user *user_ptr,
+				       struct mm_struct *mm, u64 flags)
+{
+	int ret;
+
+	ret = copy_remote_mm_str(mm, (unsigned long)user_ptr, dst, size, 0);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, size);
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, size - ret);
+
+	return ret + 1;
+}
+
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
 {
+	struct mm_struct *mm;
 	int ret;
 
 	/* flags is not used yet */
@@ -691,13 +726,16 @@ BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	if (unlikely(!size))
 		return 0;
 
-	ret = access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
-	if (ret == size)
-		return 0;
+	mm = get_task_mm(tsk);
+	if (!mm) {
+		memset(dst, 0, size);
+		return -EFAULT;
+	}
 
-	memset(dst, 0, size);
-	/* Return -EFAULT for partial read */
-	return ret < 0 ? ret : -EFAULT;
+	ret = __bpf_copy_from_user_mm(dst, size, user_ptr, mm);
+	mmput(mm);
+
+	return ret;
 }
 
 const struct bpf_func_proto bpf_copy_from_user_task_proto = {
@@ -3659,6 +3697,92 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
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
+ * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if @mm is no
+ * longer active or the copy fails or is partial.
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
+	if (unlikely(!mmget_not_zero(mm))) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	ret = __bpf_copy_from_user_mm(dst, dst__sz, unsafe_ptr__ign, mm);
+	mmput(mm);
+
+	return ret;
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
+ * -EINVAL if @flags is invalid, or -EFAULT if @mm is no longer active or the
+ * copy fails.
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
+	if (unlikely(!mmget_not_zero(mm))) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		else
+			*(char *)dst = '\0';
+		return -EFAULT;
+	}
+
+	ret = __bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
+					  mm, flags);
+	mmput(mm);
+
+	return ret;
+}
+
 /**
  * bpf_copy_from_user_task_str() - Copy a string from an task's address space
  * @dst:             Destination address, in kernel space.  This buffer must be
@@ -3682,6 +3806,7 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
 					    const void __user *unsafe_ptr__ign,
 					    struct task_struct *tsk, u64 flags)
 {
+	struct mm_struct *mm;
 	int ret;
 
 	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
@@ -3690,17 +3815,20 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
 	if (unlikely(dst__sz == 0))
 		return 0;
 
-	ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_ptr__ign, dst, dst__sz, 0);
-	if (ret < 0) {
+	mm = get_task_mm(tsk);
+	if (!mm) {
 		if (flags & BPF_F_PAD_ZEROS)
 			memset(dst, 0, dst__sz);
-		return ret;
+		else
+			*(char *)dst = '\0';
+		return -EFAULT;
 	}
 
-	if (flags & BPF_F_PAD_ZEROS)
-		memset(dst + ret, 0, dst__sz - ret);
+	ret = __bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
+					  mm, flags);
+	mmput(mm);
 
-	return ret + 1;
+	return ret;
 }
 
 /* Keep unsigned long in prototype so that kfunc is usable when emitted to
@@ -4925,6 +5053,8 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
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

