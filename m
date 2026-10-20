Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504166;
	b=cFt71xXx2065VS0S1L3+qLuPD6K0d1PpREriFo6tMONdM0cbYxmCTs1dzysdHyeINKXh
	 1GMGxJJ/5QDQCG2IZQ1t8DfVsfrxtPBQ+iDuydbSLghODLeUkYaLcxL3T0Y37SVe6a9b/
	 A1qAs7H6C+CKNnXpgg4QIyS/7dIasBSTZZo5mqwoHpmyAZeiag4JvOdGbs0WTVz3vtl6z
	 rzb8CkeorM2dSLvH94i1FZ6mhz8K2Cxgg8+02wFOHwI355uBw3jMfz83wRVyQ6fJHIx4h
	 xwNdzFgnBgYeCzQavZQTBWhKubouxN+HPkW76XYikLJ5zJKcjErZ+lUTiWdF4zelKeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504166;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WancafQhACUxOycmAAieawsiaQrybOyyNWIuo+D6eqQ=;
	b=zwy6dCDejcQD8LM8fOY5gEQ8pjYWS4xw8OK3d0t09tA8UiV0cqv0CusEEs5MqoU4Uirr
	 DFvHc2gRbcay2nRdqo0dgfsx7FSYbhBDlsk7AjA2p2BjQ7V4NYCZ030mtPPUZz5VjjcnS
	 K0hgjJSP/sw/6LiZlI5j6wLi3cz4uvlswgi0c0+aZaYRZklHV4XSwYHA1NZbxgtuR9zeN
	 KxJidLHv5A5QYGMWiFxhrvAuiEHBgJWtw9EoBc0ribDgQB+aHbReJB8ggx3FvRNIR2NEw
	 DrKDx9XtWetqgWJkGLbKg4xb3j0Qs0Lns2oC7J9EMfeNuUfm5DkhDGxd5h/irTUTcpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F7606F465;
	Tue, 20 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55F7606F465
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn379DzYQtvV;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6D2234056F;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S11;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 09/16] bpf: Teach verifier about arena percpu instructions
Date: Tue, 20 Oct 2026 13:22:54 +0000
Message-ID: <38a798d59fc40d94c555c785a900e57c22cec2bc.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Jryxur45AryUJryxury5twb_yoWfXry3pF
	s7Gr95Cr48ZF4xuwsxJa17AFW5Ww4rG3y7C3yxC34FyF12qws8Xa1Ig3W5A34YkrWkuw1x
	Kr1q9rW2g34UAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
	xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
	6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Teach the verifier about the arena percpu pseudo instruction. The
percpu chunks of all cpus have the same size and layout, so the
verifier only checks the address in the pseudo instruction against
cpu 0's chunk. If the offset or the access size goes past cpu 0's
chunk, the prog is rejected.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h    |  3 ++
 include/linux/filter.h |  1 +
 kernel/bpf/arena.c     | 23 ++++++++++++++
 kernel/bpf/core.c      | 22 +++++++++++++-
 kernel/bpf/verifier.c  | 69 +++++++++++++++++++++++++++++++++++++++---
 5 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7750df973494..5ffefcd5f15e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -674,6 +674,9 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
+u32 bpf_arena_percpu_chunk_off(const struct bpf_map *map);
+u32 bpf_arena_percpu_chunk_sz(const struct bpf_map *map);
+bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off);
 struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6f4c9bd024a0..d4d80e14d594 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1254,6 +1254,7 @@ bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
+bool bpf_jit_supports_arena_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 05cd6397adae..310573a2661b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -102,6 +102,29 @@ u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
 	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, map));
 }
 
+u32 bpf_arena_percpu_chunk_off(const struct bpf_map *map)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	return arena->percpu_chunk_off;
+}
+
+u32 bpf_arena_percpu_chunk_sz(const struct bpf_map *map)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	return arena->percpu_chunk_sz;
+}
+
+bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	u32 chunk_off = arena->percpu_chunk_off;
+	u32 chunk_sz = arena->percpu_chunk_sz;
+
+	return off >= chunk_off && off - chunk_off < chunk_sz;
+}
+
 /**
  * bpf_prog_arena - return the bpf_map of the arena referenced by @prog
  * @prog: a loaded BPF program
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fc22d66d194a..29291101416a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -319,7 +319,8 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 		if (!was_ld_map &&
 		    dst[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
 		    (dst[i].src_reg == BPF_PSEUDO_MAP_FD ||
-		     dst[i].src_reg == BPF_PSEUDO_MAP_VALUE)) {
+		     dst[i].src_reg == BPF_PSEUDO_MAP_VALUE ||
+		     dst[i].src_reg == BPF_PSEUDO_ARENA_PERCPU)) {
 			was_ld_map = true;
 			dst[i].imm = 0;
 		} else if (was_ld_map &&
@@ -1600,6 +1601,20 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 			continue;
 		}
 
+		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
+			/*
+			 * The imm of an arena percpu pseudo insn is the
+			 * loader resolved address of the value in cpu 0's
+			 * chunk, and the JIT translates the pseudo insn to
+			 * step it into the running cpu's chunk. No need to
+			 * blind it.
+			 */
+			insn++;
+			i++;
+			continue;
+		}
+
 		/* We temporarily need to hold the original ld64 insn
 		 * so that we can still access the first part in the
 		 * second blinding run.
@@ -3383,6 +3398,11 @@ bool __weak bpf_jit_supports_percpu_insn(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_arena_percpu_insn(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01434e1d23b5..0c0d3662ec76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4724,6 +4724,10 @@ static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_reg_state
 		verbose(env, "invalid access to context, ctx_size=%d off=%d size=%d\n",
 			mem_size, off, size);
 		break;
+	case PTR_TO_ARENA:
+		verbose(env, "per-cpu arena access at offset %d size %d outside cpu 0's chunk\n",
+			off, size);
+		break;
 	case PTR_TO_MEM:
 	default:
 		verbose(env, "invalid access to memory, mem_size=%u off=%d size=%d\n",
@@ -7415,6 +7419,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_ARENA) {
+		/*
+		 * A per-cpu reference is bounded to cpu 0's chunk through
+		 * mem_size. A plain arena pointer has no bound and only
+		 * faults at runtime.
+		 */
+		if (reg->mem_size) {
+			err = check_mem_region_access(env, reg, argno, off, size,
+						      reg->mem_size, false);
+			if (err)
+				return err;
+		}
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
@@ -17456,7 +17471,12 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			aux->zext_dst = true;
 		}
 
-		/* Any arithmetic operations are allowed on arena pointers */
+		/*
+		 * Any arithmetic operations are allowed on arena pointers.
+		 * Arithmetic on a per-cpu reference drops its chunk bound.
+		 * The register rolls back to a plain arena pointer.
+		 */
+		dst_reg->mem_size = 0;
 		return 0;
 	}
 
@@ -19080,10 +19100,27 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	map = env->used_maps[aux->map_index];
 
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
-	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
+	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE ||
+	    insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
 		if (map->map_type == BPF_MAP_TYPE_ARENA) {
-			__mark_reg_unknown(env, dst_reg);
-			dst_reg->map_ptr = map;
+			if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
+				u64 pos = aux->map_off - bpf_arena_percpu_chunk_off(map);
+
+				/*
+				 * The register value tracks the position of
+				 * the reference inside cpu 0's chunk and
+				 * mem_size bounds accesses to the chunk.
+				 * map_ptr and mem_size share a union and
+				 * map_ptr is never read for PTR_TO_ARENA,
+				 * so only mem_size is set.
+				 */
+				__mark_reg_known(dst_reg, pos);
+				dst_reg->type = PTR_TO_ARENA;
+				dst_reg->mem_size = bpf_arena_percpu_chunk_sz(map);
+			} else {
+				__mark_reg_unknown(env, dst_reg);
+				dst_reg->map_ptr = map;
+			}
 			bpf_diag_mod_end(env);
 			return 0;
 		}
@@ -21372,6 +21409,7 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 			switch (insn[0].src_reg) {
 			case BPF_PSEUDO_MAP_VALUE:
 			case BPF_PSEUDO_MAP_IDX_VALUE:
+			case BPF_PSEUDO_ARENA_PERCPU:
 				break;
 			case BPF_PSEUDO_MAP_FD:
 			case BPF_PSEUDO_MAP_IDX:
@@ -21410,6 +21448,26 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 			} else {
 				u32 off = insn[1].imm;
 
+				if (insn[0].src_reg == BPF_PSEUDO_ARENA_PERCPU) {
+					if (map->map_type != BPF_MAP_TYPE_ARENA) {
+						verbose(env, "per-cpu value pseudo insn only allowed on arena maps\n");
+						return -EINVAL;
+					}
+					if (!bpf_arena_percpu_chunk_sz(map)) {
+						verbose(env, "arena map has no per-cpu chunks\n");
+						return -EINVAL;
+					}
+					if (!bpf_arena_percpu_off_in_range(map, off)) {
+						verbose(env, "per-cpu arena reference at offset %u outside cpu 0's chunk\n",
+							off);
+						return -ERANGE;
+					}
+					if (!bpf_jit_supports_arena_percpu_insn()) {
+						verbose(env, "JIT doesn't support arena percpu insn\n");
+						return -EOPNOTSUPP;
+					}
+				}
+
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
 					return -EINVAL;
@@ -21579,6 +21637,9 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_FUNC)
 			continue;
+		/* The JIT reads this pseudo to emit the per-cpu step */
+		if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU)
+			continue;
 		insn->src_reg = 0;
 	}
 }
-- 
2.47.3

