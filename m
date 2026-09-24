Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C385D78
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238381; cv=none; b=He/b0DPtDv2XWJ0yAxyvkFjL/SXYIXa00kTT32BUoS8iy5HuGlK4zycuh9pZIG7qrRXODu17VQen9noxSEH4L3D8/k4CG//JcZMjkgBtQgqVCum2fZX/CO/MtrqIV3mFMQvybs8anSqf2Y9Y3KaAyxG6ZR9cP0xcJGGqzO0Q8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238381; c=relaxed/simple;
	bh=99rSoC5riNouHcQYWMT4yxgoWA31Yw2VJMXt1k9+Zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag2IAIP5kZQN2lGTzJWQbAewaH2tXik37fp15IzvU2E/h51t8fOrZTg0mToOa9RPaeTLQ+nSaL7JcUc1ImuAdLrVUivZVtTDopjKgK2+joYY8J9s4hsvR4JRyUgFrSbPN4kdiFJoJG8JrQcsnkouGPEY4lJ3YXPOCVxRu9Mskyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3kfaM/Q; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3kfaM/Q"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso5762725e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238378; x=1790843178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfX3gLvZXy31RogjuBhvkhO3/5/bYjD/aCrgO4xnFv4=;
        b=X3kfaM/QoCIFIV7hGIzvXO6WM2aUrJ1NoQyjd81RXzTIFaH57UwzNYr8D4MXcNwIpj
         bhvdRYV4X9CAe6YzhylzoXk2eWZQAM1DHiwX6f58RML0suYujTPcQaA0V8aZ67eiY9pb
         hsv8tqjVKDA013eWvPAu75yDBgV3F1EdK69ppN9xYopfUktJO7hAzyB+rJAyaPTxAdYK
         lu1so3O04oGNPvVnoYcihBo+jbH0QvTpdi8VtS1HsQnOlunqxS4K1/UZVSSEsH/uN21X
         x6OTqfBj3TbVNOvc0Kq8SYSuuspWkvMPGOBV4eU60TknhmVaSWGi9WfYH/gHIJDMtrFG
         r+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238378; x=1790843178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfX3gLvZXy31RogjuBhvkhO3/5/bYjD/aCrgO4xnFv4=;
        b=hJSBZaUTiv8/rWK49cwsh0v65aefMj6uPZGWxPKdigew4nHKIaqBRRGWgtDf5EWC3p
         ue+1uZn2RcByguSFMtrf6lnmFBMNzdmdmWjYhVLxU00h5z/3PgbKeRoc1ZQBm1Suxfls
         y0EoZpJ045Yd+joQSphJQqabgf/yIhvj00RRHLoYo6QnopAGtFYjbjIXCAm3TwQs99g8
         Vkr0mTxA6dDqFcu3BFY9pCBWblkyLNohTo1fpLd1FTrYpg2yyAznm0EMcqmYtk/TfA9T
         y5zd/KYntuLZHsC9gERMyV9xjWwJs/PDdNqmEKx5z9gmW+/cbpMKVdQU/Zw5wT3xgWhS
         xhjg==
X-Gm-Message-State: AFuF++nMOBFPEgsKGXQ92XC0+d8DsrvE/WBqYrETPmd7q0+m5tuxl/n1
	fv0BXCjh+/ArcIw12WA5DnG9btznj7JUZNUYtogPGI+ahmW8Zd7vieipHRMOHhXd
X-Gm-Gg: AYBFou19I4HIuNpcoq3R/A++Bz0aHr8baf2RX5oA1kOaakZTW9xCL1V9mThrywUpryt
	6iddprEuWtXfiMstWqTPTizx0XAleVitLdYs5ZVndJk4mC6GCZmht3z6BdJXtcpM5+A+6ann4Jr
	a5+9ukXXBptBd4PLjQZ8kTQOrvZulvUdOkHpD/G/64cw9tDDvRSCaOseHdgV+dqDWeFpYcysAzu
	GhsAXqQR1vdLYVFBf4XKlmjxnyDhYduJiFkNvFI0GCSc7eZo+atjWxYwOCmj6K3UPODtNxGN0j8
	kbST3WqCehsA9u9D2ludFSM3YxWGNMfIBsyX8scFRs5Lyeao6u5N48hdO/lZkisOm3uFG90CRnb
	DJ0+7hs7ZedbYEXzgYwr/3MgWb+Cx9UdPMPEE64GFRx4LMIryli48osrRIy1d3NpRZe5NB6QLH4
	rjSa31uljYRfgYfNc3lovoLotVcBy3Iwd0jpH/OXURhMNXKA9RFTl9ahnTIdm1Pxz8Ywk9U8OwL
	Z+S/HvL7tquM9snbN2cYSS5jWvvrsolFge8s7bYJCYlDwnzulUuOPjqeOwZnTrpU0muNoyFuDR8
	E1qHp5iNBmNAOY0ZzRZSuy5XRCHKuvJqR/lXFg==
X-Received: by 2002:a05:600c:1d06:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fe7bcc25dmr18081045e9.31.1790238378056;
        Thu, 24 Sep 2026 01:26:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm48271405e9.6.2026.09.24.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/18] bpf: Track scratched stack slots with a bitmap
Date: Thu, 24 Sep 2026 10:25:41 +0200
Message-ID: <20260924082607.2695649-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=memxor@gmail.com; h=from:subject; bh=99rSoC5riNouHcQYWMT4yxgoWA31Yw2VJMXt1k9+Zi4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvaRNB+N3GoWKsM4uX9vau+wN4++F9fLqdfta5Q5+y VwbKGjZUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIksbmL4Z3Xs8i6dDYkqvIee 2EQtzNC74bwl6PLkjedVud91P/NIP8HIML1VgbmzcuV+SdfVoW/jz9dFvrgceFHuKNtdgZBZVTX zWAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The set of stack slots touched since the verifier state was last
printed lives in a u64, so the log could only ever mark the first 64
slots of a frame as scratched. Make it a bitmap sized by
MAX_BPF_STACK_SLOTS and go through the bitmap helpers for setting,
testing, clearing and filling it.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4b69737e1d42..a179551247de 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1090,7 +1090,7 @@ struct bpf_verifier_env {
 	 */
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
-	u64 scratched_stack_slots;
+	DECLARE_BITMAP(scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[1];
@@ -1509,7 +1509,7 @@ static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 
 static inline void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
 {
-	env->scratched_stack_slots |= 1ULL << spi;
+	__set_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -1517,27 +1517,28 @@ static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
 	return (env->scratched_regs >> regno) & 1;
 }
 
-static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u64 regno)
+static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u32 spi)
 {
-	return (env->scratched_stack_slots >> regno) & 1;
+	return test_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool verifier_state_scratched(const struct bpf_verifier_env *env)
 {
-	return env->scratched_regs || env->scratched_stack_slots;
+	return env->scratched_regs ||
+	       !bitmap_empty(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = 0U;
-	env->scratched_stack_slots = 0ULL;
+	bitmap_zero(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 /* Used for printing the entire verifier state. */
 static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = ~0U;
-	env->scratched_stack_slots = ~0ULL;
+	bitmap_fill(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
-- 
2.53.0

