Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666401AC45D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372413; cv=none; b=Cn/W5RyoXjD6rLDRQYH0wPJiDYF5CtqABG2DLPBedboBwJEx6wlZLgB364aiiVZAk1KtzUDdjZ+bpiDXXa0pw/RcpLhnFt0nl0LI+40tUniex0HavWkTTBQTTPlomYmWhHwejlnTkKSZAisgTaZ0nZdBVw7TSiEkMmIjtU+SLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372413; c=relaxed/simple;
	bh=bntzwVkgy1XhsUFl9A5E8NeNdZ0t1iQs6Enbsh3fKeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKkWLii1bXu6Sm+VycN4JFeGKq0JlohmizF5YSvotWA0j9trdkQHzyTKI6Ku6+ws8GsLmDwz3grbwAHFXMl9e3V8M3R2zepxHzm+peZwQono90r3yyBJiCZ7LWusi7O5i3z+/8Bvp97sF8mBKVrYUZDMwRJUHb60ThV+IHYkMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3+YTjOe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3+YTjOe"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89f639ba307so494820b3a.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792372412; x=1792977212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0Sxuxs0EeUMgUZwauh7fkGLGVHI/Gd5mDOOEksG0cA=;
        b=Y3+YTjOe2L9CF8ITBVfOOxppI1iBSbYTB1ZE+ILSHPL1Z3NabtLO8sHS7lgdSmX9K4
         rBp38UI4GUDwUDg2UF1UPxaW3dcTcivL3Vaxj33fzG3mfYtn9jUNwYHDWoAf9xlX4wgJ
         rA1SmivA/i0W3V2qjjdrMHlu1NgK9WqJm4kR9/EswzdhjWLUyx5RC11hO/oTwLbGbNn8
         NwK73Yza/KgjArmIYOur0HDbkXKhUQn1iFQUfhNkh1WdSf3mPgOY5jRSVkrTXlCg7an4
         yHAZtMIuVltX2slIPJsRUxb40MpkzrVo6xHg1MjtGsQpwQHvxxRL5eYf4Fk/HaDeUlxE
         zwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372412; x=1792977212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0Sxuxs0EeUMgUZwauh7fkGLGVHI/Gd5mDOOEksG0cA=;
        b=nl1AVMg5mhsSz1nzfM8hYZKIPG02HMIW8MKJArcFq6so8niBqf2I6V+hUFm3Tmd04R
         uKwDHZ8G59LOe03xWxUqBvFDNm/f+CF2lCwQxwSu9cB0hfWn3AVLyB3Gh13FQVAu09PD
         R4e2YfTWD9UWSNu8WJxBCzkC7gwZS52cO46GAfFPP0mE5YPdgReg29D1aWOR/GE8Thsk
         ZBXlDnG9CS74aKkog+D+kqjYxht4hUrfiPFQeo8HuliTP5Db2Eha+NaKcctzFuKM4/S1
         4EUpc7VFDNO1bCBF8QmCMa0wr5peMQebr70nI1L5AdMu9apJ3U/fnn2UgscuzT/3b2nQ
         W+HA==
X-Gm-Message-State: AFq9FYIVF9eFnV33dD72LuNCTsE4j50u9+FLvjxdYmZ/12+UmuIf6t05
	RwO2jP+e8eYto0h3uyznKjjJVtq5UGxycT+pZGpbgfGDD+38uJ91lksQDZKxKw==
X-Gm-Gg: AYBFou3K+jws3+pOsmZ9JKw+HwV4ZiQzcFRV+3VQewgvxFmLc1zN7sRUFRWDE7YrzIC
	QsNv2Jx3I93Z5DOYSVQuOhg2/dWxLIp+i4GccW2jDzHtQZTODep+rTtYxryx6xfqhJYyyx0F5Rj
	QgaoeCGlqhRrLfXAH5DnDHuaZMCKxKe0lgaticQbIdOKx1PJRWbKUrQ45wBzF2juWHrJhqOnlGr
	6WheWZXLGauuiZYE4uOMvLWYkpaVB0UmN3u/B+pObED4PVrLJdf48A7sj93kr1ad6Ogq6XEz6L0
	deQxpt0/i804G9TRYa2qJIYc8OhP/5Az3m0nUL6DWx+3s+Lx5j/cEVDC+oJ4y1wxJy9WSFYuwtm
	Sy2W8I5TupH6yoYbUv5Vy5rFMfNCe84PNSr2Bx8irxcKT9FvBmbO/uOIwHrOhyOlRqvnW7lL/xK
	Wj4lY+c5eJWGrWpHI46/bvztk9nqUWIi0U/pyBy4VJ5qYlgqs7vCmTpuAISdvNK+ox79Y1r4rrT
	PhUqE7QE+n5j6yfD5715NRbch/SM6fQvr6oGd9u5whN2YkcUd9quOBFVxgBya20KiA6bhbWQcHg
	TcZjg43xwDN4R7M6VSjuawobltqh38TFKw+lsVWwtwY=
X-Received: by 2002:a05:6a00:17a9:b0:89f:4cd9:241a with SMTP id d2e1a72fcca58-8a04c43806emr4715638b3a.41.1792372411409;
        Sun, 18 Oct 2026 18:13:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fd010b47fsm2888435b3a.31.2026.10.18.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:13:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2] bpf: Refuse the prologue for an extension if callers keep packet pointers
Date: Mon, 19 Oct 2026 01:13:27 +0000
Message-ID: <20261019011328.1843764-1-alexei.starovoitov@gmail.com>
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

Functions can share a type id in func_info.  The first of them is the one
that is replaced, so look it up in one place.

Fixes: 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
v1 -> v2:
- Two functions with one type id got past the check: it took any of them,
  while the first one is replaced.  Same use-after-free, reproduced.
  bpf_check_attach_target() and bpf_check_ext_prologue() share the lookup
  now (sashiko, bpf-ci).

v1: https://lore.kernel.org/bpf/20261018012753.1724147-1-alexei.starovoitov@gmail.com/

 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/fixups.c          |  6 ++++
 kernel/bpf/verifier.c        | 67 ++++++++++++++++++++++++++++++++----
 4 files changed, 71 insertions(+), 6 deletions(-)

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
index 63fff641d985..1444be95f577 100644
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
@@ -22209,6 +22230,41 @@ static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *
 	return -EINVAL;
 }
 
+/* Functions may share a type id. The first of them is attached to. */
+static int find_tgt_subprog(const struct bpf_prog *tgt_prog, u32 btf_id)
+{
+	const struct bpf_prog_aux *aux = tgt_prog->aux;
+	int i;
+
+	for (i = 0; i < aux->func_info_cnt; i++)
+		if (aux->func_info[i].type_id == btf_id)
+			return i;
+
+	return -1;
+}
+
+/*
+ * The prologue of an extension gives a cloned skb a new head, unless the
+ * prologue of the target program has done that. The callers of the function
+ * that it replaces must not hold on to the old head.
+ */
+int bpf_check_ext_prologue(struct bpf_verifier_log *log,
+			   const struct bpf_prog *tgt_prog, u32 btf_id)
+{
+	const struct bpf_prog_aux *aux = tgt_prog->aux;
+	int subprog = find_tgt_subprog(tgt_prog, btf_id);
+
+	if (aux->has_prologue)
+		return 0;
+
+	if (subprog >= 0 && !aux->func_info_aux[subprog].called_with_pkt_ptrs)
+		return 0;
+
+	bpf_log(log,
+		"Extension writing packet data cannot replace a function whose callers keep packet pointers\n");
+	return -EINVAL;
+}
+
 /*
  * An extension is verified as a program that runs under the RCU read lock. Does
  * the function that it is to replace?
@@ -22235,7 +22291,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	char trace_symbol[KSYM_SYMBOL_LEN];
 	const char prefix[] = "btf_trace_";
 	struct bpf_raw_event_map *btp;
-	int ret = 0, subprog = -1, i;
+	int ret = 0, subprog = -1;
 	const struct btf_type *t;
 	bool conservative = true;
 	const char *tname, *fname;
@@ -22274,11 +22330,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < aux->func_info_cnt; i++)
-			if (aux->func_info[i].type_id == btf_id) {
-				subprog = i;
-				break;
-			}
+		subprog = find_tgt_subprog(tgt_prog, btf_id);
 		if (subprog == -1) {
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
@@ -22333,6 +22385,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
 			}
+			if (prog->aux->has_prologue &&
+			    bpf_check_ext_prologue(log, tgt_prog, btf_id))
+				return -EINVAL;
 
 			tgt_might_sleep = aux->func
 					  ? aux->func[subprog]->aux->might_sleep
-- 
2.55.0

