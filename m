Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271D2F7F02
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875642; cv=none; b=IX8T5oGheDeCf6ly55uJs36SX3+nCm9RbZ3V6iN+MUdsCFsCqxf/4/hQH85QUG+Buir8jYlHFqGj7AL2FHwGTIcudU4fE8G6KOexCE8X8F2z6aoNXoJ/guhD2HuKUYeCpgzlTfq7J+bZyiw9BGKj/VM8s5OeRaLF0Z3aCdFA9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875642; c=relaxed/simple;
	bh=Jp/8wuz4bLqv6X2VknLOdLdnBsvBqAZbQZW+ZPOb804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJswJwuGjY/tggewHgIcZjTjhnt5EZ35wWW+l0zWOcXwuilW3eDgvB0GBp71QhH8SOiQGG6dDLyBB100m/dNu1KvHObShCEHn0ZVsDB2DTldsRIg8H6/GbQezy4odZSpubkHoFuN3LpocwZt6AN/sDNelSVE62Fhi2O0pvvTVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWnkvZ/k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWnkvZ/k"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-485888b3c3dso4737326f8f.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875623; x=1789480423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xSsTNyIRZy5PEX3RScePveTfXXWy3/wJHDxgtQYEvA=;
        b=RWnkvZ/k+t+iYIdw8YuNx4B0TSTnCehgTSb0aAlNfDlRlnG2R+c8kg9vzopfw+rPw2
         YNxml7HMosJOwxcFpghxvda85oKPMsRk7spa8DOFL7xlj40WQH54IZZPBMeBtXDDlwW4
         NwIvRymghTFz5U4QUW51XYMbCzjMmqE5B424HJymWqVo9GYZmMuw8OV2bFMkvb6FYRIa
         T6QrgRhnyDwwr+Sfykne+pF43FbrUvltRZd4b+3eAkHp4zGXcL3FlAFAP+hDssoq7lFj
         8q+ueWvPQP31HY3BuPOjPVIV2WR5iLHUk8TTx2BOATPdUrttgDXm2e5IrneBzg7CbC7d
         j0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875623; x=1789480423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xSsTNyIRZy5PEX3RScePveTfXXWy3/wJHDxgtQYEvA=;
        b=Xy5sn21qMi2AaNF+BMbvyMbAAkYg4qAsrxQlMB3k0JlT1qbjb+Wr5m+qkLqQE1lVHP
         ANelW2mlUqNf2FKInCRchhiHsfRcI6myfkmAdiwC3a2KJaYLriRIncM0BZ6Hiiydj2x9
         OU5lypoRhaVZRC4QjFOIU9r0uJtvVkqEdPNOBH4veb87nShLCIMwThEjmj0VQkoI5dgt
         IE4JAjKvP93g7NeguemoJTSTyKXlZXVWPY2H4BBLEWsVtzPeqfjZEz6yDTRasMB/0pB1
         80OeeSqmPcfoQe0duY2q/OyebPC8OF11Usjn8y8NJougVV4IRqfPWNN9Ot9dnmveIXHH
         YXUA==
X-Gm-Message-State: AFuF++koZLMQl4LdpZqYi0NeuCnfXwGI2CrIouP5VSnP4eyjXAjkkVTM
	R88GOYCHGdCvBMK4o2kIUHT/kA3EiomuxAAVzhGRri8lUSwZz+e3WrbrfjlGLvuiI30=
X-Gm-Gg: AYBFou1g/1t7b8LFVvmpqs5fqHlk0d1zcA33oSrItLKp3juPNgin0j7RQhUzHWalz1r
	O2Xzu9Vk8EmpU5TMwoe4r6ywjtnK+K3hAHLsi+uxOghHPTBWn5HYALUQT7BCDggTrf2/nw6/Pqn
	Zm9O8TgMD2oVhWXiXS/jFQS6HoMhbnuiwGFuVlXCBjJN09Mtnzznal5WCniX7HzZFaBq+wVoB4T
	k4mfnw5pgmU5CIRsnExeYM/48skj3gM1ao80O1W6+B9BMqvw0DoakSXV9C/80esJfTz7swzpICA
	X8t7XuOiHSt28LWuvzHrq/zDq/8wxniTuR7nXGoy4gFwa4acK5SDLTmThJIa12hhlnrJL593mjx
	ublgL+tdIDSA3SrsKHniHo3jA+tK/HWOq5xPbBzzeTuiTDuZd1jx8k3cJzac+++9Cx0wx+Qz0Df
	mTCroITYa15uO7Q9Ii069f5JsxyMG6sbCVf/uRtx58i/eifNHs2qeWTIzZy6VkHG1zNprRR1Peo
	nM=
X-Received: by 2002:a05:600c:a04:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49cf82621acmr307894995e9.15.1788875622435;
        Tue, 08 Sep 2026 06:53:42 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm377235005e9.3.2026.09.08.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:53:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue,  8 Sep 2026 16:53:00 +0300
Message-ID: <20260908135302.74963-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
References: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
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
---
 kernel/bpf/helpers.c | 130 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..3338bebdd86e 100644
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
@@ -3658,6 +3696,68 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
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
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	return __bpf_copy_from_user_mm(dst, dst__sz, unsafe_ptr__ign, mm);
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
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(dst__sz == 0))
+		return 0;
+
+	return __bpf_copy_from_user_mm_str(dst, dst__sz, unsafe_ptr__ign,
+					   mm, flags);
+}
+
 /**
  * bpf_copy_from_user_task_str() - Copy a string from an task's address space
  * @dst:             Destination address, in kernel space.  This buffer must be
@@ -3681,6 +3781,7 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
 					    const void __user *unsafe_ptr__ign,
 					    struct task_struct *tsk, u64 flags)
 {
+	struct mm_struct *mm;
 	int ret;
 
 	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
@@ -3689,17 +3790,20 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
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
@@ -4924,6 +5028,8 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
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

