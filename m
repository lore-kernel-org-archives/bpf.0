Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63B33D6DD
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109849; cv=none; b=DlSM4jFUvtdd+6DhiLnPT/nHH8a2ZZTx4gVOYUrJ/0dWIMM6dqPNWAFE9tRd0lutXaF4hd8Kltj3QkXZ3yplPR53S8D3eb3WPqKIhUj8w4Xr+69AXoZGx4upWiBey2eFSPq96XzuT9nuhiYLJ5B3dzsfqbzVAVYNcVa37BS4LXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109849; c=relaxed/simple;
	bh=Ekl7OgEjAIO0u1Znpv5rM+ZFRVf8DHPBt8TAt0Tx55Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4qyqOBi6cE1Z2tS7YfJeh1nfIHG/SL5GazBamtDg3v5Nunk4u1m3gozlMcpp+n7kHA9ZznfCTbSCEk8HRkqeiq53ogcgwttFUKWjuAQNpSp9xdQ9lC3d1Gi6302jR19y81D0CGKPKeYwfJzTQhhI49qE/3beHunYlvpceNKPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBJI7qcA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBJI7qcA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848595b338cso2322319b3a.0
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785109847; x=1785714647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddkR3SqPvYCZiT3hFG7W3zUmR6gwvKiMX8Jv0Skt7Wo=;
        b=ZBJI7qcA+SypQbzi+Iecu9EMS90Sm38GZjJ1t8ABgp38tV3hFa/2K96oomvS3Z8qyb
         z/vVeILBkCFInBQVaOlPr1KEjHJX7cNL3MyngfnWcHH2b9sXWzqMAUcIug3TWJjonI9t
         2ij8VywwQ+pBDqIce+ukqsWgKloYMBizSEKogS5bfrXLhvYsMzf49mcYWqL35Rd+P+/2
         tdsMHjQ3Ppfgo4pcVYt32MlzJfKmmLZDABcbsQ0+suMw9Oc49L2n/wItRWMpXYODG8IG
         cl6GNybUe/uBku7ksTKd2WbygTz+xYA79o/oZUeDLcstpQFFK8nPY4EQZ2+yKx3LHhnx
         b81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785109847; x=1785714647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddkR3SqPvYCZiT3hFG7W3zUmR6gwvKiMX8Jv0Skt7Wo=;
        b=k8kyypOFhX95sMlq1mO0YUBIjLKaD2/oXLzSc6PpK6JdaaCeGiggu3Dij6Y7nkNM/g
         u1susafykW8B2elVIG0vp5Pb9f9t8zYWB3gsi3KnZZTqLhUP6r7F1S/9sjJaK3RN16+t
         vm5GIazHOYS8NKinqSi7BrUGENM+ZoCOGkGK57pTTothApRqoZ0graNM2QjYZjaZ2zZl
         WMikZ5z8CgWfQ8sxIsdJcIzHppKKdmF78T24K0MJmTAADtgM2+71/QbpJx6eTezSLbp3
         SkAIdijNyPTdLV67uez22zB3u3tHNwHdPOHClOuO6K3KvQxVhevcklmJaYp/nr9mY4If
         QNtA==
X-Gm-Message-State: AOJu0YxPndRWPUh5Y0tLy3ucLtyJuht7diSBloEpQPhJpD0PNJnyUT8u
	KGAWlXvenn5W96G16FKUpjh0ebGKGEai2Vt4GvkD8cVv8W+AgxZh1ebMh3WmTaQ4
X-Gm-Gg: AR+sD13d1P4oCIVhYwxdkBigUV5C65OqkST1ilzo2pvdnsPA6VdUh55sO+BnXPx3HWt
	0gsTa6LsxJpiLWBcgIDf6PLbv+UEdd3NQEsoKSudXo77XGV8L8gUsTJIBtol15r6TWgCZMAxLbY
	+2peKQDoIQLFRoI826gwqEnuaQIax8KF93Cxc3O8xjKdVttBbhzmjSzm+vWKP9eZc4d34NUjxTy
	PGVCJefADo6Qw4BSOGPM4Fjx+SbHikXADYzqHx/AvQyRqHbO0+hDdV9bNsrePM6TB2EWT6Du+bM
	rMeVjKRxNXNQk7IxS1ETZITTegH4ac/2yDplC4zwqqPPLiFwelYV9LNfyuYQ8CPJo6XWqibotJa
	VNDrV00ESqJJKdamZMd1uC/w2+c1vxnBPqpOxvfPahnyLYXBCsJ/BHN3NpTMik6ptLBOJaJeIzs
	8wYcByNun2xaq+dnphpaE/eaDFWny8wSb5qtpbUhfN
X-Received: by 2002:a05:6a00:3308:b0:84a:2a88:fbd3 with SMTP id d2e1a72fcca58-84e59468f21mr5206144b3a.20.1785109847205;
        Sun, 26 Jul 2026 16:50:47 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e534694a7sm2216910b3a.59.2026.07.26.16.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 16:50:45 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	davem@davemloft.net,
	greg@kroah.com
Subject: [PATCH bpf v2 1/2] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Sun, 26 Jul 2026 16:50:29 -0700
Message-ID: <20260726235030.1152542-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726235030.1152542-1-dingning04@gmail.com>
References: <20260726235030.1152542-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_refcount_acquire() returns NULL if the object's refcount has
reached zero.  For an RCU-loaded map kptr, another thread can replace
the map entry and drop the last owning reference before the acquire,
which makes the ref count drop to 0.

However, the verifier incorrectly marks the input as owning solely because it
lacks NON_OWN_REF, and therefore treats the return value as non-NULL.
This allows an unchecked NULL return to be passed to bpf_obj_drop(),
which can crash the kernel.

Only treat the input as owning when it is present in the verifier's
acquired-reference state. Add tests for owning input, checked borrowed
RCU input, and unchecked borrowed RCU input.

Fixes: 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning refs")
Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 47 ++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc65..1e7343b625de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12419,7 +12419,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 61906f48025c..fd35093285c0 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -23,6 +23,15 @@ struct map_value {
 	struct node_data __kptr *node;
 };
 
+struct node_refcount_only {
+	long key;
+	struct bpf_refcount refcount;
+};
+
+struct map_value_refcount_only {
+	struct node_refcount_only __kptr *node;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__type(key, int);
@@ -30,6 +39,13 @@ struct {
 	__uint(max_entries, 2);
 } stashed_nodes SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value_refcount_only);
+	__uint(max_entries, 1);
+} stashed_refcount_only SEC(".maps");
+
 struct node_acquire {
 	long key;
 	long data;
@@ -832,6 +848,51 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 	return 0;
 }
 
+SEC("tc")
+__success
+long refcount_acquire_owning_input_no_null_check(void *ctx)
+{
+	struct node_refcount_only *n, *m;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	m = bpf_refcount_acquire(n);
+	bpf_obj_drop(m);
+	bpf_obj_drop(n);
+
+	return 0;
+}
+
+SEC("tc")
+__success
+long refcount_acquire_rcu_map_kptr_null_checked(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *n, *m;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	m = bpf_refcount_acquire(n);
+	bpf_rcu_read_unlock();
+
+	if (!m)
+		return 3;
+	bpf_obj_drop(m);
+
+	return 0;
+}
+
 static long __stash_map_empty_xchg(struct node_data *n, int idx)
 {
 	struct map_value *mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 024ef2aae200..acd3e81a3916 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -19,6 +19,15 @@ struct node_refcounted {
 	struct bpf_refcount refcount;
 };
 
+struct node_refcount_only {
+	long key;
+	struct bpf_refcount refcount;
+};
+
+struct map_value_refcount_only {
+	struct node_refcount_only __kptr *node;
+};
+
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
 
@@ -28,6 +37,13 @@ private(A) struct bpf_rb_root groot __contains(node_acquire, node);
 private(B) struct bpf_spin_lock lock;
 private(B) struct bpf_list_head head __contains(node_refcounted, list);
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value_refcount_only);
+	__uint(max_entries, 1);
+} stashed_refcount_only SEC(".maps");
+
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct node_acquire *node_a;
@@ -80,6 +96,37 @@ long refcount_acquire_maybe_null(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *tmp, *n, *m;
+	int idx = 0;
+
+	tmp = bpf_obj_new(typeof(*tmp));
+	if (!tmp)
+		return 3;
+	bpf_obj_drop(tmp);
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	m = bpf_refcount_acquire(n);
+	bpf_rcu_read_unlock();
+
+	bpf_obj_drop(m);
+
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.43.0

