Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782B34AB01
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400303; cv=none; b=S+HwAHhDBRHzRJgHp0p2DrYtnouEMABx04junoj5ibDfLvb3brbz4FLtcQXTs3lYBxpkzkuRhS2vPzZfXSwWap/7xW+y2NVB1TdavyKFHm2V9Up6e9TjVvj+RY3/rPuC9Ff7/H/Tdb6aa7if4UuPlefd7378zfkCxaSVZEK9u/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400303; c=relaxed/simple;
	bh=2xwOvOuHsd4PIyGYDG9MdWT4ESoKDUk0/kRwCszoLpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN41lQAhHjBy4BmG721qsw6NkeBvyjP8u21vdKFDUNv+cf3oD9SLRPo550/BheAHn8c0s37fISTBQVWbTYEis7Rl4DlT1FFcwKlg15dxegWprAdOxQtsyviX3C6DepEzeG78ELVqaTLDPrk0ZhCabsdTQnfEnEqi37DumdrXz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mEc65Igo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mEc65Igo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ypZ7B2JSyyPo9QPtq7bxe7NCb81D9SYKrAa631mHJWA=; b=mEc65IgoKStHEAwZj02TBRcT9T
	MrI/ADslf9JK65LLyIDKmQJjGg5QyOEwGuGaxNrbCi2ag3co62Kmu/u/K9I8WXJRM8Ds6v8EczW/D
	3bQ0iiNFxvvxd5KrFpCDDcp+kYaZelnZ2MMupVYgiJTadCqHeasiKofllRcD/CgEzpitclh89uHVG
	fC5e5LmbabsPPuW8E3HdDMpBb2T2Zh4MxVih1So9kg+iPkC5q9o0wL+7xxx8ANmyWbD0Og4PaOYnx
	4EhAyhL/NXP+/MBvfxGEjRjhHRl0Sf9C+JzQr/wVDsfF1F5WzfE+jQVfJzQ72lCXGP8dnoGeU+AQY
	Zxl9+zdw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtYJw-00056h-0D;
	Tue, 11 Aug 2026 00:18:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] bpf: Derive the atomic load register in one place
Date: Tue, 11 Aug 2026 00:18:06 +0200
Message-ID: <20260810221811.481040-1-daniel@iogearbox.net>
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
it reads the old value into, the BPF_STX case of insn_def_regno() open codes
the very same mapping a second time, and BPF JITs need it as well to know
which register a faulting BPF_PROBE_ATOMIC has to clear. Having the
derivations sit in different files is how the JITs came to disagree with
the verifier in the first place. Add a small helper so that all of them can
share it. No functional change. The BPF_LOAD_ACQ case is there for the JITs,
which do walk all instruction classes.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - also convert insn_def_regno (Eduard, sashiko)

 include/linux/filter.h | 24 ++++++++++++++++++++++++
 kernel/bpf/fixups.c    | 11 +----------
 kernel/bpf/verifier.c  | 17 ++++++-----------
 3 files changed, 31 insertions(+), 21 deletions(-)

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
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 661e2d13a604..c4bd70befbb5 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -49,16 +49,7 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	case BPF_ST:
 		return -1;
 	case BPF_STX:
-		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
-		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
-			if (insn->imm == BPF_CMPXCHG)
-				return BPF_REG_0;
-			else if (insn->imm == BPF_LOAD_ACQ)
-				return insn->dst_reg;
-			else if (insn->imm & BPF_FETCH)
-				return insn->src_reg;
-		}
-		return -1;
+		return bpf_atomic_load_reg(insn);
 	default:
 		return insn->dst_reg;
 	}
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

