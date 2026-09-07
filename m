Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341B51E424
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799977; cv=none; b=f/FAd3erpY+fN5BznwIhAPo88z44FT3BFw0n1FqQNcMKHP2Jzf2uIkDReBoqL3qosULatRnsHTejP7e6e7TybXi7B53ew3WXe6qnxCE+qEMTqFgHez5SggRavPHnMVyIiIAXyZUbpW5S82+e+QhpYE6aX4CJtuLJIWvbBA2nNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799977; c=relaxed/simple;
	bh=Q0tWSBlQLFk3oEvXn8y4hkhcwkljNZY80ooFvpI2RrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiHSIa7Lnwt5u0MEBi1goZE3nWvgmKxKZg3zHErhlxbeT0tPKM4rIobB798ApyPZhqbcnNmxaIBCu26zQLCxhsorpyTJxYTIDZM6x03VbZDJ2RjIEj7jrMAa//9AP/6fjumd3X7zuQwXJsOUoCH7GLp1Ylegg4nda4EG11M92hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9dAsqCs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9dAsqCs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b965570d7so44257395e9.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799974; x=1789404774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYJwxo5Nb9UiMMNksSdgP6g3PKaxvBMYGoOE/hW9Rkk=;
        b=U9dAsqCsC1Ng7j2pEbxxLUChmGYvpqUervfvREs7heCNRIOn9cu9aMRFNGKnSknHYh
         C2fzC0K9xb39/myBFYeRVx0hBDg5E8IxTeGv8un+Cfc+9Nehw7osc1sVHg5QZOdbPF47
         yfSFYlde+XetyaAago/GAJPiihSea7kU1TF0Sizw2mw0kdeWHTMohDTkWjyqlPed9mm9
         sWQqemLNx+AFhc1cNhBSKi6o5I1gjYYdoPQZEJMDKIAOYPenHBeIjyb9LB2YihTIWlAA
         QKT0rBPph+hU9wAV3xVc1MbGyc5PlG68LUcG2d0ob5Cmh3L36EmrkZOJCC6WZQIsjigb
         s8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799974; x=1789404774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYJwxo5Nb9UiMMNksSdgP6g3PKaxvBMYGoOE/hW9Rkk=;
        b=AjByLAbgJ7ZXwLQz55pLV7v2CNR9u0i/P+kVAsLvXE7P6HJtB7w7ZHhr6uJiZGlCa8
         PqL8lOqfZSKZIbvYlHPt6F6rZ1N7bjyeoZdJnOui8vzDlkFkdXTEhf8G4m9i/HtqjlPZ
         ZU9Fd2spV24RNKD1M7YA6FzRcZvDiuwnqelL2id3c0ud7tkUGK/InDEbnxS5V4zJjA8U
         /0c7HrAzN8zg/MvQPF6Q9+aZKCcpQq9TYyWxmDg6IU9eV8ZL1wPwP2DXAcSqEQQPPiZF
         YQunl524WPuf12K+XME1wzR8sKeRny0trJV1VCv42tBU2S7H2U6Cz2UgX+bUgSu5ybZo
         UaAw==
X-Gm-Message-State: AFuF++k+3cSrhP410V3QVWxMvutepK6c0jFETXknmLvuA+qkvng/y2Mh
	Vh8zvJrvSRZhavczUYoW30kC7r5Rkxb0/Q+GJ7Qj7w8w1incED2tlNRbW2uzseVY41U=
X-Gm-Gg: AYBFou0L58l3KIkSnghfN8sdQI2EedGZo2l8ad0cZUXl5vFk0Es50K9loO61DGDbzaU
	tVay8KS0r28PDYiEg/PenQ6LauuCvJc9Ac2Vkfa738/X6nfAu/egt32Y+yuIpRtGNlbm0W0BVw3
	Q49mQkve6xNkH1e2hc80SLfCFtv+rL6f1gNeLiHXAI1LzdgayydTWyQYHdiBXQvcP76eGqoV0zm
	AoZQPSVec4n5WiIwl/ldFEijh2cblYLof3m5XWZSeLUFx7adEOis5pQ6dBP+yvsBefrjva8SyrI
	vuatpx+A/YaK9EtcfXaIM19NEGJDDaC5ecp7q8/+zHmSyO5vZsndB3++O3fWvuClBRTi2lbd9gz
	SiEik7QDWYfBN9P4IUPV9jP41H3DEF9uJJlYEtV/mHelpMgT2qYHq2+Wc1cEuMx95f1maDVLLyM
	hlRQCAPcFSx1ahamurUSfZMBjeHxm1DU8a4Z9HKPgL7kTFS4dztoPy5VrV87Na1mrxp1zsX45Ox
	g==
X-Received: by 2002:a05:600c:4fc9:b0:49c:fc6e:8cb9 with SMTP id 5b1f17b1804b1-49cfc6e8e1emr209497255e9.29.1788799973392;
        Mon, 07 Sep 2026 09:52:53 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:52:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/7] mm: Add copy_remote_mm_str()
Date: Mon,  7 Sep 2026 19:52:14 +0300
Message-ID: <20260907165220.52431-2-tasos.papagiannnis@gmail.com>
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

copy_remote_vm_str() gets the target address space from a struct
task_struct. This does not work for an address space that exists but is
not yet associated with a task_struct, such as the mm held by struct
linux_binprm during exec.

Add copy_remote_mm_str(), which operates directly on a struct mm_struct.

Use a common internal interface for the MMU and NOMMU implementations
and define both public wrappers in mm/util.c. Preserve the existing
copy_remote_vm_str() behavior, including handling zero-length requests
before acquiring the task's mm.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/internal.h      |  5 ++++
 mm/memory.c        | 41 ++----------------------------
 mm/nommu.c         | 41 ++----------------------------
 mm/util.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 78 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..d5bde1f71a97 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3326,6 +3326,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
 #ifdef CONFIG_BPF_SYSCALL
+extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags);
 extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags);
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..8264a346d18a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -25,6 +25,11 @@
 struct folio_batch;
 struct hstate;
 
+#ifdef CONFIG_BPF_SYSCALL
+int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			 void *buf, int len, unsigned int gup_flags);
+#endif
+
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
diff --git a/mm/memory.c b/mm/memory.c
index 8b0c2c735d3d..fe2f5e988fb9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7331,8 +7331,8 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  * Copy a string from another process's address space as given in mm.
  * If there is any error return -EFAULT.
  */
-static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
-				void *buf, int len, unsigned int gup_flags)
+int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			 void *buf, int len, unsigned int gup_flags)
 {
 	void *old_buf = buf;
 	int err = 0;
@@ -7407,43 +7407,6 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 		return err;
 	return buf - old_buf;
 }
-
-/**
- * copy_remote_vm_str - copy a string from another process's address space.
- * @tsk:	the task of the target address space
- * @addr:	start address to read from
- * @buf:	destination buffer
- * @len:	number of bytes to copy
- * @gup_flags:	flags modifying lookup behaviour
- *
- * The caller must hold a reference on @mm.
- *
- * Return: number of bytes copied from @addr (source) to @buf (destination);
- * not including the trailing NUL. Always guaranteed to leave NUL-terminated
- * buffer. On any error, return -EFAULT.
- */
-int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
-		       void *buf, int len, unsigned int gup_flags)
-{
-	struct mm_struct *mm;
-	int ret;
-
-	if (unlikely(len == 0))
-		return 0;
-
-	mm = get_task_mm(tsk);
-	if (!mm) {
-		*(char *)buf = '\0';
-		return -EFAULT;
-	}
-
-	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
-
-	mmput(mm);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(copy_remote_vm_str);
 #endif /* CONFIG_BPF_SYSCALL */
 
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index 498e01ee40b0..98596e60311f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1746,8 +1746,8 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  * Copy a string from another process's address space as given in mm.
  * If there is any error return -EFAULT.
  */
-static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
-				void *buf, int len)
+int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			 void *buf, int len, unsigned int gup_flags)
 {
 	unsigned long addr_end;
 	struct vm_area_struct *vma;
@@ -1781,43 +1781,6 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	mmap_read_unlock(mm);
 	return ret;
 }
-
-/**
- * copy_remote_vm_str - copy a string from another process's address space.
- * @tsk:	the task of the target address space
- * @addr:	start address to read from
- * @buf:	destination buffer
- * @len:	number of bytes to copy
- * @gup_flags:	flags modifying lookup behaviour (unused)
- *
- * The caller must hold a reference on @mm.
- *
- * Return: number of bytes copied from @addr (source) to @buf (destination);
- * not including the trailing NUL. Always guaranteed to leave NUL-terminated
- * buffer. On any error, return -EFAULT.
- */
-int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
-		       void *buf, int len, unsigned int gup_flags)
-{
-	struct mm_struct *mm;
-	int ret;
-
-	if (unlikely(len == 0))
-		return 0;
-
-	mm = get_task_mm(tsk);
-	if (!mm) {
-		*(char *)buf = '\0';
-		return -EFAULT;
-	}
-
-	ret = __copy_remote_vm_str(mm, addr, buf, len);
-
-	mmput(mm);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(copy_remote_vm_str);
 #endif /* CONFIG_BPF_SYSCALL */
 
 /**
diff --git a/mm/util.c b/mm/util.c
index bf0513d1d3d0..2eca27b02791 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1061,6 +1061,68 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	return res;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:         the remote address space
+ * @addr:       start address to read from
+ * @buf:        destination buffer
+ * @len:        number of bytes to copy
+ * @gup_flags:  flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
+}
+
+/**
+ * copy_remote_vm_str - copy a string from another process's address space.
+ * @tsk:	the task of the target address space
+ * @addr:	start address to read from
+ * @buf:	destination buffer
+ * @len:	number of bytes to copy
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	if (unlikely(len == 0))
+		return 0;
+
+	mm = get_task_mm(tsk);
+	if (!mm) {
+		*(char *)buf = '\0';
+		return -EFAULT;
+	}
+
+	ret = __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
+
+	mmput(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_remote_vm_str);
+#endif /* CONFIG_BPF_SYSCALL */
+
 int __weak memcmp_pages(struct page *page1, struct page *page2)
 {
 	char *addr1, *addr2;
-- 
2.55.0

