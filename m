Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D9390223
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110219; cv=none; b=fpSi1ikDgryRqXk4Sa2llRa7ijscqriIT70VNsKDALwXvB+HPUqDNXKd60+ezVXQ/hROXQwJDTUBDxzWi/f4yajXn9G9GU5B5cK+Hk3sww9B9P5age8bY5lrd7k810MQWprbtVfNB+PWY+HN73hEZQCIA/Svp/jHZ/VVASrvktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110219; c=relaxed/simple;
	bh=qnOZ3pZVmGhoXHk1WKN3SGMEkSGXjcz9fN46WOajHak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7vh37htk+nTAW16NlTxVfW0XeoGme+cDyO8GByno/ySwMMhp0AdPk/BcMWsMQVlIWjlBBjJXQDDYfLXI6v91mAIPIUwZjHrOiaTwm+qfftaO1Tt/plAkEqx+O+ClEAaHD0U7eW3RVwtuEcMX53QGV5UBoPamJIyWNt1V6a3S7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt77NHdh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt77NHdh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fb7f51171so1214871a91.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110218; x=1776715018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N+ggbalB+aiT8TNp4qyNwpeEcxjZBAepL60FMU6ub8=;
        b=Wt77NHdhh24xpMJ8kbV/jyLcnwfIiDsle8AVKX01nFndhIM0ijwb8WnXWNTMeQ3OBN
         IJdmYqPdQ5jCJPKbf5VORd/Qx0saifhc1lkY29ADV0NzIawPbzR0GDCCejmTbLls3PUb
         T65ZD/H4TjRKRiraaqF7bNloOAT5fm5e+79DIwmT953f69a62lYVQhZWdnYUExfnPIy7
         KP0uB1LeJjnX0oZB6A8maNX1WDiYhffVhWOrrnATL+gc5yucDZd21mC0A0R1QLc0SyxG
         71S1Fpp2wIRXHPEf9Au4q+epe3GzbfEcUjcv7QF03f9XmasFMhtg5w4Ax8rnT81mOmYr
         F4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110218; x=1776715018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3N+ggbalB+aiT8TNp4qyNwpeEcxjZBAepL60FMU6ub8=;
        b=cHIZNKec6D6rNoBIMMepFBIsUHflyOhuMah0zr6vcOxzFSg73jQvU3b278FJFlbkEX
         Z8eF8o7u4pjF4MWnKwSzkd1LzLWMEBWRDWLvHNjk3G6467gtnYwU3rgMxFhEqNB8Cson
         PtajUU9WPeUHqUmwL5W5wBh0uCLkNh8LP/ulHjxPa1vL6OE6QRwzgL1EHFO47aC90udj
         24clWr57l9lvOjn5g0Fr68DZnwGLWl5T96XA5st9aWdmWyFBkLzvTpn3VPAnTP6kD2I7
         yeQooWihymmv1gMlFZuyapDqfTN6s/MoURE9CNFF1AAZdxYu+RPKc2+vmEolTft83NIf
         sjIQ==
X-Gm-Message-State: AOJu0YwtpmCiWRYYzrJfZJreVzGktbjal26YnEszrz/rr6RcGx/OPint
	ohnORDx6aHKySlaLLV7siMtUBKa0W+kyjRTRg42njQ3beYtckknwLq+40mv9IQ==
X-Gm-Gg: AeBDietN/A4PBFaAH4k1ciph2FbLHQl+TtH7vm9DCsm73JveuUN1VmJvIz/FSt3cFUm
	7Ctyfa1Ol2seFLE5cn1/nfkBsEaZSYLMjKOzG3Q0RnV22yHaugwEz3PNTp073rP4MyH0LpUMkTG
	AwgecbxAe4EHBkvYMCOZoB9b9RIE0jreoRchaFDV/Vz+x6xAFgMv28CH4Ks7c8MUR4GCcSMXtF/
	TX643cUl+TO+KpGgiiCRSeVoGQ0uXbTqaW+7QCtAxmXLWSKGDhZr197pMDfRKnlz6WXxFxwUmiY
	Lm9fJGBBeXIPdEDu5DBelpROtMI2uADO8C3KoQavQCZMOU62lz9GIPpEKNjwTrHqSNiwzjQjeg2
	4q/VYNuRiDe7xGxPi+32gKnp+b9yJU9gNnEVscegyJ9S+VLMN+D8thgbmt9pAbPFZBHWBlM3wtQ
	bT4STtdr6opI1aRkmuCKPpThN8mP7SDUc5kpJzBPbHZlVkYN8xmtCEZJy7zxc6VFZNemgfIIaUA
	PinjQ==
X-Received: by 2002:a17:90b:3a4d:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35e428412a8mr13408962a91.19.1776110217747;
        Mon, 13 Apr 2026 12:56:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm16452599a91.9.2026.04.13.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:56:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/3] bpf: fix arg tracking for BPF_STX through imprecise ptrs
Date: Mon, 13 Apr 2026 12:56:39 -0700
Message-ID: <20260413-stacklive-fixes-v1-1-9f48a9999d6e@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com>
References: <20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

BPF_STX through ARG_IMPRECISE dst should be recognized as a local
spill and join at_stack with the written value. For example,
consider the following situation:

   // r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}
   *(u64 *)(r1 + 0) = r8

Here the analysis should produce an equivalent of

  at_stack[*] = join(old, r8)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1fb4c511db5a..8069ea955023 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1042,6 +1042,12 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		verbose(env, "\n");
 }
 
+static bool can_be_local_fp(int depth, int regno, struct arg_track *at)
+{
+	return regno == BPF_REG_FP || at->frame == depth ||
+	       (at->frame == ARG_IMPRECISE && (at->mask & BIT(depth)));
+}
+
 /*
  * Pure dataflow transfer function for arg_track state.
  * Updates at_out[] based on how the instruction modifies registers.
@@ -1111,8 +1117,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			at_out[r] = none;
 	} else if (class == BPF_LDX) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool src_is_local_fp = insn->src_reg == BPF_REG_FP || src->frame == depth ||
-				       (src->frame == ARG_IMPRECISE && (src->mask & BIT(depth)));
+		bool src_is_local_fp = can_be_local_fp(depth, insn->src_reg, src);
 
 		/*
 		 * Reload from callee stack: if src is current-frame FP-derived
@@ -1147,7 +1152,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		bool dst_is_local_fp;
 
 		/* Track spills to current-frame FP-derived callee stack */
-		dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 		if (dst_is_local_fp && BPF_MODE(insn->code) == BPF_MEM)
 			spill_to_stack(insn, at_out, insn->dst_reg,
 				       at_stack_out, src, sz);

-- 
2.53.0
