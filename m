Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A74378D8D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660574; cv=none; b=tBAj1k4Pe5tF9Yrp+J3S6tQ3KEhNlGUb7ffp6B5rF4vUTbrp9cTQsZfNY8TN8oatVnBdlkd7tuzfgjOvX4Oz/CATMFB8F1XRC//jievT9hemYVK+1hmcCJcRu9NurWetIBJbT4ssJd/kQzXEBxT4c3210IIapvacSPMM+k6rmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660574; c=relaxed/simple;
	bh=f254u9m1QCRh+1RTnHbpIKWIkCtIaFhXm7XPT4JMgW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr/xVETBKLkeMQxBo68jUf2L/WkfGwvpcWLMAfVApeDAvQaWCnZxft5z1qqzLVqyJcKSNdh9snMa9jlkmUgBATQ3m82BxCv5ucJFG6kc7CLlpqsikm3uQVWT429+oFIXQpYr9HKWFsgZtlqIj1pkdWedslwd/rsLxiqz4fTTAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQPRwHW0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQPRwHW0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824c9da9928so2877946b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660571; x=1774265371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2EXT8xQIbLD8Uq3gaj+lgUvs/CfjmF64+/VehA8xmM=;
        b=IQPRwHW0hdmJVPw/QB5HYZNDRiS8IfS4WLz41X0HY2Wi8q71hSicH9jLwWCntcPxe4
         RiF3YoIXAi++m72YWJzYt/jzVQsQ/zWJdVcrwi6JD1IY6oy7/Ek5YOQXiusUo7tGDxJO
         bCvJo1v5OjpW+UaZN7dhS6XfJx3qWvq20sbck3xG9Ud6NDuKtLylJxLanOr1//J1Vwf1
         wPt/ky/KNhLkml5FdBKck+cQJW9ne8NiIKn4dXyCpv9sTMDqYf4/a/VNfGNV1pJAzyNV
         trgC+OXHldlww/0TJHygLmkC+RQ9ti/iIV0FUlqrwnYyU1pXHFYFZsblfJrmaQipglgL
         lJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660571; x=1774265371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2EXT8xQIbLD8Uq3gaj+lgUvs/CfjmF64+/VehA8xmM=;
        b=AJ3JJKki8wtD4+h/YBtYofAFGWd2O+T4uN8IPIna04ykeuqEf+am6BTRZdyRxAK5Vf
         WWEvvQ00882xleZxn+DZnEViJB9hSV2vXJN0L7hw39uJ8uRdKYHlssOCjnobLYOY8Ktm
         kKSDpT4Co1aiaEIMfB5qxHpnU3XB+erTrwG2ewr8u4gFDRg4Ng2eEDsWFA7OLGjcacKa
         X0SVR1lQxw1SNstjN3uJRxGqFncLlaMq9E1pkkxLxtu/hW7gvVZrWnfdsTnegCURpbG0
         jgqFA+UhC+v/D4RCfG/FNC8VW7/TIALBXXzICuKdHhuMEiiwTkrI70B5yjmN7nhc/Ujm
         aR1g==
X-Gm-Message-State: AOJu0YzaIUF+8EUxkGjwZtfxv8my6q4WVCz6mdk+b7cpt+/c0+QlDc+f
	3r/zEYfT+zKKuBIoTk6cTQnXZeTNnzE+EA15t3ootbU29bkrsoP9SR4I
X-Gm-Gg: ATEYQzzI7OKEXPagIsakxj5mhrQ8r2Xt+fguCVpuQ+0qVFtVYELDHRePInhwzt4yzY2
	Iuwts87OUn3s+o2IqR/D+jXH7rK6/tq0agVxNoJWVT4W6U/pUklWxTG/6Up/UGWPM7/HkjLXA5R
	ru8JiiXsYkRgZtPyb+eL8uIRMbyXqQGCccFnSqJknaK70QJkKcusnQXwSayUNzP/tpg/4hVhFGC
	eFUhlzUJErrKXHPi6Ih0/e2y6QDpkJjCXjsbqmJ0vkv4m9Ut4Q2tM12pPns2SV54BE8z+X9cqlJ
	hvDpECMYb2V6FcvbmAzWUbLfrujPXG/IqS7qoOZilpFkbjP/d4Mxa8t+Ms3MLbmKztUFv8TcJvP
	NzU4KNpPx3TObn19EsMjByvcOO8JXw4MFPvstDoARhOoCwphT8suVVHBIFNmGxmwfWzQSWgRbFR
	FUVkC94LmoQoCG0zgRT0HBm1YpZZGyIa249wA4BqHywZDHR5lvSfVF4kY=
X-Received: by 2002:a05:6a21:7106:b0:398:c3c3:8686 with SMTP id adf61e73a8af0-398eca2d969mr10979592637.4.1773660571067;
        Mon, 16 Mar 2026 04:29:31 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:30 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 5/8] bpf: Add bpf_list_add_impl to insert node after a given list node
Date: Mon, 16 Mar 2026 19:28:40 +0800
Message-ID: <20260316112843.78657-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add a new kfunc bpf_list_add_impl(head, new, prev, meta, off) that
inserts 'new' after 'prev' in the BPF linked list. Both must be in
the same list; 'prev' must already be in the list. The new node must
be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
that reference and the node becomes non-owning once inserted.

We have added an additional parameter bpf_list_head *head to
bpf_list_add_impl, as the verifier requires the head parameter to
check whether the lock is being held.

Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
is already in a list (or duplicate insertion). On failure, the
kernel drops the passed-in node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 14 ++++++++++++++
 kernel/bpf/verifier.c | 13 +++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a9665f97b3bc..dc4f8b4eec01 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2438,6 +2438,19 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return __bpf_list_add(new, head, &h->prev, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
+				  struct bpf_list_node *new,
+				  struct bpf_list_node *prev,
+				  void *meta__ign, u64 off)
+{
+	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
+	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *prev_ptr = &kp->list_head;
+
+	return __bpf_list_add(kn, head, &prev_ptr,
+			      meta ? meta->record : NULL, off);
+}
+
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
 					    struct list_head *n)
 {
@@ -4574,6 +4587,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_add_impl)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e928ad4290c7..98ddb370feb5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12506,6 +12506,7 @@ enum special_kfunc_type {
 	KF_bpf_refcount_acquire_impl,
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_list_del,
@@ -12567,6 +12568,7 @@ BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
+BTF_ID(func, bpf_list_add_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
@@ -12644,6 +12646,7 @@ BTF_ID(func, bpf_stream_print_stack)
 static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_list_del,
@@ -12655,6 +12658,7 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
 	KF_bpf_list_del,
 };
 
@@ -14345,6 +14349,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
@@ -23357,13 +23362,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		int struct_meta_reg = BPF_REG_3;
 		int node_offset_reg = BPF_REG_4;
 
-		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
-		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		/* list/rbtree_add_impl have an extra arg (prev/less),
+		 * so args-to-fixup are in different regs.
+		 */
+		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 			struct_meta_reg = BPF_REG_4;
 			node_offset_reg = BPF_REG_5;
 		}
-- 
2.50.1 (Apple Git-155)

