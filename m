Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5536998A
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612696; cv=none; b=uEeGMr+zUKDSe2P7nWGpMvh2wwRcHTcAePE6HCW4F0jXOdYBjolislKlrwQ1ck2YDLGg6pZoY+boKRUIoD+qZphQGq0LfOFKOVM95BUHimCvGZZp6nI1ZoZp2vwXSsypj9M/K3u7gS/sqp3w1lVe6wN4oGfJ4e3qPcgHI0vEVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612696; c=relaxed/simple;
	bh=87IG69s4O65VKHmNw+vaDrsF9z/H+45X+PTSZhiRRdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRxrO3AnOxCgRHK9V3mx6kla0j18WsgRp79w8AOv21QkTUJVUTdfnVRR4F8tj9nHwzwSTpv/AI6IxXhzmiZID94QhWr3jJCb5fYmsDU/F8Uzdpu2BcH8LUiGg4NwL46YGBR/2VH7jHmd85hlITCMje8nZVdnkc1VePqVsGEIwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmHQ2iAb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmHQ2iAb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so4193395f8f.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 07:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769612682; x=1770217482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2hqiBgPjkm2mGxtAMoZvIn/phBBIQU5j1T7Yk4obro=;
        b=fmHQ2iAbVlJBnx//Ar0GnFbbOldqjAcyEsu+K6aSdBW9c/Azl0IFvSzfjFbOd3FEHe
         sKw27zXMOBvmTUaC1vd8wgek7GVcUmUvhPnyDDpVaYWDJteNC+qQaS8XzZ56oQW4JUUN
         ByIDiDh4HqznOWwikW4sVLOyYko7NHGFRNZvzGGFh4nWdwTmH8zhIA8HupYAkVeHoWYi
         ksZBg6U1iYFie5bWiiCCp0Jdm7GzP/82r/iGCopibUtXc0ZjSmNUz7dYe4EnxLhkM4j0
         IWTYVnOxCLhsx/4OiBJ5TR6EadCi93cGXO6MqaPo8fpMZmTryKuONZh9FP1uE6lUI6yT
         pDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612682; x=1770217482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2hqiBgPjkm2mGxtAMoZvIn/phBBIQU5j1T7Yk4obro=;
        b=PdsAZtLBdWBRXXt8P0TqcDE45Rq3sPTIekVDfAnE9sNwNGMr1svtXqrDNclWkWWdcp
         vM/yJRpuBVFJn2X8N5YaZAZ3L+7qsqkwS8uOlRi3Td3BbXqdqjgHu13wqISK2OmkCUaw
         Kzc4uOEwDh31/jOyEklRmpTlml9m21rb8ZTRJlriF8nFqnUJ7RvhpBmArxBoknClsV6x
         T0lKf+EXjF3P3/ejcAZnu9Ut5BZcMg8mw9Nq03Q63uPv1jJU5NwduRxgZSdRHoEu55mk
         NWJCmtnJq/lwrX96mbs1Um51FrJfLXtYddxkh2rsp0Oq2AJF7KhSXzTFGp+Yq0W5dxTb
         ys8g==
X-Gm-Message-State: AOJu0YybxSKINORSOVAfYf25HtD0RD3hIyIt+AsPxZW4fsmfer6MAIs1
	M7BMroGGL5DR3xB7GzvR2VFW5JdY/7w5Jh8a9kgm7boFVwBvFqS/3pi4PNtIov4N
X-Gm-Gg: AZuq6aIZDW0xUjz0/BA8Jb7uuTH8KQ/ChcdBo5pO0JYeGEZvYCFv/4yIputw2NR7gmH
	yD2lKowKuLhm4wKDyv8OuMMyhx51XaguAaxALrkBw13WJo7OKDzeL8m/kjMdxhmb/RsyFk/5njd
	YvFk4+6/8Mq4agUsH1EXr1jUESw0FPKwcMSsMSe495h1JIflwtDN8oiDisI2kVYxj9Koo+TvDDi
	LH4qPXxsXUlpSXGBjnKFDqNE8u0YyQqhBr4jJSUfux7yLKisn1bo5sUMgdHE/tpm9j3sVgrIH8l
	/3E6Af9aFOz5DqXtmmCbBvjMlNTokC8WLcB56AkTnSgy5pSPnln4rcG2KDHpdWF49tIejnao3bG
	53kh1dgZ/N/0Xzi8FtIgP1u5Y6NE4m7WnB3WBBdPqiIjowlN8t15IgoqW7qYT93iN0Bs=
X-Received: by 2002:a05:6000:2483:b0:435:a0f5:c276 with SMTP id ffacd0b85a97d-435dd1d8617mr7528315f8f.61.1769612681999;
        Wed, 28 Jan 2026 07:04:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:f1cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm7390643f8f.24.2026.01.28.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:04:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	kpsingh@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Remove xxd util dependency
Date: Wed, 28 Jan 2026 15:04:35 +0000
Message-ID: <20260128150435.85074-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

The verification signature header generation requires converting a
binary certificate to a C array. Previously this only worked with
xxd (part of vim-common package).
As xxd may not be available on some systems building selftests, it makes
sense to substitute it with more common utils: hexdump, wc, sed to
generate equivalent C array output.

Tested by generating header with both xxd and hexdump and comparing
them.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2c2f68a171ed..bbcd2101c3d7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -720,9 +720,13 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
+# Generates a header with C array declaration, containing test_progs_verification_cert bytes
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	$(Q)ln -fs $< test_progs_verification_cert && \
-	xxd -i test_progs_verification_cert > $@
+	(echo "unsigned char test_progs_verification_cert[] = {"; \
+	 hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g'; \
+	 echo "};"; \
+	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
 
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
-- 
2.52.0

