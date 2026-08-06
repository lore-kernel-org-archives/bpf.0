Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96814472557
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027176; cv=none; b=ZIaYaNyH/oHMmayRmuxew3kFRDEqLiRgClZBuey/q6KaZPGuEg0zRd6syqcz49dQp43nLn+2Y59Dfg11oY21gnEpj1ZZky5yCbbTzwxgTgLqd3kHRuGT/86BcXW8WtK06wkhC6MDqXDOZGH3C9rO3t2O6A9RRYVgJsabqEk6T8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027176; c=relaxed/simple;
	bh=dvbrQInNqBS/imrNKmi2eLWPDz1JOewHi5vgz2up9Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgagu5SXnGonI/xZ6sI0sNX9HWiV21EdQfUvXNUS0vdphPjq8WzS7OjjEebtMzm2f6E6GA8v0VLoyVE4scoave7rHxHKWXTXUwFasy3eMjB+Q0E+AkG0ATnF/V1khWK3wJEJC4eNHKn76E6FzxUg4matWZ3emrcNMNoPV9e4zso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ODmv+eTg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ODmv+eTg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pjWyAPd1p4aKq6KVX4etstagqRKOkUnuYUUPVQDADmc=; b=ODmv+eTgbodJPT3gsgeO9pQyjY
	WAJCyMwg5Vt3OFJYJHL/Mm+BQcJ4H3zsTgQVnAS0hM5Wm4lGF/mgCvNGOXp/rJSQ9SBWDEqfwarS8
	sKI+Yn7HbxtzPPcves1/qyfP9y6bZVyF5X+DQGyiMiZ0Zy0i7ZaQ50EHLfY7pCh0Y4qLZDHYPs5ec
	Q3rGmzk8prcXuQ99xrldd9N+5KkEyhrF6TvbK9dO8j6E61n/4oIk1XtXq595qHTtnCY0WK4ddEOGi
	KT28jsGapnod4fOqitOIJfXHMM6vE9HJKDMrLGrxXJYowG/HeZIMBfuDnLL7HSOHuPYGzts4hQvJZ
	9txSa4Yg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrzFl-0004sb-3C;
	Thu, 06 Aug 2026 16:39:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Peilin Ye <yepeilin@google.com>
Subject: [PATCH bpf-next 3/6] bpf, x86: Fix exception table metadata for arena load-acquire
Date: Thu,  6 Aug 2026 16:39:21 +0200
Message-ID: <20260806143924.319238-3-daniel@iogearbox.net>
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

