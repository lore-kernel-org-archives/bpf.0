Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8430D3E9
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369432; cv=none; b=AJRIz/XyVqG3aEym/3Ja3+Ucd+SQPoYQ0tLY3XqRgoefn3M/QAN+U6MTewv4xktpBoTnDoiSYICT08GqEjX1uLp5hBZKhGWmRS6xjD2bVamIFyrf3pn6WckvFOFAqXe5n198j+2kr49ShsZF4/FWLR9DEfKB0ZmKobSdpSUJgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369432; c=relaxed/simple;
	bh=Y5BbQviINm8FFgruGVu3TLLtuqshkYFRybewMwza7hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vC0TxBw9pBzCZA0wzaslBpgoLa5ObEI4Q6vtW/Nbz0Smy8YCWB0xHsLjXwzM1/YLwvHr9ygPHmfdhtzKwz6ROSDtg79kL09vkSYyVD2TLtYKYVHLguQJ6T20d9wazRgq/KE3tDRyokimnjer6E5D21EhM5dYRx/CYfXFrdTILFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KqIwFw5W; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KqIwFw5W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ce/0oP+WKsnImWdWQEUwoMQ+WiBaWgqVvdg1fyUoUlM=; b=KqIwFw5W36viPQziPcDF6xqttQ
	Dk1oO0vZ/j33hTV7RoJa8LQv0VYZIH5zpTm9BvXxu3STerF3UpF8PB2vs9SLsGozZqf/pQr18veM+
	N1oAoOOPzRJjy9/Q9lJtdRAOxhfqleeoC8adxchWAMJljpY9z6ldLNw16Ds2H07jOR8ulIFSJ+nOa
	W5ohYUHl03yXFERY1vdEo482S6ysyyGW3utPiRLGmFPMHnLdia1A/jvj/Dx8puj+i95fIpE2yrs7R
	YoBg5lfrkFl5dCOZMjScAUogYa+HO1wqhYh4t1TVQN0s3PU9xTzm1X48U+8lOq/cLe2/5ajHSidhD
	7HkVz9LQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtQI6-00050F-29;
	Mon, 10 Aug 2026 15:43:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/6] bpf: Derive the atomic load register in one place
Date: Mon, 10 Aug 2026 15:43:41 +0200
Message-ID: <20260810134346.466004-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28088/Mon Aug 10 08:24:15 2026)

check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the register
it reads the old value into, and BPF JITs need the very same mapping to know
which register a faulting BPF_PROBE_ATOMIC has to clear. Having the two
derivations sit in different files is how the JITs came to disagree with
the verifier in the first place. Add a small helper so it can be reused.
No functional change. The BPF_LOAD_ACQ case is there for the JITs, which
do walk all instruction classes.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 24 ++++++++++++++++++++++++
 kernel/bpf/verifier.c  | 17 ++++++-----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4edba8182db1..15d83684c6e9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
 	       insn->imm == BPF_LOAD_ACQ;
 }
 
+/*
+ * Given an instruction @insn, return the number of the BPF register that a
+ * BPF_ATOMIC reads the value at its memory operand into, or -1 if there is
+ * no such register. That is the register a BPF_PROBE_ATOMIC has to clear when
+ * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assumed to
+ * be a BPF_ATOMIC here.
+ */
+static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
+{
+	if (BPF_CLASS(insn->code) != BPF_STX ||
+	    (BPF_MODE(insn->code) != BPF_ATOMIC &&
+	     BPF_MODE(insn->code) != BPF_PROBE_ATOMIC))
+		return -1;
+
+	switch (insn->imm) {
+	case BPF_LOAD_ACQ:
+		return insn->dst_reg;
+	case BPF_CMPXCHG:
+		return BPF_REG_0;
+	default:
+		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
+	}
+}
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..73a2e8bb1782 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6485,21 +6485,16 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (insn->imm & BPF_FETCH) {
-		if (insn->imm == BPF_CMPXCHG)
-			load_reg = BPF_REG_0;
-		else
-			load_reg = insn->src_reg;
-
+	/*
+	 * A negative load_reg means that this instruction accesses a memory
+	 * location but doesn't actually load it into a register.
+	 */
+	load_reg = bpf_atomic_load_reg(insn);
+	if (load_reg >= 0) {
 		/* check and record load of old value */
 		err = check_reg_arg(env, load_reg, DST_OP);
 		if (err)
 			return err;
-	} else {
-		/* This instruction accesses a memory location but doesn't
-		 * actually load it into a register.
-		 */
-		load_reg = -1;
 	}
 
 	dst_reg = cur_regs(env) + insn->dst_reg;
-- 
2.43.0

