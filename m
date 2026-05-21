Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC272621
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403868; cv=none; b=ijDpDVDj2IffalCUTRkT6fRka4NDnaysyw6drZyFp19IgfUCGr2n+xA/tDTWSpAPLQedrsNm/4LWGEItXf/hcwS4mDe2YEFBMC1pDufHBW84cNd6AHJP16585ihHvYNv3/CCpLY1kz55VWoQjIu5ABgtTLggWmwUc7ZnLKFGsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403868; c=relaxed/simple;
	bh=59CB+nPUZqTvo1tK5kyFcmQcM2kFAHkCc9lFZiEnUkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3gc5i5ZYLCaKK4Qw/+r5lZ739bU8auwTrwCagWhQmnQjq0VDEXiS+ZB3pZakkDlt7md6nzuXY2OZlAkCCxDbz57Y+HeW92dBxMg+Y39JVtjloDrOoFITicbqvwjdMmf5026tTTFzlSBAGVz/cqH2Uv1r7YUEUItLguoEj7vfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmknv/Q1; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmknv/Q1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779403865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soCrvY+G9j9s8Up9MbZp+KmpDH/Fu49zSezrypYZ7SE=;
	b=pmknv/Q18ouHvs2TlAH2cWY5ZhoxfG35Su+eS36kwjbnMPdLLgeqV7CMWTmaaH37dZLhrE
	tmhVLkFCt6yLM5KRluzGC8ZgUjdiFivd6nqEexg5UYs+CY8sJzAbVFHCxAHtoO3qw3ga3p
	eBUwx/0FH7j3z3u9j6lhP5Imb8SRNvU=
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
Subject: [PATCH bpf-next v6 3/3] bpf: Cache build IDs in sleepable stackmap path
Date: Thu, 21 May 2026 15:50:22 -0700
Message-ID: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
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
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 52 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 95336c0e8b56..0d641ac39227 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -245,6 +245,14 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 		.vma = NULL,
 		.mm = mm,
 	};
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
@@ -253,6 +261,17 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
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
 		if (!vma || !vma->vm_file) {
 			stack_map_build_id_set_ip(&id_offs[i]);
@@ -260,8 +279,26 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
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
+		if (file == cache.file) {
+			/*
+			 * Same backing file as previous (e.g. different VMAs
+			 * of the same ELF binary). Reuse the cache build_id.
+			 */
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
@@ -270,10 +307,19 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 			fput(file);
 			continue;
 		}
-		fput(file);
 
 		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
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

