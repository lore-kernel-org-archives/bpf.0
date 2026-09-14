Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6ED4570E1
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391828; cv=none; b=hfkO3j/SH0xdSaTiWXnsy3ZObtUe/fSiGPtHwevpsCjc8ummVozS0xKjDWePhbHU6/jzFEdZOvcGCkg5g1jCWhKS/6gGS//u/oYgbdnlpYymmo1BGlkXtWRx9cYersE3M9MyOEodirRlZ0wHoNoIXwGhFWtYRiAPcX9asTlKfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391828; c=relaxed/simple;
	bh=4A4xY4pV3ulKVk+UxXUp/ielcZ3v2W7Q0fX7UAuodPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNj5zqeF1bCzU/6YnYGMzT9DcOKMgb1l7XTbVLEwpdOlovj5JUKRTFi6bAb56qsp6BUnj64rda1s8lYa8XIo4xTkqAQxxh8GOoaJHF5Mxxqn9cyeUCXektxfiMBFwhshlqjWCKUp40Dajai727HjsL5NmZFvfj0r/jhKt0+JUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdlI2i0a; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdlI2i0a"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so1250721f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391825; x=1789996625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/AM7pZVJCJBV6CmB4qgnOFAcJg5ZJ+OcNMjbIk/uz4=;
        b=WdlI2i0aZLaSg1NDUYgpLAqqbAo1Tpuma/7Uij1gpfV5PXP5/NYr4noM4uPsjiEZ7K
         trPhS/+O7C7+qOcvRSrA3y0UCH9ukndGaVKiN0B/04ep3MLsZ58n9hw/Xy8SQw4bO2PP
         3oNIOszbKYcQMiVi6ZVxvtlA4RNvTuRAJJf+FUl88US67hk+F7KmGJXPvmSQyXwfCgnj
         vDzfdB8XDhai199trQxD61nJlC01vWdnfUhcgtWL2Y0lk70BAOTZ50qReK8ows1fLHFy
         f+ztKMFvOF7TO523ErHnSF5hBe4u0hLYkILjvKlHucmXLBZMzrxWtwi/jsfHgY4ar39d
         AElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391825; x=1789996625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/AM7pZVJCJBV6CmB4qgnOFAcJg5ZJ+OcNMjbIk/uz4=;
        b=WmAzny4UwPY9w8OIokBAGAM3eM4ZA+9FsIkc8Dtq3Raiipb+V4YYZTuKsipsdCsw6d
         k3Ozu8Usd0dHXTYePj+mHIC1tAB3lfQNBIeImourjFVnhbM542udgQTJVMIKu32mvzJW
         /ubeA1jP7owBvRrZNTMwUVVmIi27Jm9jXhtNDt+igMjo575mJ3x77DsvGpyWvwsBx3HP
         fHEIiN9q0v5M85NtncfQ0q2poEefjG8Lif9SGy+rtVqz8GhId8Z4SQeWk82neDzCQ1U5
         /EYlrMgUEIFpVSOcQRMt/mv3Ywjd6DwDa0EyNXxiXtTUTQZoxsu90R47ifip0K9ufc+q
         wtlg==
X-Gm-Message-State: AFuF++mva1sKbf5g2i1hzYvdkTPE8vpyhi4yZIhlS7q9IIT6J90RxwyH
	H/ou4kBbKOq1XU+xuarCF7dgGC87gr7SM0GE2xoWg2KKVsv+6QRHsmrvf0Q34hYB
X-Gm-Gg: AYBFou0S3TRJ2QA7kYa1BRCUWwj/DMfjb1OzxILHAaPuc/brd5lsL/8lbB0e1jMeLKq
	XBLTnf5RaZrj4w08eG5/fKC951CZrvW1trWTEKZyRjCeDqsuOqefM8b5ssFOBQ9sAu1rmK+dEgo
	zSPHG9VcJxlE62D3019ZGdPcWk0nsR9RHdvcDS64LWvGxMpm9BPdOoevytvfYg/Ki9O0+sD+dHM
	AFXPGdGK9izWF6HGm+U0k6cqpQSXG7SAazdSEXRSBJ4vmpBOuQpgCtHHGxH6WlRnqCapsjJXBAY
	AFNg76i5F7LInRLLCcWY2mbsV42fLNiWZUPs7mLzZA+HHuW455kcEfxqSx5RnayfMI3b189rkDy
	ybW45HcB3P58fdyM4dl9kSZdwMJnvn/+rWcadUij0kYsiwTZcXLX0871deqQeUSxTYJvGyP4rdz
	jzJcYFrvpQTCguwMnfpocUS+eazHLR5EkSIv9+QUdnNzS5oLEOMqJS2SUt3neL8FQIUrVtYdbT3
	Iq+dDMr5QKV48QTAKc1qt9fouOovTBtv2mUuEccdLvKN/3/xczaOwDUCrQoFtxJVVUy8UvvFoA+
	/G0yq135Z3s+aLsukua4ngXxX3MDkEstftIl3SQL0npYplxS
X-Received: by 2002:a05:6000:471a:b0:485:b169:54fd with SMTP id ffacd0b85a97d-48702ac21f3mr6657315f8f.4.1789391824928;
        Mon, 14 Sep 2026 06:17:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm27044660f8f.2.2026.09.14.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/7] bpf: Make post-verification instruction rewrites killable
Date: Mon, 14 Sep 2026 15:16:51 +0200
Message-ID: <20260914131701.2529725-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661; i=memxor@gmail.com; h=from:subject; bh=4A4xY4pV3ulKVk+UxXUp/ielcZ3v2W7Q0fX7UAuodPA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv55xnuj2eVLrvNvOm4Vd/KSaFbmm0OfDb8J1rGfdtO+ lphbMGJjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyE9zrDX5mP3ZMWXo+SnNp7 h8PJkWueytM7rZd1vLYrHoi92evV8o7hn+Wz2oqJFxseMdiEJGfzX9hl+ysx/5nfX++kJw+XnbZ +wwMA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c   | 19 ++++++++++++++-----
 kernel/bpf/fixups.c | 24 ++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b294dfc1ad4..df1eb43d1933 100644
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
 
@@ -2625,7 +2628,8 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog,
+					     int *err)
 {
 #ifdef CONFIG_BPF_JIT
 	struct bpf_prog *orig_prog;
@@ -2636,11 +2640,14 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
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
+			*err = -EINTR;
 		goto out_restore;
+	}
 
 	prog = bpf_int_jit_compile(env, prog);
 	if (prog->jited) {
@@ -2681,8 +2688,10 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(env, fp);
+		fp = bpf_prog_jit_compile(env, fp, err);
 		bpf_prog_jit_attempt_done(fp);
+		if (*err)
+			return fp;
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
 			return fp;
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

