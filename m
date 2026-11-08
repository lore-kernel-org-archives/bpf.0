Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166085;
	b=eXxduDEKSbi7PaC8TuNpuO1j0H7LCZ1Wt71Jllt51zElMSVYCvWculxJeaqKKh8YqAcD
	 gRA7RrWnXNJUBrOlH7RxKnMGt493w4SPiXdOpLdy4eqNJ2YHKsKHWE6DbVAKDbOoXUJAj
	 8jGVmYcpu4B6vgMXxdkp8ZxfPQQmypBBg57O/qxIWXvR+cXG45biVrrHV9C1MWy7bulyP
	 01i36KHpgX0jGPRXawxfMEAApwydF4pOtYWyYTtf6OUwNXHbcwPD2sqt4t4lQn79fyEOP
	 D2/o8aTrKz/k+baGvJdQn+f5Dju1rBEKz1gbSvsEQz4fIrutX8ESB2XLTxCbAhIKi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166085;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=RcCscprRSS6sg96pHRuM6i6GjMM6gyD2dEZJUUlTmcw=;
	b=kdQYd5svFulgo8LuLK+vkWNbmID5EFGFtjC4Py4WCBkpU/RkDOMVC2kqpNTHJOzs93wv
	 kLgrLLV9+EnQBTCXakx/CMuGCGZtc1qVBW/STWb1AQn4yVsI/2GhtmuKHnGP6IPtQsiw8
	 grJyDU8YFXGSOwymOM/3dSoaJ5smcB5JOzAbXT2ZIQJsbmMpsuPtOpJN8lSYelS9VPwc1
	 SqCKrfGaZwRpB4Dd/88lteBhdQksf5I9a7r7Po6fqlXsbsIr1AU03iar1UkwO9ONKfHii
	 i8fCXfdO+yQe2dTKjaqtmr4yjdw80fWO2gfzxfGsogapNyPBp7dOAbskln2VQ5Lc5Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dTg5+KnU;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BE606A320
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dTg5+KnU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RcCscprRSS6sg96pHRuM6i6GjMM6gyD2dEZJUUlTmcw=; b=dTg5+KnUGQ1FeLuOpx77qhrGC1
	es1SORgaDD/Y8Iykxt/v4oLLzzVaXntSWfr/G1/9VHlhnNHSZ8oszxQt9/8ji4m9DPcKoqZilJj4h
	yb/vej+oNWxAj6JXsbOfjWEolkpda/8XZgKGTFgREw55PACQEYReaR0NSJW9oibvrknU0iwaQQCg2
	Ewi9gv7frJANSnnpktrgQN4JpSV1B+m8BrBSm2ktOhavaGlbKJfiQGZ+LyvXHax0G4/vOj8Yt4OWN
	UL/KZvQUqL5BBQXUmPD/r3Xc41JEpz8N4TkxRvskTUxVEiRDSboVbZ8f+Lri57w4NQ9PctlMx40+j
	DNPaTyHA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yc-000Pp4-1p;
	Sun, 08 Nov 2026 20:28:03 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 14/24] bpf, arm64: Store zero immediates from the zero register
Date: Sun,  8 Nov 2026 20:26:40 +0100
Message-ID: <2a41c66d3f9b162b32cf038f8d65ad5ea4b300b7.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

A store of an immediate first moves it into a temporary, even when it
is zero. Store a zero from xzr instead, which saves the mov. Zero
stores are common: with cpu v4, LLVM emits runs of them to clear the
stack slots of the structs and arrays that BPF programs pass to
helpers.

Before/after for *(u64 *)(r10 - 8) = 0 with 16 bytes of stack:

  d280000a  mov x10, #0x0
  f90007ea  str x10, [sp, #8]
  f90007ff  str xzr, [sp, #8]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e20c48028f71..083d8c383f5b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2121,9 +2121,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

