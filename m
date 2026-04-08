Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAE3B9DBC
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662646; cv=none; b=J52OUQCohTrvTJoheA4rYZe7qQSgOz+v4LSZdjDDoA2wtI4cxW81I78fwIkcUERbwL2gF4uYYhO4QbeX2PgdZxXWoggQTTMpJmFY5OW5F7q9GcEy2r8YLGdt2AowIEQOSvQG7z2zOZ0w1v0CENpRZxxAJQW61XkxofEmiKo6o/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662646; c=relaxed/simple;
	bh=DbcY/M33XA30O6tkP6IUa/a9LSBeneUlaEJhAF0PYLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQQM7wB9YMBHM0/bXN3Uu1eI8dsOfCzlyqZgyvgGJt+AVtQ0iOh8CsMDWPE0JIfAbLzY4TyT4qkVKIdxbv9Jgt8ELlte/vrvWtpGByFws+fBFa0Cv7w1lNQd6Z7ilk98fXlnrTLiWi9/oG3oRsByR0LBXQPQG8Zgbj5F1AIkPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NiSscpDx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NiSscpDx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1XiYXCoIpOHN20aQmrm4hQW/6aOLwtCy6TP3Stb3DRA=; b=NiSscpDx1RF01GQrD2BRxh+/bW
	SQm4OCugH/KTIj8rnmaAtmQZlb2nlSfCIM0jyv+jXlEwS/8Si86QYJP3c29nExGBu6U6zTtI/Tovs
	U38ytua9HQNaf39XnSSjCYutmcnK4VkWINX53MqDtlSlCbKaMiKiS0UToMOWUcI749Fi21HaOw5Xv
	57juY2oXbCkXAmVDART8nnws1Il6o3Azq315Lanym4OP4PhZ8bXpldrFCmVfnBYf12pOTy5QdrbpQ
	bxfOux9X1s6tSycjDOVHT7XsOyugRMDJO3A76RriGR5tM0VxexAsdelKvBwclmMQvQlg5KzZJySt9
	MhDDyVKA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAUxu-000LUu-0o;
	Wed, 08 Apr 2026 17:37:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 2/4] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Wed,  8 Apr 2026 17:37:10 +0200
Message-ID: <20260408153712.523124-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408153712.523124-1-daniel@iogearbox.net>
References: <20260408153712.523124-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

Usage of ld_{abs,ind} instructions got extended into subprogs some time
ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). These
are only allowed in subprograms when the latter are BTF annotated and
have scalar return types.

The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=0 +
exit) from legacy cBPF times. While the enforcement is on scalar return
types, the verifier must also simulate the path of abnormal exit if the
packet data load via ld_{abs,ind} failed.

This is currently not the case. Fix it by having the verifier simulate
both success and failure paths, and extend it in similar ways as we do
for tail calls. The success path (r0=unknown, continue to next insn) is
pushed onto stack for later validation and the r0=0 and return to the
caller is done on the fall-through side.

Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db009d509ade..46f55ea6684e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18357,6 +18357,22 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	mark_reg_unknown(env, regs, BPF_REG_0);
 	/* ld_abs load up to 32-bit skb data. */
 	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
+	/*
+	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
+	 * which must be explored by the verifier when in a subprog.
+	 */
+	if (env->cur_state->curframe) {
+		struct bpf_verifier_state *branch;
+
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (IS_ERR(branch))
+			return PTR_ERR(branch);
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		err = prepare_func_exit(env, &env->insn_idx);
+		if (err)
+			return err;
+		env->insn_idx--;
+	}
 	return 0;
 }
 
@@ -19276,7 +19292,12 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
 }
 
-static int visit_tailcall_insn(struct bpf_verifier_env *env, int t)
+/*
+ * Instructions that can abnormally return from a subprog (tail_call
+ * upon success, ld_{abs,ind} upon load failure) have a hidden exit
+ * that the verifier must account for.
+ */
+static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 {
 	static struct bpf_subprog_info *subprog;
 	struct bpf_iarray *jt;
@@ -19311,6 +19332,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) != BPF_JMP &&
 	    BPF_CLASS(insn->code) != BPF_JMP32) {
+		if (BPF_CLASS(insn->code) == BPF_LD &&
+		    (BPF_MODE(insn->code) == BPF_ABS ||
+		     BPF_MODE(insn->code) == BPF_IND)) {
+			ret = visit_abnormal_return_insn(env, t);
+			if (ret)
+				return ret;
+		}
 		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
 		return push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	}
@@ -19356,7 +19384,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			if (bpf_helper_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
 			if (insn->imm == BPF_FUNC_tail_call) {
-				ret = visit_tailcall_insn(env, t);
+				ret = visit_abnormal_return_insn(env, t);
 				if (ret)
 					return ret;
 			}
-- 
2.43.0

