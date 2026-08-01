Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD037C90E
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625447; cv=none; b=nNYduNcKwjMtoM6MuEV9e9FoJxP0/X0OHSdL/ZNG2rwniOUZGpj+8DFXbwqKDMJoPEyl8D8+jeHiWebnz73dDgeCk3TFt4xa+EHqGal/MLD6zOrSUp2u+/L0qvAQweLVGTvjQUMFm1GSde+nfhInO7GYAguV89NEGR1p0ufZz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625447; c=relaxed/simple;
	bh=GtqHuKGFJ/ERUpveVV33VM47T8qIrTjHtNY1B3pp/Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goK9Ni2Bt97S24JyD6G/uNJ7Dbn0wc6QWXYQDeUdZZFTf7Y3yEeabwnntpjWuj+Jkspsbv43aUhKhqg0oytph+WYJzuXZv5tQGZffTG2/93BpVu0B3qCBArv8EjmnSGJV7rPOX0qPROTqG/zsujzYosCu0FQIqrnVsZkPfu0Alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EokvRu/a; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EokvRu/a"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so3989575e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785625443; x=1786230243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Myo7zbPkQp+zr3R/Ale/Ewm/wNKb8rXqpBp/M9tFFrs=;
        b=EokvRu/akTqixLiqWgBM30SyuwDGRuCVt+OCjDfrErxfCHw564WlrR6ONpbxSqQm5J
         msLrl4oLCQpqaJonI/EpP913gcuVbRPQeL5XXwHwPU9YBa5EFOwemzbmSjLfDJsZdo4F
         ZTj9GJqTD+op46WjMnYpDn07fnpJUFkHX2u32pn5/ofikcZ8diHQfslYKD7RblMr3E02
         yvlzlVUmdS6dqBwfwAYrrDa8G7EwlEPzjr2k5mj/qPr8SK1I/bhSqYVWlDaEeWqrSxwt
         PsjMRwbCGZnBPTn5od8xR/ZxHJdEzA+NWYUxOI0YCppPZLqapepD7pOqAAYPTSHiguAf
         MSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785625443; x=1786230243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Myo7zbPkQp+zr3R/Ale/Ewm/wNKb8rXqpBp/M9tFFrs=;
        b=EryAZd6cJYremvnyAK+VSolEhIWZY7muztE5j5AkbH1IpCzEFe9Jwl77+nGqk6++rL
         qOgv4LHje1sFnlR2SJ9Zkee66C8fnYkTqPFReTmiNghPx8wTz29+qUXZtIf6oFwM1vjT
         YD+8pl8SK19nGeZvmBCq7T4kF5ReMA/qYzqsKuSMk3kJvcT01OxZaVDUhAUMQGdqfdaP
         wXZgc8Ve6xDFyDPtE/sDodp2YRCY4l+SZHo2jxb9MX7CT4P2YpaNLLpmQF+6mzB1EXqO
         pZbP/PXlOd0GlU3s2WKQ+fq4Q6KmlOy/YpWQGaDQjrLHJOVoOnIZFvHDBeexOqwPUzLD
         z+Mw==
X-Gm-Message-State: AOJu0YwYOsyCduVA3M/fLnoShMgkPMmd4EpdvxzJh0mbIgotddQetW/F
	KfIxo7U72UusufrY7wGlgBJO4Oy/+hrpMJvADmDEMTiV6lGUhv67EvRXXKltkmS0
X-Gm-Gg: AR+sD11gXJ/B+hdye25rfap86FyP/0TuJRdW6p69HmS3rIk2QCilB64/On+OXZIhcGv
	DmlNoImvWixhJf149sYclMBpdBJFlhf5xiFQPu+rsB5j0ES3cT/70o1lio2oqxYJx2DrBw5KidK
	r+14TOw1PcSR1PxpRMpuiCCdP9KIndaisRVT+Rgl4wW1sc3TCPO0FxUL8FSDiZNfmob2rVRF//h
	YvxopJitELR6VdEGBmJak62m4dbJuJmp6bdjvgpFjMhRcr1X7z0+o6k3tSUXODQxHE2wfHwjBeB
	JUQrii0UYLv+4veYW/4HhnQpXJkg68Bng3GJR5XJdpJyqU1+VQTvMuX1V/J810gDGQyixCZvaUk
	tbX80hGZYYSA6oSX89nwxJSHHRcQom+u9sud+juRSRcvPwPbnGg2azOv5nBgUAp47Yh4MnwGE03
	44bhORIiqG7JQmDr4CqvBPbngpAq8PvxT4w+evIfdl8nJ7rH7A6rjtllZ/fV+5eWZlH9ZDWFzGI
	zsjjNHagHrSyk9WRMTKsLgc/0xtU97JW/QLD9f019JBISZledo6bVyCit+jYaxQXnGOFK+yxkrn
	36f63MD697DozAneGR02nYSASqY=
X-Received: by 2002:a05:600c:4f87:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4980c66c7d9mr67388195e9.3.1785625442641;
        Sat, 01 Aug 2026 16:04:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a1910sm40696855e9.4.2026.08.01.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:04:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack depth stats
Date: Sun,  2 Aug 2026 01:03:56 +0200
Message-ID: <20260801230400.850271-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801230400.850271-1-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8408; i=memxor@gmail.com; h=from:subject; bh=GtqHuKGFJ/ERUpveVV33VM47T8qIrTjHtNY1B3pp/Pc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuvquNXdlDM2YPc9dsON3xO6Wyf+uKinNTl2tC3M/w6j mR2/eTrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET25DL8U+9atk2zZYu9l42p WpluY3jZlyQ5AR414586f/4KBs9XZmTYrnDfwMm+3/35nSk/PSyuX1R+/WaOwgVvxeNML+VXzL3 KBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, the output of stack depth statistics is two crude, with a
list of captured stack depths ordered by the subprog numbers. The actual
subprog numbers are determined by libbpf, hence it is hard to associate
the stack depth statistic back to the subprog by name.

Change the format to:
stack depth <subprog>=<depth> ... max=<depth>

In case the subprog name is not specified, use subprog[N] as the string.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 16 ++++++++++++----
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 19 +++++++++++--------
 .../bpf/progs/verifier_private_stack.c        |  9 ++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 5 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d0635ee48c7..51ac0a9ae339 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18703,10 +18703,18 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 	if (env->log.level & BPF_LOG_STATS) {
 		verbose(env, "verification time %lld usec\n",
 			div_u64(env->verification_time, 1000));
-		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
-		for (i = 1; i < subprog_cnt; i++)
-			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, " max %d\n", env->max_stack_depth);
+		verbose(env, "stack depth");
+		for (i = 0; i < subprog_cnt; i++) {
+			const char *name = env->subprog_info[i].name;
+
+			if (name && name[0])
+				verbose(env, " %s=%d", name,
+					env->subprog_info[i].stack_depth);
+			else
+				verbose(env, " subprog[%d]=%d", i,
+					env->subprog_info[i].stack_depth);
+		}
+		verbose(env, " max=%d\n", env->max_stack_depth);
 		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f2114..f135c4b9344b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,7 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("stack depth uninitialized_stack1=8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +45,7 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("stack depth uninitialized_stack2=8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..0b48156920df 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -10,7 +10,7 @@
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("stack depth simple=8")
 __xlated("4: r5 = 5")
 __xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
@@ -96,7 +96,7 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth wrong_reg_in_pattern1=16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +598,7 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("stack depth helper_call_does_not_prevent_bpf_fastcall=8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +620,7 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("stack depth may_goto_interaction_x86_64=24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -661,7 +661,7 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("stack depth may_goto_interaction=24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +708,8 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("stack depth bpf_loop_interaction1=32 dummy_loop_callback=0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +757,8 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("stack depth bpf_loop_interaction2=40 dummy_loop_callback=0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
 __xlated("3: r0 =")
@@ -800,7 +802,8 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 512+0 max 512")
+__log_level(4)
+__msg("stack depth cumulative_stack_depth=512 cumulative_stack_depth_subprog=0 max=512")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..4a4a5a891f62 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,8 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4)
+__msg("stack depth private_stack_nested_1=512 cumulative_stack_depth_subprog=32 max=512")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -331,7 +332,8 @@ SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __load_if_JITed()
-__log_level(4) __msg("stack depth 8+0+256+0 max 272")
+__log_level(4)
+__msg("stack depth private_stack_async_callback_2=8 timer_cb1=0 subprog1=256 subprog2=0 max=272")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -355,7 +357,8 @@ int private_stack_async_callback_2(void)
 SEC("fentry/bpf_fentry_test9")
 __description("private stack, max stack depth is private stack")
 __success
-__log_level(4) __msg("stack depth 8+256+0 max 256")
+__log_level(4)
+__msg("stack depth private_stack_max_depth=8 subprog1=256 subprog2=0 max=256")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..7fb81a954eb1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth stack_write_priv_vs_unpriv=16")
 __failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
@@ -238,7 +238,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth stack_write_followed_by_read=16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0

