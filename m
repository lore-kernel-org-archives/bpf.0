Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55836AB56
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033918; cv=none; b=CHDdWd7FswATV5cSJD//+M8fgsF0S6Jt6bb0PQ903wMg7tHdPK364/LxXjC3AEdYuhsjMfQM2UHRawMeFr0schiL4B3AlBfV25SJJYxRgTpR69dpX6RquoXHGz3uwuQD/Tvux8Y5To1G0fXWx1njUougN4VsK6BqCWGn8CnmLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033918; c=relaxed/simple;
	bh=sUZIvw696NISTswmkUNoVcZzdRr+86eCb9mN9+daf7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcNc2XqJfr3Co3tHbO9KwgkibTmd5rUlPqFtizu/UO+CaDm0mNhUTT852R7sjK3RkxpvPVysQafJBA3AbClCXLGTmKsDLDWcNxaWnhGYFmzXiGBuP5AzXXnvkliqDEtE7bJVIqphX1a8PiXuBv7cetr+bQyBsZ0qoRFxx7FejaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PFeu1DMu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PFeu1DMu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cedkGspDwMO0wtkxkbQlXm0zjGY93pIGGrHV8+BgXtg=;
	b=PFeu1DMuD2S34wpWx85OuBON6VLuNCyCZ/XIZVBXcoC0h0ifrUwad0a3+/y/b5BTK9lkha
	uZInsywcGbPEPvTy076TNZ34WlUPe4+CQpOY+gkvJFrOj4VwLbsaFIDZ7OXw4NCkPluWPg
	7B2ifPkZkw04RBIBjv1osEqsVdN4b5Y=
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
Subject: [PATCH bpf-next v11 03/10] bpf: Introduce global percpu data
Date: Fri,  7 Aug 2026 00:31:18 +0800
Message-ID: <20260806163125.11172-4-leon.hwang@linux.dev>
In-Reply-To: <20260806163125.11172-1-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
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
 kernel/bpf/fixups.c     | 37 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c   | 11 +++++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..34865701f7f7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -259,6 +259,37 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
 }
 
+static int percpu_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (off >= map->value_size)
+		return -EINVAL;
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
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (imm < base || imm >= base + array->elem_size)
+		return -ENOENT;
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
index 440e73e1b11b..f2398749103b 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1817,6 +1817,43 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
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
+			prog->jit_required = true;
+
+			/*
+			 * We are *skipping* first half of ld_imm64 insn
+			 * with 'i++;', patching over second half of it
+			 * with that same half + mov64_percpu_reg insn.
+			 * All because bpf_patch_insn_data() can only
+			 * replace one 8-byte insn, which does not work
+			 * well for ld_imm64 insn.
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
index 25c4ada94cd9..09582b9b2791 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5659,6 +5659,8 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	u64 addr;
 	int err;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY || map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
 	err = map->ops->map_direct_value_addr(map, &addr, off);
 	if (err)
 		return err;
@@ -6172,6 +6174,8 @@ static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state
 		add_scalar_to_reg(&regs[value_regno], off);
 		regs[value_regno].type = PTR_TO_INSN;
 		return 0;
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		goto reg_unknown;
 	default:
 		break;
 	}
@@ -6193,6 +6197,7 @@ static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state
 		return 0;
 	}
 
+reg_unknown:
 	mark_reg_unknown(env, regs, value_regno);
 	return 0;
 }
@@ -8225,6 +8230,12 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
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
-- 
2.55.0

