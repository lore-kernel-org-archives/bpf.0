Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579734;
	b=0OGhS4x8tvzK7kIwjayhJzXwFC5XOXovhDtyPYxsLTigTm7lY0Ko6TjgAzl+ApoXxKBb
	 tPQhfEjS0a/8CPilHJOLOgVGq/GT2OuaGxG1u+QChMZOBcc+PQZeqyysgXqyKPecnUfe7
	 KNguezT4lziSPbptf1jMcIGs8/mSyPhTSYmMvvUV/X+Y6PXC3KDr8Ql1hzSdKmiEKO9zB
	 DzDNMEjnu1/KWwFr3T17j6aNNS4HCT7Py+xiE6MYfzU4M6DsVfuOM2LCJ/kqRVfCl9H75
	 tZVaw+TWGwUKVRHhz2aIcr+rZliPCzpwTe6khMRvLHp6ycNlndTY6/hJ6H/Uc0EXylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WJRwWPOTE0hYoLp8KuuVCByDfF2c3mIcUS4E6iAWUJU=;
	b=4LmwuRRxtvkwzepnbD2YHTLlm9qxuxIYTaXMmbTk72t95WtgiHZlInemm8b5JBW0lFZW
	 SuIJGlZdvKT/DvUoM9rOOrlbEi6NXioY2XC21+7+g2mCQ5mYuMrzEZUFXdgsIcI+HVgNB
	 PkfN74F76hUbZS4FFpNemuxrXBs4/FsvMsCNjtjjh3hWivKZhJONEZjy1xc6Vjy443ysZ
	 vPd32wRxdZ9hUNvoaq+ReYjA76ao6MxNb1lGpmTrhH1sry55tSvgvUkVyutk8znX8iEJW
	 duoqHcId6l8rtwL2bhhzycLL/yI5hkbYNXPBVPbobJmG1uWqsSonePI8NEt7N3HJgww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSg4ip4U;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31821606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31821606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSg4ip4U
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so3566456a91.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579733; x=1796184533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WJRwWPOTE0hYoLp8KuuVCByDfF2c3mIcUS4E6iAWUJU=;
        b=FSg4ip4UbJRR/gI2OVbmsrwE6lQ5455knfLlkvUKyZM0hOMvfHuqTIRE8zdRbrFJg9
         qQ4P18/P1158zzz/gFZgur7qL2a7U1ezaGkrmQpWU9jukMzxJEIOshzN/w2p8ejNJKpD
         m3yFw9FX8v22rgRyaLU8iPzbeVVlZYtJhz8Pz7abpdMBOsYZN1GHwHYTuer72q3A6hMo
         LjA1Xm+cZamNnxbtcGsju0TN+FJSdojCSrGDEIycr7A3Mw1PgfrAcSmmOlveacxGWAk8
         2v7zgF66GOLhWunemfCjQbmOlR5iemcm/tyOHOLnbnj5ieP/2GxVkD9dnNb5pfetmJIT
         tBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579733; x=1796184533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WJRwWPOTE0hYoLp8KuuVCByDfF2c3mIcUS4E6iAWUJU=;
        b=OCPRb8GDfYbOXPP/PoCVqo6f30leKuHz7k/wEvNpyWNTzTpKUMMxbn8e5SATSPsv8u
         3T0rP/hNDV37kUaDyRMKxE+F/9ZaVST/vUb0juXXV6oDN9ubHJ60wRg+eDonmC9JhiP2
         L3pTFxOuCJ+jTx85PkfV/wzBMvnwfNE0xlteqjzFGDDcRuvIrYaoNYI3uBb8/+tW917x
         g9nujkC3dmBNhnmKJeCrWTfAyaNfDc/i9eGK4YXYeozJgKIlemoaot1TdbZkgT+EACqV
         nhI8Y6kHnWol4k4iQqDi5r5TdmPg1bVUxBkUbgaEea0tmN/4Z5VC4L978l/1nlL3gezM
         Y6DA==
X-Gm-Message-State: APuU4Z9L5ID9pqX2JyN/e/2Rf1AUlALYYHbBatm6g8rWm5EfBCtL8w8P
	mPWZckPqHm/wtr+S3yayjgFCzrtG8SlYA3tuwJGXuDz+nUrvSqOBJzfYnebqrp3w
X-Gm-Gg: AZFdTZfd2CTOrMCCrEKrip1RuBAnaqSy57Gr/x2wsudGjVJD50RqWSFbHeq9ztbqqtC
	RplAn1x0JzaA5Rh2czJC9mfpDQc/d+Mm4fHiAgi4WmoPtgj8wRfZje0JUB/PZJ8MSZbf7lp7LN/
	qHMAyYkDakX0cab8fvFWSd7LeSfS2Lhx2ZQSTt7mNEafmoCwaWXRdlih7EYvq6BKHOFraDsbLMD
	vwSV/pissHXjitcxecbosDIO2jDrm273dtTthO0m5s5jx3o9fxdvnbv85TcSpEA82DFUugimaJk
	x2opmikpbeVC9aq4bha4mQgtseGeCNxhPm4HGjUy0L65Tu3vmQn9ntzg/H0Va/dFQ7kM0pNeIbx
	kdgqHNUVcwhSZNQAelXqa+pSOWwNlMnO0sABPDcqfCJkD4vXcCyeg71c4+rVc9qhrI8+3sSh9um
	CUh0YiKKr1DjH+bYdGAHz6pk2ecPNtmxfvKW9cNRFDIx8z8M10CypjzuBb0g4OQrY/ZAzDBBO3/
	R/vZLwEjOMxYvMrRmQxzh4SQXAvxqUciv7WSbrwb188Q+px3qm2MfeUMxCxekoMOddeIqerVg71
	/kIBcoTgZ0pluN7ogBLuyx5qFoOsdWFdnqlXB6nDsoXJ5bJ8p4mtD59SsxEgA2j0z7ED0+u2XpG
	cWhCA1vNbEp+PUYdG1GCd3qLmqxcnQJKU9CsxHwyYmaVECXDdXEmi5BU4NgB7dHSvdWuZLct/rq
	0=
X-Received: by 2002:a17:90b:2e8c:b0:3ab:884b:65a9 with SMTP id 98e67ed59e1d1-3b41c9e430fmr17146012a91.25.1795579733309;
        Tue, 24 Nov 2026 20:08:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm9879546a91.10.2026.11.24.20.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 5/5] bpf: Do not end a speculative path at a call
Date: Wed, 25 Nov 2026 04:08:20 +0000
Message-ID: <20261125040820.947816-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
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

do_check() ends a speculative path at an insn with nospec_result,
because a nospec follows that insn. A helper or kfunc that writes to the
stack can set nospec_result of the call, but bpf_convert_ctx_accesses()
emits no nospec after a call.

Continue the path after a call.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13c53df386bc..251106d0b233 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20808,13 +20808,14 @@ static int do_check(struct bpf_verifier_env *env)
 			env->insn_idx++;
 		}
 
-		if (state->speculative && insn_aux->nospec_result) {
+		if (state->speculative && insn_aux->nospec_result &&
+		    (BPF_CLASS(insn->code) != BPF_JMP || BPF_OP(insn->code) != BPF_CALL)) {
 			/* If we are on a path that performed a jump-op, this
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only
 			 * used for the write-ops
-			 * `*(size*)(dst_reg+off)=src_reg|imm32` and helper
-			 * calls. These must never skip the following insn
+			 * `*(size*)(dst_reg+off)=src_reg|imm32` here.
+			 * These must never skip the following insn
 			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
 			 * is false). Still, add a warning to document this in
 			 * case nospec_result is used elsewhere in the future.
@@ -20823,9 +20824,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 * fall-through edge. For these, nospec_result should
 			 * already work.
 			 */
-			if (verifier_bug_if((BPF_CLASS(insn->code) == BPF_JMP ||
-					     BPF_CLASS(insn->code) == BPF_JMP32) &&
-					    BPF_OP(insn->code) != BPF_CALL, env,
+			if (verifier_bug_if(BPF_CLASS(insn->code) == BPF_JMP ||
+					    BPF_CLASS(insn->code) == BPF_JMP32, env,
 					    "speculation barrier after jump instruction may not have the desired effect"))
 				return -EFAULT;
 process_bpf_exit:
-- 
2.55.0

