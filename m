Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F153CDBD3
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687949; cv=none; b=jOuG4/dr2fA22w/K7VtxPdxXA8cY5wLGFfpI2NN4SWYnOp8EQjN5HVZzXrHDX3VEgCmjmj/e7d3wiplQDi5oa8tBuj3zA4fEo+aOR5xAL7TNSODFuMl/xyeJaIaxnLrUQUxW0FVXt9oMni3PBRt1qXvmP8ThTwAHYcoZadMHw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687949; c=relaxed/simple;
	bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq9q4q6MlpFiBg6+cB5d+XYk07PPb0bAtO0lWsV2s1qgyaQO81UP7KUuZu9BtitaOfoTfjj0tqMYQ89HktmShcgR61CYXP2/4HPeJ0B7WRyZSxgnwDVQHYRvrM0RDnVetyZIbpxIHiT0MJVmT2b3X2NHSJhfs7I8mVe0JYU3ETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdIx3iMa; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdIx3iMa"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so588275e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687946; x=1790292746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=BdIx3iMaQ25Iz6hLX6A1owgz0UFiOwHVa+hrmbg26tcvfSQNzqmJdw9kya5Lr0dgbX
         hZwGe25RxNyKbhHvFN0WK3Z/RF6NnxhWh4oKzdKhm+S3WpAuul+ifKQE0cbNgrllPgyV
         F8cdBD1CaBHVEGHtGeb7uQXVPwQV5esaYdX09oZ4TcLsE5wqcly+asrV91USUmHk6Sgy
         ZDkBVj7lgcwYhaKGBnLaJv79iEJA5cByFEKn6zAG/yTKKM8dQgi3RVn1+UMhoEhWhBMa
         Kj8gFQGLdDoPNe13kg44XzEzIBLFmhTRY2Cy+7uHPBv7vzg1RijWKj5hQrlSCtb7J3qf
         YVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687946; x=1790292746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=bgRbdMGSxj+gdm8ORzKMtmEFy+3XqeJS6ffGDBEVwS1qOTUDB5JrHA9rZRqbqVbOD6
         JOL7ywpIazTq6qfOZpGwJiL5eyyqNghILPiCAMnsdaL7zuCw8AGZh42w0rWjVvxQuDfD
         yMga2zWKfOwYu7OfcqbdxhBv2X5TF1/N2vWUccR82U8NsrMYyPHHomuMprOAI+vgaFmO
         T1VseNq+8ur+PDswXHOFKgNj2isCAJBH9QHw4nN/GkILqW6GjSn6EFMz3GpIxOYIJDG0
         BX2GkAdfVHH1VXxSdAan6h0pWRKwIO17eL0nOZxRNOzh+XAZP3llwoLpvZQ43N2mZHVH
         rETw==
X-Gm-Message-State: AFuF++lWRF2rHMsarvvOQBHkrV8/3N6y49vep9BKWZdLt40tSBHU/bJL
	JpcPnp6pzpxNZlz9k8sMlSqRzSplrR6Qh+oQV2imp68BgyBfGbQ/vNh2/IpiGaNn
X-Gm-Gg: AYBFou1CSHHHB47uFP4t9QQhnO5GyB44jvJnf7HdqchdW6RuNRD0ueTT2ZU2tb/ToVe
	Ml8q4CAnX6vtQOudm29rvg0JMC+KSxO9ddlH9csN+yM+E8OKUZqNEWg0D37xNwKZqygQ2KLo+p/
	5kKtjxCbFd3YMydRFpJsAGZPhzBeT2p3g4ckXdNa/6/9XAgj0QjPr+Ad2UmbwkH9nVO60ytAGCV
	iCPDRcR/wW/wlUFFH3gWhtC+cDVpJA+FUoQLaNrGdauudgYG/1jbqzRgUjc8RSfByzxDo3tb+iW
	oSJnNXpvxetzJyCGf/enCDxjO5ahH2ksj3GhecGalqUQ7PNrjN4n8u9HjkVZKNN2uJOGQ8pooyE
	JkA+YszJQBTKTOqHao0Dn9XNPJwORXtVJQpqovK4+RHlWglDZuOinhV7K6oWhviK5N8P40oZsJ7
	alpyl9Ar0RmMAlPzLp6hx+s1UElXbQpvtRs92Gibe0EH0Be3I8mc+0LnRGzqCQ6Di4OQ0OZHuZx
	5RyrkuH6/YSZHoTr+zsTuLpVbiA0LiXRL2/RBt63homEqtbiP6m9mVbtaePBPoOHSidqetObvFt
	+Sjz6k2tbAoksLs9xZQYFMyS5qP8baIvXWEGkw==
X-Received: by 2002:a05:600c:3104:b0:49e:7c83:4733 with SMTP id 5b1f17b1804b1-49fc5749bbdmr5472755e9.32.1789687945731;
        Thu, 17 Sep 2026 16:32:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm26628735e9.4.2026.09.17.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:25 -0700 (PDT)
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
Subject: [PATCH bpf v7 01/10] bpf: Make post-verification instruction rewrites killable
Date: Fri, 18 Sep 2026 01:32:09 +0200
Message-ID: <20260917233222.2542500-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727; i=memxor@gmail.com; h=from:subject; bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRXqEipR5Ye+rYEm/DzoLa0/z873YP8dh5b1ILmNNr y8KdXEdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEjWf0aGh7Ub96Z9ubyie9tT eYOSmIp3IgE/3p74lKbln1twWUkjg5FhndOhi6Vza1/EFhhvCPrOenSq8ST5eBML4fV+jjsz/1p zAgA=
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

