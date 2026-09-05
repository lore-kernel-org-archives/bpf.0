Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF13955D9
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599280; cv=none; b=Hnol/fVyk0jHV8D4phE3485svy0696XHLPCswVk4xxtXITjpKGYVSntf0zcMqtf/ridgZqnYoZ6f1JmWcta5n24Lk9e24K2F4CYHi9Jsy4Phyw4fZB8W1pkRLbdSbSLVmktLeuD3DSSMGpwqsbBInC2XsCk43bMReAXGbdBORNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599280; c=relaxed/simple;
	bh=MQD23V5h+bsrXOq4b2JJkh5E1cOcs8YcanBejKUxM/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t76B7bnjWIgSTkZ043G471ejg6NdYa9CgM/3EPXWveZFNvc8oo3pLX5YyvX+t6tiMCDFolmTGrGQ0uBjq9PZXoHQ85WSkQlKu2Ydnrv7dLnda2CbMYm0sYUpOpoJ+49UJkvYfOFaY8qt2pSYXxqbKq5YudZ2M3wPuJnX/SOHLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNhHQK7K; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNhHQK7K"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso8358455e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599277; x=1789204077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fVEoaAeHpetDYrx6QYtXVZ40aGGi2jKjOkYTDlRiPo=;
        b=gNhHQK7KVnbF1HZDR6Ki+hvvmf1ekKlm5FNgQrrnC34bdRS0HIiS3hFs1UaZy+GnkO
         05N70CmmSiTasMFG4aMBkQ3mgnOTMHl0uvdiJ/4Daa10Em0Dnlb2voeD8ZSRp/R5SwBV
         5KsfxnIczDsm/3Om871cF3DD/0QubJjkML4OuwAPZFbuVvrj5AMqLWtI88q1hNZuGVIh
         Nt6J3VmijLyCI1XpoONHVyk1epqFWjP+9Jm+eJJVCqLuX+JJ6x9QfvtJyJJKpIk+8Meo
         8bdS4zC00YvfBymjajzXgEc7sdPC5yB66oWDGuknB5sJ4QJuBlNTyo/OFnHhpNtf12A4
         TG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599277; x=1789204077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fVEoaAeHpetDYrx6QYtXVZ40aGGi2jKjOkYTDlRiPo=;
        b=WO0vsbfkGlFLuCJlgVTjmLVJh8DWlpLfYBJTYbSrST4OC/4f8tVFCJz1ti4ZzTQSWE
         Cd8O39GCqnlWxoRdomT51AabNh600iN1oYsAMMoHrvCbltsDPnxIuFyCbQ8/VmqmRidu
         eBumGiS8vE/AzBoUo4nNu0sbER5/AqDg8QdzqUuSzXSc101LmUa0bDNhT7008WYaDka6
         X4N/z3z39mroR4Kj71mk/l2fPtiWsEQSAGyVD5ERNUxIjaKUBxKQy3CvZUstTMnzR0xu
         GGF2I4llwFD6GvuO6JhgzL4iP8yaxVQY83/3AlnxykZDu+8nrOQhCUUtQEmplgW+tUaB
         jX9A==
X-Gm-Message-State: AFuF++n0mr6BFNImWTXWfqvdISsW/kW7t/4ELlH3gthAI9AldBYQC9s0
	EvVeYzzWzY/jtAkGIUxJi/h2lZv++vX+jYrgKj4LU0gptyjLDNIoqjrQjRdUt6LT
X-Gm-Gg: AYBFou2ozP7f37IHTWQ+uaJ1whGmC3lNxdc0bUVq4vNjt3NBlfZycG8l0h7JYQ6upaE
	VjzFhvozFc903eimcvwdPihO4ZR3/Y1AFCR056brUU6Yf2DnUOv+OSobQvV3mbpLH8Pw2jd2Ph2
	a98aXiZXRSFnzJsbil+uipMgHc5FT6Pz1GheRKJwQFwni+aSb8CvonYtBb4KXCFOIFUpXXtfZWx
	XZ+/YRp6Ofm8aUATyzUGYyhlpbrbNxbUZSJAphJ9zEk/D9I2Gho9TkIcU+xLGKG/ta4516OYl2M
	BiHixaJeSGl6irEn8TEklYedNEtgXBadqwEuQm1FgpEoKlolsVZg1ccpLagX76Jil8JrekOwtJk
	l7zXGVSDK/d3oZD29At84O3tou8hCQ6mSwbo1y0GgMkb1JigbIO+oRxwOKSCFJTCSk/LgEDWain
	X+0xweuBY7v0l+fk8VvWQBzzg/IXtrJQ9L6wNbG/hwivTWs/2gHLq5wizTxZnqJtQf6HsFiqETM
	KZ2F39IoM0dme/lROrZ41P6qrjjENL0tr27jOIrzHv7y/VDv5b0QommNkrMdlNt5sX6c2XdV83H
	RPuhbKup9nA7h08RlZprz9Yw690=
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49cf82524a2mr157150495e9.14.1788599276558;
        Sat, 05 Sep 2026 02:07:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm283057185e9.15.2026.09.05.02.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:07:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Check local object ownership depth
Date: Sat,  5 Sep 2026 11:07:48 +0200
Message-ID: <20260905090750.4064411-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905090750.4064411-1-memxor@gmail.com>
References: <20260905090750.4064411-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7075; i=memxor@gmail.com; h=from:subject; bh=MQD23V5h+bsrXOq4b2JJkh5E1cOcs8YcanBejKUxM/s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2rfefDMV3Hn1n3WA5/5HF0XfnHI2nLb9/59uOqX7sE 47yX7yyuqOUhUGMi0FWTJGl5P8+JuMTlb8DbZdxw8xhZQIZwsDFKQATmcXFyNCx2GL7tQ9PGUss V4i8f1ucddzszLzNLq/eLuPTslSwFp3P8D97SaDif/7HGjW28+LM9fr/FZzzeMccNv1HpCH7tkN Z0kwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Build raw program BTF records to exercise local object ownership without
constructing a runtime chain deep enough to threaten the kernel stack.

Cover referenced-kptr and percpu-kptr self-cycles, a two-type cycle, and a
cycle mixing a graph root with a referenced kptr. Also pin the accepted
depth boundary with a terminal plain object. A kernel without the ownership
graph check accepts every cycle and the over-limit chain, while the fix
rejects them with -ELOOP.

Although bpf_percpu_obj_new() currently rejects types with special fields,
require the percpu cycle to fail at BTF load so future support cannot bypass
the ownership bound. Keep a positive control for a non-owning kptr, which
remains outside the ownership graph.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/local_kptr_ownership.c     | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
new file mode 100644
index 000000000000..83674155e3b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
@@ -0,0 +1,202 @@
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
+static void test_acyclic_depth(int depth, int expected_err)
+{
+	int ptr_id[MAX_OWNERSHIP_DEPTH + 1];
+	int first_struct_id;
+	struct btf *btf;
+	int id, err, i;
+
+	btf = init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+	first_struct_id = 5 + 2 * depth;
+	for (i = 0; i < depth; i++) {
+		ptr_id[i] = add_local_kptr(btf, first_struct_id + i + 1, "kptr");
+		if (ptr_id[i] <= 0)
+			goto out;
+	}
+	for (i = 0; i < depth; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "owner_%d", i);
+		id = btf__add_struct(btf, name, 8);
+		if (!ASSERT_EQ(id, first_struct_id + i, "btf__add_struct owner"))
+			goto out;
+		err = btf__add_field(btf, "next", ptr_id[i], 0, 0);
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
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH, 0);
+	if (test__start_subtest("too_deep_acyclic"))
+		test_acyclic_depth(MAX_OWNERSHIP_DEPTH + 1, -ELOOP);
+}
-- 
2.53.0

