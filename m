Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD84D599D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643511; cv=none; b=XVuAgcPuskRiaYtHToI6Ir1m6XseRopKNBvqCyN0BsGlRJZbVIyo/m03eFkMnqgjgseYnT23wWuArBeQU82A//8qPurS8d2zQQDxfLnshoc/ZTlzP2va2yAVwLSK8piIiIHHnwOBtZWPMJ7s8mqWF53bYojYRo2bqny5jvM7ANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643511; c=relaxed/simple;
	bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k95P0s+dmqRQLmgw8FMCIYZ3YyP4t5N07X8KyccHH3g0aVjsflB7i9s39x/gMkKFmZDQI7dPMznuG99kaa8tHpLPbsXbZWXzMJLfqcd6K/WGJYGoSJ6gAyfmBfcWKqbfLjlaFTyKxgtivO+QMzBn1bxqL5bBNPNB5KMJRMChV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5qcd8IN; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5qcd8IN"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so2994945e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643490; x=1790248290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=l5qcd8INaxYCTNQAz9YXL6ERiSM3X3vdABE2YVWcf0fs/N7iYipSOAiUKv3KCcSEAQ
         DNt1VJuJOUKYOfOIQL32b7ZXiHwegTSY3Yj24dpHAi9h+bhnOcZ2sekhmcTKhVFH74mN
         +v9OXS92dO0jOpOrwFBNmOIVd2g7xZl12OiIXSgcN0N+OIeqGi/BASBUeTBBset40TjV
         9wmuxMQNsSLwFDgF3iAv5pCAa/ykLmaXYUoq6SjdlHvsyFRp6SP//EUH4GxviO6ZhHW5
         V/w3I+MKJ+m85wSmVkmMGGX+f+wT39tIEsDGuOukLjC0J+UaqLbd+Vd30awlgFjoiG4o
         N3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643490; x=1790248290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=FDuTxuSghpx1INz5RLA4gBWWsVwS34/pUufEnRuleFGeyboXBXJ7QG/DDsz1v8QmYr
         AbWoMLMVqQnJ3j4Pno0T4bzCnyyeX+jDIkmOA/LnrVeG1qXTuuCJsyKhUO/JEhKv5I3h
         ar5DFuCkh9NYHx1goP8LvtySL8/mdU3tw1O37T8jBtP8TfpbBoCxN98/OIgs6fc+2oUb
         Zq5A6tZkHL7Z3lQbLLVYs3eUjtN/buUfKM7tU0gXTlYZa9Qyek6djkwvmFR3SMTEfCqY
         zE66MhMrbnJwtrp8OHAHYhjSQaYsl+fM1VoOG00PrOjecYzvbyTY0E+MP7eLkpNDYPWJ
         Dmzw==
X-Gm-Message-State: AFuF++ls+obA/nigC/rSSOHb6I0EoYnwnHS+UbJTHVXbpinD/9WbRJ5y
	HeBNmFLqZrwLqyhIDTRtHXSTB+ygKT/8ilbNNxkuG/lKH/YwfZF0N/XJGCKRqqK/
X-Gm-Gg: AYBFou0yv8inhcd3PRjK5BNFdR0UZ5oPQxOdfz/rQkt8oPLP5EaHzbbokXd37hAy91r
	g8iHsaPGNRvDubmM/yUQwdi3QdrnQ2AVMJ550/JLGgtsUkdLUEBo0G6z+2NscPPifZw2cv/1cEe
	aIiBdYKkWgbg54DcWQqCBA3yPvOpzXn6iic+KSBQi4klKUoK7cvv0mRq3foTLRbr5zvPlUkc2Sk
	xptmSLD1fQN51xIbuMHBlv/EF5Mmd8fEnRt7RmnrPR8Zka9QUhXY7mRZC7KhjSIkIJ/8tE3JqYR
	gGHskKAwVrHdvFHup3Ja+eylcNSBSptsUZ8OBJ6hsQ23qdpn0QFHHHZ+9qAaIuNTu9/n/Px/HCG
	5yXzKL1yG7OnU+xJhiBKFTv5nxbUW9n8+uZZVdAHFGxCETj1Nkbi72J8EyDbaJDEXc7/XQiJTbK
	vJpk5HkrMG+OFAKGeXr0TCj0SRw0fGa/Tgr7HEZ8veUMKwWctNPfLeQX2QvyQEsSz2Wz5jfM4Bz
	RWyM8WpP8kiEuQ9Afb1B58oj3iOOFPxABrhtJ20EOHr6ous+8gC9Hoaee3y+QsuXxf40/Tp1Xlj
	aOSJedm9J17kwQGyS+CPr9ogp1kbiJNe7KVQyQ==
X-Received: by 2002:a05:600c:6298:b0:49c:cfbe:5a76 with SMTP id 5b1f17b1804b1-49eb7314373mr74097655e9.2.1789643490200;
        Thu, 17 Sep 2026 04:11:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd225898sm72235475e9.9.2026.09.17.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:29 -0700 (PDT)
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
Subject: [PATCH bpf v6 01/10] bpf: Make post-verification instruction rewrites killable
Date: Thu, 17 Sep 2026 13:11:13 +0200
Message-ID: <20260917111127.3780880-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727; i=memxor@gmail.com; h=from:subject; bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qcQIFSnzwt5XwZJ+H3QW1p7m53uxf47DynuRXMaaX l8U6uI6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBF5BkaGR/k7JluvmqC0hT// V+O3KoEKvX0Hm+Wjq267pR5asEbPguF/zafl199smOgdYtUQp6rzKvHJDVaxfSv/dL00nVx/0uI VHwA=
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

