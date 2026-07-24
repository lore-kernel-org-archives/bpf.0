Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D5470131;
	Fri, 24 Jul 2026 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932217; cv=none; b=kLyu1pYTks/Uz0QRd3iGkwsjDfQ6V2TcvsIdGpPzB1X8dK6D8kdvtqtVCYHn4pPJtsUW5mAhBrJeVxm3ogf6MCZLxSv9b5J98SHnPEB7B0mxExBg7LuGJQt8+7Ydr7oNxqnPsZtz0Rw2fC+UByv+t2Zc80CJl+YZQE6Jl+8jWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932217; c=relaxed/simple;
	bh=F+4QHVMTdUxWVRG4L1XBerMtnFJQb/EMdPg2rQqLd68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlipCO5xgGg0/x07cdJ1w5t1iaoPI7pDRX1p4HUDKBIhko7ZXykXNfpVneb9c2v0X0fSCYtXqHgzAD4TiAUMjoxU7zd/ajN1xdxOtp0tijZqI8iM2AcBRXWVqCUIa7FOGivoqZC6MecbyD6xZdrLBTrFpUYWrvvLahe2K60P1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=MS9beTn9; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="MS9beTn9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=laFb2+2OJHBjt42yZcZ3hsZQhNcm9lH5QpuUTZr6hlo=; b=MS9beTn9E8RTJJ4e2NxUs4APQF
	lAXN0Zcyhkx0y+7Mtv/RePRaBeHwPGyHKX5pv22oE72E+K3e2CemBHeOJQ9PfLCo/p58tVLwnJIAf
	rV4awksMHY2ke6Lar0t7F7nBQEmsaHCdS4g0vM7Jm8fSYiL9FSVy8o6AWz03JvGdI93FHR8NU6YK9
	PgHLj0T4iLAF9pqDWeSR/4GWTTlGKBm7U70OsI6A75EWGs7LGXi0x4MRr/g4r6Fus+Cfsi3RujiBg
	BE1K/icV7oT4ieExMWcBru/LRH81jK04qt/z40d1zgRltnZXmSiMAEp2LBrmvW4kg0HpsyfNRtfR/
	BoUcWQYQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wnOOs-0000000027h-1eMx;
	Fri, 24 Jul 2026 18:29:50 -0400
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	bpf@vger.kernel.org
Subject: [PATCH RFC v4 07/12] mm: read remote strings under the per-VMA lock
Date: Fri, 24 Jul 2026 18:29:29 -0400
Message-ID: <20260724222934.1463812-8-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724222934.1463812-1-riel@surriel.com>
References: <20260724222934.1463812-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__copy_remote_vm_str() reads another process's memory under the mmap read
lock for the whole copy, and looks the VMA up again for every page through
get_user_page_lookup_vma().

This is the mmap-lock-only form that __access_remote_vm() used before it
moved to the per-VMA lock, and it shares the same contention: an mmap() or
munmap() stalls a bpf_copy_from_user_task_str() reader even though the
string is resident.

Read the string through remote_vm_walk(), the walk __access_remote_vm()
already uses, with a copy_vm_str() action that strscpy()s each page and
stops at the NUL. Bounding the copy by its maximum length keeps the per-VMA
path inside a single VMA, so no VMA is looked up again while that lock is
held.

A copy the per-VMA lock cannot finish falls back to the mmap lock: a fault
that dropped the lock, or a string running past the VMA. Memory with no
struct page (VM_IO/VM_PFNMAP) and stack expansion stay on the mmap lock
path and still return -EFAULT, as before; ->access() support is left for
later.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/memory.c | 111 ++++++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 64 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 273dfe12bc6d..aaf620017f34 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7296,84 +7296,67 @@ EXPORT_SYMBOL_GPL(access_process_vm);
 
 #ifdef CONFIG_BPF_SYSCALL
 /*
- * Copy a string from another process's address space as given in mm.
- * If there is any error return -EFAULT.
+ * Copy a NUL-terminated string from @addr into *@buf, up to @len bytes,
+ * stopping at the NUL. strscpy() always NUL terminates, so recopy the last
+ * byte of a page when more pages follow. A string is never read from
+ * struct-page-less VM_IO / VM_PFNMAP memory.
  */
-static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
-				void *buf, int len, unsigned int gup_flags)
+static int copy_vm_str(struct vm_area_struct *vma, struct page *page,
+		       unsigned long addr, void **buf, int len, int write)
 {
-	void *old_buf = buf;
-	int err = 0;
-
-	*(char *)buf = '\0';
+	struct folio *folio;
+	int bytes, offset, retval;
+	void *maddr;
 
-	if (mmap_read_lock_killable(mm))
+	if (!page)
 		return -EFAULT;
 
-	addr = untagged_addr_remote(mm, addr);
+	bytes = len;
+	offset = addr & (PAGE_SIZE - 1);
+	if (bytes > PAGE_SIZE - offset)
+		bytes = PAGE_SIZE - offset;
 
-	/* Avoid triggering the temporary warning in __get_user_pages */
-	if (!vma_lookup(mm, addr)) {
-		err = -EFAULT;
-		goto out;
+	folio = page_folio(page);
+	maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);
+	retval = strscpy(*buf, maddr + offset, bytes);
+	if (retval >= 0) {
+		/* Found the end of the string. */
+		*buf += retval;
+		folio_release_kmap(folio, maddr);
+		return 0;
 	}
 
-	while (len) {
-		int bytes, offset, retval;
-		void *maddr;
-		struct folio *folio;
-		struct page *page;
-		struct vm_area_struct *vma = NULL;
+	*buf += bytes - 1;
+	if (bytes != len) {
+		copy_from_user_page(vma, page, addr + bytes - 1, *buf,
+				    maddr + (PAGE_SIZE - 1), 1);
+		*buf += 1;
+	}
+	folio_release_kmap(folio, maddr);
 
-		page = get_user_page_lookup_vma(mm, addr, gup_flags, &vma);
-		if (IS_ERR(page)) {
-			/*
-			 * Treat as a total failure for now until we decide how
-			 * to handle the CONFIG_HAVE_IOREMAP_PROT case and
-			 * stack expansion.
-			 */
-			*(char *)buf = '\0';
-			err = -EFAULT;
-			goto out;
-		}
+	return bytes;
+}
 
-		folio = page_folio(page);
-		bytes = len;
-		offset = addr & (PAGE_SIZE - 1);
-		if (bytes > PAGE_SIZE - offset)
-			bytes = PAGE_SIZE - offset;
-
-		maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);
-		retval = strscpy(buf, maddr + offset, bytes);
-		if (retval >= 0) {
-			/* Found the end of the string */
-			buf += retval;
-			folio_release_kmap(folio, maddr);
-			break;
-		}
+/*
+ * Copy a string from another process's address space as given in mm.
+ * If there is any error return -EFAULT.
+ */
+static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
+				void *buf, int len, unsigned int gup_flags)
+{
+	int bytes, err;
 
-		buf += bytes - 1;
-		/*
-		 * Because strscpy always NUL terminates we need to
-		 * copy the last byte in the page if we are going to
-		 * load more pages
-		 */
-		if (bytes != len) {
-			addr += bytes - 1;
-			copy_from_user_page(vma, page, addr, buf, maddr + (PAGE_SIZE - 1), 1);
-			buf += 1;
-			addr += 1;
-		}
-		len -= bytes;
+	*(char *)buf = '\0';
 
-		folio_release_kmap(folio, maddr);
+	bytes = remote_vm_walk(mm, addr, buf, len, gup_flags, false,
+			       copy_vm_str, &err);
+	if (err) {
+		/* The contract guarantees a terminated buffer even on error. */
+		((char *)buf)[bytes] = '\0';
+		return err;
 	}
 
-out:
-	mmap_read_unlock(mm);
-	if (err)
-		return err;
-	return buf - old_buf;
+	return bytes;
 }
 
 /**
-- 
2.53.0-Meta

