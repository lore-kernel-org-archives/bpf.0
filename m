Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949A426D26
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995625; cv=none; b=mDDOmeGYMcWxGJBsLYXjMtrMlKvuRAIcXT8oAN3N2IpBWK+z6eCqpDgWrGbC3ssKLTzrZzosbdyLlc6gy/gAJ85+mgmPWVlgmD5ZwKKIHkEeV9rfyMsVq9o4mDOn/XqvmXGDM2i1bAIr6wj+OdkYcbAxiVCd2zytXTcmJMZTI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995625; c=relaxed/simple;
	bh=qTTGJ6vWBCDAj6ucfYtWVi/dfJPa8xDoqdq4tcpY4k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8C2zwp6NtWYOXT7UFptjrPs9Vot8lPAF6mQw3YiyESsIc4pNLvWVxyl7Oh11wuI64ZUsDXbXvrf+FAXQailAEONwA1ZRVMEzW8lJ61aEf3v+JZLEoIjkSV+hPTteQOaHaKzQB5R/zCWcT2dtXYnWLO5qJRPdKZkEvtWLkJW1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=poJZuvK3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="poJZuvK3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=U5wlTF+B7Yf1trKF49RfgC+h5EfP6+1RkyZ6Dh0VamQ=; b=poJZuvK3nS/fwAhAzQpofVBRG1
	6gxVLj63v9twmRRyXIDJptS8kwj7fAZ6NpLwxIAv5EWlzcI4OyDCD5ckrJ6SxATICxOY25TxTfNqD
	dUPSrt4e3EnDC5PAHgUOKzJd5PfCES6vMoe015w6K73LXvmlwCo4SadlV7VmNs0uHyHcHSzeK9wnB
	V0P6lruRNz8G5Rs9RHjW4NDE7Kutz3t6ALWOBnsy23YMHGxTQZH8qZmtQSgQv3NH0aRHjbdIyuDGN
	fOR3d5jGOypS9r+nJI/G01igYIv+/mdu8ylzko22E3UCqx4gCj9OXrp3E84nn+6EmIlmOiZ6G59sC
	maYshm1w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7hRc-0002Gs-2g;
	Wed, 01 Apr 2026 00:20:20 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: puranjay@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v2 1/2] bpf: Fix incorrect pruning due to atomic fetch precision tracking
Date: Wed,  1 Apr 2026 00:20:19 +0200
Message-ID: <20260331222020.401848-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27957/Tue Mar 31 08:24:30 2026)

When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
a destination, thus receiving the old value from the memory location.

The current backtracking logic does not account for this. It treats
atomic fetch operations the same as regular stores where the src
register is only an input. This leads the backtrack_insn to fail to
propagate precision to the stack location, which is then not marked
as precise!

Later, the verifier's path pruning can incorrectly consider two states
equivalent when they differ in terms of stack state. Meaning, two
branches can be treated as equivalent and thus get pruned when they
should not be seen as such.

Fix it as follows: Extend the BPF_LDX handling in backtrack_insn to
also cover atomic fetch operations via is_atomic_fetch_insn() helper.
When the fetch dst register is being tracked for precision, clear it,
and propagate precision over to the stack slot. For non-stack memory,
the precision walk stops at the atomic instruction, same as regular
BPF_LDX. This covers all fetch variants.

Before:

  0: (b7) r1 = 8                        ; R1=8
  1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
  2: (b7) r2 = 0                        ; R2=0
  3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
  4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
  5: (0f) r3 += r2
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
  mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
  mark_precise: frame0: regs=r2 stack= before 2: (b7) r2 = 0
  6: R2=8 R3=fp8
  6: (b7) r0 = 0                        ; R0=0
  7: (95) exit

After:

  0: (b7) r1 = 8                        ; R1=8
  1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
  2: (b7) r2 = 0                        ; R2=0
  3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
  4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
  5: (0f) r3 += r2
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
  mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
  mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0
  mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1
  mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8
  6: R2=8 R3=fp8
  6: (b7) r0 = 0                        ; R0=0
  7: (95) exit

Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Fixes: 5ca419f2864a ("bpf: Add BPF_FETCH field / create atomic_fetch_add instruction")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - Integrate precision handling into BPF_LDX path to reduce code duplication
   - Kernel comment style, rebase against bpf-next

 kernel/bpf/verifier.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..5c84d6a3d887 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -642,6 +642,13 @@ static bool is_atomic_load_insn(const struct bpf_insn *insn)
 	       insn->imm == BPF_LOAD_ACQ;
 }
 
+static bool is_atomic_fetch_insn(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_STX &&
+	       BPF_MODE(insn->code) == BPF_ATOMIC &&
+	       (insn->imm & BPF_FETCH);
+}
+
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -4478,10 +4485,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			   * dreg still needs precision before this insn
 			   */
 		}
-	} else if (class == BPF_LDX || is_atomic_load_insn(insn)) {
-		if (!bt_is_reg_set(bt, dreg))
+	} else if (class == BPF_LDX ||
+		   is_atomic_load_insn(insn) ||
+		   is_atomic_fetch_insn(insn)) {
+		u32 load_reg = dreg;
+
+		/*
+		 * Atomic fetch operation writes the old value into
+		 * a register (sreg or r0) and if it was tracked for
+		 * precision, propagate to the stack slot like we do
+		 * in regular ldx.
+		 */
+		if (is_atomic_fetch_insn(insn))
+			load_reg = insn->imm == BPF_CMPXCHG ?
+				   BPF_REG_0 : sreg;
+
+		if (!bt_is_reg_set(bt, load_reg))
 			return 0;
-		bt_clear_reg(bt, dreg);
+		bt_clear_reg(bt, load_reg);
 
 		/* scalars can only be spilled into stack w/o losing precision.
 		 * Load from any other memory can be zero extended.
-- 
2.43.0

