Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAA4779A1
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027176; cv=none; b=PKladZPgvZS5lEAqjXngW+Kq9AG5sJRmGtg4ORrU338FQm9xX4+Vk7bqBzs7eB/+OVnpV2DsUISL/zry4sau+5j4lkT48l6Yo3lE+2UkBOxQXZ7P89P6OLWhSR+vby+2pUTtgKNOnue/W7HGEmJY/PaDBS0BoPHqkcxt4T8PECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027176; c=relaxed/simple;
	bh=Ic0nyxXjSlJNa92spvUW2/djsB/elLo3iB5HrJrDzO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnyNJ5Oz5zR5tnRNnjoM6rrrPsMQg74mg7x4gJFDbvJEkgykAvppREVusm+PVXxZ+g+WD9ENH1sMNIQVvyfaSMl78eaGYCuDSPpI3O63e1M6SrV+Srxjgn6U//I2MMFFUb91UPwtLrgU8EeNQ9rdFLO3LGwU7RP+FZFxEHm87O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oVwcBZdX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oVwcBZdX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YlBbhBS3O0d7JtaRtMa5svic3lkFt40wqLpn7grnf7g=; b=oVwcBZdXjTeBhApGaVgbRizl8z
	UDJAF4cij8waBLzmMNQJxITb0fHqUzu4Y8U7w+SNumzIA4XDRzC34H7L3UnT1g31kZtnrp4Vb+V+2
	+l0+C884zBIq/1Oos3XrhbtmSHtgJrv8qcoZFhTwYb3jM2fE5t6CIeKHDgrFX6M/V+vKNGHr4dPAb
	fVP1AernZegfFrpbaP0D1x58VX1HcSHocpISDC06NLlaA3Pkf1SIkniFfv0qkYHhA4DwCExO2UIRL
	hAUiwKbDzrqz1wMhWwWL3jXw2kiEOXCpnHOj8/UaQO8gTIEK27VHsp7nTzQ8jkBVfJIa06GlssBY5
	VtoWckWQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrzFl-0004sW-1I;
	Thu, 06 Aug 2026 16:39:25 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/6] bpf, riscv: Add and use bpf_atomic_is_load_acq() helper
Date: Thu,  6 Aug 2026 16:39:20 +0200
Message-ID: <20260806143924.319238-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806143924.319238-1-daniel@iogearbox.net>
References: <20260806143924.319238-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

A load-acquire is the only BPF_STX class instruction that reads from
src_reg into dst_reg, that is, it has the operand roles of a BPF_LDX.
JIT code which tells loads from stores apart by instruction class alone
has to special case it, for example when deciding which register holds
the faulting address and which one to clear from an exception handler.

riscv64 already does so, open coded as a bare insn->imm test. Add a
bpf_atomic_is_load_acq() helper and convert riscv64 over to it, so that
the x86-64 and arm64 JITs can use the same helper in subsequent patches.

Unlike bpf_atomic_is_load_store(), which presumes that its argument is
already known to be a BPF_ATOMIC instruction, the new helper is called
from code which still sees all instruction classes, so it checks class
and mode itself.

Also, move bpf_atomic_is_load_store() to filter.h next to BPF_ATOMIC_OP,
so that both helpers stay together. No functional change intended.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/riscv/net/bpf_jit_comp64.c |  2 +-
 include/linux/bpf.h             | 15 ---------------
 include/linux/filter.h          | 31 +++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8fe8969fb8a0..6b9972b07c1b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1994,7 +1994,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		/* ret can be 1 (skip-zext); extable entry still needs to be added */
 		if (ret >= 0)
 			ret = add_exception_handler(insn,
-				insn->imm == BPF_LOAD_ACQ ? rd : REG_DONT_CLEAR_MARKER,
+				bpf_atomic_is_load_acq(insn) ? rd : REG_DONT_CLEAR_MARKER,
 				ctx) ?: ret;
 
 		if (ret)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..d79bf7557ef6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1132,21 +1132,6 @@ static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
 	return bpf_is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
-/* Given a BPF_ATOMIC instruction @atomic_insn, return true if it is an
- * atomic load or store, and false if it is a read-modify-write instruction.
- */
-static inline bool
-bpf_atomic_is_load_store(const struct bpf_insn *atomic_insn)
-{
-	switch (atomic_insn->imm) {
-	case BPF_LOAD_ACQ:
-	case BPF_STORE_REL:
-		return true;
-	default:
-		return false;
-	}
-}
-
 struct bpf_prog_ops {
 	int (*test_run)(struct bpf_prog *prog, const union bpf_attr *kattr,
 			union bpf_attr __user *uattr);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 32d5297c557e..41b02d53e222 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -383,6 +383,37 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 /* Legacy alias */
 #define BPF_STX_XADD(SIZE, DST, SRC, OFF) BPF_ATOMIC_OP(SIZE, BPF_ADD, DST, SRC, OFF)
 
+/*
+ * Given a BPF_ATOMIC instruction @atomic_insn, return true if it is an
+ * atomic load or store, and false if it is a read-modify-write instruction.
+ */
+static inline bool
+bpf_atomic_is_load_store(const struct bpf_insn *atomic_insn)
+{
+	switch (atomic_insn->imm) {
+	case BPF_LOAD_ACQ:
+	case BPF_STORE_REL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * A load-acquire is the only BPF_STX class instruction that reads into
+ * dst_reg from src_reg + off16, i.e. it has the operand roles of a BPF_LDX.
+ * Unlike bpf_atomic_is_load_store(), @insn is not assumed to be a BPF_ATOMIC
+ * instruction here, so that callers which walk all instruction classes can
+ * use this directly.
+ */
+static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_STX &&
+	       (BPF_MODE(insn->code) == BPF_ATOMIC ||
+		BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
+	       insn->imm == BPF_LOAD_ACQ;
+}
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
-- 
2.43.0

