Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29F3BFE5C
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746687; cv=none; b=ssL6plXVOpKFkIU1L04FEn+SVqeSG5gnh/pjpYpfTQZNe5HaUcUfmHi3lFh+j96dTTw97oBNqqShHk3I7wOVOaxMfdKiqiwL4fwvu8zdUgelIBP0nLZo80QMJJHT5H7z/NSeLV9BULctGMPppIwFLjmvYd0bpEDEmljP8LKjfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746687; c=relaxed/simple;
	bh=xpzzIguqBMOLggyP7VwCCUMdT8hqLEhAhmY7rxzjAHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPfksOQUqmRK00QaVfAoqwb/0h1j8QAukEdwufGl74UIJ7A2qFrYf+kcw4OvbIlie9HGrIp1EXfpbvMDr9df1GdP2AiMrNSjvOP8SpKMA6LzoDWnYxNS6BcoEn1JGnbqKpSyShMTymL6PMx7Qw9fGWZB1o3czzaB1zIJYnJnag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fvgGSx2s; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fvgGSx2s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782746680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUwG9zkqnvlaZgRxQNZU8OaRWjlk6ZJe7sTRgdJuNYc=;
	b=fvgGSx2svGfMAfRB5GXfNei1ZkcFqyKMu9eviH/k/n44MM/MDPC/QlTrf1zQaw+GWsX/S0
	mF4x++ptZMKn7ARtmCs/8JwcBqHAlV9rr1cKm5DTBig248C68SOIre4HZpDODxmt1zor0V
	AG/sWgFZhtus9KJbZnf+n8f/aUdQMqw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 2/9] bpf: Introduce global percpu data
Date: Mon, 29 Jun 2026 23:23:59 +0800
Message-ID: <20260629152406.52582-3-leon.hwang@linux.dev>
In-Reply-To: <20260629152406.52582-1-leon.hwang@linux.dev>
References: <20260629152406.52582-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce global percpu data, inspired by the commit
6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
definition of global percpu variables in BPF, similar to the
include/linux/percpu-defs.h::DEFINE_PER_CPU() macro.

For example, in BPF, it is able to define a global percpu variable like:

int data SEC(".percpu");

With this patch, tools like retsnoop [1] and bpfsnoop [2] can simplify
their BPF code for handling LBRs. The code can be updated from

static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");

to

static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs");

This eliminates the need to retrieve the CPU ID using the
bpf_get_smp_processor_id() helper.

Additionally, by reusing global percpu data map, sharing information
between tail callers and callees or freplace callers and callees becomes
simpler compared to reusing percpu_array maps.

Links:
[1] https://github.com/anakryiko/retsnoop
[2] https://github.com/bpfsnoop/bpfsnoop

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/arraymap.c   | 38 ++++++++++++++++++++++++++++++++++++--
 kernel/bpf/const_fold.c |  1 -
 kernel/bpf/fixups.c     | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c   | 15 +++++++++++++++
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..c4e9430941e5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -259,6 +259,37 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
 }
 
+static int percpu_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (off >= map->value_size)
+		return -EINVAL;
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+
+	*imm = (u64)(__force unsigned long) array->pptrs[0];
+	return 0;
+}
+
+static int percpu_array_map_direct_value_meta(const struct bpf_map *map, u64 imm, u32 *off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u64 base = (u64)(__force unsigned long) array->pptrs[0];
+
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (imm < base || imm >= base + array->elem_size)
+		return -ENOENT;
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+
+	*off = imm - base;
+	return 0;
+}
+
 /* emit BPF instructions equivalent to C code of percpu_array_map_lookup_elem() */
 static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
@@ -551,9 +582,10 @@ static int array_map_check_btf(struct bpf_map *map,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
 {
-	/* One exception for keyless BTF: .bss/.data/.rodata map */
+	/* One exception for keyless BTF: .bss/.data/.rodata/.percpu map */
 	if (btf_type_is_void(key_type)) {
-		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
+		if ((map->map_type != BPF_MAP_TYPE_ARRAY &&
+		     map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) ||
 		    map->max_entries != 1)
 			return -EINVAL;
 
@@ -832,6 +864,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
+	.map_direct_value_addr = percpu_array_map_direct_value_addr,
+	.map_direct_value_meta = percpu_array_map_direct_value_meta,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
 	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index b2a19acadb91..5787246bef30 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -182,7 +182,6 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 		u64 val = 0;
 
 		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
-		    map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
 		    off < 0 || off + size > map->value_size ||
 		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
 			*dst = unknown;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3cf2cc6e3ab6..4f84d087ca69 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1819,6 +1819,38 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		if (env->prog->jit_requested &&
+		    bpf_jit_supports_percpu_insn() &&
+		    insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+		     insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
+			struct bpf_map *map;
+
+			aux = &env->insn_aux_data[i + delta];
+			map = env->used_maps[aux->map_index];
+			if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+				goto next_insn;
+
+			/*
+			 * Reuse the original ld_imm64 insn, and add one
+			 * mov64_percpu_reg insn.
+			 */
+
+			insn_buf[0] = insn[1];
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
+			cnt = 2;
+
+			i++;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 49a331c27b43..dbf76fa9d43d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5594,6 +5594,8 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	u64 addr;
 	int err;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY || map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
 	err = map->ops->map_direct_value_addr(map, &addr, off);
 	if (err)
 		return err;
@@ -6149,6 +6151,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
 			    map->ops->map_direct_value_addr &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
 			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;
@@ -8117,6 +8120,12 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		verbose(env, "%s points to percpu_array map which cannot be used as const string\n",
+			reg_arg_name(env, argno));
+		return -EACCES;
+	}
+
 	if (!bpf_map_is_rdonly(map)) {
 		verbose(env, "%s does not point to a readonly map'\n", reg_arg_name(env, argno));
 		return -EACCES;
@@ -18203,6 +18212,12 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+				if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY &&
+				    !env->prog->jit_requested) {
+					verbose(env, "JIT is required to use global percpu data\n");
+					return -EOPNOTSUPP;
+				}
+
 				err = map->ops->map_direct_value_addr(map, &addr, off);
 				if (err) {
 					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
-- 
2.54.0

