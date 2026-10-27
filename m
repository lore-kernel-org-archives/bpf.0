Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125494;
	b=5NE0TKmXXGTBokbOu88U3bSvitDXfn4wnNrlt2xoh28O64e3iKvX7hpSJlyp0lTL1Io0
	 f8YjvRpvQh5L5QY5oRE+WNQGdfNpHXP5BFNvURja1KaZz6S+wdUA0dMKY+JBbJPEqTpRs
	 4MEaEXDtbePLXGnh8ZZcB2W05g5VJy0sUYDpPmIYfqtoQBS7s1A7SysjKXDC5y1swqZEh
	 dNxEPEoODTKHteWdOD/ajZxhB0OLWz5MyoXtStTPwayz3Mm/L6nn10YTKwEYx/ZLzz7qE
	 bPAPTucr7GTREeM7TnzViof5b9gZd/ZZpZFHHaotHA3h/t3bRE/e+Q0Cih8dJYHVEWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125494;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=oxCQW5HwaM8PfDofvHdmFdOGhSfWfx87HCUD5vnrhOU=;
	b=VvswteHghD8mVLtsNSLFBQYauFkQXLtm9YKtOdBi9myPlbkX3+tZX6/n6mdYWNJfIRXV
	 CP3ooCgS+ZZeop90N9BkIVW4uP2d1CLt5hoaIr5YrYv9PmTIPbdn5yjDqLfLx2JfaNk4O
	 zKzeASscB5aJdBgSx8T35v8qlNntTIyL7lEPqoXRIWJOh9dVadHQ1brMdKdqUjEL/hKUe
	 DaXH1PBeYEqjVnwUFYrxt8+Ac78QEFOki4EuJdubtMhEnaI6zrywCZQyoo7BKB+CD5T9X
	 YsGMlabYOE+RXoT2Ye2UMuZEEIQ7FUYc2rmAD0iA7DaNGmFxkbGY7VNoaMpNoB1O4pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Tei7mcKC;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6995606A32E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6995606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Tei7mcKC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oxCQW5HwaM8PfDofvHdmFdOGhSfWfx87HCUD5vnrhOU=; b=Tei7mcKCnkTQ0nlABVxXcWKNqD
	mnWaisqr2uZdsMbgqbNLDXDj+OwMMf1aKV5sNis+KaG9NNuwWFXPb5yK6h8byljU9HxCQAfY8CiGu
	zZH4QBUDfrYDO4ZOVacHlGB+myTk2KrndK71GuUSAMCZ0EtIypwrwnodLk1jwkwKCvfB5LBJ5xNwz
	hI2fwNptVRI2lZTn3hIRCkwRIA20X8Ya3CjeCpW2H6qlvPW7wfCzo8re4HKilR6q+vtN2L5y9JEnb
	kHl2cSS3fj5ezR3nMcer0MwXZM5zZsh/rVf+El3NB0RyfzhlIRaaDipfECDV2D/DpbeYeqV048iGA
	/yfpgzzg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqu-000IlM-0z;
	Tue, 27 Oct 2026 19:24:52 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 10/21] bpf, arm64: Store zero immediates from the zero register
Date: Tue, 27 Oct 2026 19:24:34 +0100
Message-ID: <20261027182445.1156335-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

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
index b57420391282..c54f39a8b679 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2078,9 +2078,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

