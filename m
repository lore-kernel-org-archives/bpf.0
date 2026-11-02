Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599178;
	b=h033wfkLvKdb6clo/uQpY1iSz1aAHx+jyObQW7Qk+fFfSCvk39wwvq5eJmplBo5nOaXu
	 MDmw7AZ/ZHRJHHokGkSqbrSgiMaspmk0uZRzt5LRX1Gc8F2jtgcuVHs32kSt3e8X2neSt
	 Vul14+NhcYfGE/ZdLqsBGK3iQPyelZNaxiXQSCdIs8Cev08HcA/QsDsTqv+0Kzk112Nhw
	 1Jy11ZIogbDSzCpp7ObO1yHdGk3EkWZ1FNpWA84oi1uhWor3TsWqlxnMIgtpWueozonD3
	 okKJPw2KW+P+3Z4G1wdVrWZiyri3IRVN4z88pQpHy+DO8qm5riDt0cHgagYC9VZ/+Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ftLi+uEssVWbFqe//a9M+9AcEdbK38T5yBT1cewzn9U=;
	b=kcXxX6rodKYIZfrbwiMQZKDt04pSubmZ9bytH0A8slSG/0oqAIqqswCaSKSe+cRELZ7K
	 NZ6JEEbMrjz1u9gaa7ZI0eCElBsCs7+t4Q+raDs961hxy6bEb6PcL+jzHfoxCjypdn8XC
	 pPNhE39/nEYPxj30/5RohVbIoVPbsV/bmQLoxfmoOS1OXGtkQ0ns/Sjv57tNwqNfnTQ2D
	 frl7ldzV0cPiewiDB6Wt6j3BGHNbdSjAhafrYMTPdmXBP/zF6aY9vgvdzpsHcATwyyKmY
	 XUy6x9b0QULZYMRWdFza5zG3GDUIbm1IKuqcLgj5NHKWQjMzmRQrT78gySI93G2tGHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCN1ik1T;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7F606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BF7F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCN1ik1T
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1757646a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599177; x=1794203977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftLi+uEssVWbFqe//a9M+9AcEdbK38T5yBT1cewzn9U=;
        b=eCN1ik1TkbRtJPad9TkTWL6QRuN9Ubm08TNmdYt3QpXINCJZdHuZf9Gglp+VD5cdbM
         jcuEjTNgqZH5qFcUPzRKeUjEpkC5wuMSIVu+skvsOgP63fvv2xt9FVPJAuelt06CNG5q
         kEhHSxcgVDoZAjcec9dR+l41iXJL0MG0v3o0eB45kPhhuaOqjt20F6QYbB9E5zy8uIs7
         FMXBa7wWGZsUAIh7tz1wuJL59ucLFs5tlURpxsDtAsc+XRwbMNMdZ2n2XQV6TKcBIYDV
         FmTEmtXZsQImsZL/vjrQtOE0nTMku/wb0jt498U3jXePL8dCiyOCmjxEOUQ0zAEdzrw9
         dqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599177; x=1794203977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftLi+uEssVWbFqe//a9M+9AcEdbK38T5yBT1cewzn9U=;
        b=fEMUE5ywRNT2b5/aH2Hc2fNagjTGknC09tewDGW9ljkOHKhWxxM0uyC/GAC5ABe6+Q
         G+JahyUmCV0g4iXNSZjvKBHFeHuEc0iX/M8sfdtWLjywi/9OglrAM5h0YED794PQ4k8l
         hMImTcpQPEh/LCWCufE9X0u68LBQUGLSHNWq3oYUYncI12WoCFX9jfXS9mgK4/TeB+q6
         VMpPfjVtREAcQ8rj/hze1bOGCbpvXmaX0EGL90mjn0nao8l2J5tEiMlAclja0mIOOKHh
         vpW8JmmUqgGKfrdauktCcRzsMb1nJGzKXyk3Lu/96Nq0rGQZ9/1dQzncbeVy43kMZjX3
         DVxQ==
X-Gm-Message-State: APuU4Z+5OQEfSAydDCZ5fKckHt/6tf9/yyU29cJ/v4Z9QFyreScyTCD2
	BiQjmZP9tJ+NtvAyzvouEsDUOz9Itwgz1tyC5amZJBwT1YVgHk2638A7L3p7VA==
X-Gm-Gg: AYBFou1Nhf4RwO6dLCe1da+MDDwizha4uXF3lEJKMWSNZCsPC20pFBeLVKKyTqZl6nh
	PoTjE/y5HfzRvbV/KdSiS/jlOpDlcEFneR8FcsOm4e43735p730OOYqxwtaW/5J36mimVVQBhBv
	tP75p66pWjr5TgB15EZjx/dTb3htsT0b8lyKGis7K0PEJZGEERVTnnkqzfjCVbilAoz2AE3PiCw
	ljxznsLZH0tpCOHp3xsKDFliskboQ24q3dA2RrANgwMPl8lL/SwWqqsDMa32H9iuYuY4yIcg7nW
	YMmuDJDGT/AVG9xI5izUy8DkI+StXM5GkxK9DfyYsV3kRJya5cur46lird0fGT3TvrutO5uYKwx
	Ef+nx47CaJo9gS/XXxRKcVL/3UBznGXcovMtDGHEH2grq36TkA/EApfEeFkCJT54xLxS5j25Ztw
	P2PBEn2keCqn1zpwvq8ihm7jGd3ZAQ7K830jkg5DZTrAqeh7nHUMTQks4eXVgapvfNtIT6jg4pT
	CQL7ga9Koco3E6wIzoN+Chg3eGar3Sg/aY91P4LyJ6Ja8e7bpKmfHFNQ3h8k1cy43Ltt/TqorJg
	Tlldm0yx/97bDq23BoUs/gEAB7zM9u3AZkxwwPbpkug67BpcaqwmBYV/wUEDCIWHNu8o4Jar0hm
	mVMQJgUULysHtvwASNa5s45tMy4W9gpuyib8s8nYRwtpkrDKBlgMvs9APg3JdpaovAs6+qDw6PQ
	==
X-Received: by 2002:a17:90b:17c8:b0:3a8:c3b9:4b38 with SMTP id 98e67ed59e1d1-3ae6efb5a82mr8100417a91.14.1793599177196;
        Sun, 01 Nov 2026 21:59:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm16971238a91.2.2026.11.01.21.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:59:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 3/4] bpf: Don't trust pointers spilled in slots that a callee can write
Date: Mon,  2 Nov 2026 05:59:12 +0000
Message-ID: <20261102055913.3598414-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
References: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
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

arg_track follows pointers to the stack through registers and spills.
Scalar evolution and the removal of dead slots rely on it to know which
slots an insn reads and writes.

arg_track assumes that a call does not change the pointers that are spilled
in the frame of the caller. But a static subprog or a callback can store
a pointer to other memory there, and the caller can use it:

  *(u64 *)(r10 - 16) = fp-8
  r1 = fp-16, r2 = map_value
  call sub                        ; *(u64 *)(r1 + 0) = r2
  r7 = *(u64 *)(r10 - 16)         ; verifier: map_value. arg_track: fp-8
  *(u64 *)(r10 - 8) = fp-24
  *(u64 *)(r7 + 0) = 0            ; arg_track: fp-8 is overwritten
  r8 = *(u64 *)(r10 - 8)          ; verifier: fp-24. arg_track: none
  loop:
    r1 = *(u64 *)(r10 - 24)       ; the counter of the loop
    ...
    *(u64 *)(r8 + 0) = 4096       ; arg_track: not a write to fp-24

Scalar evolution does not see the last store. It gives the counter the
range of a loop that only increments it. The prog loads, and it accesses
a map value out of bounds.

Valid progs are rejected as well. The store through r7 makes fp-8 dead, and
a later read of fp-8 fails with "slot poisoned by dead code elimination".

When a static subprog or a callback can get a pointer to the frame of its
caller, join every slot of that frame with "not a pointer to the stack".
Reads and possible writes through a filled pointer are still seen, but no
store through it is a certain write. It has to be every slot: the callee
reaches the whole frame from one pointer, and callees are analyzed after
the caller. The price is precision: an 8-byte load through a filled
pointer gives a value that can point to any frame.

For a spilled copy of r10 this needs "bpf: Fix the join of fp+0 with
a value that is not a pointer to stack".

In selftests, Cilium and sched_ext the stack marks change in 4 of 12522
progs. Verdicts, insns and states do not change in any prog.

one_fp_clear_stack_threshold and two_fp_clear_stack_threshold expect the
fake offset fp+0 in the log now.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c                         | 52 ++++++++++++++-----
 .../selftests/bpf/progs/verifier_live_stack.c | 12 +++--
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index db01aecdffba..75d9af4921de 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1383,6 +1383,31 @@ static struct arg_track arg_track_deref(struct bpf_verifier_env *env, struct bpf
 	return (struct arg_track){ .frame = ARG_NONE };
 }
 
+/*
+ * True if the call at @insn_idx can pass a pointer to the frame at @depth to a static subprog
+ * or to a callback. They use it as a pointer to stack, a global subprog gets plain memory.
+ * It errs on the safe side: it looks at all argument registers and stack args, also at those
+ * that this callee doesn't take.
+ */
+static bool subprog_gets_local_fp(struct bpf_verifier_env *env, struct bpf_insn *insn, int insn_idx,
+				  struct arg_track *at, int depth)
+{
+	int r;
+
+	if (bpf_pseudo_call(insn)) {
+		r = bpf_find_subprog(env, insn_idx + insn->imm + 1);
+		if (r >= 0 && bpf_subprog_is_global(env, r))
+			return false;
+	} else if (!bpf_is_callx(insn) && !bpf_calls_callback(env, insn_idx)) {
+		return false;
+	}
+	/* R1-R5 and stack args */
+	for (r = BPF_REG_1; r < MAX_AT_TRACK_REGS; r++)
+		if ((r <= BPF_REG_5 || r >= MAX_BPF_REG) && can_be_local_fp(depth, r, &at[r]))
+			return true;
+	return false;
+}
+
 /*
  * Pure dataflow transfer function for arg_track state.
  * Updates at_out[] based on how the instruction modifies registers.
@@ -1446,21 +1471,22 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*dst = none;
 	} else if (class == BPF_JMP && code == BPF_CALL) {
 		/*
-		 * at_stack_out[slot] is not cleared by the helper and subprog calls.
-		 * The fill_from_stack() may return the stale spill — which is an FP-derived arg_track
-		 * (the value that was originally spilled there). The loaded register then carries
-		 * a phantom FP-derived identity that doesn't correspond to what's actually in the slot.
-		 * This phantom FP pointer propagates forward, and wherever it's subsequently used
-		 * (as a helper argument, another store, etc.), it sets stack liveness bits.
-		 * Those bits correspond to stack accesses that don't actually happen.
-		 * So the effect is over-reporting stack liveness — marking slots as live that aren't
-		 * actually accessed. The verifier preserves more state than necessary across calls,
-		 * which is conservative.
+		 * Helpers, kfuncs and global subprogs can scratch stack slots. The verifier reads
+		 * a scalar from a scratched slot, but at_stack_out[slot] is not cleared, and
+		 * fill_from_stack() returns the stale spill: an FP-derived arg_track for a scalar.
+		 * A scalar can't be dereferenced, so the stale value can only set liveness bits
+		 * for stack accesses that don't happen. That is conservative.
 		 *
-		 * helpers can scratch stack slots, but they won't make a valid pointer out of it.
-		 * subprogs are allowed to write into parent slots, but they cannot write
-		 * _any_ FP-derived pointer into it (either their own or parent's FP).
+		 * Static subprogs and callbacks can't store an FP-derived pointer into the frame of
+		 * the caller, but they can store any other pointer there. The caller can fill it
+		 * and store through it. With the stale spill that store would be a definite write
+		 * to a stack slot, and it doesn't touch the stack. Callees are analyzed after the
+		 * caller, and they reach the whole frame from one pointer to it. So after the call
+		 * every slot holds what it held before or a value that is not FP-derived.
 		 */
+		if (subprog_gets_local_fp(env, insn, insn_idx, at_out, depth))
+			for (slot = 0; slot < nslots; slot++)
+				at_stack_out[slot] = __arg_track_join(at_stack_out[slot], none);
 		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
 			at_out[r] = none;
 	} else if (class == BPF_LDX) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index b5ae4f0d4dc5..61833ea784d0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1943,11 +1943,15 @@ static __used __naked void grandchild_deref(void)
 	::: __clobber_all);
 }
 
+/*
+ * The callee gets a pointer to the frame that holds the spills. It can store a pointer
+ * that is not FP-derived over them: after the call each of them is "fp-N or not FP-derived".
+ */
 SEC("socket")
 __log_level(2)
 __success
-__msg("14: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
-__msg("15: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16 r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
+__msg("14: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0 fp-16=fp0-8|fp0+0")
+__msg("15: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16|fp1+0 r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0")
 __msg("stack use/def subprog#1 mid_two_fp_threshold (d1,cs2):")
 __msg("14: (79) r1 = *(u64 *)(r10 -8)        ; use: fp1-8")
 __msg("15: (79) r0 = *(u64 *)(r1 +0)         ; use: fp1-16")
@@ -1992,8 +1996,8 @@ static __used __naked void inner_nop_fptest(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("13: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
-__msg("14: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16 r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
+__msg("13: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0 fp-16=fp0-8|fp0+0")
+__msg("14: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16|fp1+0 r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0")
 __msg("stack use/def subprog#1 mid_one_fp_threshold (d1,cs2):")
 __msg("13: (79) r1 = *(u64 *)(r10 -8)        ; use: fp1-8")
 __msg("14: (79) r0 = *(u64 *)(r1 +0)         ; use: fp1-16")
-- 
2.55.0

