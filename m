Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4E395AE9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505898; cv=none; b=EjZZjRh+h1v2FF4cai5Aj21bonzQppqiUzgVrViDHD3aQ8GWPUo0OdDPY1w/OeGT8PqWOn60wxZJo9t7dz0r9txxBYKqQQhz67OtSPN9Q0CzpVxHE3WShh2IYBGgm2rmD+k0TW+lYYK9xyZHw6X6k3LrlZ7v6yWeQPhJrwjGTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505898; c=relaxed/simple;
	bh=1DWEKxnL9Y5iIJJgE0IGQnZCRFQryy48gL+P1KY1O00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH94kMYmIuUEq++IpylDzblG82czkuQ/TL+9XqsJop81O2ZqBt0I5qJfmI/DVCd1shjA3zn9llRA10OQXqFphH1EUJGFiZbENIyV1Z8SmNj/qzs/uWysyy4oTf06ihFgEZj5Ct+Rn0RBMRKE1+1sta8fQOEgIVGogYqU2QWDZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxRermI05qhmIBAA--.4546S3;
	Wed, 08 Jul 2026 18:18:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxTOXfI05qK20FAA--.4099S3;
	Wed, 08 Jul 2026 18:18:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next v9 1/2] bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
Date: Wed,  8 Jul 2026 18:18:05 +0800
Message-ID: <20260708101806.18885-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260708101806.18885-1-yangtiezhu@loongson.cn>
References: <20260708101806.18885-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOXfI05qK20FAA--.4099S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw48Xw4fXF13tr4rGFW5XFc_yoW7XFy7pF
	n8J3srCr40qr4093ZrJF4xA343t3W8W3y2krWkG34SgF4jqrs7X3W8KryfZayftry09F1I
	vws29FWjg348ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Introduce a 'jit_required' bitfield flag in struct bpf_prog to track
whether a BPF program strictly requires the JIT compiler to run. This
prevents a dangerous runtime fallback to the interpreter for features
that are only implemented in the JIT compiler.

Currently, bpf_prog_has_kfunc_call() is used only for kernel function
calls, replace the kfunc-specific helper with the new 'jit_required'
flag. This makes it easy to support other JIT-only BPF features, such
as inlined helpers.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/bpf.h   | 9 ++-------
 kernel/bpf/core.c     | 7 ++-----
 kernel/bpf/fixups.c   | 5 ++---
 kernel/bpf/verifier.c | 7 ++-----
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index adf53f7edf28..b1271f53905c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1865,8 +1865,9 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
+	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
+				jit_required:1,	/* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
@@ -3170,7 +3171,6 @@ const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
 						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
-bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
@@ -3509,11 +3509,6 @@ static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
 
-static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
-{
-	return false;
-}
-
 static inline const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e19a030da6f..883cb7a800b1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -126,6 +126,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->aux->main_prog_aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
+	fp->jit_required = IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON);
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
@@ -2670,15 +2671,11 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = false;
+	bool jit_needed = fp->jit_required;
 
 	if (fp->bpf_func)
 		goto finalize;
 
-	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
-		jit_needed = true;
-
 	if (!bpf_prog_select_interpreter(fp))
 		jit_needed = true;
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12a8a4eb757f..02246df2f6c3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
-	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
 	int depth;
 #endif
 	int i, err = 0;
@@ -1404,8 +1403,8 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 			return err;
 	}
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	if (has_kfunc_call) {
-		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
+	if (prog->jit_required) {
+		verbose(env, "program requires BPF JIT compiler but it is not available\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51f7965d42e3..1e178143e10b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2714,6 +2714,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 		prog_aux->kfunc_tab = tab;
 	}
 
+	env->prog->jit_required = 1;
+
 	/* func_id == 0 is always invalid, but instead of returning an error, be
 	 * conservative and wait until the code elimination pass before returning
 	 * error, so that invalid calls that get pruned out can be in BPF programs
@@ -2768,11 +2770,6 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	return 0;
 }
 
-bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
-{
-	return !!prog->aux->kfunc_tab;
-}
-
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
-- 
2.42.0

