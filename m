Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538399;
	b=nErQmSt21wIGpIynlwYxp+vGQ+6Xmh5kpSuK8gDGUzuE7fgvOB87fv8FnE64ojkImfau
	 upyON2rTMKn4K8p9VCiUiwfpVO7DKGjrsq3z47wQmWMA0bfQZuM34sJpFQILyEoX4ua3/
	 4RCQtk8pW4RBZYUFX5/V0BQRspYswa/4l1KlH/ZrEXwXTpQzaUwy+lQbYh3UAUPXq1PHM
	 qbpVLdUlKzVB2basLp7lTvY/iQWejnCQI5esbThNeqZkhYGxcmzwwQeUejDHU8cWQicOB
	 YiCy1s+DZ0PTQViMlz6NIff53C9SpV7DnKyIoqFjv574yQGjNfSe7JHe/PHWfFcbjuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hc4TEVuvWzyg0HQCXzcfeCpFf+Rspk/JVSrCCcdyBaE=;
	b=2U/dbYgDLGGYUHk1XKTK3Xn/KR1V7FW2pgcr2ORwqZAwu32JsJOi5I/NxITIs+GE0EBu
	 iCI76aDE8KLby2IGYuDrZj6nuWZ8cQckeZJv19JIDfsUcbRX6PtD9M2WWayuanR49EaRf
	 4QkchqNsvpuPMmHigh+zcBjjWGEr8aKZm93LpNRYvijryqrq86W2bIRbOq84V331VTqEI
	 u82Gx6MsAgMaeXuK7YxGwUtMQiOXFewg64uMsfKRs3MK1e/z45TE/sCKUf5D70pz+3VWK
	 /LNeGRsrz7NBr1H1Jbqdqh1YihTqXGcW6FwB3r4lu91FVsh4zlwC+Nd4fmKgMpyl/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7HXsKhJ;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D8606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7HXsKhJ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso39378a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538399; x=1793143199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hc4TEVuvWzyg0HQCXzcfeCpFf+Rspk/JVSrCCcdyBaE=;
        b=i7HXsKhJMvjECuYcqIGMj/Gofujdds1m1zbdT9vBBZ8tg07kGX5VQhCHUUjMPziWey
         XJsxrvtRGBDfNQL2VzN3ahzUezhpXQ98EP+hMIqzSXBIUfVd7ROm3uxVEI3bjpAXdkVr
         3vQriA9td6sez2Cl5Zj3W5+km7NQIrNdpR9hoPH1BHjC/jOwdWpumvyZsXBTOsJYslHW
         RQ9G7y84kPSy9cNxRgEOwsK8r1T1MVKLrCJfWmADOlKmBy8ArhB/9B6eSXB3sYA/bymo
         JhrdWrITn5PEuwBhYe7WWq4mKv2DSdR9X8wBNlvvxkhv2S+VDZH61qiti028z6zj2i6A
         l0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538399; x=1793143199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hc4TEVuvWzyg0HQCXzcfeCpFf+Rspk/JVSrCCcdyBaE=;
        b=uJg13kRMSmqiT9TzwaP3m3c7Ky/qylz3zET3GohK5ckgBe8PBAkxtGPpJm30W1SG6j
         kXCdPZz2CmrLb+4QzIU2ZPoVQr+9O19SJ55AZ3bUcpGXRlTYA+itUusnr5y9pKOtfQBX
         +rYflAh/0+g8NwBakcSKhUUmFZbLM7/3ABvgdD1R1pXj7BSUR9DMaPUiv39OgWlKZfxx
         MriveBV/1mq2EuUt/o0w98/1tr9+iLoRrF1+zgcFgIUsqBxRtNVNTvF+XXxrSQWcewCV
         lDIuBXwOsxPWA6DS5obntnQd0UC34QFnEhL6Jukf/OGxBOQwduGvD5zNuLKCOduELxhs
         e9sA==
X-Gm-Message-State: AFq9FYKZPymaPA23YeXFxlViGSTzmlZtA3psJ/s7GrFN1F3E+jiKSYQ6
	paRN8CFgmgXpZEic6HMbOf3P/Xd8pyb7bbRdlyBoSxDYXDXx4HOCmu7YvPRvZg==
X-Gm-Gg: AYBFou2qv+lF/9V3Z0OhfHrgrfETd8NBZtyZfrgULrz+BZnJMIfDkbm6D0ZK+D1Ytve
	DmTMCGkLl9hUbBltZpK7vq9kuwTP6mVhYUPl3LyWe0PEAqfbwsIvdZeuoXa6qoRwLPtjoV7wwi2
	Z8/gI9h3MeT+JHgUA84mSdOKzDTzuV2AqRfkrhkaiQA2FoIksa9HSy+kmh9QVGHPmPvuPvjatbn
	4zyxh6HDMLeh13HvebZgbmXB9EBDozHPzfrqSgxWd4ea/QWPsP0mWMG7wWAhESPGxvO9b8A8eZJ
	G5+O5f5yFopluJI3PyixqLTsAmm1KTcL2+ge3/bq6vNfESDIu2TUquYNZjbVF7jjkKAbS+GkmDG
	yJ2man3sydl/LHtLKOC2RhjziUNZRXUz4UXa4Xe7zI2ASUqwf22NDklaw61wSQGW4juytL8Ir6e
	DpZ8D8LMC+XhRHD0JcXlXdEZc9YA49ubSWI9hcZV5FELWB1fpHbAi8/TuhQWQPxPxqG7LZSGpCu
	+huzQbSKPfRsSxqj9vexIJT1LYT9QS6bRL+UC8wLNh6xbvoTT0qPmUdwczWBRMfSXkzHAFDdZpm
	u28yU/KPtoPXdmxXzVnSF4M6m5LLva1AyEYw+Xev23hneQFQBvgoPzLkuLQhoACaVeBmN9oR2ts
	k6nrlIFLxkJX2ruqkJdwlNmp3
X-Received: by 2002:a17:90b:5390:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3ad870b7858mr280035a91.66.1792538398762;
        Tue, 20 Oct 2026 16:19:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad803035a1sm1410099a91.13.2026.10.20.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:19:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next 2/3] bpf: Reject unwind_goto and unwind_exit in offloaded progs
Date: Tue, 20 Oct 2026 23:19:40 +0000
Message-ID: <20261020231942.2568163-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
References: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
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

A prog with unwind_goto or unwind_exit has to be JITed by a JIT that
supports them. The driver JITs an offloaded prog, and nobody looks at
jit_required there.

nfp rejects unwind_goto in nfp_verify_insn(). netdevsim takes everything.
Nothing runs such a prog, but it's not jited for bpf_insn_prepare_dump(),
which takes unwind_goto for BPF_CALL_ARGS and shows it as a call.

Fixes: a2d274771321 ("bpf: Add unwind_goto and unwind_exit insns")
Closes: https://lore.kernel.org/bpf/sashiko-outbox-179499@kernel.org/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d7193b087f6..5601d2056218 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3462,7 +3462,7 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
 	}
 	if (!seen)
 		return 0;
-	if (!bpf_jit_supports_unwind()) {
+	if (!bpf_jit_supports_unwind() || bpf_prog_is_offloaded(env->prog->aux)) {
 		verbose(env, "JIT does not support unwinding\n");
 		return -ENOTSUPP;
 	}
-- 
2.55.0

