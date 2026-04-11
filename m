Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB928A72F
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866639; cv=none; b=N04YYb+Z9CAX3ChIJU2srZVvuVe1+dsg+sa3C267jtzHcryYKLWxdzXM6wxN16UhdGcBvsY+2y2tkIcWNq5FKBeMO2L6jQQe34td8Ma2YNMtJt9sHpSFcKEmmVrUmwjDsCzXImrrIcD3yJfvPQjQoyVqL0zd+b44eH8xdeJ6mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866639; c=relaxed/simple;
	bh=XyHApXkJPYFMb5sPpXXH1wNPpyctu5iFw5+b/y9DvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL1A6uJ9cHJSeV4MWg9VKHGdxmAVcNABTQqZ+GjzpSgPIAzixSSyklVQEAdYSTHPCHFmMn5URH/rT3w3IXPVBUgCFQVm2z6F3KhjL+B2Hmu6h0anq4EDPcsoC/SweJJv9+yKs4A0/REGeN6vyvoEtQW3m6vVw2nHRUVvzlg4Fsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcgAwgRR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcgAwgRR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso18636615ad.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866637; x=1776471437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvo33gS43wCEroCU6vBIRuxM6Ru5FSzI64PbEkrdXrY=;
        b=lcgAwgRR3YdXt1d7PLvAbvoWxYaOTKopGA1FLL1QyGiqLVytxLsmB0N6jbiJ/yECot
         9Hv/OFrFFJmbp+AGextHYmQ6f4YuSm6Fb6/v1Uqo61ETzTNndTFiH1WvrvfkdOHZcR20
         vFZNgkxJ8QsNPZN5IZlhSYJMvH1rbvFkSOP6CLFBVEQ+YRhPKidtNKF7zV8XH6OlpFb1
         wMsSL/XTITfCLotxQsqMN3ifNxjRKYy9s65d8EJ2jFlbNdG4TOTj9mdjCfR6lAmNd+DO
         4BKPKghJTXMA23Dk2/3+cV/RL0qeeGKPO0lV4aF7JY0V63P63EKEaKdHZkqidCKc/5ya
         oV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866637; x=1776471437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvo33gS43wCEroCU6vBIRuxM6Ru5FSzI64PbEkrdXrY=;
        b=cK6x9NiBY8xodGZvMt2IHjRVwPYo6VA6fOhvdkT0s9ygi4q/Lv5cV9yow0A557bfvu
         w6Z7MxktjB/UwAdhcNmOnivS2nqkaJGAMH77unYbk3MzM0zY9g5a6dZGWWWQbzrgp5UJ
         CidarGXORS6aCAuoGwL9vR0YwzEvZjqNwP+hWINC6+Onz8eFxU0EJbeLt20HxoDykj1f
         JJDjVsgd5NmCFKZ6IUtyfcasPtPcUD0QqwmlA8VUGs/Ko6PxB1GcJrF6YXu34paBe0be
         Y58PUqRTqerf3MMsQBOEqGp6ppErldPN7bVoT43an5FbmM5ZI5z13a1NIaeEhKHNcy6G
         CqQg==
X-Gm-Message-State: AOJu0YwSV/1Izj5WlPe2wx76UnXBJGVLVIjL+bPRyBGG4FXuVqY2prkn
	1FjP6AHFjEQa4ZBr2YPcWn2ToLtBVm1R9xzsSznyYVbHUMoZyBbETkHPoCd2FQ==
X-Gm-Gg: AeBDieuwIe8y3Ka5sPPnKcPoBqwfNKtekoWFElG5PPkfR2MLrgZunYxoSRtGogbC+rK
	iNhOsv1I+k7iYzCaz3bnnIMkAL5jcF6aku32JXYgOoHUvQK9qHD+GWOEadsXV5vndda7G17bPXN
	A17ntVHx+XFsHOC95y1hc/IwxpieD6XmKhCXUZdTn+PV3gIkC35tf1MukxQgDZmjFRBJYYOzLhp
	YaS1Vn6l8Uvn5jBKA5iDUT7sOT+MnHBZGiqGD+y+xo7PPHMoBkSoo62Uxlxit4Nt6xbGpTxdz9V
	O6B+WLJPXjBa6qyaSfINKXGkKhGOJZ2DFLbRL+c+1XVD36l2dJumK5lam28hafimwhFe+7wMAMW
	/vndGdj7Q9iIeDaBd8oQ7EGxYlqLP6sNVKxWcghKvRmRPghs44sKdfi++rLqG1gIsHYHMSYf+hE
	wQnwvqn01YIEgzCg==
X-Received: by 2002:a17:903:c11:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b2d59416b7mr31897055ad.4.1775866637003;
        Fri, 10 Apr 2026 17:17:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm42477185ad.64.2026.04.10.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
Date: Fri, 10 Apr 2026 17:17:11 -0700
Message-ID: <20260411001711.3418264-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411001711.3418264-1-ameryhung@gmail.com>
References: <20260411001711.3418264-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the check that rejects sleepable BPF programs from doing
BPF_ANY/BPF_EXIST updates on local storage. This restriction was added
in commit b00fa38a9c1c ("bpf: Enable non-atomic allocations in local
storage") because kzalloc(GFP_KERNEL) could sleep inside
local_storage->lock. This is no longer a concern: all local storage
allocations now use kmalloc_nolock() which never sleeps.

In addition, since kmalloc_nolock() only accepts __GFP_ACCOUNT,
__GFP_ZERO and __GFP_NO_OBJ_EXT, the gfp_flags parameter plumbing from
bpf_*_storage_get() to bpf_local_storage_update() becomes dead code.
Remove gfp_flags from bpf_selem_alloc(), bpf_local_storage_alloc() and
bpf_local_storage_update(). Drop the hidden 5th argument from
bpf_*_storage_get helpers, and remove the verifier patching that
injected GFP_KERNEL/GFP_ATOMIC into the fifth argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  7 +++----
 kernel/bpf/bpf_cgrp_storage.c     |  9 ++++-----
 kernel/bpf/bpf_inode_storage.c    |  9 ++++-----
 kernel/bpf/bpf_local_storage.c    | 16 ++++++----------
 kernel/bpf/bpf_task_storage.c     |  9 ++++-----
 kernel/bpf/verifier.c             | 26 --------------------------
 net/core/bpf_sk_storage.c         | 17 +++++++----------
 7 files changed, 28 insertions(+), 65 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dced54e9265f..9e4f5c45c974 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
-		bool swap_uptrs, gfp_t gfp_flags);
+		bool swap_uptrs);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now);
@@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 int
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *first_selem,
-			gfp_t gfp_flags);
+			struct bpf_local_storage_elem *first_selem);
 
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags);
+			 void *value, u64 map_flags, bool swap_uptrs);
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index d93ac2866748..c76e9b0fabba 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -76,7 +76,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 		return PTR_ERR(cgroup);
 
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-					 value, map_flags, false, GFP_ATOMIC);
+					 value, map_flags, false);
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -122,9 +122,8 @@ static void cgroup_storage_map_free(struct bpf_map *map)
 	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -143,7 +142,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-						 value, BPF_NOEXIST, false, gfp_flags);
+						 value, BPF_NOEXIST, false);
 
 out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index efc8996a4c0a..0da8d923e39d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -98,7 +98,7 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
-					 value, map_flags, false, GFP_ATOMIC);
+					 value, map_flags, false);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -122,9 +122,8 @@ static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 	return inode_storage_delete(file_inode(fd_file(f)), map);
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -150,7 +149,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata = bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d0e6070fa68c..77bb1b76fd4b 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -68,7 +68,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool swap_uptrs, gfp_t gfp_flags)
+		void *value, bool swap_uptrs)
 {
 	struct bpf_local_storage_elem *selem;
 
@@ -464,8 +464,7 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem,
-			    gfp_t gfp_flags)
+			    struct bpf_local_storage_elem *first_selem)
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
@@ -535,7 +534,7 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags)
+			 void *value, u64 map_flags, bool swap_uptrs)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
@@ -552,9 +551,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
 		return ERR_PTR(-EINVAL);
 
-	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
-		return ERR_PTR(-EINVAL);
-
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
 	if (!local_storage || hlist_empty(&local_storage->list)) {
@@ -563,11 +559,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
+		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
+		err = bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
 			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
@@ -597,7 +593,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 55f4f22bb212..4b342be29eac 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -118,7 +118,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
-		true, GFP_ATOMIC);
+		true);
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -165,9 +165,8 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -184,7 +183,7 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		return IS_ERR(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa06f534cb2..0d2218033fdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -603,14 +603,6 @@ static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
 	return is_may_goto_insn(&env->prog->insnsi[insn_idx]);
 }
 
-static bool is_storage_get_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_sk_storage_get ||
-	       func_id == BPF_FUNC_inode_storage_get ||
-	       func_id == BPF_FUNC_task_storage_get ||
-	       func_id == BPF_FUNC_cgrp_storage_get;
-}
-
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -23893,24 +23885,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto patch_call_imm;
 		}
 
-		if (is_storage_get_function(insn->imm)) {
-			if (env->insn_aux_data[i + delta].non_sleepable)
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
-			else
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
-			insn_buf[1] = *insn;
-			cnt = 2;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
-			goto patch_call_imm;
-		}
-
 		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
 		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
 			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 9fb22e352beb..3aaaf21c00eb 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -106,7 +106,7 @@ static long bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	if (sock) {
 		sdata = bpf_local_storage_update(
 			sock->sk, (struct bpf_local_storage_map *)map, value,
-			map_flags, false, GFP_ATOMIC);
+			map_flags, false);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -227,9 +227,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	return ret;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -250,7 +249,7 @@ BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata = bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -383,16 +382,14 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	return false;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
-	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
-						     gfp_flags);
+	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
 }
 
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
-- 
2.52.0

