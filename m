Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E003335091
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726903; cv=none; b=aI342CI2Fu+5bZmKcfLKYKIe3zEhcRkiDm2V7+3uufFBdYQHPLpsEonoDnuc0w2Govc7SPK37ibByG6dCwpDlnKSgYNuxun+KnPDU5ZWumXORic80Urb/uMwqJtFYDSUO85znT7AQSN8NUf0ApKOWeuxmDph22lQIMzs5wBQrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726903; c=relaxed/simple;
	bh=rUo0Dz/ORetATKzLytrcGsZOEhAsxmI4aatCt24F7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWA+y7A3c72Pwwwaxg8PIiBVpFCAdRRVbjjCZYtGuglsLSSttQYfHCmTeAur9fL5ZkPcSzc2f67HTL2j5JIqEL5EP7sg/YEXsitsQp2jO+DYoZtbsEjuILOAFdPuMNZIs3TfxEvU5sNzO9zfZ/mSIopYe4KyHNcACW3XE8+kY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8+oBwLa; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8+oBwLa"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso986647f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785726899; x=1786331699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWPJsjptRk2KxTIrGXKw4TSHxgzIN07H8MJkIjA3UOw=;
        b=e8+oBwLa9prh833O0T8b3XaPKlYTiB6xEoLE/Lc4xlRdl8oy1VNyGYbM2FAVbZkMIJ
         gS7fE+Jv21T7adwdVBLy2qdqejcQm7xBQ7HeaWuLbvy9f1Y/sa44AyMe8QlYxJB8nbiW
         yeuDTov0wZvGHm1QcNrKv9blHqH7qACfshr4O/8YiquTXlX7THtMnjQKlqbwiTlCLGZZ
         5TTIv9Umh5hRXBtVU9iYhiac2q04zVB2RnMAs5V8e7PQHj5UU1JtztM8Sfo02hFEIqhu
         FkUPMSRWufyo08v+456C6NQ0HdEsxkwZohixR5NCWNHz60mF6m3cEOR914Ag2RVoDQ5t
         FyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726899; x=1786331699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWPJsjptRk2KxTIrGXKw4TSHxgzIN07H8MJkIjA3UOw=;
        b=mrWfr7evYmDQ+vaMOdzgeWB4xscZHI/A9d7v1j034HafeVHu/nU/gngmIYtPyBZN3U
         Wwa3TUwMpaCcsh04vg9uI+acHQc87V85K8ENsNH92wa5oesEpNw/cY2k8H+0h7cMyRZE
         PipH2K3LhIYBaPgjT0ec8rNlLMGvKSqdNJVMN5hiKmRMh189OgdD69XnIWgEd6YAjR1+
         Dcvu/mvDZefXjyS0ioyfw8JlZU0dLMNXu07r7Fx1AzA7/BTh/cGl+L4SsVOP78MYsQTk
         nphnWNcfcQHCDGSzgZ3l89QomiLM+IlcnmUe3ltERVdDgYfdUt+5Cbat9ntbG3IBnaJV
         s2TQ==
X-Gm-Message-State: AOJu0YyjsoCL860LVZkwjT1G1TGXH0DO3xMHSNUwf9VonK8ckXcABbcB
	xYcFPNUvIe6l7qUae9uo2+YkUphvjH9QgCz0GoHRZ8l7gtc3Kx8WsCVP10UWBdyW
X-Gm-Gg: AR+sD13u6L/tc9da5ayZ8HvoWDPlDJifxnIxsQi0GHKzybtg1mxGkNnwz+mL/zGVqie
	a4Xoof9RaoSuvTmBc8/Mt79bUaO94LpJ8cYqzjwZamC3YDEu2lzRKH7OppOAPcw/JVmqvdmGr95
	RuB+ghITvVJTBQxvBlZprBvhIaFPEP+eLN0Eo0iCcAS/4KDFyXt3As1DzGYfYNNxe68O0hZLhox
	joQFMvQLwo5wpBrTmN30QZKvFEySJtlsefWNtyhyiYgoMJOeg5bhmsyRPRAwTykVUnd48ClKa1x
	7k/zKTWRO2UUCIYQiSk/Cw/CsHJ8NEQ76TcpjaAdYys/OmY6sLqtfGCJvQgoRVVMyZ/DDZaKc0Y
	csT4Mfx1WM/YzGwa4jYYQTZZ1ypvZ+sxYDTKzhTvbPkXJd9BSvzYGYvvAkomKWUIlJdzNE6MxZB
	+ADiTE6BvFun7o4punrZ1KWUYxqLyzM4OOPL+a+NGDNax+DDOtgl8TubU/C2i0BdvlyaTGUMKYW
	L3GuKX0A6UxY6T4EnxJiIMKQjM6FEfqHlP9wc7/ARdwgMcjPC3aZ2aSc1YymxePIYxHz+z9tXV9
	Y9/lrzUt7fSEnYlFKHgfoeJ8dnwQ6B5Oorm+Sw==
X-Received: by 2002:a05:600c:34c6:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-4980c66b50emr192265565e9.2.1785726899115;
        Sun, 02 Aug 2026 20:14:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b84fb2sm112104885e9.1.2026.08.02.20.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:14:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/3] bpf: Show more useful info in stack depth stats
Date: Mon,  3 Aug 2026 05:14:53 +0200
Message-ID: <20260803031457.3115812-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803031457.3115812-1-memxor@gmail.com>
References: <20260803031457.3115812-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8851; i=memxor@gmail.com; h=from:subject; bh=rUo0Dz/ORetATKzLytrcGsZOEhAsxmI4aatCt24F7OE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauAfdadxEkvjBI6GjW3iT/4f1NutvyCIP5JdikNuX7Ku Vomiz06SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGXOEaGRSWPti6MdzyaYrNl ut385NDX/4WkNG58/3hK95fRSt+oC4wMT4Ln/3V4eDVddE3r2eZn2sxnSxTEVl0pfCG/1zbcifE 4AwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, stack depth statistics are too crude, listing captured depths in
subprogram-number order. Since libbpf determines those numbers, it is hard to
associate each depth with its subprogram name.

Print the maximum stack depth and each subprogram on separate lines:

stack depth max <depth>
stack depth subprog <number> <name> <depth>

When no subprogram name is available, print <unknown>.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 13 +++++++----
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 5 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..cc2b4a8619ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 	if (env->log.level & BPF_LOG_STATS) {
 		verbose(env, "verification time %lld usec\n",
 			div_u64(env->verification_time, 1000));
-		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
-		for (i = 1; i < subprog_cnt; i++)
-			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, " max %d\n", env->max_stack_depth);
+		verbose(env, "stack depth max %d\n", env->max_stack_depth);
+		for (i = 0; i < subprog_cnt; i++) {
+			const char *name = subprog_name(env, i);
+
+			if (!name[0])
+				name = "<unknown>";
+			verbose(env, "stack depth subprog %d %s %d\n", i, name,
+				env->subprog_info[i].stack_depth);
+		}
 		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f2114..61ec8790fd21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,7 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("stack depth subprog 0 uninitialized_stack1 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +45,7 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("stack depth subprog 0 uninitialized_stack2 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..cb36866bfed3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -10,7 +10,7 @@
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("stack depth subprog 0 simple 8")
 __xlated("4: r5 = 5")
 __xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
@@ -96,7 +96,7 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth subprog 0 wrong_reg_in_pattern1 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +598,7 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("stack depth subprog 0 helper_call_does_not_prevent_bpf_fastcall 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +620,7 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("stack depth subprog 0 may_goto_interaction_x86_64 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -661,7 +661,7 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("stack depth subprog 0 may_goto_interaction 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +708,9 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("stack depth subprog 0 bpf_loop_interaction1 32")
+__msg("stack depth subprog 1 dummy_loop_callback 0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +758,9 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("stack depth subprog 0 bpf_loop_interaction2 40")
+__msg("stack depth subprog 1 dummy_loop_callback 0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
 __xlated("3: r0 =")
@@ -800,7 +804,10 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 512+0 max 512")
+__log_level(4)
+__msg("stack depth max 512")
+__msg("stack depth subprog 0 cumulative_stack_depth 512")
+__msg("stack depth subprog 1 cumulative_stack_depth_subprog 0")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..c818898836c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,9 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4) __msg("stack depth max 512")
+__msg("stack depth subprog 0 private_stack_nested_1 512")
+__msg("stack depth subprog 1 cumulative_stack_depth_subprog 32")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -331,7 +333,11 @@ SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __load_if_JITed()
-__log_level(4) __msg("stack depth 8+0+256+0 max 272")
+__log_level(4) __msg("stack depth max 272")
+__msg("stack depth subprog 0 private_stack_async_callback_2 8")
+__msg("stack depth subprog 1 timer_cb1 0")
+__msg("stack depth subprog 2 subprog1 256")
+__msg("stack depth subprog 3 subprog2 0")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -355,7 +361,10 @@ int private_stack_async_callback_2(void)
 SEC("fentry/bpf_fentry_test9")
 __description("private stack, max stack depth is private stack")
 __success
-__log_level(4) __msg("stack depth 8+256+0 max 256")
+__log_level(4) __msg("stack depth max 256")
+__msg("stack depth subprog 0 private_stack_max_depth 8")
+__msg("stack depth subprog 1 subprog1 256")
+__msg("stack depth subprog 2 subprog2 0")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..df436bbc9ecf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth subprog 0 stack_write_priv_vs_unpriv 16")
 __failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
@@ -238,7 +238,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("stack depth subprog 0 stack_write_followed_by_read 16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0

