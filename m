Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DA39BFE1
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742058; cv=none; b=BSw5+jsowyp0Zp5I1aeqCpKM58DpgGmVHNfCwbkSGigbcHeAEG+g9Ypr0usAs7N9GrpmBT6C+0gcM+enO7Yb0hqDi8zrbMrzzKfrFWRIRVa4Qjxd5hBZXO1khmTRHw1iOFjagXXY9UeCcDgO2G9GRyGJUDRR7N0KJNWf1oZxUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742058; c=relaxed/simple;
	bh=fiX4SO33sQrCOuY30ddzwRHh18TmsoTB/t8uaw2rJBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LemVNKy78nUE/GRo32tV6Bfa3g1CStoaxj7CJ/kJK2Pa/rnPL4h8++T7DF/QYhwWSxYPwmR93GDYOmvaVtDHGT57j/n/Z/3ISOlIYCg0XYpRKgQ/HSzphtHKmWuvinTeBO0bp95guafRRFUdMJqN0oNzPTOWSlM5j4Oj6iqFF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foaQKVM3; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foaQKVM3"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso1318910f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742055; x=1786346855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3M45FGTDX4E3gQhw9w5a0gLiRSCyOs/qAFWGeH8BgY=;
        b=foaQKVM3I5cLFNNRGxGBvzvQVj6KoUN6Ss1GrdUdyiXbSXkpM+fexuFZ+wc7MYHNs/
         eE0u9WwCh6DBfUpbFklnNHinTjqaQYtMQEbaqBGGKfdH5d69uDCmZ0JyuEmkRWND9tj0
         d7Jzl6QsnaQFcHJtd1XCiGcuxM+EjtQZIk8NsNB9wnzoaJpm5J7drEvhGPv795HCUo4x
         pSmM8Ch1S5bPp2oIkjvsW820TAQnEsl7rJgzu77mQc09ckMEedhWvGbQCjj6mV2LzIz1
         enWcQu1LiDytknDdgqFrgYVBkVRqfnVdDmNsizS+MizFYfP0B9yGP0GLcX1KyChuOZGo
         9s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742055; x=1786346855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3M45FGTDX4E3gQhw9w5a0gLiRSCyOs/qAFWGeH8BgY=;
        b=s51B8BLt3pyZtghX5jYFtahmVJ+g8p9rUAO+sQ7h9zwveOxNokofxIPd6/wJ/Ynpea
         jN4s9LXphmfTZtx10nXR931/HzMz27ATCB+T5BxLb11j2D03xBBXxhPo+7/FrkqfVLxJ
         aM/PI5EH+rs9nIz/eHfeTiU3c/O8S2TVVoqvFbzWfLtYCF55dXeJBgTPtJiKFfWSsI14
         3KrTWl7AMWGHCju06blOv8X2UHIvr7BT/l2UdaoKJJPSm4oOz+IHXhBVDqe7iq9LQeh3
         dSIPZlqNEhcPnuooTv8A9IRbd7VMRgL1pOTWzRLtVOPF7ggzBtkuAU3XmrHZSUrxPL6w
         dw9A==
X-Gm-Message-State: AOJu0YyTAq7d5ASLK0GlGWSelkXTCgfZD00TgQn1sys9IxWZrvfnCPsL
	nz978jcWTsFGk18iOnY7LkbC/qgk/BGoZdNDSPRYDfzV6fa+6HGnvf4PlNKvMxq2
X-Gm-Gg: AR+sD12fjp2+Wa9MLMGTRTw6q/lm/ByN6MSmGFQpDif4e9m/a8jIjxY1J197JjE4YtO
	sG6yniMQI4eMu41N2P2sXVDr2qJdxmHVl+svZu8c3rSY/yLxSc9QXN7nc6bcgI3On6xL05Lp4tr
	z9w/X6AUMtG2xxxtAV1DwjNT44JaQKoEgwPZwWW5VOr3k6Nd94pbmkelskULIPc/QiqRFiSlmgM
	wIELOikrlWjhxHAtEJjZFIHin//60sNf8K9wpalBuiL0f3MKxEs7j0wleAnIhFHg6ZnmUD+6IQD
	KhjAyAr7YKkrzKCv0+o1RrH8WW3gia7D+3T6k+IXh7C/lc0h3ol0zLF1dOHMXUj6b/qr21t+Owx
	QaMyCjEKg2EAKYRNdkEn3aG+Uw/nr7UDr2oSzSRPwxgS5E8leDNUbdKOhPmtGdJ848m4lT0J//I
	k2AH6mc4i71GE1Cq+63rQZ/Pj6E+D1og0HIBUSlm5zQoVya0tJuuVR5DAV8DHjGxY5+tZSoZtXd
	CNXMv3Lm5rmgiDZ5xevCvv6Tu57sh5lOcH3BPr2FgDnOeJv4f4op/ga34OTe+T9umd4wyvU81mI
	SfTUTLDMX6ubDVdCjQksVN4//6M=
X-Received: by 2002:a05:6000:22c2:b0:47f:c648:e265 with SMTP id ffacd0b85a97d-47fd9cf7670mr21007523f8f.17.1785742055368;
        Mon, 03 Aug 2026 00:27:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm29375574f8f.4.2026.08.03.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:27:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/3] bpf: Show more useful info in stack depth stats
Date: Mon,  3 Aug 2026 09:27:29 +0200
Message-ID: <20260803072733.191502-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803072733.191502-1-memxor@gmail.com>
References: <20260803072733.191502-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8865; i=memxor@gmail.com; h=from:subject; bh=fiX4SO33sQrCOuY30ddzwRHh18TmsoTB/t8uaw2rJBM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavA6fqU37xvXxoHO1w2LT2rImP1WlDK+v62/Vwi9roX5 fsPvVHuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESmLmBkuP0v7f6alpMa3gdv hex+1fwwheWu9pKNOqzdQXxp85p8JjL8szE4ssAjl8Nk9zpPk/mlXROM/r1boX90psWEv0kBV7m fcgIA
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
index b274004fccfd..3b61897ed0d2 100644
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
+			const char *name = env->subprog_info[i].name;
+
+			if (!name || !name[0])
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

