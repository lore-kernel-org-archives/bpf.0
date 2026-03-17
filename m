Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1093A7F4E
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790724; cv=none; b=YYIVhRVt/HRotKqRee/4XJfoZTp0FZRb91b9qmt6i3jvcMeECgwGmy2jVo3IUBJxuQqI7c6bV57UktjjGftZQDyiO14VmBwtr5E3j2Ps1C+sK4v1O6WbofWZI8DV7ke7ux5tzUJR7uj3548//gcTZGFVFgo9n0F3Vj0Mp58Khc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790724; c=relaxed/simple;
	bh=w8Tq6Bc94AEMzOJYfUQvY+6Pun3Kffb3whTQ47bh5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzPwa1QQDSLvjhQzHlr6sblLjOAsAjgHkRDTA5ABy0q4bZls++lIrLNAQ+LpQ5hF6VzkxM0KDEC5zph1Zv2+Dg0g+uh959Jm/T41n85alb2YmoZx73JhykXqG0F7POldagbxI2Eb7nujtPODVGFKP6tmTFla25nvW8L/Lw9hjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myyGBfNi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myyGBfNi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b49819938so996840f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773790721; x=1774395521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLDvbIYEy8LBmAkZqY7L30i1fR9uuX/8ehy3u8kgra8=;
        b=myyGBfNi5VzhCn8QjCVron1UdnEmaNnSOZtUqQTtJ6RlBMSiYudaKLHQKFEBuYRSge
         Dt7fIGcP+YzrYL8w3FpPrLAq3bsY32uQCb/ePnG7JouAlMtlvLzqwqVsZm5hr4movWJ+
         uwTE814s7nejMSurukRwsrwTYS+z32j37cBuc+r2velB/WkFKyTW/1w/CCTENeKST1dj
         7wC6EnA9QRUGwuhEtsgs73dOD74LOhrb2YKRioa3guI9tVkMEMd/Nlw7rrqD+tNej9Ja
         NmpgpAGepLz8fQaoPFxGaUDY4vewOwYZZk/uMOBoR88lSOKIZmMv+YcEsKQ055H1jNTo
         z0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790721; x=1774395521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLDvbIYEy8LBmAkZqY7L30i1fR9uuX/8ehy3u8kgra8=;
        b=X/mD4GBuYrP8M/k7hhOfziAfMymvrAfxPo3EDHgW06nArrrZs5RZ8qJaGsC4X/dfGi
         O/8308BmKoOthSDOI2ORUXUX7/8UYYJlsTxiohKGWl/4z7OiHoIGrIAZeKq98abAOEeY
         NUiIjTfXNDhwUORTpNC31b5SjkJ06G+6y7aTvPvknL7xPJAfiiWhOJUQy4fiLZnC5rkj
         2DMQj5IGdQJOd0hSXtjEYisdm6EFfO4k5ib4Q4OMJ7YjYhxicKBb9dgNElR4suz9nOu3
         kcMsAjp+liHQ/eDcWUyNUAVhS7la2DaGr9e+2gbIPGA7xGFpVEjfFIzLCklZ0C5ThWIp
         Ct2w==
X-Gm-Message-State: AOJu0YzHLUaeUoMl8FTqw9OZ2i3kE/SnBGQmE0MOPAoCvt2Qw7HWsnhf
	4N1Ld1lXt+EXJ6NdTWeR6j0RDKkHfXE09n+mcA2KMXl55oqWaOePu3ryuO7E
X-Gm-Gg: ATEYQzxiIMw6OdiT0oicni8+POmTtGlStZFhvKFxDrrzHYuXPoohg7KC2mtg0nD77DB
	nDuj+5jfA4imxGRDIgp3WLbAxMfVs6tHAAhvEt/v9zgmOnt2l+NEL3nGlanmf+FtloZkCWKDMKQ
	Tuyf88SR5AZKvPVT+9LWTnCqGnBlp4PibgkQdAwZlVggFvWmcqWPoju7H8A4DyC6WHQQNb2Sfx8
	0iBo9X3QyVlOQKauwhdSXqygWEmj2L1EYhoq/X+IYeIAGGF2ha6xoNx9T6FwQJfIgveWiWFiNRg
	7sLhAIYQQIPM2nB2gBYaw/OUwLlByDhWhSZE4TcG++h3q1+ZpMIvqB/lLEHDwCXkMpZmFcNL8Ry
	eKUbYycK6EaVCz34iMp22yNqQeHjIaGufms/WDpwkqoQdsmYaKTAas+VdJ1iRTJhXAbdRCBDj8t
	muSiLLrqKI8+3Y0g==
X-Received: by 2002:a05:600c:4e49:b0:485:4136:99a8 with SMTP id 5b1f17b1804b1-486f4441072mr19598745e9.22.1773790720354;
        Tue, 17 Mar 2026 16:38:40 -0700 (PDT)
Received: from jacks ([197.38.212.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm174784555e9.1.2026.03.17.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:38:39 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 19:38:24 -0400
Message-ID: <20260317233824.1750602-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Zein <zeroxjacks@gmail.com>

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The comment above these checks incorrectly claims this boundary
condition is impossible. However, is_reg_const() uses tnum_is_const()
which requires mask == 0, so a register can have umin == umax while
tnum is non-const (mask != 0). Remove the misleading comment and add
explicit boundary guards to prevent wrap-around in all
{u,s}{min,max}{32,64} variants.

Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for regs")
Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17046,31 +17046,30 @@
 		 */
 		val = reg_const_value(reg2, is_jmp32);
 		if (is_jmp32) {
-			/* u32_min_value is not equal to 0xffffffff at this point,
-			 * because otherwise u32_max_value is 0xffffffff as well,
-			 * in such a case both reg1 and reg2 would be constants,
-			 * jump would be predicted and reg_set_min_max() won't
-			 * be called.
-			 *
-			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
-			 * below.
-			 */
-			if (reg1->u32_min_value == (u32)val)
+			if (reg1->u32_min_value == (u32)val &&
+			    reg1->u32_min_value != U32_MAX)
 				reg1->u32_min_value++;
-			if (reg1->u32_max_value == (u32)val)
+			if (reg1->u32_max_value == (u32)val &&
+			    reg1->u32_max_value != 0)
 				reg1->u32_max_value--;
-			if (reg1->s32_min_value == (s32)val)
+			if (reg1->s32_min_value == (s32)val &&
+			    reg1->s32_min_value != S32_MAX)
 				reg1->s32_min_value++;
-			if (reg1->s32_max_value == (s32)val)
+			if (reg1->s32_max_value == (s32)val &&
+			    reg1->s32_max_value != S32_MIN)
 				reg1->s32_max_value--;
 		} else {
-			if (reg1->umin_value == (u64)val)
+			if (reg1->umin_value == (u64)val &&
+			    reg1->umin_value != U64_MAX)
 				reg1->umin_value++;
-			if (reg1->umax_value == (u64)val)
+			if (reg1->umax_value == (u64)val &&
+			    reg1->umax_value != 0)
 				reg1->umax_value--;
-			if (reg1->smin_value == (s64)val)
+			if (reg1->smin_value == (s64)val &&
+			    reg1->smin_value != S64_MAX)
 				reg1->smin_value++;
-			if (reg1->smax_value == (s64)val)
+			if (reg1->smax_value == (s64)val &&
+			    reg1->smax_value != S64_MIN)
 				reg1->smax_value--;
 		}
 		break;
