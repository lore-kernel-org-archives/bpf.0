Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977C282F2A
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454169; cv=none; b=pC8tjEqw9uJRx357rVSINWgVG012MwBLqFz/aFSXaWUU+Nz8tfVn0DN5oAB8d1wmGUsuvVdXNqL7frb1aWWOwHbSQPBe+kOZz9aX7M6U9FPzaxjR0wQomj5fvI0pQBNN3pDwNUVV7QJUoMLMfCgfRwCROZSNuQ33IVSdqkDbc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454169; c=relaxed/simple;
	bh=QSZeD/JeRScEMFp577fri86SzcLLBOL/5TbbjJDlcAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBsqL+u2mOIans/RY/P/IkuvU6RuQdOhTWJfdQgGhkkXiwrMq4nnLYP2XV667w/5bQDi0McSrd8ZiBqz1/qMlfKciaYGEQt0WLmaoVmgplfZ2cILc1QLrjFMjfbcFIbiZI+0mQh4AI1dIAhgA9dLTeAyNfx6tMvzO0MVxPFa5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YZYRjOV0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YZYRjOV0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=G2BV7lYdWJfJUHXDIiXt3MRCn7T/oQxA6eb9bO4Bnuc=; b=YZYRjOV0dr7aBLsVsePzy2ZRW7
	U95hs2suoMty0RuH7aPBISGp2Q4+eH39nLPyk6yr3yhXys+gYhaEb6dbp8QSmL+KT16pSzWxBm4l8
	O3o0mYx6yhdEODdRBR7BAZUzPayqe9RD85Ck7hOcreye6kOXmmdDQT+WQUSaAsIYgqY4yoLjq/pT+
	S1ISgv/2XRUytrgjP6uuLMCABTAVQiG3F44R+s3UoMLKw9VZJS2pfN8K2mBy/ThmiCyisvlOdVS40
	H8gSB4KwfXOD1LkOiHWBASXgUf9KKXTRG52ds0neUC9uC+x2BITVZs1ukYYpgazKtUn2cVVFJ6PRQ
	aE00xAxQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKp-0009Ut-2i;
	Tue, 11 Aug 2026 15:16:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 5/6] bpf, s390: Clear fetch destination on faulting arena atomic
Date: Tue, 11 Aug 2026 15:15:59 +0200
Message-ID: <20260811131600.506721-5-daniel@iogearbox.net>
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

Same missing register clear as on riscv64. A RMW atomic on an arena pointer
is converted to BPF_PROBE_ATOMIC and gets an exception table entry, but
bpf_jit_probe_atomic_pre() only fills in the arena base and the probe
offset, leaving probe->reg at the -1 that bpf_jit_probe_init() set, which
bpf_jit_probe_post() writes into the entry and ex_handler_bpf() then reads
back as "there is nothing to clear".

That is right for a plain BPF_{ADD,AND,OR,XOR}, which only writes memory,
but an RMW carrying BPF_FETCH also reads the old value into a register:
src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and r0 for
BPF_CMPXCHG. So on a fault over an unmapped arena page the program resumes
at the landing pad with whatever that register held before the atomic
instead of the 0 that every other BPF_PROBE_* access delivers.

Fill probe->reg in from bpf_atomic_load_reg(). Unlike x86-64 and arm64,
s390x does not report arena violations from its exception handler, so there
is no access direction to correct here, only the missing register clear.

Fixes: 2f9469484a3b ("s390/bpf: Support arena atomics")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b60877478b45..c46872b071ce 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -774,6 +774,8 @@ static void bpf_jit_probe_atomic_pre(struct bpf_jit *jit,
 				     struct bpf_insn *insn,
 				     struct bpf_jit_probe *probe)
 {
+	int load_reg;
+
 	if (BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return;
 
@@ -783,6 +785,14 @@ static void bpf_jit_probe_atomic_pre(struct bpf_jit *jit,
 	EMIT4(0xb9080000, REG_W1, insn->dst_reg);
 	probe->arena_reg = REG_W1;
 	probe->prg = jit->prg;
+	/*
+	 * A read-modify-write carrying BPF_FETCH reads the old value into
+	 * src_reg, or into r0 for a BPF_CMPXCHG. Clear that register on
+	 * fault, the remaining atomics only write memory.
+	 */
+	load_reg = bpf_atomic_load_reg(insn);
+	if (load_reg >= 0)
+		probe->reg = reg2hex[load_reg];
 }
 
 static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
@@ -1684,6 +1694,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			if (load_probe.prg != -1) {
 				probe.prg = jit->prg;
 				probe.arena_reg = load_probe.arena_reg;
+				probe.reg = load_probe.reg;
 			}
 			loop_start = jit->prg;
 			/* 0: {csy|csg} %w0,%src,off(%arena) */
-- 
2.43.0

