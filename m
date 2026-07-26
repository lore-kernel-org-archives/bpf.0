Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA7302146
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030820; cv=none; b=GHw+AFQpM2jhcC1SwK5zm7vf7pNE8TrRxD9Y3/6uYihL/2qC097m1cljalTAHWokRljhQ8zBkbrKEn6pmtIDwdBhk/gXPusbyZBoF1dzjblNudcFk5kFRQAKKC+vHFs5MtjiWAmgbE4xEQ6A0IaCToifvh3xbivFuvAZDCRo2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030820; c=relaxed/simple;
	bh=OXdVwd8OGB3itgQP8vCJu1V5xVKbEuPPRj5JvFgzmho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKXlTePthXEAPs0rZiowQJFf6gk1JFlw1h+t1S4LF/w3OSV65zLez4R3A5hEzC+TJkrPfeJjzY9eE8z8D5FmsbAQOJatE9zZ1SRpWp7b5GVc/leoPnJBWEZo5YjlXQQPffgGLNsNio+T18tqDIRYyHfB6CvcYhkVGB2OvbY8k54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ66lSdY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ66lSdY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38101f85591so2386285a91.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785030818; x=1785635618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2r5ROGNU8KrJ+Wzlz8Y+8OP3goD10z/nEGFCxckca8=;
        b=PJ66lSdYLkQCP/ZzT2KjYIB53IoM4St7wlZYv2pJX7CowdMvfGBl9+DnFqzqZNpKE1
         APkAD9I8AzCDGwbm92ipdfrl9b3AD/TZwcbL0FnbXT4wET0IiozB69KoN3shqa5vfnv6
         6gYl219XrirnFk3ovKJpAXtRnQH4GIhuq51WnClqJBKGWMUKi2ivHZ8mQen4sStiOMAy
         x9GIAbqwGbVwJqLCJlJ/h5yMh+cvVAAYAMy5dmajcpdFTESV9kR5V0j84hbI/SzOcb1c
         Tv25vZylFZgulJa/P7pTmX2rZZf6REx1OP4VC8VnGrNeBRKfudq78+N0BkdCeOg3o1+s
         3hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785030818; x=1785635618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2r5ROGNU8KrJ+Wzlz8Y+8OP3goD10z/nEGFCxckca8=;
        b=N+UWERheZAemlh/jn/VX2wl/FVWGSWkUYJaCGADkH6691VXB9vCMjZ/DAutpWL5Kyq
         qdLdzGM2CI4Um8rHh7vbT3zeEKTEWvduIhw6aA3oGyLl0pjtMTL+djKZA5pqji7DK2XT
         5rHsH70ZY3tupzof34b4R6VLN6PArSSu2V7W5MBt33KWG16cHg7A4KllKElIWJspvX2u
         040F3yK9AWdTjVMee1dz8qtp75HTL5wef4ouCtsEoP4CAd8EFMDawyZ56tm72abi0Xxa
         7MzYf3UtD7tXiq883f5Pj9m7HLlUkyAL3jLxgJO6YVoD559FSvtP5ohVlezaZe579WtP
         JLsw==
X-Gm-Message-State: AOJu0Yx8y4a6MyWHoxrrtD+c6Xs7T3w2/xeYCRLTZlkMkl1Uw7slIZuY
	t6ltcZhB638b8WGakKAmiZHcDgcC4R7yV6GUq2DbYE2wuRwO1w7dbc9kMUJhXLwkcbo=
X-Gm-Gg: AR+sD13X1XEZC/+LW3VHHw36v70ncMa4MgSMVIh0rN4zsdxdL0z83FmCviE3EHdmP9Q
	GeLEdGgdRaitOAOi/kMAjv1YxKVknMBehLWnk0SFO510wzok0vf+uo3esiPtxkX67zVHWcRMkJq
	WXHf3/XXzq7ymnbitsBq74MAU1fmCjrqB+ZJKkVq0KlzfjsZiC88YVFlogstFFWoXU3EYH0gRoH
	bxVIvXgDVhWsMwwZnWhZhpiLkJgSvfcM13rZenN4yeymD0M9O8C6FWMMwLBPEmamaH6Ccx7yHWC
	kDbgdroFRK19oGTCghWilME3IAFwxzdPZ86LL7SOBKWFWrzY0K9/zF2OcIjuneC10jBzfoOY5mE
	wHC6TPq7bCKp9K8EVT3H9sa2gaT8tg1dFxA0s2asxfSV3Q80ie8FG60hsiDLb0/HQY0uiE1DrSY
	y4n2yaw3OynK9dIbpRZs3cEb5BA+8rUA==
X-Received: by 2002:a17:90b:548f:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-38f2aa99de3mr2686163a91.16.1785030818387;
        Sat, 25 Jul 2026 18:53:38 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f05665ff9sm2466332a91.0.2026.07.25.18.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:53:37 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	davemarchevsky@fb.com,
	greg@kroah.com
Subject: [PATCH bpf] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Sat, 25 Jul 2026 18:53:30 -0700
Message-ID: <20260726015330.705259-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_refcount_acquire() can fail for a refcounted map kptr loaded
within RCU. Another execution can replace the map kptr and drop the
last owning reference after the pointer is loaded but before the
acquire, causing refcount_inc_not_zero() to fail.

check_kfunc_args() currently treats a refcounted pointer as owning
whenever it is not explicitly marked NON_OWN_REF. But an RCU-loaded
map kptr can lack NON_OWN_REF while still being borrowed and absent
from the verifier state's acquired-reference tracking. This sets
arg_owning_ref and causes is_kfunc_ret_null() to suppress KF_RET_NULL,
allowing an unchecked NULL return from bpf_refcount_acquire() to be
passed to bpf_obj_drop().

Require reg_is_referenced() before treating the input as owning. Add
tests for a genuine owning input, a checked borrowed RCU input, and
an unchecked borrowed RCU input.

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

base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
-- 
2.43.0

