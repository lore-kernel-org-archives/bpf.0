Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277685437F2
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875627; cv=none; b=mqJtHBWNLPsihtZViNF7T1muqu7YL7KcOR2uWoMrAZsJSepXMqLtNwgHLk8fAxVKfUUEc/nscE15A9MsQayHETQ2m5EBQonh80aADwH9mfcdPete1AmRrHhEQfoRvvlvWxcx7FO4tE7JdHXjkhiuuDWGqvMJQaTyUgQ69G0Inyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875627; c=relaxed/simple;
	bh=QS7NkuiG/C1KyxRAh++o8gjnFJZ4G7rjZwi8eIE4fDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/IHJ8A2QP7VxTe8dnPh7kWonDZyXi2ex+K8h6czBTi7gumnff6K6FQvB4tb6TxrVsNtWeV2UOwSETz2Tq/hnFMPiaBPT1w4cjeSCC9G0HgviR4w641jh9WhbJUfJmuUuzLs4y0o3SdF678W+4h4qBOQc/01nk4h6+jGmJUG5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfVhsLvX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfVhsLvX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso41201085e9.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875618; x=1789480418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99poktiSHLiETVfeHxyXac9wEwytCbkoCCeCU8LCmbQ=;
        b=JfVhsLvX/rO/oROxvDeGrH69Q8eg5LWWHCFfpZFd8IvlPvw/2cG3/crmLTrnhZPSSr
         vZASEjtohEnOzzAqo3JlcjECXdspS9hgqb14w5ha/CkJBxnhphODh3XhqrpcpTkYW2zN
         YuQq3ihr1/yo8x24BBSoMmZ3+jzYdrqHJOfOfSIy5uIBIcivkha4D5l2pFnd6FOs9GP/
         dQ8+E9OULV2j3R9ZO9RiOYwa9cQCN3nbQxdtAIBhGOwjuShVjVZbaYTdh96F9fsjLFO3
         O8xkqE2DH9/0TfbQttZo0RVjgt7Ee1jUtrZsOceGKOfQloOwQReNiq7+26KcNb8cDbYz
         vK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875618; x=1789480418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=99poktiSHLiETVfeHxyXac9wEwytCbkoCCeCU8LCmbQ=;
        b=W9cnP1aDnFxSAMywm6UB0MVOugeeJD3042PC3rr4pwLgszw4brDtI/P7UiJ85z8AHQ
         i4+qA3R57HxAGs4yQiN+uzNGo83tzixfxS9wBxPcz4qhf4h6997eRQjx54wtglQSwoy9
         wpr96kdRT6K0q9BTZ4FKbfMjOVAV7KFC52FPE7XOfUkW1HpggbDNj91aehWe2ph+UoEN
         Gpwgm1gFbNrVmsB89Ss4jLByP2bkIwDwvxeDjLW3HzfRwed8l2FE1EPsqisdbGZuFvjm
         0bVA1cIjcIpindOyOFTJLEL17AKvZclihwYXYM14Ty+ap02TbALGhdTXoopJb7zS4YIl
         BbgQ==
X-Gm-Message-State: AFuF++mvGX5jMyRhM012MoXG/ccIdWLSORAk+FGqKBOGHWV0ngpVcL+m
	y5cWtH0/D2dNc/yO+h17ieYiImGCMSBhLe50kmnojfg/OG49JOIidujqVPOMc8Tbpc8=
X-Gm-Gg: AYBFou2TPHG90iFBufyceefYL3uMt2cs7VGKhlQIrBwm/rCr8dmpufVFhwgCB/ZNGTk
	4Qh+ygh9of4e0HSb8CZSvAVqTl5nkr40486WvpwzdYVvJbnWdjKaJhdZgC8OsMncsfTZIdow7Hc
	uPQZ3RZ9y3CKr14V7tgA/WtoJ6NX5o6EqVetmWZZzXRC1LOPXYBsUl/HviNXNZDSI2vgPBmG+g9
	j0yNJW37NJL8s+XngPiv2oIPzEvlmDxqOfUtiZeTq7dGow+QR7kp9rhT8idPUVfJmNQiCd0OHQt
	Qo7XlJrNMpVM7kLiqKeJ7D0tXC7nEe1tCi5Nw/1cFV19RpmNX3rvACg90Ovmpnm7Gpxety/r5RF
	l9G7kUXo0ZNty73lHvEGJCOtQiJOIaMgJl2k9EMwQDEcCbz+yN1sija+wFnQ04It2IyputiSOCL
	L9T78WqqHZal9D8YTbVjSd2TOVNDAt6NrHrp7vdj2RRNW2uic+QtiEAPnT+WBIdhbNCuMnI/xMx
	spSsVMVr1u4
X-Received: by 2002:a05:600c:5394:b0:49c:fc6c:be0d with SMTP id 5b1f17b1804b1-49cffdc89e4mr232121365e9.19.1788875617546;
        Tue, 08 Sep 2026 06:53:37 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm377235005e9.3.2026.09.08.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:53:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/5] mm: Add copy_remote_mm_str()
Date: Tue,  8 Sep 2026 16:52:58 +0300
Message-ID: <20260908135302.74963-2-tasos.papagiannnis@gmail.com>
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
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h |  8 +++---
 mm/internal.h      |  3 +++
 mm/memory.c        | 41 ++----------------------------
 mm/nommu.c         | 41 ++----------------------------
 mm/util.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 82 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..6f10ce315eaa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3325,10 +3325,10 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
-#ifdef CONFIG_BPF_SYSCALL
-extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
-			      void *buf, int len, unsigned int gup_flags);
-#endif
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags);
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags);
 
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..557b29381355 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -25,6 +25,9 @@
 struct folio_batch;
 struct hstate;
 
+int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			 void *buf, int len, unsigned int gup_flags);
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

