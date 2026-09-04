Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC83E3C4D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510826; cv=none; b=dHFgqcyMerINaPbVzgIEUh9ihHkqALMA9g6fvqW01H0h4wDixExUdqXL/sCTZD3W22STrkKTAgk8Q5RApeEMo4obOci8p3CXUDahilaVxp6rAFG3pumGU8iV/h9+1n71LFJ7ay7XnEEX0dH/MO8r70nrD2nliTJTKWCmUa9giGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510826; c=relaxed/simple;
	bh=i8OPUhL4lUFFYi1+aCREuhyOOP8gIxyPhwlEkG5v80c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLAkpqvcMGowiCUpYRSLfsCXZqtHgWz8pXD2MRcBgJoqAJrKxJJjSfgQwFAvzaBbDuJkNFbQzKZTh1kpXBBN2ZYN0qARNA+EnRG5iXqKwSEdQLe2cJrId8vtFQVnAZs04QV7yTJlucYgUz7omwo5zWgQeLTuylchisewqp0ocOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=renbHhl1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="renbHhl1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-395cf2535acso823991a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510824; x=1789115624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vC40WbPgq+piJeq0gDg1QKCEupI2KwPTGsvEsuRJKWY=;
        b=renbHhl1AC4XoZELTzieZGYDYvlUvP46DhahZ3PuYLUzUn/nTgWL6Pw3Y7FVJY1V34
         aadMg+MG3QrG6umr80B9XWf1BqyMUIAexMwb0/kqUXDNkbrdl5HbxRsUnD8JgwgOQ9Zo
         1kJHOkgHpPKSjJE+fPq2RB+D0Xdxgcm992tZjZOL/RfpN0iSuM1mtFQeEaEeH/W1B9ft
         JaDINpO1XRqvkBwPQy5eN4QNB0rm1wSQBX2M4JMzoovZfFECt0DttKdHc6gbwPlAoz63
         fk8LvZzYWTdSG9fuMcIgUSgiFQ4smI3aib5BSTk+sAjqHDhSHkdGqK6JzrxIBaK2y/pe
         nOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510824; x=1789115624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vC40WbPgq+piJeq0gDg1QKCEupI2KwPTGsvEsuRJKWY=;
        b=Hb2D8oKoBacMGsyGHr66ynAe7jqFYjpzMRn3R7o+zboOTHJbeoMTo77RYjOYRxPfi8
         +a1z7sTmgYUqq8UDXuY7r8ZYLalAM+bODY+XNnUT8Fs2rvqwpx/sgYC/AVw9FMA6aEro
         QP2QMH1qZ6bKAdnDzdgdRFrSUKogg7+HZ+efttDD9ajsZksxqaUNJIAQnrg5dGus2ebe
         ItmV1yz/KrKfiheD+BDpdIqE+MOx3oX4VbIzIz0SxMcw8D0oB2/zWNDQ9peDbqkWBWxr
         0Nls4xd0kV+A8GkubtgPl7/ZGA0rNShwDAicCpYMjBiXSe5jsqXE9CveWxPfpXOQWeLM
         xIWg==
X-Gm-Message-State: AFuF++k+VYYM+JEFTAhi/CYP9Y+4SisP+pFC3Z1FNlhcxgh3MbWgtjHa
	NAGmQnflsWOVzVfBlNqaMxI4Mw+ywq9V1KRU31Bvegd0xULl4ACDE2nnouU2ByN45vs=
X-Gm-Gg: AYBFou09lgC6Oux+U48eCdWt8dr3sICoj2KB2xFn9/YDyhjsvwEtaxE+FYQL8fs2/mI
	5neg5rT59p/JVInvvZ7pkvBVrXgInBLL0GXrWbrhHFZoyYjptiEr9BbWEfPMVHLwfS8CCxWuRc5
	0uRjtgH40y1BgTAQpn0+NcTGY4MEtUkjQ2bfjQvaLVjCoDp/DgIgQFpMDZWlEKsVNHCm6quQ3UM
	gqd6G+srxMUpSv5v2wdOTSRB0XU9OEbEJFCco73GESHXrZxnTr8nmezflMT9vktC9ELFAzBeLZd
	Za5xZ6hdTrslQErzHWCf0NvFc+lPDTjjY2cPUQd3hWCeEzL/b0oGYcbV9SSS7WgirqZffpABChJ
	KKQ9uz78mN2SZr+Pz/CCCOfGMvaNLwed2t2qbu4OrCefBWH9tldJTU7Uq5rifGenaf0TJ1xWREb
	1qMFDs4M+jEhW0xTVpP5AtEqs5gU1A7Zi00mGFytqQbCmsB5/xbsJBLkk1wk74eFqcqm7cERMmI
	+R0OmQmRE7Z3L0gN5EF7iYaiku0VtcM
X-Received: by 2002:a17:90b:4c09:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-39b27d7894cmr2650053a91.11.1788510824448;
        Fri, 04 Sep 2026 01:33:44 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 7/8] bpf: mark the zero register precise for a register-form NULL check
Date: Fri,  4 Sep 2026 01:33:24 -0700
Message-ID: <20260904083325.2083493-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_cond_jmp_op() accepts "if rA <op> rB" as a NULL check for a
nullable pointer rA when rB is a scalar known to be zero,
lifts PTR_MAYBE_NULL from rA in the corresponding branch and does not
mark rB precise. Consider the following program:

  r0 = bpf_get_prandom_u32();
  r6 = 1;                  /* the r6 == 0 path is explored first */
  if (r0 == 0) goto 1f;
  r6 = 0;
1:
  r0 = bpf_map_lookup_elem(map, &0);  /* absent, NULL at runtime */
  if (r0 == r6) goto 2f;   /* taken as a NULL check for r0       */
  *(u8 *)(r0 + 0);         /* verifier: map value; runtime: zero */
2:
  return 0;

The r6 == 0 path is explored first and the dereference is accepted.
The r6 == 1 path is pruned at the checkpoint recorded for (1),
so the comparison is never verified with a non-zero r6. At runtime a
failed lookup returns NULL, NULL != 1 takes the non-NULL edge and the
program dereferences a pointer that is zero.

Fixes: 2f4cb53eed44 ("bpf: detect non null pointer with register operand in JEQ/JNE.")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb8e9efcfbad..709b4793e8eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17024,6 +17024,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	    type_may_be_null(dst_reg->type) &&
 	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
 	     (BPF_SRC(insn->code) == BPF_X && bpf_register_is_null(src_reg)))) {
+		/*
+		 * For BPF_X the zero is a property of this execution path,
+		 * hence src_reg has to be precise.
+		 */
+		if (BPF_SRC(insn->code) == BPF_X) {
+			err = mark_chain_precision(env, insn->src_reg);
+			if (err)
+				return err;
+		}
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-- 
2.55.0

