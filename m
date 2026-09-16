Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1901466AF4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582230; cv=none; b=sf5DIKsbT0FmYG6G4TV655byOmW/vPqVFVIoi5DitVfsoMUW//Hu9w1TChSe0T+v4aV37Dra6x5S/nsXxgeg8KTkOc7ulCEmmAMdEQli2GFTSRj2rAqcImdRk/Rl1l822XG77wfkCyDGoVon7g5I9dSMkHkn5botFE5G3pYnQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582230; c=relaxed/simple;
	bh=zW2RwnLfumjVy/sP+HREg7Msc98rbIvzGm+54oemM6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSBSrFo+h8hnLmBq9W64KsQ4W+P4QoBFBGXS5LsMwOt6dgrXr8HlDf3ssjVBMlelfQjCaZ1CCDn64ESjoiX2HysMhz6bFjhLtqC5F2kTY4PUZCbO2G5KBgR7eHRiFphXq/0E/vizZGg/2W8BCGlmNTBuPdjcCJH3uwwVvJtDR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qe0a2jWb; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qe0a2jWb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zW2RwnLfumjVy/sP+HREg7Msc98rbIvzGm+54oemM6E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789582220; v=1; x=1790187020;
 b=Qe0a2jWbcbo+kUV3i8kcFwehPBfPMiv2SuKp6R979re2Vz59AHWp/tngZmplXZlP8/FwJkQu
 sW1cafUFlvgGmZkSIkuc/Fq1T7lMQiHZuo04ud5lBk1dSh+3BDM1vMr716hqbAPjyWjayuUEIgI
 ePJyRKZkHr2onFvE1nYQn5hM=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c987281efb541743;
	Wed, 16 Sep 2026 18:10:09 +0000
X-Mizu-Trace-ID: c987281efb541743
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: ast@kernel.org,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	martin.lau@linux.dev,
	memxor@gmail.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket locks
Date: Wed, 16 Sep 2026 11:10:01 -0700
Message-ID: <20260916181001.201787-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_local_storage_update() takes the map bucket lock while holding
local_storage->lock. bpf_selem_unlink_map() does the same; its only
caller holds local_storage->lock. The outer lock is acquired with
raw_res_spin_lock_irqsave(), so interrupts are already disabled at both
sites.

Using raw_res_spin_lock_irqsave() for the nested lock saves the already
disabled IRQ state and issues another IRQ disable. The matching unlock
tests that saved state before leaving interrupts disabled. On x86-64,
this adds a pushfq/popq/cli sequence and a test/branch around an
unreachable sti to each acquisition.

Use raw_res_spin_lock() and raw_res_spin_unlock() instead. They retain
preemption nesting, memory ordering and resilient-lock bookkeeping. The
outer unlock remains responsible for restoring the caller's IRQ state.

In the tested clang x86-64 build, this removes five executed instructions
from each uncontended nested acquisition. It also shrinks
bpf_local_storage_update() from 1732 to 1702 bytes and bpf_selem_unlink()
from 1030 to 992 bytes. The affected paths are updates that add or replace
an element in existing owner storage and successful unlinks.

Document the owner-lock requirement of bpf_selem_unlink_map() and assert
that interrupts are disabled.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6fc6a4b672b55..4642da062f0f8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -240,24 +240,26 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
+/* Must be called with the owning local_storage->lock held. */
 static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
-	unsigned long flags;
 	int err;
 
+	lockdep_assert_irqs_disabled();
+
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
-	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock(&b->lock);
 	if (err)
 		return err;
 
 	hlist_del_init_rcu(&selem->map_node);
-	raw_res_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock(&b->lock);
 
 	return 0;
 }
@@ -552,7 +554,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags, b_flags;
+	unsigned long flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -637,7 +639,8 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	b = select_bucket(smap, local_storage);
 
-	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	/* local_storage->lock is held, so IRQs are already disabled. */
+	err = raw_res_spin_lock(&b->lock);
 	if (err)
 		goto unlock;
 
@@ -655,7 +658,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 						&old_selem_free_list);
 	}
 
-	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
+	raw_res_spin_unlock(&b->lock);
 unlock:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 free_selem:
-- 
2.53.0-Meta

