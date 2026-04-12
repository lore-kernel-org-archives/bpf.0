Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13722868B5
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775960854; cv=none; b=LHyqHVnc4WZGS3gIMQXaeDEWS4X/SDmKZLK/1NDdATw8G0V5tP6H/6+SEORwYrn3SwZ7CtpeZhXQSYzn3kzJZgkjIacuqs6pB0OpPMcjvlDyLrmUdYDgEfKBq/vQNbAVwU6It7OmBbAT4Pu59f8pwQAlWWdx8Q0Gb93rQ22xuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775960854; c=relaxed/simple;
	bh=EVadKMzdyA05JwtqvG0eCVx3p4RsAmYyt8IXqFx0U7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of//ZKVv4MiwQwpz4SV39yOkVknpjJGv1YzesG/b27F9Lqcy8FHnjWv65MsOc9MCRifGSDDdZ2+s4aLBdnh35cMkcDCDKcjUqYm5PSNV+cy+wcOo8A5qUnsyEECcfJBzkbp34Up6/BxEsLT88mr6uCTGada3zc9r+S8a3ZHbl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja/zMrUG; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja/zMrUG"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c444dbe8eso1272828c88.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775960852; x=1776565652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRb3JIVlYGaiJeVlo7rnOgfaUPADTGIibb+C/7j3e0o=;
        b=Ja/zMrUGPAaJEV9INF4DkPX9Y5D4oWr67Wa2ZCMfxa0QgyIRc7a4YbK5wI39Fe4egX
         tuM6U0KTma6EFpJKfMQ9KbIVTS+CITNibiJjwmz/lmZrj2ZudDAAKRiosiONhSRUbUDo
         qWeJMpyN1d/dOiI48mO6b847Ai2KGHJCpYVTpKBW6wOg1k890ZM8r9gg8IjIM+aZQlyS
         QPIw+HeqZlvdNW+wJJWpHx0H6rK/CulhjCrL7L475T7PBdSGlxnHBrScOhq5BwEXfxQC
         mxsJC1CcTcznU8A01skckbNKaz+7BvbBFVAyPV0kncRHXAkAMsnZT4JHBn15JmivKgIX
         400A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775960852; x=1776565652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRb3JIVlYGaiJeVlo7rnOgfaUPADTGIibb+C/7j3e0o=;
        b=Lg3GHzLQqK04+UF5TBh7WTwTEIauIQAJkaDHplttyVREDYh7DnHICOPgDZHGYeWWak
         errjEjPriPxiIKfbM3ytrXYQ914ut04IaW5zNPBAlbmsqZ3F6GXQhGwMrj1MhpmW7DQX
         9Wy/pP8Ier19ufXWMzVDyaGcH2Y0b4asNnrTOLxwFbq7SaOKo22WYBf5ChlW2mrv+JAx
         CsEhsUDjx4XSNxLh8Yv+hhPIdzHmxFnB122MuiVlfxQ/XGRYFBvf6GSQ4qJAIdbxJO8q
         ZpjcPAYJgNmXIJbClFUCTbzLhMTgHVU1MtEB+bvzK8RzH4iwYt0+SdN8vui108vwXi/F
         PXpw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMjANZhsXDhsi8JpW7D0UM9RRE5bfo762ULPtVBITgwrnK6glJtVAHrsoMjZpk2E6Bos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7Wcv1FJ3nI2B9GhfIjG9b3zNWejOcWkaS114dhP1pcI4HQFS
	CRlMEHvS8U8T58v54aShhcrw1lDKlh9GYA2C0ACPj3ebcpVYPwnYFUdW
X-Gm-Gg: AeBDietBqZ5qnHLtwQ5dDQ2uv9X0QTJRtuMZ29LphPPEezjdqZ74dX4zA4ZGNrHLQsX
	wRg1J8VHh7Jg6AtN6ZcLYq1t1UY/m/xlR4EBheG8nOUaoxO+oG+n9tuKV1u3JKL7MqHaaxTsizS
	moss8hhaFKX7zWBsFur/gsxIcHxPwYmd/yDAm1HEa0dnRzITk3sk7tAfjLWUQyAAdi7doyXHHwG
	mv5MwKNCXmlxIa1V3a6My6qXZEzRaLqRW4VzztZcY1w0xxWrK4mkTX+BHJo3Ft0zp7s8d7uHsjr
	oOFtEtSYTzA4qc7O1cA6iXXMBuVdG1EVymnqWweQjcltCYxe1HpMqnfOtI782Bi9imJfBkdWPqC
	wctTww1fed2sZz4XCbZakvJ57qd0Go+xDf0pcmBabZYKl1UO2SkdjGwgIBXchw9UwbjzUOTnjJo
	qUG4ALXfEnnJ5M8HGc+Yjlsx6eH+PA3BUHTEjJcFRgkNJzpBjj1ktmxBrm2vAM0s7LSJGguWqSj
	84kMn3s1A==
X-Received: by 2002:a05:7022:6282:b0:12a:796b:7cf1 with SMTP id a92af1059eb24-12c34edb8f8mr5438349c88.23.1775960851712;
        Sat, 11 Apr 2026 19:27:31 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm8757860c88.0.2026.04.11.19.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:27:31 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
Date: Sat, 11 Apr 2026 19:27:14 -0700
Message-ID: <20260412022714.1955495-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412022714.1955495-2-bestswngs@gmail.com>
References: <20260412022714.1955495-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA or updates the stored vma pointer. When
the original VMA is unmapped while a forked copy still exists,
arena_vm_close() drops the refcount without freeing the vma_list entry.
The entry's vma pointer now refers to a freed vm_area_struct. A
subsequent bpf_arena_free_pages() call iterates vma_list and passes
the dangling pointer to zap_page_range_single(), causing a
use-after-free.

The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
deterministically -- no race condition is involved.

 BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:2234)
 Call Trace:
  <TASK>
  zap_page_range_single+0x101/0x110   mm/memory.c:2234
  zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
  arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
  bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
  __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
  __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
  do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
  entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
  </TASK>

Fix this by tracking each child VMA separately. arena_vm_open() now
clears the inherited vm_private_data and calls remember_vma() to
register a fresh vma_list entry for the new VMA. If remember_vma()
fails due to OOM, vm_private_data stays NULL and arena_vm_close()
skips the cleanup for that VMA. The shared refcount is no longer
needed and is removed.

Also add arena_vm_may_split() returning -EINVAL to prevent VMA
splitting, so that arena_vm_open() only needs to handle fork and the
vma_list tracking stays simple.

Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/arena.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..3462c4463617 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
-	refcount_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc_obj(*vml);
 	if (!vml)
 		return -ENOMEM;
-	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
@@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 
 static void arena_vm_open(struct vm_area_struct *vma)
 {
-	struct vma_list *vml = vma->vm_private_data;
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	refcount_inc(&vml->mmap_count);
+	/*
+	 * vm_private_data points to the parent's vma_list entry after fork.
+	 * Clear it and register this VMA separately.
+	 */
+	vma->vm_private_data = NULL;
+	guard(mutex)(&arena->lock);
+	/* OOM is silently ignored; arena_vm_close() handles NULL. */
+	remember_vma(arena, vma);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -347,10 +353,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	if (!refcount_dec_and_test(&vml->mmap_count))
+	if (!vml)
 		return;
 	guard(mutex)(&arena->lock);
-	/* update link list under lock */
 	list_del(&vml->head);
 	vma->vm_private_data = NULL;
 	kfree(vml);
@@ -415,9 +420,15 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	return VM_FAULT_SIGSEGV;
 }
 
+static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct arena_vm_ops = {
 	.open		= arena_vm_open,
 	.close		= arena_vm_close,
+	.may_split	= arena_vm_may_split,
 	.fault          = arena_vm_fault,
 };
 
-- 
2.43.0

