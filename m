Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43735B632
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556591; cv=none; b=MQ6BcwfsVTjzLgHi7RMvPd8X7eXsl8ZegArjmWzA84j3i662qrMBW/bO+qlJHvuIhzjoJXUA+7Sg12A9R41JBYdBBQH14TpFzxYMLYiEOkMyG6HOUuZj8DcaL05hFiMEjRndQPP3gakvOaZTHHrRDuA9u7fN1M9axMiT35Fwp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556591; c=relaxed/simple;
	bh=6dC5rvFzxuabGgciG0/6aQdl7x3eEwrj1UYxfioRTWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uns5p52GnGZz7gNkJ91gr+CvRU73J4WyfDKyOxhQRZvoBNi/yxrhBuAWqYvFt1/cRMDV1JQQlmTB0U8BdFRnyGLBooOFCHDtJjBr8tZfPTKg8zjEGIkal12Y3WTCtYiqUl0VkV2rlFhtVGbaNr1QtCvv34G9VLN28pt8IetFCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jS8b+EFQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jS8b+EFQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778556588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3d5xLhMxD/AZ4bzcWoDlbHQbIevCAOLUrNaq4k4mG4Y=;
	b=jS8b+EFQbobQJv4vu8/VkplnHYGBsxOIekLkZencjCi/tU3bqHib5e3+KzURSMIZrtqQrU
	D+1Be28VS3m/BMdfvT0RulAPXkABdkGVqPEbSvMu5aDbzTTa1tuEexGbh0CwqJGiRS9a7d
	/R4fBw9NKSspsyJ7TWtvt/jG0LFhTF4=
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
Subject: [PATCH bpf v3 3/3] bpf: Cache build IDs in sleepable stackmap path
Date: Mon, 11 May 2026 20:29:06 -0700
Message-ID: <20260512032906.2670326-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260512032906.2670326-1-ihor.solodrai@linux.dev>
References: <20260512032906.2670326-1-ihor.solodrai@linux.dev>
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
parsed build ID together with the resolved VMA range and backing file
so the sleepable build-ID path can avoid repeated VMA locking and file
parsing in common cases.

Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c1e96df360c3..318ce9ed0dd5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -226,13 +226,34 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 		.vma = NULL,
 		.mm = mm,
 	};
-	unsigned long vm_pgoff, vm_start;
+	struct {
+		struct file *file;
+		const char *build_id;
+		unsigned long vm_start;
+		unsigned long vm_end;
+		unsigned long vm_pgoff;
+	} cache = {};
+	unsigned long vm_pgoff, vm_start, vm_end;
 	struct vm_area_struct *vma;
 	struct file *file;
 	u64 ip;
 
 	for (u32 i = 0; i < trace_nr; i++) {
 		ip = READ_ONCE(id_offs[i].ip);
+
+		/*
+		 * Range cache fast path: if ip falls within the previously
+		 * resolved VMA range, reuse the cache build_id without
+		 * re-acquiring the VMA lock.
+		 */
+		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
+			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
+			vm_start = cache.vm_start;
+			vm_end = cache.vm_end;
+			vm_pgoff = cache.vm_pgoff;
+			goto build_id_valid;
+		}
+
 		vma = stack_map_lock_vma(&lock, ip);
 		if (!vma || !vma->vm_file) {
 			stack_map_build_id_set_ip(&id_offs[i]);
@@ -240,9 +261,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 			continue;
 		}
 
-		file = get_file(vma->vm_file);
+		file = vma->vm_file;
 		vm_pgoff = vma->vm_pgoff;
 		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+
+		if (file == cache.file) {
+			/*
+			 * Same backing file as previous (e.g. different VMAs
+			 * of the same ELF binary). Reuse the cache build_id.
+			 */
+			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
+			stack_map_unlock_vma(&lock);
+			goto build_id_valid;
+		}
+
+		file = get_file(file);
 		stack_map_unlock_vma(&lock);
 
 		/* build_id_parse_file() may block on filesystem reads */
@@ -251,11 +285,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 			fput(file);
 			continue;
 		}
-		fput(file);
 
+		if (cache.file)
+			fput(cache.file);
+		cache.file = file;
+		cache.build_id = id_offs[i].build_id;
+
+build_id_valid:
+		cache.vm_start = vm_start;
+		cache.vm_end = vm_end;
+		cache.vm_pgoff = vm_pgoff;
 		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
+
+	if (cache.file)
+		fput(cache.file);
 }
 
 /*
-- 
2.54.0

