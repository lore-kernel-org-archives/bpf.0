Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620528;
	b=PuFB4gtkXDPkDDGWL+iFBatVkf/Jbrf5GZSS9nUJfGoHOr6DRuRXqm95egbpvNZAHR6+
	 NxpxfuCXUO9eGzC+QMq4iXqHjYA7JcF7bbFjtD5jSe1fHWDe9zg3hdWsxG2bWpYO2ZvOJ
	 k5au5pe1Dv8PfDX19NbKR8zgD90UxSNZ/IDExYWFMbuiUZTqbZF5UvCEtd4gWvaxsLncA
	 hCaMIPvAj2gCrr0Ccp+NJtSMCcd9O3A+UJx+DM3aJqxIzX2loYPOW/SbMUn8JWeSK1Fwi
	 kjIl7QX+xtrb2S3BHo/PC0IdXk4T7KExGZhRdjem02XkK0l1vPmibE92zaqPHH4qucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pz4tEpSynEYvkFogLqp4Cw8HLtwWsTiM4dIDzA9K+QU=;
	b=TfywwMN1QZbmPORjuRulOuBzRy6LprxeoU4bkCIV7JEgUN2i8kecjRu6+U1Rwj+rQi12
	 8j+yc8MkNH/jJS2Qtn15UxRiw5VYBGV+Yba3yAftlsdYJT/qeh7WtKv2igiZtVVLncNaQ
	 85gKUmkIqEcwCns4NZw9WYsOYfdbnI+ETDXY5YUQXui8DlPakh89odwG2XApIhWWI8nOT
	 6I8eWqvBlgExynhLWxoUyPc/UBHlzMnwYnNlrwAAOpRIgvqhodUKdb9o6EQcr26vlkghu
	 BrEiIaF/Mfrzxh6i8GVinfFhX+uJCEM4WiIdN5hPRtYdafibol1091A7CLs1zGGjtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fH+Z1N7P;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2C606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D2C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fH+Z1N7P
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e96502e447so9149365ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620527; x=1793225327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pz4tEpSynEYvkFogLqp4Cw8HLtwWsTiM4dIDzA9K+QU=;
        b=fH+Z1N7P2Tgupp1W801NO1dPhcYVH7BamqOzAtUSFPWa/HXms9IOE8PB3qIpLkGF2p
         M6W9UNIGqgPAvzS9lwzuQSJgeehzTrkvBi7M5tpLFaG39QjY1tPMVA455CJSip9zAPh6
         Xto4MKyHaAhU2abCXkvRAkJ3fLhyq9Jd/uGFhGegmUOxDVKMPzz/L1KisFCexrJ46wc3
         lcGdsWAmZOebA9yMjuFjhzsGRah6wukkq4e2BKe4WMcl8NGNigZSsTqTAd3zKb9Nd9Pr
         fK4cznOcowRJhBnPSc+V9DHwRNyNr0iGR6C9+GXR89hxEhMRMmx/x2Y1SQu7yVEHulqc
         Ktfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620527; x=1793225327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pz4tEpSynEYvkFogLqp4Cw8HLtwWsTiM4dIDzA9K+QU=;
        b=D8BAayAS37v45Um+I3Y3BVbCwGhVn4JFpb5Ml6xuOl4rk/RH0W3UqHAfnJoPHY1YJO
         E9jl//RvoCkTs8Ay39wV/bqHDkl7V6Nbdzzx02vJX9XaA7Wed8dazGnuT3G4r+WuP81w
         GbzXzxqBIcvpqEupAKDJWpp7hlkGRf+whhPeXd/90fFejQsoEU2lb/c+xp6YoQvXQSOq
         o6UYCdOy/fVeRWa4yOZQpvvdlLuxne8HZClYCQkJZ3yPnX5H2TAYSZ2E0TYxlx6bbtbp
         2rGzhMv0wOH2QYVVSkXX/05rlZVnsj9nbWMaVPFFshuzTWDSZvoDZd8VJpbupuUnR+eS
         Bh5g==
X-Gm-Message-State: AFq9FYIP17xv4ODLV8WGVm/MRVUOndpftmAAdbBlsNgf0KRpiHZv7/J5
	s9DuAyTBaj77G+eRE/0oW1joduBoiXy9KMtvwrxCLFgNYbb/NUnyh6lU2GEIcg==
X-Gm-Gg: AYBFou3Oz5pcabDYfrEQvnDhbvi7gpu0WYHLWBQSImKuwur8fJmRvrzvr5wcVqAkJX1
	dKsNOILW4HJ7CIg7QUWJJ24T+6o1aH97bn7HbjEIid/kqdtlkr6yDwwAcaNNRnN4SEXQ2zPZ2c1
	u8CCtCoXCyxxRVzuIOC/BJhjQzOJOkoyj2cM7kTvi5MjXSTDGv/7DioXgKSfyvp4HYwsHCRMbbC
	/YJasgtep1ev7Ce/AOKincTxaSz4laMkNU8Im/iBvAJ8kiTZNxVkg6HoNyB2yGY0yABqMW4Ui0u
	WBPckLmXCmEqIVpy1O4ibuY6h+PJgb+eDiQfrM+3LZ4SpmlDzsNthLGOABIKPSgdjoyEg6TpAsz
	SuBI5xLfxH0M9/BnJemU/SpKDl3JQys+hvYSxvm0NE3ROWtAaynNu7CbaqGsrWcKObtEYD1/xUQ
	I4nluBBd19Vh3aiw+jg1AhFSd1UMVYLdoFK1ULbN+r6ZtKgNQXADf21uBQqHNXAzGpnM9dHMxAA
	67Wk5Ax9SeE8b9EJ9JYCiVGYbk/USZKaf+65hXe8jDVU5oP5mxW++XhDkld58/DcahKPOyhbQyt
	b/2NKY9x/L+b/TjwGCa7rqVo78wlDzcbjHsDjDmwgPv0l4y/Croir5pXEs3edJxnoSRafStcJyg
	BM50IsKUG2WD3zREZjD8MD7Zn
X-Received: by 2002:a17:903:2a88:b0:2e2:cc25:b232 with SMTP id d9443c01a7336-2ea43cf0a2amr35063215ad.42.1792620527242;
        Wed, 21 Oct 2026 15:08:47 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b48edc9sm15707205ad.67.2026.10.21.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:08:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH bpf-next] bpf, x86: Use emit_rsb_call() to call bpf_unwind_target()
Date: Wed, 21 Oct 2026 22:08:44 +0000
Message-ID: <20261021220844.239400-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

clang inlines emit_unwind_ret_addr() and emit_patch() into do_jit() and
folds 'bpf_unwind_target - X86_PATCH_SIZE' into one relocation. It points
to a nop in the padding in front of the function, and objtool complains:

  vmlinux.o: warning: objtool: do_jit+0x1330: relocation to !ENDBR: .text+0xc7fab

It's only used to compute rel32 of a direct call, so nothing is wrong at
run time.

emit_rsb_call() does call depth accounting too and hides func from
the optimizer. Use it instead of open coding.

Fixes: cff94a3d78d8 ("bpf, x86: Support unwind_goto and unwind_exit")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/bpf/20261021201456.GA3197963@ax162/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..71f7200dba00 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2564,9 +2564,7 @@ static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
 
 	EMIT2(0x50, 0x56);			/* push rax; push rsi */
 	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
-	ip += prog - start;
-	ip += x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
-	if (emit_call(&prog, bpf_unwind_target, ip))
+	if (emit_rsb_call(&prog, bpf_unwind_target, ip + (prog - start)))
 		return -EINVAL;
 	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
 	EMIT2(0x5E, 0x58);			/* pop rsi; pop rax */

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.55.0

