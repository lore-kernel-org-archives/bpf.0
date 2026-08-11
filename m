Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8B43E077
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447368; cv=none; b=QD355WMcFCvlxqPl1YnFYBJYkVqjN3WeRQ7HY8YqjSvtsG0RBawacCWCyfsRiEizh9VcjaHASQSjocLmhFCTV3k19Qb5OWAMyXW5RnUD98F7YZWeKgUEL9J1lIlmgEQcBy7VWWwshp/FAAj1LNyNqdyWMDD8sWU2k7jg9s/1VBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447368; c=relaxed/simple;
	bh=wLw+wL5lOK5ZHxFbzv7hNMRisyZ2gWWpu7JX/Ww1mB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6xyKallA3HaZhvHJQ5/1LCbhWqVnEa2hDzsPvg1xXbZmzEG6AxYkR4203bo624fHdACAu2r96EPKENxN0+SW/WmRy2Jkf+oGc0QqqAoOtxL+X/hTMHcg0mBMrYH2k8bLaaG5JoKzsjCLV/wnkJRSkodxIpNhil4G+ZsF4HS96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ry0r6Tj7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry0r6Tj7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so10093025e9.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447359; x=1787052159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oj+eoknvOaxVg+TzcZeSMNSYsDXOGxOvzczJwlu1YLQ=;
        b=ry0r6Tj7hJUIrbXgcsVrZuj0QeERRGDMZji/eoNIQk3MAVPFE6fYgkmZMsJYQ2rmqS
         TO2qtcHjVNoCbkvGoH62rzcv88mvaqFMAeG760x83pZNyl9nS49SHwr/D0U4JNPpnFyp
         fGn94lLFtmrzb1boiR9uy3HxIg01AAoUDOPME4XjBptYBrPQFYSdqUsoqeIURe8oCHFh
         CEcrC904z1R+8dvjsjaPkyjbP0GaV01GYbPozF/BDFvuX22ANwO7ndXGyMp9AS3fNwD2
         q3pwtNqZUSBgZ9t7S22O9jbfF4lsdP8Twde/CVblT9Ua45AmSiwNwxv1O9Lrw/qOPWbk
         JPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447359; x=1787052159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oj+eoknvOaxVg+TzcZeSMNSYsDXOGxOvzczJwlu1YLQ=;
        b=ToY5zbg5WWjUI3Ob1VmBnfkqKeJ33TLBFEXK/zs6AksVxkLNdHx2Q7ctKyrS8FcQbx
         Mvtq671Y3F+v96pF2y6saiv5LfAboyacOs29AIjrXcdd3QlSiPIyvkZ7OqYfixbjF9/7
         viSiMvKlLjoZtUjMny+HGHRJEkL9Mj6NmREm4vbg+XeIu9gFpmik7A9Nv5Z81jhEUi2r
         B4fV1qHlHaShPeAghRetu43gkL8y+eBhFyP+p7c4P7IZ6Et7K7vFIY4pOGB5xdQQKIlF
         EMJUHM0XXZnqa5iskCmZd/rtMcco7CyKFHmgugonSEcgyJc+qRMS6HjAkfKNJKgOg1/C
         6lMw==
X-Gm-Message-State: AOJu0YyRAePiFlBKRh3q9L6Dy8p5SINNJzA4LRu17ZJLs/0WEDnpbLGf
	3wAqrLVPvknvgurF0Ggfswv4/FfHKDpCJR92PK2JpHuzmDMGw7Zgc89YMmr1q2Ep
X-Gm-Gg: AR+sD100fdJGHNY2XLPTS/eEgIkkEI/RjJg1HX2gC/6QaOQSc+sdt5ssDILYbKm9XxK
	e27LfxKTQjB0dbQYX/bZujfcB0fbxe7icXL29r4R1wPbGDYDEQ6JO0XTv7xcm/i57lQ/2YOGXer
	y2Pjr+BaKF/ekPVnrqs5W+RTQOW7aydheiGFM+2rHVa3WSGfCVPc6BSMj+4YaGOOKzvNyZTDxG2
	VnSBvXtHmO4fGTqn5Cy+nDt/Dlqt8lOq+BunrgJ7gixTKUjXL1NWn7wq2yIBb0j16P//nuDGLdB
	RNbm8VBgqYiQ/EyV528GtRgpcBRsfHylgsYZdSwDaoAc8SRp0ufgSbvEe676fcRUzd7qBe5TrPd
	KgBLPdrFZ4lhxjm9ocrHxjHxtymNbe116XCf1UxY3ru3dne5Av7NrS9TlV7DGCFy9GmERAnK0pj
	GeMMgGTHc9wjnSuMkCZlSlMxkCZhgm2JABXvT7WsNyQF9F6ZUYwGpL7+Hni7Ex/gjwK+NQqUnoX
	smbnJPhecU/c6o=
X-Received: by 2002:a05:600c:4695:b0:499:726a:117c with SMTP id 5b1f17b1804b1-49978494f70mr32371385e9.19.1786447359204;
        Tue, 11 Aug 2026 04:22:39 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:38 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/5] mm: Add copy_remote_mm_str()
Date: Tue, 11 Aug 2026 14:21:50 +0300
Message-ID: <20260811112154.94053-2-tasos.papagiannnis@gmail.com>
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

copy_remote_vm_str() gets the target address space from a struct
task_struct. This does not work for an address space that exists but is
not yet associated with a task_struct, such as the mm held by struct
linux_binprm during exec.

This patch adds copy_remote_mm_str(), which operates directly on a struct
mm_struct.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 25 ++++++++++++++++++++++++-
 mm/nommu.c         | 25 ++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..eede435bf4a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
 #ifdef CONFIG_BPF_SYSCALL
+extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags);
 extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags);
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 6b8280cfc1db..03cbd3b02bef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7218,6 +7218,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return buf - old_buf;
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
+ * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -7247,7 +7270,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index ed3934bc2de4..8fbe6306d074 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1752,6 +1752,29 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return ret;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:         the remote address space
+ * @addr:       start address to read from
+ * @buf:        destination buffer
+ * @len:        number of bytes to copy
+ * @gup_flags:  flags modifying lookup behaviour (unused)
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. Always guarantees a NUL-terminated buffer.
+ * On any error, return -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -1781,7 +1804,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
-- 
2.55.0

