Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C134251D
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748811; cv=none; b=tkIlbWgtnW5+k2RX6mwIpN2XDRV5diPsXA8IPm90xtIVQcM1d3Srm/KkmDGPlT532PLS9KP95LVai86jLWM6IpqABs87Tk257ZurEsUfMOG3uRUMQsY4nFYKRZFdkOo59Bf9tkZ/bGvURqT2yNZO544UD9eLPwG825o4r0LGOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748811; c=relaxed/simple;
	bh=Jr9lcIbXLq4LE+XYFj8sp3KUpS6T1W/u6KkSV5Q3PFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StJfRADtXca53Xq9PhZnsaoCV4qlcLHyZVU1B/egegbbcW8YhIOQLQbyURXPRr1DZLBBVpRRSGuT4jeScKoPmBGvEU+Gw1LwtYHiXQpLXKefo46uB4l7qvaSE8jeGbLbqZMpEgnkIHvvsqmwFB72RPMEEeXV1w+flqDFJSmBA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSP7oJYM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSP7oJYM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779748807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVrvzy9clah8EtD+v/2ouiX/NekgcIxxRRED2Tw7R3w=;
	b=qSP7oJYM64isI/RnAp8IUkaDX0elXGA5tQCQJUsP1ZwSwwMsIx45Qvi0arEURyvepEuuS4
	mZHnd2VO/7lhE4i3hgi6CKehhgmAqvyHqzEpKAN1yb7qmfzEBZQy8yQCsOxdKW/UzMqY1V
	VN9tFQazhsZdsrXZR4pcdxr5DJ5kU+Q=
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
Subject: [PATCH bpf-next v7 1/3] bpf: Factor out stack_map build ID helpers
Date: Mon, 25 May 2026 15:39:46 -0700
Message-ID: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
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

Factor out helpers from stack_map_get_build_id_offset() in
preparation for adding a sleepable build ID resolution path:
stack_map_build_id_set_ip(), stack_map_build_id_offset(), and
stack_map_build_id_set_valid().

While here, refactor stack_map_get_build_id_offset():
  * use continue-driven control flow in the main loop and remove
    build_id_valid label
  * update prev_vma and prev_build_id on the fall-back-to-IP branch so
    the cache reflects the actual VMA seen on the previous IP [1]
  * guard fetch_build_id() with vma_is_anonymous() [2] to skip parse
    attempts that would otherwise fail the ELF magic check

[1] https://lore.kernel.org/bpf/CAEf4Bzac9uWWqBvzH0iFzKvJcq3vxscZ3pKm0sUHmN-F-z9wVQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/226398c1ff3f2b686c0aeb010408d85fb15df13f9ff60a045bee31e79b9e41e9@mail.kernel.org/

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 57 ++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..e23be7d44503 100644
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
@@ -165,44 +187,45 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
-	int i;
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
+	bool has_user_ctx = user && current && current->mm;
 	struct vm_area_struct *vma, *prev_vma = NULL;
-	const char *prev_build_id;
+	const unsigned char *prev_build_id = NULL;
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
 
-		if (range_in_vma(prev_vma, ip, ip)) {
+		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
 			vma = prev_vma;
-			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
-			goto build_id_valid;
+			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
+			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
+			continue;
 		}
 		vma = find_vma(current->mm, ip);
-		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
+		if (!vma || vma_is_anonymous(vma) ||
+		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
 			/* per entry fall back to ips */
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
+			stack_map_build_id_set_ip(&id_offs[i]);
+			prev_vma = vma;
+			prev_build_id = NULL;
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

