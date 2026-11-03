Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716158;
	b=lam2qbxQ4qGM0IfFwCc7B7QMMl504kbBIbtCZbT1NKz4pnBoytD/7tHFmsqzSV1wmLyC
	 eGCUnE/Un2Y8UcuEj2A+DV99WcaGnQ3a4OTlhteDa+5w/furvr2AaBT70Kd2iY5ciNSgW
	 UIV6jmyO7stpSw1yMqf2USxuB+A8nP+86zZEk10D3ucYxThK6TpOMpA+iWA3CwkrcF1Ec
	 Bk4R/jEL6E7CT53Cx1F7xzJHviWMfa2k1g/68JS1qDPfZ6hPIlM5EMj6IR1QKh3zqEdPb
	 5GIq9JqfhpMdGzQgjCJQHNDODebokSld85n9TmNqNIAGTocPWdm7yZxiVWyjQaY7Vzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dG52N6unu4NTumzzFCmmJhlJS66Q5HFtzBD5ijAlHnY=;
	b=DgM74fS/hXF48x8fem2B24Bb0dV/pNMwrkxLHemGKbSv3BJDfPRBPlwRV1QcQ8dqiZ/U
	 mP6sREptZr3kZ86h/RN5jWvxo/NM/b2JhFT5ifUCDB9ZcaovOVNuXRqrIv2bodKdQDP0l
	 L2ZDNDhjZYXYDP/1mg2thpbBADj9fi/PIKmSDBrUVlbntHPvC4LajdXYmACPUH6q3C1PA
	 5DoEoK2OFcCiYMeUPDpPlbWY+zAiYEC4TEZQGYlRvzLebdGbv7uiI5xIq8PbQHJK5o2Su
	 zNCvoK50WfmgpLzZSO0YXQTH5i7rscp1LgKUKUGLl16YuKJOwiaPq6f9RbWeWy4CEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXVNHi3+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDE606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXVNHi3+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20E21F000C1;
	Tue,  3 Nov 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716157;
	bh=dG52N6unu4NTumzzFCmmJhlJS66Q5HFtzBD5ijAlHnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXVNHi3+QLuGUUwuDh+AzohCFxdy8JNtH+7Ge9QDlHUm15KP+GHkD0DBGInLCa67F
	 qVvvXDsI98dCAifoYkPPa/klGKXt+ZBH+nQTXcU/hHyiwIaiYXyftgnJV3onzAciBr
	 kGKPCrMBPIlqmaytuFBAbH6RAtJPyPGpeXk/oaGQZtEpzeS7neoQ8+ssff0jmNOqLp
	 gva6RLFuvHLfGuuRrqbWepAMkRFUOj5iAIpw4KKn+XUwowRlO0aQRTabQ9W2/tsqxw
	 aLTPpisVAgMDPfrmqG19hMTimRR4DpOMKrUBQF2HXFq9LZWQlK+uWT1jrMU77E6dhF
	 YMBtLZ3Ocs9WA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Don't allocate and free prog pack memory with pack_mutex held
Date: Tue,  3 Nov 2026 06:28:53 -0800
Message-ID: <20261103142856.463063-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103142856.463063-1-puranjay@kernel.org>
References: <20261103142856.463063-1-puranjay@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_pack_free() frees an empty pack with pack_mutex held, and
alloc_new_pack() calls set_memory_rox() with it held. Both can end up in
__purge_vmap_area_lazy(), which queues purge_work on system_percpu_wq
and waits for it since commit 72210662c5a2 ("mm: vmalloc: offload
free_vmap_area_lock lock"). set_memory_rox() gets there through
vm_unmap_aliases() on arm64, x86 and powerpc.

Progs are freed from system_percpu_wq too, and bpf_prog_free_deferred()
sleeps on pack_mutex. When enough progs are freed at once, these work
items take all active slots of the pool that purge_work was queued to.
purge_work never runs and everything waits for pack_mutex:

  INFO: task kworker/0:0:9 blocked for more than 20 seconds.
  Workqueue: events bpf_prog_free_deferred
  Call trace:
   ...
   mutex_lock+0x50/0x68
   bpf_prog_pack_free+0x50/0x270
   bpf_jit_binary_pack_free+0x28/0xb0
   bpf_jit_free+0x58/0x1c8
   bpf_prog_free_images+0x84/0xa0
   bpf_prog_free_deferred+0x198/0x1d8
   process_one_work+0x1a0/0x490
   ...
  INFO: task kworker/0:0:9 is blocked on a mutex likely owned by task kworker/9:25:646.

while kworker/9:25 is in:

  __flush_work+0x78/0xf8
  flush_work+0x1c/0x30
  __purge_vmap_area_lazy+0x420/0x470
  _vm_unmap_aliases+0x21c/0x2b0
  vfree+0x1d0/0x250
  execmem_free+0x2c/0x58
  bpf_prog_pack_free+0x1a8/0x270
  bpf_jit_binary_pack_free+0x28/0xb0
  bpf_jit_free+0x58/0x1c8
  bpf_prog_free_images+0x84/0xa0
  bpf_prog_free_deferred+0x198/0x1d8
  process_one_work+0x1a0/0x490

This was hit in 16 cpu arm64 KVM guests by processes that attach cBPF
filters to sockets and close them in a loop, with
bpf_arch_text_invalidate() moved out of pack_mutex so that the frees are
faster.

pack_mutex protects pack_list, the bitmaps and arch_flush_needed. Set
up a new pack without it, then look for room again, since another
allocator may have added a pack in the meantime, and free the new pack
if it is not needed. Free the memory of an empty pack after taking it
off the list and dropping pack_mutex. Allocations larger than a pack
touch none of this, so don't take pack_mutex for them.

Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/core.c | 52 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 831f73f825993..4dac33a4208aa 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -951,7 +951,6 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		if (err)
 			goto out;
 	}
-	list_add_tail(&pack->list, &pack_list);
 	return pack;
 
 out:
@@ -963,11 +962,10 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack, *fallback_pack = NULL;
-	unsigned long pos, fallback_pos = 0;
+	struct bpf_prog_pack *pack, *fallback_pack, *new_pack = NULL;
+	unsigned long pos, fallback_pos;
 	void *ptr = NULL;
 
-	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		/*
 		 * Allocations larger than a pack get their own pages, and
@@ -991,8 +989,13 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 				ptr = NULL;
 			}
 		}
-		goto out;
+		return ptr;
 	}
+
+	mutex_lock(&pack_mutex);
+again:
+	fallback_pack = NULL;
+	fallback_pos = 0;
 	list_for_each_entry(pack, &pack_list, list) {
 		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 						 nbits, 0);
@@ -1021,11 +1024,21 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 		goto found_free_area;
 	}
 
-	pack = alloc_new_pack(bpf_fill_ill_insns);
-	if (!pack)
-		goto out;
+	if (new_pack) {
+		list_add_tail(&new_pack->list, &pack_list);
+		pack = new_pack;
+		new_pack = NULL;
+		pos = 0;
+		goto found_free_area;
+	}
 
-	pos = 0;
+	mutex_unlock(&pack_mutex);
+	new_pack = alloc_new_pack(bpf_fill_ill_insns);
+	if (!new_pack)
+		return NULL;
+
+	mutex_lock(&pack_mutex);
+	goto again;
 
 found_free_area:
 	/* Flush only for cBPF as it may contain a crafted gadget */
@@ -1040,9 +1053,12 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 	}
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
-
-out:
 	mutex_unlock(&pack_mutex);
+
+	if (new_pack) {
+		bpf_jit_free_exec(new_pack->ptr);
+		kfree(new_pack);
+	}
 	return ptr;
 }
 
@@ -1052,12 +1068,12 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 	unsigned int nbits;
 	unsigned long pos;
 
-	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		bpf_jit_free_exec(ptr);
-		goto out;
+		return;
 	}
 
+	mutex_lock(&pack_mutex);
 	list_for_each_entry(tmp, &pack_list, list) {
 		if (ptr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > ptr) {
 			pack = tmp;
@@ -1079,13 +1095,17 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 	if (static_branch_unlikely(&bpf_pred_flush_enabled))
 		pack->arch_flush_needed = true;
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
-				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
+				       BPF_PROG_CHUNK_COUNT, 0) == 0)
 		list_del(&pack->list);
+	else
+		pack = NULL;
+out:
+	mutex_unlock(&pack_mutex);
+
+	if (pack) {
 		bpf_jit_free_exec(pack->ptr);
 		kfree(pack);
 	}
-out:
-	mutex_unlock(&pack_mutex);
 }
 
 static atomic_long_t bpf_jit_current;
-- 
2.53.0-Meta

