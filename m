Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983810;
	b=jl6vkurA6II5QP+th20guOMiw41k8EGh0bNKEkZ0ymk9A5ITaLsAS8jOMer/yFKjeIJc
	 R1QwDs2AIuFGTbESUxinFWPNnJcD5YJ5ue1vgoY6ZuKUeOZFGXYHYuLfjXMvpb5GlJoB8
	 gLzDfgJfIl96A09hLtg45Go70IagQKRyQ7at6fSdkQyiiiWo25kjpaS1jjbmGrZLu+3A1
	 8CmIAx6ZG1Ntcm73mPcMtN7o2xZi35Uu5JvhcNtsyRI0dX9BBJWGH9vD1xpYTS3BbgJSI
	 J832t32Xq5+qMTdsjHeGb5BaMpIYlcH1Nc5o85W88x7mhm0/axH0CI+P7FkkVrwK02g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rFpvYRQasfqbLDA0iW83rpEWd9idB3lVdAeJEclQ8zc=;
	b=jbdkGvpc0YPOWTGOWbjclQW1KtYi3yP2k3uUY3POcE1SgjUqiDoeW3u4dTXIkIQ82/8b
	 V4O6lR4mYFC3qSivF+1YICKIMNbdG55x5qG3YM0AeNgxshp6ydOYmPGTaibxIlFzAiok+
	 xp1KjnGqWJU4RMTM6hUBuCPAMJv2/TaEK0N94/aS4UKoDWWRKbq+WU/8v1uiD1oC04wRS
	 exvt9LNCsulQaWJlPukDtzutGxhSVNufBO+C63mnvlm1Rp9CLvJNK6m9kgy62s8PV1oNz
	 HkuaCeo2mw6g2YZtXLGAJLMoVJlq/uhIQzwKdVFzfVZoKkYiYVJPD/vqQo350SxPwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMCstVom;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CABA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMCstVom
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a01cac8733so1829008b3a.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983809; x=1793588609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFpvYRQasfqbLDA0iW83rpEWd9idB3lVdAeJEclQ8zc=;
        b=NMCstVomv32F6N62BloE6B56TRTCMMDRIFHC0Qm5HvtGKk4nzSInH4WHuicWY9miBD
         KqW2v7tiM4hGkvr2eK83INNKEBXufYR+YwpjUxWb943NWHC2FrQSgdF/UfB/JuocTu+C
         Ut7Agj4ziFYChnNNdySu7WzxOkjimp7wl/goRAOdr2rpnNqapFilGTT+aRLjgTk0sv5I
         cKG+bI4S6oGbEFNDQMqreLy7rCHMyJHSGO1hqckAAEIu8cMymk+roF53HPY8B7dRflYA
         OGLApTdyuFxGtmj9uZ968jCrLNjsFPKn6SNcO9hX9KZmz3mz2MA9oQZ7M9a9QRTUEFRh
         88EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983809; x=1793588609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFpvYRQasfqbLDA0iW83rpEWd9idB3lVdAeJEclQ8zc=;
        b=t1IEdoJxP4dsV6i0yTmNvKOI2o8AjVRKkY72o6ghczKIh95bMZZW2SjtFMIspVMx7g
         Va4pAj100582c6tqmUkbV7HA98O7yb/aDrayfkywA555XC+1yASJsVBtJ+DeAet/Ef7Z
         Vm7HhNJHy9gtzroYw7oSIi8WQyd1vvVrCK8e1roEPFAzQHujmzzIT/+474p34JefuOLQ
         sBSvre0mjq1WwptBz45bDhK3xFNAJaf4uJcuscXzNhv8T6dIyI9NIi41SVJXwPWr8Xxl
         m8LhykteFrn2DgV5NxZ+tB0jPsW886v9OdCfbKa/BUpWgaEZuRoIVxkfskr6TV2mcSpj
         umVw==
X-Gm-Message-State: AFq9FYITpETb9FfBD480A+QFi3xtELuNoUDO/8eH0ZHwTEL3Zg5DNDyM
	4+k4P+wyRthRGdF2kX58Y85S/w6tHy27fzxQVuPh73zhF3cMEHbTQ8T3TwiLDQ==
X-Gm-Gg: AYBFou2ElPanJiCn+Q1H1cczTZlgDjy0Vnp/XOnDw0d3kCcnOa5ccYV79oECebnpRmi
	b2If+Il3Vi/E2O3qoisQ7SiYZlyxJwt81c/CKUDcnDGcmotit3tKCStXzJjgq1etgG6xnIgjemM
	XlE7Uxv3Whw2zprYvS3TeajOVz5fXf4zKs6yrBP1CLvzMPvORbUFAI9WQvTKL8CDQeFKlqnk9P2
	0F197tltIkS44heMMrybrsHNt/F78cwT5XN4Qcz2KEiL9BKbHUPFI8vctqlVUwM41sd81wGwp9o
	lQY3d+QjIi7NViIitKnLjADOwjbrAlYJZ5k//DFXfI8XPwGKGlE+vZG8xy7H54HHPxoeX0g4Lsu
	ACCxTk0PHvVv4IWy8dl37VojAl0BKnEs+2M4xiJ3yRDMbN2uuaCSl1HU3SxI/9Hnn+x6eiit21M
	jmEjUE2LCFmscEl3SFpsaVRMTlH10cRWRWer4zX0/gS8UgqNxy8fczqrzOnVJpMlVNbPYB62HlD
	+8VYte0Evo3nwedwAakjj37VfZwhsw1JRozAzrf/owUq2e7PGn3riHbRuuOQ/CBjzStrKsOsjPz
	1PbdIjPbFDrHihSn/V+g7yY5W4O4yxy6F87GE2tUkKhrE3FYHOqJD2L6ZrI6tW17A4RRUP7Gfe3
	yL8BBxJtZ9elI04v584Bmogfu+NlXzLfOcUek7NQr6sZSdQ==
X-Received: by 2002:a05:6a00:1382:b0:870:c2db:da2c with SMTP id d2e1a72fcca58-8a366f6724bmr4226678b3a.25.1792983809028;
        Sun, 25 Oct 2026 20:03:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a37695ab9dsm675929b3a.26.2026.10.25.20.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 38/81] bpf: Simplify (zext32 (zext32 x)) in scalar evolution
Date: Mon, 26 Oct 2026 02:58:59 +0000
Message-ID: <20261026025943.404450-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

clang compiles 'for (i = zero; i < 17 && can_loop; i++)' in
test_buddy_alignment() of libarena into

  w1 = w6
  w6 += 1
  if w1 < 16 goto ...

Scalar evolution describes the value of a register as an expression.
(linear r6 1) is a counter that starts at r6 and grows by 1 in each
iteration. A 32-bit insn clears the upper half of its result, and zext32
shows that in the expression.

  the 32-bit counter w6       (zext32 (linear r6 1))
  its 32-bit copy w1          (zext32 (zext32 (linear r6 1)))

The latch (the jump back to the loop head) tests the copy. Scalar evolution
recognizes a counter inside one zext32 only. Thus it cannot calculate how
many times the loop runs:

  loop header at 1, non-linear latch at 3

The outer zext32 does not change the value. Add the rule:

  (zext32 (zext32 x)) -> (zext32 x)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5c2150928ff3..d0ba709694db 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1507,6 +1507,10 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	if (is_zext32(scev, id, &l) && is_imm(scev, l, &imm1))
 		return imm_expr(scev, (u64)(u32)imm1);
 
+	/* (zext32 (zext32 x)) -> (zext32 x) */
+	if (is_zext32(scev, id, &l) && is_zext32(scev, l, &a))
+		return l;
+
 	/*
 	 * (zext32 (+ (zext32 $a) $b)) -> (zext32 (+ $a $b))
 	 * (zext32 (+ $a (zext32 $b))) -> (zext32 (+ $a $b))
-- 
2.55.0

