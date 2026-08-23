Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED93ABD8D
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514190; cv=none; b=Ehyf7fgrc4Jd0Q5I2KKEX4Z4gZ8vigsfmHGpfZIbDiv+fRxP9J7XLoO3Srg3NO0e2wBa06n6Vi9I8WuZawZHrlGPghyEWiJm3FklWLQen5zRZQVxGYDIIB3IVVoeSFfAtAa6K980YG6mx6OXPOzvS4t5bDopgNGfsVdVWDT/glg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514190; c=relaxed/simple;
	bh=LuhDOqP6kHxggDykgo17g+9fTKlf7dI97a9W6FLXtCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcrJvvsh05JGQBwhZxklL0da/8WlCO9GitBRQkTGGJVameltrhE1Foy70m9G/ZBLpEQBcmniHP519NmrZ9VDdGqw6Tjy740hd5U08fng4vfod+3p3FiEW7BgaWCa+VieKlDgnyrmqrA/vNRCet8L/9fhoRsmzzTnsfv1lo0Oz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh63Mpq+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh63Mpq+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso1607822a12.3
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514189; x=1788118989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nVRKLBXOY/pnQADr+Bfw9vuMWjF77x+n5vf7Z5RLQQ=;
        b=gh63Mpq+y75BXmh8q+kGAvUqqH3ieUSghed8mYpT+48klzDS0iN9AeqIp6r6/d4sbT
         1I90azYTxJQgfSHDo5iVLtj9MzIEe4Hx3U4vAYHhXvVhwdXutU4rOlS5+vUhOpTghHhV
         sfnr7MZT37VSKL8HPCWE57oN4PpIQNYJtTk0J3Zg/czPcb8FrGd+SmlxtgUiFqln7hs+
         mA5ZRUr1D+sh3eiz3lbFPs+lv4O3rYkydmdug/XJ/w1lsRoCUn8OgW4nAu2VYLHtOHEF
         2xRZvMOVWvgBeV/ZcvGpW73cC4yCR/waWrMgQZQR9t5sjtUyBOBD7ljMdD1K5PnQAvnq
         hRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514189; x=1788118989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nVRKLBXOY/pnQADr+Bfw9vuMWjF77x+n5vf7Z5RLQQ=;
        b=E2sT+qjH1KhMwNalkQmPQ1h3pl46MDhN8l8hpg3hQTRegk/o3ouFexhn89xbC1A4ip
         9zjkQX9xZfMt8/Do/gHh/+g85ccsuFFW0ees9yGiP5uvDbidGldwNRksLepiqQQtOJUs
         JgWluY9X/HtUrCEOBCGIO6U6/vBR+xXbq0VcHGSPjQP/VOP/sbexIiGAyOXgZroCwFnz
         OfXmevKiHZvJrPjAHLElfmesNzBcT2LdQFUek5oB/9zslB7VnjMZxsv5psE46lIquWFC
         g1aofJAfZ3qz9yyN8cg4zLXtKy50FBKQ2JL3JtuqB50mEji//08/7WVIoeIN8COsG0LD
         4DwQ==
X-Gm-Message-State: AFuF++mHLL2QJdglvlyZhuBWKUAxZlyAkEVJp1QtCXu7BAkAfn4m95GF
	pV61EP+O4QitrZPrGxd94HS2YivnijN7AfE7WTzCFH2er12haZyBM3agNWKEAsAb
X-Gm-Gg: AR+sD13P/w1M3dLgPDpN5i9mFW0TmPzv/qj/hlualHjuzGT/XORd4k7dsLgQ+zry7IO
	ghaaCQayK6ulLoWo45JcBkyZUiaNHKKI5NaTceiOzVbvlU79jsiT4wDfJveOWunD3gob9Ar2/Zv
	PKtoimnXsrCJ2+c6iqx+llZwAsbGiKmNiUvsOI3sBhvuHprt+oqUKp5GlNGPD39GTIBI0ovN0cP
	34p/0yOQBZ+HiJrzCA3ReUCczGyDvBg+zC4N+zmG9e7arfZ5ATwQExIJe2AKUiCdfud7mRU1a8c
	sD7jYbXsOKili3MXeQuYebyH+ZI+zFTuG99USbtY1bFpu4AtVxJoFOmzTdcFVGuxVsCyLPq04QU
	bF4jhdDLR4xWUXGQTatM+USDLsNsXJjj1xiWkbYjrcKPowJRt2KTpyZ/fSpwI4JHFQVA+VhDD/I
	E92y1u77FydL7c0oJq58hTZw6DTCDF82qS0CZ4xnh7ZAKRUiABQNvZlKRQheUqYWiEGJxaYXDHG
	x6t9o2EA6oLuFV+044i1E3tEIg31LNTAzF8STDyjgvNkFUKbXHAcbQ=
X-Received: by 2002:a17:90a:e7c3:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-395c371d53amr35239490a91.8.1787514188806;
        Sun, 23 Aug 2026 12:43:08 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/9] selftests/bpf: generate the signing key and certificate once
Date: Sun, 23 Aug 2026 12:42:36 -0700
Message-ID: <20260823194241.3415152-5-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$(VERIFICATION_CERT) and $(PRIVATE_KEY) come from a single genkey
invocation, but a rule with two normal targets runs its recipe once
per stale target. Today only $(VERIFICATION_CERT) is ever a
prerequisite (of $(VERIFY_SIG_HDR)), so the recipe runs once; the
runner patch later in this series lists both files as prerequisites
of the same target, at which point both runs would execute, under -j
concurrently, and the openssl invocations would race on the same
output files.

Rewrite it as a pattern rule, the same workaround the test_kmods
rule already uses, with the stem narrowed to the fixed name: genkey
hardcodes signing_key.pem / signing_key.der, and a wider pattern
would claim every .pem/.der under $(BUILD_DIR) and "succeed" without
producing the requested file.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e4c8efd1e6f1..7b80a1b1ef76 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -787,7 +787,12 @@ VERIFY_SIG_HDR := verification_cert.h
 VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
 PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
-$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+# One genkey run produces both files. A plain two-target rule is not
+# grouped - if both files are stale make would run genkey twice, under
+# -j concurrently, and the openssl invocations race; the pattern form
+# is implicitly grouped even with make < 4.3. The stem only stands in
+# for 'signing' so that no other .pem/.der under $(BUILD_DIR) matches.
+$(BUILD_DIR)/%_key.pem $(BUILD_DIR)/%_key.der: $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
-- 
2.43.0

