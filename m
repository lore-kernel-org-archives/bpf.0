Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DF3B4EB7
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447372; cv=none; b=YO3wsOwFv8IoaFVfQSU7w9T9DCfB1v0aipfC08t1uDb+YPOnrOU3TWcYAXRgSpfCswHcjGld6dSk5CwQTABp9uT8luZYJ4o+7rFeyhwwST8QdT9cwjRNkSoWEcLCA4j+BRwjhrDP6a121EHKSjxJTn1pvlD2OJMVgqT5IaWYfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447372; c=relaxed/simple;
	bh=8DQh2SWbpdhxbKfSWZUmdp9rHTYS6PAT02UU8JSnJKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rK+NMbs1kAPCB+9XGeOBIXFfzkpavR2RpXvSjRZFPkl45l8jelKAe5rr5bw0KJ3c65gyyosIENH/2YflQXX4RYxg36oaM3jQZzRchNqUfDkbXdSThlp3Mea2BfUxQ/jVIqjmjhPrOEvMkAky40kMrIWMzielWlPG1q7Ja5qthj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFnN6uck; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFnN6uck"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49802c418b5so28271865e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447363; x=1787052163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rcy5zMa/mQvTQ0drm+XsfTSCaDYlJAty3EgPpWyKkzc=;
        b=gFnN6uckci5jXJJHFeT5sX3RYH2D9Bgq5YPhKUqgsP0SbmHqGMQjVGQdspm/YSAoHo
         Zen9iKAF4OTPUN36H14SvcYoCjKZC9b/BqKMQE1vx7CSEJRUpOqSeljErhJBD1HqTqgv
         OLvkCP3NihDjZod0jYgxpYtInCG6u4WumjZcbIcS8izQRs2RuOCoOYI4/wm0VXxx5gC9
         zkp5EyS7+F8WE7FMDtDIyWu4V1QhTqLlpMBU4mR/iE6/+QcJ+Io1KKfU/iE4DJkXhXzq
         XjYwgQQ1IvcG+uyhPXpQj86fBF68MKW5MllxzW92VgBqx5lXmA25f/T0s1qJVI9GeyLP
         NZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447363; x=1787052163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rcy5zMa/mQvTQ0drm+XsfTSCaDYlJAty3EgPpWyKkzc=;
        b=avZOZajiDytVtpMwyBdGUjaQIeTE/4blyOsxOTdrGTy5I5v1ZZrpoxPIcORi8HLpW3
         y2PAU8y7T9h6NRRH6BELncCyqstqdEwOtCCYXaj6F84zAm4x2F/VWI+ZranroTDBsk8L
         WmLjhIIpd3FIVMsTJEbT5FpxUe7s679yRa2M0P9idBoNyirhwc0xpXWBdhBhuGIIPfXl
         amogSzeDyGex1MNQc0huA5cVIDkFQq1XduOik866cGcRuUje89WKxBlqIi4SfuOaCzgh
         F6M1CkUXXzzRtfvk5LrwAfR7NZSuoPIwpP4vtvTCv25PiUmYVr5L85YH+B1Rjpj6ibdC
         kKTA==
X-Gm-Message-State: AOJu0Yz6GKUBkwA5TFefNl6QkPbfSB1NPIhTWmRH4j5GzRtdTjyB4VjJ
	i1gSbT4Y2BHqUc3iNkCXXBqPYOiQaIXJaoP2Vuz87DcYP1WS+yywws1odCEErqPd
X-Gm-Gg: AR+sD13YEtpCuwkM1nWa1E0/a2Ho1QQFu2gqrzRW1xV9GZYnaZsgHGDJVyNN2lzNLI4
	Gu9xoq44kk3KfYj/m2cmBxfWrv9cEBjd2X2CRh3Xc68WuM0ISea+QgQQX2Y4bI/GrvCp4ZJgKaU
	HTMY9zIWZVK/b0fTWqM+bwmTQMBufGKLa6q3g5wfBDp7mUat6tIpLBnAa6whda8stqonohf3Qn4
	dTg0Tkdce9FhzGhyUNSqJZ9w01eJ+EUnC7/mTMQPrjNdFtXPexghGgW4eTDG9EW1xWJG4aRukwH
	tJv6H9yix1DZT9+zl2YxwNDwcMbqrRlC5MAQCyuIoahJvIOmYcuz/nBmCczvpOQCyY12P2JGt36
	QJsjOeohC7/tIXu9B5BRrsjlxpbYYU14PPTK+q8Q4a8RU+CN1XlFV8272zW/xN0BjVVEzHliA1H
	UfG2r35mgshgZ6YG7emtyBmVOsgB4rpa52d72WvqoMewxu4Y3AUoBAlVtYbYcRnEPXkyEQMHt+d
	QbZewmjfiWEV3g=
X-Received: by 2002:a05:600c:1912:b0:499:737c:8a8b with SMTP id 5b1f17b1804b1-4997845e778mr44282705e9.12.1786447363236;
        Tue, 11 Aug 2026 04:22:43 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:42 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 2/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue, 11 Aug 2026 14:21:51 +0300
Message-ID: <20260811112154.94053-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When security_bprm_check runs, the arg and env strings for the exec have
been copied into bprm->mm. The new address space has not been associated
yet with a task_struct until exec_mmap(), so existing BPF user memory
helpers can only read from the calling task's old address space.

Add bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() kfuncs. Both
take a struct mm_struct pointer directly, allowing callers to access
trusted address spaces that are not associated with a task_struct.

bpf_copy_from_user_mm() has similar semantics to
bpf_copy_from_user_task(). bpf_copy_from_user_mm_str() copies one
NUL-terminated string and returns its size including the NUL terminator.
It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.

Register both kfuncs with the common BPF_EVENTS kfunc set and mark them
KF_SLEEPABLE because accessing the remote address space can fault. The next
patch marks linux_binprm->mm as trusted-or-null, allowing BPF LSM programs
attached to security_bprm_check to read arguments beginning at bprm->p
after a NULL check and reject an exec based on its command-line arguments.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 kernel/bpf/helpers.c     |  2 +
 kernel/trace/bpf_trace.c | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6388b6b23e49..9ba3362832cd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4931,6 +4931,8 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
 #ifdef CONFIG_BPF_EVENTS
+BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
 BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
 BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 891897f8a1b3..8931b3b2fc9d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/namei.h>
 #include <linux/file.h>
+#include <linux/mm.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -3619,6 +3620,88 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
 	return bpf_send_signal_common(sig, type, task, value);
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
+ * is zeroed if the requested number of bytes cannot be copied in full.
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
+ * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on success
+ * and all of @dst is cleared on failure.
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
+	if (unlikely(!dst__sz))
+		return 0;
+
+	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
+				 dst, dst__sz, 0);
+	if (ret < 0)
+		goto err;
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, dst__sz - ret);
+
+	return ret + 1;
+
+err:
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst, 0, dst__sz);
+	return ret;
+}
+
 __bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					   u64 size, const void __user *unsafe_ptr__ign)
 {
-- 
2.55.0

