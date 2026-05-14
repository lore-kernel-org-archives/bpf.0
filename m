Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696E3A5E82
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784494; cv=none; b=SrxFX4n02UjgGWf5kRSoRt+8WmndY+T/kDiCbVulBmFNpFao+WTgrDJLaxuxm8qEFZlRz4W+oqO+hMeP30wS15jC6U3yio6a9hW+h4telGyhk3UgfZe6d8iuCJp2VslAEJUatTp6cf28mmakPsnc2jCVhvW/Pwzs5G9oRvFKjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784494; c=relaxed/simple;
	bh=BhOSSkVm62e4oj2SU0/riFCDVWlbQeiSQcEROgZ3D8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmI/bxZHW/1CCMtCQxs07SAZZ2an+rycYirP3kFmhyoKNj2puY3iX6CTD41CH+khuMbLsclGC7nCf9T58bzAatu74uZJAt81Gp66vSveEg7c3C/qJD7wCbYwVvFa3BPD6cPmklwyaNEXXGrUyqpDoWluTQPIYNd5ohl1lhOybmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opBi7J6E; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opBi7J6E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778784486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTQUFXQQ4gAuugVKJWsSuk2OTC94//edl3ECkXYmpds=;
	b=opBi7J6E5AVo2MlU9c2kgTrndlr0DoCHRI/QzAXPJvEkCGb3Hes43CB8qgIIeJxDa81COL
	UZOMG6suIFgugB38ltXXvBM1daHLtrhHeW4U3A7lvyXKuFdoKWR1CfMqzQrwlbTYPWpFqc
	pwF4jthlg1Fa2bbwGrLpgffZnZlXJuM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm locks
Date: Thu, 14 May 2026 11:47:26 -0700
Message-ID: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sleepable build ID parsing can block in __kernel_read() [1], so the
stackmap sleepable path must not call it while holding mmap_lock or a
per-VMA read lock.

The issue and the fix are conceptually similar to a recent procfs
patch [2].

Resolve each covered VMA with a stable read-side reference, preferring
lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
enough to acquire the VMA read lock. Take a reference to the backing
file, drop the VMA lock, and then parse the build ID through
(sleepable) build_id_parse_file().

[1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
[2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/

Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")
Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 105 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4ef0fd06cea5..c1e96df360c3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -9,6 +9,7 @@
 #include <linux/perf_event.h>
 #include <linux/btf_ids.h>
 #include <linux/buildid.h>
+#include <linux/mmap_lock.h>
 #include "percpu_freelist.h"
 #include "mmap_unlock_work.h"
 
@@ -158,6 +159,105 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
 	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
 }
 
+struct stack_map_vma_lock {
+	bool vma_locked;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+};
+
+static struct vm_area_struct *
+stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
+{
+	struct mm_struct *mm = lock->mm;
+	struct vm_area_struct *vma;
+
+	if (WARN_ON_ONCE(!mm))
+		return NULL;
+
+	vma = lock_vma_under_rcu(mm, ip);
+	if (vma)
+		goto vma_locked;
+
+	if (!mmap_read_trylock(mm))
+		return NULL;
+
+	vma = vma_lookup(mm, ip);
+	if (!vma) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!vma_start_read_locked(vma)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+	mmap_read_unlock(mm);
+#else
+	mmap_read_unlock(mm);
+	return NULL;
+#endif
+vma_locked:
+	lock->vma_locked = true;
+	lock->vma = vma;
+	return vma;
+}
+
+static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
+{
+	struct vm_area_struct *vma = lock->vma;
+
+	if (lock->vma_locked) {
+		if (WARN_ON_ONCE(!vma))
+			goto out;
+		vma_end_read(vma);
+	}
+out:
+	lock->vma_locked = false;
+	lock->vma = NULL;
+}
+
+static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
+						    u32 trace_nr)
+{
+	struct mm_struct *mm = current->mm;
+	struct stack_map_vma_lock lock = {
+		.vma_locked = false,
+		.vma = NULL,
+		.mm = mm,
+	};
+	unsigned long vm_pgoff, vm_start;
+	struct vm_area_struct *vma;
+	struct file *file;
+	u64 ip;
+
+	for (u32 i = 0; i < trace_nr; i++) {
+		ip = READ_ONCE(id_offs[i].ip);
+		vma = stack_map_lock_vma(&lock, ip);
+		if (!vma || !vma->vm_file) {
+			stack_map_build_id_set_ip(&id_offs[i]);
+			stack_map_unlock_vma(&lock);
+			continue;
+		}
+
+		file = get_file(vma->vm_file);
+		vm_pgoff = vma->vm_pgoff;
+		vm_start = vma->vm_start;
+		stack_map_unlock_vma(&lock);
+
+		/* build_id_parse_file() may block on filesystem reads */
+		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
+			stack_map_build_id_set_ip(&id_offs[i]);
+			fput(file);
+			continue;
+		}
+		fput(file);
+
+		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
+		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
+	}
+}
+
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -178,6 +278,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	const char *prev_build_id;
 	int i;
 
+	if (may_fault && has_user_ctx) {
+		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
+		return;
+	}
+
 	/* If the irq_work is in use, fall back to report ips. Same
 	 * fallback is used for kernel stack (!user) on a stackmap with
 	 * build_id.
-- 
2.54.0

