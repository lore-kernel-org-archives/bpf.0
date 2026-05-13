Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FA2AEF5;
	Wed, 13 May 2026 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699778; cv=none; b=VXd27x1JGUhgHjFTk1tPBmSOVZNEinBWWUCsFoz/BTSdbXfcFuni2cCxjEgfd2e5+0YwAZp9P65VIQneUfv0Ahw8cHc5Fh3vnalj77GqkjizkJ50vt7ER6CG5pcfaS9CgwvlqeJhotl4dXEdg54CpxJS0k9SV5VFr2dI9BMr2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699778; c=relaxed/simple;
	bh=AogXxCuilaNU2a7TRYw2082Wz8X7D8ixpm8B77RvooY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qxm5GCel40yiMUJLBoLe7kPgqP1TFJ2Li2McQ25XT1QLhks2FCycwBitPfUBuqeuI+YknSBBv0iZzuI0/wu2oS0DPS2nY2F9+Y4Hcy/35usdObcqhImXvENjXU25KSVyxcYMHVnXxYuJShDV+70gtBuxgbBiiw2UJ5qdcuOi7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=WKtdWFuj; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=xyy1srMK; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="WKtdWFuj";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="xyy1srMK"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778699602; bh=5A0Fbx7XypcXPy8p2i3oWdu
	1wE+T/OQBEHMe1DQG/Jk=; b=WKtdWFujZD9c7oyEAW0jpS0SUCyV84fqHMrSVEqh5eXqCN5PPQ
	K8kwzQP4YPcUJOJZsFV08YrOKC1XyTr+VgznnQug5lk2yxtwuPkx91OE5P0t9FZBpREhC1nGtXM
	UBiSt8bB2XHFyNaAfncgSQhbvanewn9VBU1tI3fZQwqsRPvWwr4G6SnFbXS5pypjxicxO1EkrfQ
	VdAaz8SkWqn94QshU4mO6TdfQREojgfwvwoGgOn0+p58T8xZyEx85g5mxZl86oIWm9XoXGpsj+n
	upqw00RInkrAFvLEbaIpSc1JD6JINAAo8w0Os2gv18IGwRpfZKVAlPIeWt8Q6HJO4qA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778699602; bh=5A0Fbx7XypcXPy8p2i3oWdu
	1wE+T/OQBEHMe1DQG/Jk=; b=xyy1srMKmfVDAJ6H3J2/EQWj6uSSaZWDECbBH0Ju70gtNEJXaA
	rRrnyorC4IAwc4N7KkVzHbXEFbdocDY0ouAg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	git@danielhodges.dev,
	brho@google.com,
	hodgesd@meta.com
Subject: [PATCH 1/2] bpf: arena: fix use-after-free in VMA tracking on fork
Date: Wed, 13 May 2026 15:13:21 -0400
Message-ID: <20260513191322.21319-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the existing vma_list
entry without creating a new entry for the child's VMA. After fork,
vml->vma still points to the parent's VMA. When the parent unmaps
(arena_vm_close decrements refcount but doesn't remove the entry),
vml->vma becomes a dangling pointer. A subsequent bpf_arena_free_pages
call reaches zap_pages() which dereferences the freed VMA via
zap_vma_range(vml->vma, ...), causing a use-after-free:

  BUG: KASAN: slab-use-after-free in zap_vma_range+0xf2/0x100
  Read of size 8 at addr ff11000113ec9b10 by task test_progs/198
  Call Trace:
   zap_vma_range+0xf2/0x100
   arena_free_pages+0x6de/0x970
   bpf_prog_a2b540a82b1066f3_arena_free+0x8b/0xb6
   bpf_prog_test_run_syscall+0x3d3/0x8a0

The same issue is triggered by __split_vma (partial munmap) and
copy_vma (mremap), both of which call vm_ops->open.

Fix this by giving each VMA its own vma_list entry instead of sharing
one with a refcount. arena_vm_open now allocates a new entry for the
new VMA, and arena_vm_close always removes and frees its own entry.
If the allocation fails in arena_vm_open, vm_private_data is set to
NULL and arena_vm_close handles this gracefully, meaning the VMA
simply won't be zapped during arena page frees.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Assisted-by: Claude-Code:claude-opus-4-6
---
 kernel/bpf/arena.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 49a8f7b1beef..a3c46100dd12 100644
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
@@ -336,9 +334,19 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 
 static void arena_vm_open(struct vm_area_struct *vma)
 {
-	struct vma_list *vml = vma->vm_private_data;
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct vma_list *vml;
 
-	refcount_inc(&vml->mmap_count);
+	vml = kmalloc_obj(*vml);
+	if (!vml) {
+		vma->vm_private_data = NULL;
+		return;
+	}
+	vml->vma = vma;
+	vma->vm_private_data = vml;
+	guard(mutex)(&arena->lock);
+	list_add(&vml->head, &arena->vma_list);
 }
 
 static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long addr)
@@ -357,10 +365,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
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
-- 
2.52.0

