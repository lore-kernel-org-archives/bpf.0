Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC73A6EF4
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784493; cv=none; b=X5c5rfhWKYODRVJi2f8/UX7UnELVEtlwwC0DKsMH0W1qVECSaHKoyHHY2lVMB3Fl0yrlApLSo9thIdzb2iRsQF8PaM/w7tKmNgyRjKiqV5H8FzKNQMp8RefuPNKY++fxRgBNZDKwKkgCS2pBvk0tDM95cyIVrVCoLD4ASCarlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784493; c=relaxed/simple;
	bh=/6E4Uj1V5dxCdPU6zojMhfvBzk9DWzYdC9lbgSXe2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIS15OfuCD0TOI/1oa5NIXyGNHKpvlO5ENPHNHIqNugqK6cN1cuclxddZyry73l4QyqgpV90Xp2NbYqSpUc3mYm+nFAYmQwTDhRf656pmy7wiFDssx9NfzBOj9GZQaXJRLCmp8nJ0VTAl4d0freBh+uT0iCbpe3KoeENlf/qo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FksoVacG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FksoVacG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778784483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALIqiwZGQGc8gWzhYBCduPwwRPxukG0LlNeus3Maqs8=;
	b=FksoVacG/5hseH+kg4VmNT0ez8G0zts1xDsbv2St0ejKV2BEs6aNBDdxKpTK4JQqSmgREL
	S4NfjRQwCwCMttTgfBawN8b6D+RXJT70gvKH5y7+o7Z62gvDepkjnMpN7ajcT8DIupn6Zl
	3VcG06pVyL8b880HdS05Mr9lZVHnUa8=
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
Subject: [PATCH bpf v4 1/3] bpf: Factor out stack_map_build_id_set_ip() in stackmap.c
Date: Thu, 14 May 2026 11:47:25 -0700
Message-ID: <20260514184727.1067141-2-ihor.solodrai@linux.dev>
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

