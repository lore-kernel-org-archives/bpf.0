Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FBB47986F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655803; cv=none; b=EW5ZuIkZcjc4MvJU33r/JcFwEgcTX84dki+aFrROU8lBSdo2p3dLKFg+oUyOBnkfIvA6lQYISU/Xs2B7GDJ3aOuLOWYb766hRPSEFrbbQbt28XuwrDeWlEl65/YNeTrkzQVb4E+1xgXdZ9PdnaWx6Qj3cCFqMFJlqkr2DbZdOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655803; c=relaxed/simple;
	bh=sAusXOdwVtn6WF9NS8nJSIu1JOY/31ExSEj2AGQ5TPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlDq8kgSG131s78mEA85bNmynn5i3LmnYBfqq/kILo6IgqMEH14HRHdQ/oHPi01NV6+epsJ8fYnMH5i7l/+QQ5bA7raomBXAtfy4h5+Lk2QhyviYRnJFv+rpmdnDlrevjcK0vvv4JKO7J/IWbfe3MLM+SDi3Ol0G6CqQWV8l/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNVXmvHB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNVXmvHB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so443848a91.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655795; x=1787260595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPxZbADhGWNayp+pc6kSWXesxZmSrTwPZr9c/8FZz0Y=;
        b=dNVXmvHB2zMB6zNV/+Xx4F9O48yXwH1CWjVd0ObJ99iA9O7F+vxQyEDUQtVURRNiwJ
         y83k7SPLRpX13O7PZjR2Srp8hs0W+n9Shbe4oK3KXpFTlHcsNK5I4+N9eCS17GE5mKEg
         KDRZNPu2r2Y9VnbGPgq0JnnIXdwB9wt+hxsl4uhcgHQeScXM2tb5AtX7TTALNEy5FRvV
         zkwfNXqwVhJd41RwDHmLS3cIyYCIzzzPy16n+yK3ZRun10i+FqiwZw3sPfV4EZaXu2hh
         AtSMTsFuj83VGG0fqXdedGd0vsCNKCYNoX12QBB6Tu4SgBWpxywUnsMfKdYykA08fsUb
         X/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655795; x=1787260595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPxZbADhGWNayp+pc6kSWXesxZmSrTwPZr9c/8FZz0Y=;
        b=VJGuweBGLioMSFNlSFRsJ0s3ihfPMQbnFcZLwmfWDba2h6P07oYI/kl5S6IJ6hEfqj
         mj949aqRxmHCTYcPv107+8PyCh990eR1nODhSJ87JivleFuWjkO1yEOBdW5NCvPRHNV0
         yT/6nYlbkicyF9JCBYaiynHuOGKOQKbWJFzFNQ8jAvslXLhfUedDcGnihdJPIIbH4VcT
         Ao/JZOcyM46D92Diu0LDcP5mrIY89UNgnMdbcoj4HYUMXYfAkTtEw2DL8cxwKPYiBuOq
         Ix9svEnRv34YGU9+H3PVrQeBGkiakaw/08Ur7XGSnWBopzLdw68YPezwNcyyRHCZ8iwy
         spUA==
X-Gm-Message-State: AOJu0Ywna5Y6KCwMbBC4JC01H7I96qhztd+Ope3XCwGp18EDxU+tUo9b
	4tU2tzOw2gbRp0q5Yx26kXEDtp8vAALBd3WGhA751QyE8rhTFYtKbB6o38p7Jg==
X-Gm-Gg: AR+sD12yGunalXJuhaIFyC4o1S/UY48JyiwSusO9ekAsoDZ3drIa84fpxrYFPT8FWeK
	biaoWyEidggDodd2LU7xsPpOLT/ij5tNSYhAJ87Xy0xiNHTprUlKQXlSmR+9RZH2OC04kzAJ1pc
	WMC7FnrNO7ZyU0zd7s/NN/kL9S2QjU+8C48raUK3oK46l93qfH3TqashuNXg2nAeesCUAsxBEMu
	fnh4BexaT4tXKEtWbeiQQUfRx4zb7RYcBD0sP4y2zPEMUK5TeDJcLeJ05Uwjnu4NRDOR/2JT8RB
	HNq9UdSYL1YrtV1QNXQVT5IVIQfA25K7+J4YQz7IM/xnXCG43+Ml1CJ2a01L9tVJtLXDu+eba9H
	KtzSIn9UXp6hkd1uGeo64ymFZ97L9WZ+xgsTfyGXLRBGdnBUWybprrgZQfE3V4hbgp6RAS42B22
	OzWY4enJb8W/ksbsGNkjM+h8x6HshxQPs+TixsnC0tF6cMmJbvhiMjxvg86gSDDAO9XN80ynVnn
	5ZVZRTP5/ccseNw
X-Received: by 2002:a17:90b:3d8b:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3933b77ece8mr1072781a91.1.1786655794693;
        Thu, 13 Aug 2026 14:16:34 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a03e288sm853985a91.17.2026.08.13.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:16:34 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	dingning04@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Kaitao Cheng <chengkaitao@kylinos.cn>,
	Viktor Malik <vmalik@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/4] selftests/bpf: Test refcount_acquire return nullability
Date: Thu, 13 Aug 2026 14:15:24 -0700
Message-ID: <20260813211533.290256-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813211533.290256-1-dingning04@gmail.com>
References: <20260813211533.290256-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier could accept an unchecked bpf_refcount_acquire() result for a
borrowed RCU-loaded map kptr. If the call returns NULL, passing the result
to bpf_obj_drop() can crash the kernel.

Add tests showing that an owned input remains non-NULL, a checked borrowed
result is accepted, and an unchecked borrowed result is rejected.

Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 47 ++++++++++++++
 2 files changed, 108 insertions(+)

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

