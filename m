Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC7392823
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783833; cv=none; b=SvzwLI5S1IA8SA4oICDVaAfuac4hxxMW7OVnPxeQSmwmFKBTsNGJ5XpTMwkpqrCGVYYPmf83n+0acjTLJgx9cdTddRuQA6vj6CV4Q+Scv8hboe81CJOQzURb2d2ItVSIZNSOVedaoAjdOMWyS2L9D/NG14qU887/KRezpD6wVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783833; c=relaxed/simple;
	bh=yisUaVMlLp61lh5yAzr/Bu85mTbkAy2RyPo2m46rB3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4nsyoHmLfNHclhy2BwR5NXE1ylOT+T0SjZeMJpufmVHxTBjyzdiu7vfc2elNFYC5EeThw3rFHFfd+P2FyarvI61odG5mL+NGDR4RfNSsPRiGaaV4QoNq611g+IoODCzqW//VKipQ6DWr3yTVvdjRAZfDdY6CwoI8p6WV+oeRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ4hs2wm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ4hs2wm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b9675d36so9267205e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773783830; x=1774388630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3J6QL/sCxXmvI2aX8hIXwKbPG6y0wN/eNHB6NdqHKuk=;
        b=GQ4hs2wmFyxvXHUV37pu8jxWbLRXgthBbdcb4iq2a0sm8BsWJX6WIEuK60AoDn30f2
         r1pwNt4VH/4CT+mNlUlE4DI4+Lr/SEQBaZeKz8UjJDmbDhGiVdBr1NUVJvLeiCZwvYml
         xtNKF/lxpNpSiFSbUGY/0kuxa3FUrkUy6tLf2n9n/I32OCG/laCzl3arRp1XYoGdHvkT
         fAsdg58sv3OykS5Wz+AiuiM3TKsDfKW4JoKszKHCTa0Lc6oGEQyzMjbn4Bti/8+QgqW8
         kRhxk02chPCDCeA3C9AhQalJXxcTl9P0ZCpJj5moioH0QdCqHU3jRFf7tZg7h9I9FwUS
         Mjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783830; x=1774388630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J6QL/sCxXmvI2aX8hIXwKbPG6y0wN/eNHB6NdqHKuk=;
        b=s52cGi9j3xGIOnY33tjn/efN8EnaTNAX70Cbvmyf+UQbb49TncH3mCN5cQ7NYGDIud
         tpXXQPbPmKTfE86pV0b+YVgpeuyHQuB+cVZitzA3MHtjQkmB/5fNGDQkbEAksl8yNyNI
         3vRr13fs0h/QlBaYamAWOdg2IP3ErXWaazeqrsEXFAiRNXg9y3Ras0eRAiy7fx0lUO9t
         q2GalesC8XiPLnp9IMa2Rnkt9kiNU+Tjcv5gNqqrohE6Ev7NPC4b4ldnmqT2/yzNJBAa
         9QWt5aQE9oiJ+m1xDF37HrCHvcHJNxCuHKs4jOkOpNoRWEeGeaT0+2gvLSc+V4ImmKmj
         PVFQ==
X-Gm-Message-State: AOJu0Yy8WeCez1xY+F+BaTk7WywnVRZTLLq7XWZXetKag7SiTUr6XYlW
	ZNyXG6FfWhKxWXfYaROA3IIBfeYTHsXpURFRUdN5kldd7QaduEqPyXp7vwHHjl8=
X-Gm-Gg: ATEYQzwqNI3w+gB6iiWv4NQiZEu5dEAYJzmsfqADIyVRFfWMXsI9IJyec/druXGli6x
	wkKYUosviFRHNENNqgrY+1+bxphQFvK19/sUIdKDlChoyK+tzAZQPe99fTtMh5fEFip6uWG/G8X
	6UVmXNlNYQPRr9Ot4Emy0fF7b9BShsLNmFKqalx677QSlSo/rNt04ujMNu93Z/JrCwPuLxJiCrN
	APXGh9VZ+pDcouLf6jYS0TcoKgcVEqptY3j/Krzp9Q0oBHgrhPp05ccNZ79IP+tlDQmaPCbGFMB
	DxxlDaJi9Vkj7XqM2xMiJsv4KkZy1ippJsqTtJUetuJEyedwSdZdC4ZcFbke5x1hODfk3WrtzEF
	p9M1uqmFdLEl+soNOjsxRnolavLc0wm6y2hp2QOqvzJw36JLXiUJwo0relmZwHHY5189f8PVUNq
	sMqaRo9Zq5MQV3Wg==
X-Received: by 2002:a05:600c:46c5:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-486f441fbfcmr19081925e9.1.1773783829766;
        Tue, 17 Mar 2026 14:43:49 -0700 (PDT)
Received: from jacks ([197.38.195.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4d10a20sm4057605e9.0.2026.03.17.14.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:43:49 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	Ibrahim Zein <ZeroXJacks@gmail.com>
Subject: [PATCH bpf-next v2] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 17:43:41 -0400
Message-ID: <20260317214342.1729449-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The same issue exists for all {u,s}{min,max}{32,64} variants.
Add explicit boundary guards to prevent wrap-around in all cases.

Reported-by: Ibrahim Zein <ZeroXJacks@gmail.com>
Signed-off-by: Ibrahim Zein <ZeroXJacks@gmail.com>
---
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17055,22 +17055,30 @@
 			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
 			 * below.
 			 */
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
