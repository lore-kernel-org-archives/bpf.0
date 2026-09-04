Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053934CC277
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533666; cv=none; b=XXupI8fS3U7kZZZt/Wtnt6Vl8yfb+MaXyNP+8y5eLIbBB7TmUODD322yQ6XJa2jEjEal7WJzTRZ8nD3QDAjEpFLN5XCPMB0ng8OogbXaBCtybM0Ua6X8OMQZqY4nwov7geCFhfLpmkULwSz3PnFmV6GpnmK0NxWBz5DOfmdPXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533666; c=relaxed/simple;
	bh=mSyr5ubBmdluKcCLSrzLFo733QFcQsmlfRW8JWiocpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOYAk/F8Qgrcuo7eevU9ag5AixMQFwCzIchSmU3bXmS8hfLkyYsuK5BFHwTst5DVlmV0RvHoEUgmmUvZQj0eR4AcCPZpXrFhbdm2ilEgNCV8FFnCKIDLroaOUpk4AzhLO+GkDmJJiHd4pSWwFfoH6fDXJcRJdgEZhqS1alhpL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUOA+1/o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUOA+1/o"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so9555905e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533663; x=1789138463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsJst8PFRStuSDVwSJV/FL2xzbq9iEwS7FDAi7P/CCA=;
        b=cUOA+1/o7JzQOGpeTS6W83NIwxj3jcDOdderJ/1NDShoQ0XTP/azkVRkufPSLUuj7y
         IecpR1VMBUEDYOHicHIwOLxWFCHw6QUIRzTzKeFXk3dBJ/DM5GlMN3/Uow0XbmQJHTfa
         1Ex7nhvIyGOaZ71XcqWmbF0jjzuWF7TcQpF+vtEZ7lImt/HEEXmLmq5feQGRcDGeBsQm
         O0KO3xQIWFZz+g7vVVi3FRhNClBi9s5jiRn6tT16/Ahh2vuCQ5Zi4lsMDOaHQqgSfyHA
         bqM+C6hTXDkGq4zHx3V0+d5c7K5z4/Mrpo2ep64SoHk9FZI2Elpfx0+VtfFnpGLZA0eI
         VzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533663; x=1789138463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsJst8PFRStuSDVwSJV/FL2xzbq9iEwS7FDAi7P/CCA=;
        b=kZGq2jOM+mD9ce7i8zIAikQzOlCjPbGvqIQk2dOmIC5e1uclCOt1+hrfOGnKUen7Ld
         i8EHyfgjEkev3Pe/Hr/IiSOktD3j/xYP0DtfLzA8OK+5OEJYEI+zJAEbKpil219lxst8
         wadcdWG91TX23TgjuIFJEADi23yTT0IIpBNQ2Pvkm3CFPgyFHVLKtqulZwRqEwxcBzf+
         yL4LXulLKhglXJjgkjI4jsJxGfg9z5e7Je9WV0oYVmEF/1Y0hR1d/qHBNd0K0HSk12tW
         iXlG0xdDydrl/rht2X1khWrrVZcNGKhXIkuCmi/ZhYiJOdLfL5xRaM6VGDsEmR4EELYn
         FCvQ==
X-Gm-Message-State: AFuF++kla0tLAeoCGazlse1skmLurnz+L1Yr/fxMT3NDW+sd8+U/O55d
	f+q/tF+Wrvh+hzDjX/Lr56NiSgYD1fLcldRwbtS6+gUPtJDiwIMCtnNLqSNU1a2DBIE=
X-Gm-Gg: AYBFou32Un3qwEhH29hWlLQA6ZcVpKlLxkWEIkdPsk+zKmqwILVVjfuenCC/tuuHvVd
	UMuuqDoOoP/bwpDVx/5PSgNzmVqqp4922OkDn5NQ6D4gslb4Naqg+S9Es8RQf24nyD6JQsc8Xh3
	em00+aFfawarmmTzi8yr2ZfjDA7Yo7/0PIfREZ+FG2prme+tAHW5V2D8mfuxGjCgxaQHlZ/0BM2
	WbyhIm/WYllwtr8v01N1nZ8a0vsFe9LYpiLXGOUEUISm7ewvunyAwTSoF68a9vLLQN56Lji5EtD
	KRonJ4qBsGU0sC+NQhuwl+4voOq6vBhkVTKRFqNvUAWV2GS8mevTSmEavWHmRSpbPjIM+5ut8Gn
	+vG2CXI7RlRJjc3+1BS+07Hl2TNxDtKe0K/7+8InBIogTtKoB7noNl/Uyq9+vvrqjnYhEGZKjYX
	AeclxdI2uYQcwU5v+cVTu6/Tp78H4QhMIYzSvEauSjsR09I1+f6BpeB2zGGEzF+Jc67Ctp0+q/1
	Y4eKYC4EuEJ
X-Received: by 2002:a05:600c:3507:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cf7fe6900mr106125375e9.3.1788533663103;
        Fri, 04 Sep 2026 07:54:23 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:22 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v4 3/7] bpf: Add user memory access kfuncs for mm_struct
Date: Fri,  4 Sep 2026 17:53:36 +0300
Message-ID: <20260904145340.40212-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
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

