Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937306;
	b=GPxxrooY6ST/lTiGfJIgR9BUAukRmTIzDffGn6S5jYlqux/juvXiqgolPxWMeClR5KxO
	 w7ALJ3An9mCkjFODiIM6CsFeIM9FreKPIVj3M3K2Pu3AYwLp5dnxSkD5g4Are6q1D0xjY
	 8IpUz9jS+vJcp69wvzQeE/mlPc0qBUz4IkZr24dJDrOs3jhMCohjZrwzltZHsLxUNgwLu
	 9DO7f2WXlnEJjgU9LePYTUiFQfcYYjdmKFs0Il7eAD9JV5D+Tgr6n5PjiEgPOFOXVeJNy
	 k6D5ntP/2sHMGkAtAsWFPge6ACSynhPTZBDNnyWKosf9Pn4fbm/4xsvewZBzIGkI6tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gPX8r1hfQ09/Ikr09i+UqcLglCN5rIS7SNhqyT87dfc=;
	b=aZxumGaSb1kppD+7rje/Z+L/09xbsgsKobwSDDArOu7PIFpbhri03XsbypRadr6GWnLF
	 YPk7guxkApLDoDjPWNOrqP7o6hEwt+ukW4wmFoBKxfhN2GUHk7Ry7ZYpufD6YZjn0pwXW
	 Sm8fFUKgKk9QactqKK8HVhCQmJmGgX5UW6uS2m9zreFNOaLKBl5PmQDs9PMDwpDEHBuk4
	 iv/mrsQmmYPgLG6dUdjN13vbr8cqzO+5vYh0CO/IsSMjdNQH0Qy7I+LoeIYyKgWg6kH3/
	 NrWuTjMOveBQE8nudYDjdVJI2xnQQDIsUL0NtPpUz5Ed+CnDslKrMrGSK7CrNq61QJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i3k7bUhd;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3649606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3649606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i3k7bUhd
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89f85edd210so69526b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937304; x=1794542104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gPX8r1hfQ09/Ikr09i+UqcLglCN5rIS7SNhqyT87dfc=;
        b=i3k7bUhd20RIbmxz2ny8amN+UZ/PFJuA4a+dwX3AYtfFZQdkNsG1Sy0hPH5Zc+RKji
         VCYf337JMyRmuuRo9XnPPZjUFIyhGLUYEBC/6hMCtPgU+R7ZKGbAo47xJtkIaHMlCh97
         VVo7XhzZ0Z7S/cm+5dQZdbFZ7sfhpCAuQU0Ianj4rm/1hDX02iyOxswuDW8VktMH7XzQ
         WVwLhhkc24lGTA9vIgoinV9br+/yiomUDjmbJRi/Pkl5Mh1modmoGtQs+qzyrnBQG2cN
         v0xh7kkQVn/KLwOzWLhNBgH9LBrbamR9JTA6WbVu69DItKbJ1GANwhGD06SoeoPD3yKW
         4g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937304; x=1794542104;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPX8r1hfQ09/Ikr09i+UqcLglCN5rIS7SNhqyT87dfc=;
        b=OzAACJ1DIR/9RCoWQ3+9TLjD0Ww4iDesLTtJaJ+/lVGxYLjxdOm9vDR+/lMcjA6nYS
         T43i/Q6WhKbWFo0R5CDDrITf2vaPxJ6oHRggTXXmH4AM2kaRq3NT5sbUtq2laU9yt+ze
         xIe7MFSKvCBcHHziheJ8PyASch9lmBAdgqLY94FQK0jrk3nvvmKrsP45jUp5JDdOUe2p
         YOQuGkiVATYG5IRnHLvh6R0nR6NI8kJQ2o3Wg/FEYoyG776yu/MLt75stc8DRQ4S0GKj
         OAETlrKvw/IaHrL60te5GW/4KBHIxMH3hJD3lK+gcbG/cXsUz77Zz7Dk2ipsty99J/MF
         rCWw==
X-Gm-Message-State: APuU4Z8riWQWUXpYG0G5vMSGOY9tkvdBHHfbd2ZTKqLXYygVufc8pVKw
	YIg/HL6/Z21nJdBnJWmgLGO1cia5HEpK7mv+gzwlJRsrEc/ceQkBEGnWnfIDJg==
X-Gm-Gg: AYBFou3nmTACinPzIwMir9qSwnlIvjbUyeg5SZNVg/GIQid2TaeuuFqHako3DGEpNNY
	ixCcYSHTmaUH/NmrbuFFSpoEMyHN3e8+5U4zANMeW/+TVx87ZFkDAtnFRWB4Mg5oU4eGTz28bCG
	O1R3wW/VioCdTlX5eINNNKldGFsAeMMJJb5mq1b3oxUOLHPWUntPo1MdjL3qMtNVr3QDh3YRSR5
	jqrDGGZSgqIkJDAEzBImpynGek24SMctfZMP+7LeytDBiPT7T4Ven1oa27ouuPcbnyb/Xw3PCP2
	2gcuVCx2eGHRprF7buzO6QMPfH9RkSxDq4Gqn+KcfqeaRXEsB7lz5HNyTlHfniGlaP+oDHAcPWo
	B6OCNg/CLAP6gYX57ARyzJ1G8TGSJUr2sbfzXc1l41d39JpAQbWZ6CBi2/qU81nauX3v05fR//a
	0s2kmjPy9bnk5Z5uGcqYyZkVhk6C/jM1De3iJakoe9haC1iojO3/vsoMiCGfEEUpZfxV/r5oGzr
	FoH9kNqbSe60Mydj4zss/Pi8fdLEAY+x/4sochSWSVTPrklg0aqfbO5zBtwnSjxpR+yWMlzbBKF
	0AfKhuXriFkz9cQRuxw1fjSZNHQ70zU0lOP1WRPNG0upxfSsZUSbw8xio23ZRIEDuI9Zf6l2kdd
	Qe69qGX9ToRpDQp5XbyHKAdZpz9G6bksOaXnoQSUQkmADtwg8dhwOJFkUCX+zjnwfOYt28t3uVQ
	==
X-Received: by 2002:a17:90b:2ccf:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3b0db6ee7c5mr1090439a91.28.1793937302299;
        Thu, 05 Nov 2026 19:55:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7cb447esm1493692a91.17.2026.11.05.19.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:55:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 39/45] selftests/bpf: Adjust tests to log lines that are gone
Date: Fri,  6 Nov 2026 03:51:03 +0000
Message-ID: <20261106035111.3315285-40-alexei.starovoitov@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Without this patch 114 subtests of test_progs and 4 tests of test_verifier
fail. Their progs get the old verdict, but the tests match lines of the
verifier log that the kernel does not print any more. Keep the progs. Match
the line of the new log that shows the same fact.

  [P] "bpf: Remove precision tracking"
  [V] "bpf: Remove is_state_visited(), bpf_compute_scc() and iter.depth"
  [F] "bpf: Verify programs as a fixpoint over the control flow graph"

  the tests matched        they match now
  -----------------------  ------------------------------------------------
  [P] "mark_precise: ..",  The value of the scalar where the prog uses it:
  462 lines                "R2=-8".
  [V] "N: safe", 23 lines  "from M to N: within". If no state covers the
                           other one: "joined", and the join.
  [F] "id=1" of a scalar,  No id: the verifier clears an id that only one
  12 lines                 live register has.

The first row is verifier_precision.c, _subprog_precision.c, _spill_fill.c,
_scalar_ids.c, stack_arg_precision.c and verifier/precise.c. The second row
is verifier_bounds_step.c, _search_pruning.c, _live_stack.c: the tests of
regsafe(), stacksafe() and range_within(). The target of a jump is verified
before the fall-through. Thus the tests in which the first of two states
must cover the second one swap their branches.

Three verdicts change. short_loop1 was "too large". Now one state at the
loop head covers all iterations, and it loads. 2 unprivileged progs of
verifier_value_ptr_arith.c load: r1 = [0, 3] and r1 = [0, 7] are joined in
front of 'r1 += r0', and the insn gets one limit for its mask. 8 progs are
rejected as before, with a different message. BPF_F_TEST_STATE_FREQ has no
effect. Remove it from the tests that change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/aggregate_ret_func.c  |  15 -
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |   7 -
 .../testing/selftests/bpf/progs/dynptr_fail.c |   4 +-
 .../selftests/bpf/progs/exceptions_assert.c   |  24 +-
 .../selftests/bpf/progs/stack_arg_precision.c |  48 +--
 .../selftests/bpf/progs/test_global_func15.c  |   5 -
 .../bpf/progs/verifier_array_access.c         |  14 +-
 .../bpf/progs/verifier_bounds_deduction.c     |   2 +-
 .../bpf/progs/verifier_bounds_step.c          |  73 ++--
 .../bpf/progs/verifier_linked_scalars.c       |   7 +-
 .../selftests/bpf/progs/verifier_live_stack.c |  34 +-
 .../bpf/progs/verifier_map_ret_val.c          |   2 +-
 .../bpf/progs/verifier_mem_size_reg.c         |   8 +-
 .../selftests/bpf/progs/verifier_precision.c  | 186 +++------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 329 +++++-----------
 .../bpf/progs/verifier_search_pruning.c       |  40 +-
 .../selftests/bpf/progs/verifier_spill_fill.c | 224 ++++-------
 .../selftests/bpf/progs/verifier_spin_lock.c  |   4 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  13 +-
 .../bpf/progs/verifier_subprog_precision.c    | 353 +++---------------
 .../bpf/progs/verifier_value_or_null.c        |   2 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |   6 +-
 .../selftests/bpf/progs/verifier_var_off.c    |   3 -
 .../testing/selftests/bpf/verifier/precise.c  |  69 +---
 24 files changed, 399 insertions(+), 1073 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
index f0077d951a25..2671323255cd 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -121,14 +121,6 @@ static __naked __noinline u128 static_agg_precise(void)
 SEC("tc")
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (95) exit")
-__msg("mark_precise: frame1: regs=r2 stack= before 11: (b7) r2 = 4")
 __naked int aggregate_ret_static_precise(void)
 {
 	asm volatile (
@@ -150,13 +142,6 @@ __naked int aggregate_ret_static_precise(void)
 SEC("tc")
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (85) call pc+9")
 __naked int aggregate_ret_global_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
index 0361a7b42c9b..102156175ba0 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -31,13 +31,6 @@ SEC("tc")
 __arch_x86_64 __arch_arm64
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (85) call bpf_kfunc_call_test_i128")
 __naked int aggregate_ret_kfunc_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 3770ffdeaaaa..c6b239b78325 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -127,7 +127,7 @@ static int missing_release_callback_fn(__u32 index, void *data)
 
 /* A callback cannot return with the last dynptr for a referenced resource. */
 SEC("?raw_tp")
-__failure __msg("cannot overwrite referenced dynptr")
+__failure __msg("Unreleased reference id=1")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
@@ -782,7 +782,7 @@ int dynptr_pruning_overwrite(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__success __msg("12: safe") __log_level(2)
+__success __msg("to 12: within") __log_level(2)
 int dynptr_pruning_stacksafe(struct __sk_buff *ctx)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index e4abf4172fca..67b51f728af2 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -29,32 +29,32 @@ check_assert(s64, ==, eq_llong_min, LLONG_MIN);
 __msg("R{{.}}=0x7fffffffffffffff")
 check_assert(s64, ==, eq_llong_max, LLONG_MAX);
 
-__msg("R{{.}}=scalar(id=1,smax=0x7ffffffe)")
+__msg("R{{.}}=scalar(smax=0x7ffffffe)")
 check_assert(s64, <, lt_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, <, lt_zero, 0);
-__msg("R{{.}}=scalar(id=1,smax=0xffffffff7fffffff")
+__msg("R{{.}}=scalar(smax=0xffffffff7fffffff")
 check_assert(s64, <, lt_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smax=0x7fffffff)")
+__msg("R{{.}}=scalar(smax=0x7fffffff)")
 check_assert(s64, <=, le_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smax=0)")
+__msg("R{{.}}=scalar(smax=0)")
 check_assert(s64, <=, le_zero, 0);
-__msg("R{{.}}=scalar(id=1,smax=0xffffffff80000000")
+__msg("R{{.}}=scalar(smax=0xffffffff80000000")
 check_assert(s64, <=, le_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_zero, 0);
-__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000001")
+__msg("R{{.}}=scalar(smin=0xffffffff80000001")
 check_assert(s64, >, gt_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_zero, 0);
-__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000000")
+__msg("R{{.}}=scalar(smin=0xffffffff80000000")
 check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index c9564776d733..6c6f58a67eff 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -23,7 +23,7 @@ int __btf_kfunc_gen(struct __sk_buff *ctx)
 }
 
 /*
- * Test precision backtracking across bpf-to-bpf call for kfunc stack arg.
+ * Test that the range of a stack arg is known across bpf-to-bpf call for kfunc stack arg.
  * subprog_call_mem_kfunc receives a size as incoming stack arg (arg6)
  * and forwards it as mem__sz (arg7) to bpf_kfunc_call_stack_arg_mem.
  */
@@ -52,52 +52,12 @@ static long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long
 }
 
 SEC("tc")
-__description("stack_arg: precision backtracking across bpf2bpf call for kfunc")
+__description("stack_arg: range across bpf2bpf call for kfunc")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 9 to 11: joined")
+__msg("13: (79) r1 = *(u64 *)(r11 +8)        ; R1=scalar(smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=6,var_off=(0x4; 0x2),step=0+2)")
 __btf_func_path("btf__stack_arg_precision.bpf.o")
-__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1")
-__msg("mark_precise: frame1: regs= stack= before 25: (b7) r5 = 5")
-__msg("mark_precise: frame1: regs= stack= before 24: (b7) r4 = 4")
-__msg("mark_precise: frame1: regs= stack= before 23: (b7) r3 = 3")
-__msg("mark_precise: frame1: regs= stack= before 22: (b7) r2 = 2")
-__msg("mark_precise: frame1: regs= stack= before 21: (b7) r1 = 1")
-__msg("mark_precise: frame1: regs= stack= before 20: (7b) *(u64 *)(r11 -16) = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 19: (7b) *(u64 *)(r11 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 18: (07) r2 += -8")
-__msg("mark_precise: frame1: regs=r1 stack= before 17: (bf) r2 = r10")
-__msg("mark_precise: frame1: regs=r1 stack= before 16: (7b) *(u64 *)(r10 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 14: (18) r2 = 0x807060504030201")
-__msg("mark_precise: frame1: regs=r1 stack= before 13: (79) r1 = *(u64 *)(r11 +8)")
-__msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13")
-__msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx 11")
-__msg("mark_precise: frame0: regs= stack= before 9: (05) goto pc+1")
-__msg("mark_precise: frame0: regs= stack= before 8: (7a) *(u64 *)(r11 -8) = 4")
-__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1 ")
-__msg("mark_precise: frame1: regs= stack= before 25: (b7) r5 = 5")
-__msg("mark_precise: frame1: regs= stack= before 24: (b7) r4 = 4")
-__msg("mark_precise: frame1: regs= stack= before 23: (b7) r3 = 3")
-__msg("mark_precise: frame1: regs= stack= before 22: (b7) r2 = 2")
-__msg("mark_precise: frame1: regs= stack= before 21: (b7) r1 = 1")
-__msg("mark_precise: frame1: regs= stack= before 20: (7b) *(u64 *)(r11 -16) = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 19: (7b) *(u64 *)(r11 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 18: (07) r2 += -8")
-__msg("mark_precise: frame1: regs=r1 stack= before 17: (bf) r2 = r10")
-__msg("mark_precise: frame1: regs=r1 stack= before 16: (7b) *(u64 *)(r10 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 14: (18) r2 = 0x807060504030201")
-__msg("mark_precise: frame1: regs=r1 stack= before 13: (79) r1 = *(u64 *)(r11 +8)")
-__msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13 ")
-__msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx 11 ")
-__msg("mark_precise: frame0: regs= stack= before 10: (7a) *(u64 *)(r11 -8) = 6")
 __naked void stack_arg_precision_bpf2bpf(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index 201cc000b3f4..497f09dc8876 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -24,12 +24,7 @@ int global_func15(struct __sk_buff *skb)
 }
 
 SEC("cgroup_skb/ingress")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
 __failure
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (b7) r0 = 1")
-/* check that branch code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7")
 __msg("At program exit the register R0 has ")
 __naked int global_func15_tricky_pruning(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 9333321c3ac8..825ff1c3ce43 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -248,7 +248,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("invalid map access into an array with no floor check")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void array_with_no_floor_check(void)
 {
@@ -280,7 +280,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("invalid map access into an array with a invalid max check")
 __failure __msg("invalid access to map value, value_size=48 off=44 size=8")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 max value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void with_a_invalid_max_check_1(void)
 {
@@ -541,8 +541,7 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("valid map access into an array using constant without nullness")
-__success __retval(4) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(4)
 unsigned int an_array_with_a_constant_no_nullness(void)
 {
 	/* Need 8-byte alignment for spill tracking */
@@ -557,9 +556,7 @@ unsigned int an_array_with_a_constant_no_nullness(void)
 
 SEC("socket")
 __description("valid multiple map access into an array using constant without nullness")
-__success __retval(8) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -16) = {{(0|r[0-9])}}")
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(8)
 unsigned int multiple_array_with_a_constant_no_nullness(void)
 {
 	__u32 __attribute__((aligned(8))) key = 1;
@@ -595,8 +592,7 @@ unsigned int an_array_with_a_32bit_constant_0_no_nullness(void)
 
 SEC("socket")
 __description("valid map access into a pcpu array using constant without nullness")
-__success __retval(4) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(4)
 unsigned int a_pcpu_array_with_a_constant_no_nullness(void)
 {
 	__u32 __attribute__((aligned(8))) key = 1;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index 260a6df264e3..a474c9978a35 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -102,7 +102,7 @@ l0_%=:	r0 -= r1;					\
 SEC("socket")
 __description("check deducing bounds from const, 7")
 __failure __msg("dereference of modified ctx ptr")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__msg_unpriv("dereference of modified ctx ptr")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_7(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index d824a5d48a39..51b703058cf7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -371,14 +371,17 @@ struct {
 	__type(value, struct step_val);
 } step_map SEC(".maps");
 
-/* Old register [4..130, step 2] should prune cur register [8..68, step 4]. */
+/*
+ * Register [8..68, step 4] is within register [4..130, step 2]: one state stands for both
+ * and nothing is lost.
+ */
 SEC("socket")
 __success __log_level(2)
 __msg("7: (27) r6 *= 4                       ; R6=scalar({{.*}}umin32=8,{{.*}}umax32=68,{{.*}},step=0+4)")
 __msg("10: (27) r7 *= 2                      ; R7=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2)")
 __msg("11: (25) if r0 > 0x2a goto pc+1")
-__msg("from 11 to 13: safe")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("13: R6=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2) R10=fp0")
+__msg("processed 18 insns")
 __naked void step_prune_hit_multiple(void)
 {
 	asm volatile ("					\
@@ -394,11 +397,11 @@ __naked void step_prune_hit_multiple(void)
 	r7 += 2;					\
 	r7 *= 2;					\
 	if r0 > 42 goto 1f;	/* can't predict */	\
-	r6 = r7;		/* step=2 explored first, step=4 explored next */ \
+	r6 = r7;		/* step=2 here, step=4 on the other path */ \
 1:	r0 = r10;					\
 	r6 = -r6;					\
 	r0 += r6;					\
-	*(u8 *)(r0 + 0) = 7;	/* force r6 precise */	\
+	*(u8 *)(r0 + 0) = 7;				\
 	exit;						\
 "	:
 	: __imm(bpf_get_prandom_u32)
@@ -406,17 +409,16 @@ __naked void step_prune_hit_multiple(void)
 }
 
 /*
- * Old register [0..189, step 3] should not prune cur register [0..30, step 2].
- * Bounds and tnum containment allow pruning; step divisibility must prevent it.
+ * Register [0..30, step 2] is not within register [0..189, step 3].
+ * Bounds and tnum say that it is; step divisibility must prevent it.
+ * The states are joined and the result has no step.
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (27) r6 *= 2                       ; R6=scalar({{.*}}smin32=0,{{.*}}umax32=30,{{.*}},step=0+2)")
 __msg("8: (27) r7 *= 3                       ; R7=scalar({{.*}}smin32=0,{{.*}}umax32=189,{{.*}},step=0+3)")
 __msg("9: (25) if r0 > 0x2a goto pc+1")
-__msg("17: (95) exit")
-__msg("from 9 to 11: R6=scalar({{.*}},step=0+2)")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("11: R6=scalar({{.*}}umax32=189,var_off=(0x0; 0xff)) R10=fp0")
 __naked void step_prune_miss_non_multiple(void)
 {
 	asm volatile ("					\
@@ -430,13 +432,13 @@ __naked void step_prune_miss_non_multiple(void)
 	r7 &= 0x3f;					\
 	r7 *= 3;					\
 	if r0 > 42 goto 1f;	/* can't predict */	\
-	r6 = r7;		/* step=3 explored first, step=2 explored next */ \
+	r6 = r7;		/* step=3 here, step=2 on the other path */ \
 1:							\
 	r2 = r10;					\
 	r6 += 1;					\
 	r6 = -r6;					\
 	r2 += r6;					\
-	*(u8 *)(r2 + 0) = 7;	/* force r6 precise */	\
+	*(u8 *)(r2 + 0) = 7;				\
 	r0 = 0;						\
 	exit;						\
 "	:
@@ -445,17 +447,17 @@ __naked void step_prune_miss_non_multiple(void)
 }
 
 /*
- * Constant current register lying on the cached line: cached is {0,3,6,...}
- * (step 3, base 0), current is the constant 6. range_within() takes the
- * constant branch: imod(6, 3) == base 0, so cur is on the line and the
- * (precise) state is pruned -> "safe".
+ * Constant register lying on the line of the other state: that is {0,3,6,...}
+ * (step 3, base 0), this is the constant 6. range_within() takes the
+ * constant branch: imod(6, 3) == base 0, so the constant is on the line and
+ * the state with the line stands for both.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
-__msg("16: (b7) r1 = 6")		/* current path: const 6, on the line */
-__msg("17: safe")			/* pruned at join: imod(6, 3) == 0 */
+__msg("16: (b7) r1 = 6")		/* const 6, on the line */
+__msg("14: (27) r1 *= 3")		/* step 3 line */
+__msg("from 15 to 17: joined")
+__msg("17: R1=scalar({{.*}},step=0+3) R7=")	/* imod(6, 3) == 0 */
 __naked void step_prune_hit_const_on_line(void)
 {
 	asm volatile ("					\
@@ -472,13 +474,13 @@ __naked void step_prune_hit_const_on_line(void)
 	r1 = r6;					\
 	r1 &= 0xff;					\
 	if r6 > 0 goto l_cur_%=;			\
-	r1 *= 3;			/* old: step 3 */	\
+	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
-	r1 = 6;				/* cur: const on line */	\
+	r1 = 6;				/* const on line */	\
 l_join_%=:						\
 	r0 = r7;					\
-	r0 += r1;			/* r1 forced precise */	\
+	r0 += r1;					\
 	r2 = *(u8 *)(r0 + 0);				\
 l_out_%=:						\
 	r0 = 0;						\
@@ -491,22 +493,21 @@ l_out_%=:						\
 }
 
 /*
- * Constant current register NOT on the cached line: cached is {0,3,6,...}
- * (step 3, base 0), current is the constant 7. imod(7, 3) == 1 != base 0,
- * so range_within() fails and the join is traversed again. A power-of-two
+ * Constant register NOT on the line of the other state: that is {0,3,6,...}
+ * (step 3, base 0), this is the constant 7. imod(7, 3) == 1 != base 0,
+ * so range_within() fails and the states are joined. A power-of-two
  * step is avoided on purpose: with step 3 the tnum is loose enough to admit
  * 7, so imod() is
  * the sole check that rejects it. No failure shape is possible here: 7 is
- * within the line's bounds and tnum, and the cached line path already
- * verifies the whole outro, so an eager prune could not miss an error.
+ * within the line's bounds and tnum.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
-__msg("16: (b7) r1 = 7")		/* current path: const 7, off the line */
-/* not pruned: current continues past the join with the constant offset 7 */
-__msg("19: R0=map_value({{.*}}imm=7) R1=7")
+__msg("16: (b7) r1 = 7")		/* const 7, off the line */
+__msg("14: (27) r1 *= 3")		/* step 3 line */
+/* the result stands for 7 too: it has no step */
+__msg("from 15 to 17: joined")
+__msg("17: R1=scalar({{.*}}var_off=(0x0; 0x3ff)) R7=")
 __naked void step_prune_miss_const_off_line(void)
 {
 	asm volatile ("					\
@@ -523,13 +524,13 @@ __naked void step_prune_miss_const_off_line(void)
 	r1 = r6;					\
 	r1 &= 0xff;					\
 	if r6 > 0 goto l_cur_%=;			\
-	r1 *= 3;			/* old: step 3 */	\
+	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
-	r1 = 7;				/* cur: const off line */	\
+	r1 = 7;				/* const off line */	\
 l_join_%=:						\
 	r0 = r7;					\
-	r0 += r1;			/* r1 forced precise */	\
+	r0 += r1;					\
 	r2 = *(u8 *)(r0 + 0);				\
 l_out_%=:						\
 	r0 = 0;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index d571fbfc86a3..caae67feaf5b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -668,12 +668,16 @@ __naked void add_const_base_id_pruning(void)
 	call %[bpf_get_prandom_u32];				\
 	r6 = r0;						\
 	r6 &= 1;						\
-	if r6 >= 1 goto l_true_%=;				\
+	if r6 < 1 goto l_false_%=;				\
+	goto l_true_%=;						\
 								\
+l_false_%=:							\
 	/* False branch (explored first, old state) */		\
 	call %[bpf_get_prandom_u32];				\
 	r2 = r0;						\
 	r2 &= 0xff;		/* R2 = scalar(id=A) [0,255] */	\
+	r4 = r0;						\
+	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
 	r3 = r2;		/* R3 linked to R2 (id=A) */	\
 	r3 += 10;		/* R3 id=A|ADD_CONST, delta=10 */\
 	r6 = 0;							\
@@ -703,6 +707,7 @@ l_merge_%=:							\
 	r9 += r3;		/* fp-16+[0,5] vs fp-16+[0,255] */\
 	*(u8*)(r9 + 0) = r6;	/* within 16B vs past fp */	\
 l_exit_%=:							\
+	r4 = r4;		/* R4 is live at the merge */	\
 	r0 = 0;							\
 	exit;							\
 "	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 2ae5c60150dd..795956bd4f9f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -368,7 +368,6 @@ static __used __naked void arg_track_join_convergence_subprog(void)
 }
 
 SEC("socket")
-__flag(BPF_F_TEST_STATE_FREQ)
 __log_level(2)
 /* fp0-8 consumed at insn 9, dead by insn 11. stack_def at insn 4 kills slots 0,1. */
 __msg("4: (7b) *(u64 *)(r10 -8) = r0        ; def: fp0-8")
@@ -380,9 +379,9 @@ __msg("10: (b7) r0 = 0{{$}}")
 __msg("11: (05) goto pc+0{{$}}")
 __msg("12: (95) exit")
 /*
- * Checkpoint at goto +0 fires because fp0-8 is dead → state pruning.
+ * fp0-8 is dead after goto +0, so one state stands for both.
  */
-__msg("12: safe")
+__msg("from 11 to 12: within")
 __naked void caller_stack_pruning(void)
 {
 	asm volatile (
@@ -497,7 +496,6 @@ struct {
 
 SEC("socket")
 __failure __msg("invalid read from stack R2 off=-4096 size=8")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked unsigned long caller_stack_write_tail_call(void)
 {
         asm volatile (
@@ -855,7 +853,7 @@ static __used __naked void maybe_clobber_key(void)
 
 /*
  * Demonstrate that subprog arg spill/reload breaks arg tracking,
- * inflating caller stack liveness and preventing state pruning.
+ * inflating caller stack liveness and keeping states apart.
  *
  * modifier2(fp-24) has two paths: one writes a scalar to *(r1+8)
  * = caller fp-16, the other leaves it as zero.  After modifier2
@@ -871,16 +869,15 @@ static __used __naked void maybe_clobber_key(void)
  * the reader never touches it.
  *
  * Result: at modifier2's return point two states with different
- * fp-16 values cannot be pruned.
+ * fp-16 values are kept apart.
  *
- * With correct (or old dynamic) liveness fp-16 is dead at that
- * point and the states prune → "6: safe" appears in the log.
+ * With correct liveness fp-16 is dead at that point and one state is
+ * within the other one.
  */
 SEC("socket")
-__flag(BPF_F_TEST_STATE_FREQ)
 __log_level(2)
 __success
-__msg("6: safe")
+__msg("from 16 to 6: within")
 __naked void spill_reload_inflates_stack_liveness(void)
 {
 	asm volatile (
@@ -1366,31 +1363,32 @@ __naked void half_spi_clean_preserves_stack_zero(void)
  * conditional block with helper call and temporary stack spill,
  * spill dead after merge.
  *
- * Path A (fall-through): spill r6 to fp-8 across helper call
- * Path B (branch taken): skip the block entirely
- * At merge (insn 6): fp-8 is dead (never read after merge)
+ * Path A (branch taken, verified first): spill r6 to fp-8 across helper call
+ * Path B (fall-through): skip the block entirely
+ * At merge (insn 7): fp-8 is dead (never read after merge)
  *
  * Static liveness marks fp-8 dead at merge. clean_verifier_state()
  * converts path A's STACK_SPILL to STACK_INVALID. Path B has
- * STACK_INVALID. stacksafe() matches -> path B pruned -> "6: safe".
+ * STACK_INVALID. stacksafe() matches -> one state stands for both paths.
  */
 SEC("socket")
-__flag(BPF_F_TEST_STATE_FREQ)
 __success
 __log_level(2)
-__msg("6: safe")
+__msg("from 3 to 7: within")
 __naked void dead_spill_at_merge_enables_pruning(void)
 {
 	asm volatile (
 	"call %[bpf_get_prandom_u32];"
 	"r6 = 7;"
-	"if r0 != 0 goto l_skip%=;"
+	"if r0 == 0 goto l_spill%=;"
+	"goto l_skip%=;"
+"l_spill%=:"
 	/* conditional block: spill, call, reload */
 	"*(u64 *)(r10 - 8) = r6;"
 	"call %[bpf_get_prandom_u32];"
 	"r6 = *(u64 *)(r10 - 8);"
 "l_skip%=:"
-	/* fp-8 dead. Path B pruned here -> "6: safe" */
+	/* fp-8 dead. The states of both paths are the same here */
 	"r0 = r6;"
 	"exit;"
 	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
index 1639628b832d..2b65ab508596 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
@@ -83,7 +83,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("sometimes access memory with incorrect alignment")
 __failure __msg("R0 invalid mem access")
-__msg_unpriv("R0 leaks addr")
+__msg_unpriv("R0 invalid mem access")
 __flag(BPF_F_STRICT_ALIGNMENT)
 __naked void access_memory_with_incorrect_alignment_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
index 7e24706a764e..aba9510a1c08 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -7,13 +7,9 @@
 
 char _license[] SEC("license") = "GPL";
 
-/*
- * The __szk size of a kfunc memory/size pair must be marked precise even when
- * the nullable buffer is passed as NULL.
- */
+/* The __szk size of a kfunc memory/size pair when the nullable buffer is passed as NULL */
 SEC("?tc")
-__success __log_level(2)
-__msg("mark_precise: frame0: regs=r4 stack= before")
+__success
 int dynptr_slice_null_buf_size_precise(struct __sk_buff *skb)
 {
 	struct bpf_dynptr dptr;
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 71ac80a984d8..f0f9b62494ca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -16,10 +16,7 @@ struct {
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0xfffffff8 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (87) r2 = -r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 8")
+__msg("1: (87) r2 = -r2                      ; R2=-8")
 __naked int bpf_neg(void)
 {
 	asm volatile (
@@ -36,10 +33,7 @@ __naked int bpf_neg(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (d4) r2 = le16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (d4) r2 = le16 r2                  ; R2=0")
 __naked int bpf_end_to_le(void)
 {
 	asm volatile (
@@ -57,10 +51,7 @@ __naked int bpf_end_to_le(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (dc) r2 = be16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (dc) r2 = be16 r2                  ; R2=0")
 __naked int bpf_end_to_be(void)
 {
 	asm volatile (
@@ -82,10 +73,7 @@ __naked int bpf_end_to_be(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (d7) r2 = bswap16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (d7) r2 = bswap16 r2               ; R2=0")
 __naked int bpf_end_bswap(void)
 {
 	asm volatile (
@@ -104,10 +92,8 @@ __naked int bpf_end_bswap(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (db) r2 = load_acquire((u64 *)(r10 -8))")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("2: (db) r2 = load_acquire((u64 *)(r10 -8)){{ *}}; R2=8 R10=fp0 fp-8=8")
+__msg("4: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_load_acquire(void)
 {
 	asm volatile (
@@ -115,7 +101,7 @@ __naked int bpf_load_acquire(void)
 	"*(u64 *)(r10 - 8) = r1;"
 	".8byte %[load_acquire_insn];" /* r2 = load_acquire((u64 *)(r10 - 8)); */
 	"r3 = r10;"
-	"r3 += r2;" /* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -126,10 +112,8 @@ __naked int bpf_load_acquire(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r2 = r10")
-__msg("mark_precise: frame0: regs=r1 stack= before 2: (79) r1 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (db) store_release((u64 *)(r10 -8), r1)")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("1: (db) store_release((u64 *)(r10 -8), r1){{ *}}; R1=8 R10=fp0 fp-8=8")
+__msg("4: (0f) r2 += r1                      ; R1=8 R2=fp8")
 __naked int bpf_store_release(void)
 {
 	asm volatile (
@@ -137,7 +121,7 @@ __naked int bpf_store_release(void)
 	".8byte %[store_release_insn];" /* store_release((u64 *)(r10 - 8), r1); */
 	"r1 = *(u64 *)(r10 - 8);"
 	"r2 = r10;"
-	"r2 += r1;" /* mark_precise */
+	"r2 += r1;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -150,24 +134,7 @@ __naked int bpf_store_release(void)
 #endif /* v4 instruction */
 
 SEC("?raw_tp")
-__success __log_level(2)
-/*
- * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
- * and "parent state regs=" lines. "R0=6" parts are here to help anchor
- * expected log messages to the one specific mark_chain_precision operation.
- *
- * This is quite fragile: if verifier checkpointing heuristic changes, this
- * might need adjusting.
- */
-__msg("2: (47) r0 |= 0                       ; R0=6")
-__msg("3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (47) r0 |= 0")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 2")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
-__msg("3: R0=6")
+__success
 __naked int state_loop_first_last_equal(void)
 {
 	asm volatile (
@@ -206,10 +173,6 @@ __success __log_level(2)
 __msg("8: (bd) if r2 <= r10 goto pc+3")
 __msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
 __msg("10: (b5) if r2 <= 0x8 goto pc+0")
-__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0")
-__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3")
-__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
 __naked void bpf_cond_op_r10(void)
 {
 	asm volatile (
@@ -225,9 +188,6 @@ __success __log_level(2)
 __msg("3: (bf) r3 = r10")
 __msg("4: (bd) if r3 <= r2 goto pc+1")
 __msg("5: (b5) if r2 <= 0x8 goto pc+2")
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= r2 goto pc+1")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
 __naked void bpf_cond_op_not_r10(void)
 {
 	asm volatile (
@@ -245,9 +205,6 @@ SEC("lsm.s/socket_connect")
 __success __log_level(2)
 __msg("0: (b7) r0 = 1                        ; R0=1")
 __msg("1: (84) w0 = -w0                      ; R0=0xffffffff")
-__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (84) w0 = -w0")
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
 __naked int bpf_neg_2(void)
 {
 	/*
@@ -280,9 +237,6 @@ SEC("lsm.s/socket_connect")
 __success __log_level(2)
 __msg("0: (b7) r0 = 1                        ; R0=1")
 __msg("1: (87) r0 = -r0                      ; R0=-1")
-__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (87) r0 = -r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
 __naked int bpf_neg_4(void)
 {
 	/*
@@ -313,11 +267,8 @@ __naked int bpf_neg_5(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_add_precision(void)
 {
 	asm volatile (
@@ -326,7 +277,7 @@ __naked int bpf_atomic_fetch_add_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -337,11 +288,8 @@ __naked int bpf_atomic_fetch_add_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_xchg_precision(void)
 {
 	asm volatile (
@@ -350,7 +298,7 @@ __naked int bpf_atomic_xchg_precision(void)
 	"r2 = 0;"
 	".8byte %[xchg_insn];"		/* r2 = atomic_xchg(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -361,11 +309,8 @@ __naked int bpf_atomic_xchg_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_or((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_or((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_or_precision(void)
 {
 	asm volatile (
@@ -374,7 +319,7 @@ __naked int bpf_atomic_fetch_or_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_or_insn];"	/* r2 = atomic_fetch_or(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -385,11 +330,8 @@ __naked int bpf_atomic_fetch_or_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_and((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_and((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_and_precision(void)
 {
 	asm volatile (
@@ -398,7 +340,7 @@ __naked int bpf_atomic_fetch_and_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_and_insn];"	/* r2 = atomic_fetch_and(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -409,11 +351,8 @@ __naked int bpf_atomic_fetch_and_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_xor((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_xor((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_xor_precision(void)
 {
 	asm volatile (
@@ -422,7 +361,7 @@ __naked int bpf_atomic_fetch_xor_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_xor_insn];"	/* r2 = atomic_fetch_xor(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -433,12 +372,8 @@ __naked int bpf_atomic_fetch_xor_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2){{ *}}; R0=8 R2=0 R10=fp0 fp-8=mmmmmmmm")
+__msg("6: (0f) r3 += r0                      ; R0=8 R3=fp8")
 __naked int bpf_atomic_cmpxchg_precision(void)
 {
 	asm volatile (
@@ -448,7 +383,7 @@ __naked int bpf_atomic_cmpxchg_precision(void)
 	"r2 = 0;"
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
 	"r3 = r10;"
-	"r3 += r0;"			/* mark_precise */
+	"r3 += r0;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -457,19 +392,15 @@ __naked int bpf_atomic_cmpxchg_precision(void)
 	: __clobber_all);
 }
 
-/* Regression test for dual precision: Both the fetched value (r2) and
- * a reread of the same stack slot (r3) are tracked for precision. After
- * the atomic operation, the stack slot is STACK_MISC. Thus, the ldx at
- * insn 4 does NOT set INSN_F_STACK_ACCESS. Precision for the stack slot
- * propagates solely through the atomic fetch's load side (insn 3).
+/*
+ * Both the fetched value (r2) and a reread of the same stack slot (r3) are used.
+ * The fetched value is known. After the atomic operation, the stack slot is
+ * STACK_MISC, so what is reread is not.
  */
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2,r3 stack= before 4: (79) r3 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("5: (bf) r4 = r2                       ; R2=8 R4=8")
+__msg("6: (0f) r4 += r3                      ; R3=scalar() R4=scalar()")
 __naked int bpf_atomic_fetch_add_dual_precision(void)
 {
 	asm volatile (
@@ -482,7 +413,7 @@ __naked int bpf_atomic_fetch_add_dual_precision(void)
 	"r4 += r3;"
 	"r4 &= 7;"
 	"r5 = r10;"
-	"r5 += r4;"			/* mark_precise */
+	"r5 += r4;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -493,12 +424,8 @@ __naked int bpf_atomic_fetch_add_dual_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0,r3 stack= before 5: (79) r3 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 8")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("6: (bf) r4 = r0                       ; R0=8 R4=8")
+__msg("7: (0f) r4 += r3                      ; R3=scalar() R4=scalar()")
 __naked int bpf_atomic_cmpxchg_dual_precision(void)
 {
 	asm volatile (
@@ -512,7 +439,7 @@ __naked int bpf_atomic_cmpxchg_dual_precision(void)
 	"r4 += r3;"
 	"r4 &= 7;"
 	"r5 = r10;"
-	"r5 += r4;"			/* mark_precise */
+	"r5 += r4;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -523,9 +450,7 @@ __naked int bpf_atomic_cmpxchg_dual_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
-__msg("mark_precise: frame0: regs=r1 stack= before 9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1){{ *}}; R0=map_value({{.*}}) R1=scalar()")
 __naked int bpf_atomic_fetch_add_map_precision(void)
 {
 	asm volatile (
@@ -540,7 +465,7 @@ __naked int bpf_atomic_fetch_add_map_precision(void)
 	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u64 *)(r0 + 0), r1) */
 	"r1 &= 7;"
 	"r2 = r10;"
-	"r2 += r1;"			/* mark_precise */
+	"r2 += r1;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -553,9 +478,7 @@ __naked int bpf_atomic_fetch_add_map_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1){{ *}}; R0=scalar() R1=0")
 __naked int bpf_atomic_cmpxchg_map_precision(void)
 {
 	asm volatile (
@@ -572,7 +495,7 @@ __naked int bpf_atomic_cmpxchg_map_precision(void)
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r6 + 0), r0, r1) */
 	"r0 &= 7;"
 	"r2 = r10;"
-	"r2 += r0;"			/* mark_precise */
+	"r2 += r0;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -585,9 +508,7 @@ __naked int bpf_atomic_cmpxchg_map_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
-__msg("mark_precise: frame0: regs=r1 stack= before 9: (c3) r1 = atomic_fetch_add((u32 *)(r0 +0), r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("9: (c3) r1 = atomic_fetch_add((u32 *)(r0 +0), r1){{ *}}; R0=map_value({{.*}}) R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __naked int bpf_atomic_fetch_add_32bit_precision(void)
 {
 	asm volatile (
@@ -602,7 +523,7 @@ __naked int bpf_atomic_fetch_add_32bit_precision(void)
 	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u32 *)(r0 + 0), r1) */
 	"r1 &= 7;"
 	"r2 = r10;"
-	"r2 += r1;"			/* mark_precise */
+	"r2 += r1;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -615,9 +536,7 @@ __naked int bpf_atomic_fetch_add_32bit_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (c3) r0 = atomic_cmpxchg((u32 *)(r6 +0), r0, r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("11: (c3) r0 = atomic_cmpxchg((u32 *)(r6 +0), r0, r1){{ *}}; R0=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R1=0")
 __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 {
 	asm volatile (
@@ -634,7 +553,7 @@ __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u32 *)(r6 + 0), r0, r1) */
 	"r0 &= 7;"
 	"r2 = r10;"
-	"r2 += r0;"			/* mark_precise */
+	"r2 += r0;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -648,11 +567,9 @@ __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 /*
  * Verification takes two paths: with r1 being scalar zero on path (1)
  * and with r1 being some other scalar on path (2).
- * Check that the verifier does not use checkpoints created
- * on path (1) to prune path (2).
+ * Check that the state of path (1) does not stand for path (2).
  */
 SEC("?tc")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R1 type=scalar expected=fp")
 __naked int null_mem_arg_zero_size(void)
 {
@@ -689,11 +606,9 @@ __weak int subprog_mem_arg(int *p)
 /*
  * Verification takes two paths: with r1 being scalar zero on path (1)
  * and with r1 being some other scalar on path (2).
- * Check that the verifier does not use checkpoints created
- * on path (1) to prune path (2).
+ * Check that the state of path (1) does not stand for path (2).
  */
 SEC("?raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R1 type=scalar expected=fp")
 __naked int null_mem_arg_global_subprog(void)
 {
@@ -711,9 +626,8 @@ __naked int null_mem_arg_global_subprog(void)
 		: __clobber_all);
 }
 
-/* Same as above, check that path with r3 == 0 does not prune the path with r3 != 0 */
+/* Same as above, check that path with r3 == 0 does not stand for the path with r3 != 0 */
 SEC("?tc")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R3 type=scalar expected=fp")
 int null_kfunc_arg_dynptr_slice(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 256547048cc4..9ea61b162736 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -11,27 +11,22 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-/* Check that precision marks propagate through scalar IDs.
+/* scalar in [0, max] that shares id with other registers, as it is in the log */
+#define LINKED(id, max, mask) \
+	"scalar(id=" id ",smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+#define ALONE(max, mask) \
+	"scalar(smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+
+/*
  * Registers r{0,1,2} have the same scalar ID.
- * Range information is propagated for scalars sharing same ID.
- * Check that precision mark for r0 causes precision marks for r{1,2}
- * when range information is propagated for 'if <reg> <op> <const>' insn.
+ * Range information is propagated for scalars sharing same ID
+ * for 'if <reg> <op> <const>' insn.
+ * The registers share the ID in the join of both branches too.
  */
 SEC("socket")
 __success __log_level(2)
-/* first 'if' branch */
-__msg("6: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-/* second 'if' branch */
-__msg("from 4 to 5: ")
-__msg("6: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 5: (bf) r3 = r10")
-__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
-/* parent state already has r{0,1,2} as precise */
-__msg("frame0: parent state regs= stack=:")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("4: (25) if r1 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("5: R0=" LINKED("1", 255, 0xff) " R1=" LINKED("1", 255, 0xff) " R2=" LINKED("1", 255, 0xff))
 __naked void linked_regs_bpf_k(void)
 {
 	asm volatile (
@@ -42,9 +37,6 @@ __naked void linked_regs_bpf_k(void)
 	"r1 = r0;"
 	"r2 = r0;"
 	"if r1 > 7 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r3 = r10;"
 	"r3 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -57,16 +49,14 @@ __naked void linked_regs_bpf_k(void)
 	: __clobber_all);
 }
 
-/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
- * check that verifier marks r{1,2} as precise while backtracking
- * 'if r1 > ...' with r0 already marked.
+/*
+ * Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that range information is propagated to all of them.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
-__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__msg("5: (2d) if r1 > r3 goto pc+0          ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("6: R0=" LINKED("1", 255, 0xff) " R1=" LINKED("1", 255, 0xff) " R2=" LINKED("1", 255, 0xff))
 __naked void linked_regs_bpf_x_src(void)
 {
 	asm volatile (
@@ -78,9 +68,6 @@ __naked void linked_regs_bpf_x_src(void)
 	"r2 = r0;"
 	"r3 = 7;"
 	"if r1 > r3 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r4 = r10;"
 	"r4 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -93,16 +80,11 @@ __naked void linked_regs_bpf_x_src(void)
 	: __clobber_all);
 }
 
-/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
- * check that verifier marks r{0,1,2} as precise while backtracking
- * 'if r1 > r3' with r3 already marked.
- */
+/* Same as linked_regs_bpf_x_src(), r3 is what is used after the jump. */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
-__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__msg("5: (2d) if r1 > r3 goto pc+0          ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("7: (0f) r4 += r3                      ; R3=7 R4=fp7")
 __naked void linked_regs_bpf_x_dst(void)
 {
 	asm volatile (
@@ -114,9 +96,6 @@ __naked void linked_regs_bpf_x_dst(void)
 	"r2 = r0;"
 	"r3 = 7;"
 	"if r1 > r3 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r4 = r10;"
 	"r4 += r3;"
 	/* Mark r1 and r2 as alive. */
@@ -131,16 +110,13 @@ __naked void linked_regs_bpf_x_dst(void)
 }
 
 /* Same as linked_regs_bpf_k, but break one of the
- * links, note that r1 is absent from regs=... in __msg below.
+ * links, note that r1 is absent from the first __msg below.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("7: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
-__msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r2 stack=:")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* r1 is not there */
+__msg("5: (25) if r0 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) "{{$}}")
+__msg("8: (bf) r1 = r1                       ; R1=0")
 __naked void linked_regs_broken_link(void)
 {
 	asm volatile (
@@ -155,9 +131,6 @@ __naked void linked_regs_broken_link(void)
 	 */
 	"r1 = 0;"
 	"if r0 > 7 goto +0;"
-	/* force r0 to be precise,
-	 * this eventually marks r2 as precise because of shared IDs
-	 */
 	"r3 = r10;"
 	"r3 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -170,50 +143,16 @@ __naked void linked_regs_broken_link(void)
 	: __clobber_all);
 }
 
-/* Check that precision marks propagate through scalar IDs.
- * Use the same scalar ID in multiple stack frames, check that
- * precision information is propagated up the call stack.
+/*
+ * Use the same scalar ID in multiple stack frames. A static function is verified
+ * on its own: registers of the callers are not there when r1 is compared, so it has no ID.
+ * They share their IDs after the calls like before, if there is more than one left.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("17: (0f) r2 += r1")
-/* Current state */
-__msg("frame2: last_idx 17 first_idx 14 subseq_idx -1 ")
-__msg("frame2: regs=r1 stack= before 16: (bf) r2 = r10")
-__msg("frame2: parent state regs=r1 stack=")
-__msg("frame1: parent state regs= stack=")
-__msg("frame0: parent state regs= stack=")
-/* Parent state */
-__msg("frame2: last_idx 13 first_idx 13 subseq_idx 14 ")
-__msg("frame2: regs=r1 stack= before 13: (25) if r1 > 0x7 goto pc+0")
-__msg("frame2: parent state regs=r1 stack=")
-/* frame1.r{6,7} are marked because mark_precise_scalar_ids()
- * looks for all registers with frame2.r1.id in the current state
- */
-__msg("frame1: parent state regs=r6,r7 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame2: last_idx 9 first_idx 9 subseq_idx 13")
-__msg("frame2: regs=r1 stack= before 9: (85) call pc+3")
-/* frame1.r1 is marked because of backtracking of call instruction */
-__msg("frame1: parent state regs=r1,r6,r7 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame1: last_idx 8 first_idx 7 subseq_idx 9")
-__msg("frame1: regs=r1,r6,r7 stack= before 8: (bf) r7 = r1")
-__msg("frame1: regs=r1,r6 stack= before 7: (bf) r6 = r1")
-__msg("frame1: parent state regs=r1 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame1: last_idx 4 first_idx 4 subseq_idx 7")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
-__msg("frame0: parent state regs=r1,r6 stack=")
-/* Parent state */
-__msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
-__msg("frame0: regs=r1,r6 stack= before 3: (bf) r6 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("13: (25) if r1 > 0x7 goto pc+0        ; R1=" ALONE(7, 0x7))
+__msg("10: R0=0 R6=scalar(id={{.*}}umax32=255,{{.*}} R7=scalar(id={{.*}}umax32=255,")
+__msg("5: R0=0 R6=" ALONE(255, 0xff))
 __naked void precision_many_frames(void)
 {
 	asm volatile (
@@ -254,11 +193,6 @@ void precision_many_frames__bar(void)
 	"if r1 > 7 goto +0;"
 	"r6 = 0;" /* mark r6 as live */
 	"r7 = 0;" /* mark r7 as live */
-	/* force r1 to be precise, this eventually marks:
-	 * - bar frame r1
-	 * - foo frame r{1,6,7}
-	 * - main frame r{1,6}
-	 */
 	"r2 = r10;"
 	"r2 += r1;"
 	"r0 = 0;"
@@ -266,23 +200,13 @@ void precision_many_frames__bar(void)
 	::: __clobber_all);
 }
 
-/* Check that scalars with the same IDs are marked precise on stack as
+/*
+ * Check that range information is propagated to scalars with the same IDs on stack as
  * well as in registers.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("12: (0f) r2 += r1")
-/* foo frame */
-__msg("frame1: regs=r1 stack= before 11: (bf) r2 = r10")
-__msg("frame1: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
-__msg("frame1: regs=r1 stack=-8,-16 before 9: (7b) *(u64 *)(r10 -16) = r1")
-__msg("frame1: regs=r1 stack=-8 before 8: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+3")
-/* main frame */
-__msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("10: (25) if r1 > 0x7 goto pc+0        ; R1=scalar({{.*}}umax32=7,{{.*}} fp-8=scalar({{.*}}umax32=7,{{.*}} fp-16=scalar({{.*}}umax32=7,")
 __naked void precision_stack(void)
 {
 	asm volatile (
@@ -311,10 +235,6 @@ void precision_stack__foo(void)
 	"*(u64*)(r10 - 8) = r1;"
 	"*(u64*)(r10 - 16) = r1;"
 	"if r1 > 7 goto +0;"
-	/* force r1 to be precise, this eventually marks:
-	 * - foo frame r1,fp{-8,-16}
-	 * - main frame r1,fp{-8}
-	 */
 	"r2 = r10;"
 	"r2 += r1;"
 	"r0 = *(u64*)(r10 - 8);"
@@ -329,20 +249,9 @@ void precision_stack__foo(void)
 SEC("socket")
 __success __log_level(2)
 /* r{6,7} */
-__msg("12: (0f) r3 += r7")
-__msg("frame0: regs=r7 stack= before 11: (bf) r3 = r10")
-__msg("frame0: regs=r7 stack= before 9: (25) if r7 > 0x7 goto pc+0")
-/* ... skip some insns ... */
-__msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
-__msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
+__msg("9: (25) if r7 > 0x7 goto pc+0         ; R6=" LINKED("1", 7, 0x7) " R7=" LINKED("1", 7, 0x7) "{{$}}")
 /* r{8,9} */
-__msg("13: (0f) r3 += r9")
-__msg("frame0: regs=r9 stack= before 12: (0f) r3 += r7")
-/* ... skip some insns ... */
-__msg("frame0: regs=r9 stack= before 10: (25) if r9 > 0x7 goto pc+0")
-__msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
-__msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("10: (25) if r9 > 0x7 goto pc+0        ; R8=" LINKED("2", 7, 0x7) " R9=" LINKED("2", 7, 0x7) "{{$}}")
 __naked void precision_two_ids(void)
 {
 	asm volatile (
@@ -360,13 +269,11 @@ __naked void precision_two_ids(void)
 	"r9 = r0;"
 	/* clear r0 id */
 	"r0 = 0;"
-	/* propagate equal scalars precision */
+	/* propagate range information to equal scalars */
 	"if r7 > 7 goto +0;"
 	"if r9 > 7 goto +0;"
 	"r3 = r10;"
-	/* force r7 to be precise, this also marks r6 */
 	"r3 += r7;"
-	/* force r9 to be precise, this also marks r8 */
 	"r3 += r9;"
 	"r6 = r6;" /* mark r6 as live */
 	"r8 = r8;" /* mark r8 as live */
@@ -378,7 +285,6 @@ __naked void precision_two_ids(void)
 
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 /*
  * check that r5 is unlinked after 'if', collect_linked_regs() can't tie
  * more than 5 registers for a single insn and the register compared by
@@ -386,9 +292,6 @@ __flag(BPF_F_TEST_STATE_FREQ)
  */
 __msg("7: (25) if r5 > 0x7 goto pc+0         ; R5=scalar(smin=")
 __msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
-/* check that r{0-4} are marked precise after 'if' */
-__msg("frame0: regs=r0 stack= before 7: (25) if r5 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3,r4 stack=:")
 __naked void linked_regs_too_many_regs(void)
 {
 	asm volatile (
@@ -410,9 +313,6 @@ __naked void linked_regs_too_many_regs(void)
 	"r4 = r4;"
 	/* make r5 appear in the log */
 	"r5 = r5;"
-	/* force r0 to be precise,
-	 * this would cause r{0-4} to be precise because of shared IDs
-	 */
 	"r7 = r10;"
 	"r7 += r0;"
 	"r0 = 0;"
@@ -424,10 +324,7 @@ __naked void linked_regs_too_many_regs(void)
 
 SEC("socket")
 __failure __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("regs=r7 stack= before 5: (3d) if r8 >= r0")
-__msg("parent state regs=r0,r7,r8")
-__msg("regs=r0,r7,r8 stack= before 4: (25) if r0 > 0x1")
+__msg("5: (3d) if r8 >= r0 goto pc+3         ; R0=scalar(umin=1) R7=scalar(id=1,umax=0xfffffffffffffffe) R8=scalar(id=1,umax=0xfffffffffffffffe)")
 __msg("div by zero")
 __naked void linked_regs_broken_link_2(void)
 {
@@ -438,13 +335,11 @@ __naked void linked_regs_broken_link_2(void)
 	"call %[bpf_get_prandom_u32];"
 	"if r0 > 1 goto +0;"
 	/* r7.id == r8.id,
-	 * thus r7 precision implies r8 precision,
-	 * which implies r0 precision because of the conditional below.
+	 * thus what is learned about r8 is learned about r7
 	 */
 	"if r8 >= r0 goto 1f;"
 	/* break id relation between r7 and r8 */
 	"r8 += r8;"
-	/* make r7 precise */
 	"if r7 == 0 goto 1f;"
 	"r0 /= 0;"
 "1:"
@@ -455,13 +350,11 @@ __naked void linked_regs_broken_link_2(void)
 	: __clobber_all);
 }
 
-/* Check that mark_chain_precision() for one of the conditional jump
- * operands does not trigger equal scalars precision propagation.
- */
+/* A conditional jump that is predicted says nothing new about its operands. */
 SEC("socket")
 __success __log_level(2)
-__msg("3: (25) if r1 > 0x100 goto pc+0")
-__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__msg("3: (25) if r1 > 0x100 goto pc+0       ; R1=" LINKED("1", 255, 0xff) "{{$}}")
+__msg("processed 6 insns")
 __naked void cjmp_no_linked_regs_trigger(void)
 {
 	asm volatile (
@@ -470,9 +363,7 @@ __naked void cjmp_no_linked_regs_trigger(void)
 	"r0 &= 0xff;"
 	/* tie r0.id == r1.id */
 	"r1 = r0;"
-	/* the jump below would be predicted, thus r1 would be marked precise,
-	 * this should not imply precision mark for r0
-	 */
+	/* the jump below is predicted */
 	"if r1 > 256 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -497,7 +388,6 @@ __naked void cjmp_no_linked_regs_trigger(void)
  */
 SEC("socket")
 __failure __msg("register with unbounded min value")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void check_ids_in_regsafe(void)
 {
 	asm volatile (
@@ -539,12 +429,9 @@ __naked void check_ids_in_regsafe(void)
  *   (2) r6{.id=B}, r7{.id=A}, r8{.id=B}
  *
  * Where (2) is not safe, as "r7 > 4" check won't propagate range for it.
- * This example would be considered safe without changes to
- * mark_chain_precision() to track scalar values with equal IDs.
  */
 SEC("socket")
 __failure __msg("register with unbounded min value")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void check_ids_in_regsafe_2(void)
 {
 	asm volatile (
@@ -595,24 +482,24 @@ __naked void check_ids_in_regsafe_2(void)
  * If such IDs *are* generated the 'l1' below would be reached in
  * two states:
  *
- *   (1) r1{.id=A}, r2{.id=A}
- *   (2) r1{.id=C}, r2{.id=C}
+ *   (1) r3{.id=A}, r4{.id=A}, which is there first
+ *   (2) r3{.id=B}, r4{.id=C}
  *
- * Thus forcing 'if r1 == r2' verification twice.
+ * and (2) is not within (1).
  */
 SEC("socket")
 __success __log_level(2)
-__msg("14: (1d) if r3 == r4 goto pc+0")
-__msg("frame 0: propagating r3,r4")
-__msg("14: safe")
+__msg("from 14 to 15: within")
+__msg("15: (1d) if r3 == r4 goto pc+0        ; R3=0 R4=0")
 __msg("processed 18 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void no_scalar_id_for_const(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
 	/* unpredictable jump */
-	"if r0 > 7 goto l0_%=;"
+	"if r0 <= 7 goto l2_%=;"
+	"goto l0_%=;"
+"l2_%=:"
 	/* possibly generate same scalar ids for r3 and r4 */
 	"r1 = 0;"
 	"r1 ^= r1;" /* prevent bpf_prune_dead_branches from folding the branch */
@@ -629,7 +516,7 @@ __naked void no_scalar_id_for_const(void)
 	"r3 = r1;"
 	"r4 = r2;"
 "l1_%=:"
-	/* predictable jump, marks r3 and r4 precise */
+	/* predictable jump */
 	"if r3 == r4 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -641,17 +528,17 @@ __naked void no_scalar_id_for_const(void)
 /* Same as no_scalar_id_for_const() but for 32-bit values */
 SEC("socket")
 __success __log_level(2)
-__msg("14: (1e) if w3 == w4 goto pc+0")
-__msg("frame 0: propagating r3,r4")
-__msg("14: safe")
+__msg("from 14 to 15: within")
+__msg("15: (1e) if w3 == w4 goto pc+0        ; R3=0 R4=0")
 __msg("processed 18 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void no_scalar_id_for_const32(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
 	/* unpredictable jump */
-	"if r0 > 7 goto l0_%=;"
+	"if r0 <= 7 goto l2_%=;"
+	"goto l0_%=;"
+"l2_%=:"
 	/* possibly generate same scalar ids for r3 and r4 */
 	"w1 = 0;"
 	"w1 ^= w1;" /* prevent bpf_prune_dead_branches from folding the branch */
@@ -668,7 +555,7 @@ __naked void no_scalar_id_for_const32(void)
 	"w3 = w1;"
 	"w4 = w2;"
 "l1_%=:"
-	/* predictable jump, marks r3 and r4 precise */
+	/* predictable jump */
 	"if w3 == w4 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -677,20 +564,20 @@ __naked void no_scalar_id_for_const32(void)
 	: __clobber_all);
 }
 
-/* Check that unique scalar IDs are ignored when new verifier state is
- * compared to cached verifier state. For this test:
- * - cached state has no id on r1
- * - new state has a unique id on r1
+/*
+ * Check that unique scalar IDs are ignored when a verifier state is
+ * compared to the state that is there. For this test:
+ * - the state that is there had a unique id on r1
+ * - the state that arrives has no id on r1
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (25) if r6 > 0x7 goto pc+1")
 __msg("7: (57) r1 &= 255")
-__msg("8: (bf) r2 = r10")
-__msg("from 6 to 8: safe")
-__msg("processed 12 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void ignore_unique_scalar_ids_cur(void)
+__msg("from 7 to 8: within")
+__msg("8: R0=0 R1=" ALONE(255, 0xff))
+__msg("processed 11 insns")
+__naked void ignore_unique_scalar_ids_old(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
@@ -706,8 +593,8 @@ __naked void ignore_unique_scalar_ids_cur(void)
 	"r1 &= 0xff;"
 "l0_%=:"
 	/* get here in two states:
-	 * - first: r1 has no id (cached state)
-	 * - second: r1 has a unique id (should be considered equivalent)
+	 * - first: r1 has a unique id
+	 * - second: r1 has no id (should be considered to be within the first)
 	 */
 	"r2 = r10;"
 	"r2 += r1;"
@@ -717,20 +604,20 @@ __naked void ignore_unique_scalar_ids_cur(void)
 	: __clobber_all);
 }
 
-/* Check that unique scalar IDs are ignored when new verifier state is
- * compared to cached verifier state. For this test:
- * - cached state has a unique id on r1
- * - new state has no id on r1
+/*
+ * Check that unique scalar IDs are ignored when a verifier state is
+ * compared to the state that is there. For this test:
+ * - the state that is there has no id on r1
+ * - the state that arrives has a unique id on r1
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (25) if r6 > 0x7 goto pc+1")
 __msg("7: (05) goto pc+1")
-__msg("9: (bf) r2 = r10")
-__msg("9: safe")
-__msg("processed 13 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void ignore_unique_scalar_ids_old(void)
+__msg("from 7 to 9: within")
+__msg("9: R0=0 R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R10=fp0")
+__msg("processed 12 insns")
+__naked void ignore_unique_scalar_ids_cur(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
@@ -748,8 +635,8 @@ __naked void ignore_unique_scalar_ids_old(void)
 	"r1 &= 0xff;"
 "l0_%=:"
 	/* get here in two states:
-	 * - first: r1 has a unique id (cached state)
-	 * - second: r1 has no id (should be considered equivalent)
+	 * - first: r1 has no id
+	 * - second: r1 has a unique id (should be considered to be within the first)
 	 */
 	"r2 = r10;"
 	"r2 += r1;"
@@ -759,16 +646,14 @@ __naked void ignore_unique_scalar_ids_old(void)
 	: __clobber_all);
 }
 
-/* Check that two registers with 0 scalar IDs in a verified state can be mapped
- * to the same scalar ID in current state.
+/*
+ * Check that two registers with 0 scalar IDs in the state that is there can be mapped
+ * to the same scalar ID in the state that arrives.
  */
 SEC("socket")
 __success __log_level(2)
-/* The states should be equivalent on reaching insn 12.
- */
-__msg("12: safe")
-__msg("processed 17 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 10 to 11: within")
+__msg("processed 15 insns")
 __naked void two_nil_old_ids_one_cur_id(void)
 {
 	asm volatile (
@@ -783,16 +668,14 @@ __naked void two_nil_old_ids_one_cur_id(void)
 	"r7 *= 1;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
-	"if r6 > r7 goto l0_%=;"
-	"goto l1_%=;"
-"l0_%=:"
+	"if r6 <= r7 goto l1_%=;"
 	"r6 = r7;"
 "l1_%=:"
-	/* Mark r{6,7} precise.
+	/*
 	 * Get here in two states:
-	 * - first:  r6{.id=0}, r7{.id=0} (cached state)
+	 * - first:  r6{.id=0}, r7{.id=0}
 	 * - second: r6{.id=A}, r7{.id=A}
-	 * Verifier considers such states equivalent.
+	 * Verifier considers the second one to be within the first one.
 	 * Thus "exit;" would be verified only once.
 	 */
 	"r2 = r10;"
@@ -804,18 +687,14 @@ __naked void two_nil_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
-/* Check that two different scalar IDs in a verified state can't be
- * mapped to the same scalar ID in current state.
+/*
+ * Check that two different scalar IDs in the state that is there can't be
+ * mapped to the same scalar ID in the state that arrives.
  */
 SEC("socket")
 __success __log_level(2)
-/* The exit instruction should be reachable from two states,
- * use two matches and "processed .. insns" to ensure this.
- */
-__msg("16: (95) exit")
-__msg("16: (95) exit")
-__msg("processed 22 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__not_msg("from 10 to 11: within")
+__msg("11: R0=0 R6=" ALONE(255, 0xff) " R7=" ALONE(255, 0xff))
 __naked void two_old_ids_one_cur_id(void)
 {
 	asm volatile (
@@ -830,24 +709,22 @@ __naked void two_old_ids_one_cur_id(void)
 	"r9 = r0;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
-	"if r6 > r7 goto l0_%=;"
-	"goto l1_%=;"
-"l0_%=:"
+	"if r6 <= r7 goto l1_%=;"
 	"r6 = r7;"
 "l1_%=:"
-	/* Mark r{6,7} precise.
+	/*
 	 * Get here in two states:
-	 * - first:  r6{.id=A}, r7{.id=B} (cached state)
-	 * - second: r6{.id=A}, r7{.id=A}
-	 * Currently we don't want to consider such states equivalent.
-	 * Thus "exit;" would be verified twice.
+	 * - first:  r6{.id=A}, r7{.id=B}
+	 * - second: r6{.id=B}, r7{.id=B}
+	 * Currently we don't want to consider the second one to be within
+	 * the first one. Thus they are joined.
 	 */
 	"r2 = r10;"
 	"r2 += r6;"
 	"r2 += r7;"
 	/*
 	 * keep r8 and r9 live, otherwise r6->id and r7->id
-	 * will become singular and reset to zero before if r6 > r7
+	 * will become singular and reset to zero before if r6 <= r7
 	 */
 	"r9 += r8;"
 	"exit;"
@@ -878,10 +755,6 @@ __log_level(2)
 __msg("4: (77) r1 >>= 32                     ; R1=0")
 __msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
 __msg("6: (95) exit")
-__msg("from 3 to 4")
-__msg("4: (77) r1 >>= 32                     ; R1=0")
-__msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
-__msg("6: (95) exit")
 /* Verify that statements to randomize upper half of r1 had not been
  * generated.
  */
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index f40e57251e94..9ff29a981a41 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -96,7 +96,7 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("varlen_map_value_access pruning")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void varlen_map_value_access_pruning(void)
 {
@@ -110,8 +110,9 @@ __naked void varlen_map_value_access_pruning(void)
 	if r0 == 0 goto l0_%=;				\
 	r1 = *(u64*)(r0 + 0);				\
 	w2 = %[max_entries];				\
-	if r2 s> r1 goto l1_%=;				\
-	w1 = 0;						\
+	if r2 s<= r1 goto l3_%=;			\
+	goto l1_%=;					\
+l3_%=:	w1 = 0;						\
 l1_%=:	w1 <<= 2;					\
 	r0 += r1;					\
 	goto l2_%=;					\
@@ -193,7 +194,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("precision tracking for u32 spill/fill")
-__failure __msg("R0 min value is outside of the allowed memory range")
+__failure __msg("invalid access to map value, value_size=8 off=32 size=4")
 __naked void tracking_for_u32_spill_fill(void)
 {
 	asm volatile ("					\
@@ -202,7 +203,7 @@ __naked void tracking_for_u32_spill_fill(void)
 	w6 = 32;					\
 	if r0 == 0 goto l0_%=;				\
 	w6 = 4;						\
-l0_%=:	/* Additional insns to introduce a pruning point. */\
+l0_%=:	/* Additional insns to have one more place where paths meet. */\
 	call %[bpf_get_prandom_u32];			\
 	r3 = 0;						\
 	r3 = 0;						\
@@ -239,28 +240,21 @@ __naked void for_u32_spills_u64_fill(void)
 	call %[bpf_get_prandom_u32];			\
 	r6 = r0;					\
 	w7 = 0xffffffff;				\
-	/* Additional insns to introduce a pruning point. */\
-	r3 = 1;						\
-	r3 = 1;						\
-	r3 = 1;						\
-	r3 = 1;						\
+	r9 = 0xffffffff ll;				\
+	/* Additional insns to have a place where paths meet. */\
 	call %[bpf_get_prandom_u32];			\
 	if r0 == 0 goto l0_%=;				\
 	r3 = 1;						\
-l0_%=:	w3 /= 0;					\
+l0_%=:	r3 = 1;						\
 	/* u32 spills, u64 fill */			\
 	*(u32*)(r10 - 4) = r6;				\
 	*(u32*)(r10 - 8) = r7;				\
 	r8 = *(u64*)(r10 - 8);				\
 	/* if r8 != X goto pc+1  r8 known in fallthrough branch */\
-	if r8 != 0xffffffff goto l1_%=;			\
+	if r8 != r9 goto l1_%=;				\
 	r3 = 1;						\
-l1_%=:	/* if r8 == X goto pc+1  condition always true on first\
-	 * traversal, so starts backtracking to mark r8 as requiring\
-	 * precision. r7 marked as needing precision. r6 not marked\
-	 * since it's not tracked.			\
-	 */						\
-	if r8 == 0xffffffff goto l2_%=;			\
+l1_%=:	/* if r8 == X goto pc+1 */			\
+	if r8 == r9 goto l2_%=;				\
 	/* fails if r8 correctly marked unknown after fill. */\
 	w3 /= 0;					\
 l2_%=:	r0 = 0;						\
@@ -272,7 +266,8 @@ l2_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("allocated_stack")
-__success __msg("processed 15 insns")
+/* every insn once: the state that wrote to the stack is within the state that did not */
+__success __msg("processed 14 insns")
 __success_unpriv __msg_unpriv("") __log_level(1) __retval(0)
 __naked void allocated_stack(void)
 {
@@ -337,12 +332,9 @@ l0_%=:	r1 = 42;					\
 	: __clobber_all);
 }
 
-/* Without checkpoint forcibly inserted at the back-edge a loop this
- * test would take a very long time to verify.
- */
+/* The number of trips is not known */
 SEC("kprobe")
-__failure __log_level(4)
-__msg("BPF program is too large.")
+__success
 __naked void short_loop1(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 4d1374885f6d..34c551f97e61 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -518,15 +518,6 @@ __msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0")
  */
 __msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2=0 R10=fp0 fp-16=0")
 __msg("11: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
@@ -600,8 +591,6 @@ __success
 __msg("2: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=0000????")
 __msg("4: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0000????")
 __msg("5: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (71) r2 = *(u8 *)(r10 -1)")
 __naked void partial_stack_load_preserves_partial_zeros(void)
 {
 	asm volatile (
@@ -637,7 +626,6 @@ __naked void partial_stack_load_preserves_partial_zeros(void)
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R2=0")
 __naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
 {
@@ -663,50 +651,21 @@ __naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
 char two_byte_buf[2] SEC(".data.two_byte_buf");
 
 SEC("raw_tp")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
 __success
-/* make sure fp-8 is IMPRECISE fake register spill */
+/* make sure fp-8 is fake register spill */
 __msg("3: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8=1")
-/* and fp-16 is spilled IMPRECISE const reg */
+/* and fp-16 is spilled const reg */
 __msg("5: (7b) *(u64 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
 __msg("8: (79) r2 = *(u64 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=1")
-__msg("9: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 8: (79) r2 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-/* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7a) *(u64 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("9: (0f) r1 += r2                      ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=1")
-__msg("13: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (79) r2 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (79) r2 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-/* now both fp-8 and fp-16 are precise, very good */
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=P1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("13: (0f) r1 += r2                     ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision(void)
 {
 	asm volatile (
-		/* establish checkpoint with state that has no stack slots;
-		 * if we bubble up to this state without finding desired stack
-		 * slot, then it's a bug and should be caught
-		 */
 		"goto +0;"
 
 		/* fp-8 is const 1 *fake* register */
@@ -716,7 +675,6 @@ __naked void stack_load_preserves_const_precision(void)
 		"r0 = 1;"
 		"*(u64 *)(r10 -16) = r0;"
 
-		/* force checkpoint to check precision marks preserved in parent states */
 		"goto +0;"
 
 		/* load single U64 from aligned FAKE_REG=1 slot */
@@ -740,48 +698,21 @@ __naked void stack_load_preserves_const_precision(void)
 }
 
 SEC("raw_tp")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
 __success
 /* make sure fp-8 is 32-bit FAKE subregister spill */
 __msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=????1")
-/* but fp-16 is spilled IMPRECISE zero const reg */
+/* and fp-16 is spilled const reg */
 __msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=????1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
 __msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=????1")
-__msg("9: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("9: (0f) r1 += r2                      ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=????1")
-__msg("13: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (61) r2 = *(u32 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????P1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("13: (0f) r1 += r2                     ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision_subreg(void)
 {
 	asm volatile (
-		/* establish checkpoint with state that has no stack slots;
-		 * if we bubble up to this state without finding desired stack
-		 * slot, then it's a bug and should be caught
-		 */
 		"goto +0;"
 
 		/* fp-8 is const 1 *fake* SUB-register */
@@ -791,7 +722,6 @@ __naked void stack_load_preserves_const_precision_subreg(void)
 		"r0 = 1;"
 		"*(u32 *)(r10 -16) = r0;"
 
-		/* force checkpoint to check precision marks preserved in parent states */
 		"goto +0;"
 
 		/* load single U32 from aligned FAKE_REG=1 slot */
@@ -1118,41 +1048,37 @@ l0_%=:	r1 >>= 32;					\
 	: __clobber_all);
 }
 
-/* stacksafe(): check if stack spill of an imprecise scalar in old state
- * is considered equivalent to STACK_{MISC,INVALID} in cur state.
+/*
+ * stacksafe(): the state with a stack spill of a scalar is there (label 1 is
+ * looked at first), the state with STACK_{MISC,INVALID} arrives.
+ * The first one is within the second one, which stands for both.
  */
 SEC("socket")
 __success __log_level(2)
+__msg("8: R0=scalar() R10=fp0 fp-8=??mm??mm")
 __msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-/* STACK_INVALID should prevent verifier in unpriv mode from
- * considering states equivalent and force an error on second
- * verification path (entry - label 1 - label 2).
- */
+__msg("processed 10 insns")
+/* STACK_INVALID is an error in unpriv mode */
 __failure_unpriv
 __msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg_unpriv("9: (95) exit")
-__msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
 __msg_unpriv("invalid read from stack off -8+2 size 8")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void old_imprecise_scalar_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_{MISC,INVALID} at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1160,71 +1086,69 @@ __naked void old_imprecise_scalar_vs_cur_stack_misc(void)
 	: __clobber_all);
 }
 
-/* stacksafe(): check that stack spill of a precise scalar in old state
- * is not considered equivalent to STACK_MISC in cur state.
+/*
+ * stacksafe(): check that the state with STACK_MISC is not considered to be
+ * within the state with a stack spill of a known scalar, which is there.
  */
 SEC("socket")
 __success __log_level(2)
-/* verifier should visit 'if r1 == 0x2a ...' two times:
- * - once for path entry - label 2;
- * - once for path entry - label 1 - label 2.
- */
-__msg("if r1 == 0x2a goto pc+0")
-__msg("if r1 == 0x2a goto pc+0")
-__msg("processed 15 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* what is loaded is not known to be 42 */
+__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar() R10=fp0 fp-8=mmmmmmmm")
+__msg("9: (15) if r1 == 0x2a goto pc+0       ; R1=scalar()")
+__msg("processed 12 insns")
 __naked void old_precise_scalar_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u64*)(r10 - 8) = r0;"
 	"*(u32*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should not be considered safe on second visit */
 	"r1 = *(u64*)(r10 - 8);"
-	/* use r1 in precise context */
+	/* the value of r1 matters */
 	"if r1 == 42 goto +0;"
+	/* r0 is dead where the states meet: they differ in fp-8 only */
+	"r0 = 0;"
 	"exit;"
 	:
 	: __imm(bpf_ktime_get_ns)
 	: __clobber_all);
 }
 
-/* stacksafe(): check if STACK_MISC in old state is considered
- * equivalent to stack spill of a scalar in cur state.
+/*
+ * stacksafe(): check if the state with a stack spill of a scalar is considered
+ * to be within the state with STACK_MISC, which is there.
  */
 SEC("socket")
 __success  __log_level(2)
+__msg("from 4 to 8: within")
 __msg("8: (79) r0 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 10 insns")
 __naked void old_stack_misc_vs_cur_scalar(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
 	/* conjure STACK_{MISC,INVALID} at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 4) = r0;"
-	"goto 2f;"
-"1:"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r0 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1232,21 +1156,16 @@ __naked void old_stack_misc_vs_cur_scalar(void)
 	: __clobber_all);
 }
 
-/* stacksafe(): check that STACK_MISC in old state is not considered
- * equivalent to stack spill of a non-scalar in cur state.
+/*
+ * stacksafe(): the state with STACK_MISC is there, the state with a stack spill
+ * of a non-scalar arrives. A program that may read uninitialized stack may
+ * take a pointer for a number: the second state is within the first one.
  */
 SEC("socket")
 __success  __log_level(2)
-/* verifier should process exit instructions twice:
- * - once for path entry - label 2;
- * - once for path entry - label 1 - label 2.
- */
-__msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("9: (95) exit")
-__msg("from 2 to 7")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 4 to 8: within")
+__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar()")
+__msg("processed 10 insns")
 __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 {
 	asm volatile(
@@ -1255,16 +1174,16 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
+	/* conjure context pointer in fp-8 */
+	"*(u64*)(r10 - 8) = r9;"
+	"goto 2f;"
+"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u64*)(r10 - 8) = r0;"
 	"*(u32*)(r10 - 4) = r0;"
-	"goto 2f;"
-"1:"
-	/* conjure context pointer in fp-8 */
-	"*(u64*)(r10 - 8) = r9;"
 "2:"
-	/* read fp-8, should not be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1310,35 +1229,34 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 }
 
 /*
- * stacksafe(): check if 32-bit scalar spill in old state is considered
- * equivalent to STACK_MISC in cur state.
+ * stacksafe(): the state with a 32-bit spill of an unknown scalar is there, the
+ * state with STACK_MISC arrives. The second one is within the first one.
  * 32-bit scalar spill creates slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL.
  * Without 32-bit spill support in stacksafe(), the STACK_SPILL vs STACK_MISC
- * mismatch at slot[4] causes pruning to fail.
+ * mismatch at slot[4] says that it is not.
  */
 SEC("socket")
 __success __log_level(2)
+__msg("from 5 to 8: within")
 __msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 10 insns")
 __naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure 32-bit scalar spill at fp-8 */
-	"r0 = 42;"
-	"*(u32*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 6) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure 32-bit scalar spill at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u32*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index d9d7b05cf6d2..f4e7f47e4cdd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -469,9 +469,9 @@ l3_%=:	r1 = r7;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: regsafe() check_ids() similar id mappings")
-__success __msg("29: safe")
+__success __msg("to 29: within")
 __failure_unpriv __msg_unpriv("")
-__log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2) __retval(0)
 __naked void check_ids_similar_id_mappings(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index e6a9021b197b..e9194a560fbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -587,14 +587,13 @@ __naked void stack_check_size_512_with_may_goto(void)
 #endif
 
 /*
- * Verify that old PTR_TO_STACK state is considered a super-set of
- * new PTR_TO_STACK state when the new offset is within the old range,
- * e.g. old [-72, -16] vs new {-16}.
+ * Verify that a PTR_TO_STACK state is considered a super-set of
+ * another PTR_TO_STACK state when the offset of that is within its range,
+ * e.g. [-72, -16] vs {-16}.
  */
 SEC("socket")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 /*
  * r7 is widened to [-72, -16] at the loop header (insn 5),
  * the loop body sees [-64, -8] after 'r7 += 8'.
@@ -604,9 +603,9 @@ __msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
 /* 'r7 = r8' sets r7 to fp-16; its ANY SCEV is not clamped. */
 __msg("R7=fp-16 R8=fp-16 loop_stack=5")
 __not_msg("clamping r7")
-/* back-edge state is pruned because {-16} is within [-72, -16]. */
-__msg("from 8 to 5: safe")
-__msg("processed 12 insns")
+/* back-edge state goes no further because {-16} is within [-72, -16]. */
+__msg("from 8 to 5: within")
+__msg("processed 11 insns")
 __naked void stack_ptr_subrange_in_loop(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index dc0c7034c04f..041b7a71fb3f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -39,31 +39,21 @@ static unsigned long callback_subprog()
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r0                      ; R0=12 R1=map_value(map=.data.vals,ks=4,vs=16,imm=12)")
 __naked int subprog_result_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
-		/* pass r6 through r1 into subprog to get it back as r0;
-		 * this whole chain will have to be marked as precise later
-		 */
+		/* pass r6 through r1 into subprog to get it back as r0 */
 		"r1 = r6;"
 		"call identity_subprog;"
 		/* now use subprog's returned value (which is a
-		 * r6 -> r1 -> r0 chain), as index into vals array, forcing
-		 * all of that to be known precisely
+		 * r6 -> r1 -> r0 chain), as index into vals array
 		 */
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0->r1->r6 chain is forced to be precise and has to be
-		 * propagated back to the beginning, including through the
+		/*
+		 * here r0 has to be known: the constant went through the
 		 * subprog call
 		 */
 		"r1 += r0;"
@@ -98,26 +88,18 @@ static unsigned long sneaky_fp_leaking_subprog()
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
-__msg("mark_precise: frame0: regs=r0 stack= before 10: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 9: (bf) r0 = (s8)r10")
-__msg("7: R0=scalar")
+__msg("3: R0=scalar() R6=")
+__msg("6: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int fp_precise_subprog_result(void)
 {
 	asm volatile (
 		"call fp_leaking_subprog;"
 		/* use subprog's returned value (which is derived from r10=fp
-		 * register), as index into vals array, forcing all of that to
-		 * be known precisely
+		 * register, so it's unknown), as index into vals array
 		 */
 		"r0 &= 3;"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* force precision marking */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -129,31 +111,18 @@ __naked int fp_precise_subprog_result(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = (s8)r1")
-/* here r1 is marked precise, even though it's fp register, but that's fine
- * because by the time we get out of subprogram it has to be derived from r10
- * anyways, at which point we'll break precision chain
- */
-__msg("mark_precise: frame1: regs=r1 stack= before 9: (bf) r1 = r10")
-__msg("7: R0=scalar")
+__msg("3: R0=scalar() R6=")
+__msg("6: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int sneaky_fp_precise_subprog_result(void)
 {
 	asm volatile (
 		"call sneaky_fp_leaking_subprog;"
 		/* use subprog's returned value (which is derived from r10=fp
-		 * register), as index into vals array, forcing all of that to
-		 * be known precisely
+		 * register, so it's unknown), as index into vals array
 		 */
 		"r0 &= 3;"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* force precision marking */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -165,35 +134,25 @@ __naked int sneaky_fp_precise_subprog_result(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0")
-__msg("mark_precise: frame0: regs=r0 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 7: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (a5) if r0 < 0x4 goto pc+1")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (85) call pc+7")
+__msg("9: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int global_subprog_result_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
 		/* pass r6 through r1 into subprog to get it back as r0;
-		 * given global_identity_subprog is global, precision won't
-		 * propagate all the way back to r6
+		 * given global_identity_subprog is global, nothing is known
+		 * about what it returns
 		 */
 		"r1 = r6;"
 		"call global_identity_subprog;"
 		/* now use subprog's returned value (which is unknown now, so
-		 * we need to clamp it), as index into vals array, forcing r0
-		 * to be marked precise (with no effect on r6, though)
+		 * we need to clamp it), as index into vals array
 		 */
 		"if r0 < %[vals_arr_sz] goto 1f;"
 		"r0 = %[vals_arr_sz] - 1;"
 	"1:"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0 is forced to be precise and has to be
-		 * propagated back to the global subprog call, but it
-		 * shouldn't go all the way to mark r6 as precise
-		 */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -213,11 +172,9 @@ static unsigned long loop_callback_bad()
 		"if r0 s> 1000 goto 1f;"
 		"r0 = 0;"
 	"1:"
-		"goto +0;" /* checkpoint */
+		"goto +0;"
 		/* bpf_loop() expects [0, 1] values, so branch above skipping
-		 * r0 = 0; should lead to a failure, but if exit instruction
-		 * doesn't enforce r0's precision, this callback will be
-		 * successfully verified
+		 * r0 = 0; should lead to a failure
 		 */
 		"exit;"
 		:
@@ -228,14 +185,8 @@ static unsigned long loop_callback_bad()
 
 SEC("?raw_tp")
 __failure __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame1: regs=r0 stack= before 11: (b7) r0 = 0")
-/* check that we have branch code path doing its own validation */
-__msg("from 10 to 12: frame1: R0=scalar(smin=umin=1001")
-/* check that branch code path marks r0 as precise, before failing */
-__msg("mark_precise: frame1: regs=r0 stack= before 9: (85) call bpf_get_prandom_u32#7")
-__msg("At callback return the register R0 has smin=1001 should have been in [0, 1]")
+/* 0 of the fallthrough code path doesn't stand for what the branch code path has */
+__msg("At callback return the register R0 has {{.*}} should have been in [0, 1]")
 __naked int callback_precise_return_fail(void)
 {
 	asm volatile (
@@ -256,41 +207,15 @@ __naked int callback_precise_return_fail(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body,
- * r1 and r4 are always precise for bpf_loop() calls.
- */
 __msg("9: (85) call bpf_loop#181")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: parent state regs=r4 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r4 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: parent state regs=r1 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r1 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs=r1 stack= before 7: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs=r1 stack= before 6: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs=r1 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* r6 precision propagation */
-__msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
-__msg("mark_precise: frame0: regs=r0,r6 stack= before 10: (bf) r6 = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
-/* State entering callback body popped from states stack */
-__msg("from 9 to 17: frame1:")
 __msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-__msg("frame 0: propagating r1,r3,r4")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4 stack= before 18: (95) exit")
-__msg("from 18 to 9: safe")
+/* the callback changes nothing for the caller */
+__msg("from 18 to 9: within")
+__msg("14: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int callback_result_precise(void)
 {
 	asm volatile (
@@ -309,9 +234,7 @@ __naked int callback_result_precise(void)
 		"if r6 > 3 goto 1f;"
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the bpf_loop() call, but not beyond
-		 */
+		/* here the range of r6 has to be known */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 	"1:"
@@ -326,15 +249,7 @@ __naked int callback_result_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 7 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 10: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs= stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_callee_saved_reg_precise(void)
 {
 	asm volatile (
@@ -348,9 +263,7 @@ __naked int parent_callee_saved_reg_precise(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -362,13 +275,7 @@ __naked int parent_callee_saved_reg_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 7 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_callee_saved_reg_precise_global(void)
 {
 	asm volatile (
@@ -382,9 +289,7 @@ __naked int parent_callee_saved_reg_precise_global(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -396,36 +301,14 @@ __naked int parent_callee_saved_reg_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
-__msg("12: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 12 first_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 10: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 9: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (b7) r1 = 1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* State entering callback body popped from states stack */
-__msg("from 9 to 15: frame1:")
+__msg("12: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __msg("15: frame1: R10=fp0 cb")
 __msg("15: (b7) r0 = 0")
 __msg("16: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r1, r4 are always precise for bpf_loop(),
- * r6 was marked before backtracking to callback body.
- */
-__msg("frame 0: propagating r1,r3,r4,r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4,r6 stack= before 16: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs= stack=:")
-__msg("from 16 to 9: safe")
+/* r6 is what it was before the callback */
+__msg("from 16 to 9: within")
 __naked int parent_callee_saved_reg_precise_with_callback(void)
 {
 	asm volatile (
@@ -442,9 +325,7 @@ __naked int parent_callee_saved_reg_precise_with_callback(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) callback call
-		 */
+		/* here r6 has to be known: the callback doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -458,19 +339,7 @@ __naked int parent_callee_saved_reg_precise_with_callback(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 6")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 13 first_idx 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 13: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 12: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs= stack= before 5: (85) call pc+6")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("9: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_stack_slot_precise(void)
 {
 	asm volatile (
@@ -492,9 +361,7 @@ __naked int parent_stack_slot_precise(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -506,15 +373,7 @@ __naked int parent_stack_slot_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (85) call pc+6")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("9: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_stack_slot_precise_global(void)
 {
 	asm volatile (
@@ -536,9 +395,7 @@ __naked int parent_stack_slot_precise_global(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -550,38 +407,14 @@ __naked int parent_stack_slot_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
-__msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 10")
-__msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 10: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0 subseq_idx 10")
-__msg("mark_precise: frame0: regs= stack=-8 before 9: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 8: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* State entering callback body popped from states stack */
-__msg("from 10 to 17: frame1:")
+__msg("14: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 10:")
-/* r1, r4 are always precise for bpf_loop(),
- * fp-8 was marked before backtracking to callback body.
- */
-__msg("frame 0: propagating r1,r3,r4,fp-8")
-__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4 stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
-__msg("mark_precise: frame0: parent state regs= stack=:")
-__msg("from 18 to 10: safe")
+/* fp-8 is what it was before the callback */
+__msg("from 18 to 10: within")
 __naked int parent_stack_slot_precise_with_callback(void)
 {
 	asm volatile (
@@ -604,9 +437,7 @@ __naked int parent_stack_slot_precise_with_callback(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the callback doesn't change fp-8 */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -621,27 +452,18 @@ __naked int parent_stack_slot_precise_with_callback(void)
 __noinline __used
 static __u64 subprog_with_precise_arg(__u64 x)
 {
-	return vals[x]; /* x is forced to be precise */
+	return vals[x]; /* x has to be known */
 }
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("8: (0f) r2 += r1")
-__msg("mark_precise: frame1: last_idx 8 first_idx 0")
-__msg("mark_precise: frame1: regs=r1 stack= before 6: (18) r2 = ")
-__msg("mark_precise: frame1: regs=r1 stack= before 5: (67) r1 <<= 2")
-__msg("mark_precise: frame1: regs=r1 stack= before 2: (85) call pc+2")
-__msg("mark_precise: frame0: regs=r1 stack= before 1: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 0: (b7) r6 = 3")
+__msg("8: (0f) r2 += r1                      ; R1=12 R2=map_value(map=.data.vals,ks=4,vs=16,imm=12)")
 __naked int subprog_arg_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
 		"r1 = r6;"
-		/* subprog_with_precise_arg expects its argument to be
-		 * precise, so r1->r6 will be marked precise from inside the
-		 * subprog
-		 */
+		/* subprog_with_precise_arg needs to know its argument */
 		"call subprog_with_precise_arg;"
 		"r0 += r6;"
 		"exit;"
@@ -666,7 +488,7 @@ static __u64 subprog_spill_reg_precise(void)
 		 * verifier log output)
 		 */
 		"*(u64 *)(r10 - 16) = r2;"
-		/* use both spills as return result to propagete precision everywhere */
+		/* use both spills as return result */
 		"r0 = *(u64 *)(r10 - 16);"
 		"r2 = *(u64 *)(r1 + 0);"
 		"r0 += r2;"
@@ -676,32 +498,14 @@ static __u64 subprog_spill_reg_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("10: (0f) r1 += r7")
-__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
-__msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
-__msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R8=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8=P1")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
-__msg("mark_precise: frame1: regs= stack= before 16: (79) r2 = *(u64 *)(r1 +0)")
-__msg("mark_precise: frame1: regs= stack= before 15: (79) r0 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame1: regs= stack= before 14: (7b) *(u64 *)(r10 -16) = r2")
-__msg("mark_precise: frame1: regs= stack= before 13: (7b) *(u64 *)(r1 +0) = r2")
-__msg("mark_precise: frame1: regs=r2 stack= before 6: (85) call pc+6")
-__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r2 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+__msg("10: (0f) r1 += r7                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=4) R7=4")
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
 		"r6 = 1;"
 
 		/* pass pointer to stack slot and r6 to subprog;
-		 * r6 will be marked precise and spilled into fp-8 slot, which
-		 * also should be marked precise
+		 * r6 will be spilled into fp-8 slot
 		 */
 		"r1 = r10;"
 		"r1 += -8;"
@@ -716,8 +520,9 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
 
 		"r7 *= 4;"
 		"r1 = %[vals];"
-		/* here r7 is forced to be precise and has to be propagated
-		 * back to the beginning, handling subprog call and logic
+		/*
+		 * here r7 has to be known: it's what the subprog spilled into
+		 * the stack slot of its caller
 		 */
 		"r1 += r7;"
 		"r0 = *(u32 *)(r1 + 0);"
@@ -730,32 +535,12 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("17: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 16: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 15: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 14: (79) r0 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 13: (7b) *(u64 *)(r7 -8) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (79) r0 = *(u64 *)(r8 +16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (7b) *(u64 *)(r8 +16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 10: (79) r0 = *(u64 *)(r7 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 8: (07) r8 += -32")
-__msg("mark_precise: frame0: regs=r0 stack= before 7: (bf) r8 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 6: (07) r7 += -8")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r7 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 21: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 20: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (85) call pc+15")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+__msg("17: (0f) r1 += r0                     ; R0=4 R1=map_value(map=.data.vals,ks=4,vs=16,imm=4)")
 __naked int stack_slot_aliases_precision(void)
 {
 	asm volatile (
 		"r6 = 1;"
-		/* pass r6 through r1 into subprog to get it back as r0;
-		 * this whole chain will have to be marked as precise later
-		 */
+		/* pass r6 through r1 into subprog to get it back as r0 */
 		"r1 = r6;"
 		"call identity_subprog;"
 		/* let's setup two registers that are aliased to r10 */
@@ -777,11 +562,11 @@ __naked int stack_slot_aliases_precision(void)
 		"r0 = *(u64 *)(r8 + 16);"
 		"*(u64 *)(r7 - 8) = r0;"
 		"r0 = *(u64 *)(r10 - 16);"
-		/* get ready to use r0 as an index into array to force precision */
+		/* get ready to use r0 as an index into array */
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0->r1->r6 chain is forced to be precise and has to be
-		 * propagated back to the beginning, including through the
+		/*
+		 * here r0 has to be known: the constant went through the
 		 * subprog call and all the stack spills and loads
 		 */
 		"r1 += r0;"
@@ -789,7 +574,7 @@ __naked int stack_slot_aliases_precision(void)
 		"exit;"
 		:
 		: __imm_ptr(vals)
-		: __clobber_common, "r6"
+		: __clobber_common, "r6", "r7", "r8"
 	);
 }
 
@@ -820,15 +605,11 @@ static unsigned long identity_tail_call(void)
 SEC("?raw_tp")
 __failure __log_level(2)
 __msg("13: (85) call bpf_tail_call#12")
-__msg("mark_precise: frame1: last_idx 13 first_idx 0 subseq_idx -1 ")
 __msg("returning from callee:")
 __msg("frame1: R0=scalar() R6=3 R10=fp0")
 __msg("to caller at 4:")
 __msg("R0=scalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
 __msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=Pscalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
 __msg("math between map_value pointer and register with unbounded min value is not allowed")
 __naked int subprog_result_tail_call(void)
 {
@@ -860,36 +641,22 @@ static int ld_abs_subprog(void)
 }
 
 /*
- * Buggy verifier did not properly backtrack early subprogram exit
- * modelled for BPF_LD | BPF_ABS instruction, causing a segfault.
+ * BPF_LD | BPF_ABS instruction is modelled as an early exit of the subprogram.
+ * r7 is known on both paths.
  */
 SEC("socket")
 __success
 __log_level(2)
-/* early exit path */
-__msg("3: (0f) r1 += r7")
-__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r7 stack= before 9: (20) r0 = *(u32 *)skb[0]")
-__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
-__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
-__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
-/* fallthrough path */
-__msg("3: (0f) r1 += r7")
-__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r7 stack= before 10: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 9: (20) r0 = *(u32 *)skb[0]")
-__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
-__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
-__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
+/* the early exit and the exit of the subprogram give the same state */
+__msg("from 10 to 2: within")
+__msg("3: (0f) r1 += r7                      ; R1=fp-8 R7=-8")
 __naked int ld_abs_backtrack_both_paths(void)
 {
 	asm volatile (
 		"r7 = -8;"
 		"call ld_abs_subprog;"
 		"r1 = r10;"
-		"r1 += r7;" /* mark r7 as precise */
+		"r1 += r7;"
 		"*(u64 *)(r1 + 0) = 0;"
 		"r0 = 0;"
 		"exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_or_null.c b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
index 8ff668a242eb..2a5bdac24925 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
@@ -183,7 +183,7 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("invalid map access from else condition")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void map_access_from_else_condition(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index b3b701b44550..f9ad07704578 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -225,8 +225,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
@@ -270,8 +269,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 399884911ea5..d92215c5b923 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -63,7 +63,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves spilled zero")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_spilled_zero(void)
@@ -89,7 +88,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves spilled zero across slots")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8,-16")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_spilled_zero_across_slots(void)
@@ -116,7 +114,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves partial spilled zero")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_partial_spilled_zero(void)
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index a9242103dc47..de9d35ed8a4b 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -36,26 +36,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
-	.errstr =
-	"mark_precise: frame0: last_idx 26 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 19 first_idx 10\
-	mark_precise: frame0: regs=r2 stack= before 19\
-	mark_precise: frame0: regs=r9 stack= before 18\
-	mark_precise: frame0: regs=r8,r9 stack= before 17\
-	mark_precise: frame0: regs=r0,r9 stack= before 15\
-	mark_precise: frame0: regs=r0,r9 stack= before 14\
-	mark_precise: frame0: regs=r9 stack= before 13\
-	mark_precise: frame0: regs=r9 stack= before 12\
-	mark_precise: frame0: regs=r9 stack= before 11\
-	mark_precise: frame0: regs=r9 stack= before 10\
-	mark_precise: frame0: parent state regs= stack=:",
+	.result = ACCEPT,
 },
 {
 	"precise: test 2",
@@ -95,24 +76,8 @@
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	mark_precise: frame0: last_idx 26 first_idx 22\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 19 first_idx 17\
-	mark_precise: frame0: regs=r2 stack= before 19\
-	mark_precise: frame0: regs=r9 stack= before 18\
-	mark_precise: frame0: regs=r8,r9 stack= before 17\
-	mark_precise: frame0: parent state regs= stack=:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,17 +118,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 4 first_idx 2\
-	mark_precise: frame0: regs=r4 stack= before 4\
-	mark_precise: frame0: regs=r4 stack= before 3\
-	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 4 first_idx 2\
-	mark_precise: frame0: regs=r0 stack= before 4\
-	5: R0=-1 R4=0",
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.retval = -1,
 },
 {
@@ -182,23 +137,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 6 first_idx 4\
-	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
-	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
-	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 3 first_idx 3\
-	mark_precise: frame0: regs=r0 stack= before 3: (55) if r3 != 0x7b goto pc+0\
-	mark_precise: frame0: regs=r0 stack= before 2: (bf) r3 = r10\
-	mark_precise: frame0: regs=r0 stack= before 1: (57) r0 &= 255\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 0 first_idx 0\
-	mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7\
-	mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs= stack=:",
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.retval = -1,
 },
 {
-- 
2.55.0

