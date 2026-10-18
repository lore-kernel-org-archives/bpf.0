Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155145038
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286878; cv=none; b=mbsHl1LfeNrIpiX/CVkjm76C3USWQNEDXFlGuMlGYfxp9gfmrPXsjABZOShECR69/CwD1gp6N9Eux+FhtLmVZWQFWezuFdABj/QP3MYXXc+PuvdKd8W57YN3t7N2KoZ1Hiwqwc+4MbmnzG+EZHaFl7tbUR4SOJgT4oQ2sQ0s+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286878; c=relaxed/simple;
	bh=tkiOfmdHr5kOq2uXuo3m+6KWjyP5EOQs/3JbmkdgetI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srkaIiYMOtBwB4dFQzINmXMJ45BHUJjVD3K8hQXpaC6ALwlxhEtKsgDpaaiDHZQDns+adOzrwW6KxK4r5I72+bDIzYBodZxRz0eVu3gb5NzDHhvIJqTFCEJ18dvzCX/NjrU4hA6KwiI0I6X0RnjZyp4WADrRg2VAmikMZYujJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOUWEUai; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOUWEUai"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso884988a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792286876; x=1792891676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=snwUkhPLrHgz2APuZstMsya2Ffy3a5Mctprzb96QwMc=;
        b=FOUWEUaidXzHJjZiMzCU15/oVo7YaJHrLYWUw0c0aaZqzxk+6s9qQ2/4vTDlCXHbdJ
         BOp5Y7/1hB2/dFgzOIDMLFBwgQ1ntJfbd6jLOjnd6gjasGbPBzV7HQWnAoPv5tYMYU9o
         Q+TD2fscIjvVGMLY0rpI9aPqUIOMn5Nqh+9wOSQBlCX/XHPa/SlWTmfrHja9eeRCTz+X
         Kn3PUlU05QN9QlmCFXD7WAWdY2uZVGI+NkkyfzjVPf+Hdk3qb5s0cueiJioAZW2v4vjM
         h/gqPa9RHqGCP+1ywnRuujaFtp4nItSgJzQadT/GVkZKQIThHDQk2yB6sy+KNBDaxvtg
         rTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792286876; x=1792891676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snwUkhPLrHgz2APuZstMsya2Ffy3a5Mctprzb96QwMc=;
        b=aUgn03j2Ckv5zx4mSlg01TGvenyE7XquxLdbtZPu2QjzFhz3+DAdpnLh9ItRRYSyTW
         4G7tHTahZRrmPt9z4rxMuxFttDeToZwgpseELCANMVElmyHgDHxJ4pr7cjpFetQn1cIp
         mfDG6LrzaScAMhRxRFKzJX/SzCAtFY2djf0UYx8IPgKvRCQgiX76su36eNL+5QQ2WKZk
         TGTHB6r0OkK8HrWaIZHslWuMGawFjtLVSHd187bpxGJTHgp6bzft1jWrJfC0HPQtPfUt
         kRlTWj/tbkdQzu4rR2T3phYMSjM3UhOUNHWPU25DoZTEKrE4QB3qR5VPXBI07nCNAhJK
         8a1Q==
X-Gm-Message-State: AFq9FYImq2fgyGOFXmbwI9xabCYHBP9xJpyQKMpMdnui7Rsax9NIG7KO
	vEEveL4MH7BnU7/0mUMoJ8/pxpD70tLCxyI7rZwmm/vyXpK4d7XKBzmEMbQFwg==
X-Gm-Gg: AYBFou0YR1CWS2erQlM5pTIehwitLhvllihig/A1cPvI8lyODwEu0P5IY+pWGU6wOXE
	rxyq31VYEBZptzBAXxduUlpMXE6yRBEH4ULe29ZhumV+wzvCTbcCfSvCi+bem583NZxVpXeq9op
	60xP1rY3vGXycVh2hqMhMVZukeY981h4CaKhEnLhHsaIOYoDpXid2d4yRBo8oyqBCKU6LkLT71y
	bidp/JFdLOY9oh7QUmf3RSD6N1vODJtAFqWCnd4adUepeAYk+r9V0xYUXAJOsn00m0D5KyjbquQ
	0e63AfnHtM6imkW/PtGNmshzztX4vHXYqMj2kejX6V18EqGBikkbJqJTAs9I1dML2hMs2xn0+qX
	gFi9pYVSig00JndphYWjM62tDrMwIvs50b6NBzmYFq+GPUuVebefq/NYH4BBhrHTPWDei4myqB3
	dF2mj+t12M2/qfGsJVKWVYYI6dtZQxOD5I85u24NCxP+c0xrpJsre7NpntynmZB1TCz7zyaCR11
	zOZ7CqTyl1ygo4oKIeYYkIuw+r4C8bT2Iy7kHjRZT2y8bIr77IX3s5GHbPNIwre1JZLvlbdFpJ0
	j+OqqvXXOltwngTQyu6AiO/kez6kJcKDW1l39Nje4jw=
X-Received: by 2002:a17:90b:388c:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3acef1881camr3866978a91.29.1792286876230;
        Sat, 17 Oct 2026 18:27:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7311sm15051408a91.4.2026.10.17.18.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:27:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] bpf: Refuse the prologue for an extension if callers keep packet pointers
Date: Sun, 18 Oct 2026 01:27:53 +0000
Message-ID: <20261018012753.1724147-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

An extension that writes to the packet of a tc, lwt_xmit or sk_skb program
starts with bpf_unclone_prologue().  If the skb is cloned, that gives it
a new head.

It does not count as changing packet data.  changes_pkt_data goes by the
helpers and kfuncs that a program calls, and whether it gets a prologue
is known only after it has been compared with its target.  So the extension
can replace a global function that leaves the packet alone, and the callers
of that function keep their packet pointers across the call.  These point
into the old head, which is left to the other clone.  Once that is freed,
by the reader of a packet socket for example:

  BUG: KASAN: slab-use-after-free in bpf_prog_53bc21b9810cadbc_t_read+0x2e8/0x36e
  Read of size 1 at addr ffff888107bfe73c by task tt11/102
  Freed by task 112:
   kfree+0x161/0x500
   skb_release_data+0x2dc/0x340
   consume_skb+0xa6/0x1c0
   packet_recvmsg+0x4b3/0xa20

Nothing is wrong if the target program writes to the packet too: its own
prologue has uncloned the skb, and that of the extension does nothing.
Nor if the callers hold no packet pointers, like a dispatcher, or if the
main function is replaced.

Note for every global function that leaves the packet alone if it is
called while packet pointers, or slices of the dynptr of a packet, are
held.  What the callers of a global function hold is not known while it
is verified, so the functions that it calls are taken for such as well.
Refuse an extension with a prologue for such a function, unless the target
program has a prologue, both when the extension is loaded and when it
is attached to another target.

Fixes: 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/sashiko-outbox-175849@kernel.org/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/fixups.c          |  6 +++++
 kernel/bpf/verifier.c        | 48 ++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feb7de6483e3..54ae73e211f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1757,6 +1757,7 @@ struct bpf_func_info_aux {
 	bool unreliable;
 	bool called[BPF_FUNC_CTX_CNT];
 	bool verified[BPF_FUNC_CTX_CNT];
+	bool called_with_pkt_ptrs;
 };
 
 enum bpf_jit_poke_reason {
@@ -1894,6 +1895,7 @@ struct bpf_prog_aux {
 	bool jits_use_priv_stack;
 	bool priv_stack_requested;
 	bool changes_pkt_data;
+	bool has_prologue;
 	bool might_sleep;
 	bool kprobe_write_ctx;
 	struct {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7a72bb06fe56..951a90458d18 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1381,6 +1381,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *tgt_prog,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
+int bpf_check_ext_prologue(struct bpf_verifier_log *log,
+			   const struct bpf_prog *tgt_prog, u32 btf_id);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a8739fbd0349..673751b86aee 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -940,6 +940,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 					"Extension writing packet data must take ctx and scalars only\n");
 				return -EINVAL;
 			}
+			if (env->prog->type == BPF_PROG_TYPE_EXT &&
+			    bpf_check_ext_prologue(&env->log,
+						   env->prog->aux->dst_prog,
+						   env->prog->aux->attach_btf_id))
+				return -EINVAL;
+			env->prog->aux->has_prologue = true;
 			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
 							 BPF_PATCH_MOVE_TARGET);
 			if (!new_prog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63fff641d985..c31287d2231c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10867,6 +10867,20 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 	}));
 }
 
+static bool holds_pkt_pointers(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	bool ret = false;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
+			ret = true;
+	}));
+
+	return ret;
+}
+
 enum {
 	AT_PKT_END = -1,
 	BEYOND_PKT_END = -2,
@@ -11472,6 +11486,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 		clear_caller_saved_regs(env, caller->regs);
 		invalidate_outgoing_stack_args(env, cur_func(env));
+		/*
+		 * What the callers of a global function hold is not known
+		 * while it is verified.
+		 */
+		if (!env->subprog_info[subprog].changes_pkt_data &&
+		    (state->frame[0]->subprogno || holds_pkt_pointers(env)))
+			sub_aux->called_with_pkt_ptrs = true;
 
 		/*
 		 * A non-void global function returns a 64-bit SCALAR_VALUE in
@@ -22209,6 +22230,30 @@ static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *
 	return -EINVAL;
 }
 
+/*
+ * The prologue of an extension gives a cloned skb a new head, unless the
+ * prologue of the target program has done that. The callers of the function
+ * that it replaces must not hold on to the old head.
+ */
+int bpf_check_ext_prologue(struct bpf_verifier_log *log,
+			   const struct bpf_prog *tgt_prog, u32 btf_id)
+{
+	const struct bpf_prog_aux *aux = tgt_prog->aux;
+	int i;
+
+	if (aux->has_prologue)
+		return 0;
+
+	for (i = 0; i < aux->func_info_cnt; i++)
+		if (aux->func_info[i].type_id == btf_id &&
+		    !aux->func_info_aux[i].called_with_pkt_ptrs)
+			return 0;
+
+	bpf_log(log,
+		"Extension writing packet data cannot replace a function whose callers keep packet pointers\n");
+	return -EINVAL;
+}
+
 /*
  * An extension is verified as a program that runs under the RCU read lock. Does
  * the function that it is to replace?
@@ -22333,6 +22378,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
 			}
+			if (prog->aux->has_prologue &&
+			    bpf_check_ext_prologue(log, tgt_prog, btf_id))
+				return -EINVAL;
 
 			tgt_might_sleep = aux->func
 					  ? aux->func[subprog]->aux->might_sleep

base-commit: a6303535c2ad9d49598d52556183911f02287791
-- 
2.55.0

