Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BF3D47DD;
	Wed, 20 May 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321061; cv=none; b=HDHbguAOxgT25/HAIQiKK2lydHLP6CuTOX3441AZP9Z5COm5Affa7v8YpB44VyH7oN54JWMCyWXi5xKWfaqgX0rc9XJFENzTVhVdyysunKS2XlnGFnUcrRCYqoHIiRhyeJMG8JDaAu8nMubWDnaKuUjhSufpE+Uoi7jWDAWoS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321061; c=relaxed/simple;
	bh=cstOV2+2ci8zXNA1Qt+GQw2l2x7LM8SwWqJ3hidZguY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtDyoi4PjW+mEV/3/2+qlJP+SkRDiRuxcR6VQx6VKujN2gKkiivk0Z8AP6Ilrclt78zd3Qt7Zp3h8xe0aEoI9s9cCY8jSv00MiQvYlkkMY2I6LvRrbJj/d23lQoUdnYU3NoH5UznflH9soBOywslfC3NQDEgphytHsLBioH0VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APzU+iQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APzU+iQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464B71F00A3E;
	Wed, 20 May 2026 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321057;
	bh=xK8/4hQ0j9g1pID7Vdqyu8/i/yh91hlV7Ni1mBkOJ+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APzU+iQv4rh0acB52YSaIyInFGYquGdEFeHHg3Fl9plQlL7b7DbLT+9iJfSaFsLcx
	 MkmbH9ysihwjXG9bUD1tTnDPczpxmmhKRbNEU0fDa3OcDDPhVzxSUohYpXiDJhAdo4
	 7WfnC7nLPVEt2oHSckKZRJFvHnoqdCw3llehZ7zK4wnPubZuOnW/3UZDe46a0Nn/Vb
	 x0C57aQKa2p/VbfZEu01bvgSVUCCwQvIb6tfiYimIML+VtIeGozykQeicAk1xDrEV0
	 uvgLtPjdtbNZ7J5c02Neqnf+iayG22GobtiwFjl1JbKJKk6uEIWNUYLuPOgGnoXdse
	 W+asDJLa6Of8g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/8] bpf: Add bpf_struct_ops_for_each_prog()
Date: Wed, 20 May 2026 13:50:48 -1000
Message-ID: <20260520235052.4180316-5-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520235052.4180316-1-tj@kernel.org>
References: <20260520235052.4180316-1-tj@kernel.org>
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

A sched_ext follow-up walks the member progs of a cid-form scheduler's
struct_ops map, reads prog->aux->arena directly, and requires all member
progs to reference exactly one arena, without requiring the BPF program
to call a registration kfunc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64968ca6db51..5b99d786e98c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2129,6 +2129,9 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
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
2.54.0

