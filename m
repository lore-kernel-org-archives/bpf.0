Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61313C1985
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179434; cv=none; b=RjsmAcWq+7SZxUS6+VUE/Qg9B5t9UftRVC3NvQZCBiryX2CU4VGUjjZS2jTh+m77+5OZjglO9vxtWm2VNFFG+kldLHmfPf2uttrFgjPURwhFQMIUE38e7AMHa1dswMSdkL9sWhb63vwcnOYLpPhYYeNKp49406HFqMSVsFUJlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179434; c=relaxed/simple;
	bh=rBeAhUZBI4DU+8ypY7JzZ5gBzhHrMIQHDp3MrVWvafo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaKlhA8gGLoE2EiuxEL0fI5YbvkPzjrmVlDP4XRA1A3XaN6O91GjWWGh2jEoiQHWdBoNZtpZcAQAMu1flqhOTdyrF2x2HCpwPwnrXet0iMdlNZ0t5UtAuau+XVnc+oyr2+ezbWNiaV1nbSaKRqF6x6uTvi8zAv/AT8omZydmdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SHxywELE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SHxywELE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e95bd1c14cso1534375ad.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179430; x=1792784230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxGrEQJvo9udDPogIDwCH/j7y+lcv5ffeeEE8r9Dr44=;
        b=SHxywELEDk3dG5VxyLJR0/UgwjzOY6W54Gvhv3m7nDS2ZijtkPPYriX6/Owx9o3BST
         7rMVoR0HjONaZ/8zhiRUUdeTBRtXwtGQc80OrOofcFNvTSAlRYCUFQYV5y1Y0J0MEH0k
         hnig7+5Tm2hIFK3RKCnFOSPGpPfHZVMDZGBsiKleZMJl5bbQmAYpQOWXqMh/01MKtIMD
         3qabzSKm651odtd4TyljeClfg/zaMRHSOdJ0rByI07DSF21ml5ulFDQwNP+NLCUw/G40
         4J2ifileZwgJXQUIOiV1oNg9onP4XnaiKKNDR9Vki/7X3N49lIEPe3R9Nv1hv7fY2ra2
         lv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179430; x=1792784230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxGrEQJvo9udDPogIDwCH/j7y+lcv5ffeeEE8r9Dr44=;
        b=094XQX21CMalgBBELXEIe5qeJkQSQ0ryfvuQvNaCwGrPD+v7H1SIbSYjrDaxZ2YGro
         2dlgiZQFexG8EIW13C1Y2N+sCihGw181UwsQtk/1Cum4/sdJK+kXROY/tFZvCTwKtK96
         pWhcCqbLtqkyZaNdMEbO0cS6Ydxt8pYtYZuMZS1IQw7VIdLQxmVJiXbfOOisIPxDOMfd
         X/6MCBI0iSju515ORABxjOe8MWE8FSkpPsc3nSVrDu+3XBb2STPyWSCW5aOYFD6TXYfY
         6zMc2NdpWJhFNJJ/kWusAt5PGTU6dNeyydfmf8SuED61R9Q/SJ+NaDdZq3OOWi+XWc4J
         A/xA==
X-Gm-Message-State: AFq9FYJjVveMxbVeOUvG3k2tWyofdKyhLgyTn5YaoDb/chbkyvy/xg51
	QmKBAc2sd+/ybaD5/AS38XgI6Z8vRt8YIEQMibWkUQgRdKlSOIUX4aWM4kY+juJSHIXVbxhvf5V
	YWanppJYi6A==
X-Gm-Gg: AYBFou2tjQx83I+EfOY7WQ/CB89Fb42SlQHzMRgkMlVmPg2ohTZYLtjHDbmxrSBifJi
	YMpcqqJcMV9qim7fbQZQr82GfWoSPfmaa/dVPGxonnzXppc0SLkJk2rBK9uUKwK2zUZ1QH8VEu8
	ZpFPyaJQHcKyQsVDYP42mU3FCxj6jvK6sClamNpN/sw1/KN2gTOVhnvMpSarNsqaPu4YjbTVbgB
	RpNdRP6tWfyhW9A8/ApIrq33TLptptwwmnETJzUcR27sID9W+RfT/v5kw7SvgdXbHhkni9Wa++I
	tREFh4xxQBDKrpl+QE3gbL2wApYAF9OI6wRaxIqVVWMabJxu6ekJ46bag1sBR0i50QXPRllj5Zj
	bTSG6XpWtCvgDTo1cFojK4sj4rDtCeD9kAwTrNYPdVvUW8vvFUcXllSxDwosWAmHNjN5yq0MWEP
	k1UhqTh3Yotogu6Zx2ydlcZZsh7o72xf6QPZH+cwCKsbUvDC5zLqgsknpA4s57/Y/v51tSm+Txo
	u9sN161sbJ+NpPmOYzrSckFYVO/vjUe5FaUwKoz+gZuG5c=
X-Received: by 2002:a17:902:ea03:b0:2e9:a23b:643d with SMTP id d9443c01a7336-2e9a6c0a75bmr8745765ad.35.1792179429704;
        Fri, 16 Oct 2026 12:37:09 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm14970045ad.68.2026.10.16.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:37:09 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 2/5] bpf: Revalidate faulted arena pages before installing user mappings
Date: Fri, 16 Oct 2026 19:37:00 +0000
Message-ID: <20261016193703.9203-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016193703.9203-1-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user fault on an arena pins the page that the kernel arena maps,
drops the arena spinlock and returns the page to the core fault code,
which then locks the folio and installs the user PTE. A concurrent
free can clear the kernel mapping in that window. The page reference
prevents a use-after-free, but the fault can still install a user PTE
for a page the arena has already released. User space and BPF programs
then see different memory at the same arena offset.

Close the window from the fault side. Take the folio lock and recheck
under the arena spinlock that the kernel mapping still points to the
pinned page. If a free removed it, drop the page and retry the fault.
Unlike the lock failure handled by commit 0b10b945479c ("bpf: Fix
mmap_lock deadlock on arena lock failure"), drop the fault lock before
returning VM_FAULT_RETRY, as __folio_lock_or_retry() does, unless
FAULT_FLAG_RETRY_NOWAIT asks to keep it. Faults that cannot retry get
VM_FAULT_NOPAGE and fault again.
Keep the folio locked until the user PTE is installed, so that a free
can later synchronize with in-flight installations by waiting on the
folio lock.

Complete the fault in the arena: handle poison, install the PTE with
finish_fault() while the folio is still locked, and dirty the folio
and update the file time on write faults as do_shared_fault() would.
Return VM_FAULT_NOPAGE once the PTE is installed. Returning the locked
page with VM_FAULT_LOCKED would keep the lock held too, but for a
poisoned, mapped page __do_fault() then calls unmap_mapping_folio(),
which requires an address_space. Arena pages do not have one.

This change alone does not close the race, because the free path does
not yet wait for the folio lock. A following change makes frees wait
for in-flight faults before zapping user mappings and releasing the
range.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 113 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 8857e7b47c6f..dde887dac596 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -4,12 +4,14 @@
 #include <linux/btf.h>
 #include <linux/cacheflush.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/irq_work.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
 #include "range_tree.h"
 
@@ -492,15 +494,98 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	kfree(vml);
 }
 
+/*
+ * Complete the shared fault here, rather than handing a locked page to MM.
+ * __do_fault() assumes that a mapped, poisoned VM_FAULT_LOCKED page has an
+ * address_space; arena pages deliberately do not have one.
+ * finish_fault() consumes the fault's reference only on successful insertion.
+ */
+static vm_fault_t arena_install_page(struct vm_fault *vmf, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	vm_fault_t ret;
+
+	if (unlikely(PageHWPoison(page))) {
+		ret = VM_FAULT_HWPOISON;
+		goto out_put;
+	}
+
+	vmf->page = page;
+	ret = finish_fault(vmf);
+	vmf->page = NULL;
+	if (ret)
+		goto out_put;
+
+	/* Poison can be set without the folio lock, including during insertion. */
+	if (unlikely(PageHWPoison(page))) {
+		zap_vma_range(vmf->vma, vmf->address, PAGE_SIZE);
+		ret = VM_FAULT_HWPOISON;
+	} else if (write) {
+		/* Match do_shared_fault(), without page-cache writeback throttling. */
+		folio_mark_dirty(folio);
+	}
+	folio_unlock(folio);
+	if (!ret && write)
+		file_update_time(vmf->vma->vm_file);
+	return ret ? ret : VM_FAULT_NOPAGE;
+
+out_put:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
+/*
+ * The page reference protects lifetime; the folio lock protects installation.
+ * Validate after locking: a free may have removed this page while we waited.
+ * Keep the folio locked until arena_install_page() has installed the user PTE.
+ */
+static vm_fault_t arena_fault_page(struct bpf_arena *arena,
+				   struct vm_fault *vmf,
+				   struct page *page, long kaddr)
+{
+	struct folio *folio = page_folio(page);
+	unsigned long flags;
+	vm_fault_t ret;
+	int err;
+
+	ret = folio_lock_or_retry(folio, vmf);
+	if (ret) {
+		/* The fault lock may be gone; do not access the arena here. */
+		put_page(page);
+		return ret;
+	}
+
+	err = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (!err) {
+		if (vmalloc_to_page((void *)kaddr) == page) {
+			raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+			return arena_install_page(vmf, page);
+		}
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	}
+
+	folio_unlock(folio);
+	put_page(page);
+	if (err)
+		return VM_FAULT_SIGBUS;
+	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
+		return VM_FAULT_NOPAGE;
+	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
+	return VM_FAULT_RETRY;
+}
+
 static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 {
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
 	LLIST_HEAD(pages);
-	struct page *page, *new_page = NULL;
 	struct apply_range_data data;
 	vm_fault_t fault_ret;
+	struct page *page, *new_page = NULL;
 	long kbase, kaddr;
 	unsigned long flags;
 	int ret;
@@ -522,15 +607,10 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 	}
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-		/*
-		 * A failed lock means a possible deadlock was detected. Don't
-		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
-		 * the fault path would re-take it on retry and deadlock. Fail.
-		 */
-		if (new_page)
-			free_pages_nolock(new_page, 0);
-		return VM_FAULT_SIGBUS;
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret) {
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err;
 	}
 
 	page = vmalloc_to_page((void *)kaddr);
@@ -591,17 +671,22 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	page = new_page;
 	new_page = NULL;
 out:
-	page_ref_add(page, 1);
+	/* Pin before dropping the arena lock and validate after locking the folio. */
+	get_page(page);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (new_page)
+
+	if (new_page) {
 		free_pages_nolock(new_page, 0);
-	vmf->page = page;
-	return 0;
+		new_page = NULL;
+	}
+
+	return arena_fault_page(arena, vmf, page, kaddr);
 
 out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out_err_locked:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+out_err:
 	if (new_page)
 		free_pages_nolock(new_page, 0);
 	return fault_ret;
-- 
2.52.0

