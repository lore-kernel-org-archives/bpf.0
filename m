Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800249;
	b=RnOJTJUDAbKS4N1IoWI6ffGj5atR6LkZ6oJuB/qJPcFntDr6hvb0dIz+otBv7fLvh+Cg
	 MKRVDcyuKyNQPW4lQIaor7kcoK1E9sOPVySomIs7BJzsMHeR9gjVa9Ettyv0Rvape8HDl
	 7ik3fdbmcU0fzMuG7iyyzsAJnudBYTYf5OkhV7GAzBt8lw/tXLy+2KLDbE3oxR8jgCnjv
	 eo34+r8D/+Orq64hXa5VlXHj8TDthpVir95ccCneWCMohWXYeCZDF44e1WYu1Y2IX7+wF
	 KlV0Ajg+CFgmr/sXA5xhsDhWv9jBJ+67rCt9L+BYcEvr+RaZP3s0/vJOcVzw+7ZeBfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oM6gbb1zmw64s25wpAgGPi2FdykB0Wj3GR1m6wjkmyI=;
	b=jBRCqpbzV2m1hNAD0m7RGVBwcKumiK1uPdHvqwfn86UjN9D7R0EnGnSlM7mF+CdEdpMy
	 XDJ+JxbGb3kYUYML8vMg8H1PpcV6aWVh7O8MTlCffU3bhJwaPNr+rOs/8p3y0/WE8RgJu
	 mH9jNeprbB3cnO3q3yPn8gz89Qo0/6t3IkytRxVQumyTB30r4IyyFqxBUQnQZc/63lus9
	 r0xaIKUCNNNSFpiP8V4vTU1FpRuvVU7Wzw8SKZtHUOIQibEtCitkG90GnmAWsGij9BGCu
	 AxTyRiXTr4ju92IWhjLEJjvhjZNNvNdoWm/nRbn6Axk+m/kEG/dxAQKZVDbYKt1LhuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F29lqgCs;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C733606A325
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C733606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F29lqgCs
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso791573b3a.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800248; x=1793405048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oM6gbb1zmw64s25wpAgGPi2FdykB0Wj3GR1m6wjkmyI=;
        b=F29lqgCsnHG6luX/Gk6WDlibYGfqEydaO+SFexxsyQBM5BzyzOlM1uGZWsV99w9RIj
         NqFNTWMisczmZqicLKsa3V/RJ/8+qiIMYXPZ/UIszdSGw6yANVSIIG4pl5ZkNxCBe4J0
         Lqil/xMaiGUJo3rTnKXHHBHKHKLPOHO13mS/h9/xBrZJpfJ0OMk+4dAXmmsvYLFfbBnu
         uvzYafmXHSlZQrh+bpqdwzMwAcLTuiuj0QqAM6Vr9G6je6/9Q1IA2YkqisLwhRC7GWV+
         HQVBHyR1n4C6Y0nOZPxxm1/jOPeThasL3W4RMnuAN8ZSj+JWjLeyG9a31rQEsGmKQkUC
         yMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800248; x=1793405048;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oM6gbb1zmw64s25wpAgGPi2FdykB0Wj3GR1m6wjkmyI=;
        b=UR64UgUM9Mwj+l/X3g6f0nPHFIcmAx45sr7CIPrXeBJ4VcBMGNUgSuJfx0J90cdbE4
         gjOLRvAKyxpJb25mUg8DCQRtQYhSdumM/t04FBa1jO43kYdaA8M5ZtnYhHNq0etUovYK
         8KiKh8o5Zy9PaCZrMyRoyIxs4yNjAQ4o2VirM/MzcKp9oOHzrlBUKjnpAiV7EcEqciGp
         dKoBslwAVy8o7Zvj944uf3BNtH+b4sWtWTnavANwfJujR6l1aNcAEvga2+7Eeuh4ZsQy
         EksZ3rVdtylBNbyR7RHiB+GLS+wTI7F+1gumRdO5AJxe3fJ6sflNoGu7DXL4vbeeUGi+
         CpDQ==
X-Gm-Message-State: AFq9FYLqm1vbuBxV/h007fbNvuACgV9n57EMISktbVUqyRm7rvAEdjqQ
	JDrxLhbdohUEF355fHloLe+tafNPF5coR1LUcHyJGOKa6YdPt2RmVPoSiANqGMyi
X-Gm-Gg: AYBFou2O7G5eDFpcL481SClgq4l9Ke9ikal0P9zqt8x91bwRALvSIPS6RjWBAupiM/F
	3gexp9ngMGpwhciOCT6JIN6B+rLf3gRakFY7h+aycIxhNtk1nyn6Tj6OryjIrcLcs52HDthMpMV
	axoy5ILvYjm3+0GhO/oyMlzXcNDxJtRUec232Qfbxz4EaRUMv/4JC/jtU7rg5lerz5/eBL8qi50
	wE5/YyLiPpfAMFwbQctUX4yLwlkZBOCKx1oHxnI1l/Va1CF7pqiu3yVwP0Gj4vmyXEaqa+sgfyz
	++DvhjreB65CmxVM93VmUOCmcxnQ+UHdNyMlrS78OQBcNkvsjHDmh4Ap9X8fOGK+wOoi4CDyUgz
	NmOesbx5nxQjVFTxZt84pCCu2CWJ+yRWruR7chzX5qIVUROW6YHGXIFGhC5Z6PO7lp/+AhMS2qZ
	/aqiMLKV/K/+ofTPYJK04pXMzeVQc3Ov/ot2uq7SI/tVi1sWgBzIXQi07AVRDKuXNsaj8pFeSrV
	75tthhPXty8MF5IEAn+iT6igZuzLghHT5skQTsXEEYGKMGFn0z+G0LqwWJy5OxCqMj8p52Y
X-Received: by 2002:a17:90b:4b82:b0:3ac:2788:cab1 with SMTP id 98e67ed59e1d1-3adeafaeb96mr590927a91.30.1792800248496;
        Fri, 23 Oct 2026 17:04:08 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 05/11] bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
Date: Fri, 23 Oct 2026 17:03:47 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-5-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The compiler can preserve an induction variable across a call by
copying it to a callee-saved register. For example:

        w1 = 0;
loop:
        w7 = w1;
        call foo;
        w1 = w7;
        w1 += 2;
        if w7 < 10 goto loop;

When building expressions for the loop body, each 32-bit move adds a
zero extension:

        w7 = w1;    r7 = (zext32 r1)
        w1 = w7;    r1 = (zext32 (zext32 r1))
        w1 += 2;    r1 = (zext32 (+ (zext32 (zext32 r1)) 2))

The existing ALU32 simplification rules allow recognizing the header
SCEV for r1 as:

        (zext32 (linear r1 2))

Substituting this SCEV into r7's expression at the latch produces:

        (zext32 (zext32 (linear r1 2)))

Add the simplification rule:

        (zext32 (zext32 X)) -> (zext32 X)

This allows recognizing the saved induction variable in r7 as a
32-bit linear SCEV and computing the loop iteration bound.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index e3c2220f89c9..12b147faa32a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1502,6 +1502,10 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 		return t;
 	}
 
+	/* (zext32 (zext32 X)) -> (zext32 X) */
+	if (is_zext32(scev, id, &a) && is_zext32(scev, a, &b))
+		return a;
+
 	return id;
 }
 

-- 
2.53.0
