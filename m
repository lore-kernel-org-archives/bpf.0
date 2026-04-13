Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EC3E4C6E
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110220; cv=none; b=cs0sdGA9+3Bhh8BXwPJh38mFPxxuptfY74DyN03hlB16msJm1VIvDo9GSZnsd5ULY3d5goJbioUv/GOSLmKkb3Y8jq/Cq2OF+YZLEY4VpNlD8UU20TMZORgvB+kIH/rjGuGK/Gt9p3P+USG47LFpfeFDNlut00L8wBr2LZWf7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110220; c=relaxed/simple;
	bh=5OOW5Hv1uAF+wSubAKsIG33WXOGafvJcPR6+4k3Ci7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exfX+jgHtLYmglFRNKMSj+uZrLQv1CDxgEUdKz1teCZUuU9oIaAQy1+InaLHqkbxAc0YCf7eCPOJhEgi+tKywY21Yf8ZrVJTr0WqaIKX2zp1UTc+4ocHIj84qGV/zlohNdA3nKGKOm9bxNG0z8sE/tJPsNIWHaSS1A5E2qLJ4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz+1yfMb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz+1yfMb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so400483a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110219; x=1776715019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jB9OPnIhPg9GBCR5K6QkLNPcOIraFHkVwqWp9POQDE=;
        b=kz+1yfMbGW5iZdZg9ArqN6kPLDDhVwPkuN+tIVjSGUPp7TC/FA+6Oct1VxqhPaorY8
         bpLNMlCCNPZy2gdoZMEn390rOjFcrGEPJz5MEYSbbCacP2iaXzCwWyLQCGMppNkNwvBU
         Ju0VN4+PR1fkVb9g+ubtaC8Zv05+sms74682YvOqr4QMtUJrinwVopmYznCqB+7MEZ/j
         lc7NRZoxasuG9JAiV/5tShYa9z1zmLmRdf38scwsGe3safpz3knK1Y/uos/O+gQ3HrNT
         vio1hDuP6I+yZSJuX6JzqTvklki0Kzlcjpo64FdjpYgnvkHqfDDlQIs7d1GobmvmA1P0
         0mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110219; x=1776715019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jB9OPnIhPg9GBCR5K6QkLNPcOIraFHkVwqWp9POQDE=;
        b=GWT5SW55U3s0cHEIxT3+7e0y4PNZ9L8CTmyq+/rXD/Cbgc3vycZx2rnSlhlwVkjH5d
         SD0vt4TWffH/+gd2QBdDAfnuQlYZOP5VVmGWZWZKeCBdkjGPhHOKH1rfVzSvCAQIzWte
         pPSYI7K+qXR5xAGevJcYFlseI0J5fjYQ0byYMD19rA0timuB2GJM0tL1jFcKuyjsWP5n
         v8LsqPTTTzDsCcO9JXYPujoDKZNyUJZtJ3sCOAN7+PhO7Hn33HaF8cWUoP660FnFRems
         9VAkbATHjzONS2j+LN0SamIHVM3Q6mm0and7Nr9FjIUNI7aH4P8ASABHPrpt3oNPJ9hk
         TRoQ==
X-Gm-Message-State: AOJu0Yzq8GAVGlUw9oFpMmbGjI2YfCRL/+6gpVDzRe3aQWTY/lxqbeIi
	LqIzVIjDDQHi6617O6CTjNWO2ja5iglHhm1yb2a+8FJW5akQwHCmupKnR0p2ig==
X-Gm-Gg: AeBDiesc+1+LiAqSLWKVhqpipDoXHH385cc2ayB2e28Hm6u/xOvKqlrnPHZbC/hPsZP
	yQJBeHgkvi+NeW1nEbbloTqNkx4/hkEz0RsmbfvleCr0B7R9GKlsZDyjWAFyOnRFkwYDPej5A7q
	lrfugcrKKvFnnaTg/9f37bVXOg1riLD8fPUiHpfCsI45DKy/L1aE50I27HEcS3eFUwnbTdb4TXy
	o+aRZg76VXeVmpdoeMeQgCkiJL7xhHnmqtAyvOxhw7r74coEI1quQJhiBryLP54TeVc0X92zdFU
	BGrkvveEm4sOn/pRS8WkCQPmssMnYi62eEMEATtLNhXgmNLauIXmZLGsDQ2D5VBAjivAgurGDp5
	XXdcKl43BgFEFHIQzu0uagtRFJ/Rzg6kxeJBl31d5nm5hOpFx0cnqZ3I7tg/9/4o7r6Kng8tIwN
	uTTc4ey+AaC1zmOkJzK+HDExXdY3hZ2TPaE2BYdtx38CZbnCqv+8aQWdiCNI7Klu0r+jE=
X-Received: by 2002:a17:90b:4d10:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-35e42846585mr14379811a91.18.1776110218552;
        Mon, 13 Apr 2026 12:56:58 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm16452599a91.9.2026.04.13.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:56:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/3] bpf: fix arg tracking for BPF_ST through imprecise/multi-offset ptrs
Date: Mon, 13 Apr 2026 12:56:40 -0700
Message-ID: <20260413-stacklive-fixes-v1-2-9f48a9999d6e@gmail.com>
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

BPF_ST through multi-offset or imprecise dst should join at_stack with
none instead of overwriting the slots. For example, consider the
following situation:

   // r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}
   *(u64 *)(r1 + 0) = 0

Here the analysis should produce an equivalent of

  at_stack[*r1] = join(old, none).

Move the definition clear_overlapping_stack_slots() in order to have
__arg_track_join() visible.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 56 +++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 8069ea955023..d5e0bd18ee06 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -622,28 +622,6 @@ static bool arg_is_fp(const struct arg_track *at)
 	return at->frame >= 0 || at->frame == ARG_IMPRECISE;
 }
 
-/*
- * Clear all tracked callee stack slots overlapping the byte range
- * [off, off+sz-1] where off is a negative FP-relative offset.
- */
-static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz)
-{
-	struct arg_track none = { .frame = ARG_NONE };
-
-	if (off == OFF_IMPRECISE) {
-		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
-			at_stack[i] = none;
-		return;
-	}
-	for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
-		int slot_start = -((i + 1) * 8);
-		int slot_end = slot_start + 8;
-
-		if (slot_start < off + (int)sz && slot_end > off)
-			at_stack[i] = none;
-	}
-}
-
 static void verbose_arg_track(struct bpf_verifier_env *env, struct arg_track *at)
 {
 	int i;
@@ -980,6 +958,32 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
 	}
 }
 
+/*
+ * Clear all tracked callee stack slots overlapping the byte range
+ * [off, off+sz-1] where off is a negative FP-relative offset.
+ */
+static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz, int cnt)
+{
+	struct arg_track none = { .frame = ARG_NONE };
+
+	if (off == OFF_IMPRECISE) {
+		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
+			at_stack[i] = __arg_track_join(at_stack[i], none);
+		return;
+	}
+	for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
+		int slot_start = -((i + 1) * 8);
+		int slot_end = slot_start + 8;
+
+		if (slot_start < off + (int)sz && slot_end > off) {
+			if (cnt == 1)
+				at_stack[i] = none;
+			else
+				at_stack[i] = __arg_track_join(at_stack[i], none);
+		}
+	}
+}
+
 /*
  * Clear stack slots overlapping all possible FP offsets in @reg.
  */
@@ -990,18 +994,18 @@ static void clear_stack_for_all_offs(struct bpf_insn *insn,
 	int cnt, i;
 
 	if (reg == BPF_REG_FP) {
-		clear_overlapping_stack_slots(at_stack_out, insn->off, sz);
+		clear_overlapping_stack_slots(at_stack_out, insn->off, sz, 1);
 		return;
 	}
 	cnt = at_out[reg].off_cnt;
 	if (cnt == 0) {
-		clear_overlapping_stack_slots(at_stack_out, OFF_IMPRECISE, sz);
+		clear_overlapping_stack_slots(at_stack_out, OFF_IMPRECISE, sz, cnt);
 		return;
 	}
 	for (i = 0; i < cnt; i++) {
 		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
 
-		clear_overlapping_stack_slots(at_stack_out, fp_off, sz);
+		clear_overlapping_stack_slots(at_stack_out, fp_off, sz, cnt);
 	}
 }
 
@@ -1171,7 +1175,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		bool dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 
 		/* BPF_ST to FP-derived dst: clear overlapping stack slots */
 		if (dst_is_local_fp)

-- 
2.53.0
