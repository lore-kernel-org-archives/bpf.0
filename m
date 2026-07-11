Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E75495E5;
	Sat, 11 Jul 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747483; cv=none; b=SF/D7HpQYJI11JXJa9wpMY9WJB+qkgG6Td0w2fRKKGaZ0Bhc47uU99GlYS9SEHUAwf8NrXa6u8G3yLhi4ZpeikFS5O5IMAUGUKDKDNDebqW039er2Xu7f22oSUE2i3UCJT9cvkHIOwfBOC8ddK6FX/gMPYJJ9aAkzIN+dKrEBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747483; c=relaxed/simple;
	bh=PmT9LorRstnkYjoQl9yybf/yBRDIaFXEmC5RSS0XpE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1LNR9LfI0a6z4ISk3jfvUea2hNLJ2yC6vBKonNJPpbNpxTQc5zATu1y8D4JAIiGpSHnko2UZ2IHy4psLrdpV5+ywFQcAKGvFGvU9IkD1Ei5r8a0BOOiHFLrcrDezKeWH/Xir/7nsguDH6zMlBP2X9WiQ01hbu+36VodeFEUOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gxxvZ3cX2zKHMKH;
	Sat, 11 Jul 2026 13:24:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D254040592;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBndnKS01FqF1tCAw--.37295S4;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore subprog_starts and prog clone
Date: Sat, 11 Jul 2026 13:23:12 +0000
Message-ID: <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783775928.git.xukuohai@huaweicloud.com>
References: <cover.1783775928.git.xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBndnKS01FqF1tCAw--.37295S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWkZFWDXFy8WFW8ur18uFg_yoWfAFy7pF
	95t34DCr4qqw40g3srJa18Ary5Ja18Ww15CrW8G34Iqa1jqrn5Wa13Kw4vqFZ3Cry8Ww1x
	Zr4q9r9rW3y8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IUnoEEUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When JIT is required by the bpf program, the kernel rejects the program
on JIT failure rather than falling back to the interpreter. In this case,
the subprog_starts dup/restore and bpf prog clone are not necessary, since
they are only used to restore state for the interpreter.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/filter.h |   9 ++--
 kernel/bpf/core.c      | 104 +++++++++++++++++++++++------------------
 kernel/bpf/fixups.c    |  32 ++++++-------
 3 files changed, 81 insertions(+), 64 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 25148865f9c7..232c02031fec 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1355,7 +1355,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 
 const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog);
+int bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog **pprog,
+			    bool clone_needed, bool *cloned);
 void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 
 static inline bool bpf_prog_need_blind(const struct bpf_prog *prog)
@@ -1507,9 +1508,11 @@ static inline bool bpf_prog_need_blind(const struct bpf_prog *prog)
 }
 
 static inline
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
+int bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog **pprog,
+			    bool clone_needed, bool *cloned)
 {
-	return prog;
+	*cloned = false;
+	return 0;
 }
 
 static inline void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b7f17f89d992..0a8072f59789 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1552,27 +1552,34 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
  * Now this function is used only to blind the main prog and must be invoked only when
  * bpf_prog_need_blind() returns true.
  */
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
+int bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog **pprog,
+			    bool clone_needed, bool *cloned)
 {
 	struct bpf_insn insn_buff[16], aux[2];
-	struct bpf_prog *clone, *tmp;
+	struct bpf_prog *prog, *orig_prog, *tmp;
 	int insn_delta, insn_cnt;
 	struct bpf_insn *insn;
 	int i, rewritten;
 
-	if (WARN_ON_ONCE(env && env->prog != prog))
-		return ERR_PTR(-EINVAL);
+	*cloned = false;
+	if (WARN_ON_ONCE(env && env->prog != *pprog))
+		return -EINVAL;
 
-	clone = bpf_prog_clone_create(prog, GFP_USER);
-	if (!clone)
-		return ERR_PTR(-ENOMEM);
+	prog = orig_prog = *pprog;
+	/* only clone the prog when we can fall back to the interpreter */
+	if (clone_needed) {
+		prog = bpf_prog_clone_create(orig_prog, GFP_USER);
+		if (!prog)
+			return -ENOMEM;
 
-	/* make sure bpf_patch_insn_data() patches the correct prog */
-	if (env)
-		env->prog = clone;
+		*cloned = true;
+		/* make sure bpf_patch_insn_data() patches the correct prog */
+		if (env)
+			env->prog = prog;
+	}
 
-	insn_cnt = clone->len;
-	insn = clone->insnsi;
+	insn_cnt = prog->len;
+	insn = prog->insnsi;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
@@ -1593,42 +1600,49 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 		    insn[1].code == 0)
 			memcpy(aux, insn, sizeof(aux));
 
-		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff,
-						clone->aux->verifier_zext);
+		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff, prog->aux->verifier_zext);
 		if (!rewritten)
 			continue;
 
 		if (env)
 			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten);
 		else
-			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
+			tmp = bpf_patch_insn_single(prog, i, insn_buff, rewritten);
 
 		if (IS_ERR_OR_NULL(tmp)) {
-			if (env)
-				/* restore the original prog */
-				env->prog = prog;
-			/* Patching may have repointed aux->prog during
-			 * realloc from the original one, so we need to
-			 * fix it up here on error.
-			 */
-			bpf_jit_prog_release_other(prog, clone);
-			return IS_ERR(tmp) ? tmp : ERR_PTR(-ENOMEM);
+			if (*cloned) {
+				/* roll back to the original prog */
+				*pprog = orig_prog;
+				if (env)
+					env->prog = orig_prog;
+				/* Patching may have repointed aux->prog during
+				 * realloc from the original one, so we need to
+				 * fix it up here on error.
+				 */
+				bpf_jit_prog_release_other(orig_prog, prog);
+			} else {
+				/* just keep the latest successfully patched prog */
+				*pprog = prog;
+			}
+			return IS_ERR(tmp) ? PTR_ERR(tmp) : -ENOMEM;
 		}
 
-		clone = tmp;
+		prog = tmp;
 		insn_delta = rewritten - 1;
 
 		if (env)
-			env->prog = clone;
+			env->prog = prog;
 
 		/* Walk new program and skip insns we just inserted. */
-		insn = clone->insnsi + i + insn_delta;
+		insn = prog->insnsi + i + insn_delta;
 		insn_cnt += insn_delta;
 		i        += insn_delta;
 	}
 
-	clone->blinded = 1;
-	return clone;
+	prog->blinded = 1;
+	*pprog = prog;
+
+	return 0;
 }
 
 bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
@@ -2618,33 +2632,33 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog,
+					     bool jit_needed)
 {
 #ifdef CONFIG_BPF_JIT
+	int err;
+	bool cloned = false;
 	struct bpf_prog *orig_prog;
 
 	if (!bpf_prog_need_blind(prog))
 		return bpf_int_jit_compile(env, prog);
 
 	orig_prog = prog;
-	prog = bpf_jit_blind_constants(env, prog);
-	/*
-	 * If blinding was requested and we failed during blinding, we must fall
-	 * back to the interpreter.
-	 */
-	if (IS_ERR(prog))
-		goto out_restore;
+	err = bpf_jit_blind_constants(env, &prog, !jit_needed, &cloned);
+	if (err)
+		goto out;
 
 	prog = bpf_int_jit_compile(env, prog);
-	if (prog->jited) {
-		bpf_jit_prog_release_other(prog, orig_prog);
-		return prog;
+	if (cloned) {
+		if (prog->jited) {
+			bpf_jit_prog_release_other(prog, orig_prog);
+		} else {
+			bpf_jit_prog_release_other(orig_prog, prog);
+			prog = orig_prog;
+		}
 	}
 
-	bpf_jit_prog_release_other(orig_prog, prog);
-
-out_restore:
-	prog = orig_prog;
+out:
 #endif
 	return prog;
 }
@@ -2674,7 +2688,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(env, fp);
+		fp = bpf_prog_jit_compile(env, fp, jit_needed);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37f22eb41854..80c8beb45ea0 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -996,6 +996,8 @@ static u32 *bpf_dup_subprog_starts(struct bpf_verifier_env *env)
 
 static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_starts)
 {
+	if (!orig_starts)
+		return;
 	for (int i = 0; i < env->subprog_cnt; i++)
 		env->subprog_info[i].start = orig_starts[i];
 	/* restore the start of fake 'exit' subprog as well */
@@ -1273,35 +1275,33 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 int bpf_jit_subprogs(struct bpf_verifier_env *env)
 {
 	int err, i;
-	bool blinded = false;
 	struct bpf_insn *insn;
 	struct bpf_prog *prog, *orig_prog;
-	u32 *orig_subprog_starts;
+	u32 *orig_subprog_starts = NULL;
+	bool cloned = false;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
 
 	prog = orig_prog = env->prog;
 	if (bpf_prog_need_blind(prog)) {
-		orig_subprog_starts = bpf_dup_subprog_starts(env);
-		if (!orig_subprog_starts) {
-			err = -ENOMEM;
-			goto out_cleanup;
+		if (!prog->jit_required) {
+			orig_subprog_starts = bpf_dup_subprog_starts(env);
+			if (!orig_subprog_starts) {
+				err = -ENOMEM;
+				goto out_cleanup;
+			}
 		}
-		prog = bpf_jit_blind_constants(env, prog);
-		if (IS_ERR(prog)) {
-			err = -ENOMEM;
-			prog = orig_prog;
+		err = bpf_jit_blind_constants(env, &prog, !prog->jit_required, &cloned);
+		if (err)
 			goto out_restore;
-		}
-		blinded = true;
 	}
 
 	err = jit_subprogs(env);
 	if (err)
 		goto out_jit_err;
 
-	if (blinded) {
+	if (cloned) {
 		bpf_jit_prog_release_other(prog, orig_prog);
 		kvfree(orig_subprog_starts);
 	}
@@ -1309,13 +1309,13 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	return 0;
 
 out_jit_err:
-	if (blinded) {
+	if (cloned) {
 		bpf_jit_prog_release_other(orig_prog, prog);
-		/* roll back to the clean original prog */
+		/* roll back to the clean  original prog */
 		prog = env->prog = orig_prog;
 		goto out_restore;
 	} else {
-		if (err != -EFAULT) {
+		if (err != -EFAULT && !prog->jit_required) {
 			/*
 			 * We will fall back to interpreter mode when err is not -EFAULT, before
 			 * that, insn->off and insn->imm should be restored to their original
-- 
2.43.0

