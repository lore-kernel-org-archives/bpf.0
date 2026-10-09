Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A394C33DB
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542913; cv=none; b=ulPFGF/plkErLF9boRiTaAe6KoMPYancjquLwFb/5OPequgoxFji2Hi5naiYmnkdgYcLYLVc+2SzbR798V7gKycorjC00M4jiE/wFEiitnv16tIjk0mGWIVf73rPuy7IPSEBX4lOP9NrLcWAQubCM0besegajyg1sC7fbGM6Tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542913; c=relaxed/simple;
	bh=iK6B2ysQno6+oJGWm/4ovrpu0gLHCRuwcYknWK1/r2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/siAI1yn7J+uo+zceL/2gV17x1sL5g5W/6m8nahMxi+w3AYPYX0D0sy3q8AR9GDoENywEvBAyvFK9nzfZ5llud84sMAQoVXc+OG4OP5D8J4t79I0l52GNwGD/xV5f2qMY9l5iLiZzHfrxxOnGMtBO4LtPZ/vBEuiyOFQCytaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLRmkOOX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRmkOOX"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so2193297a12.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542903; x=1792147703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kySQWHun3LVMu/bdypxd0JPXyMmp8EiUJTp20UFQlQE=;
        b=RLRmkOOXkAl92tvGPTOEBdQnU6br26ELk4eNEBupOk8KdQklZA1CJzTpFAbgGYJxhz
         QWg1SrUSsTt7T2vakzczVs5FA+wbcI91xv8JJ4gGNZxJqt6da6HpzdnffWJcCVLQSKnM
         auGoaPm1QLuDfSWipJV/6cmT/pYYkKt5EuK7toNhoP67gI7gjGtpeE97oVvoGRK6Me5B
         BX70BsirHrvUvE2vs2V17wlJKkyui6GgCC7sK7Or32KDVUyzQqaYJFmpQy9b6uRq9w2E
         YLKCB7liN+qNBMbC0ziiJ5CRaq+GqU8Igir9uoAh183aqHq1EeiuuI6S+EPn53XmvLr2
         tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542903; x=1792147703;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kySQWHun3LVMu/bdypxd0JPXyMmp8EiUJTp20UFQlQE=;
        b=Jmi6jQ1ahRwe2r6mNB2TptB8Tx0cWoA+Z6CdFvg77BO15fw3Y5zPFDtE768ZVV3n9U
         QVOBZgHWNPLzP6h7F81cF266Mso5dFA0s4NdjatLQs4ScsUQT71mh4R0XK3b9znF314l
         Tuy7JUhE0yjl6ZHuIm24U46Er3A3OmWvP/2QO7KW2z2F4/gvT91YB51Azt+DK2nctu6V
         jA1WOHkSuUk4eopLUzYavxIHJp+aEIqjuBTG7TB2Ho6+XPvqN7bhxuN9RPnF9Phps3wi
         1oT+YlzUpnGri4XtyDtffO7FD1+gKmYCZmqRk51NBP+FFsL+pdJnxTx3CmD1+jk0KryC
         fRPQ==
X-Gm-Message-State: AFq9FYLKx2+uGGvhw++YTsbZfhp2DcvI+tUp9f3dO/OdmsS9zcm8bV+l
	/wAMj/6nqUiZo2NCUQ+hWVoDhbUkh+PqwdsJDN0c834Qz3W+EZrD9bsigw15wWs7
X-Gm-Gg: AYBFou00ddfoY8gwHm0rpE9V+gcqawTs0nTahA+sqa3RpXsVHJ1sUdLac2INYjxKO92
	TrdqNb4l9jLfyFkyTEAIwbovP0CgkzlG+SCNaHa9g21N1NwNpT6RagpplC4JhwGNdPFjDlx1G9j
	rWQDCERzElmRlhnnmQalBDQqR5gu+oUfoUC9GO++a+Fy1FOQb2Mai/08ahITXGvqIbqlr7NoUsW
	Q70ofPD6B3/43OhjpgWKiDEiICkcZcOvAcszL9UCwK+A6Wh/Od593mDQYwXj+2wdBCis6sgP+6L
	HfAx7rFdEKufH94v4vXwxTrndaMuBcGc2g3RKNotGd78afNGlfKUMxYtNtWej1Qu0iuKiJ60Mih
	YNftviyiTufO4rsH4Re7KAaDxBtGEia6si2mQ4YgfHFYjZx4DgrSTdvMAePQB8+dFuNNCrE8vsK
	tO/lT6izDMSIcYgwaIyK4RL2/wlSLPEfjULfARQ4a5NDbxDlnNS4Q1dARt88nVvISK0gy5Wwu+q
	TaMfwZ8BLCsyyc=
X-Received: by 2002:a17:90b:5404:b0:3a7:ee74:e8d2 with SMTP id 98e67ed59e1d1-3ab3a94ae98mr1353569a91.25.1791542903091;
        Fri, 09 Oct 2026 03:48:23 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 07/51] bpf: summarize regs that may hold a frame pointer in insn_aux_data
Date: Fri,  9 Oct 2026 03:47:25 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-7-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV needs to know which registers might be stack pointers at a
particular instruction. This information is used to avoid widening
registers if that would hinder further verification.
See the patch [1] for additional information.

liveness.c:compute_subprog_args() already tracks this information.
This commit modifies it to save the information in insn_aux_data for
further usage.

[1] "bpf: avoid widening registers that hinder exact stack-slot tracking"

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/liveness.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5b615083ffa9..d31c1a500958 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -668,6 +668,7 @@ struct bpf_insn_aux_data {
 	 */
 	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
 	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
+	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool nospec; /* do not execute this instruction speculatively */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 004c1f48a065..b9b76684906e 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1896,6 +1896,17 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 	}
 }
 
+static void record_stack_ptrs(struct bpf_verifier_env *env, int idx, struct arg_track *at_in)
+{
+	u16 r, mask = 0;
+
+	for (r = 0; r < MAX_BPF_REG; r++)
+		if (arg_is_fp(&at_in[r]))
+			mask |= BIT(r);
+
+	env->insn_aux_data[idx].stack_ptrs |= mask;
+}
+
 /*
  * Compute arg tracking dataflow for a single subprog.
  * Runs forward fixed-point with arg_track_xfer(), then records
@@ -2045,6 +2056,8 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 			snap->slots = nslots;
 			memcpy(snap->at, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*snap->at));
 		}
+
+		record_stack_ptrs(env, idx, at_in[i]);
 	}
 
 	info->at_in = at_in;

-- 
2.53.0
