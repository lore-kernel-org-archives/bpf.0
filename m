Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B146D560
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392298; cv=none; b=dVUvCUlpv2fGxp/JmdNg+D9djQ2gWXB1YH/NMnJeGkosScZsnLxdhP/Mpag+mN3lNtoRyhq91YqiKIt8jNTMoUsRDQgvgdUr6lucHQ+8lfbNb9K6AV/l/ilEJM8RHBTYUdCV/d3v5Jw9e+Iq9tJukJojvU/+Gf3B7Hm1A0F//xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392298; c=relaxed/simple;
	bh=HI8OYbfbwsZfJGG/lX7cLhsmE5+vkAxH2ZfYfbT/YVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKuO52fGe3rmE30nNRTZuGF//q2TeIgLtGFZei0NIe4mWut8uVxVYS663PODHqmwBRIjQaAkeGVEfiBnrbk/AyFbBOyzwnqja4jQYnYSkMuoiRLazhgAkY/N1y4kBL+MhXzU7+e7cEC8ffg0nhk0Q0+tS6/M49pPjqsb2ZUyTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyHuDElL; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyHuDElL"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so12297875e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392294; x=1789997094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nf15O+nv66aI5dM4BRK98sPd8ckCDAlARMZVRq7e23g=;
        b=gyHuDElL6i1CMjrS1eyjT5lLd8OedkuoB9Y10VxCcjEDFVifVgOz/I13rHn95ODgZl
         gbzZawKBgU5f1O3GICZbbe5Atdl0xbPgJ1EejNFZs60Q7KR2w0Fj4ZigC1KUH3I9ZG9u
         6viQ1TayiwheeACyrRYOXQPEQBclm8fDEXuh2QmEAb8VEhBegt3Qc7DxrGZ1BPya4rYL
         LK2Z7yFAgAZdkHoF56ukhFuNrIlDh5IiEQ88IHGTn1Lmkrd4sVvSg8dMw65KuTIKkbC8
         dHmORZmvEDHShnDsM/6Kleja7VRirjEHOLmKpvFtnqi8OdiXHwNGpDUu4VTM8/XFLnch
         hJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392294; x=1789997094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nf15O+nv66aI5dM4BRK98sPd8ckCDAlARMZVRq7e23g=;
        b=TcrMg0zRGnX7AWzM6E/OCcP9OXOPFtxcOxjJfnHVvvzvmGsnJKhnBmgx5RS5Yq3l5E
         wcYYiqfpikx3SNptpVDIZLN6pm0/b41B70IjzNarBRlKTog785zN2xg23jGcWoxgA5qb
         I3+Sj20Vyy/rIwzpXPrbzeOFPN/c/1W75SLh3Gywwau5+yD1QnkKomFGWWs6wWAOUWWX
         ++mFcvbjqotSy5QBw5UhCe25yFv2PwSqH9PBcXeYry9ztT2FMmAzT+rpuD79Fkqz10Gd
         t0DzD7wF8ZLBOHRx+uvSU/j5Y+ihFRQyYDxkY3zKNq6WwNB6U4Qcmu7htY+4mZv5F9lt
         kfqQ==
X-Gm-Message-State: AFuF++nrIviaT4X4GZNPL9vKgIY7OYLsIg6NpHq2QiKUkv/yMWZt3M6U
	TrxPxkGGqj6psFdeXo6XKZtuCzTOXb0hc3uK20vaBufyZvuoGjWWWDIUPxOHCRA3
X-Gm-Gg: AYBFou2cMRuKhw1DfqinlyctYXk7kWQt1gjwCgI9xvbTPYS2WLWbQc1HtVS+3gZc7Kc
	FQt+zDMQOJfI2O4tY42IY2d8E6L8QmfN3eyPZ60FXbUgcavYUGgYxbZ5TAZvHHOvpe3XQ+fE3wZ
	cItWDciTJiQo+AgeB/tc+6wfChSmuxy1zaidxiajzQGw2Gu173YzxMiAZMqPq6DPOPCWgeK+8wQ
	OEbn2NbXNc4fq2042AkyIHTMONFCRsQRHaD4IlHMVRlrbGRS+Gaciw4da9CeE/K1deSNc7Ed+V0
	+W6mQWDYaDv2og/RHLu8+dMIOYjNkeVP0665LFxn0DSHmBKXy/A7kwxncny+X8fuLOfFHW1mJ6M
	9nOHsAYRJujXvZO2SvwuCJHDC1WPEqUnlixLtcC1g3XkjFyfsQpVBFIFa4hyM8QyljmtHVu4ogs
	2+P2bn2JodSbYJ/r6sQMASJH/y8KlYneF1QSBZyYOt/r+Qb89wOhjMZ+HHZ4mtnKh92/4lUZepi
	YTSY7Axi3kL+tSdMiFWiDhc1Y814hNDab3EOZrgrDn06yv9ywQiBk5ptnm+HGftJtyYgiu3ippB
	fk5Fw4KP6eXJp4RjmeAa86DRg3IoPa9FDpOrgA==
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr38581715e9.1.1789392289131;
        Mon, 14 Sep 2026 06:24:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb3602eesm25801951f8f.34.2026.09.14.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:24:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Check local object ownership depth
Date: Mon, 14 Sep 2026 15:24:43 +0200
Message-ID: <20260914132444.2564218-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914132444.2564218-1-memxor@gmail.com>
References: <20260914132444.2564218-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11232; i=memxor@gmail.com; h=from:subject; bh=HI8OYbfbwsZfJGG/lX7cLhsmE5+vkAxH2ZfYfbT/YVo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv51ymfOq/u770xn+HwzwLOvYyXM4rLXFj+6bqwR2v1d C8wPuvXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInsb2FkmHJiU6ll+rZYKbY0 FU++NyePHXHKP1d2y702VZZ51++T5xn+KT7Siz/VLisqX6X/QehstKaD+fWTGZ86bqvsM112NHU BIwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Build raw program BTF records to exercise local object ownership without
constructing a runtime chain deep enough to threaten the kernel stack.

Cover referenced-kptr and percpu-kptr self-cycles, a two-type cycle, and a
cycle mixing a graph root with a referenced kptr. The existing graph-only
check accepts these local-kptr cycles and over-limit kptr chains; the fix
rejects them with -ELOOP.

Pin the eight-record depth boundary with a terminal plain object. Exercise
both parent-first and child-first BTF orders, and a shared suffix reached
first through a shorter path. These cases require cached suffix depths to
be checked against the remaining depth budget on each path.

Check list and rbtree chains of three, four, eight, and nine types. This
covers the old graph-only depth boundary and the new explicit bound. The
existing linked-list BTF tests still reject pure graph cycles and now accept
the longer acyclic layouts previously rejected by the conservative rule.

Although bpf_percpu_obj_new() currently rejects types with special fields,
require the percpu cycle to fail at BTF load so future support cannot bypass
the ownership bound. Keep a positive control for a non-owning kptr, which
remains outside the ownership graph.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/local_kptr_ownership.c     | 296 ++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
new file mode 100644
index 000000000000..a487aa68f2ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <bpf/btf.h>
+#include <linux/btf.h>
+#include <test_progs.h>
+
+#define SPIN_LOCK 2
+#define LIST_HEAD 3
+#define LIST_NODE 4
+/* Keep in sync with BTF_MAX_OWNERSHIP_DEPTH. */
+#define MAX_OWNERSHIP_DEPTH 8
+
+static struct btf *init_btf(void)
+{
+	struct btf *btf;
+	int id;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return NULL;
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_EQ(id, 1, "btf__add_int"))
+		goto err_out;
+	id = btf__add_struct(btf, "bpf_spin_lock", 4);
+	if (!ASSERT_EQ(id, SPIN_LOCK, "btf__add_struct bpf_spin_lock"))
+		goto err_out;
+	id = btf__add_struct(btf, "bpf_list_head", 16);
+	if (!ASSERT_EQ(id, LIST_HEAD, "btf__add_struct bpf_list_head"))
+		goto err_out;
+	id = btf__add_struct(btf, "bpf_list_node", 24);
+	if (!ASSERT_EQ(id, LIST_NODE, "btf__add_struct bpf_list_node"))
+		goto err_out;
+	return btf;
+
+err_out:
+	btf__free(btf);
+	return NULL;
+}
+
+static int add_local_kptr(struct btf *btf, int pointee_id, const char *tag)
+{
+	int id;
+
+	id = btf__add_type_tag(btf, tag, pointee_id);
+	if (!ASSERT_GT(id, 0, "btf__add_type_tag"))
+		return id;
+	id = btf__add_ptr(btf, id);
+	ASSERT_GT(id, 0, "btf__add_ptr");
+	return id;
+}
+
+static void test_self_cycle(const char *tag, int expected_err)
+{
+	struct btf *btf;
+	int id, err;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	id = add_local_kptr(btf, 7, tag);
+	if (id <= 0)
+		goto out;
+	id = btf__add_struct(btf, "self_cycle", 8);
+	if (!ASSERT_EQ(id, 7, "btf__add_struct self_cycle"))
+		goto out;
+	err = btf__add_field(btf, "next", 6, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field self_cycle::next"))
+		goto out;
+
+	err = btf__load_into_kernel(btf);
+	ASSERT_EQ(err, expected_err, "check btf");
+out:
+	btf__free(btf);
+}
+
+static void test_aba_cycle(void)
+{
+	struct btf *btf;
+	int id, err;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	id = add_local_kptr(btf, 10, "kptr");
+	if (id <= 0)
+		goto out;
+	id = add_local_kptr(btf, 9, "kptr");
+	if (id <= 0)
+		goto out;
+	id = btf__add_struct(btf, "cycle_a", 8);
+	if (!ASSERT_EQ(id, 9, "btf__add_struct cycle_a"))
+		goto out;
+	err = btf__add_field(btf, "b", 6, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field cycle_a::b"))
+		goto out;
+	id = btf__add_struct(btf, "cycle_b", 8);
+	if (!ASSERT_EQ(id, 10, "btf__add_struct cycle_b"))
+		goto out;
+	err = btf__add_field(btf, "a", 8, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field cycle_b::a"))
+		goto out;
+
+	err = btf__load_into_kernel(btf);
+	ASSERT_EQ(err, -ELOOP, "check btf");
+out:
+	btf__free(btf);
+}
+
+static void test_mixed_cycle(void)
+{
+	struct btf *btf;
+	int id, err;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	id = add_local_kptr(btf, 7, "kptr");
+	if (id <= 0)
+		goto out;
+	id = btf__add_struct(btf, "mixed_owner", 20);
+	if (!ASSERT_EQ(id, 7, "btf__add_struct mixed_owner"))
+		goto out;
+	err = btf__add_field(btf, "root", LIST_HEAD, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field mixed_owner::root"))
+		goto out;
+	err = btf__add_field(btf, "lock", SPIN_LOCK, 128, 0);
+	if (!ASSERT_OK(err, "btf__add_field mixed_owner::lock"))
+		goto out;
+	id = btf__add_decl_tag(btf, "contains:mixed_node:node", 7, 0);
+	if (!ASSERT_EQ(id, 8, "btf__add_decl_tag mixed_owner"))
+		goto out;
+	id = btf__add_struct(btf, "mixed_node", 32);
+	if (!ASSERT_EQ(id, 9, "btf__add_struct mixed_node"))
+		goto out;
+	err = btf__add_field(btf, "node", LIST_NODE, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field mixed_node::node"))
+		goto out;
+	err = btf__add_field(btf, "owner", 6, 192, 0);
+	if (!ASSERT_OK(err, "btf__add_field mixed_node::owner"))
+		goto out;
+
+	err = btf__load_into_kernel(btf);
+	ASSERT_EQ(err, -ELOOP, "check btf");
+out:
+	btf__free(btf);
+}
+
+static void test_acyclic_depth(int depth, bool child_first, bool shared_suffix, int expected_err)
+{
+	int ptr_id[MAX_OWNERSHIP_DEPTH + 1];
+	int first_struct_id;
+	struct btf *btf;
+	int id, err, i, n, pointee_id;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	first_struct_id = 5 + 2 * depth;
+	for (i = 0; i < depth; i++) {
+		if (i == depth - 1)
+			pointee_id = first_struct_id + depth;
+		else
+			pointee_id = first_struct_id + (child_first ? depth - 2 - i : i + 1);
+		ptr_id[i] = add_local_kptr(btf, pointee_id, "kptr");
+		if (ptr_id[i] <= 0)
+			goto out;
+	}
+	for (n = 0; n < depth; n++) {
+		char name[32];
+		int offset = 0;
+
+		i = child_first ? depth - 1 - n : n;
+		snprintf(name, sizeof(name), "owner_%d", i);
+		id = btf__add_struct(btf, name, shared_suffix && !i ? 16 : 8);
+		if (!ASSERT_EQ(id, first_struct_id + n, "btf__add_struct owner"))
+			goto out;
+		if (shared_suffix && !i) {
+			/*
+			 * Visit the shared suffix through the shorter path before
+			 * reaching it again with less remaining depth.
+			 */
+			err = btf__add_field(btf, "suffix", ptr_id[1], 0, 0);
+			if (!ASSERT_OK(err, "btf__add_field owner::suffix"))
+				goto out;
+			offset = 64;
+		}
+		err = btf__add_field(btf, "next", ptr_id[i], offset, 0);
+		if (!ASSERT_OK(err, "btf__add_field owner::next"))
+			goto out;
+	}
+	id = btf__add_struct(btf, "plain_leaf", 4);
+	if (!ASSERT_EQ(id, first_struct_id + depth, "btf__add_struct plain_leaf"))
+		goto out;
+
+	err = btf__load_into_kernel(btf);
+	ASSERT_EQ(err, expected_err, "check btf");
+out:
+	btf__free(btf);
+}
+
+static void test_graph_depth(bool rbtree, int depth, int expected_err)
+{
+	int root_type = LIST_HEAD, node_type = LIST_NODE, node_size = 24;
+	int id, err, i, lock_off, root_off, size;
+	struct btf *btf;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	if (rbtree) {
+		root_type = btf__add_struct(btf, "bpf_rb_root", 16);
+		if (!ASSERT_GT(root_type, 0, "btf__add_struct bpf_rb_root"))
+			goto out;
+		node_type = btf__add_struct(btf, "bpf_rb_node", 32);
+		if (!ASSERT_GT(node_type, 0, "btf__add_struct bpf_rb_node"))
+			goto out;
+		node_size = 32;
+	}
+
+	for (i = 0; i < depth; i++) {
+		char name[32], tag[64];
+
+		lock_off = i ? node_size : 0;
+		root_off = lock_off + 8;
+		size = i == depth - 1 ? node_size : root_off + 16;
+		snprintf(name, sizeof(name), "graph_owner_%d", i);
+		id = btf__add_struct(btf, name, size);
+		if (!ASSERT_GT(id, 0, "btf__add_struct graph_owner"))
+			goto out;
+		if (i) {
+			err = btf__add_field(btf, "node", node_type, 0, 0);
+			if (!ASSERT_OK(err, "btf__add_field graph_owner::node"))
+				goto out;
+		}
+		if (i == depth - 1)
+			continue;
+		err = btf__add_field(btf, "lock", SPIN_LOCK, lock_off * 8, 0);
+		if (!ASSERT_OK(err, "btf__add_field graph_owner::lock"))
+			goto out;
+		err = btf__add_field(btf, "root", root_type, root_off * 8, 0);
+		if (!ASSERT_OK(err, "btf__add_field graph_owner::root"))
+			goto out;
+		snprintf(tag, sizeof(tag), "contains:graph_owner_%d:node", i + 1);
+		err = btf__add_decl_tag(btf, tag, id, i ? 2 : 1);
+		if (!ASSERT_GT(err, 0, "btf__add_decl_tag graph_owner"))
+			goto out;
+	}
+
+	err = btf__load_into_kernel(btf);
+	ASSERT_EQ(err, expected_err, "check btf");
+out:
+	btf__free(btf);
+}
+
+void test_local_kptr_ownership(void)
+{
+	if (test__start_subtest("self_cycle"))
+		test_self_cycle("kptr", -ELOOP);
+	if (test__start_subtest("untrusted_self_cycle"))
+		test_self_cycle("kptr_untrusted", 0);
+	if (test__start_subtest("percpu_self_cycle"))
+		test_self_cycle("percpu_kptr", -ELOOP);
+	if (test__start_subtest("ABA_cycle"))
+		test_aba_cycle();
+	if (test__start_subtest("mixed_graph_root_cycle"))
+		test_mixed_cycle();
+	if (test__start_subtest("max_acyclic"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH, false, false, 0);
+	if (test__start_subtest("too_deep_acyclic"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH + 1, false, false, -ELOOP);
+	if (test__start_subtest("max_acyclic_child_first"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH, true, false, 0);
+	if (test__start_subtest("too_deep_acyclic_child_first"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH + 1, true, false, -ELOOP);
+	if (test__start_subtest("max_acyclic_shared_suffix"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH, false, true, 0);
+	if (test__start_subtest("too_deep_acyclic_shared_suffix"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH + 1, false, true, -ELOOP);
+	if (test__start_subtest("list_three_types"))
+		test_graph_depth(false, 3, 0);
+	if (test__start_subtest("list_four_types"))
+		test_graph_depth(false, 4, 0);
+	if (test__start_subtest("list_max_depth"))
+		test_graph_depth(false, MAX_OWNERSHIP_DEPTH, 0);
+	if (test__start_subtest("list_too_deep"))
+		test_graph_depth(false, MAX_OWNERSHIP_DEPTH + 1, -ELOOP);
+	if (test__start_subtest("rbtree_three_types"))
+		test_graph_depth(true, 3, 0);
+	if (test__start_subtest("rbtree_four_types"))
+		test_graph_depth(true, 4, 0);
+	if (test__start_subtest("rbtree_max_depth"))
+		test_graph_depth(true, MAX_OWNERSHIP_DEPTH, 0);
+	if (test__start_subtest("rbtree_too_deep"))
+		test_graph_depth(true, MAX_OWNERSHIP_DEPTH + 1, -ELOOP);
+}
-- 
2.53.0

