Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CC47FB10
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593690; cv=none; b=FSVA09Gm/rvnhSWxJv4joUnRHJJh/LJCdNQg9SUtRB0dq6XYHrQRGfItmnlkK1WnvxiOrBb0ecVhvUXK/AFGE2l1OMr8gw0KdWwQW6AYcHTjrfTklqHyOzVqkGSuHp0uPbGZGl+OFeRWyuUzi98nw6wpJQ4vOCTAKfXowl+Nrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593690; c=relaxed/simple;
	bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUiL0UruHYWWeS3TPXWzLrsWAH8snNbDtFc6XBp8NJ/9XtDt9JWJWaovEpvNbPYwPGW2ZmDqQr/BWZpxQCqMevhwFgZyYaPQRkLb79NN6/HbBp6ZxW69tUeyzZQ5/KJ69L6JQyXO29+6s/mOsYkPintbCv/FhoRsfeA/z+2GMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gttG+LfB; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gttG+LfB"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso58175f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593666; x=1790198466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=gttG+LfBx5iN+6BAYA5E9NT0K8JNaURAVT31tKn44ixEktaP928IqEXvIa708RwI2s
         RfILc5uFvPuWSWbAHpjVfRBvWLBVKeNHDx1j1T3G/hvcTqZPPN3QH1UHCwc8Ewbk2l4x
         SjABLX8P2+MIISdFN0CXQWflZetoNVzCxiqSCeVTphlw+HlUCncBQkgWn1lq3SkpIxsJ
         lTRsZ4nM+jyRCH1N6IT0pnx+IWc7qe6gAEMg9bJGJWcGNUmYT+RSWwtxz4OjsZ+mpF5R
         V9mDNrDCiTFAthwEAOcvg4MjAtcFKnyOfuOcTp1bsR5EaP1LqNkbaqcjQIdySuEL29Bo
         LIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593666; x=1790198466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42jMYeh0SruEgr9PJLiVYc6cC5cTQmva8JHOwdTe3Mg=;
        b=pSFV62fIGy75oNTw+adNI2XK2OoCy1eiVG1mCTUU6lFTjhwPKwxB26dahXNwJHfo1a
         ncUsSj3KJiUd+R1O89hHkCtfhvvuBP6IWFUlLvTH9bnx4So6tPaBgRc5nXmCg3aeh7gR
         lOC2e4yq/8W3EgOW+cXoyx4FU1Hk+XzwS7y0E9hs+VFWDu7fHSXNLpyV3C3AD8L5DFfp
         AJAb7VLmbM4oZsRz+vvJSJD1VfL8exj8T6r2DiNP2Ka2O0h+qir1G7aRjAebzJC3J6NA
         6rQpnz7TVBJVlcFSJYjsrq3mHdfbqSBblBzyakL7lpgPknusUhJ05DjN2uMXV0hNpIH+
         +E+Q==
X-Gm-Message-State: AFuF++l1HYwUsQfSSlSrYkdLo/lblGDzi5Ib7eOOxL4WVvTuDTpwGmEM
	opcHY2B/3HTRW3iayj8Y6/pOeMjP52gteE5rRNZ9LjoIlegxuHUdOVvU7Oc/xyx2
X-Gm-Gg: AYBFou3Isd8/MxLaoqfzEv6mk/LlQQlRL6ECg7qKLyyQ/jjlcZT+sgKQZy1jzD27pkc
	9k4shgKorAF1cZ0rAOfynEc54oZIOYTvd5gnn3c2pWSdJm8N85rsNNkG27qa1EQOx46W5QeAHxl
	qduZDrcB8nzmYZTrh03hE0FJdSYVbrnhFHuU5nOF104Mj9ljMKbn2xb+qoBwecBUvnM2zbI/LmT
	fC+wchQgzVScBPUcWqfGR+c335mnsqg86qQ+r55nvqrbVFaTNotVGqVQbySKpgqKf8IwcRmb5L4
	3SxMFgVX1uAocl6IDFcvK+26huG56V+j2ai7W/uL7zw2OK9uYQR8bkB5uUrIna2PNJ+tqTWqRBf
	hK3x0cEhWXsFDteUQ3D4twnkn/+8le9TbslrU0qqxwgSMjRS7WZG4c6qUnrP2Zgxxx8kK9HW1qQ
	nHhpBaI2p1hKa4GW8JlFUopVCQ+hiDog6GVbUlP9VVe1IUeONO/bm5P1JqTA+MvqLo45COB2aBb
	d0MVV+Yn039YEz2hTIh4JKDrecAZPgNX3UpuGcmd4ke3OBSDw1QkPavOJaWrUXjpOMmQsE6R9Wg
	i2L3IEdqEFdK0P6f4RFYbDCDPnoSDAy+FX+86vqGR/u4aon0
X-Received: by 2002:a05:6000:25c9:b0:487:62d:37db with SMTP id ffacd0b85a97d-4870d06299dmr5240516f8f.55.1789593665999;
        Wed, 16 Sep 2026 14:21:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bcc7d1esm9691135f8f.0.2026.09.16.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 01/10] bpf: Make post-verification instruction rewrites killable
Date: Wed, 16 Sep 2026 23:20:48 +0200
Message-ID: <20260916212102.597335-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727; i=memxor@gmail.com; h=from:subject; bh=6ig4MTBot15ujYcg2J9tuuByub5T3f+7YulzlLPtS0g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h2yEipR5Ye+rYEm/DzoLa0/z873YP8dh5b1ILmNNr y8KdXEdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEhpAiPDpm9d/UbPbm6sfPTk W9o+HxPpV9kz36+a7pxeO5v30dzAI4wMM2d/m1V6w06T/1a18an390zYmHzcD6aJlDR+3PLNQ0q dAQA=
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

