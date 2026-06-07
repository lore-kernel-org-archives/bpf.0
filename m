Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8E2D949B
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852219; cv=none; b=WpMn/zbVbs52g3fj7CZ6fhzJsPbsoGbIXVR4Dj1Wr0dNlNz1Fp81agkTdxXpQOQHozYpeB2/UvkFPuNRsabkzQuO0OF1HhNrBlIQZ5he8+QzFDuxsPsrK8zW0qPxPcLHeF89wDhOeMt9N9gHgk9uSp09D5szKatWvr3QdG9EvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852219; c=relaxed/simple;
	bh=Wj6INcB2ZWn71vsSX+uGeQfK2gKV41AKUbGx7CRisFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie1vclPGLNSocXIJRjzi7j2HqtEo70mJ6Q+6MvYyhINqskOvgrOGZfVXTgHj3XEsonWlF2OotQxMPdvgy8dDDBfnYhRakvRSSaL1xPDQkuv8TQxAwZ145jbxh1uaT0IbkKtg9Jah9GxcnZrn9nCYX1nTvF2xwzkyR31W8lSMCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjmLcIhQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjmLcIhQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso24011505ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852217; x=1781457017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPsuDEC4emnE4igPvpmuWKON1k829WThn64znvg3mx8=;
        b=hjmLcIhQEYPmillRFf3WucOCrckndMbn9ijwD4YnlaMuuBWzHgV1i0kDpjLNX55YOm
         UXPdABmNb6vunD9ZOGmX4xZwaX4oU8hGBJSz0Pi4xSct5kEEdLrQBC8qqi+tOQ9sFAbA
         yu/DIh/FJDtat43b7Wz9zAvLg075cuD2Evwiht84mTGxO9oWfkMOPP4mQTU2oh/5imcg
         FRIpKIbubsEXdhcrUYQHf0FbmCqB+1XwyRm9N41dE3jQcz66dVLkKejc0tbHoXZUmzDG
         6lyiZDwgBMiZaE348OsoeZ+ktaPvntrRPnR6s1ZPnmotMQhmR41bLcA+zAcGZbxhtlZp
         oB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852217; x=1781457017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPsuDEC4emnE4igPvpmuWKON1k829WThn64znvg3mx8=;
        b=Ln6dPEYOiRUV9JtPFfhe46ASKy3/d9rxOXtOdze0bmsPgPPZOx/+iXELTZW7eNAMmC
         WLowYjMMGTDYB2usljgb6t2ED0F/sHDyc5XxT6u+3eCcKgZ3PLYF8L+5MV5bK4GcS00o
         z3h6T+jzz1b792pjottggL8rzmBt8x3Flv7yeNurI+Vqjv8GE4bagFM58DcoxsuO9Fk/
         XX6mLjcEzXW2zJlZIvYUmN5c5wXp3W9XewXh6JaEX10dLnyXl9tuRuWw5xD6jOA9ElmR
         F7CNLAjpkx/cqBvISheZn+4ToTwD+hGW54Ego8F0C7P4WabNd4gYAKxapizv/g5v63fi
         gsIA==
X-Gm-Message-State: AOJu0Yyz4dlAnqgsqpXag9gSCFNr2YqsPwAu7SonYxOsWthimedfQztV
	Z7KMp2BmlF3qGtEQJqXC1Qwj/R9CJFhPgiALKcnL0ajMs+Pekl6e+u77LEVuGHnUH7w=
X-Gm-Gg: Acq92OGZsIhn0apdNuD7WJDoKs4sNItd/iIHyMi/AOTBysavwF1J/epE7dXOIClaJQL
	bV8j0afkYVSLXQ+RzBym1VkwAPVsZIoHBN6rAp5zpvyFL6JkkKx7OdEk9LZcRZXVb2MTMqy4Lkb
	5SsM6cAVw0K+MhwWyh/r+eAurf47ep60aEy9dJZoyPViw6eBeXXyKoKRy+SC39F39LXj4LHxYbV
	+4rIYV33ALvNnfeDhWvDm3VBFxN5ViiSoVPNQKDVZCJtYpRsqFKZ9JEsvLQj8HuUrjwoo/1buPL
	qv496QGi2evXt7uGGWJI3qJENHZbeYgdwVsG/7m655+ODVCinV/SRHSYx6lgjgUF3lMmFrVZNbR
	5K7A3vnIZ/Kg3xUxoErpHhGIHuORzD32y9IGoub/aQTZk88MH3sB4ukIfVd9KwfaeVfhcWKt+Nr
	6e8PAPlvv69KJwQQgMiTthSDdnyOLuPEsNbVlF7KZrNA==
X-Received: by 2002:a17:903:28e:b0:2c2:5446:30e8 with SMTP id d9443c01a7336-2c254463524mr29394155ad.18.1780852217123;
        Sun, 07 Jun 2026 10:10:17 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:16 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 1/3] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
Date: Mon,  8 Jun 2026 01:09:56 +0800
Message-ID: <20260607170959.823755-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 9e314f5d8682e1fe6ac214fb34580a238b6fd3c4 ]

When performing 32-bit conditional operation operating on lower 32 bits
of a full 64-bit register, register full value isn't changed. We just
potentially gain new knowledge about that register's lower 32 bits.

Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
reg_set_min_max() performs as a last step, can lose information in some
cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
That's bad and unnecessary. Especially __reg_assign_32_into_64() looks
out of place here, because we are not performing zero-extending
subregister assignment during conditional jump.

Replace __reg_combine_* with reg_bounds_sync(), which derives u64/s64
bounds from u32/s32 and vice versa.

For coerce_reg_to_size(), reset subreg bounds for 1- and 2-byte loads and
then use reg_bounds_sync() to recover as much information as possible.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231102033759.2541186-10-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: backport to 6.6.y verifier.c layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 60 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d90236d0..5f94bff12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2448,51 +2448,6 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 	}
 }
 
-static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
-{
-	/* special case when 64-bit register has upper 32-bit register
-	 * zeroed. Typically happens after zext or <<32, >>32 sequence
-	 * allowing us to use 32-bit bounds directly,
-	 */
-	if (tnum_equals_const(tnum_clear_subreg(reg->var_off), 0)) {
-		__reg_assign_32_into_64(reg);
-	} else {
-		/* Otherwise the best we can do is push lower 32bit known and
-		 * unknown bits into register (var_off set from jmp logic)
-		 * then learn as much as possible from the 64-bit tnum
-		 * known and unknown bits. The previous smin/smax bounds are
-		 * invalid here because of jmp32 compare so mark them unknown
-		 * so they do not impact tnum bounds calculation.
-		 */
-		__mark_reg64_unbounded(reg);
-	}
-	reg_bounds_sync(reg);
-}
-
-static bool __reg64_bound_s32(s64 a)
-{
-	return a >= S32_MIN && a <= S32_MAX;
-}
-
-static bool __reg64_bound_u32(u64 a)
-{
-	return a >= U32_MIN && a <= U32_MAX;
-}
-
-static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
-{
-	__mark_reg32_unbounded(reg);
-	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
-		reg->s32_min_value = (s32)reg->smin_value;
-		reg->s32_max_value = (s32)reg->smax_value;
-	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
-		reg->u32_min_value = (u32)reg->umin_value;
-		reg->u32_max_value = (u32)reg->umax_value;
-	}
-	reg_bounds_sync(reg);
-}
-
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
@@ -6164,9 +6119,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size >= 4)
-		return;
-	__reg_combine_64_into_32(reg);
+	if (size < 4) {
+		__mark_reg32_unbounded(reg);
+		reg_bounds_sync(reg);
+	}
 }
 
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
@@ -14329,13 +14285,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 					     tnum_subreg(false_32off));
 		true_reg->var_off = tnum_or(tnum_clear_subreg(true_64off),
 					    tnum_subreg(true_32off));
-		__reg_combine_32_into_64(false_reg);
-		__reg_combine_32_into_64(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	} else {
 		false_reg->var_off = false_64off;
 		true_reg->var_off = true_64off;
-		__reg_combine_64_into_32(false_reg);
-		__reg_combine_64_into_32(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	}
 }
 
-- 
2.43.0
