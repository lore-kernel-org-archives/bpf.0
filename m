Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDB47ECD9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944059; cv=none; b=ceDF7DZsPQOmNPWmXDANF+1Oub2fJYfRKLD0sM1oZAWXfpB4VZ2KLH6Tf4KDlKyUpFxYTIIJY4XibqJEnhq3MzAXjhwpp6qv/lUhQ2Bp+tNHx4JLHc0LtFWogyuNOdCCsdEy5bV9TsQbD/h7sMluJcRZoGTYhU+oLHc2i93jMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944059; c=relaxed/simple;
	bh=Fq9mPhF+x4kABBj3fAZkbuJ1hBAgDuPfZcD+bGPvZNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaP9mu0kmZ1X7yTsXn17IFPtyHbfHm+uanom35yWF0RK2KUCEWG3dsdmJ+d3WWoNpnW1us/tGmsTFQIq48qiTvJgAGOf2eN59CxTsyLWRd0ZoW00WeGvVtys+/ZIpVxuvFtg2Udm/u6j2zLyacWoh4xT3nmjEPJgWu0hm32XBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G/LtLcDR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G/LtLcDR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785944045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyCUO76kvyNGTAYi37CSbvCLeWxsrL1T0JqZ1cD6Rbc=;
	b=G/LtLcDRu7v9/sVoV/lpFoKigUzmmdYA/rDC4yNlwENcO3eHQPdEIxaALDl/6vqYgVF02T
	epXATG558Oj7JtpAORycqVp2rnEremLg0gzDzIV2/CzK3nXOFRtLK9EUHXnu8RN9cSNmII
	ZFtxWKWPvN+4SNTmGdySiCloEgopE7M=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next v2 2/3] bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE
Date: Wed,  5 Aug 2026 23:33:39 +0800
Message-ID: <20260805153340.34776-3-kaitao.cheng@linux.dev>
In-Reply-To: <20260805153340.34776-1-kaitao.cheng@linux.dev>
References: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The verifier currently keeps a hard-coded list of kfuncs that may be
called while holding a bpf_spin_lock. With KF_SPINLOCK_SAFE available,
retaining this list creates two sources of truth and requires verifier
changes whenever another lock-safe kfunc is added.

Mark every kfunc currently accepted by kfunc_spin_allowed() with
KF_SPINLOCK_SAFE. This covers the graph, numeric iterator, resource
spin lock, arena, and stream kfuncs.

Remove the obsolete category checks and make kfunc_spin_allowed() rely
solely on the kfunc registration metadata. This preserves the behavior
of existing kfuncs while using the same mechanism for built-in and
module kfuncs.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/arena.c      |  6 ++---
 kernel/bpf/helpers.c    | 56 +++++++++++++++++++++--------------------
 kernel/bpf/rqspinlock.c |  8 +++---
 kernel/bpf/verifier.c   | 32 -----------------------
 4 files changed, 36 insertions(+), 66 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 555ee2531ef9..7b6847200b43 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1118,9 +1118,9 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4709a5ad0474..6388b6b23e49 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4812,30 +4812,32 @@ BTF_ID_FLAGS(func, bpf_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_percpu_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_refcount_acquire, KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
-BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_list_push_front_impl)
-BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_list_push_back_impl)
-BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_is_first)
-BTF_ID_FLAGS(func, bpf_list_is_last)
-BTF_ID_FLAGS(func, bpf_list_empty)
+BTF_ID_FLAGS(func, bpf_refcount_acquire,
+	     KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl,
+	     KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_push_front_impl, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_push_back_impl, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_is_first, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_is_last, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_list_empty, KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_rbtree_add, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
-BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_add, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_add_impl, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL | KF_SPINLOCK_SAFE)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
@@ -4885,9 +4887,9 @@ BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
-BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
@@ -4962,8 +4964,8 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..e527cb425cf4 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -744,10 +744,10 @@ __bpf_kfunc void bpf_res_spin_unlock_irqrestore(struct bpf_res_spin_lock *lock,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(rqspinlock_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_res_spin_lock, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_res_spin_unlock)
-BTF_ID_FLAGS(func, bpf_res_spin_lock_irqsave, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID_FLAGS(func, bpf_res_spin_lock, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_res_spin_unlock, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_res_spin_lock_irqsave, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_res_spin_unlock_irqrestore, KF_SPINLOCK_SAFE)
 BTF_KFUNCS_END(rqspinlock_kfunc_ids)
 
 static const struct btf_kfunc_id_set rqspinlock_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1f8d552655..7c1edcae293a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11797,20 +11797,6 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
 }
 
-static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_iter_num_new] ||
-	       btf_id == special_kfunc_list[KF_bpf_iter_num_next] ||
-	       btf_id == special_kfunc_list[KF_bpf_iter_num_destroy];
-}
-
-static bool is_bpf_graph_api_kfunc(u32 btf_id)
-{
-	return is_bpf_list_api_kfunc(btf_id) ||
-	       is_bpf_rbtree_api_kfunc(btf_id) ||
-	       is_bpf_refcount_acquire_kfunc(btf_id);
-}
-
 static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
@@ -11819,29 +11805,11 @@ static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
 }
 
-static bool is_bpf_arena_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_arena_alloc_pages] ||
-	       btf_id == special_kfunc_list[KF_bpf_arena_free_pages] ||
-	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
-}
-
-static bool is_bpf_stream_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_stream_vprintk] ||
-	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
-}
-
 static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
 {
 	struct bpf_kfunc_meta kfunc;
 	int err;
 
-	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_id) ||
-	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) ||
-	    is_bpf_stream_kfunc(func_id))
-		return true;
-
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err || !kfunc.flags)
 		return false;
-- 
2.50.1 (Apple Git-155)

