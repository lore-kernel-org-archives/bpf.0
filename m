Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2540DFB9
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149793; cv=none; b=GSJJszc9z8bIALJdf1//njhrzEksL/ecs6swy7E8F7kdVtRCTCAPSRS1p0TaJUsAlROzUJLf4CVUGcycvU2S49Z30ww4TmCQe74Ez8rW4hTPPT1bMIiDh4jT2El7cWARUVieD7nNCIhpwNfKfQmu35U4XtO5+Q2VxzoXXMHIDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149793; c=relaxed/simple;
	bh=gHNRoxVSqrNkMH/hcfVh+LJsirATJy8f3b63+wPgItg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Dwbn/x1v/4D78uXQAAqnMBZV/ib2QhmzXwpipIcwO8jTGzrmxRLtyVhCIdbmC7mAhPHw0JjQ8mM/woX7V1U7/DjJtLr3WpQuh8Zmr0vKiuEEY46+eibeyDj0qMVZLxvdaD6hAckQML5qoLaEr0zCRDTHRxdq8PiHfVFYZGfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Jk4Ygx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Jk4Ygx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8fba3f769so56418485ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149792; x=1773754592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1HSKzicmn6cGpC0YTCNBNmvhX9ynB3fnal8VNv28dg=;
        b=I/Jk4YgxD+hv+XxQZ7q64U4nsdvtLH++55F2jkNtSjHvuSr+0VWXqFN2W3Z+zEUbGl
         DsS997G8lywAIAhbpbOi9qZwZWBI62Ua9OIKdx07qRHqBM69rec7nw3OKdVDNFqPXeTx
         MM0yvw2sQDyaD/UpEvR71356W0vlzS5+FqijM+XcZ3+XjMmF3A9n0PsNPAfL0q61QvhK
         aGjkdJXUVeYTb8ZcGzHetgNBoRukbLcfyiu0l7+rqCOEv5fwuht5QynlcKH1E5bILkbI
         qb8uAhc7WNKquAymMqq1AmrWDPI/LZQC+6hTGp68mMZVcH9q0VXkiGK+Oe5i3fCI3PKT
         fLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149792; x=1773754592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1HSKzicmn6cGpC0YTCNBNmvhX9ynB3fnal8VNv28dg=;
        b=IRglZvZMB4iZ+vEQoHk0LRiwX0w4KWY70IeMtja+chriCtFcK6/xcXqQD3T3JkQ43H
         jlIO8jcNt/DhD07OxvbFa1/olJPDpI97iBzS8CP/w5d8V3tHomPrrK6OU09hX2Hw6L8d
         wL7tIZXrq9hAYHhqWL+8CSEM4smMuuG7RzoJ5maMSUknsurWRGxaY1VH5ElYsK3l5Xfn
         CUVgOzak2wg6+buyXbTXMGw/tAvSrDf40pEHQ5wvotlQmxHBDe/O6m5hEck/NxWIBetP
         WBYiYn67MpicRdxxGhmQkyy6AKskYa8b0hHr0QE2hsmP9rZc/N7A9ggol+21JVXtTBNM
         Vp2w==
X-Gm-Message-State: AOJu0YznjIR4ZJhl/+r435JC4xlm602h4fsHcS1jBwn+qPhsU4KsK5Rk
	kb+NWMKl6PPSC6BDaTrxvFXT1LExfI2HdbVQF4Fur2vecwhwJGmTLPwfC9GyI4MyN8E=
X-Gm-Gg: ATEYQzy3O2p32AHXasbmDOHyi4u9IEZYOF/Zys47D1/g1GFFJJMXgNjdnehT8lICi9b
	2iR/WcQ+cAbkasf7VI15RyGbxU8sONEAY0UqkUQleHqFLdv/QwvXKNrcugEiVZCJIhpiJlG1wDH
	2PxIjgfonGg0KdQ/IQxw+1uDwQ6ZkTQz959dcl6yVfk4yrDUyIwqyzT0RucZYN1scb51hchDw6y
	ycpms45TNVPxPtTAAC7Qyomn7xiPDax3PUkS7kzIGxMSuGurYYeOXEaQ19g55Yw0islOxQACrDu
	7GV9c7SUKbsYPLynDEzsS5cnla0s7BI4icrWG7UYjAnk736EdhdFZz+JzO6Kx841z63SIWLyZsz
	UCuMszMfrFtWrin+DGHBT/BeMojlkzqPTF8ANeipOXdNrwbCzKrR96UcsMCrFvX3P/DQIG6COYJ
	xnADGTHoexpBnuAttPeSyYqn0SYLgaeGHnSoF0FBakwnJWBYLoegAAneMdVLznUKe6CVb/hHDTS
	unfn4sPomWHMU3R2UAH
X-Received: by 2002:a17:903:3bac:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2ae82434346mr146314095ad.29.1773149791527;
        Tue, 10 Mar 2026 06:36:31 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f6csm203111285ad.23.2026.03.10.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:36:31 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
Date: Wed, 11 Mar 2026 00:35:03 +1100
Message-ID: <20260310133504.94871-2-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310133504.94871-1-danjwade95@gmail.com>
References: <20260310133504.94871-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
source operand is a constant.  When dst has signed range [-1, 0], it
forks the verifier state, setting the pushed path dst to 0 and the
current path dst to -1.

For BPF_AND this is correct: 0 & K == 0.
For BPF_OR this is wrong:    0 | K == K, not 0.

The pushed path therefore tracks dst as 0 when the runtime value is K,
producing an exploitable verifier/runtime divergence that allows
out-of-bounds map access.

Fix this by passing the opcode into maybe_fork_scalars() so it can set
the correct value for the pushed state:
  - BPF_AND: pushed dst = 0         (unchanged)
  - BPF_OR:  pushed dst = insn->imm (the constant K)

The bug was introduced by commit bffacdb80b93 ("bpf: Recognize special
arithmetic shift in the verifier").

Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
 kernel/bpf/verifier.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9e2380327..2e644f489e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14193,7 +14193,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 }
 
 static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			      struct bpf_reg_state *dst_reg)
+			      struct bpf_reg_state *dst_reg, u8 opcode)
 {
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *regs;
@@ -14211,11 +14211,16 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return PTR_ERR(branch);
 
 	regs = branch->frame[branch->curframe]->regs;
+	/* For AND: 0 & K == 0, so pushed dst = 0 is correct.
+	 * For OR:  0 | K == K, so pushed dst must be set to K.
+	 */
 	if (alu32) {
-		__mark_reg32_known(&regs[insn->dst_reg], 0);
+		__mark_reg32_known(&regs[insn->dst_reg],
+				   opcode == BPF_OR ? (u32)insn->imm : 0);
 		__mark_reg32_known(dst_reg, -1ull);
 	} else {
-		__mark_reg_known(&regs[insn->dst_reg], 0);
+		__mark_reg_known(&regs[insn->dst_reg],
+				 opcode == BPF_OR ? insn->imm : 0);
 		__mark_reg_known(dst_reg, -1ull);
 	}
 	return 0;
@@ -14277,7 +14282,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, BPF_AND);
 			if (ret)
 				return ret;
 		}
@@ -14287,7 +14292,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, BPF_OR);
 			if (ret)
 				return ret;
 		}
-- 
2.43.0

