Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6C412C04
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051335; cv=none; b=AvL9bVqAGq3ov6urvM4Lot7YBdp/RIKz5wirSddhUdIFghATZNv048SBUUJTL623u8GlX20HQ7ZEXDfNLa4lCAcJmphFuMEH/RlzVQDVkXBYO7B9cWXep1NPj8CRfvl7gO/9mFfQG31032Z6KJSVJV1MCqCCGRqhKt5QLWk1CZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051335; c=relaxed/simple;
	bh=oEKUFe6He9YyzYnObHI4KSO0XtXvJ3JdBWqhH2AueLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rW697vo2NbgNmMXGn3LXw7dv1/GCKTZUlbS9YeyO/SceAB5gb5Rk9WfqsGJGFER5soi1DQ6N/rSizNMAo0l27Rtx57GqyqLrkq/it2fXO55lgiwfJpVidBHwFa6zEICVEIGIoIlxAWTEzeh7AVRkDMUn28yvzan5oVZ2Ui8tNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z9r4cc/1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z9r4cc/1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso18242325e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051316; x=1784656116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raWiwRZEQQqDhRSvhhJ/GJekPfKvlCApx6athB+xse0=;
        b=Z9r4cc/11Doh09LsOwsxu+BBuXgz9odTIa4OHFm/VPxcppfihsCR2dKswqqLDu1FBD
         mpqOV5QeO95y83NZgcsZNHagudNnFmocRsfw8Iw79oWKoFhG6OHdOUz7X+IyLeY2M9FU
         7dqMFpkSjgBP+1xfchRXPk8vTzybsYT4PR6kF3iCUkPhJPvCaFYp+rEnBPu3kwhifw6k
         LA4LpqbV12hrHndNj0F3xX73cTqiQoF2E7KT/YsqWItGIETWbk5nd+saiqkPilyhM9/x
         homJRv4XO2/qPw3UViINJN/2PweX2wX9VrCBFJmuFKbKFHOyDe4Uh+A71rtZBVMpsBsC
         ESLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051316; x=1784656116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raWiwRZEQQqDhRSvhhJ/GJekPfKvlCApx6athB+xse0=;
        b=h4D2E4FXv10/QcAqCwgTL2FVdhbLD712e5pwnUhLtHzSYD6nUOwty01k/xANqOssxd
         YXvm8o5rHnHvxUZuyGyECTy6gwZrPYlwrqqEwTj/+5GQJp/rAJNkL0b7ESnGP75jGloI
         aNboya4mC0qLCOOohMotzmMAVcNAbbs5Pf9a8/Hsuo1J2U37lH4+8ScxWZK4Adsfoq2B
         etSYP4CstX19WuzmPwbkIrqcRRHns/sJpZz/TjFfkFYHrcIYaLEDglYWeIlaypmriNKR
         ur6xY+Y8B6knVbKvvPjOpb4N3b96uUzMNwhey/7PwQ62rI2hzs0t4eRaWr4CnqHLlQtN
         IP5g==
X-Gm-Message-State: AOJu0YwwJ8B30gzRgljyCRBtEIGSxRZZk0AFxurdiNghJmWdJfyHQ6Dr
	LJ5uyupi3Y0yCBW1XDcNUIua7ik4RzBddjIzOyFtuBqB6ucmDpChWT6l3SoghNpvXQzBIH6e62x
	Psr0m1pY=
X-Gm-Gg: AfdE7cnMgLXxutta4Zzx4tvDohr1igxXGGlm8fU4wkk4FZp1r8Nkz+mxDJSuY4YsJm7
	R+xt3+sc/cmXIYgiwF0vu79I5aFZuMcOqWifFqvQzZ5yVLlOo8Nf7/aNUaTfbFOyo+KXzpSjFcT
	bJwhQIK3hyuH/GNDMDAj5R1FcC8HzLsABG1rjuVpSroZ/gK+KzXDAv+VV+fTq4m0g7sMZ0k7AIU
	XKTJaeIw7QHV5VQA3FPRjnQYVpJ3oUkddwBWAUFDV1CkbC8C3OmeyBTTGaEJcuA0QnJqb38zHMG
	cxTNeD9+bJ8wYsrK7xFMuBXXDHrtgVD6FQvhoZ6dJz95G2CFk3+yqUFdr3M3fb27h3u6V7lu0oH
	czkLaos5szjv4ywt+mvuu3q+PHJOb6Vq1YU6Xsh3OhYoXw/oQcMDZOHYjyWJ/mErWmotZnOfaB5
	qgj1IR56OaDX+lBIzqrad78Bc5W8pBnNlgyWWSM73E0bqLqn0=
X-Received: by 2002:a05:600c:37ce:b0:490:b189:212d with SMTP id 5b1f17b1804b1-49518314f0cmr53886715e9.33.1784051316176;
        Tue, 14 Jul 2026 10:48:36 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322c86sm83493315e9.11.2026.07.14.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:25 +0200
Subject: [PATCH RFC net-next 6/6] selftests/bpf: Use non-trivial test
 payload in xdp_context tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-6-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

Replace the sequential test payload pattern (0x01..0x38) with
higher-entropy values that don't alias common protocol header fields
such as IP version/IHL or ethertype LSBs. This reduces the chance of
false positives from stray packets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a697e8f63722..0a73035dd855 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -14,10 +14,10 @@
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index a1a3cbdb85bc..7e5a9d14b572 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -28,10 +28,10 @@ static const __u8 smac_want[ETH_ALEN] = {
 };
 
 static const __u8 meta_want[META_SIZE] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 static bool check_smac(const struct ethhdr *eth)

-- 
2.43.0

