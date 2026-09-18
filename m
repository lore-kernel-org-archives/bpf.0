Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743B3D7D8D
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722684; cv=none; b=Xr0HhLUfDEiWQRZ36ntMypduLSTA0LWHohJCTi4Esdqo1SqX2D3F6xjwLNxCgyVJxaBlpTXlYfzlEfy3NBrWLM42mnTINPqiXwklpmcHrj8cNn2mkVy1jV/U4Y64nA5pIf/7vEeYeUGWMw+l1kACPCmPLMjvWvDVxl7xOQht+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722684; c=relaxed/simple;
	bh=STCzW5M5EW9uUQOkS2hfX2s5skhk+EdAa196HwCnHIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWhsApCI4SO1Sx1ePVnyLzZEk1+XDZxtvWMFlEcPMNG3zIN3RVGxEd4zzyBv/7clOKIGh7MHp18OEqJ5nt3rPDuoJmYjjfwKOqwas4zo7QMhto7Kk116k9tYqx9dAV8ZKzs+NSbaJGhsr8ICbk0UBqFxCUSRChP6Jl605652HRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8JLc1jQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8JLc1jQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so347210f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722680; x=1790327480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQCtz3oTX1YW2gbSF1mQxat1U/wMyPCcu5DDLW4b9vc=;
        b=r8JLc1jQt3xPiJ8pi+YFdOJ+gtJwCqCrmCqxXmopJ2/Y9POVZfPrMFSS5VB5YgQLtC
         HaMZRC1GJ647DR/tr/RDKqsYGLsjAhY/9xj0eqjGIx+TSDw5ForgfB1mxuFXYNITIabD
         T+mIsPcwohV1HH1scQNQ2Vugw9XGevsMG+vrwRHNc/xhZPkdslCPVOWNUFtrtwmHgcrT
         1M17iwqa6N4y0cy+0FztzJGPBC9qVqO/QBFdxj+J6hLEdNj6OK1p1iAsTr9ALJ5/q9+G
         CBuJqZkQoAwDPxeckNL1caB2rMWsU/BTujFeT6KaBvq7g1Kg+NP3RzlveWwxgnt6NVBq
         RK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722680; x=1790327480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQCtz3oTX1YW2gbSF1mQxat1U/wMyPCcu5DDLW4b9vc=;
        b=RfO7nE4RhCPG1aWyOjYQbYcfxmUIxLmMPvjOrwBq77/OfhdRzLglTTX7ZCJlZCX2YQ
         xgDMFqwy48ddBHTjuH1I0tffT6RBfIrg7sHYPVxosyF9s+hejOsitd49tRd8n5g7KbCV
         YBfghiZqzSjPfQoUhNHd2B4gjeGtLVr+8EABnWKWqWllyQLQ0qV+u0jKe3WdT8YbGrlF
         AK3XuTWvK8JPCDU3r6iN406YOxFfGS0brS40B21v9+hQg6YtWd8wQw04gEK46c7GjUN8
         2wd6Kj/yMPxqL9anywAJIObdmu4D7KRnTHdBfONd4/tfIqCvf4zItPy8cDfKL2w6z/O7
         XLMA==
X-Gm-Message-State: AFuF++nJbguylqgMVGXklMock/MKBoG9qerNId/Ns4/AKokVYu/hZBq9
	WQeUm5vhVNP/yTVke2a6CnD5U6Vq9vSxxp59GGNhgVl2JwwWM1O67tS+f2PqvZ9o
X-Gm-Gg: AYBFou0z0ZKoQ+Dp4K65Zjto9SIqB+qYj2fHJpmwgYMg4CwiUyTsC7MwvEpVNT3ODm4
	dHNCjofYewFCCsOWqBoDYbA8fDZ86cDUf7KOmA/LOgl3rfGQDGGYqdgNgY3K8TNrWqQdMtIISuN
	wgW9+idBKvzrYjGjptGfWohuo9TEtdQFPAbtmV6ij3cDz/QGFJohkt+RLyv2zzHgGE4UiDO8rp+
	Lzm4gT4Zxp8CTR4PndDxsMCpdjk8kiebRpk5S97PECXuvWFoVyyXnbrEPrzA7THiAUJmHtttd1r
	lfWjCtRIHK5oPK/sDORqsZWDyoFQ5fViec/B3cnbrPZ3wA95RxhwA3FozVK6uxfApyRpVy4tBte
	W/7RnBCSqgDjwBhE9yZJUoNvtLLRl0MvqkMwRmjmVsoW/b0jLlTHBCWtORQhcqsekAuTRX06XYh
	fkKfBbqqbEqCjF35qNYgfTdQKgQnDdjI3vTKqGUbUgcB71YT7Re1eanM0JUW4ZUXVZZ/rFyrTe2
	TO7cVmY8YgKME8=
X-Received: by 2002:a05:600c:4e89:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49fc5681267mr21914985e9.1.1789722679822;
        Fri, 18 Sep 2026 02:11:19 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 1/5] mm: Add copy_remote_mm_str()
Date: Fri, 18 Sep 2026 12:10:54 +0300
Message-ID: <20260918091058.297740-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h |  8 +++---
 mm/internal.h      |  3 +++
 mm/memory.c        | 43 ++------------------------------
 mm/nommu.c         | 43 ++------------------------------
 mm/util.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 86 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..63f40e615754 100644
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
+		void *buf, int len, unsigned int gup_flags);
+int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags);
 
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
index 8b0c2c735d3d..fc6933d7e9d3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7326,13 +7326,12 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(access_process_vm);
 
-#ifdef CONFIG_BPF_SYSCALL
 /*
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
@@ -7408,44 +7407,6 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return buf - old_buf;
 }
 
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
-#endif /* CONFIG_BPF_SYSCALL */
-
 /*
  * Print the name of a VMA.
  */
diff --git a/mm/nommu.c b/mm/nommu.c
index 498e01ee40b0..9a810c35e7e9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1741,13 +1741,12 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 }
 EXPORT_SYMBOL_GPL(access_process_vm);
 
-#ifdef CONFIG_BPF_SYSCALL
 /*
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
@@ -1782,44 +1781,6 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return ret;
 }
 
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
-#endif /* CONFIG_BPF_SYSCALL */
-
 /**
  * nommu_shrink_inode_mappings - Shrink the shared mappings on an inode
  * @inode: The inode to check
diff --git a/mm/util.c b/mm/util.c
index bf0513d1d3d0..47c2e3ae8496 100644
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
+		void *buf, int len, unsigned int gup_flags)
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
+		void *buf, int len, unsigned int gup_flags)
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

