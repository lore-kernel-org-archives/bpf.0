Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38E3998AE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161857; cv=none; b=AZfS/lcCieU9akG++u1t5+jdTV+TERc0rBcvrNuZKr/fOJTX9cU5HMBPx9FoeLRcEEIIt0noiYAlTySZpwqXLL7y3/uYuAXej+AjjjqXmlZTQ2C20OjPWSfAEMh9kDepcfRD8gocgmFG6HP4qJMwBsDJj8MY2wBRw36a8wnEpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161857; c=relaxed/simple;
	bh=HQ98az85ol9ykgd6Ibgq6G67fhmP9KbNYrzWQtRpRM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugUx1/JCoKRBuD3KbHsKDx6l+Luk2aJ6of80T/ffsruu74+dqm/moz90A2tcJuiYmREKXHoXW4Inq0J2ud8pA86ymq07jEIQ16P5JeGaxJ7flbLDKwWTGB9zJF3NNGjtwWwdHdkmm2+nsOUfhIJG8YYjne91Qb3OOzcBbBrmbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=XKCE4nVm; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="XKCE4nVm"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so680809e87.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1790161853; x=1790766653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7qFG7exmvG6u25BqZtpI99huEdrJeNvIdqZ6NzVIJU=;
        b=XKCE4nVmiKICZmNOveLCVJmZc6nlyHmRjN7J4rqsm1VbCmf5NwRLyCsgeodayTI0TO
         0oRHwLzlmcNPFVmqNZYjivW1Ga12WArEE7kSbhnwndlNtrrthY0Fyvh0eKhr7mxxgpB/
         2baQi0cXgg+7gMAIwWDDO/CoysF8B4nKEXMi0Dt1b3DOhLLvUWI2ht/AuyJLlLW5z7Jt
         XKPFYl2+BfcbdYZ0+u8x2qh3ECz0j9jHPHxklEbpHUIb/7ig9Etri8Su49Cq0oZ55Iah
         ylRFcRDp70o3J+VEzxuMPg1WyuKb8iydxmwu7WCJUZR2RwKtGqXIkevXdThNqV4yqvtZ
         Mm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161853; x=1790766653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7qFG7exmvG6u25BqZtpI99huEdrJeNvIdqZ6NzVIJU=;
        b=Kei222CcswwubIN2WbTFN+s7vwA1/mA3f37SG71W6fc0vEZQJmIOTeHNiIec51L1mU
         IXC0ztsEc/EneCARnv94DCkXqC3CviMM9tAcV1/Y8RFNHY9iKdpJPsN28gebNZ9Ua6eM
         tlDwvgrl8tkZ2JTZi5sBCQUj7UtIpVJHV6R0rPHK76MC/YT1UAweTrcSwp0DNkuAV+9m
         vXXCnty253esEv9gOM3pJHpWKZbBdpZPh7VIOMN/7V9lPSJ763QvtJK3MHPlUOANnjNK
         KitqBcqwntqsLIlZ40+9FHyk69i6WJBiy/oe33FN4KLznRE33Ppl/KITMY6SLNqSTxkh
         YQ1g==
X-Forwarded-Encrypted: i=1; AKwUvBxyPLeAWaW+asQl1tIA9psuXVn7N8rKUFORIZcKC0ZQM9IloqLkhKab1cv/4rx8YFZQhiw=@vger.kernel.org
X-Gm-Message-State: AFuF++mwzJW+YBm+MsGh/5X17ZPOTMRyERh5m+SdsXJe1q5WSouV/jr6
	cwk7Q1FxBGZRsQ9QJtybfmy8dKD7DlTWc+EpUHOU1DMAHDR5VlVZMQ53TD9BmstiPP4=
X-Gm-Gg: AYBFou1S/HM7JqQTWWGUun9ZXipA5K/xk6WtGqzumjW+IqGKBgb1br5eLi8HuAVWcph
	2GrZD7h5OR2NJ8wsrqsN+CFfhBTK6G4n5L8VpW+CykK49JpVGqyROXd/4PV+VO4xZCfJ4VAiwhd
	3dOG6/8UuuHDIPvcmWSmUNuBDKzsVK7y5jSwBzTnCi9PrjGC0Cwti8SEbYF5qgNu882NmiTtyoF
	YjaD2EM5oX7O2GoXF1BLUvTS3YBGWidcmMsmbDLijhQSwkv4UMoDnmwvet+cHQ57WkAkfD+IvOF
	1tI4NWJ4kp/OMYvsGO6ebJw5ZL1Y4v656Toz24y7W8ktxHMYpk5aAp0Tk840Juydsn1JHJ7jmVX
	nOHWZp1qDIrGEcaD9/3v9O93J2ZHsbLC1rzPG+vNCbNkwW5M4nYcP1cNznzde8j6zi3r6VdSwB/
	VgTRKtiH8M0ydxec0ayw3jS9tPiuCk6na1yuYIVoyq2FNlzoR8nqWhrgvHCEyOSz2wUTi1EFZoT
	popIbH5u4Xz4w4EkNwnpmRPFeYOpCtyv54WEikDQSQ=
X-Received: by 2002:a05:6512:1389:b0:5b8:c1e3:ec96 with SMTP id 2adb3069b0e04-5b8d89c293dmr844693e87.51.1790161853213;
        Wed, 23 Sep 2026 04:10:53 -0700 (PDT)
Received: from nuc.. (78-69-188-101-no600.tbcn.telia.com. [78.69.188.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8589783sm507873e87.51.2026.09.23.04.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:10:52 -0700 (PDT)
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
To: tsbogend@alpha.franken.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	paulburton@kernel.org,
	main.kalliope@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	philmd@oss.qualcomm.com,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf 1/2] bpf, mips: Fix immediate JMP JEQ/JNE on MIPS32
Date: Wed, 23 Sep 2026 12:51:57 +0200
Message-ID: <20260923105158.3514342-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An addu instruction was emitted instead of addiu, causing the immediate
value 1 to be interpreted as register $at. This made the comparison
result invalid when the immediate operand was negative. Note that $at
is mapped to BPF_REG_AX, which is used for constant blinding.

Fix the instruction to use the immediate form.

Found with test_bpf on MIPS32r1 emulated by QEMU.

Fixes: eb63cfcd2ee8 ("mips, bpf: Add eBPF JIT for 32-bit MIPS")
Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/net/bpf_jit_comp32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5..15a2a153dc87 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1111,7 +1111,7 @@ static void emit_jmp_i64(struct jit_context *ctx,
 			emit(ctx, xor, tmp, lo(dst), tmp);
 		}
 		if (imm < 0) { /* Compare sign extension */
-			emit(ctx, addu, MIPS_R_T9, hi(dst), 1);
+			emit(ctx, addiu, MIPS_R_T9, hi(dst), 1);
 			emit(ctx, or, tmp, tmp, MIPS_R_T9);
 		} else {       /* Compare zero extension */
 			emit(ctx, or, tmp, tmp, hi(dst));
-- 
2.43.0

