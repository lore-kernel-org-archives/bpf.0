Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322143C1F5E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690861; cv=none; b=leJ3O64g0p+nX0jW+/wKkePHBpBnSZlCb1Wu1Rfj5vfrwceOaCn5Pb2aQRjiuGd+cmMLXGX5lu8PmfSO8OetQtrmfihgSzzG/FPFnt7FoPHgWdd0YsyM2J02FXZwjSgN5JIOfA34ZXhbH19S4EI39MXnIETL6/qA69Abt/KBXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690861; c=relaxed/simple;
	bh=5vyxLhszd4pc8MOuDhTfCuGbXmG0d81B+H2+kf+qRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb1aCQvsMBiDYrOqdVXgnRzHbopUSBPq3HVZEQ2UyYYLupLC33LvRfGumoeKgeNUss0vdnwyMYh7pjGtWhIg+esBzRsJz7crjjszW0COI6K3qek2fmiXq9E8Sb3W97Yd2QLde27HGf/TnHTJ/3EN8RJLpUolEQl4SyU8tx0+Ozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAsmLVWp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAsmLVWp"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f52af13so1677005b3a.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690859; x=1781295659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/qqVZz0MXMbG2AkjLHGnH5V3pnHRKsmfhFOzzneMQo=;
        b=JAsmLVWpv67sNnMt1R/lSYnu/3Bz+ncPsC1pi3rvL9w0/xoP3VOVYAKCmSIlmdpnV1
         /TpGA/T3rM8vtDZ5Q5rAJfU1l6kreRiStXNEokmQnKn98z8X7CTVTwRnc7n7bBUZCwfZ
         LmzjHH1bhHg5N0p2KZSObRl3bH54x7ST6g6rRS7/8FG1ajDg33NyrFw6T/vQ4hFF8Bg+
         tyEAZF7+0R0lDe4JLSTJt7nwFBhXYvc9ZnqAy/0Q504MKLs0Sv1G9phNbTVZEUxqp02p
         rz6DoQ9hKUgpUviveJUoVy8GuQr4Uzd5SkXIwJJb1mjbRZPDOmI8LBV3zmqxew2wGMe9
         hETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690859; x=1781295659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/qqVZz0MXMbG2AkjLHGnH5V3pnHRKsmfhFOzzneMQo=;
        b=ZXWqKU3+vPWxnfljJ3Srrwge+HKlxRVpFdGkUCeeeeLhFjB+QYQC22ePuP2FFX7Y26
         evYcQmJcDubyr7fJa1X/v8SnSK/HhORjqOtZFLbsN6hlo3DnCZh1J+njo0Ns7n/lVrJB
         hOFdbOR5Rh3NH3AD5Q1mAQzk4pt6QgdOso1wY7sBHEvBUiIOHgoW3cxypB/o2FLsoi1z
         6yRbEmxQWSbqLS06lb5FPJfSknmcZlTJXS7heb8a1n5ToXqRlEno2zpyGvT6aZruex5R
         sbDn/Az7evKVBCGbzMTjHmY6pJe4bOr1/ypJUTpbu+nZvr+nzi8R5Glsc40WSBEBFulQ
         xCvw==
X-Gm-Message-State: AOJu0YyYYZFNy5ZOGUDsYnUSempz1pdKN0yKkIfLcc4Gi2J1QoWfk3wD
	JVv6Jrtk2MtMv18wAky3D/sFp3uyK8ULFEE5SS637bh1ILG9YqQNDSbsIvZvmQ==
X-Gm-Gg: Acq92OG/JTPfR7U0MOAJHL4vUfeUozQBTs2O8p97RwTlONdfQWvKESmagIrOtOPnLyz
	mDhZboJmAiBusNjLRo6yTAIvkom/Kwg3cWJZdQWn3kMKRn7a0iNm7LR3d/4uDJAvGOikQGAfVLi
	p7DaN2nuWxg8FLPHkZuUglq4Fl9/bwZLUqUvF7+abwJAPzuKpOgzQ8WgV1rMgTAFz/xnOQtA939
	Uq7M6A/7D6LCSsqdc1ON+wX/L6HIchc8stf7MZtn0rr//KTzcVPhOOBhxaMGMZMY+3uy7jeYXhz
	8HZlzmQxJX1ORbDcu6TY1uaGEG3vR0oQ6dx5ZMPWqPCQ9/Tg+gkUSgxNwBPJfQr0XxcriGVMa8G
	Wd7KeFbOLg6NfD8Y29dHsAeNcvx1+3FWVMD4YwwvPNPSWxi3aeqGzCfzbP6/5I83bOMW2g/ug2n
	yYewvYx4qCjPYR7WL5f+ONGCM=
X-Received: by 2002:a05:6a00:909d:b0:842:7e71:b74 with SMTP id d2e1a72fcca58-842b0feef31mr5186787b3a.44.1780690859330;
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e1e5bsm9955003b3a.46.2026.06.05.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
Date: Fri,  5 Jun 2026 13:20:53 -0700
Message-ID: <20260605202056.1780352-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When acquiring references for struct_ops program arguments tagged with
"__ref", the return value of acquire_reference() was stored directly
into u32 ctx_arg_info[i].ref_id without checking for failure.
acquire_reference() returns -ENOMEM when acquire_reference_state() fails
to allocate, so the error was silently stored as a ref_id instead of
aborting verification. Fix it by checking the return.

Fixes: a687df2008f6 ("bpf: Support getting referenced kptr from struct_ops argument")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6446db9628ae..80a72402463d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18362,9 +18362,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
-		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
-						      acquire_reference(env, 0, 0) : 0;
+		for (i = 0; i < aux->ctx_arg_info_size; i++) {
+			ret = aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0) : 0;
+			if (ret < 0)
+				goto out;
+
+			aux->ctx_arg_info[i].ref_id = ret;
+		}
 	}
 
 	ret = do_check(env);
-- 
2.53.0-Meta

