Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937311;
	b=aRN4OVJm/m1IxCQr+M2St7XOfsM3yHBZVTEbr/n6NDLlNV+e2tzBnzNKvBp+vemoViVr
	 N0IJKZQnQL+YVUMVYqUM+V0HDOmhoxu9wBfDSXiMWP/Ur8qarIxix6hHXLTN13H/7T+EE
	 uyiA8MQxeVzpYCB9f8uAHJfQxhS6cVbebUr8b6GkDx5AZAbdIguhqUBv4YdYAm6IljYFB
	 y2CD6urMmcJjAQZPGmDee3XfGhB6Y5RZ+E4bUxjBgpUzX3dbxnTVCxPrfUIYEtNEul2Em
	 WuAsUffbZlm3HDYK4tVjJZB77ag79Zzc88kP0nnPHyZUKAtU9sUO3xF2f1gMUyNwl2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=53sPBx+nbuuvdrHBI1Oq2xyK/fYhkNDK1rQDzq93c5k=;
	b=2SI7XPKSgizzV7qYkwcPc2q0QDvWnufVxoS/Off0BeS8m57T93UqdH4zAhZRXpX4Js06
	 TsZ4c85eqgL4L+Ncv7Mhwdv+3XGgyqnIxohkKfTlzqQglAY+FnCF7EMUxpuC9cOrFd6cY
	 QSIlNAB6BYZ2iQVAYl4bZejAqsQFe5ZU+D/AXlb1uEQahX3M8AtS/y8tCD8AMgZcdJ4Wa
	 EwxgGq37o9Xw6qM4r4fpUq7TJxaN3/yAnGxZAPrmXmO7ScehUzzhmPa/WKLB1zu6YtMkz
	 kfehd4eveqqxOnWpe8jlbZhHpDWvN6lG3Aee3hE42+26hScS5a7XlzGmL5XBdvqmSHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOxaer7T;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACB606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EACB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOxaer7T
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so130467a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937309; x=1794542109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53sPBx+nbuuvdrHBI1Oq2xyK/fYhkNDK1rQDzq93c5k=;
        b=qOxaer7TSjEz1vEeLdOT7Wy8T64exxBE4BpI1My31Ld5NFXldHCK12O4KszOnttctO
         9g8o0O5dRxdSKCNAIENRbVl6xWcwdYKx80+Dl8RAih1TEA7MkjaAyGYTSzlsJ651tdsz
         CsR5APNVpJgAPeNMEm09nULbG5Nsm1SAt1OP9yxq7kHyoSjbOrCC1ihD6Z+zbgTgjYJW
         yteqOC5Vf+u7Cl5FEI+Z6U/nnSUQqMgPAMfXyMjUtqN1LMP1m3rd11WmFR6gyH33+ZG4
         L9uWRLeG9gTPvxYafG1jlZ3OpzVPKz7kIvcpGq+vxbILktKo2u3/s8HiO7nx9pVwGr9R
         +Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937309; x=1794542109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=53sPBx+nbuuvdrHBI1Oq2xyK/fYhkNDK1rQDzq93c5k=;
        b=Nqknj6gyJJpVE1ciLPM/c4MZ4g7hKsVhY/i6knwqibxT05UkOGgXcHcn9agip8oNFa
         NsXHuan2l+S0S1BYiZxoLOxGtSQj5ysVeJHPj4tVD56hWd9V8O19Lg0Wc5Q5FruxkvRZ
         IpkS2RoNHunkz8NT7Dh3to3jpvKLwbYTAHppDbVfSmMQscU+fL96d2TOkawnUSHlybOa
         6eqd2BYIgwjP5h4zGSscz0cNsZhV2xajg1yluHU2cQHaEIYf73nV2XsjXPRF5atXgnTe
         w7D+4CV4i2mqMlUDz+1I9MAEbnGuteq+3Nm4iuPeodIq2w+BWwNz15+JsT6iSzlMsmWj
         5BCw==
X-Gm-Message-State: APuU4Z/dgC5u93QzjVPlAWml+5yjexvl6Jge1EuNuQLBPKtD8Q4gNHJd
	IuN0lnHDSzkLnnTA20q6QdGrJHOsF74FuKmkHlpC3VOZK+XNBtMvLJe+Fi/J8w==
X-Gm-Gg: AYBFou2bhdJRD4bQG6rRuJW52ReX4f/xmN6ueoyGmk01jcOWftG17omq6GViDZP7cc3
	KRCjLh7Yae7z4hNX1V4TSipZDb1aHMUnAn5c7ozzt26thHRruF6d2mWoGWqecWlSTuQPLqZGnDT
	UvtXMhs87n9K6k4TFxLWMMOe9RQH9qbWOQOqPPMJ7PF3RpPzcjOohxfiHw7mDowOsTYic1ZIi0f
	Ie5aZ5MFcxi5DdsJcE7uqnISK7GRmRlpn3WDGOagjPW6m+Enju7SlvxIUYsqiQ4BXcrDGamZORr
	YcIshAsGq1kiE/T7Z/GsyNO9N3dATnzDv6bUyl8qjL+POO43QN8ULcuCjIegWbrq37E8FT9pm25
	va0bTSXJDt7MAkzkp0fyQiWUw0YknvW4bRiuE49/cFMtbU0WvsLoBqliVU+ZdOjWQiyzQfNBayb
	5je7JSDFENtDj4Fv9ZdGQn/viiohdUSsT9+5KuIBegMR+51t52YdIVhsvldxzToLkt6cYW84AcK
	wTB3NJ1Th1dn+WXr4wsDYSN9VBidv7jGunX9wN6anwFAvEvuHR4HmQZCHmVWfKw+Pepwy10o4FQ
	7WQBfbd7wVsGi6hv5yT2AESZwBYCgdxtf3OE5Pa8WGWqUjA0NDtnk3hoGPTv+VIMsHz4PWCeqWh
	x7cVhFlJdsJWvh8OM3sijgYldLmxBhXvQ8rf+65a5XoMNXSzJq3zNFLIc8wx1q32yJRzFqd8GsG
	ryjx+jcEHYgDi4t5aCpg/e
X-Received: by 2002:a17:90b:39b0:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3b0db6d42d2mr1183636a91.15.1793937308345;
        Thu, 05 Nov 2026 19:55:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42932sm1517976a91.6.2026.11.05.19.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:55:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 40/45] selftests/bpf: Adjust tests to new verdicts, messages and order
Date: Fri,  6 Nov 2026 03:51:04 +0000
Message-ID: <20261106035111.3315285-41-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Without this patch 143 subtests of test_progs and 3 tests of test_verifier
fail. No prog that loaded is rejected. 25 progs that were rejected load.

  [F] "bpf: Verify programs as a fixpoint over the control flow graph"
  [O] "bpf: Verify static subprogs on their own"
  [R] "bpf: Allow recursive subprogs"

  before                          now
  ------------------------------  -----------------------------------------
  "infinite loop detected",       [F] 19 progs load, most run and return 0:
  "too large", "8193 jumps"       8 iter_remake_*, loop3.bpf.o, .. One
                                  state covers all iterations, and may_goto
                                  stops the loop.
  the same, the loop has no exit  [F] "loop at insn N never exits": 6 progs
  "recursive call from",          [R] 6 progs load: callx_*_recursion,
  "frames is too deep"            bounded_recursion, .. It needs the JIT:
                                  __arch_x86_64, __arch_arm64.
  "header_count is [0..3]", then  [F] "[0..5]": two bounds are joined in
  "[0..5]"                        front of a counted loop.
  the fall-through is verified    flow_compute_order(): the target of
  first                           a jump is. Swap the branches, or expect
                                  the other one of two errors.
  "0: R1=ctx() R10=fp0"           [F] "0: R10=fp0": only what is live
  scc column, "depth=",           gone, "(limit 0)": the patches that
  "(limit 1000000)"               remove the old pass
  r1 is an argument               [O] only if the callee reads it

The last row: the callees in verifier_live_stack.c and _liveness_exp.c read
the pointer that they get. unsafe_on_2nd_iter also wrote 8 bytes to
'char buf[4]', and the verifier finds that error first: the buffer gets
8 bytes. bpf_loop_iter_limit_nested compares two sums with their maximum:
the verifier knows their range, not the set of their values.

New tests of [R] stand next to the old tests of the same limits. What it
rejects: test_global_func3.c, verifier_tailcall.c,
"calls: a timer callback calls the main prog", "arena stack: the kernel
frame of a recursion counts in the depth of the stack". What runs:
"arena stack: recursion ends in the stack", and
callx_no_recursion_after_all, which gets no check at run time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |   4 +-
 .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |   6 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     |   5 +-
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |   4 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   2 +-
 tools/testing/selftests/bpf/progs/iters.c     | 114 ++++++--------
 .../selftests/bpf/progs/iters_state_safety.c  |   8 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |  12 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |  16 +-
 .../selftests/bpf/progs/test_global_func3.c   | 125 ++++++++++++++++
 .../selftests/bpf/progs/timer_failure.c       |   9 +-
 .../selftests/bpf/progs/verifier_align.c      |  10 +-
 .../selftests/bpf/progs/verifier_and.c        |   4 +-
 .../bpf/progs/verifier_arena_stack.c          |  82 +++++++++++
 .../selftests/bpf/progs/verifier_bounds.c     |   6 +-
 .../selftests/bpf/progs/verifier_callx.c      |  71 +++++++--
 .../bpf/progs/verifier_callx_rodata.c         |   4 +-
 .../selftests/bpf/progs/verifier_cfg.c        |   8 +-
 .../bpf/progs/verifier_global_subprogs.c      |  11 +-
 .../bpf/progs/verifier_helper_value_access.c  |   8 +-
 .../selftests/bpf/progs/verifier_idoms.c      |   9 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |  17 ++-
 .../selftests/bpf/progs/verifier_live_stack.c |   3 +-
 .../bpf/progs/verifier_liveness_exp.c         |   7 +-
 .../bpf/progs/verifier_loop_hierarchy.c       | 125 ++++++++--------
 .../selftests/bpf/progs/verifier_loop_latch.c |   2 +-
 .../selftests/bpf/progs/verifier_loops1.c     |  16 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_scev.c       | 139 ++++++++----------
 .../bpf/progs/verifier_subprog_insn_stats.c   |  16 +-
 .../selftests/bpf/progs/verifier_tailcall.c   |  27 ++++
 .../selftests/bpf/progs/verifier_uninit.c     |   2 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  23 +--
 .../bpf/progs/verifier_unpriv_perf.c          |   4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  46 +++++-
 36 files changed, 615 insertions(+), 337 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 902a70d5afeb..2dc37090d7a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -154,9 +154,9 @@ void test_verif_scale_loop2()
 	scale_test("loop2.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
-void test_verif_scale_loop3_fail()
+void test_verif_scale_loop3()
 {
-	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
+	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop4()
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index d6f14a232002..4f821fdc4a02 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -125,7 +125,7 @@ static void obj_load_log_buf(void)
 	ASSERT_OK_PTR(strstr(libbpf_log_buf, "libbpf: prog 'bad_prog': -- BEGIN PROG LOAD LOG --"),
 		      "libbpf_log_correct");
 	ASSERT_STREQ(obj_log_buf, "", "obj_log__empty");
-	ASSERT_STREQ(good_log_buf, "processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+	ASSERT_STREQ(good_log_buf, "processed 4 insns (limit 0) max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n",
 		     "good_log_ok");
 	ASSERT_STREQ(bad_log_buf, "", "bad_log_empty");
 
@@ -179,7 +179,7 @@ static void bpf_prog_load_log_buf(void)
 	opts.log_level = 2;
 	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
 			   good_prog_insns, good_prog_insn_cnt, &opts);
-	ASSERT_OK_PTR(strstr(log_buf, "0: R1=ctx() R10=fp0"), "good_log_2");
+	ASSERT_OK_PTR(strstr(log_buf, "0: R10=fp0"), "good_log_2");
 	ASSERT_GE(fd, 0, "good_fd2");
 	if (fd >= 0)
 		close(fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index 90a98e23be61..89a7f5947081 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -41,7 +41,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
 				  "log_buf_part2");
 		ASSERT_HAS_SUBSTR(log_buf,
-				  "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+				  "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n",
 				  "log_buf_end");
 		break;
 	case TRUNC_PARTIAL:
@@ -50,7 +50,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
 				  "log_buf_part2");
 		/* we shouldn't get full end of BPF verifier log */
-		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n"),
 			    "log_buf_end");
 		break;
 	case TRUNC_FULL:
@@ -58,7 +58,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 		ASSERT_NULL(strstr(log_buf, "struct task_struct___bad.fake_field (0:1 @ offset 4)\n"),
 			    "log_buf_part2");
 		/* we shouldn't get full end of BPF verifier log */
-		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n"),
 			    "log_buf_end");
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 6231258b26cc..09f7930733be 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1276,7 +1276,7 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 		{true_pos + 1,  7, "R7=", true2_reg},
 	};
 	char buf[32];
-	const char *p = log_buf, *q;
+	const char *p, *q;
 	int i, err;
 
 	for (i = 0; i < 4; i++) {
@@ -1291,8 +1291,9 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 		 * Different verifier passes may print
 		 *   18: (bf) r0 = r6
 		 * as well, but never followed by ';'.
+		 * The branches are in the log in the order the verifier looked at them.
 		 */
-		q = p;
+		q = log_buf;
 		while ((q = strstr(q, buf)) != NULL) {
 			const char *s = q + strlen(buf);
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
index 2e23b8593af9..1d1684d2cf3b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -26,8 +26,10 @@ int BPF_PROG(invalid_dynptr_cross_frame, struct sk_buff *skb, struct Qdisc *sch,
 	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
 
 	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
-	if (!hdr)
+	if (!hdr) {
+		bpf_kfree_skb(skb);
 		return NET_XMIT_DROP;
+	}
 
 	free_skb(skb);
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index c89c88db39d1..715218d32105 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted R1")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
 int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ae845ad747bf..b9677d30e692 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -47,7 +47,7 @@ int iter_err_unsafe_c_loop(const void *ctx)
 }
 
 SEC("?raw_tp")
-__failure __msg("unbounded memory access")
+__failure __msg("math between map_value pointer and register with unbounded min value is not allowed")
 int iter_err_unsafe_asm_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
@@ -878,19 +878,15 @@ __naked int delayed_read_mark(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
+__msg("21: (79) r8 = *(u64 *)(r0 +0)")
+__msg("misaligned stack access off -33+0 size 8")
 __naked int delayed_precision_mark(void)
 {
 	/* This is equivalent to C program below.
-	 * The test is similar to delayed_iter_mark but verifies that incomplete
-	 * precision don't fool verifier.
-	 * The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
-	 * State with r7=-16 is visited first and follows r6 != 42 ... continue branch.
-	 * At this point iterator next() call is reached with r7 that has no read
-	 * and precision marks.
-	 * Loop body with r7=-32 would only be visited if verifier would decide to continue
-	 * with second loop iteration. Absence of precision mark on r7 might affect state
-	 * equivalent logic used for iterator convergence tracking.
+	 * The test is similar to delayed_read_mark.
+	 * The call to bpf_iter_num_next() is reachable with r7 values -16 and -33.
+	 * The loop body with r7=-33 is only looked at if the verifier goes on
+	 * with the second iteration of the loop.
 	 *
 	 * r8 = 0
 	 * fp[-16] = 0
@@ -899,7 +895,7 @@ __naked int delayed_precision_mark(void)
 	 * bpf_iter_num_new(&fp[-8], 0, 10)
 	 * while (bpf_iter_num_next(&fp[-8])) {
 	 *   if (r6 != 42) {
-	 *     r7 = -32
+	 *     r7 = -33
 	 *     r6 = bpf_get_prandom_u32()
 	 *     continue;
 	 *   }
@@ -957,22 +953,17 @@ __naked int delayed_precision_mark(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("misaligned stack access off -25+0 size 8")
 __naked int loop_state_deps1(void)
 {
 	/* This is equivalent to C program below.
 	 *
 	 * The case turns out to be tricky in a sense that:
-	 * - states with c=-25 are explored only on a second iteration
-	 *   of the outer loop;
-	 * - states with read+precise mark on c are explored only on
-	 *   second iteration of the inner loop and in a state which
-	 *   is pushed to states stack first.
+	 * - c is -25 only on a second iteration of the outer loop;
+	 * - c is used only on a second iteration of the inner loop.
 	 *
-	 * Depending on the details of iterator convergence logic
-	 * verifier might stop states traversal too early and miss
-	 * unsafe c=-25 memory access.
+	 * The verifier might stop too early and miss unsafe c=-25
+	 * memory access.
 	 *
 	 *   j = iter_new();		 // fp[-16]
 	 *   a = 0;			 // r6
@@ -1082,23 +1073,18 @@ __naked int loop_state_deps1(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("34: (0f) r0 += r8")
+__msg("misaligned stack access off -25+0 size 8")
 __naked int loop_state_deps2(void)
 {
 	/* This is equivalent to C program below.
 	 *
 	 * The case turns out to be tricky in a sense that:
-	 * - states with read+precise mark on c are explored only on a second
-	 *   iteration of the first inner loop and in a state which is pushed to
-	 *   states stack first.
-	 * - states with c=-25 are explored only on a second iteration of the
-	 *   second inner loop and in a state which is pushed to states stack
-	 *   first.
+	 * - c is used only on a second iteration of the first inner loop;
+	 * - c is -25 only on a second iteration of the second inner loop.
 	 *
-	 * Depending on the details of iterator convergence logic
-	 * verifier might stop states traversal too early and miss
-	 * unsafe c=-25 memory access.
+	 * The verifier might stop too early and miss unsafe c=-25
+	 * memory access.
 	 *
 	 *   j = iter_new();             // fp[-16]
 	 *   a = 0;                      // r6
@@ -1259,49 +1245,38 @@ __naked int loop_state_deps2(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("misaligned stack access off -25+0 size 8")
 __naked int loop_state_deps3(void)
 {
 	/* This is equivalent to a C program below.
 	 *
-	 *   if (random() != 24) {       // assume false branch is placed first
+	 *   if (random() != 24) {
 	 *     i = iter_new();           // fp[-8]
 	 *     while (iter_next(i));
 	 *     iter_destroy(i);
 	 *     return;
 	 *   }
 	 *
-	 *   for (i = 10; i > 0; i--);   // increase dfs_depth for child states
+	 *   for (i = 10; i > 0; i--);
 	 *
 	 *   i = iter_new();             // fp[-8]
 	 *   b = -24;                    // r8
-	 *   for (;;) {                  // checkpoint (L)
-	 *     if (iter_next(i))         // checkpoint (N)
+	 *   for (;;) {
+	 *     if (iter_next(i))
 	 *       break;
-	 *     if (random() == 77) {     // assume false branch is placed first
+	 *     if (random() == 77) {
 	 *       *(u64 *)(r10 + b) = 7;  // this is not safe when b == -25
 	 *       iter_destroy(i);
 	 *       return;
 	 *     }
-	 *     if (random() == 42) {     // assume false branch is placed first
+	 *     if (random() == 42) {
 	 *       b = -25;
 	 *     }
 	 *   }
 	 *   iter_destroy(i);
 	 *
-	 * In case of a buggy verifier first loop might poison
-	 * env->cur_state->loop_entry with a state having 0 branches
-	 * and small dfs_depth. This would trigger NOT_EXACT states
-	 * comparison for some states within second loop.
-	 * Specifically, checkpoint (L) might be problematic if:
-	 * - branch with '*(u64 *)(r10 + b) = 7' is not explored yet;
-	 * - checkpoint (L) is first reached in state {b=-24};
-	 * - traversal is pruned at checkpoint (N) setting checkpoint's (L)
-	 *   branch count to 0, thus making it eligible for use in pruning;
-	 * - checkpoint (L) is next reached in state {b=-25},
-	 *   this would cause NOT_EXACT comparison with a state {b=-24}
-	 *   while 'b' is not marked precise yet.
+	 * What the verifier learned in the first two loops must not make it
+	 * take {b=-25} at the head of the third one for {b=-24}.
 	 */
 	asm volatile (
 		"call %[bpf_get_prandom_u32];"
@@ -1884,7 +1859,6 @@ __naked int absent_mark_in_the_middle_state2(void)
 }
 
 SEC("?raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("misaligned stack access off -31+0 size 8")
 __naked int absent_mark_in_the_middle_state3(void)
 {
@@ -2014,8 +1988,8 @@ static int loop1_wrapper(void)
  * but adapted for use with bpf_loop().
  */
 SEC("raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+/* -32 or -31 */
+__failure __msg("misaligned stack access off (0xffffffffffffffe0; 0x1)+0 size 8")
 __naked void absent_mark_in_the_middle_state4(void)
 {
 	/*
@@ -2159,8 +2133,7 @@ static int loop_cb5(int i, __u64 *ctx)
 }
 
 SEC("raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("memory access is {{.*}} and is outside of the object of size 64")
+__failure __msg("invalid access to map value, value_size=64 off=402000 size=4")
 __naked void loop_counter_precision_2nd_iter(void)
 {
 	asm volatile (
@@ -2174,9 +2147,8 @@ __naked void loop_counter_precision_2nd_iter(void)
 		"r3 += -8;"
 		"r4 = 0;"
 		/*
-		 * Explore with nr_loops=1 on a first path and nr_loops=2 on a second path.
-		 * Buggy verifier did not propagate r1 precision properly,
-		 * and thus checkpoints created for nr_loops=1 case matched nr_loops=2 case.
+		 * nr_loops is 1 on one path and 2 on the other.
+		 * The second call of the callback must not be lost.
 		 */
 		"call %[bpf_loop];"
 		"r0 = 0;"
@@ -2190,12 +2162,12 @@ __naked void loop_counter_precision_2nd_iter(void)
 
 /*
  * An iterator that is destroyed and created again inside its loop starts from
- * the beginning and the loop never ends. In the first four progs the first
- * prune point after bpf_iter_num_new() is the call of bpf_iter_num_next().
+ * the beginning and the loop never ends. bpf_iter_num_next() is not what stops such
+ * loop: the verifier adds may_goto. The progs spin until it's out of budget.
  */
 SEC("socket")
 __description("iter: remake in the loop, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_jmp(void)
 {
 	asm volatile (
@@ -2256,7 +2228,7 @@ __used __naked static void iter_remake(void)
 
 SEC("socket")
 __description("iter: remake in a callee, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_callee_jmp(void)
 {
 	asm volatile (
@@ -2295,7 +2267,7 @@ __naked void iter_remake_callee_jmp(void)
 
 SEC("socket")
 __description("iter: remake after next, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_after_next_jmp(void)
 {
 	asm volatile (
@@ -2336,7 +2308,7 @@ __naked void iter_remake_after_next_jmp(void)
 
 SEC("socket")
 __description("iter: two iterators, remake each after its next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_two_jmp(void)
 {
 	asm volatile (
@@ -2398,7 +2370,7 @@ __naked void iter_remake_two_jmp(void)
 /* Same loops with a prune point in front of bpf_iter_num_next() */
 SEC("socket")
 __description("iter: remake in the loop")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_inline(void)
 {
@@ -2439,7 +2411,7 @@ __naked void iter_remake_inline(void)
 
 SEC("socket")
 __description("iter: remake in a callee")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_callee(void)
 {
@@ -2475,7 +2447,7 @@ __naked void iter_remake_callee(void)
 
 SEC("socket")
 __description("iter: remake after next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_after_next(void)
 {
@@ -2515,7 +2487,7 @@ __naked void iter_remake_after_next(void)
 
 SEC("socket")
 __description("iter: remake when drained")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_drained(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index b2ba4609a31e..fa9604f0a173 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -30,7 +30,7 @@ int force_clang_to_emit_btf_for_externs(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active)")
 int create_and_destroy(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -207,8 +207,8 @@ static __noinline void subprog_with_iter(void)
 SEC("?raw_tp")
 __failure
 /* ensure there was a call to subprog, which might happen without __noinline */
-__msg("returning from callee:")
-__msg("Unreleased reference id=1")
+__msg("0: (85) call pc+2")
+__msg("Unreleased reference id=2 alloc_insn=7")
 int leak_iter_from_subprog_fail(void *ctx)
 {
 	subprog_with_iter();
@@ -218,7 +218,7 @@ int leak_iter_from_subprog_fail(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active)")
 int valid_stack_reuse(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index d00888f6687a..88ce4b7a9c33 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -20,8 +20,8 @@ __s64 res_empty;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_empty(const void *ctx)
 {
@@ -38,8 +38,8 @@ __s64 res_full;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_full(const void *ctx)
 {
@@ -58,8 +58,8 @@ static volatile int zero = 0;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_truncated(const void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index b5cf85e2a19a..c6c1c3767a75 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -219,9 +219,9 @@ int mixed_mem_untrusted_btf_id_type(void *ctx)
 	 * returning 0.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u64 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -263,9 +263,9 @@ int mixed_mem_btf_id_type(void *ctx)
 	 * gotten on its own.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u32 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -305,9 +305,9 @@ int mixed_rdonly_mem_btf_id_type(void *ctx)
 	 * only its PTR_UNTRUSTED variant is.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u32 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -340,9 +340,9 @@ int mixed_mem_mem_type(void *ctx)
 	 * hence without the BPF_PROBE_MEM rewrite the other path needs.
 	 */
 	asm volatile (
-	"r7 = %[q];"
-	"if %[zero] == 0 goto +1;"
 	"r7 = %[p];"
+	"if %[zero] != 0 goto +1;"
+	"r7 = %[q];"
 	"r8 = *(u64 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index b332704b395c..b916355c5e59 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -205,6 +205,131 @@ int global_func3_32_frames(struct __sk_buff *skb)
 	return f31(skb);
 }
 
+volatile int again;
+
+static __attribute__ ((noinline))
+int calls_itself(struct __sk_buff *skb)
+{
+	if (again)
+		return (calls_itself(skb) >> 1) ^ 1;
+	return f16(skb);
+}
+
+#define FRAME(name, next)			\
+static __attribute__ ((noinline))		\
+int name(struct __sk_buff *skb)			\
+{						\
+	return next(skb);			\
+}
+
+FRAME(g1, calls_itself)
+FRAME(g2, g1)
+FRAME(g3, g2)
+FRAME(g4, g3)
+FRAME(g5, g4)
+FRAME(g6, g5)
+FRAME(g7, g6)
+FRAME(g8, g7)
+FRAME(g9, g8)
+FRAME(g10, g9)
+FRAME(g11, g10)
+FRAME(g12, g11)
+FRAME(g13, g12)
+FRAME(g14, g13)
+FRAME(g15, g14)
+FRAME(g16, g15)
+
+/*
+ * 16 frames above the subprog that calls itself and 16 below it. The call of it
+ * with nothing above it comes first.
+ */
+SEC("tc")
+__arch_x86_64
+__arch_arm64
+__failure __msg("the call stack of {{[0-9]+}} frames is too deep")
+int global_func3_frames_around_recursion(struct __sk_buff *skb)
+{
+	return calls_itself(skb) + g16(skb);
+}
+
+static __attribute__ ((noinline))
+int depth(int n)
+{
+	return n > 0 ? (depth(n - 1) + 1) & 255 : 0;
+}
+
+SEC("kprobe")
+__arch_x86_64
+__arch_arm64
+__failure __msg("recursive depth() in a tracing program")
+int global_func3_recursion_in_tracing_prog(void *ctx)
+{
+	return depth(again + 7);
+}
+
+__attribute__ ((noinline))
+int redirects(struct __sk_buff *skb, int n)
+{
+	int ret = n > 0 ? redirects(skb, n - 1) : 0;
+
+	return ret + bpf_clone_redirect(skb, 1, 0);
+}
+
+/* The prog would run again on top of the frames of its recursion */
+SEC("tc")
+__arch_x86_64
+__arch_arm64
+__failure __msg("recursive redirects() in a program that calls bpf_clone_redirect()")
+int global_func3_recursion_redirects(struct __sk_buff *skb)
+{
+	return redirects(skb, again + 7);
+}
+
+static __attribute__ ((noinline))
+int depth_to(int n, long *out)
+{
+	*out = depth(n);
+	return 0;
+}
+
+/* The pointer to the stack is left over in r2 at the call of depth(), which doesn't read r2 */
+SEC("tc")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+int global_func3_recursion_stale_stack_pointer(struct __sk_buff *skb)
+{
+	long x = 0;
+
+	depth_to(again + 7, &x);
+	return x;
+}
+
+/* It writes to the stack of its caller, or a compiler hands down the value and no pointer */
+static __attribute__ ((noinline))
+long hands_down_its_stack(long *up, int n)
+{
+	long mine = n;
+
+	*up += 1;
+	if (n <= 0)
+		return mine;
+	return hands_down_its_stack(&mine, n - 1) + mine;
+}
+
+/* What a subprog does with the stack of its callers is not found for chains without an end */
+SEC("tc")
+__arch_x86_64
+__arch_arm64
+__failure
+__msg("recursive hands_down_its_stack() passes a pointer to the stack to hands_down_its_stack()")
+int global_func3_recursion_stack_pointer(struct __sk_buff *skb)
+{
+	long x = skb->len;
+
+	return hands_down_its_stack(&x, skb->mark & 7);
+}
+
 #define PTR_FRAME(name, next)			\
 static __attribute__ ((noinline))		\
 long name(long *p)				\
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
index 0538269101ca..84ea861575fc 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -43,14 +43,7 @@ static unsigned long timer_cb_ret_bad()
 }
 
 SEC("fentry/bpf_fentry_test1")
-__log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before")
-__msg(": (85) call bpf_get_prandom_u32#7") /* anchor message */
-/* check that branch code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before ") __msg(": (85) call bpf_get_prandom_u32#7")
 __msg("should have been in [0, 0]")
 long BPF_PROG2(test_bad_ret, int, a)
 {
@@ -80,7 +73,7 @@ static int timer_cb_infinite_loop(void *map, int *key, struct elem *val)
 }
 
 SEC("fentry/bpf_fentry_test1")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn {{[0-9]+}} never exits")
 long BPF_PROG2(test_infinite_loop_cb, int, a)
 {
 	struct bpf_timer *timer;
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
index 0083ef8b8ba7..aecc5279dbaf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_align.c
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -13,7 +13,7 @@
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}} R3=2")
 __msg("1: {{.*}} R3=4")
 __msg("2: {{.*}} R3=8")
@@ -35,7 +35,7 @@ __naked void mov(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=1")
 __msg("1: {{.*}}R3=2")
 __msg("2: {{.*}}R3=4")
@@ -69,7 +69,7 @@ __naked void shift(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=4")
 __msg("1: {{.*}}R3=8")
 __msg("2: {{.*}}R3=10")
@@ -93,7 +93,7 @@ __naked void addsub(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=7")
 __msg("1: {{.*}}R3=7")
 __msg("2: {{.*}}R3=14")
@@ -532,7 +532,7 @@ __msg("9: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3c)")
 /* Adding 14 makes R6 be (4n+2) */
 __msg("10: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7c)")
 /* Subtracting from packet pointer overflows ubounds */
-__msg("13: R5={{[^)]*}}var_off=(0xffffffffffffff82; 0x7c)")
+__msg("12: {{.*}} R5={{[^)]*}}var_off=(0xffffffffffffff82; 0x7c)")
 /* New unknown value in R7 is (4n), >= 76 */
 __msg("14: {{.*}} R7={{[^)]*}}var_off=(0x0; 0x7fc)")
 /* Adding it to packet pointer gives nice bounds again */
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index 2b4fdca162be..fb64ea9928f1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -38,9 +38,9 @@ __naked void invalid_and_of_negative_number(void)
 	r1 &= -4;					\
 	r1 <<= 2;					\
 	r0 += r1;					\
-l0_%=:	r1 = %[test_val_foo];				\
+	r1 = %[test_val_foo];				\
 	*(u64*)(r0 + 0) = r1;				\
-	exit;						\
+l0_%=:	exit;						\
 "	:
 	: __imm(bpf_map_lookup_elem),
 	  __imm_addr(map_hash_48b),
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
index 1d676da4b5ea..b46e30a9c67f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -199,6 +199,88 @@ __naked void call_through(void)
 	: __clobber_all);
 }
 
+unsigned long first_r12, last_r12;
+
+/* 1024 bytes in the stack in arena, nothing in the kernel stack */
+static __naked __noinline __used long goes_down(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[mov];"	/* r1 = r12 */
+	"r2 = %[last_r12] ll;"
+	"*(u64 *)(r2 + 0) = r1;"
+	"call goes_down;"
+	"exit;"
+	:
+	: __imm_addr(last_r12),
+	  __imm_insn(adj, ADJ(1024)),
+	  __imm_insn(mov, MOV(BPF_REG_1))
+	: __clobber_all);
+}
+
+/* The check of a recursion looks at the kernel stack. It fails before 32K of arena are used. */
+SEC("syscall")
+__description("arena stack: recursion ends in the stack")
+__success __retval(1)
+__naked void recursion(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[mov];"	/* r1 = r12 */
+	"r2 = %[first_r12] ll;"
+	"*(u64 *)(r2 + 0) = r1;"
+	"call goes_down;"
+	"r1 = %[last_r12] ll;"
+	"r1 = *(u64 *)(r1 + 0);"
+	"r2 = %[first_r12] ll;"
+	"r2 = *(u64 *)(r2 + 0);"
+	"r1 -= r2;"
+	"r0 = 0;"
+	"if r1 < 8192 goto +2;"
+	"if r1 > 32736 goto +1;"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_addr(first_r12),
+	  __imm_addr(last_r12),
+	  __imm_insn(adj, ADJ(32)),
+	  __imm_insn(mov, MOV(BPF_REG_1))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long large_frame(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 1792) = 0;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __naked __noinline __used long goes_down_with_leaf(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call large_frame;"
+	"call goes_down_with_leaf;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(1024))
+	: __clobber_all);
+}
+
+/* goes_down_with_leaf() gets a frame in the kernel stack. What it calls comes on top. */
+SEC("syscall")
+__description("arena stack: the kernel frame of a recursion counts in the depth of the stack")
+__failure __msg("combined stack size of 3 calls is")
+__naked void recursion_above_large_frame(void)
+{
+	asm volatile (
+	"call goes_down_with_leaf;"
+	"exit;"
+	::: __clobber_all);
+}
+
 SEC("syscall")
 __description("arena stack: helpers don't change r12")
 __success __retval(3)
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 05efa9f4a522..6fede778971c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1797,8 +1797,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 1")
-__msg("3: (b7) r0 = 0 {{.*}} R0=0")
 __msg("5: (b7) r0 = 1 {{.*}} R0=1")
+__msg("3: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_3(void *ctx)
 {
@@ -1818,8 +1818,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 2")
-__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_4(void *ctx)
 {
@@ -1840,8 +1840,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 3")
-__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_5(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index f3f8ea67eb7e..afe4990cd027 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -243,8 +243,7 @@ __naked void callx_scratches_args(void)
 /* return value of the callee is tracked */
 SEC("socket")
 __success __log_level(2)
-__msg("to caller at 4:")
-__msg("R0=6")
+__msg("4: R0=6 R10=fp0")
 __naked void callx_retval_is_tracked(void)
 {
 	asm volatile (
@@ -541,9 +540,11 @@ static unsigned long self(void)
 	);
 }
 
-/* unbounded recursion is caught by the main verification pass */
+/* unbounded recursion is stopped at run time */
 SEC("socket")
-__failure __msg("frames is too deep")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
 __naked void callx_unbounded_recursion(void)
 {
 	asm volatile (
@@ -569,12 +570,10 @@ static unsigned long countdown(void)
 	);
 }
 
-/*
- * The depth of the recursion is known to the main verification pass,
- * but recursive calls are not allowed regardless.
- */
 SEC("socket")
-__failure __msg("recursive call from countdown() to countdown()")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
 __naked void callx_bounded_recursion(void)
 {
 	asm volatile (
@@ -621,7 +620,9 @@ static unsigned long pong(void)
 }
 
 SEC("socket")
-__failure __msg("recursive call from")
+__arch_x86_64
+__arch_arm64
+__success
 __naked void callx_mutual_recursion(void)
 {
 	asm volatile (
@@ -636,6 +637,49 @@ __naked void callx_mutual_recursion(void)
 		: __clobber_all);
 }
 
+/* calls_arg(fn) { return fn(); } */
+__naked __noinline __used
+static unsigned long calls_arg(void)
+{
+	asm volatile (
+		"callx r1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long returns_7(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"exit;"
+	);
+}
+
+/*
+ * The address of calls_arg() is taken: its callx could call it. The main pass finds that it
+ * calls returns_7(). There is no cycle, so calls_arg() doesn't check the stack at run time.
+ */
+SEC("socket")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__xlated("...")
+__xlated("exit")
+__xlated("callx r1")
+__naked void callx_no_recursion_after_all(void)
+{
+	asm volatile (
+		"r2 = %[calls_arg] ll;"
+		"r1 = %[returns_7] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(calls_arg),
+		  __imm_addr(returns_7)
+		: __clobber_all);
+}
+
 __naked __noinline __used
 static unsigned long use_stack_304(void)
 {
@@ -944,11 +988,8 @@ long long vals[] SEC(".data.vals") = {1, 2, 3, 4};
 
 SEC("socket")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 11: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (8d) callx r2")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("5: R0=3 R10=fp0")
+__msg("8: (0f) r1 += r0                      ; R0=24 R1=map_value(map=.data.vals,ks=4,vs=32,imm=24)")
 __retval(4)
 __naked void callx_precision(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 642071fa7498..8bb74b579203 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -669,7 +669,9 @@ static unsigned long selfcall(void)
 }
 
 SEC("socket")
-__failure __msg("recursive call from selfcall() to selfcall()")
+__arch_x86_64
+__arch_arm64
+__success
 __naked void callx_rodata_recursion(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index b429fa7a08f5..e97e89ba3d68 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -138,8 +138,8 @@ l0_%=:	r1 = r0;					\
 
 SEC("socket")
 __description("conditional loop")
-__failure __msg("infinite loop detected")
-__msg_unpriv("back-edge")
+__success
+__failure_unpriv __msg_unpriv("back-edge")
 __naked void conditional_loop(void)
 {
 	asm volatile ("					\
@@ -175,7 +175,7 @@ l1_%=:	r8 += r4;					\
 
 SEC("socket")
 __description("unconditional loop after conditional jump")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn 2 never exits")
 __failure_unpriv __msg_unpriv("back-edge from insn 3 to 2")
 __naked void uncond_loop_after_cond_jmp(void)
 {
@@ -201,7 +201,7 @@ static unsigned long never_ending_subprog()
 SEC("socket")
 __description("unconditional loop after conditional jump")
 /* infinite loop is detected *after* check_cfg() */
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn 6 never exits")
 __naked void uncond_loop_in_subprog_after_cond_jmp(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 5e8461b2167d..100d8307c3bd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -557,12 +557,13 @@ __noinline int global_calls_loop(int x)
 
 /*
  * loop_cb_calls_static() -> static_calls_global() -> global_calls_loop() ->
- * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion that the
- * main verification pass can't see, because it doesn't follow calls of global
- * functions. None of the functions use stack.
+ * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion through a global
+ * function and a helper. It's stopped at run time. None of the functions use stack.
  */
-SEC("?raw_tp")
-__failure __msg("recursive call from global_calls_loop() to loop_cb_calls_static()")
+SEC("?socket")
+__arch_x86_64
+__arch_arm64
+__success
 int recursion_via_global_func_and_callback(const void *ctx)
 {
 	return loop_cb_calls_static(0, NULL);
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index c6603a118fdc..1b13d3a8dcfa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -717,12 +717,12 @@ __naked void bounds_check_using_bad_access_1(void)
 	*(u64*)(r2 + 0) = r1;				\
 	r1 = %[map_hash_48b] ll;			\
 	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
+	if r0 == 0 goto l1_%=;				\
 	r1 = r0;					\
 	r3 = *(u32*)(r0 + 0);				\
 	if r3 < 32 goto l1_%=;				\
 	r1 += r3;					\
-l0_%=:	r0 = 0;						\
+	r0 = 0;						\
 	*(u8*)(r1 + 0) = r0;				\
 	r0 = 0;						\
 	exit;						\
@@ -775,12 +775,12 @@ __naked void bounds_check_using_bad_access_2(void)
 	*(u64*)(r2 + 0) = r1;				\
 	r1 = %[map_hash_48b] ll;			\
 	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
+	if r0 == 0 goto l1_%=;				\
 	r1 = r0;					\
 	r3 = *(u32*)(r0 + 0);				\
 	if r3 <= 32 goto l1_%=;				\
 	r1 += r3;					\
-l0_%=:	r0 = 0;						\
+	r0 = 0;						\
 	*(u8*)(r1 + 0) = r0;				\
 	r0 = 0;						\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_idoms.c b/tools/testing/selftests/bpf/progs/verifier_idoms.c
index fdee6bced77b..91d9f9aae8e9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_idoms.c
+++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
@@ -10,7 +10,7 @@
  * The immediate dominator is printed by log_program() as the numeric column
  * immediately before the "<insn#>:" field of every "Program dump" line:
  *
- *   Program dump (scc? loop_header? idom insn#: live_regs_before):
+ *   Program dump (loop_header? idom insn#: live_regs_before):
  *            -1   0: ....... (b7) r0 = 0     <- idom(0) = -1 (subprog entry)
  *             0   1: ....... (07) r0 += 1    <- idom(1) = 0
  *             ^^^^^^
@@ -307,17 +307,16 @@ __naked void entry_is_loop_header(void)
 /*
  * Self-loop: insn 1 is its own predecessor. idom(1) must be the pre-header
  * (insn 0); the self-edge is ignored (idoms[pred] == -1 on the first pass, then
- * idoms_intersect(a == b) short-circuits). Program is rejected later for an
- * infinite loop, but the dump (and idoms) are printed before that.
+ * idoms_intersect(a == b) short-circuits). The loop can spin forever: the
+ * verifier adds may_goto to it.
  */
 SEC("socket")
-__failure
+__success
 __log_level(2)
 __msg("Program dump")
 __msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
 __msg("{{.*}}  0   1: {{.*}} (a5) if r0 < 0xa goto pc-1")
 __msg("{{.*}}  1   2: {{.*}} (95) exit")
-__msg("infinite loop detected")
 __naked void self_loop(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 4dd98acc6436..a3e31aa25fe1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -45,7 +45,7 @@ SEC("?raw_tp")
 __failure __msg("R1 type=scalar expected=fp")
 int unsafe_on_2nd_iter(void *unused)
 {
-	char buf[4];
+	char buf[8];
 	struct buf_context loop_ctx = { .buf = buf };
 
 	bpf_loop(100, unsafe_on_2nd_iter_cb, &loop_ctx, 0);
@@ -94,7 +94,7 @@ static int loop_detection_cb(__u32 idx, struct num_context *ctx)
 }
 
 SEC("?raw_tp")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn {{[0-9]+}} never exits")
 int loop_detection(void *unused)
 {
 	struct num_context loop_ctx = { .i = 0 };
@@ -246,10 +246,9 @@ int bpf_loop_iter_limit_nested(void *unused)
 	/* This makes 'c' zero, but neither clang nor verifier know it. */
 	c /= 10;
 	/* Make sure that verifier does not visit 'impossible' states:
-	 * enumerate all possible callback visit masks.
+	 * one more call of any of the callbacks gives more than that.
 	 */
-	if (a != 0 && a != 1 && a != 11 && a != 101 && a != 111 &&
-	    b != 0 && b != 1 && b != 11 && b != 101 && b != 111)
+	if (a > 111 || b > 111)
 		asm volatile ("r0 /= 0;" ::: "r0");
 	return 1000 * a + b + c;
 }
@@ -291,9 +290,13 @@ static __naked void iter_limit_bug_cb(void)
 	);
 }
 
+/*
+ * may_goto doesn't leave the loop, so it's not what stops it. The address is greater than 10:
+ * the loop spins until may_goto that the verifier adds ends the prog.
+ */
 int tmp_var;
 SEC("socket")
-__failure __msg("infinite loop detected at insn 2")
+__success __retval(0)
 __naked void jgt_imm64_and_may_goto(void)
 {
 	asm volatile ("			\
@@ -310,7 +313,7 @@ l0_%=:	.byte 0xe5; /* may_goto */	\
 }
 
 SEC("socket")
-__failure __msg("infinite loop detected at insn 1")
+__success __retval(0)
 __naked void may_goto_self(void)
 {
 	asm volatile ("			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 795956bd4f9f..32bab3cb3fcb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2844,7 +2844,7 @@ __naked void merge_preserves_may_write(void)
 	"if r0 == 0 goto 1f;"
 	/* chain A: r2 = map value (ARG_NONE, not stack) */
 	"r1 = r10;"
-	"r1 += -16;"				/* unused fp anchor */
+	"r1 += -16;"				/* fp anchor */
 	"r2 = r0;"
 	"call mvs_mid;"
 	/* chain B: r2 = caller stack slot fp-8 */
@@ -2872,6 +2872,7 @@ static __used __naked void mvs_leaf(void)
 {
 	asm volatile (
 	"*(u64 *)(r2 + 0) = 42;"
+	"r0 = r1;"				/* a register that is not read is no argument */
 	"r0 = 0;"
 	"exit;"
 	::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c b/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
index 72646fa2745e..3f2a60f19319 100644
--- a/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
+++ b/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
@@ -32,8 +32,12 @@ char _license[] SEC("license") = "GPL";
 			"r1 += -" #off ";"	\
 			"call " #fn ";"
 
-/* 50 calls, each with a distinct FP offset: -8, -16, ... -400 */
+/*
+ * 50 calls, each with a distinct FP offset: -8, -16, ... -400.
+ * The function reads r1 first: a register that the callee doesn't read is no argument.
+ */
 #define CALLS_50(fn)							\
+	"r0 = r1;"							\
 	C(fn,   8) C(fn,  16) C(fn,  24) C(fn,  32) C(fn,  40)		\
 	C(fn,  48) C(fn,  56) C(fn,  64) C(fn,  72) C(fn,  80)		\
 	C(fn,  88) C(fn,  96) C(fn, 104) C(fn, 112) C(fn, 120)		\
@@ -50,6 +54,7 @@ __naked __noinline __used
 static unsigned long exp_sub7(void)
 {
 	asm volatile (
+		"r0 = r1;"
 		"r0 = 0;"
 		"exit;"
 		::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
index 0608e983d7fc..4f4e04d50bc7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -22,10 +22,10 @@ __success
 __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
-__msg("          2   3: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("      2   3: {{.*}} (95) exit")
 __naked void loop_single(void)
 {
 	asm volatile ("					\
@@ -43,13 +43,13 @@ __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("loop at 4{{$}}")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  2       0   1: {{.*}} (07) r0 += 1")
-__msg("  2   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
-__msg("          2   3: {{.*}} (b7) r1 = 0")
-__msg("  1       3   4: {{.*}} (07) r1 += 1")
-__msg("  1   4   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
-__msg("          5   6: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("      2   3: {{.*}} (b7) r1 = 0")
+__msg("      3   4: {{.*}} (07) r1 += 1")
+__msg("  4   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
+__msg("      5   6: {{.*}} (95) exit")
 __naked void loop_two_independent(void)
 {
 	asm volatile ("					\
@@ -70,13 +70,13 @@ __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")			/* outer loop header */
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")			/* outer loop insn */
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")			/* inner loop header */
-__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")	/* inner loop insn */
-__msg("  1   1   4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")	/* outer loop insn */
-__msg("          5   6: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")			/* outer loop header */
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")			/* outer loop insn */
+__msg("  1   2   3: {{.*}} (07) r1 += 1")			/* inner loop header */
+__msg("  3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")	/* inner loop insn */
+__msg("  1   4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")	/* outer loop insn */
+__msg("      5   6: {{.*}} (95) exit")
 __naked void loop_nested(void)
 {
 	asm volatile ("					\
@@ -95,12 +95,12 @@ SEC("socket")
 __success
 __log_level(2)
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32")
-__msg("          0   1: {{.*}} (25) if r0 > 0x0 goto pc+2")
-__msg("          1   2: {{.*}} (b7) r0 = 2")
-__msg("          2   3: {{.*}} (05) goto pc+1")
-__msg("          1   4: {{.*}} (b7) r0 = 3")
-__msg("          1   5: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (85) call bpf_get_prandom_u32")
+__msg("      0   1: {{.*}} (25) if r0 > 0x0 goto pc+2")
+__msg("      1   2: {{.*}} (b7) r0 = 2")
+__msg("      2   3: {{.*}} (05) goto pc+1")
+__msg("      1   4: {{.*}} (b7) r0 = 3")
+__msg("      1   5: {{.*}} (95) exit")
 __naked void fwd_edges_no_loop(void)
 {
 	asm volatile ("					\
@@ -123,16 +123,16 @@ __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("loop at 6, nested in 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
-__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
-__msg("  1   1   4   5: {{.*}} (b7) r2 = 0")
-__msg("  1   1   5   6: {{.*}} (07) r2 += 1")
-__msg("  1   6   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
-__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
-__msg("          8   9: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   2   3: {{.*}} (07) r1 += 1")
+__msg("  3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
+__msg("  1   4   5: {{.*}} (b7) r2 = 0")
+__msg("  1   5   6: {{.*}} (07) r2 += 1")
+__msg("  6   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
+__msg("  1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("      8   9: {{.*}} (95) exit")
 __naked void loop_nested_siblings(void)
 {
 	asm volatile ("					\
@@ -157,16 +157,16 @@ __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("loop at 5, nested in 3")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
-__msg("  1   3   3   4: {{.*}} (b7) r2 = 0")
-__msg("  1   3   4   5: {{.*}} (07) r2 += 1")
-__msg("  1   5   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
-__msg("  1   3   6   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
-__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
-__msg("          8   9: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   2   3: {{.*}} (07) r1 += 1")
+__msg("  3   3   4: {{.*}} (b7) r2 = 0")
+__msg("  3   4   5: {{.*}} (07) r2 += 1")
+__msg("  5   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
+__msg("  3   6   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
+__msg("  1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("      8   9: {{.*}} (95) exit")
 __naked void loop_three_levels(void)
 {
 	asm volatile ("					\
@@ -189,14 +189,14 @@ __success
 __log_level(2)
 __msg("loop at 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (bf) r1 = r0")
-__msg("  1   1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
-__msg("  1   1   3   4: {{.*}} (b7) r1 = 1")
-__msg("  1   1   3   5: {{.*}} (0f) r0 += r1")
-__msg("  1   1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
-__msg("          6   7: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (bf) r1 = r0")
+__msg("  1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
+__msg("  1   3   4: {{.*}} (b7) r1 = 1")
+__msg("  1   3   5: {{.*}} (0f) r0 += r1")
+__msg("  1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
+__msg("      6   7: {{.*}} (95) exit")
 __naked void loop_with_if_else(void)
 {
 	asm volatile ("					\
@@ -217,15 +217,15 @@ __success
 __log_level(2)
 __msg("loop at 3, irreducible")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
-__msg("          0   1: {{.*}} (b7) r1 = 0")
-__msg("          1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
-__msg("  1       2   3: {{.*}} (b7) r1 = 1")
-__msg("  1   3   3   4: {{.*}} (05) goto pc+1")
-__msg("          2   5: {{.*}} (b7) r1 = 2")
-__msg("  1   3   2   6: {{.*}} (0f) r0 += r1")
-__msg("  1   3   6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
-__msg("          7   8: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("      0   1: {{.*}} (b7) r1 = 0")
+__msg("      1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
+__msg("      2   3: {{.*}} (b7) r1 = 1")
+__msg("  3   3   4: {{.*}} (05) goto pc+1")
+__msg("      2   5: {{.*}} (b7) r1 = 2")
+__msg("  3   2   6: {{.*}} (0f) r0 += r1")
+__msg("  3   6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
+__msg("      7   8: {{.*}} (95) exit")
 __naked void loop_irreducible(void)
 {
 	asm volatile ("					\
@@ -244,10 +244,9 @@ __naked void loop_irreducible(void)
 }
 
 SEC("socket")
-__failure
+__success
 __log_level(2)
 __msg("loop at 1")
-__msg("infinite loop detected at insn 1")
 __naked void loop_self(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 6dd46edd8ed0..e8daf791b4c0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -120,7 +120,7 @@ BAD("down from a range, one unsigned test, one too many")
 LOOP(down_unsigned_range_bad, "if r7 > 2048 goto 9f;", "w7 += -1; if w7 < 2049 goto 1b;")
 
 /* below 0 a 32-bit counter is 0xffffffff for a 64-bit jump */
-BAD("down, a 64-bit test with a bound above 32 bits")
+NO_COUNT("down, a 64-bit test with a bound above 32 bits")
 LOOP(down_unsigned_wide_bound, "w8 = 2047; r9 = 0x100000800 ll;", "w8 += -1; if r8 < r9 goto 1b;")
 
 BAD("down, an unsigned and a signed 64-bit test")
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index 48a966cda199..18067907579e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -123,7 +123,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("infinite loop after a conditional jump")
-__failure __msg("program is too large")
+__failure __msg("loop at insn 2 never exits")
 __naked void loop_after_a_conditional_jump(void)
 {
 	asm volatile ("					\
@@ -135,10 +135,11 @@ l0_%=:	exit;						\
 "	::: __clobber_all);
 }
 
-SEC("tracepoint")
+SEC("xdp")
 __description("bounded recursion")
-__failure
-__msg("recursive call from")
+__arch_x86_64
+__arch_arm64
+__success __retval(4)
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
@@ -163,7 +164,7 @@ l0_%=:	call bounded_recursion__1;			\
 
 SEC("tracepoint")
 __description("infinite loop in two jumps")
-__failure __msg("loop detected")
+__failure __msg("loop at insn 1 never exits")
 __naked void infinite_loop_in_two_jumps(void)
 {
 	asm volatile ("					\
@@ -174,9 +175,10 @@ l0_%=:	if r0 < 4 goto l1_%=;				\
 "	::: __clobber_all);
 }
 
-SEC("tracepoint")
+/* It never ends on its own. may_goto that the verifier adds ends the prog. */
+SEC("xdp")
 __description("infinite loop: three-jump trick")
-__failure __msg("loop detected")
+__success __retval(0)
 __naked void infinite_loop_three_jump_trick(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 195b27a51224..2f4a678c31c2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -226,7 +226,8 @@ l0_%=:							\
 
 SEC("socket")
 __description("MOV32SX, S8, var_off u32_max")
-__failure __msg("infinite loop detected")
+__success __log_level(2)
+__msg("w7 = (s8)w3 {{.*}}R7=scalar({{.*}}smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))")
 __failure_unpriv __msg_unpriv("back-edge from insn 2 to 0")
 __naked void mov64sx_s32_varoff_1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 07c356fde68d..5e566933f7e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -8,6 +8,7 @@
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
+#include "bpf_compiler.h"
 
 #define COND_TEST(name, _initial, _step, _bound, msg, body)                     \
 SEC("xdp")                                                                      \
@@ -238,7 +239,7 @@ __naked void meet_agrees(void)
 }
 
 SEC("xdp")
-__failure
+__success __retval(0)
 __log_level(2)
 __msg_next("scev at header 1:")
 __msg_next("  r6=(any r6 (+ r6 1)) / ?")
@@ -1234,23 +1235,20 @@ RANGE_TEST(backedges_first_is_a_range, "", 0, 3, 1, 0, 2,
 RANGE_TEST(backedges_two_variables, "", 0, 3, 1, 0, 1,
 	   BACKEDGES("r6 += 1; r7 += 1", "r9 & 1", "r6 < 3", "r7 < 6"),
 	   __msg("header_count is [0..6] ") __msg("widening r6 to 0..8 "))
-/* Explore with a bound of 3 first, of 5 next. The second state is not equal to the first. */
+/* A bound of 3 and a bound of 5 are joined in front of the loop */
 #define PRECISE_BOUND(reg)									\
 	"r4 = 2; r5 = 2; " reg " = 5; if r7 == 0 goto +1; " reg " = 3; r0 = 0;"		\
 	BACKEDGES("r6 += 1", "r9 & 1", "r6 < r4", "r6 < r5")
-#define EXPLORED_TWICE										\
-	__flag(BPF_F_TEST_STATE_FREQ)								\
-	__msg("header_count is [0..3] ") __msg("header_count is [0..5] ")
-RANGE_TEST(backedges_bound1_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r4"), EXPLORED_TWICE)
-RANGE_TEST(backedges_bound0_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r5"), EXPLORED_TWICE)
+#define EXPLORED_ONCE	__msg("header_count is [0..5] ") __not_msg("header_count is [0..3] ")
+RANGE_TEST(backedges_bound1_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r4"), EXPLORED_ONCE)
+RANGE_TEST(backedges_bound0_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r5"), EXPLORED_ONCE)
 
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 10 ")
 __msg("loop header at 1, widening r0 to 0..9 step 1")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jlt(void)
 {
 	asm volatile ("					\
@@ -1262,8 +1260,8 @@ __naked void post_cond_jlt(void)
 }
 
 /*
- * Explore with r7=10 first, r7=4096 next.
- * Should trigger invalid stack read if r7 is marked precise.
+ * r7 is 10 on one path to the loop and 4096 on the other.
+ * Should trigger invalid stack read if the larger one counts.
  *
  *   r0 = 0;
  *   r6 = 0;
@@ -1278,11 +1276,7 @@ __naked void post_cond_jlt(void)
 SEC("xdp")
 __failure
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("loop header at 6, header_count is 10 ")
-__msg("mark_precise: frame0: parent state regs=r6,r7 stack=:")
-__msg("loop header at 6, widening r0 to 0..9 step 1")
-__msg("loop header at 6, header_count is 4096 ")
+__msg("loop header at 6, header_count is [0..4096] ")
 __msg("loop header at 6, widening r0 to 0..4095 step 1")
 __msg("invalid variable-offset read from stack R2")
 __naked void mark_bound_precise(void)
@@ -1308,8 +1302,8 @@ __naked void mark_bound_precise(void)
 }
 
 /*
- * Explore with r6=4086 first, r6=0 next.
- * Should trigger invalid stack read if r6 is marked precise.
+ * r6 is 4086 on one path to the loop and 0 on the other.
+ * Should trigger invalid stack read if the smaller one counts.
  *
  *   r0 = 0;
  *   r6 = bpf_get_prandom_u32() == 42 ? 4086 : 0;
@@ -1323,11 +1317,7 @@ __naked void mark_bound_precise(void)
 SEC("xdp")
 __failure
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("loop header at 5, header_count is 10 ")
-__msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("loop header at 5, widening r0 to 0..9 step 1")
-__msg("loop header at 5, header_count is 4096 ")
+__msg("loop header at 5, header_count is [0..4096] ")
 __msg("loop header at 5, widening r0 to 0..4095 step 1")
 __msg("invalid variable-offset read from stack R2")
 __naked void mark_base_precise(void)
@@ -1541,7 +1531,7 @@ __msg("scev at header 1:")
 __msg_next("r6=(+ r6 1) / (linear r6 1)")
 __msg_next("*fp-8=(any *fp-8 7) / (any *fp-8 7)")
 __msg("loop header at 1, widening r6 to 0..2 step 1")
-__msg("2: (7a) *(u64 *)(r10 -8) = 7          ; R10=fp0 fp-8=7 loop_stack=1")
+__msg("3: (79) r0 = *(u64 *)(r10 -8)         ; R0=scalar() R10=fp0 loop_stack=1")
 __naked void widen_any_unallocated_slot(void)
 {
 	asm volatile ("					\
@@ -1819,11 +1809,10 @@ BOUND_IN_MAP_TEST(bound_in_data, data_bound, 16)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 3, header_count is 8")
 __msg("loop header at 3, widening r0 to 2..9 step 1")
 __msg("3: R0=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=9,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void post_cond_jlt_with_base(void)
 {
 	asm volatile ("					\
@@ -1910,11 +1899,10 @@ NO_ZEXT32_TEST(arsh_by_32, 0x7ffffffe, "r7 <<= 32; r7 s>>= 32;")
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 11")
 __msg("loop header at 1, widening r0 to 0..10 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=10,{{.*}})")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jle(void)
 {
 	asm volatile ("					\
@@ -1928,11 +1916,10 @@ __naked void post_cond_jle(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 10")
 __msg("loop header at 1, widening r0 to 0..9 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=9,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void post_cond_jge(void)
 {
 	asm volatile ("					\
@@ -1947,11 +1934,10 @@ __naked void post_cond_jge(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 11")
 __msg("loop header at 1, widening r0 to 0..10 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=10,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void pre_cond_jge(void)
 {
 	asm volatile ("					\
@@ -1966,7 +1952,6 @@ __naked void pre_cond_jge(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next(" scev at latch 2:")
@@ -1975,10 +1960,9 @@ __msg("loop header at 1, widening r0")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,{{.*}})")
 __msg("1: (07) r0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("2: (55) if r0 != 0x3 goto pc-2")
-__msg("3: (95) exit")
 __msg("loop header at 1, clamping r0")
-__msg("from 2 to 1: safe")
-__msg("processed 5 insns")
+__msg("3: (95) exit")
+__msg("processed 4 insns")
 __naked void post_cond_jne(void)
 {
 	asm volatile ("					\
@@ -1992,16 +1976,15 @@ __naked void post_cond_jne(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 -1) / (linear r0 -1)")
 __msg_next(" scev at latch 2:")
 __msg_next("  r0=(+ r0 -1) / (linear (+ r0 -1) -1)")
 __msg("loop header at 1, header_count is 3 ")
 __msg("loop header at 1, widening r0 to 1..3 step 1")
-__msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) loop_stack=1")
+__msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) R10=fp0 loop_stack=1")
 __msg("loop header at 1, clamping r0 to 1..3 step 1")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jne_neg_step(void)
 {
 	asm volatile ("					\
@@ -2025,7 +2008,7 @@ __msg("loop header at 2, widening r1 to 0..4 step 1")
 __msg("loop header at 2, widening r3 to 0..4 step 1")
 __msg("3: (55) if r3 != 0x5 goto pc+1 {{.*}}; R3=5")
 __msg("loop header at 2, clamping r3 to 0..4 step 1")
-__msg("from 6 to 2: safe")
+__msg("from 6 to 2: within")
 __naked void clamp_dependent_overshoot(void)
 {
 	asm volatile ("					\
@@ -2051,7 +2034,7 @@ __msg("loop header at 2, widening r1 to 0..4 step 1")
 __msg("loop header at 2, widening r3 to 0..4 step 1")
 __msg("3: (56) if w3 != 0x5 goto pc+1 {{.*}}; R3=5")
 __msg("loop header at 2, clamping r3 to 0..4 step 1")
-__msg("from 6 to 2: safe")
+__msg("from 6 to 2: within")
 __naked void clamp_dependent_overshoot32(void)
 {
 	asm volatile ("					\
@@ -2070,7 +2053,6 @@ __naked void clamp_dependent_overshoot32(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next(" scev at latch 1:")
@@ -2081,11 +2063,10 @@ __msg("1: (15) if r0 == 0x3 goto pc+2        ; R0=scalar(smin=smin32=0,smax=umax
 __msg("2: (07) r0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("3: (05) goto pc-3")
 __msg("loop header at 1, clamping r0")
-__msg("1: safe")
 __msg("from 1 to 4: R0=3")
 __msg("4: R0=3")
 __msg("4: (95) exit")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void pre_cond_je1(void)
 {
 	asm volatile ("					\
@@ -2100,7 +2081,6 @@ __naked void pre_cond_je1(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(zext32 (+ r0 1)) / (zext32 (linear r0 1))")
 __msg_next(" scev at latch 2:")
@@ -2109,10 +2089,9 @@ __msg("loop header at 1, widening r0")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,{{.*}})")
 __msg("1: (04) w0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("2: (56) if w0 != 0x3 goto pc-2")
-__msg("3: (95) exit")
 __msg("loop header at 1, clamping r0")
-__msg("from 2 to 1: safe")
-__msg("processed 5 insns")
+__msg("3: (95) exit")
+__msg("processed 4 insns")
 __naked void post_cond_jne32(void)
 {
 	asm volatile ("					\
@@ -2386,7 +2365,6 @@ __naked void loop_around_301_exits(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 11:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next("  r1=(+ r1 2) / (linear r1 2)")
@@ -2396,18 +2374,15 @@ __msg_next("  r1=(+ r1 2) / (linear (+ r1 2) 2)")
 __msg("loop header at 11, widening r0")
 __msg("loop header at 11, widening r1")
 __msg("11: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7)) R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=14,var_off=(0x0; 0xe),step=0+2)")
-/* loop exit */
 __msg("16: (a5) if r0 < 0x8 goto pc-6")
-__msg("exiting loop 11")
-__msg("17: (95) exit")
 /* second iteration */
 __msg("loop header at 11, clamping r0")
 __msg("loop header at 11, clamping r1")
 /* iteration convergence */
-__msg("from 16 to 11: safe")
 __not_msg("{{^}}11:")
-/* map lookup error path */
-__msg("from 7 to 17: safe")
+/* loop exit */
+__msg("exiting loop 11")
+__msg("17: (95) exit")
 __naked void correlated_regs(void)
 {
 	asm volatile ("					\
@@ -2441,15 +2416,14 @@ __naked void correlated_regs(void)
  *     k += 1
  *     k <<= 1   // make SCEV construction not possible
  *     k >>= 1
- * map[k] = 1    // make k precise
+ * map[k] = 1    // k has to be known
  */
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("19: (72) *(u8 *)(r4 +0) = 1           ; R4=map_value(id={{.*}},map=map,ks=4,vs=1024,imm=16)")
 __not_msg("19: ")
-__msg("processed 106 insns")
+__msg("processed 105 insns")
 __naked void nested_loops_precise_var1(void)
 {
 	asm volatile ("					\
@@ -2488,8 +2462,7 @@ __log_level(2)
 __msg("loop header at 2, header_count is 100 ")
 __msg("loop header at 4, header_count is [0..100] ")
 __msg("loop header at 6, header_count is [0..100] ")
-__msg("processed 20 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 14 insns")
 __naked void nested_loop_with_two_exits(void)
 {
 	asm volatile ("					\
@@ -2550,14 +2523,14 @@ __msg("loop at 5")
 __msg("loop at 6, nested in 5")
 __msg("loop at 11, irreducible")
 __msg("loop at 12, nested in 11")
-/* entry via if r0 == 5 goto d_%= false branch */
+/* entry via if r0 == 5 goto d_%= true branch */
 __msg("loop header at 12, header_count is 3 ")
 __msg("loop header at 12, widening r9 to 0..2 step 1")
-__msg("12: R8=1 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) loop_stack=11,12")
-/* entry via if r0 == 5 goto d_%= true branch */
+/* entry via if r0 == 5 goto d_%= false branch */
 __msg("loop header at 12, header_count is 3 ")
 __msg("loop header at 12, widening r9 to 0..2 step 1")
-__msg("from 8 to 12: R8=0 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 loop_stack=11,12")
+__msg("12: R8=0 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 iter(11)=0 loop_stack=11,12")
+__msg("12: R8=1 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 iter(11)=0 loop_stack=11,12")
 __naked void enter_nested_loop_from_side(void)
 {
 	asm volatile ("					\
@@ -3037,7 +3010,7 @@ __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 3, widening r6 to 0..9 step 1")
 __msg("loop header at 3, clamping r6 to 0..9 step 1")
-__msg("12: safe")
+__msg("from 12 to 6: within")
 __naked void clamp_callee_state_pruning(void)
 {
 	asm volatile ("					\
@@ -3204,11 +3177,14 @@ RANGE_TEST(spill32_first_is_a_range, "", 0, 3, 1, 6, 6,
 RANGE_TEST(spill32_first_is_a_range_pre, "", 0, 3, 1, 6, 6,
 	   SPILL32_LOOP(SPILL32_LOAD "if r1 >= r7 goto 2f;" SPILL32_INC "goto 1b;"),
 	   SPILL32_COUNTED(7, "0..6"))
-/* Explore with 2 in the slot first, with 0 next. The second state is not equal to the first. */
+/* 2 and 0 in the slot are joined in front of the loop */
 RANGE_TEST(spill32_first_is_precise, "", 0, 0, 1, 0, 1,
 	   "if r7 == 0 goto +1; r6 = 2;" SPILL32_LOOP(SPILL32_INC "if w1 != 5 goto 1b;"),
-	   __flag(BPF_F_TEST_STATE_FREQ)
-	   __msg("header_count is [0..3] ") __msg("header_count is [0..5] "))
+	   __msg("header_count is [0..5] ") __not_msg("header_count is [0..3] "))
+/* The slot holds 64 bits when the loop starts. Nothing reads the high half: it's dead. */
+RANGE_TEST(spill32_first_is_64bit, "", 0, 0, 1, 5, 5,
+	   "*(u64 *)(r10 - 8) = r6; 1:" LIMIT_ITERATIONS SPILL32_INC "if w1 != w7 goto 1b;",
+	   SPILL32_COUNTED(5, "0..4"))
 /* The counter makes the address of a spill. Such a loop is not summarized, as with a register. */
 PARTIAL_SPILL_TEST(spill32_is_a_stack_offset, u32, 4,
 	"can't widen *fp-8, expr is (spill32 (+ *fp-8 8)), requires exact stack-offset tracking",
@@ -3224,11 +3200,7 @@ PARTIAL_SPILL_TEST(spill32_unknown_is_a_stack_offset, u32, 1000000,
 /* A step above S16_MAX has no range, as with a register */
 PARTIAL_SPILL_TEST(spill32_large_step, u32, 4, "can't widen *fp-8, expr is (spill32 ",
 	SPILL32_0, SPILL32_LOAD "w1 += 0x8000; *(u32 *)(r10 - 8) = r1;")
-/* No formula: the slot holds 64 bits when the loop starts, */
-RANGE_TEST(spill32_first_is_64bit, "", 0, 0, 1, 5, 5,
-	   "*(u64 *)(r10 - 8) = r6; 1:" LIMIT_ITERATIONS SPILL32_INC "if w1 != w7 goto 1b;",
-	   NO_COUNT)
-/* the load extends the sign, */
+/* No formula: the load extends the sign, */
 RANGE_TEST(spill32_sext_load, "", 0, 0, 1, 5, 5,
 	   SPILL32_LOOP(SPILL32_INC "r1 = *(s32 *)(r10 - 8); if r1 != r7 goto 1b;"), NO_COUNT)
 /* the sum is made from a different slot. */
@@ -4299,12 +4271,23 @@ exit_%=:						\
  *        } while (r8 < 3);
  *    }
  *    return 0;
+ *
+ * The outer loop gets may_goto in front of the jump that leaves it, the inner loop doesn't.
+ * At run time it's may_goto that ends the prog.
  */
 SEC("xdp")
-__failure
-__log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("The sequence of 8193 jumps is too complex.")
+__success __retval(0)
+__xlated("call unknown")
+__xlated("...")
+__xlated("if r0 == 0x2a goto pc+4")
+__xlated("r8 = 0")
+__xlated("r8 += 1")
+__xlated("if r8 < 0x3 goto pc-2")
+__xlated("goto pc-{{[0-9]+}}")
+__xlated("r0 = 0")
+__xlated("exit")
+__xlated("r0 = 0")
+__xlated("exit")
 __naked void nested_terminating_prune(void)
 {
 	asm volatile ("					\
@@ -4679,7 +4662,7 @@ __naked void widen_pkt_pointer_negative_offset(void)
 
 /* The access is in the second iteration only: the verifier gets to it after the clamp */
 SEC("tc")
-__failure __msg("invalid access to packet, off=56 size=2, R6(id=3,off=56,r=56)")
+__failure __msg("invalid access to packet, off=56 size=2, R6(id={{[0-9]+}},off=56,r=56)")
 __naked void clamp_pkt_pointer_step_lowers_umax(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
index 8f6082fdb5c8..e7636b86cc29 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
@@ -127,13 +127,13 @@ static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
 SEC("?raw_tp")
 __success __log_level(4)
 /*
- * self: 9 + 7 + 2 = 18
- * totals: leaf 2, scheduler 7, main root 18
+ * self: 8 + 7 + 2 = 17
+ * totals: leaf 2, scheduler 7, main root 17
  */
-__msg("subprog 0 (stats_async_direct) main insns_self 9 insns_total 18 stack 0")
+__msg("subprog 0 (stats_async_direct) main insns_self 8 insns_total 17 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_leaf) static insns_self 2 insns_total 2 stack 0")
-__msg("processed 18 insns")
+__msg("processed 17 insns")
 __naked int stats_async_direct(void)
 {
 	asm volatile (
@@ -194,14 +194,14 @@ static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
 SEC("?raw_tp")
 __success __log_level(4)
 /*
- * self: 9 + 7 + 7 + 2 = 25
- * totals: leaf 2, outer 7, scheduler 7, main root 25
+ * self: 8 + 7 + 7 + 2 = 24
+ * totals: leaf 2, outer 7, scheduler 7, main root 24
  */
-__msg("subprog 0 (stats_async_nested) main insns_self 9 insns_total 25 stack 0")
+__msg("subprog 0 (stats_async_nested) main insns_self 8 insns_total 24 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_outer) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_nested_leaf) static insns_self 2 insns_total 2 stack 0")
-__msg("processed 25 insns")
+__msg("processed 24 insns")
 __naked int stats_async_nested(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index 42b90b692dc5..5ba41dca35ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -148,6 +148,33 @@ __naked void tail_call_caller_stack_ok(void)
 "	::: __clobber_all);
 }
 
+static __noinline int tail_calls(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return skb->len;
+}
+
+static __noinline int calls_itself(struct __sk_buff *skb, int n)
+{
+	int ret = 0;
+
+	if (n)
+		ret = calls_itself(skb, n - 1);
+	return ret + tail_calls(skb);
+}
+
+/* The frames of a subprog that calls itself stay on the stack too: up to a half of it. */
+SEC("tc")
+__description("tail call from subprog below a recursive subprog")
+__arch_x86_64
+__arch_arm64
+__failure
+__msg("tail_calls are not allowed when call stack of previous frames is {{[0-9]+}} bytes")
+int tail_call_below_recursion(struct __sk_buff *skb)
+{
+	return calls_itself(skb, 2);
+}
+
 SEC("tc")
 __description("tail call from subprog with 256 bytes of caller stack")
 __failure
diff --git a/tools/testing/selftests/bpf/progs/verifier_uninit.c b/tools/testing/selftests/bpf/progs/verifier_uninit.c
index 691018a46049..345223a4525b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_uninit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_uninit.c
@@ -9,7 +9,7 @@
 SEC("socket")
 __description("read uninitialized register")
 __failure __msg("R2 !read_ok")
-__msg("R2 has never been initialized on this path")
+__msg("R2 is not readable here. It may never have been initialized")
 __failure_unpriv
 __naked void read_uninitialized_register(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index b9d96366e656..87aeef7545a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -394,8 +394,8 @@ __naked void fill_of_different_pointers_stx(void)
 	r2 = r10;					\
 	r2 += -16;					\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	*(u32*)(r1 + %[__sk_buff_mark]) = r3;		\
 	r0 = 0;						\
@@ -420,8 +420,8 @@ __naked void fill_of_different_pointers_st(void)
 	r2 = r10;					\
 	r2 += -16;					\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	.8byte %[st_mem];				\
 	r0 = 0;						\
@@ -435,7 +435,8 @@ l1_%=:	r1 = *(u64*)(r6 + 0);				\
 
 SEC("tc")
 __description("unpriv: spill/fill of different pointers stx - ctx and sock")
-__failure __msg("type=ctx expected=sock")
+/* bpf_sk_release(skb) is an error too: "type=ctx expected=sock". This one is found first. */
+__failure __msg("R1 invalid mem access 'sock_or_null'")
 __naked void pointers_stx_ctx_and_sock(void)
 {
 	asm volatile ("					\
@@ -449,10 +450,10 @@ __naked void pointers_stx_ctx_and_sock(void)
 	r6 += -8;					\
 	r1 = r8;					\
 	/* if (skb == NULL) *target = sock; */		\
-	if r1 == 0 goto l0_%=;				\
+	if r1 != 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = skb; */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	/* struct __sk_buff *skb = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -490,10 +491,10 @@ __naked void different_pointers_stx_leak_sock(void)
 	r6 += -8;					\
 	r1 = r8;					\
 	/* if (skb == NULL) *target = sock; */		\
-	if r1 == 0 goto l0_%=;				\
+	if r1 != 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = skb; */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	/* struct __sk_buff *skb = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -526,8 +527,8 @@ __naked void stx_sock_and_ctx_read(void)
 	/* if (skb) *target = skb */			\
 	if r1 == 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = sock */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
 l1_%=:	/* struct bpf_sock *sk = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -565,8 +566,8 @@ __naked void stx_sock_and_ctx_write(void)
 	/* if (skb) *target = skb */			\
 	if r1 == 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = sock */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
 l1_%=:	/* struct bpf_sock *sk = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
index 4d77407a0a79..5363093a4a5c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
@@ -17,8 +17,8 @@ __naked void fill_of_different_pointers_ldx(void)
 	r2 = r10;					\
 	r2 += %[__imm_0];				\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	r1 = *(u64*)(r1 + %[sample_period]);		\
 	r0 = 0;						\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index f9d71e01ddf4..bb2b9e8c71df 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -455,8 +455,47 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "recursive call",
+	.errstr = "calls itself",
+	.result = REJECT,
+},
+{
+	"calls: a timer callback calls the main prog",
+	.insns = {
+	/* bpf_timer_set_callback(bpf_map_lookup_elem(&timer_map, &(int){0}), cb); */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 4),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_EMIT_CALL(BPF_FUNC_timer_set_callback),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* cb */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -14),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_timer = { 3 },
+	.errstr = "recursive call of the main program",
 	.result = REJECT,
+	/* libbpf makes the main prog global, and then the arguments of the call do not match */
+	.func_info = { { 0, 4 /* main_prog */ }, { 13, 5 /* cb */ } },
+	.func_info_cnt = 2,
+	.btf_strings = "\0int\0ctx\0main_prog\0cb",
+	.btf_types = {
+	/* 1: int            */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	/* 2: void*          */ BTF_PTR_ENC(0),
+	/* 3: int __(void *) */ BTF_FUNC_PROTO_ENC(1, 1),
+				BTF_FUNC_PROTO_ARG_ENC(5, 2),
+	/* 4: main_prog      */ BTF_FUNC_ENC(9, 3),
+	/* 5: cb             */ BTF_FUNC_ENC(19, 3),
+	BTF_END_RAW
+	}
 },
 {
 	"calls: conditional call",
@@ -559,8 +598,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "infinite loop detected",
-	.result = REJECT,
+	.result = ACCEPT,
 },
 {
 	"calls: using r0 returned by callee",
@@ -812,7 +850,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "recursive call",
+	.errstr = "calls itself",
 	.result = REJECT,
 },
 {
-- 
2.55.0

