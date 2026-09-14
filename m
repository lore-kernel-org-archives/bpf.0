Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F648F84F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405416; cv=none; b=GvFEDXQr9rIet5Z0s5P1jYgLnc4W9VH/QxG70vbCckAlvIoqf7sMmI1h/NC3XcXglsL3+I0Oe4cb/U7mlCG3UcOukT6m2pZWRKariL5jix40ulG9ow1BAQTfHtnAqNf+Rw46pWRPmBL8JfPGUEJoonehHwAi12H6856IslxzdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405416; c=relaxed/simple;
	bh=Ap3yEKRKQOEIIEH6p/ALVkPylIjZyi273FCFRM1dXfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/V91E8/ybAkv3Wegd34jFQAM0ANph8vVvAjshJkJP/PMYCGCKOZTWSDMB7HVcWx2FLAsAcn9gsweZVTEFIvl1W4vPIHQpvrCh/izZNnKNnNjudCdya6bYX7AACHNuryaiC6VRITz4rgK/PwK0PO26jXQ1LNA3BfhxzNykp+bI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZlGqgzcM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZlGqgzcM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZazDHL8AlkmPby125+sATB2b74mThGPE4329g7I/9Sc=; b=ZlGqgzcMNYbiCBbIzThFFJ9H2l
	JrqIQNHRYXKaGMlcLZF4Yjz1bRAAjsuaWMEO1sZXhV2/YNp0nHRfzdKa0zZ41yDjIX6TdmwtfnP05
	dt/tJh8onh1kpBXF/zHynqEllvJ/1FAbmQ/kcvT36K8A6NwLkSGgbxenF6lqLrV2UAOatMLgG4qf3
	0IyGt6CwP0HEGEhgK1kXsYYhdJPf1oi3Bfv/A8hhirY/HZVGSmNshKS7LnwP/MTrEnwBxoeN5XY/9
	OJxA0gztChjwMKu9PkMQcxr+ibh65cQQPlKoPQKZalkDEKCkgRZz+YSpy7j6PqA4goEWXwDMEXkYN
	7ik322Ug==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5c-000C9A-0X;
	Mon, 14 Sep 2026 19:03:32 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Nicholas Carlini <npc@anthropic.com>
Subject: [PATCH bpf v2 07/11] bpf: Retarget indirect jump targets across prologue prepends
Date: Mon, 14 Sep 2026 19:03:22 +0200
Message-ID: <20260914170326.249953-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

A few patches do not expand in place, they prepend: gen_epilogue and
gen_prologue splice their instructions in front of insn 0 in
bpf_convert_ctx_accesses(), and bpf_do_misc_fixups() prepends the may_goto
counter init at every subprog start.

They copy the original instruction of 'tgt_idx' into the last slot of the
patch buffer, so it now lives at tgt_idx + delta, and call adjust_jmp_off()
to move direct branches from tgt_idx to tgt_idx + delta.

Nothing does the same for indirect branches, so a BPF_MAP_TYPE_INSN_ARRAY
slot that named tgt_idx keeps naming tgt_idx, which is now the first prepended
instruction, and insn_aux_data[tgt_idx].indirect_target makes the JIT emit
the landing pad there. Add a __bpf_patch_insn_data() variant and pass the
BPF_PREPEND at the affected call-sites to fix up the delta.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Fixes: 07ae6c130b46 ("bpf: Add helper to detect indirect jump targets")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h         |  2 +-
 kernel/bpf/bpf_insn_array.c |  4 ++--
 kernel/bpf/fixups.c         | 41 ++++++++++++++++++++++++++-----------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c..8115f307444a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4165,7 +4165,7 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
 int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
-void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 5874abd1f743..350ecea8f1e8 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -235,7 +235,7 @@ void bpf_insn_array_release(struct bpf_map *map)
 	atomic_set(&insn_array->used, 0);
 }
 
-void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
+void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
 	int i;
@@ -244,7 +244,7 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
 		return;
 
 	for (i = 0; i < map->max_entries; i++) {
-		if (insn_array->values[i].xlated_off <= off)
+		if (insn_array->values[i].xlated_off < first)
 			continue;
 		if (insn_array->values[i].xlated_off == INSN_DELETED)
 			continue;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index aa3fb7b87fb0..e132bd0600c7 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -213,12 +213,18 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
+enum bpf_patch_mode {
+	BPF_APPEND,
+	BPF_PREPEND,
+};
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt)
+				 struct bpf_prog *new_prog, u32 off, u32 cnt,
+				 enum bpf_patch_mode mode)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
@@ -251,9 +257,10 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * new instructions by the above memmove and memset, but the indirect jump target is
 	 * actually the first instruction, so move it back. This also matches with the behavior
 	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
-	 * instruction.
+	 * instruction. For BPF_PREPEND the original instruction is the last one, so the flag
+	 * already sits where needed.
 	 */
-	if (data[off + cnt - 1].indirect_target) {
+	if (mode == BPF_APPEND && data[off + cnt - 1].indirect_target) {
 		data[off].indirect_target = 1;
 		data[off + cnt - 1].indirect_target = 0;
 	}
@@ -273,7 +280,7 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
-static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
+static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 first, u32 len)
 {
 	int i;
 
@@ -281,7 +288,7 @@ static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
 		return;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust(env->insn_array_maps[i], off, len);
+		bpf_insn_array_adjust(env->insn_array_maps[i], first, len);
 }
 
 static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
@@ -306,8 +313,9 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
-struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len)
+static struct bpf_prog *__bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+					      const struct bpf_insn *patch, u32 len,
+					      enum bpf_patch_mode mode)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
@@ -331,13 +339,19 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len, mode);
 	adjust_subprog_starts(env, off, len);
-	adjust_insn_arrays(env, off, len);
+	adjust_insn_arrays(env, mode == BPF_PREPEND ? off : off + 1, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
 
+struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+				     const struct bpf_insn *patch, u32 len)
+{
+	return __bpf_patch_insn_data(env, off, patch, len, BPF_APPEND);
+}
+
 /*
  * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
  * jump offset by 'delta'.
@@ -755,7 +769,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
 						      -subprogs[0].stack_depth);
 			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
+							 BPF_PREPEND);
 			if (!new_prog)
 				return -ENOMEM;
 			env->prog = new_prog;
@@ -778,7 +793,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
+							 BPF_PREPEND);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2443,7 +2459,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		/* Copy first actual insn to preserve it */
 		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
 
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
+		new_prog = __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
+						 BPF_PREPEND);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
-- 
2.43.0

