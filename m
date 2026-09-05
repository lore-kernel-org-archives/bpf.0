Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1742314B63
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597265; cv=none; b=XV6JZBhjMns0jdZVYq0dbr+2yQQzMEi+vJyGj56h3UV5vanKw/ecprtE58tcqc+ybcoF2vHYiWGn1Ns05MLw5ixF/Yi5ZJvP8dwIHlV2pIJCPQVWkdeeaHJyXjwn9AfZOT6gWhTZG9QdL3ognDc8mHp7OjmL0pf0gOWFy7oKMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597265; c=relaxed/simple;
	bh=zcza65wjEK8NEEIK+tbsHqerDnQIIfxWk/CUvJpdu80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVP106xXS+U1HJFljyD6Ni72Xw0eu/Qp1IF487iWafhuVdyfwiUwNBlK5N+E0WCGsyA62P3sWfN6D1FWcBUW1RnNlFlbRwhtciTQSbth5wLfdXsQte+WzssjtXgoOVrIWxTzrF84IEAwNPMF8DYdQ5RJKfT85YOOluj+lQ3H/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlN9EE07; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlN9EE07"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso388797f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597262; x=1789202062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWJANbLFGq9MawAaFxt+pKtX9i+kT4WhXeppFB8idGk=;
        b=IlN9EE078qaHVt8ja0Dx1/dMYeMgPBG2KtZzK0TSd1+vGxsbeXhmilxsWHqy8mpKJJ
         Vsau0WQWqtlDWPK17u6GNcSZjANCMUOQX0Wu63r3HSoMuLRSvAJO2COQMXXxesLnzKGU
         mhAeqoztnmlnhpKnXhUN6ym5VO+XxJSeJEL0IojcYrwsNo42WVUIdj8CBaRAeYMnnCYZ
         1Hrr14V8x6sCsz7enQ9pcTtFkXgRG4IkLhhO5b/cgSgHzTQBYd0ObWwKljlHTHiaiGjo
         5U4q+gnSH6FQ/LKydzkl4X8Pt+XszZP+zOckFTwmbBW5XU95ey7TOx6561AQ17eyC+1h
         Hujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597262; x=1789202062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWJANbLFGq9MawAaFxt+pKtX9i+kT4WhXeppFB8idGk=;
        b=Hi/HdSpoxoGE3yrTLYr93tQHUd+iSvMGEO8b4vq6dEhDKDXckjPF9w8gootdhVPc+T
         vMV/DMksidnRONYHl+cLojcHX69jHVIFU/6cU7N9NPbzeb1WToEOATnYhsFtJO+F8y1P
         rube8iwuwzRVXERyG6NEkK/0jEgEV1z56d60ul/qWhLUicG1dA5E0knC85DPPz0iVgDv
         yQnFFa++qUE9kFxeXHhp7UbDGU1PvLe0r0KSOKDwtbnhqhDzC+NUIMbe3DsZScvZXyHa
         6DBnnZUuJvxMbSOqgVmwm/+fa9vrd1BpURULxH/6slwdzxgNe/t2Avg/AW27EIRLJtSF
         gVXg==
X-Gm-Message-State: AFuF++k5TGceLtUgJ7xZKqozQBVXzWCDimL9/BMuRCGBNolTz7JYas6f
	2lEhsHjvwWJYKC0/lfjRV2sYibTaGSJQXxZ/LfmR2QxkbrgNc++kQJqUPcvA0lpN
X-Gm-Gg: AYBFou2uHGtoAcSKO0IJgzulQ9nL71q2l0NidMcD1+0w/qJ32Xf4O9UjcZGiMBTNqcn
	3u5VZZpRqe4dg9OSx0xppm+4BnYqPgCEkHOJ7awnIb5Pwx4sE5G69aca3HVF8CahXT5MnLVupPd
	AXgxKIMH4qaGv/RXxn+3ZLE4+4mObe4gXBCB+lAIi54I1gI/rW23uEM30vsrhGXC/h5x0n200UI
	D6PSUOUXxCMdhj9+bUe88XNPsvU2BJnJJO3tIDuAXC8iMyBN25jl+RndS7k659jO34vXHjk5W6n
	O4/V8l3abJ20y7U8RIE5Kbkz1fhN4B2L2miEtiacV5FNQzRozb2t79Z+bHA+XffFcpwEoHTsGx/
	mzU34d8r/F1Aj6jCeBiWKc5OGylZgJv4wfrX0g46h7oCROVlMaV6N7dVjh6zojaMrxlXdrgj7FT
	Dp7cNzfcPE480Us+Px7tlC66MRwcbTH6/8Sya3Xpgyem9G8nsuq9kM4fAz8Oq15s+yGpA2wnV9r
	rIw3nVVVVV1gkfqlmwa2QLNzjUWAEdkWMYA2LDfqeJFB+X63N+9NTCNGxF4jS+xhDqJF6plGx4X
	zB86KFwLY+zygzAeMlD3DDA8QFs=
X-Received: by 2002:a05:6000:25e7:b0:485:8a46:b3d1 with SMTP id ffacd0b85a97d-4858a46b5acmr9656113f8f.57.1788597261646;
        Sat, 05 Sep 2026 01:34:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm12795865f8f.35.2026.09.05.01.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:21 -0700 (PDT)
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
Subject: [PATCH bpf v2 1/7] bpf: Make post-verification instruction rewrites killable
Date: Sat,  5 Sep 2026 10:34:09 +0200
Message-ID: <20260905083418.3723623-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4539; i=memxor@gmail.com; h=from:subject; bh=zcza65wjEK8NEEIK+tbsHqerDnQIIfxWk/CUvJpdu80=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pTzTuZNW3Pv4vMVy1Tnrf1/Ongg4u2BvBLeR6Xzmh baTTB+XdpSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiP3sZ/goKyC+TXf8gzXvC 8hVH4ufYVD2/Eqa1uPDdvP4bs3UY2P4yMkxfmcYZ9X6KnPFRo+dWvluvnt/tlTVjac3JRQ6BPJe Yf/EDAA==
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
auxiliary data. Most callers propagate patching failures directly. JIT
constant blinding can instead fall back to the interpreter, so recheck for
a pending fatal signal after bpf_fixup_call_args() and after runtime
selection to keep cancellation from being consumed by that fallback.

This does not reduce the quadratic cost of the rewrite passes, but it makes
the work preemptible and allows a killed loader to be torn down promptly.

Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c   | 21 ++++++++++++++++++++-
 kernel/bpf/verifier.c | 10 ++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 52d3cec33672..9401fffcedfd 100644
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
 
@@ -2666,4 +2686,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c3039f3fc32..9c797cc3df40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19,6 +19,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/perf_event.h>
+#include <linux/sched/signal.h>
 #include <linux/ctype.h>
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
@@ -21367,6 +21368,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	if (ret == 0)
 		ret = bpf_fixup_call_args(env);
+	/*
+	 * JIT constant blinding treats instruction patching failures as a
+	 * request to fall back to the interpreter. Do not let such fallback
+	 * consume a fatal-signal cancellation from bpf_patch_insn_data().
+	 */
+	if (ret == 0 && fatal_signal_pending(current))
+		ret = -EINTR;
 
 	env->verification_time = ktime_get_ns() - start_time;
 	print_verification_stats(env);
@@ -21425,6 +21433,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		env->prog->expected_attach_type = 0;
 
 	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
+	if (ret == 0 && fatal_signal_pending(current))
+		ret = -EINTR;
 
 err_release_maps:
 	if (ret)
-- 
2.53.0

