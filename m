Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AA439004
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121127; cv=none; b=iMhuQdmhPsSpP7QwglqdSkIfR7h4q+jVl27kpntHzaR0vFZxvMY+n3EVE3xAYxa40feSLekUiPGWZ6QImdh05xqu9gmeDNm8me1rD0RRUCPcGbX0F1qWh4+4pA+XC8cUvL5ih6dOLbk/DdBvcuWDOOX0Z9Rkb/4aCNAE8C3HT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121127; c=relaxed/simple;
	bh=AZJ4hVlXF97b8aJx3NcmagaJoPwP28ljCjne7XMWv4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqhjucdEm2BGVggy5guWsj0zUyO/ncJVDx5dmcmTKTExBJnVRhgymdPdHsMx+fd0wzdDvp3O6lKvAUynBlMXrgdqUp9kIHwEKYFs1a2T9TMVhgyrLLshW0Q0/Jbmp3UR/z7unIZugx61PQH0nyGmoEU+2mK/4uXpY9BQOIIZcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfA+hLab; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfA+hLab"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso627986a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121125; x=1791725925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqFD6K+FyKzM6NjLSpiidT/Pao1ZBH1yZTi9t54LUmU=;
        b=EfA+hLab/iLfmV1Ahb02RDTQy7AmYE2tixXx2gE0mmZeloMo1ihQjP3HoPZ83QEmuP
         Q5rE7qQ+B7U9aGpuG7/tQrS7sjLqOUps1M6ajRT6YyLzWcRk764o/JqwqOgXTKgShzH4
         I3XJbsRNmzDBc1iGpWHbXq6Gf1Eg4GyRk4pPuBXy4aHEH4jVtDjrb3UQ6cyNTqH411Z7
         ENkHevnTTumm/nGXVHF60Ve8eI55p6cXwLZYhUJ64YUZjRFotGhNMGpSB5gEsN28p8wt
         W4LDXEcuL/Hj87Oxb3VoTQ/sK165kn+vrSem2yNdAKQkfOVtf5zY/N3ilE479zIa/yQ9
         y/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121125; x=1791725925;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqFD6K+FyKzM6NjLSpiidT/Pao1ZBH1yZTi9t54LUmU=;
        b=ZaD2lWHy3y523ma4Gb57Q3+WzbQh3qCKK3Cleoaemw8t8KK0Vqqt/d8xrmpWjBD7S+
         v+eeNRZYXiBGo7WviCaXy79cbilYabdp48sLwq7oiuw9XtPBJlUfFZeIsGN8odpxOP0a
         3b3CEFA91m68E9VjTNNoYrNyj9gWvFy+V0W50IxCwUpdBV5VE/z8eKCWg9eQtaspL1fP
         Sm9mj/R/Zyg9/77XWZkNfGX6kX5aXkdO6GzFXUxgSLxERwj1wiy1hEh3Sr8EJiuO4MYn
         9E9edo1QfrzZRAoXZdKuMuq/AoyKjGmMlsP9MVJmE+Ct9cJ09s8FcZ5XmZvl7Cw5Kdxu
         fglQ==
X-Gm-Message-State: AFuF++lv47z2OxqSuC7wVRCVs4t/9voodHLL7AF2CJ18D0VZEYyxcg78
	BC+4xTp8C8a9u9c3xjm3Kteb5R1YxEORuWa4AT69pKIwD7L2fgJ33XqOarh8JQ==
X-Gm-Gg: AYBFou23CyXXIBXjRj0WgfKjl5Az3hSRiQfpmpE1Nw7rrct+hJjJeF+0Rb6xEti7moY
	mJb9wizcvA0xsDbgVbO1YCwFmQSaSZDS8gRObIVt/kNq+X0vGCUGbPstxfdMGFeag/LTP+YdJQh
	8MckW7gIWE2HpnLztOuSonHvgxOGh3x+llNdRZtv1SbdNFPh/XP3b5Bne/wJfZEWCWJed2NxgfZ
	H23+MT8S9ZvvfgxSPDIhP6ZW7A2Am46b+XgKbOcbbp8CvyV+XJLfTucKTycJcOK8qtEVTuQdpG6
	QRtcB/B4XSGL8hH3/V2J59nBprEqIGj4Aq+ejETgEkZv3PMJpxppcB8hF23FYgd7ev91jLA5/26
	LW/iZtJNE8DoZZC/fvkW5wM6jrevb158ISR4zym3oknTmotGsPPgv4HjxCiLKBETpySqv/ZBRcu
	HMssq2ZxP8xyzCwEc01iahT4eX9uvxI7vzNvcOMED/4TdO6ek3QZ64Zb0hJWQz5fswxDdD0M2eF
	TrvloU1fnb8idLipqnVC8p96A==
X-Received: by 2002:a05:6a21:4784:b0:3de:5002:ec6f with SMTP id adf61e73a8af0-3e0d6bb55aamr4763231637.68.1791121125216;
        Sun, 04 Oct 2026 06:38:45 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 08/43] bpf: record write effects for atomic operations in liveness.c
Date: Sun,  4 Oct 2026 06:37:50 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-8-f6254e29fdf2@gmail.com>
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

Atomic read-modify-write instructions are recorded as reads only,
omitting their stack write effects from the may_write masks needed
by SCEV.

Record both read and write accesses for atomic RMW operations. Keep
LOAD_ACQ read-only and STORE_REL write-only. Share the precise/imprecise
stack-access dispatch so both accesses use the same address handling.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index b9b76684906e..ce74e3f16eef 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1634,14 +1634,22 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		break;
 	case BPF_STX:
 		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-			if (insn->imm == BPF_STORE_REL)
-				write = true;
-			else
-				read = true;
-			if (insn->imm == BPF_LOAD_ACQ)
+			switch (insn->imm) {
+			case BPF_LOAD_ACQ:
 				ptr = &at[insn->src_reg];
-			else
+				read = true;
+				break;
+			case BPF_STORE_REL:
 				ptr = &at[insn->dst_reg];
+				write = true;
+				break;
+			default:
+				/* ADD/AND/OR/XOR(+FETCH), XCHG, CMPXCHG */
+				ptr = &at[insn->dst_reg];
+				read = true;
+				write = true;
+				break;
+			}
 		} else {
 			ptr = &at[insn->dst_reg];
 			write = true;

-- 
2.53.0
