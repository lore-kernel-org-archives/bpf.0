Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB917B425
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121126; cv=none; b=tpsp1hCK7nfLCYeGj9SQu0fUflXLPef5jEtyu3VnxteDsMMTFJPTeTC2MaMWZBMDRjhxK+8RVwoLpnUiyXqSBWSeBL7mCiMskHv7WRShJGfRDBzEPGSVhCN7oDBgfW/1CyAZ5aLUrMRKQLKMmdF6Eb6iRbno2WjOIvjtS9f63ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121126; c=relaxed/simple;
	bh=iK6B2ysQno6+oJGWm/4ovrpu0gLHCRuwcYknWK1/r2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmuaBrPU7TadrpeDfb3d/PFrZH7vXbqdiD5MiFF2YYIAE4K/wWvy9111fMoD0GgH5hAUznW/c8lmIJeW8wRYPDH/MkIwv8PMbz+amOb6jVjA6rM5768n6g8NCjZ5Tr6VVusznTpc0Di14CKBg1+PlTgbGYVWXSz8n5Cf/AqqVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2MZShbw; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2MZShbw"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso239873b3a.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121124; x=1791725924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kySQWHun3LVMu/bdypxd0JPXyMmp8EiUJTp20UFQlQE=;
        b=g2MZShbwVpXR2uz8NCZecOgFXcqqcQAEg5NedvMMYB3qCG7+SEokhTovUBpylFohnw
         LgrWV+DEqcrbmWiRGwZ6861+bUhT2IihcaUJvpapVvjlPAaW0/Pr8jIznN3BSPehD8hK
         fNrLgv/rUaPJqkBzICUfPGJtsgYB6buze8jNw5UbFBW5aHwPrURldJausqu3qslfGY67
         O5GC0ud1RyaLId4PeDqR/8DWyEtdn5YptQNLV6RNJUWUaDEbNQ/ITi+vZP52+yG8POH8
         /XwZZmKQGjFoTfycsI0wdPA9+B3223U8lnDXuuTiOm7YZ/rJ2xHKOHqWCmMfVgx4oDuG
         hbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121124; x=1791725924;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kySQWHun3LVMu/bdypxd0JPXyMmp8EiUJTp20UFQlQE=;
        b=bmloXydPXdSWonslFVhbUgXzWj8pVO4h2aQeAVQh8kLty4xWBF5e9L9ocAH9R3ULR/
         +dxrM2NYnIykEgzk2hAkk9ovBYjQQwrOYat/JXHoZ5o0qfdS47B9FgsLeId92UbPFewK
         uQFL/Q+JxeZhT3Ti1UsbYC4HqakxP/oj7kN+Q5sb5XKduvrAVffza+NG+URireT9zaAJ
         G8KX5JxUXA4c1yJn+vPx1BswhQ2ypxa9bPVzR2Vcf//zrpxjgP/A2EB8ODxSldVHz9BS
         DGGk7eBmexjwmjcx9Pf2zXstWSh1/X+0CCKWYCqofeHQIevWNzQIEr5fULSbbbIfV74a
         XhAg==
X-Gm-Message-State: AFuF++mVPrG1+2sgx8z8aycVu1GidnBz0qyzT/pWTKt+OJxfnqvDIfjY
	bhcDLige481aDJTMdPZxPGA1btuywcl3cZKnalUt7Q+pFGzfY7B4l/8xYCsymg==
X-Gm-Gg: AYBFou2OXouPG0V95W2jrtLsuiKoyFiG2oME6uta5hhooKrPo7kwvFMfL8Sl676T/Mh
	AqzfKklo4osiVcoQy8kAJ9+MoonK/QBiCsPdkgDMbLjetD61jMlaipC2mh3jxDVOjM/79hkbTgI
	ylcCXqNDi/JcZn+T+K1X2K2V8DYhrx5J8h88/Y/u5VQhEECzOwJfpZCxCKuiUoWdwh0rM+V8CHk
	NrhtxUMAZmh7dKkK+DPGTf9L51d/uTbd39Axzia5xLnf9rpMkWCLw6n2In1j1hj0eUs7oY2zlvA
	QWPp83DtsMnAMy8u/pxmaS+3C6lWjztRQT1fwhJQh0WC4Fw6WvQFPMc49qEFPMHLTKPr1PoQVTx
	KQJJAipYD4lc2c+u28ZPNUcNooifI8S+Y7ZJBdO8ujbu6qMuIfdgxnFgo6BsZVmTg79uCmWL0p9
	5XitX9BHZIhn8dAWWTRNzremiqHVqv9rE06s+2c3EZ5xrq1Up2XgBQ7NKxqIBbjlQ1QsQiINDW0
	Sv8X4kEytInG9Y=
X-Received: by 2002:a05:6a21:328c:b0:3e0:f75e:dd3b with SMTP id adf61e73a8af0-3e0f75eea96mr1181990637.59.1791121124554;
        Sun, 04 Oct 2026 06:38:44 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 07/43] bpf: summarize regs that may hold a frame pointer in insn_aux_data
Date: Sun,  4 Oct 2026 06:37:49 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-7-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
