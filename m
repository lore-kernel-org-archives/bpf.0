Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6B41A903
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503822; cv=none; b=GnwJLBh1jhDXro6Bagw0/16R1ug5sK8PT21L0MuB6B69AQ3eLq9wb4/bkVtTf/Y9ER2OOMFgIYiZrxI/dwHnwAbY2CaCwaWRK4crB5pOIOsMhNsK0++tKO6/RaMg1DsJJ5DPN+wc5/RuT6Eefy+p37/FDpSYNRAzsZ/is4BGcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503822; c=relaxed/simple;
	bh=0MK/1vHBzzhTURRUKQy4j2L9v1WRrDtI1seH1rX0gmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3b5cOCIKENxV03hdbSWUceya1oxeytVl749N9nIi/HMDqcgGLvKZ8PlBLXLmUWNp0IjLrFKqM5wq47+I/2s46AHoeGZ131RyPaIhsw5slfVEmJPKqg+fWw5GzTP8YRbOSJzv4qH8FbGcZkHcPhFGQ7oUUuKiom9MmcykpUqeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJVus4Ph; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJVus4Ph"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499b5f5151fso1588565e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503819; x=1789108619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELbJ+WjcfntlbL3fN0mO6/7n+YMo3z5D5gkg8Af3aKo=;
        b=EJVus4Ph8+DsfPBH3tJqP9Du+2lIyBMQaTmHgyRHjU6dXSbnB0FhAtNaUn0wouoncX
         sLWtIVuLHPNDL6MHj2+1kFg4pTosZpelHTCi7msIitmr5Jt8LQ6ixQv+HKDZzq/E9VSE
         Qf9NkWuz/AOoWu2oVAUO/ZuWwbBWiKjM5ZuBp1plfv2vIzzk0yD0fHnkWxir1DK+wELu
         lkkf4W/8OQpmksowbuwVd5/XB0ID7xFeA3YfuxYa6tbu8YTG0detV7wZprdW6/kOpekY
         Gw6Sriv4NjC8vnM7FpC6RtIytT8gD194huuMCj4T8hlw5hXmWAeRk1qtjlOpto4twbiA
         f8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503819; x=1789108619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELbJ+WjcfntlbL3fN0mO6/7n+YMo3z5D5gkg8Af3aKo=;
        b=ImR8jxYzH57kLxCrovUryTAAUEYmYdMzVoKsM8ZjTIXwM4G+qOddggIvnwNSPUd/u0
         Y4GI8kdEgPueD64kFgF6YNRjHAMmMbukOEhWpbKBcuWnWlei++Jf/f7MPVAcn8Og94uO
         mhqBR/yUjnHaMTxTjsxptZHgJMv5fe1UvryMesx/0d3Z289rojrIOAamJh9dmJo3pg6b
         6l6eygFtn7VbEwlvaGy7+hVJfXBQik6wC8KDT9V0XwvVDpUQ29gHB0MBONNoiHkQYGhS
         bj6sCn5wZkHKV7C0cEh8JCJKvThfWlo3M8HfMy9UX4XcnnsN6sL9MQi7eVl+tj7a/SET
         XrEQ==
X-Gm-Message-State: AFuF++kUOkMSmSiZ/qR0pZgwa96PwMQzaSk6hsetYdcWUwiMC5ZNWFeN
	o3/YnSZla3SiiOv+LPZLzn4wX+FC11ZVpbtZ4cXPRQObQVbucyl2egE6HSgWB6jv
X-Gm-Gg: AYBFou1TIwELlSN4YNnysHHcGIKG3sPOjVM2hCX4HkK0zznkNmuwVpoo5XN/ygp9Sdj
	cui4hre9bJYkbadpoLxS0WdTo7yXd7CuABGZmYoTQzhjEo8Fm8e0AOzISM8jm0GjdJBKIR8f+AX
	vdzoNWUm3KNx0quPWH6i6jgRfV96NdXV2FScqpkN6u8XqZUjwFSGAOXAnkYyi0iqlKq2InePIwG
	YoDPcqezbq9aeGfzhLfPFijXrfxUJOxsFaCl/z7XTkhFN2ZDuELXNr7dU41qMADG1HVHDiFSNzb
	TlzJZWDAPvzimiE20Sj/JsPb/f+pJZJdcApwt1WrG41q41RRhnLAJa4jCdCysQLCxrpYydF2NFX
	cDk/tCdKmXX6b8nRkjhcFF8sIvYEWvmpaS+U5AmyxtyGH3cn+5JvT87V+VmtOVb3/L0QnHNKJlg
	Eq2UuJhW+hAu23cnbRooEb25EAS3BhP1NpfVDaIbjkGT/crQtvovG2kD9rqfNsVSD29vzdh1T/Q
	JWsPjvMo2k4HhJnjtnK9U8dN5fjalMaj1qJ0549VC1HsiFkH8ZbsNxUi2mAwMHvalGoKrqTiLGi
	NlneEfOAcZApfEjsJfug+aismyI=
X-Received: by 2002:a05:600c:64c8:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49cf81f692bmr57266525e9.7.1788503818407;
        Thu, 03 Sep 2026 23:36:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5941cb4sm80881035e9.4.2026.09.03.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 4/8] selftests/bpf: Test borrowed refcount acquisition nullability
Date: Fri,  4 Sep 2026 08:36:42 +0200
Message-ID: <20260904063650.3877826-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5124; i=memxor@gmail.com; h=from:subject; bh=q/QgVUgzcomIJLGCTSOdg37A4pBzWy/hViRuH0EgSwQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2qUWUVOP2p36uazvpTiu96o/TY6y+Dz3546XnoY1H poLHfw6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHZkQx/eJ1enTL68fbfeybn +59ZK21/5bn4BMqnvmTRmuAa9n/TbEaGBV/MWmWaF8T1ThRd9ctVYN1Mi7wl05ukXZeds3LXqF7 MCgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

Add verifier coverage for the distinction between owning and borrowed
arguments to bpf_refcount_acquire().

An owning pointer returned by bpf_obj_new() must continue producing a
non-NULL result without an extra check. An RCU-loaded local kptr is only
borrowed, so a checked result must load successfully while passing an
unchecked result to bpf_obj_drop() must be rejected as possibly NULL.

Use a sleepable syscall program for the borrowed cases so the explicit RCU
critical section is what permits the local kptr load. Without the verifier
fix, the unchecked case is incorrectly accepted. With it, the verifier
rejects the possibly NULL argument.

Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 48 +++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 61906f48025c..cae00f7b0a24 100644
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
+SEC("?syscall")
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
index eaaed0859f94..7d2f8897e5ad 100644
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
@@ -89,6 +105,38 @@ long refcount_acquire_non_object(void *ctx)
 	return bpf_refcount_acquire(ctx) != NULL;
 }
 
+SEC("?syscall")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *tmp, *n, *m;
+	int idx = 0;
+
+	/* Force Clang to emit complete BTF for struct node_refcount_only. */
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
2.53.0

