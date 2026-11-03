Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708868;
	b=ElZF/7wWdoxxXDympNKaUPs7UYfL+j4538NlWw4e0AaKnKzcDyrWiY1XmLJ1cGCI0YVQ
	 Neo/9aZp/tyE6K/teUZyJoUr5+EVPprF7tkO10n2+4EdWX6hDgmuzzwsYRO44tImfy1FL
	 /j+ILHjn3tVcy79HI2gfsKRBaLbrFKSnPbkgM1vTxSdPu8O0lzJjKNmQt81V/qu/TAJUK
	 MR9BfzRV7lGuyEUnifmqVgRiamhZOJd4a26yrQa7i7XrxTUgenDH7ZJHmGnFCU+D4i3oJ
	 LhTVly5xeZoNBSH7g7e9u78h+oiJ54bx3GB56HQbCpXIKJD6JPDW8xejELeeVsJmsqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708868;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=zxh6g1/AudKAbrbexRykeEOYDRasXE90eVH1rBZl/7s=;
	b=lWTKrQQGSgptiisvITOpb28Jn2AltNZOTBoNHOM6ca/dnwUP3YogQ7K6qCgN1nO1sk7J
	 QBKGov9UXPAndKs0WiPHTjOxyYEZj6rzVbV1dh4GALniggHzH5R7rHDG8qhJ8iDOzuwPr
	 AoBcX9j4Adj1tDAxYdTE2q+u+7MsoF24oL3DAgTdG/litfv+PcaM6LOTMP1AOtGXbKxgJ
	 tlnCZLVh87IVO7V189t2aqHNGl1XEojFa5BgbrEXpkwbuiku3ybE6uQhQB6wHg2hLvtOX
	 sKjJJFp1C58PlEhEoriAs1k/y6nna6cpQTeCBYEnLgqm2vxk8LBajS5lOJfuMaSSc7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nEeAVv9E;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE7606A33B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BE7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nEeAVv9E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zxh6g1/AudKAbrbexRykeEOYDRasXE90eVH1rBZl/7s=; b=nEeAVv9EOKp8ui3M1sOPiDLaeQ
	0/XqYebarZOcmg+uK90s9z5c4ZEK+UUYdgNPOWWgn+mW9MsEan1CgrWGzpFYbwdKiB2WrrhhqRcSQ
	fNzvLRebtJ3xfQdS6rX08eya0Kh3FfdDSlButC/BaeI4HVHYCkCJAS7RYQrDAfFZgk6b5AJMoqUVl
	+C0zlKpSb2DceYV6vCyiwj3I1P6Lf7QMOHv8PjNRRKMD1Fnbu53qD6VMlGLaAtfQa8CxWi1Xpd2xL
	1PnskuNA482b1sK5DZJMPGkD6a7bLunJEj/PYmSer9dKhpL+k9abNjwvkLc/Fu0QqoEHVmIowJKLh
	Xhe7er4g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc4-000MRR-25;
	Tue, 03 Nov 2026 13:27:40 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 10/20] bpf, arm64: Store zero immediates from the zero register
Date: Tue,  3 Nov 2026 13:27:23 +0100
Message-ID: <20261103122733.1383002-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

A store of an immediate first moves it into a temporary, also for a zero,
which the zero register provides for free. Store it from xzr, which saves
the mov on every zeroing of a stack slot, as LLVM with cpu v4 emits them
in rows to initialize the structs and arrays BPF programs hand to helpers.

Before/after for *(u64 *)(r10 - 8) = 0 with 16 bytes of stack:

  d280000a  mov x10, #0x0
  f90007ea  str x10, [sp, #8]
  f90007ff  str xzr, [sp, #8]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 2a9bbd600bc0..b459f50fd533 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2089,9 +2089,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
 			dst = tmp3;
 		}
-		/* Load imm to a register then store it */
-		emit_a64_mov_i(1, tmp, imm, ctx);
-		emit_ldst(code, tmp, dst, off, tmp2, ctx);
+		/* A zero comes from the zero register, any other imm through a register */
+		if (imm)
+			emit_a64_mov_i(1, tmp, imm, ctx);
+		emit_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp2, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
-- 
2.43.0

