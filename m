Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66325B083
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454167; cv=none; b=HXzye6hP3eEEh8Dhy8n0JjqSjMU4ckogXB5QbaktJ/S4wwYJSrxSYnwFwEDnNSHAgZYLE6NjH0b/KaQhUe7a6CnQ+FpHW8tZcvDBzMJqyXsiaiHwUaLByF6gkZw6cNtzWDuEGrAJ9zbL+mh31+TYmpJr+8t4/Eonxsqo8q/xSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454167; c=relaxed/simple;
	bh=25t6Res5A5lFCnOw1YbYozzSPt/9U6sObEafbRoa820=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWgTRy3o/DqryqTv30pf6MaJEOpg3AqHli/LKJq+nwfd5SL/1bk6jB58KC8lu/zE9leddBmHY2OV7CpH7ZHekvmRXhLYxJBth8SnLsIXF8JFYnEm3HWKBrwSKIgvfT1yKxjz72eEPso9ggYwbsMJG5aXbR336whIllJD0pk1mHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=V4wgDKZO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="V4wgDKZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ZQbna4LQVqWu6gcnve7W+mHhntHX0RPwRaNx62VZ/4E=; b=V4wgDKZON6JZJCwIPd51RNmoRQ
	RCqreamBG+E3yRaaEz8Svl0olgjs/kPaV6hnWCOmaDW4/73fFMs46U4I0/Hapr+09ikoHXagK2Hqj
	NEwVUClAX67qwQu62dqJ0vG5K6E+BozOGeBANkbtrkaC651/6sQlFpW1LcqQWa03D1mNTd+8Y/3v8
	F6/PDRToGQWuVI75ylidsbOTRgobuEbBKIqCtkPhCkCz9WxAwMbgjjH58+ODvynXLd93Fygv8+B7Y
	dgu3XNJUl5LG8VaWG42BhEh31IZB/IkHOZ7KmyauD/NdXCRBz6ZUCa+imPT4+m/uomejq7Xn6c5Tp
	hGXzhY/Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKn-0009UE-18;
	Tue, 11 Aug 2026 15:16:01 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/6] bpf: Derive the atomic load register in one place
Date: Tue, 11 Aug 2026 15:15:55 +0200
Message-ID: <20260811131600.506721-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the register
it reads the old value into, the BPF_STX case of insn_def_regno() open codes
the very same mapping a second time, the const folding and the liveness
transfer functions a third and a fourth time, and BPF JITs need it as well
to know which register a faulting BPF_PROBE_ATOMIC has to clear.

Add a small helper so that all of them can share it. No functional change.
The BPF_LOAD_ACQ case is there for the JITs, which do walk all instruction
classes. const_reg_xfer() loses its explicit BPF_ATOMIC mode test since the
helper checks class and mode itself; the BPF_PROBE_ATOMIC it additionally
accepts cannot be seen there as it is only set from bpf_do_misc_fixups(),
that is, after const folding has run. arg_track_xfer() keeps its mode test
since that also guards the stack clearing next to it.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
  v2 -> v3:
   - Also use the helper for const_fold and liveness (bpf ci)
   - Drop the return value comment in verifier since the helper
     comment already covers it (Jakub)
  v1 -> v2:
   - also convert insn_def_regno (Eduard, sashiko)

 include/linux/filter.h  | 24 ++++++++++++++++++++++++
 kernel/bpf/const_fold.c | 11 +++--------
 kernel/bpf/fixups.c     | 11 +----------
 kernel/bpf/liveness.c   |  9 +++------
 kernel/bpf/verifier.c   | 13 ++-----------
 5 files changed, 33 insertions(+), 35 deletions(-)

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
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index b2a19acadb91..4cf120c7b2cb 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -199,14 +199,9 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 			ci_out[r] = unknown;
 		break;
 	case BPF_STX:
-		if (mode != BPF_ATOMIC)
-			break;
-		if (insn->imm == BPF_CMPXCHG)
-			ci_out[BPF_REG_0] = unknown;
-		else if (insn->imm == BPF_LOAD_ACQ)
-			*dst = unknown;
-		else if (insn->imm & BPF_FETCH)
-			*src = unknown;
+		r = bpf_atomic_load_reg(insn);
+		if (r >= 0)
+			ci_out[r] = unknown;
 		break;
 	}
 }
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
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ef9a5a922887..1c997aeba6fa 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1209,12 +1209,9 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				clear_stack_for_all_offs(insn, at_out, insn->dst_reg,
 							 at_stack_out, sz);
 
-			if (insn->imm == BPF_CMPXCHG)
-				at_out[BPF_REG_0] = none;
-			else if (insn->imm == BPF_LOAD_ACQ)
-				*dst = none;
-			else if (insn->imm & BPF_FETCH)
-				*src = none;
+			r = bpf_atomic_load_reg(insn);
+			if (r >= 0)
+				at_out[r] = none;
 		}
 	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..61ef43325c6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6485,21 +6485,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (insn->imm & BPF_FETCH) {
-		if (insn->imm == BPF_CMPXCHG)
-			load_reg = BPF_REG_0;
-		else
-			load_reg = insn->src_reg;
-
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

