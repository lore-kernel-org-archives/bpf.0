Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64833B27F9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424720; cv=none; b=bjK5e8oNDTI9YdtEnL6y3MnuZkcsq8Gn7phrTJ6eOcNoYcAGtlWhY0eCYEAQzFQLA+JGDC66qtMIUbkY5mNUPPX0OTp6UVqykVbs0f6xNtKe+netBN34smWhGqoaAt382vDahP8pJxSWURl/HOB+VFYEjTItp8xYKKgF3FIXzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424720; c=relaxed/simple;
	bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2xSQ9PiCsoprq6fNk8PFEWGBuvmDy29B/95w1v34HKBxwCuH89czlQaaNcr3fyBTS9BLqH8cddE5TvdSP7HcgBrevbzyhZMD53hQ7nBRNhpCGnNwtSdIp1soaHUTw4iQVEfJ0QsEMLVUDSE977CdyOianCCLaQsRUwZhWuOf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb0/zPGr; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb0/zPGr"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso15779375e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424717; x=1790029517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=nb0/zPGrj17WELRnS466HxiuyyB+1B9xXCTpLQQJvejXJ8ynkXie2SxAosmRa9VnxX
         PAqaVPcn3ODYr2aRMJIZsU8EDYaMtbuvtPKeAsies3/Zj+bIrIKiFIsRMtdvFdZR0d8R
         g3xkjRLcbGl+8YVWYxdkUhTUCRDxLc4TwdFnh/jrn1GjMpXstHnR3/2NGsIJc6fbUfbs
         oYcjXLKW2xM9V51Wj2FrAbsuHst+Xpc79FcYK8cBAcw5Kxeh/H2Z2z055EDgQpoJlmPD
         pxb7261Iyna6yuaBon0/HCrYoN86U3F0yRaHemCgWfr/bVdzzK4S7KC9suu5ZyQmtAO3
         FgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424717; x=1790029517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=cJJ0W9BVXJoW2tpMKe9Ms+wRGpTlKb33vxcW3R922b3fCRCETMCTOItRPEcPQ37BIv
         oezA5czp1BpD5zEuNJe9P2tJL77qd/xkvi2h7TmULUWS3HU6oxkZOP2uPe/YgBLgsjEn
         bxVhTRHY1XHMIxdisyw2agilykpi0xhIT7hh/ljJ8EaGErsqS/ZsIowCC1dWoUohqWoq
         rAVPsH/5Hb35FDwJ3ehhHBMWZnPlgKFEDiomqLvIIU4EEu4HwG/HwQ3+rCmsJYiPxGRp
         hB7rCEBBqeuv6WjpBfm8JW9xq98tqOrPl2E2R60NRWX0Gq0JqDoPe9WuHIAziaSXD2pw
         7h/Q==
X-Gm-Message-State: AFuF++mhR45DUpPDLPE+hsXvBK8KGSS1oSuije3TVhuSa1YreMx80UHy
	GkN6U0r3f/mOpdcCQx64YrVbTniTGFydzqha+bYgvNYECiTnetyjAfkXCEIVR/fdWaE=
X-Gm-Gg: AYBFou2T28OYk1PW0SLq9iNwEEch7s9wa4QiDCyL7HUgu555/1T4NZpKq0RP/F8Ci0V
	Ev+bmjctP7Nz2uInd9Dgv31v8CfndsssjoIeDuQ38OoShj+hmfBKZ+nLYVK0ao0nknattnfBp3V
	A0zdEE8f2VJu9Qj8DT+WJXmlAeFXjH+dDOPNFqkYgCBUV33thmAsdXLRVoiBwyfnmaKwopql6WL
	YeTENEnHbZlyfxnVhZeAM7l3HUHyqeHtiHI2hTdu5XM6NpVtV8cC7g3FrHlg5LrmH8b94aB+2bZ
	F8yx1VZ3r9gVEq3QXJubE7KsFtJFLPhpHIE7AZMThBKR9rPo4o6jKpONxQ00IrgElTrTr8j+fgV
	NelPd/68YjFB6J2yGnKLwsPAjXwfES9suySp2N8ANNv20E1Oxg1Fgar6bt69dDLa17jaox1V1dy
	N0DFRhOGwuo0F5nu2ImSu+LnogtIpBdasvHrpTMcdkB/zPx6hewoJ41NKFAAlKVs2isVaRjVJfp
	nkBcOUC41nYGmc5W2fSUKD7Sl7fMZZsoc11iDP/4UnGmRUdioi02KJNeBqk0lmbl6HURGZG5PjF
	tRRjiVKeL0QopmlCNTx6k8sTGIxLYXsNbVqoPg==
X-Received: by 2002:a05:600c:3107:b0:49d:797:8488 with SMTP id 5b1f17b1804b1-49e7a662ecdmr57693885e9.1.1789424716906;
        Mon, 14 Sep 2026 15:25:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef88754sm10380315e9.13.2026.09.14.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 01/11] bpf: Make post-verification instruction rewrites killable
Date: Tue, 15 Sep 2026 00:24:58 +0200
Message-ID: <20260914222514.1635018-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727; i=memxor@gmail.com; h=from:subject; bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFiU6EipR5Ye+rYEm/DzoLa0/z873YP8dh5b1ILmNNr y8KdXEdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIjxY0aGv7OW+leeP8TIMd2G /eIN0zzGVx7X+t/cuibMoBS695/aU0aGtX5K1TentLKFv7yk4rS18M68BZcW3rae8tPw6nkFxRw nVgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

After do_check() returns, the verifier runs several instruction rewrite
passes. Some of them patch or remove one instruction at a time. Each
operation moves the remaining instruction and auxiliary-data arrays and
adjusts all branch offsets, making the overall work quadratic in the
program length.

A privileged loader can submit 131072 unconditional jumps by zero followed
by a valid return. Verification finishes quickly, but bpf_opt_remove_nops()
then spends a long time removing each jump separately. Since this
post-verification work neither checks for signals nor reschedules, a pending
SIGKILL cannot terminate the task until the rewrite finishes.

Make bpf_patch_insn_data() and verifier_remove_insns() common cancellation
and rescheduling points. These helpers run from BPF_PROG_LOAD process
context, and bpf_patch_insn_data() can already sleep while reallocating
auxiliary data.

Report interrupted constant blinding as -EINTR and propagate it through
both JIT paths, including kernels that permit interpreter fallback.
Other blinding failures retain the existing fallback behavior.

This does not reduce the quadratic cost of the rewrite passes, but it makes
the work preemptible and allows a killed loader to be torn down promptly.

Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c   | 21 +++++++++++++++++----
 kernel/bpf/fixups.c | 24 ++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b294dfc1ad4..2e3bf8113ae9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -19,6 +19,7 @@
 
 #include <uapi/linux/btf.h>
 #include <linux/filter.h>
+#include <linux/sched/signal.h>
 #include <linux/skbuff.h>
 #include <linux/static_call.h>
 #include <linux/vmalloc.h>
@@ -1619,6 +1620,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 			 * fix it up here on error.
 			 */
 			bpf_jit_prog_release_other(prog, clone);
+			if (env && fatal_signal_pending(current))
+				return ERR_PTR(-EINTR);
 			return IS_ERR(tmp) ? tmp : ERR_PTR(-ENOMEM);
 		}
 
@@ -2636,11 +2639,14 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	orig_prog = prog;
 	prog = bpf_jit_blind_constants(env, prog);
 	/*
-	 * If blinding was requested and we failed during blinding, we must fall
-	 * back to the interpreter.
+	 * Fall back to the interpreter after blinding failures, except when
+	 * the loader was killed.
 	 */
-	if (IS_ERR(prog))
+	if (IS_ERR(prog)) {
+		if (PTR_ERR(prog) == -EINTR)
+			return prog;
 		goto out_restore;
+	}
 
 	prog = bpf_int_jit_compile(env, prog);
 	if (prog->jited) {
@@ -2659,6 +2665,8 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
 					   int *err)
 {
+	struct bpf_prog *jit_prog;
+
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
@@ -2681,7 +2689,12 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(env, fp);
+		jit_prog = bpf_prog_jit_compile(env, fp);
+		if (IS_ERR(jit_prog)) {
+			*err = PTR_ERR(jit_prog);
+			return fp;
+		}
+		fp = jit_prog;
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 52d3cec33672..d6f83521fc78 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -8,6 +8,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/perf_event.h>
+#include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
 
@@ -306,12 +307,28 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
+/*
+ * Some post-verification instruction rewriting passes require an
+ * O(prog->len) operation per instruction. Keep their shared primitives
+ * killable and preemptible.
+ */
+static bool bpf_rewrite_must_abort(void)
+{
+	if (fatal_signal_pending(current))
+		return true;
+	cond_resched();
+	return false;
+}
+
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
 
+	if (bpf_rewrite_must_abort())
+		return NULL;
+
 	if (len > 1) {
 		new_data = vrealloc(env->insn_aux_data,
 				    array_size(env->prog->len + len - 1,
@@ -523,6 +540,9 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	unsigned int orig_prog_len = env->prog->len;
 	int err;
 
+	if (bpf_rewrite_must_abort())
+		return -EINTR;
+
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
@@ -1356,7 +1376,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 		}
 		prog = bpf_jit_blind_constants(env, prog);
 		if (IS_ERR(prog)) {
-			err = -ENOMEM;
+			err = PTR_ERR(prog);
 			prog = orig_prog;
 			goto out_restore;
 		}
@@ -1433,7 +1453,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 		err = bpf_jit_subprogs(env);
 		if (err == 0)
 			return 0;
-		if (err == -EFAULT)
+		if (err == -EFAULT || err == -EINTR)
 			return err;
 	}
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-- 
2.53.0

