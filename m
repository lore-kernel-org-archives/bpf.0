Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21132C0285;
	Mon, 27 Apr 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287074; cv=none; b=Doak0CDkbgHnznHeTmUL+Xsn25vvmv0JwK/Y/vBgz+wrF9TOAhNw8jZDQaI94GyMyZ5ov/dYGE+rPJJM1lKiKAuV9BxsgsYo/DX8c0hpnQ7hfwIEHZIJgpEV2vFdBaM542J3tyTKRch323gmTG0KT2y+o2dus24tJYQygnRocsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287074; c=relaxed/simple;
	bh=dNUHBSogtkXzazl8fwvquDBzKKPdwEYjS0vm15aFiXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrjXGIv8T8BsvyIz9Z4kfapw6S4E6iB2SJHjWF4Ms3I7pXjgYMTf0vZzZ+79i/xZKwEJ/VOsu4lyMDMJfcJz+UGIdfGZCJ2SZzEPJPBniNjTfz63H1xeUudODrxtPsRQSLcEyFgtXUjZn4C0hPIGNH2fOlsFKXsrmksaI/G6kqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQRQqAz0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQRQqAz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705DBC2BCB4;
	Mon, 27 Apr 2026 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287074;
	bh=dNUHBSogtkXzazl8fwvquDBzKKPdwEYjS0vm15aFiXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQRQqAz0e9BWhlDehRjzPahDDD2UbzEnYcVF3d6R1MnEZpeWXTzp4UGu282Cb8PKE
	 9yqNc0PjQZu6DVtQMpy8lr/GUVISRNcdsm71262/F9RmlUv+AXGT5Wp8uGpotoGcCE
	 dEozg0Ps7jvf/qXfT0YH/ZievJ2TBvgBHYMTrmH3k486tXCgVFPwvsxNJ73hFPFFm7
	 tvO9E/0YW94s66BcKeqpRXo9HVT7WwjWKSKmNM16v6p+rAIts1GymTBlytfMagznGz
	 E1bp0aiSilBOFyb1nkCrudS6dH80YgEJ06393DalUFxOY4/YTOrly6gxeLjD4vokzV
	 eJibmT+dvNCFQ==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] bpf: Add bpf_struct_ops_for_each_prog()
Date: Mon, 27 Apr 2026 00:51:04 -1000
Message-ID: <20260427105109.2554518-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105109.2554518-1-tj@kernel.org>
References: <20260427105109.2554518-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper that walks the member progs of the struct_ops map
containing a given @kdata vmtable. struct_ops ->reg() callbacks (and
similar) sometimes need to inspect the loaded BPF programs, e.g. to
discover maps they reference via prog->aux->used_maps.

The implementation mirrors bpf_struct_ops_id(): container_of @kdata
to recover the bpf_struct_ops_map, then iterate st_map->links[i]->prog
for i in [0, funcs_cnt). Same access pattern, no new locking - by the
time ->reg() fires st_map is fully populated and stable.

A sched_ext follow-up uses this to require cid-form schedulers to use
exactly one BPF_F_ARENA_MAP_ALWAYS arena across their member progs,
without requiring the BPF program to call a registration kfunc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index af54705611d7..f4e4360b81f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2128,6 +2128,9 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
 void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
+int bpf_struct_ops_for_each_prog(const void *kdata,
+				 int (*cb)(struct bpf_prog *prog, void *data),
+				 void *data);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 05b366b821c3..16aec18ed31b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1203,6 +1203,42 @@ u32 bpf_struct_ops_id(const void *kdata)
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
 
+/**
+ * bpf_struct_ops_for_each_prog - Invoke @cb for each member prog
+ * @kdata: kernel-side struct_ops vmtable (the @kdata arg to ->reg/->update/->unreg)
+ * @cb: callback invoked once per member prog; non-zero return stops iteration
+ * @data: opaque argument passed to @cb
+ *
+ * Walks the struct_ops member progs registered on the map containing @kdata.
+ * Intended for use from struct_ops ->reg() callbacks (and similar) that need to
+ * inspect the loaded BPF programs (for example to discover maps they reference
+ * via @prog->aux->used_maps).
+ *
+ * Return 0 if iteration completed, otherwise the first non-zero @cb return.
+ */
+int bpf_struct_ops_for_each_prog(const void *kdata,
+				 int (*cb)(struct bpf_prog *prog, void *data),
+				 void *data)
+{
+	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
+	u32 i;
+	int ret;
+
+	kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
+	st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->links[i])
+			continue;
+		ret = cb(st_map->links[i]->prog, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
+
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-- 
2.53.0

