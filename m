Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F225A645
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454166; cv=none; b=A4zjHm8wK+xM2DcsOhVip9Mv8YFNacIGfX/xz0FlBU9USoIesQMm9xAa/G1xAaTTg1Yf6dWr0DnzR+52DEVgqDQN9p6yxH+d/Y0/Tc6KTNX6ED3NCpeUrHxM8HspFkfu1hMbMi0IkOm0O6Pf5YDzJJnk8K/TYdqa+c7bCXclgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454166; c=relaxed/simple;
	bh=ARSMoxD8urHOF/p6uPWmre1Rjt8+7t2IWk0tzD+5ZTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFBc4NpR2cDOLB6f5fNUeQ5fs8yxzhR7jaD6ZBPyvlXYDQEocJLxDSLt960eJCz6BkPfQYOaSU0dDFBiUE0B4vXFPIpKbEq2rAgmNeGykBrmWry/Bn+83vx6/YV2/tM2ZFCSt6zaxinjwmBHdxXjQkeEVDNhOCXh85+RQtLss6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f8ZBMUyh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f8ZBMUyh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Lj2zvumtP7aXbEVBpohrerC/uvC+hNZrgF9VxLZiWqA=; b=f8ZBMUyh3LJA3ogoSpxjM89BOV
	kiFnUGIhfSky2RuCX+xJSvHUMff59WA0QZWqC04w40t8of5Q/12awHespWqFXOb6SeLevgqef6eRD
	IP5ALH2CKdPoVWd9By0/5FqTNDdWPLGeDUTBl/eINhZ5EjnEl86FTMJeVcrAAtIrT8YhUS98RIUyg
	nHmNyBOqAYE1csx3ArsBkXhVHDKxBiscQQFVji0pPe2zJvu/6Y/XTJay4Ydbkyny65v1BrPDmWx2C
	C0kOY16DvM0otblCw+rjnI1GEss7MyvTGsqJvTMRS+e0L6asuWbcK+OpGjfBKI8CO0ALC0QWyUOIy
	AGijdomg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKo-0009UL-0f;
	Tue, 11 Aug 2026 15:16:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 2/6] bpf, riscv: Clear fetch destination on faulting arena atomic
Date: Tue, 11 Aug 2026 15:15:56 +0200
Message-ID: <20260811131600.506721-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811131600.506721-1-daniel@iogearbox.net>
References: <20260811131600.506721-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

A RMW atomic on an arena pointer is converted to BPF_PROBE_ATOMIC and
gets an exception table entry, but that entry records no destination
register to clear unless the instruction is a load-acquire today. That
is right for a plain BPF_{ADD,AND,OR,XOR}, which only writes memory,
but an RMW carrying BPF_FETCH also reads the old value into a register:
src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and r0 for
BPF_CMPXCHG. emit_atomic_rmw() emits it that way, e.g.:

  [...]
  case BPF_XCHG:
          ctx->ex_insn_off = ctx->ninsns;
          emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
               rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
  [...]

Thus, a fault over an unmapped arena page ex_handler_bpf() jumps over
the access but leaves rs untouched, and the program resumes with
whatever it held before the atomic instead of the 0 that every other
BPF_PROBE_* access delivers. Fill the exception table entry in from
bpf_atomic_load_reg(), which returns the BPF register an atomic reads
the memory operand into or -1 when it has none. A load-acquire ends up
with the same register it gets today, it just goes through the helper.
Unlike x86-64 and arm64, riscv64 does not report arena violations from
its exception handler, so there is no access direction to correct here,
only the missing register clear.

Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 6b9972b07c1b..2504df1fa111 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1992,10 +1992,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			ret = emit_atomic_rmw(rd, rs, insn, ctx);
 
 		/* ret can be 1 (skip-zext); extable entry still needs to be added */
-		if (ret >= 0)
-			ret = add_exception_handler(insn,
-				bpf_atomic_is_load_acq(insn) ? rd : REG_DONT_CLEAR_MARKER,
-				ctx) ?: ret;
+		if (ret >= 0) {
+			/*
+			 * A load-acquire reads into dst_reg, and a read-modify-write
+			 * carrying BPF_FETCH reads the old value into src_reg, or into
+			 * r0 for a BPF_CMPXCHG. Clear that register on fault, the
+			 * remaining atomics have no destination register.
+			 */
+			int load_reg = bpf_atomic_load_reg(insn);
+
+			ret = add_exception_handler(insn, load_reg < 0 ?
+					REG_DONT_CLEAR_MARKER : regmap[load_reg],
+					ctx) ?: ret;
+		}
 
 		if (ret)
 			return ret;
-- 
2.43.0

