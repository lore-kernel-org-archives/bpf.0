Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836128E23
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607931; cv=none; b=dEFNK1rVseG7aKncgFs3xoLdol/01Xd7KrrYUd/9QixpwwPmZBi6aGJnC73TeFpdvXcYN/EMPhClI6KYNizABGP5GBzACVWbfXwIR93772KyPeEE5WfBeyMCm4hzrdBZErX7yiuPVxk7PYo8rTFUzk0GxUbRcDbG9A6LCgFZiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607931; c=relaxed/simple;
	bh=mQm1TKX1KGkYH86qkFGrbMrnPi6qxDVtoAHsHxu5Lps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQ/g3MeZUF/r1NruNd+Cc9RUZcvQCuJvhTO+MsNqKcatGLRwPWb8STzPY8/u86sIAQbAs3EB4MiVErOH5KuE8HqCf+/0ev6qbUNwE3cD2x0UAs8S8yF+u2rY/uitaJgB0kkyK5vDcWgh6cpTv29LZWMFE0zdt7EtbKZ1wT0NZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjrudiQN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjrudiQN"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e56da425b5so249767b3a.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 19:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709607928; x=1710212728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3Uab1G5GTmyRpRg7HZiDcHzBw+gqXSTLydz3NAXDjw=;
        b=OjrudiQNScLdJVmGuBXr1/O0NR0wZu0YZ9PZP9iCAWdrtDPY6smx75vdn7+MEWEPGV
         hqEPuiEXv5o2amnWO17kYXONBm3yVtRCQNjfEkFiMgOMB0tj1jqgtrAvR+ZrI9IvSHHE
         sD4duXG+Csyz64jBD0VQJdJQ2rYcdw925ZduHp2E9IQRK1ssNJkIu1bLionx8AcmPlbF
         hKrIaZJ//xKlSZD67FIJV8FEd8xdWb1yVEv5lpPG8xTg+iy16gSoglXSSMApMbXzAo5e
         p7V3Bd08jURq23BB1DmEw31WBTvHgethuRYvPBxwctnuLjv5Gt/iZ+jqNFwLimB4jYkq
         TWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607928; x=1710212728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3Uab1G5GTmyRpRg7HZiDcHzBw+gqXSTLydz3NAXDjw=;
        b=UY1lyP7ZVbVWh84ktP8qtHUUEWz/lxS2KJ99crwtgLqyP8fIec40uhVnzVezavHmpt
         DjYOmha8OHc9Q7yPfjaXytmbOcuXkd67/FdUzqe2/M2JwJR57gQ+9QL6XgOr/85tqKFg
         v/pDv+89VrVzHw7IrYsif29rRUbk2DJYb+rriucVLxHBYmj8tpi9fGmcJOMSMtbMavbg
         71EM9V4f28oD6k+SHro/IzA1nvj0yrrwOvKoXwoTIFZg2PiCkxYvDwabxB5KCiPMqilz
         fEMkH2Bia4KIW9v9YVqdNiAg8/Zutu0J/dOQCJnhLhPVgXLmK44K9PfJ/B/eEJSGqMKK
         qSlg==
X-Gm-Message-State: AOJu0Yw+pAAMGd4BnznWJhQUreYGcRkwROQuAulsXhJwII3mxXQGfzll
	s1KSfqMPKT0npEwYqtsCm+JNdioHxl4lQgh+7DwRpHnkk3OjVHSneYnXLKlN
X-Google-Smtp-Source: AGHT+IHbzyFXZDmwTFXKOBQzhI/J5ZF4BBhSMJWYsXowuh6pvkssrM9sK35Jd24futLM3qVbKmDLRw==
X-Received: by 2002:a05:6a20:1da:b0:1a1:4d41:3570 with SMTP id 26-20020a056a2001da00b001a14d413570mr470241pzz.59.1709607927721;
        Mon, 04 Mar 2024 19:05:27 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id ep2-20020a17090ae64200b0029932d175c3sm62083pjb.0.2024.03.04.19.05.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 19:05:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	rppt@kernel.org,
	boris.ostrovsky@oracle.com,
	sstabellini@kernel.org,
	jgross@suse.com,
	linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
Date: Mon,  4 Mar 2024 19:05:16 -0800
Message-Id: <20240305030516.41519-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmap/vmalloc APIs are used to map a set of pages into contiguous kernel
virtual space.

get_vm_area() with appropriate flag is used to request an area of kernel
address range. It's used for vmalloc, vmap, ioremap, xen use cases.
- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag.
- the areas created by vmap() function should be tagged with VM_MAP.
- ioremap areas are tagged with VM_IOREMAP.

BPF would like to extend the vmap API to implement a lazily-populated
sparse, yet contiguous kernel virtual space. Introduce VM_SPARSE flag
and vm_area_map_pages(area, start_addr, count, pages) API to map a set
of pages within a given area.
It has the same sanity checks as vmap() does.
It also checks that get_vm_area() was created with VM_SPARSE flag
which identifies such areas in /proc/vmallocinfo
and returns zero pages on read through /proc/kcore.

The next commits will introduce bpf_arena which is a sparsely populated
shared memory region between bpf program and user space process. It will
map privately-managed pages into a sparse vm area with the following steps:

  // request virtual memory region during bpf prog verification
  area = get_vm_area(area_size, VM_SPARSE);

  // on demand
  vm_area_map_pages(area, kaddr, kend, pages);
  vm_area_unmap_pages(area, kaddr, kend);

  // after bpf program is detached and unloaded
  free_vm_area(area);

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/vmalloc.h |  5 ++++
 mm/vmalloc.c            | 59 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..0f72c85a377b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -35,6 +35,7 @@ struct iov_iter;		/* in uio.h */
 #else
 #define VM_DEFER_KMEMLEAK	0
 #endif
+#define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
 
 /* bits [20..32] reserved for arch specific ioremap internals */
 
@@ -232,6 +233,10 @@ static inline bool is_vm_area_hugepages(const void *addr)
 }
 
 #ifdef CONFIG_MMU
+int vm_area_map_pages(struct vm_struct *area, unsigned long start,
+		      unsigned long end, struct page **pages);
+void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
+			 unsigned long end);
 void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f42f98a127d5..e5b8c70950bc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -648,6 +648,58 @@ static int vmap_pages_range(unsigned long addr, unsigned long end,
 	return err;
 }
 
+static int check_sparse_vm_area(struct vm_struct *area, unsigned long start,
+				unsigned long end)
+{
+	might_sleep();
+	if (WARN_ON_ONCE(area->flags & VM_FLUSH_RESET_PERMS))
+		return -EINVAL;
+	if (WARN_ON_ONCE(area->flags & VM_NO_GUARD))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!(area->flags & VM_SPARSE)))
+		return -EINVAL;
+	if ((end - start) >> PAGE_SHIFT > totalram_pages())
+		return -E2BIG;
+	if (start < (unsigned long)area->addr ||
+	    (void *)end > area->addr + get_vm_area_size(area))
+		return -ERANGE;
+	return 0;
+}
+
+/**
+ * vm_area_map_pages - map pages inside given sparse vm_area
+ * @area: vm_area
+ * @start: start address inside vm_area
+ * @end: end address inside vm_area
+ * @pages: pages to map (always PAGE_SIZE pages)
+ */
+int vm_area_map_pages(struct vm_struct *area, unsigned long start,
+		      unsigned long end, struct page **pages)
+{
+	int err;
+
+	err = check_sparse_vm_area(area, start, end);
+	if (err)
+		return err;
+
+	return vmap_pages_range(start, end, PAGE_KERNEL, pages, PAGE_SHIFT);
+}
+
+/**
+ * vm_area_unmap_pages - unmap pages inside given sparse vm_area
+ * @area: vm_area
+ * @start: start address inside vm_area
+ * @end: end address inside vm_area
+ */
+void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
+			 unsigned long end)
+{
+	if (check_sparse_vm_area(area, start, end))
+		return;
+
+	vunmap_range(start, end);
+}
+
 int is_vmalloc_or_module_addr(const void *x)
 {
 	/*
@@ -3822,9 +3874,9 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm && (vm->flags & VM_IOREMAP)))
+		else if (!(vm && (vm->flags & (VM_IOREMAP | VM_SPARSE))))
 			copied = aligned_vread_iter(iter, addr, n);
-		else /* IOREMAP area is treated as memory hole */
+		else /* IOREMAP | SPARSE area is treated as memory hole */
 			copied = zero_iter(iter, n);
 
 		addr += copied;
@@ -4415,6 +4467,9 @@ static int s_show(struct seq_file *m, void *p)
 	if (v->flags & VM_IOREMAP)
 		seq_puts(m, " ioremap");
 
+	if (v->flags & VM_SPARSE)
+		seq_puts(m, " sparse");
+
 	if (v->flags & VM_ALLOC)
 		seq_puts(m, " vmalloc");
 
-- 
2.43.0

