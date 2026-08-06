Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F544A3FE
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047053; cv=none; b=oD0gErC5AaR50WOralnNsMixJkhwe2DDL/aNiiz/fZcpCuZxqBGGD5/GMLTaua9FqJnGkHvDVSU5imp07t0EOQ/HertfRwGmfE4nrGghw/49rCLHYPnh2wPDk1VwSwtcfdgKNq7TuC14CytagDGg9RYJM3gMPAwNajIBTUcgT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047053; c=relaxed/simple;
	bh=dvbrQInNqBS/imrNKmi2eLWPDz1JOewHi5vgz2up9Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbnJ287KPpzRpjPB+NB9R03iRVp5DMgijKPnHRtv3WMMPr1H3fk09A0cZACaEJPqxQIwOPtqTQ1reG6yPHELMVrjtn+MsgS3EOWQ44r9Z6E+A18nZQyfc/OyC57Be0sSwOwP3ewShIXcaoDz1q3SY921UuaR4H9ZvJK6yMKVz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=E5OG2z+9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E5OG2z+9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pjWyAPd1p4aKq6KVX4etstagqRKOkUnuYUUPVQDADmc=; b=E5OG2z+9f3Z5jhYjav0xfqp8vH
	ePMlvYA3ibDm3s4WBFCjicQ5xStpC4foFBK9R9XKMSvuK2o8YHv1BBuyh41BEaMicF56vtrk5Wvxn
	vTgv56D22YFGAA6uRTyNaiMHgahh7zbc2Jl84qk+JyODalP/Otfg8ggMN4wrUl9Im9Z0C3rB2sQby
	xab+6UD88FWgjCN2LbMFi7BhW7KPt3Ua66Anc6EczLpjjfHzmrYdRAc3UekAF9c32h/MIXbYsZayn
	eX7PmVrfICFnRYOkr4r+tc+JrU5Hy1LotlfqV3DbBZIbLFUsYsZpLPsQa1UJPZ/eZDcfhIcSyWVwl
	KIZc78LQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ws4QT-000DHC-1h;
	Thu, 06 Aug 2026 22:10:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Peilin Ye <yepeilin@google.com>
Subject: [PATCH bpf-next v2 3/6] bpf, x86: Fix exception table metadata for arena load-acquire
Date: Thu,  6 Aug 2026 22:10:44 +0200
Message-ID: <20260806201047.333389-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

A load-acquire from an arena pointer is converted to BPF_PROBE_ATOMIC and
gets an exception table entry, but the entry is filled in as if it were a
store, since populate_extable() decides based on instruction class alone
and a load-acquire is of BPF_STX class:

  if (BPF_CLASS(insn->code) == BPF_LDX) {
      arena_reg = reg2pt_regs[src_reg];
      fixup_reg = reg2pt_regs[dst_reg];
  } else {
      arena_reg = reg2pt_regs[dst_reg];
      fixup_reg = DONT_CLEAR;
  }

For a load-acquire dst_reg holds the loaded value and src_reg holds the
address, so both assignments in the else branch are wrong. On a fault
over an unmapped arena page ex_handler_bpf() then:

  - computes the reported address from the value register instead
    of the address register
  - reports the access as a WRITE, since it derives the direction
    from fixup_reg == DONT_CLEAR
  - leaves dst_reg untouched, so the program continues with a stale
    value instead of the 0 that BPF_PROBE_* loads deliver

The access itself is emitted correctly, emit_atomic_ld_st_index() uses
src_reg as the address, so this is a broken probe contract and a wrong
diagnostic rather than a memory safety issue.

Use bpf_atomic_is_load_acq() helper so a load-acquire takes the load path.

Fixes: 5341c9a4d833 ("bpf, x86: Support load-acquire and store-release instructions")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peilin Ye <yepeilin@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 01e7ce569c1e..88ed95b2eaa7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2331,8 +2331,13 @@ st:			insn_off = insn->off;
 				 * BPF_PROBE_ATOMIC) before being used for the memory access. Pass
 				 * the reg holding the unmodified 32-bit address to
 				 * ex_handler_bpf().
+				 *
+				 * A load-acquire is of BPF_STX class, but reads from src_reg
+				 * into dst_reg like a BPF_LDX does, hence it must not be
+				 * treated as a store here.
 				 */
-				if (BPF_CLASS(insn->code) == BPF_LDX) {
+				if (BPF_CLASS(insn->code) == BPF_LDX ||
+				    bpf_atomic_is_load_acq(insn)) {
 					arena_reg = reg2pt_regs[src_reg];
 					fixup_reg = reg2pt_regs[dst_reg];
 				} else {
-- 
2.43.0

