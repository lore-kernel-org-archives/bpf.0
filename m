Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC844F4047
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737507; cv=none; b=KZN0m+OZi/0AlkKBaSJHteYwn8oaZWRDYYwT2ThjnvNHN/fR3Suh/zVlT2AY+A2bU/K4rS5PhaNtn6TeGnuEteq/ASlWRztsAHSg/gLTKuTRsilr7UvjCnSOA/oWwMnj/9cqIjhUExuof6eSm8LyI46spU+OEQfa7qzxYsLJRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737507; c=relaxed/simple;
	bh=BBkVEhkLLbXu5qOdrjGK2WS6zCi3TkNNq5NU2ke1u48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OErWGV+iRHDxEYBA9uTQA8WxTXf7zKIbRmhX0sBGC5iTzWptoBYjtHfiaWmX+dY06j1ZOJmgBim6xkzpFJqu4LcdnOF2WCwuHfjQ2R/yF4LfRnf9hBy7yFNoFP1Jr1+12pBfpIej26dmAXzz3AHBUDKczA3pufnSs0QbZIWfAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS0Zn17p; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS0Zn17p"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so392770f8f.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737501; x=1790342301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBI8Vei6mUKThCIHcgGdefIiyo76m+YulL+4eF81XBA=;
        b=mS0Zn17pFo82XJZ/3cXmc3LQnwznkNaViVpZ8i/Qxca7+X2RUiDRzVYEYJym1Vpm5E
         xN1FB0JqOZNShKC67aVYIXxSzlnt5d6+DcGIz2dc4Co2/tjCpaxcNXE3sfSGHAoByOzI
         zsHm33ITd/ByFkytXWEteWLHTXCK5Uyrh1lz/m3AldXlybQkCSER5zMWzR+abTYmcwqP
         yDWiqdCKsdJg+OU527afEcZpHvwsCEIPw1VQE82ZL1M+MgtG4oJg5VnxoCJ6V5rdrnGS
         Qcr9Mf+pcXdlmZBN5sPfQfDG2PkBHejO65HjZXJacPDrPl3GZx/N46FVsKd6OwqtiNQh
         81Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737501; x=1790342301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBI8Vei6mUKThCIHcgGdefIiyo76m+YulL+4eF81XBA=;
        b=ExeSYwm9iMNu+1tLSgLhuGAdqLqaaCRuB6tkvOeGLbnDNSsxuXC6fnjoCWGDKwvojs
         X57bEGAJKkvfJAop5J1S2OAgKQU6jswDGUqAXcvhI+0+4pTXfCoenKtecvSBiEd9pSFw
         8M56fAzh4Fzntkxae4vThqhkZHDLstKQ7teAsSXpReOET7z2PJ0nqrDn5Z9WLSCKJtUW
         qXAIsjcEYEroZuTYh9HIq77u6zMZTSJgwAAtxaeCnVnZAdNWRJA1p/kV3m/Yhe7nJd3U
         mAeBLL5/w2mRIpJlS+tWPIyM3RvTMDaPvT8PktvFj9oBKsMphgvpAqSFM1BjqU96T3He
         XAsg==
X-Gm-Message-State: AFuF++lDFFF3UPzozjQ3KcB/pHlQYaialSbcMRl2DjYPYhBKtZ9fmdW0
	khmlnhyqzHtPIt2AN45RTHR4fb2a5qb3KDnIZ/UWpw5Z8GDAWmyjDQq2O5eNF0sF
X-Gm-Gg: AYBFou3aSJNsUpc4C7d1JwQlER7W4ZAkdHOuTOyelOqkJ0l5uksv85VzQxdrVg2S3N1
	FZoO+wNAxtpCKZke3bGDZJWBhu67W3Cv4WWi96nHFJmjfVDlNqeGaKlCSpmsfRR6d5yp77o/T0K
	oBEmvwF7TA26vwC5XAeZ0xxMl8Om7aFDl1SNon9hHzm7bF13NZuYlNM1CT56eQNew5MQzsaJHkJ
	53BN6vVVNkV7VKjKHBBcH5/XwCSUKpO96S2tjIhvYEEaCP8s7VQoa4rGqLMmPff1+KVZHU+u4sl
	1h5Ts/twdeTT7mY+jQvHCrYjlDTkdE03E4C7wI6RkhXtv6ZOecGVDVOnDPyrL5WMVjJ0T6WJ8Rz
	KzYiXu1PPtdrZr6LXJgaQGVj19e3TdzCgBHeqbkINfd16seVVju+D7g8cv+cRl7veUgN1GIvuFg
	v1rE2PzyXC5CI/FDV/qf6k6L2TY4NA2OD/1BGaqLKyHyADcCXSQ+BO17HYy4nWpB8Ptzq2YpeuE
	SRPRpDRQDXHT+s=
X-Received: by 2002:a05:6000:26d2:b0:487:ae2:4d01 with SMTP id ffacd0b85a97d-4871e36cff7mr7099900f8f.22.1789737501308;
        Fri, 18 Sep 2026 06:18:21 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 1/5] mm: Add copy_remote_mm_str()
Date: Fri, 18 Sep 2026 16:17:53 +0300
Message-ID: <20260918131757.42802-2-tasos.papagiannnis@gmail.com>
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
 include/linux/mm.h |  8 +++----
 mm/internal.h      |  3 +++
 mm/memory.c        | 43 ++-------------------------------
 mm/nommu.c         | 43 ++-------------------------------
 mm/util.c          | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 86 deletions(-)

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
index 38b1165212c9..7c326965a94f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -25,6 +25,9 @@
 struct folio_batch;
 struct hstate;
 
+int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		void *buf, int len, unsigned int gup_flags);
+
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
diff --git a/mm/memory.c b/mm/memory.c
index 8b0c2c735d3d..fa819a8a1df6 100644
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
+		void *buf, int len, unsigned int gup_flags)
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
index 498e01ee40b0..68b05565e15a 100644
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
+		void *buf, int len, unsigned int gup_flags)
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
index bf0513d1d3d0..75c0fc2061aa 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1061,6 +1061,66 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	return res;
 }
 
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
+
 int __weak memcmp_pages(struct page *page1, struct page *page2)
 {
 	char *addr1, *addr2;
-- 
2.55.0

