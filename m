Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B44C4F79
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=erkBB4LelT2dqbF78CepUzm5peslVdiPWjaIBTZOZTyg4iNy/ZzTO+ERoJB/55hbnh+Fa1Wfl5Ap1qH/ckw4XLsJ0RhFAfVlb5Zcyov9XQnIp/BLbTQHokhoHIlJ2lU/F/CQjgRnKcTDEuc64YwxuqUxF2GlaCXtcUBmDNSpbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=CK4WimFRoAoJpdH4fGnMEIq42YYvKVkvsnO5660jplo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpOjLjf/U96A3NAWuOYRVWAeZkmIzP/Skjr08qB33KqACE9+9h6fjVmf/DXxrr80JuJqWmedswzN9WAXgnDySJ9kZMJDlHlfjJuSnkB8soMpMwKQRhdjnxCEaLGxYtBMPAWnhWcYfNQo0Uad9mLQyac6Gt0JRhCkTOi1OlfB0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Z8c0+fbK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Z8c0+fbK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xuVUAEAAPlAtZBVGMmU9jJ7M0SNaCJa2jRLoST97YPk=; b=Z8c0+fbKLBZ4Q4mTDvOF/SDYde
	W5gtNPaPB/bx+foe6Ab4jARuKRzs81YJXFn5AU7O0RFCXVC+cX8kmLsqC/axzpBV00DOJcB2obBca
	Q1XYk4tAZO55zuCPeFLFltjMK4EVozPnDtZkkkB5rbVO3K4mtJFDcXm6y0d59cVS6h+dsKN1DURDx
	aUVEnfD7UCyhd1rYZyyc2usdRGdlOk1sQCo2XP7TxwAIoQJ2bUjKnMYQELuFV4N6EF1D2CwkTDCEq
	bOPfPUZ1C4DNLDf4CUApprea2K6ay23ymatrSyyFMjqkKp7dSHqsGk5ZfOmaRye3siXkC24FAYRiz
	Hiwth8rA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6N-000Jkn-2t;
	Fri, 25 Sep 2026 19:52:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Nicholas Carlini <npc@anthropic.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 10/16] bpf: Retarget indirect jump targets across prologue prepends
Date: Fri, 25 Sep 2026 19:52:37 +0200
Message-ID: <20260925175244.1136329-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

A few patches do not expand in place, they prepend: bpf_convert_ctx_accesses()
puts the ctx save for gen_epilogue and the instructions of gen_prologue in
front of insn 0, and bpf_do_misc_fixups() prepends the may_goto counter init
at the start of every subprog that uses may_goto.

They copy the original instruction of 'tgt_idx' into the last slot of the
patch buffer, so it now lives at tgt_idx + delta, and call adjust_jmp_off()
to move direct branches from tgt_idx to tgt_idx + delta.

Nothing does the same for indirect branches, so a BPF_MAP_TYPE_INSN_ARRAY
slot that named tgt_idx keeps naming tgt_idx, which is now the first prepended
instruction, and insn_aux_data[tgt_idx].indirect_target makes the JIT emit
the landing pad there. Add a __bpf_patch_insn_data() variant and pass
BPF_PATCH_MOVE_TARGET at the affected call-sites to fix up the delta. The
poke descriptors of direct tail calls are shifted the same way, and the
original instruction is not searched for by content in that mode, as it
is the last slot by construction.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Fixes: 07ae6c130b46 ("bpf: Add helper to detect indirect jump targets")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h         |  2 +-
 kernel/bpf/bpf_insn_array.c |  4 +--
 kernel/bpf/fixups.c         | 56 ++++++++++++++++++++++++++-----------
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8594c8aff745..2cf04bba16bb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4289,7 +4289,7 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
 int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
-void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 61d6a076dfdb..92bbb71576ae 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -236,7 +236,7 @@ void bpf_insn_array_release(struct bpf_map *map)
 	atomic_set_release(&insn_array->used, 0);
 }
 
-void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
+void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
 	int i;
@@ -245,7 +245,7 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
 		return;
 
 	for (i = 0; i < map->max_entries; i++) {
-		if (insn_array->values[i].xlated_off <= off)
+		if (insn_array->values[i].xlated_off < first)
 			continue;
 		if (insn_array->values[i].xlated_off == INSN_DELETED)
 			continue;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d4e54fa42dae..37cf130ebb57 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -214,13 +214,19 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
+enum bpf_patch_mode {
+	BPF_PATCH_KEEP_TARGET,	/* targets of 'off' keep naming 'off', the first new insn */
+	BPF_PATCH_MOVE_TARGET,	/* targets of 'off' follow the original insn to 'off + len - 1' */
+};
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 				 struct bpf_prog *new_prog, u32 off, u32 cnt,
-				 struct bpf_insn *original_insn)
+				 struct bpf_insn *original_insn,
+				 enum bpf_patch_mode mode)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
@@ -253,7 +259,12 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
-		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
+		/*
+		 * In BPF_PATCH_MOVE_TARGET mode the original insn is the last
+		 * slot by construction.
+		 */
+		if (mode == BPF_PATCH_KEEP_TARGET &&
+		    !memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
 			data[i].non_stack_access =
 				data[off + cnt - 1].non_stack_access;
 			data[off + cnt - 1].non_stack_access = false;
@@ -277,9 +288,10 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * new instructions by the above memmove and memset, but the indirect jump target is
 	 * actually the first instruction, so move it back. This also matches with the behavior
 	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
-	 * instruction.
+	 * instruction. For BPF_PATCH_MOVE_TARGET the original instruction is the last one,
+	 * so the flag already sits where needed.
 	 */
-	if (data[off + cnt - 1].indirect_target) {
+	if (mode == BPF_PATCH_KEEP_TARGET && data[off + cnt - 1].indirect_target) {
 		data[off].indirect_target = 1;
 		data[off + cnt - 1].indirect_target = 0;
 	}
@@ -299,7 +311,7 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
-static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
+static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 first, u32 len)
 {
 	int i;
 
@@ -307,7 +319,7 @@ static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
 		return;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust(env->insn_array_maps[i], off, len);
+		bpf_insn_array_adjust(env->insn_array_maps[i], first, len);
 }
 
 static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
@@ -318,7 +330,7 @@ static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 of
 		bpf_insn_array_adjust_after_remove(env->insn_array_maps[i], off, len);
 }
 
-static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
+static void adjust_poke_descs(struct bpf_prog *prog, u32 first, u32 len)
 {
 	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
 	int i, sz = prog->aux->size_poke_tab;
@@ -326,7 +338,7 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 
 	for (i = 0; i < sz; i++) {
 		desc = &tab[i];
-		if (desc->insn_idx <= off)
+		if (desc->insn_idx < first)
 			continue;
 		desc->insn_idx += len - 1;
 	}
@@ -345,11 +357,14 @@ static bool bpf_rewrite_must_abort(void)
 	return false;
 }
 
-struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len)
+static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+					      const struct bpf_insn *patch, u32 len,
+					      enum bpf_patch_mode mode)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
+	/* The first slot whose targets move. */
+	u32 first = mode == BPF_PATCH_MOVE_TARGET ? off : off + 1;
 	struct bpf_insn original_insn;
 
 	if (bpf_rewrite_must_abort())
@@ -375,14 +390,20 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
+	adjust_insn_aux_data(env, new_prog, off, len, &original_insn, mode);
 	adjust_subprog_starts(env, off, len);
-	adjust_insn_arrays(env, off, len);
+	adjust_insn_arrays(env, first, len);
 	bpf_adjust_func_ptrs(env, off, len);
-	adjust_poke_descs(new_prog, off, len);
+	adjust_poke_descs(new_prog, first, len);
 	return new_prog;
 }
 
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len)
+{
+	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_KEEP_TARGET);
+}
+
 /*
  * insn was moved down by delta insns inside its own patch. Operands relative
  * to the pc that point in front of the old position did not move with it.
@@ -883,7 +904,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
 						      -subprogs[0].stack_depth);
 			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
+							 BPF_PATCH_MOVE_TARGET);
 			if (!new_prog)
 				return -ENOMEM;
 			env->prog = new_prog;
@@ -906,7 +928,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
+							 BPF_PATCH_MOVE_TARGET);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2666,7 +2689,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 		cnt++;
 
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
+		new_prog = __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
+						 BPF_PATCH_MOVE_TARGET);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
-- 
2.43.0

