Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583044;
	b=pNUkTj74DpLzaJaIM8oLIDLCG9ucR7Ez/f7bYYtTH/EWDWR1ZP6z5wv9eGc+VVu4q7G1
	 Qeu9iXiUHfQXTbHWVMTzL+TkAjAj2TJVMAyp4fISvrNH9DaGai8DqGa0XL6tIGVpKkfmy
	 /7pfXnxBD44Fp2CkwVRGbzUA19ern/StuWi/F2J8F5LTy+5VoDKqIalHzHGt30t5fWzPP
	 uJVoCB5sr62Iap+oD7IvOjd9OR9rnrFORX/vuoB21MVy6snSBVpSv2XZXfTGN2YaqjyoX
	 0Nm0i/QFsIXdxDNLYUGt+ISUxZefe79MoUTa3OydBUDNrPm1jsN7AJq1w/+OUJ0/zqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KC/HCcFS5IQQUBpFhATlFwo684x5oGNBFghhO8GcBq4=;
	b=2uE+9lXZN0rdGhIAmH1rM3/VwbbXHV9Tcg0qKPlaIjoBbNNrq89psm0+MWI7NAPieVZ0
	 nT3Du6xwfmOGblfK9pS0p65FOsinoo8ii0oBY56PIeFR2iYFvi4gtxyCl+ZQb7KJXYumM
	 nKba19lR632EjphTUZbSv3LZ02XdOqV6XRYlJm8RBvVp1jaQmwEdIoX7kH6xOMPNVPz37
	 5/knHuDhEmnEHabmdqNhRlPIbuQqRsB7UjtGMbeVjIsRdjVUQvcM/mk9Fh5P/CxwWzo0j
	 G5c+wi/YG7EriVrTPciHvgqBj83CRysJpsHmfs8sLGWoZGP1qWPl3JGZW2d3/NijlfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Lgc/CfMZ";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E29606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lgc/CfMZ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9f6a16aedso14740395ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583043; x=1794187843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KC/HCcFS5IQQUBpFhATlFwo684x5oGNBFghhO8GcBq4=;
        b=Lgc/CfMZ0scRj+f795kP0CXEC8bdqDIQPDZgkHhiVpXDLUvs5we7qxs0om7NWvMd23
         LA5uSewSDs5LT83r4p2PceOxLRXHyJl79+g/fAGyKoDLrRmp/0H3bEoxHZ+aWDxdIdvI
         5Fng+3c0RHpu2sNEsbMJxd5LLzrJskK0MPkLjMihkV5lZah2D1x42gKVobhN5nYtad9w
         wdF3WcHDJ6hTxWqyP5kUHFlWQ6JEc3TPYCMK6WtOCfERRfn045vtiiOMhHjKdbYWI5g5
         pqj3dGgo7pnL+0zQOl4QYE1aFCypFTVwLfTxoJXefvtA7GUmllUIQcRIj99XjylBkXjz
         5L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583043; x=1794187843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KC/HCcFS5IQQUBpFhATlFwo684x5oGNBFghhO8GcBq4=;
        b=NJaJo9Qog5WistG19rG1OUlGr9RI7iuizr2qWG1ycxroB9afBAGclBu+jon99FIoC0
         IwPa69p03qq+BFQTwZcpdmrFIHgenQSZGqHwH5BV19HkcDPdOLjhovbQzhYEv5IcKL5j
         RnCQClGz91p1PARF8eW7ush/8g1ynv6IClJe+sw7WdNwamr3+OGPnDGvUAGPMZ7DYprQ
         j/eGwEM+H4HFmDv5vcsKx+8oOk2T3SVYdLvfsLDpEOejKQiG69Acl6hZha/Ii5RsYBHY
         lQIVgdGIDaz8mOqBHGglgUg78e4kkd6Qty8n5CVlBP94Fc4ofC/CLhBywa28rWZmcPgx
         Br2A==
X-Gm-Message-State: APuU4Z+SjvMTDWfdZ858Jze6SB11N8X6xHPyWM8fiOzLXsbdjTzhe8ek
	MVYYyGOZpWA328Uy5IQjCy6Sxp81vzAHQ5i8hKmvUx3YRtvjnVx93iDmc6CljA==
X-Gm-Gg: AYBFou0Zh59SISQGvpIiBS8lcRhrcv9dVbbWUzciFQZ9QAhvd+ZgEOMmwbT9ji6MK7V
	vDaWdbK4E9bNFkMF9PwBz7RlhKkY1Mf7+UecSLJzJgXJMkczH1tYjeaQBErTHWDaNoCoSHA75ZO
	L+3TKbJiClO4ZeqGNX/PQdN1tWSaFrgB31ALsV6r1b7cM0XiVHR0iyhtiUlb4pmKzaENgbpKOyV
	vnm2GwtKDaaCifIR5aCaju1AQz0r+B0Qy26yz4lVLmwbWmHza9xTd1+2OPJVxBo0BLP4m8ZxfAg
	tx9ZAqRZz2AHE8ofSiehcynwj7Uq9g4ku6X7/x5GpsMP2fiQS18g98+j2nJmE9wSG7LRHAzvCJW
	7hxpy2kSVDHG9T2HWyLI/Drp3b8y1A24zBKgIWSdBgKXs07fzFlqzxVejF4OHsc9PQtYJ6FNeZy
	+aKsvK4z3iWUa5bBuUPBVvbbSkYDehpTr07bngkSw/giViZcKZcuyh8rqIn9BbqwZVQ0d/DcfG+
	+r0vcYIWNNRh2evH/IbjCXCYPVP0gi2dScxagCI6AUyiTIpN0vwQIYPh17/aUV5UzPd6tTgvquK
	MXs/fcpWdlUaHvPNBA++POdH1IFpY4zCKIDyOgM9KhUHkEX2KBiT+/dXi+F7KBHlYdPGPnDWlxf
	1MVe+uij8HKiPawhwazx0b79hyii2mMR9+wqGijivKhRMaKNxf4MgHu96wwt/XZGW/62wAPZqig
	==
X-Received: by 2002:a17:903:228b:b0:2e8:3190:73a with SMTP id d9443c01a7336-2eb364892f4mr85277735ad.58.1793583043130;
        Sun, 01 Nov 2026 17:30:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ebesm19980625ad.9.2026.11.01.17.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 10/13] bpf: Blind constants through the patch list
Date: Mon,  2 Nov 2026 01:29:37 +0000
Message-ID: <20261102012940.1756142-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
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

From: Qiliang Yuan <odys.yuan@gmail.com>

When bpf_jit_harden is on, the constants of a prog must not be in the JITed
code. bpf_jit_blind_constants() replaces each insn that has a constant with
3 or 4 insns that calculate it. It patches each of these insns immediately,
with bpf_patch_insn_data() or bpf_patch_insn_single(). Each call costs O(N)
in a prog of N insns.

One prog of test_verifier has a million insns:
"ld_dw: xor semi-random 64 bit imms, test 5". With bpf_jit_harden=2 it does
not load in 15 minutes.

Queue the patches in the patch list, and commit one time at the end of the
pass. bpf_patch_list_commit() needs bpf_verifier_env (env). But the pass
also runs without env, for example for classic BPF progs. Add
bpf_patch_list_apply(), the commit without env. In that case the list is a
local variable of the pass.

  step               bpf_patch_list_commit()       bpf_patch_list_apply()
  -----------------  ----------------------------  ----------------------
  all that can fail  new image, aux data, prog     new image, prog
  removed insns      offload device, aux data      WARN, -EINVAL
  the tables         of the verifier, of the prog  of the prog
  the new image      insns, prog->len              insns, prog->len

 - No pass without env removes insns. Thus bpf_patch_list_apply() rejects a
   list that has a removal.
 - bpf_jit_blind_insn() does not change. It writes a jump as if its patch
   was the only one, and that is the rule of the list.
 - The reallocation of the prog is the last thing that can fail. Thus an
   error leaves 'clone' valid, and the pass can free it.
 - With env, a jump that gets out of range gives -ERANGE, and the message
   names the jump. Before this patch the pass returns -ENOMEM, and the
   message names the patched insn.
 - core.c is also built without the verifier, when CONFIG_BPF_SYSCALL is
   off. Add stubs for the functions of the verifier that the pass calls.

Load times with bpf_jit_harden=2 in an x86_64 VM with 8 vCPUs, before and
after this patch. Wall time of 'veristat -q <obj>', mean of 10 runs, and
one run of test 5:

              before        after
  pyperf180   1.222 s       0.087 s
  pyperf600   3.538 s       0.222 s
  test 5      > 900 s       1.5 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  17 ++++++
 kernel/bpf/core.c            | 103 +++++++++++++++++++++++------------
 2 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f8498de5eff5..65313a26abb2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2081,10 +2081,27 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
+#ifdef CONFIG_BPF_SYSCALL
 struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len);
 int bpf_patch_list_commit(struct bpf_verifier_env *env);
 void bpf_patch_list_free(struct bpf_verifier_env *env);
+#else
+static inline struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
+						  const struct bpf_insn *patch, u32 len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int bpf_patch_list_commit(struct bpf_verifier_env *env)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bpf_patch_list_free(struct bpf_verifier_env *env)
+{
+}
+#endif
 int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
 int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
 			  const struct bpf_insn *insns, u32 cnt);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2deb5584dc85..b9d9d0de5b92 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1963,17 +1963,48 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	bpf_prog_clone_free(fp_other);
 }
 
+/*
+ * Apply the patches queued for 'prog' without a verifier env, which can't
+ * remove insns. Return the patched program, which may have moved.
+ */
+static struct bpf_prog *bpf_patch_list_apply(struct bpf_prog *prog, struct bpf_patch_list *pl)
+{
+	struct bpf_patch_image img;
+	struct bpf_prog *new;
+	int err;
+
+	if (!pl->cnt)
+		return prog;
+
+	err = bpf_patch_list_build(pl, prog, &img);
+	if (!err && WARN_ON_ONCE(img.del))
+		err = -EINVAL;
+	if (!err) {
+		new = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
+		if (new) {
+			prog = new;
+			bpf_patch_image_install(prog, &img);
+		} else {
+			err = -ENOMEM;
+		}
+	}
+
+	bpf_patch_image_free(&img);
+	bpf_patch_list_release(pl);
+	return err ? ERR_PTR(err) : prog;
+}
+
 /*
  * Now this function is used only to blind the main prog and must be invoked only when
  * bpf_prog_need_blind() returns true.
  */
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
-	struct bpf_insn insn_buff[16], aux[2];
+	struct bpf_insn insn_buff[16], aux[2], *last;
+	struct bpf_patch_list pl = {};
 	struct bpf_prog *clone, *tmp;
-	int insn_delta, insn_cnt;
 	struct bpf_insn *insn;
-	int i, rewritten;
+	int i, insn_cnt, rewritten, err = 0;
 
 	if (WARN_ON_ONCE(env && env->prog != prog))
 		return ERR_PTR(-EINVAL);
@@ -1982,7 +2013,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 	if (!clone)
 		return ERR_PTR(-ENOMEM);
 
-	/* make sure bpf_patch_insn_data() patches the correct prog */
+	/* make sure the patches go to the clone */
 	if (env)
 		env->prog = clone;
 
@@ -2013,41 +2044,45 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 		if (!rewritten)
 			continue;
 
-		if (rewritten < 0)
-			tmp = ERR_PTR(rewritten);
-		else if (env)
-			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten);
-		else
-			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
-
-		if (IS_ERR_OR_NULL(tmp)) {
-			if (env)
-				/* restore the original prog */
-				env->prog = prog;
-			/* Patching may have repointed aux->prog during
-			 * realloc from the original one, so we need to
-			 * fix it up here on error.
-			 */
-			bpf_jit_prog_release_other(prog, clone);
-			if (env && fatal_signal_pending(current))
-				return ERR_PTR(-EINTR);
-			return IS_ERR(tmp) ? tmp : ERR_PTR(-ENOMEM);
+		if (rewritten < 0) {
+			err = rewritten;
+			break;
 		}
+		last = env ? bpf_patch_list_add(env, i, insn_buff, rewritten) :
+			     __bpf_patch_list_add(&pl, clone, i, insn_buff, rewritten);
+		if (IS_ERR(last)) {
+			err = PTR_ERR(last);
+			break;
+		}
+	}
 
-		clone = tmp;
-		insn_delta = rewritten - 1;
-
-		if (env)
-			env->prog = clone;
+	if (!err && env) {
+		err = bpf_patch_list_commit(env);
+		tmp = env->prog;
+	} else if (!err) {
+		tmp = bpf_patch_list_apply(clone, &pl);
+		err = PTR_ERR_OR_ZERO(tmp);
+	}
 
-		/* Walk new program and skip insns we just inserted. */
-		insn = clone->insnsi + i + insn_delta;
-		insn_cnt += insn_delta;
-		i        += insn_delta;
+	if (err) {
+		if (env) {
+			bpf_patch_list_free(env);
+			/* restore the original prog */
+			env->prog = prog;
+		}
+		bpf_patch_list_release(&pl);
+		/*
+		 * The clone is reallocated when nothing else can fail, so
+		 * 'clone' is still valid.
+		 */
+		bpf_jit_prog_release_other(prog, clone);
+		if (env && fatal_signal_pending(current))
+			return ERR_PTR(-EINTR);
+		return ERR_PTR(err);
 	}
 
-	clone->blinded = 1;
-	return clone;
+	tmp->blinded = 1;
+	return tmp;
 }
 
 bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
-- 
2.55.0

