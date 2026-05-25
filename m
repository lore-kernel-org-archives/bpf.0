Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89E3451AF
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748860; cv=none; b=RpR/yxEZpYoJzPN6c24kxrC8g7zMaGloIwLqg3N173HBec9JvIgP2p3QERO10p6l0LjzmvPY50HDCy4zE1mUQQMHHHsboCcKkJL/KFq/ddNPnKhsb7md3LRDAilhPQysfvHVJoUjPh3nVdKNSQYtGIEezKynk2OLDL3YOgA7TF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748860; c=relaxed/simple;
	bh=2e6ts3jthodVVFufG34atIwa3tEl5LEO9/DhoXe08gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzQ+k8QYr/RYHySYTkK/JbwfEaQBrW6322RgRqa7h0Leovtk3uuKGm32CEgsPApRPc5N3qGPF1iLt+3bv+kAyZiv9GckqUbgBchohaeEj+GI5cJ6aed2Qojk3UlPeiz3QH0KdQnEMDNM4KQDs056IxT5bVIfsBKNEB3hYWaW9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+mBiCS3; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+mBiCS3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779748813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toqCpj5veBEZ43tMu1xdjS6WjCnJ8+7ui4srFdPxUwc=;
	b=L+mBiCS3wI7qaiK9+50OIb0+WLfcwRmbALjd8A3Lra+rLUR1TTXtUPb1VjaZYF6aWsUmLI
	0Lp0OksHCzGDktJM7rqc+BZJg5+oRreBPJAmiHoo/T9zKIoHVSOdT36ukeEUxWU/mompgh
	aiuGUi/2DSxfhbRrMjnb/MP1+26C2co=
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
Subject: [PATCH bpf-next v7 3/3] bpf: Cache build IDs in sleepable stackmap path
Date: Mon, 25 May 2026 15:39:48 -0700
Message-ID: <20260525223948.1920986-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
References: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Stack traces often contain adjacent IPs from the same VMA or from
different VMAs backed by the same ELF file. Cache the last successfully
parsed build id together with the resolved VMA range and backing file
so the sleepable build id path can avoid repeated VMA locking and file
parsing in common cases.

Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 61 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c53cfd9a67cf..77ba03216c09 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -246,6 +246,14 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 {
 	struct mm_struct *mm = current->mm;
 	struct stack_map_vma_lock lock = { .mm = mm };
+	struct {
+		struct file *file;
+		const unsigned char *build_id;
+		unsigned long vm_start;
+		unsigned long vm_end;
+		unsigned long vm_pgoff;
+	} cache = {};
+	unsigned long vm_pgoff, vm_start, vm_end;
 	struct vm_area_struct *vma;
 	struct file *file;
 	u64 offset;
@@ -254,6 +262,17 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 	for (u32 i = 0; i < trace_nr; i++) {
 		ip = READ_ONCE(id_offs[i].ip);
 
+		/*
+		 * Range cache fast path: if ip falls within the previously
+		 * resolved VMA range, reuse the cache build_id without
+		 * re-acquiring the VMA lock.
+		 */
+		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
+			offset = stack_map_build_id_offset(cache.vm_pgoff, cache.vm_start, ip);
+			stack_map_build_id_set_valid(&id_offs[i], offset, cache.build_id);
+			continue;
+		}
+
 		vma = stack_map_lock_vma(&lock, ip);
 		if (!vma) {
 			stack_map_build_id_set_ip(&id_offs[i]);
@@ -265,17 +284,47 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 			continue;
 		}
 
-		file = get_file(vma->vm_file);
-		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
+		file = vma->vm_file;
+		vm_pgoff = vma->vm_pgoff;
+		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+		offset = stack_map_build_id_offset(vm_pgoff, vm_start, ip);
+
+		/*
+		 * Same backing file as previous (e.g. different VMAs
+		 * of the same ELF binary). Reuse the cache build_id.
+		 */
+		if (file == cache.file) {
+			stack_map_unlock_vma(&lock);
+			stack_map_build_id_set_valid(&id_offs[i], offset, cache.build_id);
+			cache.vm_start = vm_start;
+			cache.vm_end = vm_end;
+			cache.vm_pgoff = vm_pgoff;
+			continue;
+		}
+
+		file = get_file(file);
 		stack_map_unlock_vma(&lock);
 
 		/* build_id_parse_file() may block on filesystem reads */
-		if (build_id_parse_file(file, id_offs[i].build_id, NULL))
+		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
 			stack_map_build_id_set_ip(&id_offs[i]);
-		else
-			stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
-		fput(file);
+			fput(file);
+			continue;
+		}
+
+		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
+		if (cache.file)
+			fput(cache.file);
+		cache.file = file;
+		cache.build_id = id_offs[i].build_id;
+		cache.vm_start = vm_start;
+		cache.vm_end = vm_end;
+		cache.vm_pgoff = vm_pgoff;
 	}
+
+	if (cache.file)
+		fput(cache.file);
 }
 
 /*
-- 
2.54.0

