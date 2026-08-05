Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728F3C9EF8
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955490; cv=none; b=IIwnVDJKaYJRtw1HIoXptK98g7a45Kr+fSOK4/xclkxQPa8miIRCX0JxWMpKod/YODkeC0htGDohsT9ZocHspimQKvK49VIz8z/q99bvquLlXPnHEEDGiJ6kMMdlWlMAwrq6rFYFE6e0VyJ6u0GceUyaoEw3TJM5qt82Or7o3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955490; c=relaxed/simple;
	bh=kzJ4NY/zUiPr51BAtndhx1542Ow/yyRckiKmotkB4Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCb17knhrjfx9O6498VXSDt4+hUgiX4D3q0C8uKSsgin0P+hODhBt8rS5K0CgQ7whXb4Ul+GooDTHQSkX51OdHIn+oeQsyOe+pN1gpNvaz42KoPCTEGKFToNqAiwrXcktfZVgwOp2NwcsVroYxRTqSb2qENtf4mcHC21A+nKGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=b/PUqrDU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="b/PUqrDU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=U6FvyhKEGMwCOIGApXSqaAcRPQdFu2RgYsWog80WJrQ=; b=b/PUqrDUWK5amfvIOLwk0o9QHR
	+fN4AzZZ0/y51Zwy+e3z5eKAscONl8LcT8FcMI47evOMDPcOdPEfZVemdqZs+StGC0+a5TYg+1Uzn
	+N4Rze+6g64ZE13xSdhXziNMPju3NRo51gbLGdndavMxM34zfhCNM3KE/pLTSUK7HBtUvMaB7X2UV
	iizQx3xJSDLHjAYXxOJoj6FblxH8Va2TPCJgsps+lyryZ8qaKhTtRJt6aRZdF8lF+yUacmmd0bVvM
	01qKiTViK27jSD/wiYP3uaIYVeLMjUjPg1a+oWWIAzgzNJlfT6GwU2Xvk5pvNOt/bA1H7YoywiK0D
	PeAbqaDg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrgbe-000JYZ-0V;
	Wed, 05 Aug 2026 20:44:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: Mark pending zero extension of arena ptrs before pruning a state
Date: Wed,  5 Aug 2026 20:44:42 +0200
Message-ID: <20260805184444.292828-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805184444.292828-1-daniel@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28083/Wed Aug  5 08:24:50 2026)

bpf_mark_live_subregs_zext() marks the definitions of the registers live
at a pruning point so that a subreg_def whose only 64-bit read lies beyond
the prune is not left unmarked, but only SCALAR_VALUE currently.

PTR_TO_ARENA is the one other type that carries a real subreg_def and can
be read as a full 64-bit value: the addr_space_cast to arena (cast_kern)
records the cast insn in subreg_def, and the later 64-bit use (a load,
store or ALU64 with the pointer as source) is what marks it. The arena
access computes its address as pointer + arena_vm_start and trusts the
pointer's upper half to be zero, e.g. an indexed 'llgc %dst,off(%src,%arena)'
on s390 or a 'src + arena_vm_start' add on riscv64 and x86-64.

On x86-64 and riscv64 that upper half is cleared regardless of the mark:
x86-64 zero extends natively, and the riscv64 JIT emits its own zextw for
the cast. On a pure bpf_jit_needs_zext() architecture such as s390 the
cast_kern emits nothing and relies solely on the mark driven BPF_ZEXT_REG.
Thus, also mark the definitions of live PTR_TO_ARENA registers.

Fixes: 107e16979905 ("bpf: disable and remove registers chain based liveness")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e62b350b37af..4de9b464a9fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3172,11 +3172,14 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
  * which is only ever read as a sub-register also gets its definition marked,
  * at the cost of a zero extension that is not needed.
  *
- * Only scalars are considered since a live_regs_before bit does not imply that
- * the register holds a readable value: the caller saved regs of a frame below
+ * Scalars and arena pointers are considered, the two types that carry a
+ * subreg_def and can still be read as a full 64-bit value past this point.
+ * The arena case matters on a pure bpf_jit_needs_zext() architecture. Other
+ * types are skipped since a live_regs_before bit does not imply that the
+ * register holds a readable value: the caller saved regs of a frame below
  * the current one are clobbered to NOT_INIT at the call while keeping the
- * subreg_def of the call insn. Such a definition must not be marked, the call
- * insn has no destination register to zero extend.
+ * subreg_def of the call insn. Such a definition must not be marked, the
+ * call insn has no destination register to zero extend.
  */
 void bpf_mark_live_subregs_zext(struct bpf_verifier_env *env,
 				struct bpf_verifier_state *vstate)
@@ -3192,7 +3195,8 @@ void bpf_mark_live_subregs_zext(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_FP; j++) {
 			if (!(live_regs & BIT(j)))
 				continue;
-			if (func->regs[j].type != SCALAR_VALUE)
+			if (func->regs[j].type != SCALAR_VALUE &&
+			    func->regs[j].type != PTR_TO_ARENA)
 				continue;
 			mark_insn_zext(env, &func->regs[j]);
 		}
-- 
2.43.0

