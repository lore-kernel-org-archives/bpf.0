Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD881DDC3F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806390; cv=none; b=jtdWdICNoV2/DycZKX7TBoxQujanLS/CI4WEj32+61vMR+P1lmIU4blhhQXuFvD5iQje7J4ordjyGFBozJLWLNosRu7ERAsoo6lODSnjX02R75UHkBZCeM1Dn9f2kCiEUo4s/wD53NK9XHpOtJvBDebkCVQ6LuuHE61FK1wtwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806390; c=relaxed/simple;
	bh=/6E4Uj1V5dxCdPU6zojMhfvBzk9DWzYdC9lbgSXe2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7KGyaIeUVayCi9C2ijkhp3foI2rv1FSyHkpcXmzyb2/BrY15+c0dLdjnoPNloVfu1LD+7KtN4SF6WLfnR43toNlOroD7qJ8g2S9p83btWbvOjTBGUNhWr9PLIzYsicqdJ2iooaed/FgyKGNAtDBV8hjQVqBqGBZw/ftwiL7+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYaB7YA3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYaB7YA3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778806386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALIqiwZGQGc8gWzhYBCduPwwRPxukG0LlNeus3Maqs8=;
	b=AYaB7YA3qVXOXxtMJSRL+dGec7b6tqc/xr9oRj4ssLiK9Y5RcAZlvsEBM9aQoTAYSoC5JY
	0YMGBfpr4X6apFQ3qj5+WCO8MabSpKTXzQj6bDOwtefBSsoOQvGWMmerKKRoR6To9ubmQy
	YSqAsJf1YAWhYb2mG3UHcDDM7q3SR+o=
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
Subject: [PATCH bpf-next v5 1/3] bpf: Factor out stack_map_build_id_set_ip() in stackmap.c
Date: Thu, 14 May 2026 17:52:42 -0700
Message-ID: <20260515005244.1333013-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Factor out a small helper from stack_map_get_build_id_offset() in
preparation for adding a sleepable build ID resolution path.

No functional changes.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..4ef0fd06cea5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -152,6 +152,12 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 			 : build_id_parse_nofault(vma, build_id, NULL);
 }
 
+static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
+{
+	id->status = BPF_STACK_BUILD_ID_IP;
+	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
+}
+
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -165,23 +171,21 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
-	int i;
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
+	bool has_user_ctx = user && current && current->mm;
 	struct vm_area_struct *vma, *prev_vma = NULL;
 	const char *prev_build_id;
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
 
@@ -196,8 +200,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		vma = find_vma(current->mm, ip);
 		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
 			/* per entry fall back to ips */
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
+			stack_map_build_id_set_ip(&id_offs[i]);
 			continue;
 		}
 build_id_valid:
-- 
2.54.0

