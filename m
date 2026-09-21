Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720B3B8948
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977585; cv=none; b=myZRfzB8/B0xqkERq9hWkFV6O+TvmBaFd6xLrteCibvGqlq5MMIj7L2aSglOpa8E388Bkl5hOdrOBpbbNsQJO/YJInjy35mUv1fEMyMrrycBTLfOINiaLyyuZ4DsiuHfX2adJv9ltnWGMQdG/2RnRkfFlKWkHSYqzhXF4KopK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977585; c=relaxed/simple;
	bh=TX07Twm2bwaXdZdPvzYE+EZanTnTFawchnA1cWSCFuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df2XHckhtCIjBy5BUr0WMzF0nNmcCqGbWSQh+Lq44dxUKm2uckyuC7sL3UjHyqAyxfN4J03fJL3LOsC4EJ3kFAliu/5pqraTO5LGSBGtagcq6eu/QRDwDIVu78+LOJpGWKqbqZPCNMABYR/zQjXzJA2BNUP/XDgmUFDxpbHwXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtdzMjh7; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtdzMjh7"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2339807a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977583; x=1790582383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c9MVcCcMSsUdNo7wWdnvczF0GOU0imNUIDVq8uOUaqk=;
        b=MtdzMjh7LWcvMcQSqom4P4IANFyiHfaljHTpbFsnsTDV7DFpKXeqfFLxyX6q7Z+cOf
         6RXSKbdZEsypMhfWEuOJ6AVqlIt/qTwNvd3yskoU/Mlxyri8aZHzmZYPw8tnVgQbjgBx
         wOx0jyPfsQoCNnWom5QrdIjNJP9lILW2D4xxSQjVG3CLPQqIRX9KlID3V5FDTZYRz4r7
         yjp8Cr6/wAnlF/mqqR99jVcywBeL/4mOJq7qfcunnbySumTX0CF4LmUpSYf/fX8xnoAa
         QyuDztv4s+V7zKXtzkB0bpFqHfMkvr5ZcJ1Om4BDKQrOy6GeO0XZEXqpn/NSwdYA7BaY
         ePYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977583; x=1790582383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9MVcCcMSsUdNo7wWdnvczF0GOU0imNUIDVq8uOUaqk=;
        b=edlyBs3OsGDFpmTRs+gh4NVLXDRZ/OZY1O8X32UXoY/mIi9CIYgotsHVh7eF9PWBAZ
         FxjIuQRGzTMVEtvEbgVtdHMNRhrAEQ5HwHevOtkDntAjLm+xfmho877yn5k54VNzoUOj
         16mmQHAaElYwCMAT+j7UrHiKcZhqpadNE/m6iq95Gu1xQk8ekq2RT1/MmcfV/ZX/qDS6
         phYe1xiTEYgKK46vkw6g5TFqXI0R27pQAasvGxrMmjc5Y/fX8I9BfXEFxIOORR6iAR3O
         N454/zsYiZ9l2+TRTGNTvbIOegogJRxZu4X+zizuuyZYl8hXA0zugflO77xkx0uUUxmi
         QvCw==
X-Gm-Message-State: AFuF++mu/y5Eoc1Gg57c+3LQZcYPbAUT5X8TD5Zf22Y9ts80SOpeg1J/
	V3wbn/ScHgYU+cavxigATjWNP/4plPjOZDXjXtG03zRhDcaZrFxXCrjytlf8T0yxyY8=
X-Gm-Gg: AYBFou18i//wXoH37ANOUmjeA0w3tgFOL2fzvEG40X95kWvlruSVgUnK0ZQ7M3CCX8W
	xujSjaema+YOMhnkWMrCUwmdkoReYzInrbll/b31HoJclbycFbE2tkuwUHirsuQ2xT0MBIJZu87
	SaSyTHYJQ5QJKjuwrAmMeexpk0Kzyu+ST2RjfM09D4kIdHIAwfvvFOhWcFLCPWt5udkPWN+yw2Z
	SvZDb/UN8QyapxG7ZL0+N5clouIcerG1fkVJwL3o4ekb1x6t8bww4yGTPwcqo8+/+qys9SYQOjW
	r+DdzqjdU32jUFxW+HIK84djod0dLtFYcp8ZHsiYbBXxzo6DYlLIxUmgyU2aH+e9ZMLUZvNE2os
	JCZhtsKDfEdoJJQG+8UCWkTyl11kbCHaNN4JemPsTORAP1a0CvlrJC5hbXNZGAWY5WlIFQH28dK
	Rua7ZetP266z5m0hXg7iU0nIUq7nLNgVPvfnKPx91K06tM8HbV7mWo42jfmddXyVYVhdR6Q7z00
	i3oWXEsJ1tv6h5AtUXjy5G/GUcacSwC+1kGndpKqW55K/HOCgoAeSIL2kh2vubhCg==
X-Received: by 2002:a17:90b:3ccf:b0:39e:4c7f:7309 with SMTP id 98e67ed59e1d1-39e550784ecmr15073945a91.32.1789977583353;
        Mon, 21 Sep 2026 00:59:43 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 4/9] selftests/bpf: generate the signing key and certificate once
Date: Mon, 21 Sep 2026 00:58:50 -0700
Message-ID: <20260921075855.2065871-5-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genkey produces the private key and certificate together, but an
ordinary multi-target rule can run it twice concurrently when both
outputs are required. Only the certificate is currently a prerequisite;
the runner split will require both.

Use an implicitly grouped pattern rule, as test_kmods already does, to
support make versions before 4.3.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 11bd8997aea5..5bcb762dc3fc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -783,7 +783,10 @@ VERIFY_SIG_HDR := verification_cert.h
 VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
 PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
-$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+# genkey writes both outputs. Pattern rules group them even on make
+# versions before 4.3, preventing concurrent genkey invocations.
+# Restrict the pattern to *_key files because genkey uses fixed names.
+$(BUILD_DIR)/%_key.pem $(BUILD_DIR)/%_key.der: $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
-- 
2.43.0

