Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E23B2A6
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738075; cv=none; b=ntEqAbfTOz/6Uk++ja4T9qnmefRfH5jSN3A5G/kZOmzqHbPv8HWihwd8n4icHTBTG5jsbXUoMNYVqBkrMOl4A+r+cNozWlzy4QBo5SitHcdPsnZTkIE9258NgmZ4o7/UfX6tPU9ZjfBbXeqcCA5YoLoT6aRBYEDmxzo0ok47Ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738075; c=relaxed/simple;
	bh=mEz9VApgbx0FD0OunFg6ZVIEXnoTzB7glx9OXzO+gGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3/vkTRJmsJ5TyK4Kl7fEfNviZwPPy8Un70edsntcWmJvx1GEHSgTAOHT2vaflEJWiph7UCEUS2rCvx5OvWHuKicDhAaRGMzclx19KAnMfT0JOdBWtmm59qtkN6Aw4HmJy2I+k+lT3Nnys5/avLi5FyZKv5NuO5y9qlNQ0+tnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhgaQDlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhgaQDlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E124C433C7;
	Fri, 29 Mar 2024 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711738075;
	bh=mEz9VApgbx0FD0OunFg6ZVIEXnoTzB7glx9OXzO+gGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhgaQDlS4VyX36xz9ebrrkKizWnzctbqo0jMmP5/H0bAEKIjjWLGtFh/xwFsQFd5o
	 yUH11WsZRQWMDcYzFJWc2sBE+F1qJhA3efLak8ktRc8oyJdMfvxjntwqLuWLK6v5kf
	 WJ7KetnfXRWX+DsjqVI7HkPs0z0POR5SE4uWxTNr0d4QikxOeoR15+E1DrG029rnB4
	 G8FvFAe4gcGJaox5i+pdxwM7nYw49SAspsiHwlw7mYGa3iLQVS/RAPPsh+7yCnqBMk
	 ZBjPHi5b7/YfR0n0Eg7DuioS6I+T64uVnzZ/9mbujRbvQ2Ql/AA8afj6fTrq/nVH+l
	 IfSGCSzqDl41Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/4] bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
Date: Fri, 29 Mar 2024 11:47:40 -0700
Message-ID: <20240329184740.4084786-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using new per-CPU BPF instruction, partially inline
bpf_map_lookup_elem() helper for per-CPU hashmap BPF map. Just like for
normal HASH map, we still generate a call into __htab_map_lookup_elem(),
but after that we resolve per-CPU element address using a new
instruction, saving on extra functions calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e81059faae63..74950f373bab 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2308,6 +2308,26 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 		return NULL;
 }
 
+/* inline bpf_map_lookup_elem() call for per-CPU hashmap */
+static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (!bpf_jit_supports_percpu_insns())
+		return -EOPNOTSUPP;
+
+	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
+		     (void *(*)(struct bpf_map *map, void *key))NULL));
+	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
+				offsetof(struct htab_elem, key) + map->key_size);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+	*insn++ = BPF_LDX_ADDR_PERCPU(BPF_REG_0, BPF_REG_0, 0);
+
+	return insn - insn_buf;
+}
+
 static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
 	struct htab_elem *l;
@@ -2436,6 +2456,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
+	.map_gen_lookup = htab_percpu_map_gen_lookup,
 	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_percpu_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
-- 
2.43.0

