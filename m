Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983617;
	b=IRefkftqBNmG+arbCmpxQlnPj5aOgtoyvS9Dq8SeWzlOsh5onECumvO61rGAHIHlPHq+
	 61O4m9vFYwexJ1EWK5u9Cctcw2OgH8w3UIVL3o6TjUqPH+PqIHw2SKTxN6EtMGgTSqe4J
	 bzfUsVV3aC2nH76bGS27bicksj8IZLfy/BMBIYkKPQM+1PLpgk+X6Rj2IUOuQZv1D16gB
	 F/sNXDOA+qyL1jlL6wJ/8PqkZE1ysoBT1V+Xb5XVsk6Z9rj/QDEgJ9GEz7i8KEvy01y9U
	 xr1B99doDb3W8lk+pbzI9jOC+2nckan9R6Fj0CChgWcVdCLz7rvH+OEF9LttJgvVTbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rq7FJF1LiOMXCVzB7BjlvdTl6sEoOGa9PJfoyk1dsy8=;
	b=O5/Nk7InDZ9KM2dpDwXWyGrnQDvd/9/y7sjuxBZQG5vUHWtomNbIh85Rq3KtUPOcWkA+
	 gjMQWHeLh/cBsrAepT06osZDiWM6xckCKKIn9wHz4OsIEImT3hyS0HS+BMi+k1OYsfj0N
	 2fsd+hO4rBzRykgJxW5zxGSeW739Vu4t1b5j7ot4A6BOy+xSTEF9BYO73rYl5qP05CARa
	 2BSlJEf8k+Lz+ys0+rlR/+jaGnfesrKwtHhUfmjd/WnVC+I/6MSAhAJrOW6v7SKAz7Mp8
	 FONc0cVum9B1dI4kw6BJsGCqxvRckZMF8tYXsPf2lXKwAfpPrE8pqK70KRnk4gCI9wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FopGNZWG;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8F606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E8F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FopGNZWG
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae25008e2aso103086a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983616; x=1793588416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rq7FJF1LiOMXCVzB7BjlvdTl6sEoOGa9PJfoyk1dsy8=;
        b=FopGNZWGpmAsOUvRkLzkiBgW4PK4cvbveCGynYZUdfhCYG4jTI7D4HFeV/eKObflHv
         +2EG5Y6/1672EejPPjblEKtvbiOMPoVUAYNc+AIGlvRN6fZQV5+Ol0ZVWTI9Xdo61mrO
         zwjhKPEdJ8BMOvmFVmgSZ9HGQWVkCmkekjlWVaMtkcoSy51PdzBWyomp3cqUZ8pm2w0Q
         jfgpdrhEgVKF6r5gsk0n411t8plq3cXTTuENXQAmM4IXQkx5z532cgJqIBQzQvJtT71p
         Qj2H0IFivm2HtF4DiwqXShpsm0QO9SoagXo9Uz94nipZmmh8iCSVNgLmn/mwlf/JqGUS
         kDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983616; x=1793588416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rq7FJF1LiOMXCVzB7BjlvdTl6sEoOGa9PJfoyk1dsy8=;
        b=XaHYiBeMjzXTOmyLTnGz5MZhtjH5NF92tbTo1KV7vfAksJS04gQWbwYlmPfe2nlXyB
         mVThi5WccwqZzNyGMUMjPEJfOkIUq6vWUrJ17BuVDvJENnr30n8sZ/fDV4ri0kO3E9hH
         DkI7lmZIIv8HxS2EsABLWJ/dXe2/B0Dt0raYW9MaQB0FsfyFsmto/A5JPWwOstXLtlQN
         tmLQg8moSIwANnuOVv2FkwP+P6MRu6qQwnr3Tup86fck7BJHxYbYuVg5gk9pASH0UyHQ
         LBHjf2bVFDO0OfMFHzLaRNXtD1TebeWdcdz/xKOOSketjf9MSbjB0Mr08/eRlhhbwSDq
         MhoA==
X-Gm-Message-State: AFq9FYL9AlMzWuLwmzfl2RCUBi8KH07gw7fdNh+UItMlY6fzzb2SFdt9
	3uozO+nDRANg3lQ7S8TYwP9R7CgB080LXDTeyJ2P+lvDvJgYkpYSqbSrT+80gg==
X-Gm-Gg: AYBFou0ftQRPEsuFgUvMwMecn8ucMud4wzw1zGKBflJRCotMnTydHFGIagPGHIB5a30
	GzNJVvCOLSBTcd2FO9/1uFFZMkKk72YQ2fha9+db8+SpSmJ1e2wjUojj3Q8zYGGTVxuofzwCN13
	WbLXi0VyaW2A+LXtxu/r30taoqn3M9DlkMDdENgrzK1u26WPZXuEpT0lBVnwQPcVaYhi0js5X+x
	UZOf8IEVW9oFQZWn16HgQflMAWp+dk92KbXpUW926ZmsqtgoAnO88nSo9ASQBZQ+IUAmmvOzr7K
	SxTNACUsd5H4CsneEAV81y0kLZbC6AOM8MV9uLWxmdHtbYFdpJxzbeyhj6BTaVlS+cbwet0Wmu4
	/vDs6YmRbSBlpKJtF7U+jSftHeeGiW/fvWxbwg9D7f9JeY/1s7ITbkv4ijtZsSaS9VVtFtuGp+U
	ikmX1XjRucvz6QIUc/tA5asS8UAyKxnrNceXhAn0T/jIaNj4PJd0qlc/gF5xpKvMaZEykltbpem
	ODL4Gd5VJmLfD3yKo4Y9pCSdMt5qwocaOR4N8+8V7Ae5OMXJTXWOEqmc5W8V+FsGU0Ub+Qsk6GG
	q3M5hLUAM22WAytdwncA/5hI0tivYQgPyw1e9uplR7gxPEv0R3X76wMPNXMzLPiooPuShJcn4dQ
	zPwlzv12wIgXnLhZYZkv8v1Ve
X-Received: by 2002:a17:90b:564d:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3adeafb048dmr4798516a91.57.1792983615667;
        Sun, 25 Oct 2026 20:00:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32f70sm6235989a91.1.2026.10.25.20.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 05/81] bpf: Remove BPF_F_ARENA_SCALAR
Date: Mon, 26 Oct 2026 02:58:26 +0000
Message-ID: <20261026025943.404450-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Rust has no address spaces. Thus a prog in Rust accesses arena through
scalars. With BPF_F_ARENA_SCALAR the verifier accepts each load and each
store through a scalar as an access to arena.

The verifier rewrites one insn at a time. Thus it must add one insn to each
access. The compiler knows the source of each pointer. It can emit one
addr_space_cast for each pointer, as it does for the __arena pointers of C.

  flag: one move for each access     cast: one cast for each pointer

  ax = (u32)r1                       r1 = addr_space_cast(r1, 0, 1)
  r2 = *(u64 *)(ax + 0)              r2 = *(u64 *)(r1 + 0)
  ax = (u32)r1                       r3 = *(u64 *)(r1 + 8)
  r3 = *(u64 *)(ax + 8)

20 progs of rust-bpf, with the flag and with the casts that a prototype of
an LLVM pass emits:

                     flag    casts
  moves or casts     1568      571
  insns             14864    13938
  jited bytes       72351    69111

No released kernel has the flag. LLVM does not emit the casts for Rust at
this time. Until it does, Rust progs that access arena do not load.

This reverts commit 4c651a91bdfc
("bpf: Treat load and store through a number as arena access"). One part
stays: BPF_REG_AX in reg2pt_regs[] of the x86 JIT. The fetching AND/OR/XOR
atomics in arena use it now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c  |  5 ---
 arch/x86/net/bpf_jit_comp.c    |  5 ---
 include/linux/bpf_verifier.h   |  2 --
 include/linux/filter.h         |  1 -
 include/uapi/linux/bpf.h       |  6 ----
 kernel/bpf/core.c              |  9 +----
 kernel/bpf/fixups.c            | 39 ---------------------
 kernel/bpf/syscall.c           |  4 ---
 kernel/bpf/verifier.c          | 64 ++++++++--------------------------
 tools/include/uapi/linux/bpf.h |  6 ----
 10 files changed, 16 insertions(+), 125 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaa34c739004..33632fb20997 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3502,11 +3502,6 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
-bool bpf_jit_supports_arena_scalar(void)
-{
-	return true;
-}
-
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	if (!in_arena)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fd65ac84cfc7..7bfb7210484e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -5240,11 +5240,6 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
-bool bpf_jit_supports_arena_scalar(void)
-{
-	return true;
-}
-
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	return true;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5926f13ff43c..de301b32015d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -782,7 +782,6 @@ struct bpf_insn_aux_data {
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
 	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
-	u64 arena_scalar:1; /* ldx/stx/st/atomic through a number, it's an address in arena */
 	u64 bb_end:1; /* last instruction of a basic block */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
@@ -1074,7 +1073,6 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
-	bool arena_scalar;		/* load and store through a number is arena access */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
 	 * lists of struct bpf_verifier_state_list.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..98254742ae37 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1287,7 +1287,6 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
-bool bpf_jit_supports_arena_scalar(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_large_stack(void);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f29b0aad440c..8d7228834305 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1357,12 +1357,6 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
-/*
- * Load and store through a number is an access to the arena of the program
- * at the low 32 bits of the number. It's for programs written in Rust.
- */
-#define BPF_F_ARENA_SCALAR	(1U << 8)
-
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0a8ba603f44b..7cf37690d41f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2639,8 +2639,7 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 /*
  * Whether a function has an insn that works with the arena base, which a JIT
  * sets up in the prologue when bpf_prog_uses_arena_insns() says so. Decided on
- * the final insns of the function: an access through an arena pointer, or
- * through a number in a program loaded with BPF_F_ARENA_SCALAR, has been
+ * the final insns of the function: an access through an arena pointer has been
  * rewritten to a BPF_PROBE_MEM32 form by then, a cast to the user address
  * space keeps BPF_ADDR_SPACE_CAST, and a kfunc call with an __arena argument,
  * which the JIT rebases, has a function model that says so. A load of an
@@ -3518,12 +3517,6 @@ bool __weak bpf_jit_supports_arena(void)
 	return false;
 }
 
-/* Whether JIT takes BPF_REG_AX as the address of arena access */
-bool __weak bpf_jit_supports_arena_scalar(void)
-{
-	return false;
-}
-
 bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	return false;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f062ef7dd943..41bc37e205e0 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -44,31 +44,6 @@ static bool is_addr_space_cast32(struct bpf_prog *prog, const struct bpf_insn *i
 	return false;
 }
 
-/*
- * The insn accesses arena through a number. JITs add the base of arena
- * to the register as it is, so the access goes through the low 32 bits of
- * the number in BPF_REG_AX. Registers of the program are not changed: the
- * number may be compared or stored later, and on another path the register
- * may be PTR_TO_ARENA.
- *
- * Constant blinding leaves insns that use BPF_REG_AX alone, so the immediate
- * of st through a number is not blinded.
- */
-static int arena_scalar_access(const struct bpf_insn *insn, struct bpf_insn *buf)
-{
-	bool load = BPF_CLASS(insn->code) == BPF_LDX || bpf_atomic_is_load_acq(insn);
-	struct bpf_insn *patch = buf;
-
-	*patch++ = BPF_MOV32_REG(BPF_REG_AX, load ? insn->src_reg : insn->dst_reg);
-	*patch = *insn;
-	if (load)
-		patch->src_reg = BPF_REG_AX;
-	else
-		patch->dst_reg = BPF_REG_AX;
-	patch++;
-	return patch - buf;
-}
-
 /* Return the regno defined by the insn, or -1. */
 static int insn_def_regno(const struct bpf_insn *insn)
 {
@@ -1880,20 +1855,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 
-		if (env->insn_aux_data[i + delta].arena_scalar) {
-			cnt = arena_scalar_access(insn, insn_buf);
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			prog = new_prog;
-			env->prog = prog;
-			insn = prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
 		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
 		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
 		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc7230afa8..60c4d84b9aba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2971,13 +2971,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
 				 BPF_F_TEST_REG_INVARIANTS |
-				 BPF_F_ARENA_SCALAR |
 				 BPF_F_TOKEN_FD))
 		return -EINVAL;
 
-	if ((attr->prog_flags & BPF_F_ARENA_SCALAR) && !bpf_jit_supports_arena_scalar())
-		return -EOPNOTSUPP;
-
 	bpf_prog_load_fixup_attach_type(attr);
 
 	if (attr->prog_flags & BPF_F_TOKEN_FD) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c223bf3bc9cd..c93ef399c420 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5495,19 +5495,6 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
-/*
- * There are no address spaces in Rust, addresses of arena are plain numbers.
- * When the program is loaded with BPF_F_ARENA_SCALAR and has an arena a load or
- * a store through a number is an access to arena at the low 32 bits of it,
- * like the access through PTR_TO_ARENA is. The register stays a number.
- */
-static bool is_arena_scalar(struct bpf_verifier_env *env, int regno)
-{
-	const struct bpf_reg_state *reg = reg_state(env, regno);
-
-	return reg->type == SCALAR_VALUE && env->arena_scalar && env->prog->aux->arena;
-}
-
 static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
 			       struct bpf_insn *insn)
 {
@@ -5538,7 +5525,7 @@ static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
 		return false;
 	if (is_sk_reg(env, regno))
 		return false;
-	if (is_arena_reg(env, regno) || is_arena_scalar(env, regno))
+	if (is_arena_reg(env, regno))
 		return bpf_jit_supports_insn(insn, true);
 	if (is_load_acq_unsafe(env, regno, insn))
 		return false;
@@ -7519,22 +7506,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-/*
- * Returns the register to check the access of the current insn with.
- * For a number in a program with an arena that is 'arena'.
- */
-static struct bpf_reg_state *mem_access_reg(struct bpf_verifier_env *env, int regno,
-					    struct bpf_reg_state *arena)
-{
-	if (!is_arena_scalar(env, regno))
-		return cur_regs(env) + regno;
-
-	memset(arena, 0, sizeof(*arena));
-	arena->type = PTR_TO_ARENA;
-	env->insn_aux_data[env->insn_idx].arena_scalar = true;
-	return arena;
-}
-
 static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
@@ -7542,7 +7513,6 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state arena, *src_reg;
 	enum bpf_reg_type src_reg_type;
 	int err;
 
@@ -7564,16 +7534,16 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
-	src_reg = mem_access_reg(env, insn->src_reg, &arena);
-	src_reg_type = src_reg->type;
+	src_reg_type = regs[insn->src_reg].type;
 
 	/*
 	 * check_stack_read_fixed_off() may refine the modification's origin to
 	 * the source stack slot.
 	 */
 	bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
-	err = check_mem_access(env, env->insn_idx, src_reg, argno_from_reg(insn->src_reg),
-			       insn->off, BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
+	err = check_mem_access(env, env->insn_idx, regs + insn->src_reg,
+			       argno_from_reg(insn->src_reg), insn->off,
+			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
 	/*
 	 * Paths through a kernel struct pointer and through other pointers
@@ -7601,7 +7571,6 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state arena, *dst_reg;
 	enum bpf_reg_type dst_reg_type;
 	int err;
 
@@ -7623,12 +7592,12 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
-	dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
-	dst_reg_type = dst_reg->type;
+	dst_reg_type = regs[insn->dst_reg].type;
 
 	/* Check if (dst_reg + off) is writeable. */
-	err = check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn->dst_reg),
-			       insn->off, BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
+	err = check_mem_access(env, env->insn_idx, regs + insn->dst_reg,
+			       argno_from_reg(insn->dst_reg), insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
 			       strict_alignment_once, false);
 	err = err ?: save_aux_ptr_type(env, dst_reg_type, false);
 
@@ -7638,7 +7607,7 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 static int check_atomic_rmw(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn)
 {
-	struct bpf_reg_state arena, *dst_reg;
+	struct bpf_reg_state *dst_reg;
 	int load_reg;
 	int err;
 
@@ -7683,9 +7652,6 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/* load_reg may be dst_reg. Look at dst_reg before it's marked as unknown. */
-	dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
-
 	load_reg = bpf_atomic_load_reg(insn);
 	if (load_reg >= 0) {
 		/* check and record load of old value */
@@ -7694,6 +7660,8 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	dst_reg = cur_regs(env) + insn->dst_reg;
+
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
@@ -20280,17 +20248,16 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			return check_stack_arg_write(env, state, insn->off, NULL);
 		}
 
-		struct bpf_reg_state arena, *dst_reg;
 		enum bpf_reg_type dst_reg_type;
 
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 		if (err)
 			return err;
 
-		dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
-		dst_reg_type = dst_reg->type;
+		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
 
-		err = check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn->dst_reg),
+		err = check_mem_access(env, env->insn_idx, cur_regs(env) + insn->dst_reg,
+				       argno_from_reg(insn->dst_reg),
 				       insn->off, BPF_SIZE(insn->code),
 				       BPF_WRITE, -1, false, false);
 		if (err)
@@ -23926,7 +23893,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
-	env->arena_scalar = attr->prog_flags & BPF_F_ARENA_SCALAR;
 
 	env->explored_states = kvzalloc_objs(struct list_head,
 					     state_htab_size(env),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f29b0aad440c..8d7228834305 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1357,12 +1357,6 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
-/*
- * Load and store through a number is an access to the arena of the program
- * at the low 32 bits of the number. It's for programs written in Rust.
- */
-#define BPF_F_ARENA_SCALAR	(1U << 8)
-
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-- 
2.55.0

