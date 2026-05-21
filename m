Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE734F46D
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403861; cv=none; b=Nihfcd5u0STO6+yazU+vDC/QOZ1p0wsptVU0Qyw6p9pVC1+MtrQlHsLpFPlua+nJoNH68I5G1lxLnm1vHlOYFgTCQURl3RIuo2ichHD3+9fZX8AKbwY9U7MoC5VZQI09zSPlrp5un/DuARhAEpngp7/rnL3Mq47sSLCGx5knFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403861; c=relaxed/simple;
	bh=2l1/L1N2BsBa6UDCrcEyhM5/RBwZisw1PiRzwSFdwtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdm2Wh00ThpRwRvp3bEOkoI7uuPw5xfH7Tv57vPF7TZp4HIGufJGKRDk4tMfL6lV42wj/5lTOZs2R8Bl3tvLitmQKkrzma0h0t9n+AWitY6VkjNFstlq33bH2SRjPrDQSqNYVfDrJp8I2WPuiyk9GseDaYWx3BPToj2WO4lO4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kb6oHEl4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kb6oHEl4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779403858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39Oy0nfDjc6LjnlHZaW6NwycZGuFEV9tuMsdrt9m9AE=;
	b=Kb6oHEl4EyP+rYiJHJCZcVbUiYEOeww79bMjcBj+1pV2UgQ+Sjs9PEdOAqVJsDbumGJBq3
	Bu8B+eATxYoVC9x7QNGnqJRaOvbpf5cGRcgBHhAEMb+EI9G4C3Z9s/6xPQtplUP2dD9ij6
	4TkYCPWM9r2OIZC6CaS6GgKpj38lKFY=
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
Subject: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID helpers
Date: Thu, 21 May 2026 15:50:20 -0700
Message-ID: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
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

Factor out helpers from stack_map_get_build_id_offset() in
preparation for adding a sleepable build ID resolution path.

No functional changes.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..4c753e02c415 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -152,6 +152,28 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 			 : build_id_parse_nofault(vma, build_id, NULL);
 }
 
+static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
+{
+	id->status = BPF_STACK_BUILD_ID_IP;
+	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
+}
+
+static inline u64 stack_map_build_id_offset(unsigned long vm_pgoff,
+					    unsigned long vm_start, u64 ip)
+{
+	return (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
+}
+
+static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
+						u64 offset,
+						const unsigned char *build_id)
+{
+	id->status = BPF_STACK_BUILD_ID_VALID;
+	id->offset = offset;
+	if (id->build_id != build_id)
+		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
+}
+
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -165,44 +187,43 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
-	int i;
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
+	bool has_user_ctx = user && current && current->mm;
 	struct vm_area_struct *vma, *prev_vma = NULL;
-	const char *prev_build_id;
+	const unsigned char *prev_build_id;
+	int i;
 
 	/* If the irq_work is in use, fall back to report ips. Same
 	 * fallback is used for kernel stack (!user) on a stackmap with
 	 * build_id.
 	 */
-	if (!user || !current || !current->mm || irq_work_busy ||
-	    !mmap_read_trylock(current->mm)) {
+	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
 		/* cannot access current->mm, fall back to ips */
-		for (i = 0; i < trace_nr; i++) {
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
-		}
+		for (i = 0; i < trace_nr; i++)
+			stack_map_build_id_set_ip(&id_offs[i]);
 		return;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
 		u64 ip = READ_ONCE(id_offs[i].ip);
+		u64 offset;
 
 		if (range_in_vma(prev_vma, ip, ip)) {
 			vma = prev_vma;
-			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
-			goto build_id_valid;
+			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
+			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
+			prev_build_id = id_offs[i].build_id;
+			continue;
 		}
 		vma = find_vma(current->mm, ip);
 		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
 			/* per entry fall back to ips */
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
+			stack_map_build_id_set_ip(&id_offs[i]);
 			continue;
 		}
-build_id_valid:
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
-		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
+		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
+		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
 		prev_vma = vma;
 		prev_build_id = id_offs[i].build_id;
 	}
-- 
2.54.0

