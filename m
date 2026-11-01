Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494028;
	b=pQ/R32gctawmbxCErgiwgLDMLYVoK/4G48+CPs2cZnJkzDKpKrlwTbD03at51y8OqCBq
	 2VfAdDhEA50sV4LZkVd/snQMB7D5GAAd/foFJiHzO2WhV68xqOzyfvWOHmHvk9x3+nKZF
	 ellSy0Xnql6Remzs9q68PIyABn1sh8v1tAwZaXmFrX7etstxAmXSY69gxhqEzpe+j2obM
	 uhCvCrKATQvAHH7OPqTr//TqDLtYs/z+GJI2mA14ElB82cWmTwdVEDSuDMXQz9JWK0hp6
	 Jk2UsGixTXjamj5SOtheTvaxPwcHkNAiDeTRBfeKgp+TrRksxiTjLAOBUF8ZWCe3iEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=msLsy/arjLW6CGHa3kChOB+cBy+BVXwd3ipuX3gWSIQ=;
	b=KD6u20QryGwy2kYevEkIopGaWrTsCPwc8xf7xJ81BuXUkJEFwjflDIm9QvHzls6szX/e
	 c2UUMBV6yFBxdOe/Fz9zVy/eI13M1ig03nIpSqPDE7G4D3Z8sgyOkAEB5q/Kc4YYHQoVQ
	 vfGls4UvTv3Zrk0kWgO4I7KsyGbYUq5OCDeo6MTHeIPheCCl3otbHiynwh9/G1Ot+QXQ6
	 kbVSnjOuEuuCSp40W/FZWKtKKyeUtsN7EztvNk1XnPUh++2TA6QbIt6piVghas/MpICI/
	 3WvsOHNrrqA7jylPhEySNcJ5304F5q533sc1Vvmyc2OAGKeuUjWQWMOwYDAfgGmR53Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bi6hmQgI;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F3606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bi6hmQgI
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso879712a91.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494028; x=1794098828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msLsy/arjLW6CGHa3kChOB+cBy+BVXwd3ipuX3gWSIQ=;
        b=Bi6hmQgIU0B995WNDFnI9BJzn/RUqif0fOs387h5wtoEIodpnJvOg/hT9oGd89w//Y
         7uSCTdWkWey0hys4nDlOJ797hqz5NjEAzCYpn4sI1Y8Yx3wUKjncOlKCAuw3+vrFGcEb
         iiL9HNovWM7OBssmL9Imr8iyVoMYf4s6Bd/iuUM+iCebz0L4NwNq0sKwOKh6I/FE/BTC
         ZGTvvzyV1J/Oc5oo6gempI82Nf/g6/UEGI0B6ggpWyylBi4ykn6NO+eYAYWc87dOX5mH
         7ItdyYTWztsqWSSry6ETrx/HhVE+wl0x+PZn87WPEHnRkP7SwBhHaKWuCYJNn/uKbgrA
         jXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494028; x=1794098828;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msLsy/arjLW6CGHa3kChOB+cBy+BVXwd3ipuX3gWSIQ=;
        b=D1Ocuu7EkvJDLbut5Thqv5d9qk72EuOjS5m6RpShIDi53M+VFM3PW5FLBN6yvUGsha
         lOAFFAekatBi0M6TZuM7yefFe+aj6Z9O2pOlekyUf2xWB9Ch2bxqVvd/h7wiQN0hduwo
         nTwmO7sA7URQehecxu2FUtFk5SNhZKf0Z5ITtKSwSjmLutpAJrFa680EBGEIextn0gPx
         MPcwvG2L140Ob/5JsFRL0wB8EHSk7LNzCTZTlSQGTiOlk4iZOKQJbZtdkY8LeeTlvUtA
         KxKiusnM7OsAP4gA9FnRXoLzL3QmSYMaYPRg9j9K1+ohbobIp85F4aXJxwwbKyIsM0LZ
         sbAA==
X-Gm-Message-State: AFq9FYILQBKtiiOJne1qnQ0K551O69IVopd0Tgit6wqnvPOtxTcwPUZi
	Ph/nkyBcBSxRUe1bq6X6im8frjZIpi9jmuWWuFGBwqk9UZgOWUbBn70kEdtLvQ==
X-Gm-Gg: AYBFou3fH23A0KaXSzv/MK9iKe8u/UImtawX6ebOfamRzBKs4s/SFzyDU+RVmlacmzp
	yqPA/yKywW8ymZU64Qhf12hEVXLMs0iM3r3QfKBj1He+gvfgNlY70w0K/iNysCOxlHgWtrXYJYG
	wAS0U9HLKlDtcZhsvPpnNQxt/+xDKiD3V/00FnNTxa+1+jztXaVA/GiaYgh4bhTKUvQou2zHCUW
	PMcP9SWolI63vbiNhvGzBG9y55fvcnA91bCG5LZbp7xbkK6IQ+2Yz2f3PFDPe5SLezgXqJwpWWK
	PU4YdyqjVKxWh0kgMeGNt1TEiDDYAqEnOaOvkADnWAnwyc64rOip9RTJxjLV9OAm7kouMyo16gy
	dIyLxzQ3Aqbm5oxrVznWLsTSrncnODAadv2K68PFRhMjhm7GhBR6DY46/gVHOo7vhSqJgHqOw4p
	XcIeWAy73MQB9GFJ7qmxNU+iFP/PpkFY00/4PPCEl6mvXAbnJAKmTp5U8IqJNUAQ6+iv/yvGrVI
	KL12MgGnJcxMd77pw01vz1iN9WflU/ICP71v13aHf4pi1QWxB9dIw3hZaRhLpRHp+Di7ywFSCNU
	XUHXyu2AxQncz4ZEnl7/612Jiy+5QgKwBXf0GD46AUJwpKXJUDMh5WlR2iFmW3UYgiMGpsEhx5S
	4IEjzby2fuuYb8i/+bLQK/MhArX1TR3znlUNzF/3IAz3qO4HLuVg1UxIik1pvq4M4Sj1TQOWG4Q
	==
X-Received: by 2002:a17:90b:4a4d:b0:3ac:9e5e:d19c with SMTP id 98e67ed59e1d1-3ae897ccc1emr5465008a91.17.1793494027505;
        Sat, 31 Oct 2026 17:47:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm5126211a91.4.2026.10.31.17.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 17:47:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Don't trust pointers spilled in slots that a callee can write
Date: Sun,  1 Nov 2026 00:46:55 +0000
Message-ID: <20261101004657.3406576-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101004657.3406576-1-alexei.starovoitov@gmail.com>
References: <20261101004657.3406576-1-alexei.starovoitov@gmail.com>
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

When a static subprog or a callback gets a pointer to the frame of its
caller, join every slot of that frame with "not a pointer to the stack".
Reads and possible writes through a filled pointer are still seen, but no
store through it is a certain write. It has to be every slot: the callee
reaches the whole frame from one pointer, and callees are analyzed after
the caller.

For a spilled copy of r10 this needs "bpf: Fix the join of fp+0 with
a value that is not a pointer to stack".

In selftests, Cilium and sched_ext the stack marks change in 4 of 12522
progs. Verdicts, insns and states do not change in any prog.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 50 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index db01aecdffba..b49374a1ae0a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1383,6 +1383,29 @@ static struct arg_track arg_track_deref(struct bpf_verifier_env *env, struct bpf
 	return (struct arg_track){ .frame = ARG_NONE };
 }
 
+/*
+ * True if the call at @insn_idx passes a pointer to the frame at @depth to a static subprog
+ * or to a callback. They use it as a pointer to stack, a global subprog gets plain memory.
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
@@ -1446,21 +1469,22 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
-- 
2.55.0

