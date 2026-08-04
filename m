Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4C480DCD
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862968; cv=none; b=JulREzHnHs/3tmOvJxzrXevo4cFkzL0KsXmE/cu9g67iPPEsJdwpCS1CZIVbKNLQM/jnBSM/b6AEK7Om3nviR24alK+3WMn+c9uj57+x0n50yM1zcAr6C2pRPwk0JSFJfs+XoC/nWZvELN6SscA4J1TMH882yMKlCzvF0THt/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862968; c=relaxed/simple;
	bh=p9+J6YirvDO6reGmV+khx7v34WH6y4JYAT5US+DhCs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWCqs7dsiZHQEZrGA8l2H+94UUZRQdndeN1+GLzITc4LwKNt+hzXv8FFGIArqgHJxwQFTcMMfQmOmm4mpzo/tMsZB7EAujAeIDxLBAXlGEHC7xz0q7YmwAuOvkqeX4Q0EB/aRxUN70MrvlCTyZKKaZcZRftcWVYp+xR9rDFvmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilyWEs/K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilyWEs/K"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb7926836eso3297577a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862946; x=1786467746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWypoSLX5qVRijNNQynEg01Mcx6X5iUuFofug0UO9mc=;
        b=ilyWEs/K5Aci1lqCgLNkqGhrWZJB7Cr3YPbvhj+PARhN0J83OLS28LzQO1eYsYCxfh
         mDLvRoKbbQ4VHC7TGviVH3RfAIITMZ9zT+ni29HY5I2gLWpVeZOI8CHdC3xxK4ZNMoXj
         1ZBF9FJF7Z6PuspahBOgfPZeW8+waixKd5OA3lB8EmeFvrwCwdw4+yfLnuEMSyKDY6Pj
         Bq/sRvSxUOOIOr/fo92aF779o71Nu8VS0VzRPAjU829NKiu2+eVePjkq9Y7YCqCDFn2U
         wJZHRNTWb9CAXckHJU8LhCUOtf7nmU7BVg1SYHulpOwoZiQMY0Mg37SAqgyDo+glcgMF
         /Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862946; x=1786467746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWypoSLX5qVRijNNQynEg01Mcx6X5iUuFofug0UO9mc=;
        b=sIsuTusxxRlLfOUNj4i959rEaUksTE7kJkc6eWLyXjtXZmP6QjZLbZn3K+seuskTdG
         rymYGR2OYf6drq0ZFEC4jek++pHoYKlhBvoTiVn6HymyDlDVsB3iezBl4btyQn+7eFpa
         hrCP8LXJ4RoFSdOzphINYCsPoz8j0tX48RlJuTzCocirxrjcE1HzDyEajEJefJOeTMQK
         ztVT1t26afBIYtxLAHRZCYRTHLrbLlqcM0y8AeDkyRBENHWZ6CIltrqZbtkeU4e42mZl
         456m7L7oGcwYZv4FrfI6sp/WYQHFKWT+6eDtfeYXZ0kRjm26QMibzj/PPIFVwV9JqfQ1
         P/Fw==
X-Gm-Message-State: AOJu0YwrwSJ4RX9Ou/NAEed5GE5rmJ/PmdLWHqZ/SW3+u9Fb8anhvSqD
	9AuEW8CnLnFdtxHUEMrTpSxYbY8RwJTsB2/3K83Eh82HojJ7WRN2wz/lkJq5dPUq4xQ=
X-Gm-Gg: AR+sD13Cdl8M8F+eUxWPxmsoPQcEflpyrKeYVfbMSwE3L0hmBPOHFw1KF4q1txD1E0z
	4QSvlqk/fnRidhmahVZwXNz/bxmihTuUSd8pprTPjen8Q3qMb3VQkimDuKLapBDi1B0DYU6Y6FA
	kRgYy15CSMCc4tgtedeqtbRJApgegwle7VUAYAnOuBIXT3yjK3pJSg0P/T0dxC2cUiubaWrD2zK
	bSOiv+3bvOJLtVg9JEWd4PQVaZCYwwzEKcye473wME65hI9bmBgHQ7UR/ze35bL1IW+98zAuxSr
	J6YH8e1siNs2Evap91V/zkJqGqZy7tJtw2rVOVcF0wmA9jm1J5uJfHIW8Oe2uOYYzAzsfbk1hpe
	LiPGQBDfPfxTkcwE2pdxuDf7pJkL0uPwmihD/Jx2lquNcC91mpUB8XH8WfwOQzLOGx88FEGnJ9b
	Nyf+8saZ/axaejAFg3l/9wo6pYDxBLrqtGI4xcdnGXJBkQ3P3hWEywEO8A3nV7Mm9VxqereKTsp
	TwkcdZ0NQ4=
X-Received: by 2002:a05:6a00:a83:b0:848:75b5:1dd4 with SMTP id d2e1a72fcca58-84f2e1f4594mr254747b3a.59.1785862945697;
        Tue, 04 Aug 2026 10:02:25 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:25 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [RFC PATCH bpf-next v5 4/8] selftests/bpf: generate the signing key and certificate once
Date: Tue,  4 Aug 2026 10:01:52 -0700
Message-ID: <20260804170156.1709916-5-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$(VERIFICATION_CERT) and $(PRIVATE_KEY) come from a single genkey
invocation, but a rule with two normal targets runs its recipe once
per stale target - under -j both runs execute concurrently and the
openssl invocations race on the same output files. Rewrite it as a
pattern rule: pattern rules with multiple targets are implicitly
grouped even before make 4.3 introduced grouped (&:) targets - the
same workaround the test_kmods rule already uses.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 565862247..774286a55 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -800,7 +800,11 @@ VERIFY_SIG_HDR := verification_cert.h
 VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
 PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
-$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+# One genkey run produces both files. A plain two-target rule is not
+# grouped - under -j make would run genkey twice concurrently and the
+# openssl invocations race; the pattern form is implicitly grouped even
+# with make < 4.3.
+$(BUILD_DIR)/%.pem $(BUILD_DIR)/%.der: $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
-- 
2.43.0

