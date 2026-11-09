Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206945;
	b=a3ESt5IXglox4wsZhkPM9ICEPN2Y73v0aGaGxvOLOFd7qk1oDF6QA8nfI6B4xQ+DqRcD
	 0y6+o3dcR0E4XCX2rcLw6Zw+MhL7dnx/9MZmonuKirJBV9bioe5IxAnl8kg3flCHiiGP9
	 bWLTWYnSwIoit8juMz+UO3FDMEvjFyN61ysqfxoGG0m3mnGdB2NC13QW0anErwWPns5MS
	 p4Lc7e+Wtjo4Ko7XEgIqpoeAFpbjaciJtzHAzGYxqLccqoiyxMFmQILaW+os836G6zZKE
	 c9nOvcektUSu1AbxP3j5QoyXy6qZ+yey3fgtudsUP90/I8huQT1uKDn3WHAGsGlNM6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4E/AfnHNayFJmD06EyjeEoeSwUeb/Alc9CX7vlSCp64=;
	b=hTk0IXrlwEhe/62whFYWzsVb9xgKJwPk1NCrmp1RfWxZz9Hk238obArHklJoZKOrbHkp
	 eXDfh5Vf1hq7PZqjJDL1E0Agx11V7o86zi6bEEMGLq2V7GuLzoSzRRWsgtcGGseFcBEgx
	 Ualp0zWnC/yQbhcWiNQwXOTn85zGh1XWn1luvxN3uy3D9Sv8OU6O0wITlCz3bard+Mmsj
	 JLdHypfvn/E778pkGjAP/yqvzdTqI6qzND6fb/IDgrQAm3fB3mJjlaCWIHYYupV35ymgN
	 096RHytRACicRqq1N/1nbwOSi38zpKLSScj1c6qcTLY+PioemN+f5t/e53jkf925Dxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkMUtdPP;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757C606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2757C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkMUtdPP
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso486597b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206944; x=1794811744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4E/AfnHNayFJmD06EyjeEoeSwUeb/Alc9CX7vlSCp64=;
        b=KkMUtdPPaCIS+PiY1k2d98Ybioh6I8mgS6iDJbwHgfifV03I2tx1h0PwTmkb1zdfdU
         1hrNcZcHOlwEdUpX9e6swcM6+R7rBk+E/YQSD7PqDvZzbB8EDUAeS3KZkee7gYOBLQrE
         9uY6YE4J57znBS8JSk7Q3T/2bew1B9SMKyPauaQ3zube4wDemF+ghJg0ZIDYqj8D3EbQ
         GZO/pPRRNMMPHWzRRjnHVtgDatBr5T5bwy7FKV6jKJFcCik2rUPj/ISqtZ8f5vr8lr62
         lO1VQwCmslBhPF8Vwh55L9648JpgI5bvf9tTNtgY8uRUrON8LNcJwEs4gpFrNZWdKZ9U
         1LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206944; x=1794811744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4E/AfnHNayFJmD06EyjeEoeSwUeb/Alc9CX7vlSCp64=;
        b=sVaKIvRptovhQJ2UN1/Dn+g3nGkHirW/7dCTV/4iq5urh2+0bEpK0uM9DkCwH+YHrf
         X875swZmiM7ptgbJv3xQrVXbf4FGWJhG3zX6rKNJNA9HWCtaOby0pht+0OHIVZZRBmXs
         v31R3If0+VSobxYoLT+q/xh386h6HI33i85muPSsia0CICicC1uQxArW6Bin6+A2tA/9
         mocYx8kSldiAueYWu0t2tI8pTq7pB6NkwT1GwOKohaszU7rEbVriuQz4cM9k9Acvb2K2
         /dM105x42BQ/Tw5Zed0G9gI5v0luI6sHqvM++corgJRM1ia0GKfvh7j9GHm4L0qt6jzi
         v5PA==
X-Gm-Message-State: APuU4Z8/RlwbNrsVv0d4/5nHH9HcLz3wjIS+YA3l/xtzz6BbghyR+1Zc
	etQojyLXCjzlk0NPN+J8ddEMS3YRT26Lp3FVo6zr2bYFyg3i6UJ10tEuxeX+CA==
X-Gm-Gg: AYBFou0pebghJDwLyLVQy01m5u2omNfTC5LRY7dNAUCv/EsPkCF61oibn/JkmSHWgSS
	SiuUiXKzTUmoXX7/4ppI24KgU1wpJNm1Sju/US0MR32NpA2SbteMgqhejyRDQEFP6siPg6w5sR6
	36DOnwm3CUNbutkV9z6j2CJo3S8fGWSpzrNjBqYXrXtcEA/94EUEFvWxIGLnKPwB5rAwYD7PfUS
	C74FsGKKGhTS96MfQyoVML6Mu8uYMIY1Us545bWJtZpP2D5jIEFJ/uHpTxls/Lux85IgkFSaed4
	XrAUQF/fx47mZYXDlUIbI450AroMuTgdUs6nmnBPj5Ylsdex8GoACCEHr6B6RqGUA+aUyvmI9wM
	+3cFHKU5Fig1kLz7fZYC+0+AoFavo+t5Gd0ZhN3doS3DpZeD568x1ra15ZTEsDhKEvlFUorGEcA
	zQZZXFC/d7GmMgva4tTQ10JI5FNG0Ie+gI+Z/0NibQdfChk8mXPn4cHHtjtXW8aR6Y2N3cme1KC
	+274BXFWqKgEHZRnyqe4fjZbh8cGTG2kFf4wnZ/k4FBnkse7LX/veSOEimEwXL+4RgSmPbZMR67
	5LsrN+U+Ar6BWbxL3LkVShkjMZao1tQGq9LsxKwasJuhCv2aDkbApOnnbiu+HRsoUzCVHjY9sfP
	mwVYD5zh2fuFtJZE47K3BQoKo2Ep+xmW+b/9GpH7U5uJVALC4sy4ceseo88xmLKEzo4bFHK5eRg
	==
X-Received: by 2002:a05:6a21:7103:b0:3dd:85a9:55a4 with SMTP id adf61e73a8af0-3eed3c5a7d4mr3198103637.29.1794206944150;
        Sun, 08 Nov 2026 22:49:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9696c959sm1310373a12.28.2026.11.08.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 18/26] bpf: Find linked registers in the basic blocks of irreducible loops
Date: Mon,  9 Nov 2026 06:47:02 +0000
Message-ID: <20261109064715.2382452-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. bpfj_proc_file_open of
bpfjailer loads before and after the patch. Today it loads because of
a scalar id, and scev.c has no replacement for that id in an irreducible
loop:

	for (int i = BPFJ_MAX_POD_PER_PID - 1; i >= 0; --i) {
		if (i >= num_pods) {
			continue;
		}
		struct bpfj_pod __arena* pod = actor->pods[i];

That is role_gate.h. i lives on the stack (clang, -mcpu=v4):

	171: r1 = *(u64 *)(r10 -40)
	172: if w1 > 0x7 goto pc-10
	173: r1 = *(u64 *)(r10 -40)
	174: r1 <<= 3

The loop is entered at 163 and at 171: 'loop at 171, irreducible' in the
level 2 log. scev.c does not support such a loop: nothing is known at its
header, its body is not analyzed. The linked registers of a conditional
jump, the live registers and stack slots that are
a tested register + a constant on every path to the jump, are computed by
scev.c. So the jump at 172 has none. Only the scalar id that r1 and fp-40
share bounds what insn 173 fills.

The basic block is enough to see that r1 == fp-40 at 172: local value
numbering. find_linked_regs_in_bb() visits the basic blocks of unsupported
loops, see can_compute_loop_scev(), one by one. At the start of a basic
block every live-in register and stack slot is a phi whose operands are not
known: fp-40 is %fp-40.171=phi(?). Insn 171 copies that to r1. These
expressions are for find_linked_regs() only, the level 2 log does not print
them.

The verifier adds edges that the CFG does not have: may_goto before a loop
header, a subprog that is out of budget, see bpf_head_guard_target(). They
lead out of all loops, so a basic block of a loop is entered at its first
insn only.

Two tests: a link within a basic block is found. What the fall-through
predecessor computed is not used: it is not the only predecessor.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 52 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_scev.c       | 13 +++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 2792217754be..db60585c00c8 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -56,7 +56,8 @@ enum expr_op {
  * An SSA name for a value that no expression describes: the def of the SCEV register 'reg'
  * - by the insn at 'idx'. An insn that may write defines too (may_def in liveness.c). A nested loop
  *   defines at its header what it leaves.
- * - by a phi before the insn at 'idx': a join point, a loop header.
+ * - by a phi before the insn at 'idx': a join point, a loop header, in an unsupported loop the
+ *   start of a basic block.
  * Without its backedges and with nested loops collapsed the body of a loop is acyclic: an insn
  * executes at most once per iteration, so a def is one value per iteration. A name is unique within
  * the env of one loop.
@@ -650,7 +651,8 @@ static bool expr_next(struct scev *scev, u32 *id, u32 *order)
  *	%fp-8.8?		insn 8 may write fp-8. The value is UNKNOWN, '?' without a def
  *	%r8.7=phi(1, 2)		the phi of r8 before insn 7
  *	%r0.7=phi(_)		a phi of distinct OPAQUE values
- *	%r6.9=phi(?)		a phi of distinct UNKNOWN values, or of more than 8 values
+ *	%r6.9=phi(?)		a phi of distinct UNKNOWN values, or of more than 8 values, or
+ *				a live-in of a basic block
  *	%r2.12=(+ x 4)		insn 12 defines r2, see alu64_with_def()
  *	%r2.25=phi((+ x 4))	two adds of one shape, each may have been converted to ALU32:
  *				the phi is not (+ x 4)
@@ -1996,6 +1998,49 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	return 0;
 }
 
+/*
+ *	for (..) { if (i >= n) ..; pod = actor->pods[i]; .. }
+ * with i on the stack is 'fill, test, fill again'. clang can emit an irreducible loop for it.
+ * Unsupported loops, see can_compute_loop_scev(), get local value numbering: a live-in of a basic
+ * block is a phi whose operands are not known, %r6.9=phi(?).
+ */
+static int find_linked_regs_in_bb(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = env->prog->insnsi;
+	bool bb_start = true;
+	int i, h, err = 0;
+	struct env *e;
+	u32 r;
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL_ACCOUNT);
+	if (!e)
+		return -ENOMEM;
+	for (i = 0; i < env->prog->len && !err; i += bpf_is_ldimm64(&insn[i]) ? 2 : 1) {
+		h = bpf_loop_at_index(env, i);
+		if (h < 0 || can_compute_loop_scev(aux[h].loop)) {
+			bb_start = true;
+			continue;
+		}
+		if (signal_pending(current))
+			err = -EAGAIN;
+		cond_resched();
+		for (r = 0; bb_start && r < REGS_NUM && !err; r++) {
+			e->reg2expr[r] = UNKNOWN_EXPR_ID;
+			if (reg_alive_at(env, r, i))
+				err = replace_reg(env->scev, e, r,
+						  expr_with_def(env->scev, UNKNOWN_EXPR_ID,
+								phi_def(i, r)));
+		}
+		err = err ?: find_linked_regs(env, e, -1, i);
+		err = err ?: transfer(env, e, i);
+		err = err ?: reset_scevs_at_indirect_writes(env, e, i);
+		bb_start = aux[i].bb_end || bpf_insn_successors(env, i)->cnt != 1;
+	}
+	kfree(e);
+	return err;
+}
+
 /*
  * Find the next SCEV register that is linked to @regno at the conditional jump at @insn_idx: on
  * every path to the jump *@linked_regno == @regno + *@delta (mod 2^*@bits). It is live there and of
@@ -2715,6 +2760,9 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		if (err)
 			return err;
 	}
+	err = find_linked_regs_in_bb(env);
+	if (err)
+		return err;
 
 	/*
 	 * Compute scevs from exprs collected on a previous step. Iterate instructions in
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 8ffbe7bbdb0a..49f9a976a44c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3423,6 +3423,19 @@ LINKED(linked_at_loop_header, VALID,
 LINKED(linked_at_loop_entry_only, __failure,
 	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 2; r3 += 1;"))
 
+/*
+ * In an irreducible loop registers are linked within a basic block only. In the second test the
+ * fall-through predecessor of 'm' makes r2 a copy of r8. The other predecessor does not.
+ */
+LINKED(irreducible_loop, VALID,
+	"if r7 > 5 goto m_%=; l_%=: r7 += 1;"
+	"m_%=: r2 = r8; r2 += 1; r2 += 1; if r8 > 61 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=;")
+LINKED(irreducible_loop_fallthrough_pred, UNBOUND,
+	"r2 = r7; if r7 > 5 goto m_%=; l_%=: r7 += 1; r2 = r8;"
+	"m_%=: if r8 > 63 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=;")
+
 /*
  * No exit of the inner loop dominates its backedges: may_goto is added before its header. The prog
  * holds a reference, so may_goto goes to the exit of the outer loop: an edge that the verifier
-- 
2.55.0

