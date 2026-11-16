Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808700;
	b=QlRVtxVhyABOKweF22UH57cR8f5Wwz7P0DojRztwDSrB+JbpmBkbHqbmHIoOHpgATLwS
	 avJwKJCF1k/L4gPgP2yPIwJ4tBRVgDp0YLIcuvX5Djw0/lcuVG+JBT6j5QnOueBZFOWdA
	 6PfmjpjYcgMXcr7fYnNPU6oN1uiTrYuDg0DlbcL3cuW9+zkbzGSWgDtdn/8nv3jOj3FoL
	 1HptwXPKGmWF/XRr8tvXDQ+TJ8IYi7v3OaeW67RkafTh9jFbvhJxpniGioIuuNwMUJhED
	 Jq3AZ1ukRkPtKY/Es3bM+Awb623YIlpvZKf4TnCeIv9sdIJ1M/V9zubtikavxL+VgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i/f1r3w+1uBJPezubwsBjUo2/7FIuBxi/bq+NhHihqI=;
	b=Zh2IIxrkuxVwtaxcTmqWxTCYH1RAIVLfkasRD6jCYPKRRwxbuQIpOEgwkd+DDiDyi5tq
	 yoRAeDR/sTBb1ODfp9P2IYVmfgH//xRGcrcSidPnm39BYwQlxU9QnGhIjtCzYVml2zVTR
	 Zkz9B8y1Ub2FaqlmFEkFVtzemHVccyWkBaa53E/POvInu+eMBAF4e9Bw2GHOKGgbudFQV
	 OD4Lqueyiy52ekQJb40JJpvsY5iCOAy1Vs6n/BX478E8ttnr3FIQ4aO32bWVnAKDu2vW7
	 bh5aLMId+ZbVh+DWYhD0MIc2/tLtY+ptAlW53u71bFFuUwjX1Nev1uEdEqGLweZ5YFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIBpdRdk;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86E606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD86E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIBpdRdk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2753731b3a.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808699; x=1795413499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/f1r3w+1uBJPezubwsBjUo2/7FIuBxi/bq+NhHihqI=;
        b=pIBpdRdkjpksAlGBqr9eRt+c90RF7l5BUDd8sedgHitdiEbgzbOQHBOAuI+G2wTIkY
         ddAwptUQ9H08JP2TIizjy1r9scmc4J6xu9etmsf7m2L6vJ86nhygwpGYtuH3X5rQiehD
         uqVnRbglhKMXmdz30FEM9cxHyHQ87OEJDNsolbcPhrU+Fhqtr+givPN3HMYLnHhRLOCi
         uSLR/ZYov6OhZwibm9RiH6n9hkqGdTIla86+imwaLvNctbtsbo5bYhckFl/qN7Q7/HnQ
         XDJd42XgDJUMmUSQhy384y/z4RoLF0x1RcJa2+lq0uOyLHmcEaF9uw2RjgSvRBABxg0A
         GVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808699; x=1795413499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/f1r3w+1uBJPezubwsBjUo2/7FIuBxi/bq+NhHihqI=;
        b=kbUqXIxWN5DPF0/VqM/BqfNORbkv4rMegPrIG3rWnAfkqTV/tUGqq87BrE6eKIzIsC
         n5ANNkMioky0jeBdD9nEcR/TLdZtLHF8ICBbmfFx0wiSdZxecvS3yr67A/dI5dK/ym/q
         1drjW5BgmfPkefWLa1UAI2Dg7W8TTdHyYp5CSva3ZwqIn8KCXpB+kfeTcz36Lf6hs7wa
         MU4TBRMTYiaxR7FD8AwVxq/w47JufzR1//OVg/4w5T9BS7nReMGIwf3Dn+pj1fhptXbD
         TTWE8Ae4O6gMevz2DkdTtjFQGCLj4NO8AcO7b39JnV/9X2iOT+N74V36zkaAQ3qkPzWL
         J4Gw==
X-Gm-Message-State: APuU4Z8ZnOgtIsqihP/6nqp2IuLofM6n+yQmIX+zfJ2WtB2SQPFSzl3P
	1GgupO4xFeP7cprWrn8lhDzYGd6H2cB5hbEtDRA57+7svHJo3hP0VYrj8qQApg==
X-Gm-Gg: AYBFou3R4nowl1YKyXlB2OlMPHpsgravIMasloPhIeHKi/l9edfSVCp3JrWy4SJ+fxS
	+TCZQi4jWYlm8auteDr9WqCPCNYFPlENN9oIugMkq77O9h6Fhm0g5ch+Zp9eOKOorYRQSsiJdnd
	E+ph74C6g5bye9yq4lhX9ru6FYDcTHQpS3zXTF+eLKXodbHwevt8QcBTqIJ3xccZPz1x2xE2uIP
	8cTEp17dhP4dljLb7L3ATd2RivFljCVE4TEmYLRsVuwdsoSNsmfqX+MaQVgFQS+JZ1KVXtwCI1g
	h80+/LjUiajlc9l0LA8WzZlMfkOS3S381psSj2UYRUjnnVRIV94YKHxceEPrf1tx+AU4lLctlkn
	z2zlyOu3u9UrMZ/bxK1oAL8fZOla4cQAb9kU/AalQ7EieZEVAG0r8idM7zIMPD5cBFq51cmXoNc
	3pZrGD/Bfe4VFmPUysHAQHv42aL92novPcVJNPO32U0QRyEFcVRuJlo/kjhD2APDHYtGX1BRq1C
	0+5LSkWr2h5Oc5NsZOnh45ZrpK9obbSN+YktcV7wT+u/saH3jOb2G+/CVVi4bCvpx3qcNYU1mLm
	NHExusn802OJPeJsQxlXmWi9EMWcS4A3tHn/8tkTig2meloe9djxnkB9eIEYZMO5YxjtwmdZ8At
	6PxJwDR+zcbMBIX52iEG8cmtagOKHvZ/wwQXwUDqBn9zIwFkzGLLRoKc83rVAPFX86Cwv2ZIwHQ
	==
X-Received: by 2002:a05:6a00:bc8c:b0:8b1:e8dc:c8a1 with SMTP id d2e1a72fcca58-8beb6975428mr8273782b3a.22.1794808698940;
        Sun, 15 Nov 2026 21:58:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bfca804fbesm2429654b3a.28.2026.11.15.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 16/21] bpf: Remove BPF_MAX_SUBPROGS
Date: Mon, 16 Nov 2026 05:56:33 +0000
Message-ID: <20261116055638.4171529-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

Mark the starts of subprogs in a bitmap, count them, then allocate
subprog_info. 180 KB of zeros go away from each load.

The number of the callee was in the 16 bits of insn->off. Put it into imm
of the copy of the call that the JIT gets:

  main image:  call pc+N          is not changed, nothing to undo
  func[i]:     call subprog#      JIT: bpf_jit_get_func_addr()

x86 and sparc use that function now, like the other JITs. The dump of the
program finds the number with a binary search.

Other changes:
 - The tags of subprogs that make calls change, and so do their names in
   kallsyms.
 - The loops of the JIT over subprogs can be stopped.
 - The limit of 10000 in stack liveness counts chains of calls only.
 - Liveness of registers visits callees first. Else a chain of N calls
   takes N rounds.

What stays: bpf_flow_reset() looks at all insns after each global
function. That loop can be stopped between two functions.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/sparc/net/bpf_jit_comp_64.c |   7 +-
 arch/x86/net/bpf_jit_comp.c      |  12 ++-
 include/linux/bpf_verifier.h     |   7 +-
 kernel/bpf/cfg.c                 |   2 +-
 kernel/bpf/check_btf.c           |   5 +-
 kernel/bpf/core.c                |   7 +-
 kernel/bpf/fixups.c              | 152 ++++++++++++-------------------
 kernel/bpf/liveness.c            |  20 +++-
 kernel/bpf/syscall.c             |  25 ++++-
 kernel/bpf/verifier.c            |  76 ++++++++--------
 10 files changed, 151 insertions(+), 162 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 52f145e3843c..a2172100dba1 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1213,8 +1213,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		u8 *func = ((u8 *)__bpf_call_base) + imm;
+		bool fixed;
+		u64 func;
+		int err;
 
+		err = bpf_jit_get_func_addr(ctx->prog, insn, ctx->prog->aux->func, &func, &fixed);
+		if (err)
+			return err;
 		ctx->saw_call = true;
 
 		emit_call((u32 *)func, ctx);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5bc744c42f7f..8b5772262e13 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3323,16 +3323,22 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			const struct btf_func_model *fm = NULL;
-			bool arena_sp_args = false;
+			bool arena_sp_args = false, fixed;
+			u64 addr;
 
-			func = (u8 *) __bpf_call_base + imm32;
+			/* subprogs have addresses in the last pass */
+			err = bpf_jit_get_func_addr(bpf_prog, insn, bpf_prog->aux->func, &addr,
+						    &fixed);
+			if (err)
+				return err;
+			func = (u8 *)addr;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				u8 *tcc_load = prog;
 
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
 				ip += prog - tcc_load;
 			}
-			if (!imm32)
+			if (fixed && !imm32)
 				return -EINVAL;
 			if (arena_sp && call_clobbers_arena_sp(insn)) {
 				u8 *start = prog;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7bea740eeaee..a11cbf75a8fc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -901,7 +901,6 @@ struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
 		struct bpf_map_ptr_state map_ptr_state;
-		s32 call_imm;			/* saved imm field of call insn */
 		u32 alu_limit;			/* limit for add/sub register with pointer */
 		struct {
 			u32 map_index;		/* index into used_maps[] */
@@ -1078,8 +1077,6 @@ struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
 						  u32 size);
 int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *log);
 
-#define BPF_MAX_SUBPROGS 1024
-
 /*
  * A pointer to a static subprog in the value of a frozen read-only array map:
  * a 64-bit value that is the offset in bytes of the first instruction of
@@ -1354,9 +1351,9 @@ struct bpf_verifier_env {
 	struct bpf_verifier_log log;
 	struct bpf_diag *diag;
 	struct bpf_func_proto bpf_subprog_scratch;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
+	struct bpf_subprog_info *subprog_info;
 	/* subprog indices sorted in topological order: leaves first, callers last */
-	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
+	int *subprog_topo_order;
 	/*
 	 * Pointers to static subprogs found in frozen read-only maps of the
 	 * program, see resolve_func_ptrs(). Sorted by map and map_off.
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 6bab58797685..71ec6063dce6 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -478,7 +478,7 @@ void bpf_free_subprog_jts(struct bpf_verifier_env *env)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
+	for (i = 0; i < env->subprog_cnt; i++) {
 		kvfree(env->subprog_info[i].jt);
 		env->subprog_info[i].jt = NULL;
 	}
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 77dfb45708b6..79e079e907c9 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -163,8 +163,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 
 	krecord = prog->aux->func_info;
-	info_aux = kzalloc_objs(*info_aux, nfuncs,
-				BPF_VERIFIER_GFP);
+	info_aux = kvzalloc_objs(*info_aux, nfuncs, BPF_VERIFIER_GFP);
 	if (!info_aux)
 		return -ENOMEM;
 
@@ -207,7 +206,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	return 0;
 
 err_free:
-	kfree(info_aux);
+	kvfree(info_aux);
 	return ret;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 147261bf9e6d..2f0c9e246876 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1595,7 +1595,6 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed)
 {
-	s16 off = insn->off;
 	s32 imm = insn->imm;
 	u8 *addr;
 	int err;
@@ -1609,8 +1608,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 		if (!extra_pass)
 			addr = NULL;
 		else if (prog->aux->func &&
-			 off >= 0 && off < prog->aux->real_func_cnt)
-			addr = (u8 *)prog->aux->func[off]->bpf_func;
+			 imm >= 0 && imm < prog->aux->real_func_cnt)
+			addr = (u8 *)prog->aux->func[imm]->bpf_func;
 		else
 			return -EINVAL;
 	} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
@@ -3519,7 +3518,7 @@ static void bpf_prog_free_images(struct work_struct *work)
 		bpf_jit_free(aux->func[i]);
 	}
 	if (aux->real_func_cnt) {
-		kfree(aux->func);
+		kvfree(aux->func);
 		bpf_prog_unlock_free(aux->prog);
 	} else {
 		bpf_jit_free(aux->prog);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3daa419f75a9..4d9b67981520 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1672,6 +1672,11 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env, struct bpf_prog *prog
 	return 0;
 }
 
+static int insn_callee(struct bpf_verifier_env *env, int idx)
+{
+	return bpf_find_subprog(env, idx + env->prog->insnsi[idx].imm + 1);
+}
+
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog, **func, *tmp;
@@ -1681,57 +1686,21 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	void *old_bpf_func;
 	int err, num_exentries;
 
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
-			continue;
-
-		/* Upon error here we cannot fall back to interpreter but
-		 * need a hard reject of the program. Thus -EFAULT is
-		 * propagated in any case.
-		 */
-		subprog = bpf_find_subprog(env, i + insn->imm + 1);
-		if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
-				    i + insn->imm + 1))
-			return -EFAULT;
-		/* temporarily remember subprog id inside insn instead of
-		 * aux_data, since next loop will split up all insns into funcs
-		 */
-		insn->off = subprog;
-		/* remember original imm in case JIT fails and fallback
-		 * to interpreter will be needed
-		 */
-		env->insn_aux_data[i].call_imm = insn->imm;
-		/* point imm to __bpf_call_base+1 from JITs point of view */
-		insn->imm = 1;
-		if (bpf_pseudo_func(insn)) {
-#if defined(MODULES_VADDR)
-			u64 addr = MODULES_VADDR;
-#else
-			u64 addr = VMALLOC_START;
-#endif
-			/* jit (e.g. x86_64) may emit fewer instructions
-			 * if it learns a u32 imm is the same as a u64 imm.
-			 * Set close enough to possible prog address.
-			 */
-			insn[0].imm = (u32)addr;
-			insn[1].imm = addr >> 32;
-		}
-	}
-
 	err = bpf_prog_alloc_jited_linfo(prog);
 	if (err)
-		goto out_undo_insn;
+		goto out_done;
 
 	err = -ENOMEM;
-	func = kzalloc_objs(prog, env->subprog_cnt);
+	func = kvzalloc_objs(prog, env->subprog_cnt, BPF_VERIFIER_GFP);
 	if (!func)
-		goto out_undo_insn;
+		goto out_done;
 
 	for (i = 0; i < env->subprog_cnt; i++) {
 		subprog_start = subprog_end;
 		subprog_end = env->subprog_info[i + 1].start;
 
 		len = subprog_end - subprog_start;
+		err = -ENOMEM;
 		/* bpf_prog_run() doesn't call subprogs directly,
 		 * hence main prog stats include the runtime of subprogs.
 		 * subprogs don't have IDs and not reachable via prog_get_next_id
@@ -1744,6 +1713,32 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		       len * sizeof(struct bpf_insn));
 		func[i]->type = prog->type;
 		func[i]->len = len;
+		for (j = 0, insn = func[i]->insnsi; j < len; j++, insn++) {
+			if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
+				continue;
+			/* a hard reject, there is no fall back to the interpreter */
+			subprog = insn_callee(env, subprog_start + j);
+			if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
+					    subprog_start + j)) {
+				err = -EFAULT;
+				goto out_free;
+			}
+			/* JITs take the address from aux->func[] in the last pass */
+			insn->imm = subprog;
+			if (bpf_pseudo_func(insn)) {
+#if defined(MODULES_VADDR)
+				u64 addr = MODULES_VADDR;
+#else
+				u64 addr = VMALLOC_START;
+#endif
+				/* jit (e.g. x86_64) may emit fewer instructions
+				 * if it learns a u32 imm is the same as a u64 imm.
+				 * Set close enough to possible prog address.
+				 */
+				insn[0].imm = (u32)addr;
+				insn[1].imm = addr >> 32;
+			}
+		}
 		if (bpf_prog_calc_tag(func[i]))
 			goto out_free;
 		func[i]->is_func = 1;
@@ -1821,7 +1816,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			err = -ENOTSUPP;
 			goto out_free;
 		}
-		cond_resched();
+		err = -EINTR;
+		if (bpf_must_abort())
+			goto out_free;
 	}
 
 	/* at this point all bpf functions were successfully JITed
@@ -1831,28 +1828,17 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < env->subprog_cnt; i++) {
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
-			if (bpf_pseudo_func(insn)) {
-				subprog = insn->off;
-				insn[0].imm = (u32)(long)func[subprog]->bpf_func;
-				insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
-				continue;
-			}
-			if (!bpf_pseudo_call(insn))
+			if (!bpf_pseudo_func(insn))
 				continue;
-			subprog = insn->off;
-			insn->imm = BPF_CALL_IMM(func[subprog]->bpf_func);
+			subprog = insn_callee(env, func[i]->aux->subprog_start + j);
+			insn[0].imm = (u32)(long)func[subprog]->bpf_func;
+			insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
 		}
 
 		/* we use the aux data to keep a list of the start addresses
 		 * of the JITed images for each function in the program
 		 *
-		 * for some architectures, such as powerpc64, the imm field
-		 * might not be large enough to hold the offset of the start
-		 * address of the callee's JITed image from __bpf_call_base
-		 *
-		 * in such cases, we can lookup the start address of a callee
-		 * by using its subprog id, available from the off field of
-		 * the call instruction, as an index for this list
+		 * the imm field of a call has the subprog id, an index for this list
 		 */
 		func[i]->aux->func = func;
 		func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
@@ -1866,7 +1852,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			err = -ENOTSUPP;
 			goto out_free;
 		}
-		cond_resched();
+		err = -EINTR;
+		if (bpf_must_abort())
+			goto out_free;
 	}
 
 	/* the addresses of all functions are final */
@@ -1900,19 +1888,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * prog consistent for later dump requests, so they can
 	 * later look the same as if they were interpreted only.
 	 */
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (bpf_pseudo_func(insn)) {
-			insn[0].imm = env->insn_aux_data[i].call_imm;
-			insn[1].imm = insn->off;
-			insn->off = 0;
-			continue;
-		}
-		if (!bpf_pseudo_call(insn))
-			continue;
-		insn->imm = env->insn_aux_data[i].call_imm;
-		subprog = bpf_find_subprog(env, i + insn->imm + 1);
-		insn->off = subprog;
-	}
+	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++)
+		if (bpf_pseudo_func(insn))
+			insn[1].imm = insn_callee(env, i);
 
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
@@ -1946,17 +1924,16 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->poke_tab = NULL;
 		bpf_jit_free(func[i]);
 	}
-	kfree(func);
-out_undo_insn:
+	kvfree(func);
+out_done:
 	bpf_prog_jit_attempt_done(prog);
 	return err;
 }
 
 int bpf_jit_subprogs(struct bpf_verifier_env *env)
 {
-	int err, i;
+	int err;
 	bool blinded = false;
-	struct bpf_insn *insn;
 	struct bpf_prog *prog, *orig_prog;
 	u32 *orig_subprog_starts;
 
@@ -1992,28 +1969,11 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	return 0;
 
 out_jit_err:
-	if (blinded) {
-		bpf_jit_prog_release_other(orig_prog, prog);
-		/* roll back to the clean original prog */
-		prog = env->prog = orig_prog;
-		goto out_restore;
-	} else {
-		if (err != -EFAULT) {
-			/*
-			 * We will fall back to interpreter mode when err is not -EFAULT, before
-			 * that, insn->off and insn->imm should be restored to their original
-			 * values since they were modified by jit_subprogs.
-			 */
-			for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-				if (!bpf_pseudo_call(insn))
-					continue;
-				insn->off = 0;
-				insn->imm = env->insn_aux_data[i].call_imm;
-			}
-		}
+	if (!blinded)
 		goto out_cleanup;
-	}
-
+	bpf_jit_prog_release_other(orig_prog, prog);
+	/* roll back to the clean original prog */
+	prog = env->prog = orig_prog;
 out_restore:
 	bpf_restore_subprog_starts(env, orig_subprog_starts);
 	kvfree(orig_subprog_starts);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 053b3875cde6..cfa416f76209 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2365,7 +2365,8 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	struct func_instance *prev_instance = NULL;
 	int j, err;
 
-	if (++env->liveness->subprog_calls > 10000) {
+	/* a subprog on its own is analyzed once, chains of calls multiply */
+	if (depth && ++env->liveness->subprog_calls > 10000) {
 		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
 			env->liveness->subprog_calls);
 		return -E2BIG;
@@ -2817,7 +2818,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	int err = 0, i, subprog, start, end;
+	int err = 0, i, n = 0, subprog, start, end, *order;
 	bool changed, ret_reg_pair;
 
 	/* Use the following algorithm:
@@ -2840,7 +2841,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	 *   any instruction.
 	 */
 	state = kvzalloc_objs(*state, insn_cnt, BPF_VERIFIER_GFP);
-	if (!state) {
+	order = kvzalloc_objs(*order, insn_cnt, BPF_VERIFIER_GFP);
+	if (!state || !order) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -2854,6 +2856,15 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
 	}
 
+	/* callees first, so a chain of calls takes one round */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		subprog = env->subprog_topo_order[i];
+		start = env->subprog_info[subprog].postorder_start;
+		end = env->subprog_info[subprog + 1].postorder_start;
+		while (start < end)
+			order[n++] = env->cfg.insn_postorder[start++];
+	}
+
 	changed = true;
 	while (changed) {
 		u32 args = mask_widen(GENMASK(BPF_REG_5, BPF_REG_1)), callx_use = 0, declared;
@@ -2882,7 +2893,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			goto out;
 		}
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
-			int insn_idx = env->cfg.insn_postorder[i];
+			int insn_idx = order[i];
 			struct insn_live_regs *live = &state[insn_idx];
 			struct bpf_iarray *succ;
 			u32 new_out = 0;
@@ -2943,6 +2954,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	 */
 	err = bpf_compute_subprog_arg_access(env);
 out:
+	kvfree(order);
 	kvfree(state);
 	return err;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6a567d55c024..8d42a5c8dc89 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2465,7 +2465,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	kvfree(aux->jited_linfo);
 	kvfree(aux->linfo);
 	kvfree(aux->func_info);
-	kfree(aux->func_info_aux);
+	kvfree(aux->func_info_aux);
 	free_uid(aux->user);
 	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
@@ -5035,7 +5035,22 @@ static int bpf_prog_map_addrs(const struct bpf_prog *prog, struct maple_tree *mt
 	return err;
 }
 
-static void prepare_dump_pseudo_call(struct bpf_insn *insn)
+/* the id of the subprog that starts at insn 'start' */
+static u32 bpf_prog_find_func(const struct bpf_prog *prog, u32 start)
+{
+	u32 l = 0, r = prog->aux->real_func_cnt, m;
+
+	while (r - l > 1) {
+		m = (l + r) / 2;
+		if (prog->aux->func[m]->aux->subprog_start <= start)
+			l = m;
+		else
+			r = m;
+	}
+	return l;
+}
+
+static void prepare_dump_pseudo_call(const struct bpf_prog *prog, struct bpf_insn *insn, u32 idx)
 {
 	s32 call_off = insn->imm;
 
@@ -5044,12 +5059,12 @@ static void prepare_dump_pseudo_call(struct bpf_insn *insn)
 	 * 1. For interpreter (BPF_CALL_ARGS): insn->off is the index of
 	 *    interpreters_args array, so here using bpf_call_args_imm()
 	 *    to get the real address offset.
-	 * 2. For JIT (BPF_CALL): insn->off is the subprog id.
+	 * 2. For JIT (BPF_CALL): the subprog id.
 	 */
 	if (insn->code == (BPF_JMP | BPF_CALL_ARGS))
 		insn->imm = bpf_call_args_imm(insn->off);
 	else
-		insn->imm = insn->off;
+		insn->imm = bpf_prog_find_func(prog, idx + call_off + 1);
 
 	/* Avoid dumping a truncated and misleading pc-relative offset. */
 	if (call_off > S16_MAX || call_off < S16_MIN)
@@ -5093,7 +5108,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 		    code == (BPF_JMP | BPF_CALL_ARGS)) {
 			/* Restore the legacy xlated dump layout. */
 			if (insns[i].src_reg == BPF_PSEUDO_CALL)
-				prepare_dump_pseudo_call(&insns[i]);
+				prepare_dump_pseudo_call(prog, &insns[i], i);
 			if (code == (BPF_JMP | BPF_CALL_ARGS))
 				insns[i].code = BPF_JMP | BPF_CALL;
 			if (!bpf_dump_raw_ok(f_cred))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 35b94ab7ba97..1381b03ab0ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2602,31 +2602,14 @@ int bpf_find_subprog(struct bpf_verifier_env *env, int off)
 	return p - env->subprog_info;
 }
 
-static int add_subprog(struct bpf_verifier_env *env, int off)
+static int add_subprog(struct bpf_verifier_env *env, unsigned long *starts, int off)
 {
-	struct bpf_subprog_info *subprog = env->subprog_info;
-	int insn_cnt = env->prog->len;
-	int i;
-
-	if (off >= insn_cnt || off < 0) {
+	if (off >= env->prog->len || off < 0) {
 		verbose(env, "call to invalid destination\n");
 		return -EINVAL;
 	}
-	i = bpf_find_subprog(env, off);
-	if (i >= 0)
-		return i;
-	if (env->subprog_cnt >= BPF_MAX_SUBPROGS) {
-		verbose(env, "too many subprograms\n");
-		return -E2BIG;
-	}
-	/*
-	 * Determine subprog starts. The end is one before the next starts.
-	 * The array stays sorted: subprogs that start after 'off' move up.
-	 */
-	for (i = env->subprog_cnt++; i > 0 && subprog[i - 1].start > off; i--)
-		subprog[i] = subprog[i - 1];
-	subprog[i] = (struct bpf_subprog_info){ .start = off, .exit_idx = U32_MAX };
-	return i;
+	__set_bit(off, starts);
+	return 0;
 }
 
 static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
@@ -3103,15 +3086,17 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 
 static int add_subprogs(struct bpf_verifier_env *env)
 {
-	struct bpf_subprog_info *subprog = env->subprog_info;
-	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
+	int i, cnt, ret, insn_cnt = env->prog->len, ex_cb_insn;
+	unsigned long *starts __free(kvfree) = NULL;
 	struct bpf_insn *insn = env->prog->insnsi;
 	const char *operation, *suggestion;
+	struct bpf_subprog_info *subprog;
 
+	starts = kvcalloc(BITS_TO_LONGS(insn_cnt), sizeof(long), BPF_VERIFIER_GFP);
+	if (!starts)
+		return -ENOMEM;
 	/* Add entry function. */
-	ret = add_subprog(env, 0);
-	if (ret)
-		return ret;
+	__set_bit(0, starts);
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
@@ -3133,7 +3118,7 @@ static int add_subprogs(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		ret = add_subprog(env, i + insn->imm + 1);
+		ret = add_subprog(env, starts, i + insn->imm + 1);
 		if (ret < 0)
 			return ret;
 	}
@@ -3148,7 +3133,7 @@ static int add_subprogs(struct bpf_verifier_env *env)
 		struct bpf_prog_aux *aux = env->prog->aux;
 
 		for (i = 1; i < aux->func_info_cnt; i++) {
-			ret = add_subprog(env, aux->func_info[i].insn_off);
+			ret = add_subprog(env, starts, aux->func_info[i].insn_off);
 			if (ret < 0)
 				return ret;
 		}
@@ -3162,23 +3147,32 @@ static int add_subprogs(struct bpf_verifier_env *env)
 	/* If ex_cb_insn > 0, this means that the main program has a subprog
 	 * marked using BTF decl tag to serve as the exception callback.
 	 */
-	if (ex_cb_insn) {
-		ret = add_subprog(env, ex_cb_insn);
-		if (ret < 0)
-			return ret;
-		for (i = 1; i < env->subprog_cnt; i++) {
-			if (env->subprog_info[i].start != ex_cb_insn)
-				continue;
-			env->exception_callback_subprog = i;
-			bpf_mark_subprog_exc_cb(env, i);
-			break;
-		}
+	ret = add_subprog(env, starts, ex_cb_insn);
+	if (ret < 0)
+		return ret;
+
+	/* + 2 for the fake and the hidden subprogs */
+	cnt = bitmap_weight(starts, insn_cnt);
+	subprog = env->subprog_info = kvcalloc(cnt + 2, sizeof(*subprog), BPF_VERIFIER_GFP);
+	env->subprog_topo_order = kvcalloc(cnt, sizeof(int), BPF_VERIFIER_GFP);
+	if (!subprog || !env->subprog_topo_order)
+		return -ENOMEM;
+
+	/* Determine subprog starts. The end is one before the next starts. */
+	for_each_set_bit(i, starts, insn_cnt) {
+		subprog[env->subprog_cnt].start = i;
+		subprog[env->subprog_cnt++].exit_idx = U32_MAX;
 	}
 
 	/* Add a fake 'exit' subprog which could simplify subprog iteration
 	 * logic. 'subprog_cnt' should not be increased.
 	 */
-	subprog[env->subprog_cnt].start = insn_cnt;
+	subprog[cnt].start = insn_cnt;
+
+	if (ex_cb_insn) {
+		env->exception_callback_subprog = bpf_find_subprog(env, ex_cb_insn);
+		bpf_mark_subprog_exc_cb(env, env->exception_callback_subprog);
+	}
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < env->subprog_cnt; i++)
@@ -25364,6 +25358,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->func_set_index.slots);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
+	kvfree(env->subprog_info);
+	kvfree(env->subprog_topo_order);
 	kvfree(env);
 	return ret;
 }
-- 
2.55.0

