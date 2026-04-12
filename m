Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BD264A86
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015953; cv=none; b=aUJW580UuzAf0BM/94NKa+hCzgTeH3qTwi5DY9Y0rW9L0ONO12H3M7h0MBRbZmuvKk0n+af/Yne2/k7pkDhSmovwPgKPZ9Lie+b7JWq32HKAAcMGEKaSw+CWcQQy+xB8H5oi+m20QvWOclY6LoXUrIzUBZtLVhnvqC6fwQgl8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015953; c=relaxed/simple;
	bh=63/mRS5Y2Siyke3ieoYHbnyF1qKh/L0M5AdE3q7XJvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyDvhEdgwnaVV0ZNEn1sv/8xcO/TYg/fqMP1Dw/SI5XmUdqXnJbqhYtZY2h+Uz5X/LMZb0JnuJ9jhY9XRHtpgNRGQOP6EqYQOf9evc8v7D1UW/L4B4dTdOwCBz2KoA/B+OxnLLEkuNHK/XDt2GdlJMIZlpNu6kgqqpfJWzNMY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hnVecBK5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hnVecBK5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so1792243b3a.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015952; x=1776620752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG0bJkyyVqEeHnF16KGLZ/pTgnUNgi7fxwRcIKja2zg=;
        b=hnVecBK5Yf6Wp0BYBxJiVxB+k0gq7WMWwnW3NIcsFzsbOyl/IS6nqTIb+0sNQQ7imc
         Nl7ZzlNCBkC5vlUlDYhMLOtsZf7j7wkL93CFQA/dyBn59yB4zc4jOUb+6oyXe0HqRh1r
         CtCEoWbYN+LbK3GHUrVC6602tlM+N6EVN+2uQm8C5/qVPYGa5t5ffZnpZNBESFAd6QLi
         ZW8Ke0gbww3zHahjljKHlohKNOoTO9ZeQkK1/OivOVmpvDOGJ5Z3XiSrChh2AjbdQUFH
         dd9VuodgbEEXv7W2nS5jsNydItFo+c5iIQnqcPuVPUpV4aR+LAU47hWHKGqVHKJ9glYn
         QiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015952; x=1776620752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kG0bJkyyVqEeHnF16KGLZ/pTgnUNgi7fxwRcIKja2zg=;
        b=JDct4+3FuceqLKwSupvDak+h4pOEGbLT45GiyWcObOYb+2OFKGij9mNT6wKGBTELJ2
         PBTQPj7ahuQWlDezA9FlxGTXjyA+oTvCUwC+sPPyTnNwZ7JzgkzIUMFmFgcLr2ww4Yj6
         Uw5UUALXPtUgUOdDdhhHwHtGzAWsOaTTAq1VDm6mIphX6xVnGUU/XmWo5XiTqde7jYXE
         QriMaW0oEGZBXYGUUkvNqzrafFub+cbvKct8kk1Cvnnx+c9C0QyQg0TAucCzJ1zVZ3JT
         QxCBPVL75pqm8SZFb+Q2tXtYd97s0zagYM5BSKPPe2SqplKwCPGDBvSEf2wl2TYqE94b
         0wbg==
X-Gm-Message-State: AOJu0Yx5fSnN5Av5xqtFSPeGnlmXOnLS3aJm+j+IgGTlMDccnxPbmx4M
	iqCifYkWGPvMGLY9CyxMWOj2iw0iwbuJU4AHjKXZYGafPWvffGry2psRiw/Q7IN2knWF5SC/2/b
	Kt6EdbdA=
X-Gm-Gg: AeBDievEy1eSlqPM8Hqoqcw5MvcAZqkjfVAbtw0bGx7tNzx0AyTDOugWvUDh+R+d4le
	N+9AgIkgUkGNRLBU0qOKPzVi6ScqF8AhpyHZYAEH+d9OrLyQtL4IwfZdxPSEgw1x6PCej5urFAV
	phixSn7COzYeQhnUiSRvU9LXRR4y7GfAJTczbXFMc++0aL//LYAtm5fuNgPZ1mCBdAiydFcXu28
	eX9Wz2KgMI8IIFeLChNW7Z+IB1YE8wYLPcs7OAlS7eMIP6p5xHuNHAtcavXnDp4tPoWSAMezhYP
	ROKZmF+EYtcaOGkkEUHQB0XyFWZ796LigJsTD5ql+pe7WDHsibG+3Ly1wYREVO1etd4HQg0qEWh
	VAmbkL315iBMWRWBJkqhRF2R9o8E7UHQLgAiU9WoBuIVLM7dHkAPKTdceW5CwprR7Fqj9poG+db
	wC1A==
X-Received: by 2002:a05:6a00:aa85:b0:82a:7046:86a2 with SMTP id d2e1a72fcca58-82f0c1cc417mr9346048b3a.10.1776015951568;
        Sun, 12 Apr 2026 10:45:51 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:51 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 1/9] bpf: Allow instructions with arena source and non-arena dest registers
Date: Sun, 12 Apr 2026 13:45:38 -0400
Message-ID: <20260412174546.18684-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler sometimes stores the result of a PTR_TO_ARENA and SCALAR
operation into the scalar register rather than the pointer register.
Relax the verifier to allow operations between a source arena register
and a destination non-arena register, marking the destination's value
as a PTR_TO_ARENA.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
---
 kernel/bpf/verifier.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1135d373e2..9280b3aaae46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16655,11 +16655,21 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	int err;
 
 	dst_reg = &regs[insn->dst_reg];
-	src_reg = NULL;
+	if (BPF_SRC(insn->code) == BPF_X)
+		src_reg = &regs[insn->src_reg];
+	else
+		src_reg = NULL;
 
-	if (dst_reg->type == PTR_TO_ARENA) {
+	/* Case where at least one operand is an arena. */
+	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 		struct bpf_insn_aux_data *aux = cur_aux(env);
 
+		/* If dst_reg wasn't PTR_TO_ARENA, it is now. */
+		if (dst_reg->type != PTR_TO_ARENA)
+			*dst_reg = *src_reg;
+
+		dst_reg->subreg_def = env->insn_idx + 1;
+
 		if (BPF_CLASS(insn->code) == BPF_ALU64)
 			/*
 			 * 32-bit operations zero upper bits automatically.
-- 
2.53.0

