Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E23E6DD4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173096; cv=none; b=oi1d15cIj2fuAmk0mPjQq+i2xnDn6IiIIFALnKoiqK0mj8Bq0erzPsm4ttPHTTCVlfDBkMbkMvtYsxnfUp08OM/dRnMnmavwHrRmUio0Db2jUCjM9DcJsrXlF7Q27HfEk66WqqIVfbKoEmzGFvmT/yo+cuG3Gx0NrLfIUp79vxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173096; c=relaxed/simple;
	bh=eTJj6pZi866MRk2/8F7FMZgZkJMP1J2eruDigaQPtiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX367cHAusYs+9Cb7GAqBqb7bxafIVirdemFrqbSNAVE/Qb2tWOm77n4x3/LciogjOqJGxJM2HJTYIZEwC4G1agpAU6+WyoPmFMJbnjGs43qASKYAk9ULxE9/QMaerJxFi/yd4TnrRDJUfx+aA3tdrI4NpctWak//lAfr5LiYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YB95ZGYj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YB95ZGYj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ8ZhkzY6XdHCFlGE1MYo2cbEifiudr3GE270mYCzds=;
	b=YB95ZGYjHhJx59VNViwYv395mOmnUm3nT33hWJZZrX8XpCP2Xg3BbHAOGVgg+IKyw86M8S
	YbIj8gEW/Lzv6Y+sZcT6Fziti8/6RDy5lAeTp4Q+v9d0pQgiLTVhthvNW44wpIGqah2RKP
	Z8ZHSCtIY3yqJ1yNFqJFJmy/KphEfYs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Date: Tue, 14 Apr 2026 21:24:14 +0800
Message-ID: <20260414132421.63409-3-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
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
 kernel/bpf/arraymap.c | 41 +++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/fixups.c   | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  9 ++++++++-
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 5e25e0353509..b85ac59d808c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -261,6 +261,40 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
 }
 
+static int percpu_array_map_direct_value_addr(const struct bpf_map *map,
+					      u64 *imm, u32 off)
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
+	*imm = (u64) array->pptrs[0];
+	return 0;
+}
+
+static int percpu_array_map_direct_value_meta(const struct bpf_map *map,
+					      u64 imm, u32 *off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u64 base = (u64) array->pptrs[0];
+	u64 range = array->elem_size;
+
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (imm < base || imm >= base + range)
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
@@ -553,9 +587,10 @@ static int array_map_check_btf(struct bpf_map *map,
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
 
@@ -834,6 +869,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
+	.map_direct_value_addr = percpu_array_map_direct_value_addr,
+	.map_direct_value_meta = percpu_array_map_direct_value_meta,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
 	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 67c9b28767e1..5f16fd4e0461 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1682,6 +1682,37 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		if (bpf_jit_supports_percpu_insn() &&
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
index 1757c5720503..8ec24d63a2c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6362,7 +6362,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
 			    map->ops->map_direct_value_addr &&
-			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
+			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;
 
@@ -8358,6 +8359,12 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		verbose(env, "R%d points to percpu_array map which cannot be used as const string\n",
+			regno);
+		return -EACCES;
+	}
+
 	if (!bpf_map_is_rdonly(map)) {
 		verbose(env, "R%d does not point to a readonly map'\n", regno);
 		return -EACCES;
-- 
2.53.0

