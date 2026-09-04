Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB243B47E2
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511419; cv=none; b=IoF8PXazf56Y/KRjuZu9dwzeZg3eHmSpy/HEK/jp5vi6Kna6hqNEccWRFNGmjFz/ZTOPbSUSDn353JbGVcc7aXOkZwoNiqFa4pFMBlFpNEjhJb/jVp9948wiDlf2vAhCeqN1jFgJvrpIKl/MIj4NSiST3d8lxFi3Q8wURkrIqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511419; c=relaxed/simple;
	bh=0MK/1vHBzzhTURRUKQy4j2L9v1WRrDtI1seH1rX0gmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUPN/U6NsVG4NncR9PsR1vpLJV1JpwAIy+6Rg7Ps093F78s8q1DYkuF3ziNsrDiAj+19Wky9gXaP91pnJLYK5y/DgcNJlVYLEPHFMWHKFhlIxVDeNPcrFiQBkcTANMDoH6Dj6Uz5yu5vYDYPK6mjYFRSn+s8PUARq6ndsFVaobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4NK5V8V; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4NK5V8V"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48435ac8b67so245836f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511413; x=1789116213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELbJ+WjcfntlbL3fN0mO6/7n+YMo3z5D5gkg8Af3aKo=;
        b=V4NK5V8V2rsJk2a3nJqo9lXqRLkuXPMdlNl/iL0NlqtyxIK8CbebPusq+TG+H17YgM
         YF7g02WY173Gm1x3+/uIpRgVG2ZDyKrMwp5eon1Up4TqbkqnvPjrnpAGksuY00FN3Uz+
         bkXK0ZyUjXJRN3u4oLSOvFAjD7N9dXDmDg1aiKaa9c09du0Ll2u+Oi9tDlzH6SjvBeUj
         8nbDGicgL6fq73O4zwZIanQh/9tA6MHD5SJ4igThMuHPipGY795n8yjY72KXYtmozy+V
         /1OKnufJlK2HBOr70l+yheOEAixmKFSxY7KdXy3/C+AOfRkyj7u+TdncP+TleYJ47Un4
         EhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511413; x=1789116213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELbJ+WjcfntlbL3fN0mO6/7n+YMo3z5D5gkg8Af3aKo=;
        b=cQq9D7xjgywTjwtI8deu5ZjhIaInqiBKM49xX1askX7+4ZCk0PYTBBMjjqm9Pov6ml
         2Q7o5H4d5ZXmZj6o/Qm9mllkI44b1TxDed7xjbQg2hZAuq+QGJXmpmMgK3p3Bq4Xmtax
         RSssj7e6yMVRhJO08Qq3bsAL0nvDhuGBBPS9+Nbe9ZfIJoWe/hE4/v+nHA1tLsfphW1t
         KLjRhU6lPNsuti0ej2diBSt8oe6aXj5jrSm8kqKKEKbP0Vc5vpUQS/RiGBTcDGF3K+aa
         z5SYWlEjCIw1iT7SqRXIdqtt3b5SADPkRO+yLmssEk0GNMeBelX27rQ/0AbFbFhDyvno
         sSvg==
X-Gm-Message-State: AFuF++mm0rmL8S4xNHSvDgyXD31NdfLAdVPPOk5lRPDzZLptLBeUcWhn
	JjfU47tJMYZMd274iXEoAYLxnLXr1dM4X+X6H81Py9A8pqk4u0UYN9CQjZLXbsYD
X-Gm-Gg: AYBFou3Ui1FgCzZxkcp2In1Yu++Kaxyy+aWtVzuyFd39e9B9V5+V5p5fEGDzTYgdVOI
	PHkXh1Y0/JVJJhFjzQjq8Dlk1ON+kMel5yl2R+vFs8t4rzri2OexPBc7pk7jD2MA+L05LFhXzGu
	UR+FGlXYpysY64zwqctBXfmPRW2L6ciBfSfkuUcQhowikPOTqUC9U/bs59TD0XLbNmKRHFcWMEy
	5Mr+dGmQa9JPvUSWE2WuePh55GhKbzYQMS6rNRUVXC5zMypsxkwc6lEmCjlrqScr33mf9Xgz7IE
	apSXSgo69uMlvXEJI0W3CDDz7eFqoxG+wHnxhIJjT8i/e/q0uP7ue5hG9CVanvYDCo8GSxBL9s6
	LZ0+LSrNLEl46IJTEpjc+32K5kSQaatCAmumTcXI2WVZJlqg3dSHFol82ifANEOr8vle1rex1GZ
	Kejp9x/gIYdz5bndINZVPwITHJUT330vqjds3Pu3l6sRJmahFa+pI2z7Tf7NlWgAhyHw/1IPxkX
	azEDCAA8oeDTQFJpKNE5Um31mWS62qG+JSXy0Ql7xZU8ixiEgYq3qrD2Ftjk8jUJqwfYaEppdkd
	vcLOhHDd5P64slpkayJ//h7l+3s=
X-Received: by 2002:a5d:59ca:0:b0:485:8354:d82d with SMTP id ffacd0b85a97d-4858728f4e7mr7326582f8f.23.1788511412783;
        Fri, 04 Sep 2026 01:43:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm5728536f8f.33.2026.09.04.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:32 -0700 (PDT)
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
Subject: [PATCH bpf v2 4/8] selftests/bpf: Test borrowed refcount acquisition nullability
Date: Fri,  4 Sep 2026 10:43:17 +0200
Message-ID: <20260904084325.52250-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5124; i=memxor@gmail.com; h=from:subject; bh=q/QgVUgzcomIJLGCTSOdg37A4pBzWy/hViRuH0EgSwQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy8QWUVOP2p36uazvpTiu96o/TY6y+Dz3546XnoY1H poLHfw6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGT1xgZLne8CDz68NTdx0wG 7F3Lf3fGCV2d/bk8KbHaNl2W3ynCleGf8epTa/ybdYvTVXjmTN9ZeVB6zYIP/m3yfZU+FSHPyx4 wAAA=
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

