Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801435F8D9
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531666; cv=none; b=HA+KZGpmIG1YhIeHyoCCpi5K+3gLAO18xCpgRV5JuoJ9vqTn6/0rjlZeAPu7WB0m2ZQz+hqomnQJJDk+WpsCy/i+GBIxkujsP7V8T6knszMaytYNGKur78DtbawkA64XxFwj6bq9T1pBu2nZKi6Yvnjf/V6BOyDR0ULwhnU4IuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531666; c=relaxed/simple;
	bh=tymbMQ8Uno6kDUStFCbvA0nzFycjXciDZnhhNJqlhTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIFxAQkK5iI+y8XWqUkiCDXKpTN+XYwubeopTMBweVThEg1ynxL6ga584b3MQFaizdGbz3oI0mqtxDkdH2JBS7KQui27jup7pM81wU7VH5QutSLebckKWSYQoNm4VU0jHbWEjVIX1v4IfTu2ha7ovtqEqSjlDW5xqlWpdrECP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiQB/EJg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiQB/EJg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee2715254so30867425e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769531663; x=1770136463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYEo0AjlL7YqOGOpCwn7VL6o/6OY7T7K7Csj0LDi92U=;
        b=TiQB/EJgn4f6ZPwcU4AVW37bRr24Dp7KuO7SSkcCVreCgOtGOzayi4b62823/y9IVy
         GBbnrvJVGaaz8QRQxz+8kT6m8+ULge7YzneZPOIcnN9oPZm1EgWtZhO0s0iOLlkN2qxs
         QRHsWiJ271ciKFcB1N4t2CeHlLwreEiMGiY/10NDzFZug5EP2sKzVwhvOC9yt9fXD/t+
         CUjoDC2692tzWEKYsMVjPb0jSwZaLXpTxz4aadiwfopxcQ+VAYY7RkJ9bhU77OqX8sBX
         x6WZ6XbGWe6Omzfb5HdUwxtV1FSUGOCHdmBfgxPwm1U6Xs5rvDAv1cMpWqVhYGjEthPw
         5x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531663; x=1770136463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYEo0AjlL7YqOGOpCwn7VL6o/6OY7T7K7Csj0LDi92U=;
        b=eQL0CTcitUxjYgtPujndGKm73V0yw1Q/Wv6u2aKin8BFjftWkEbqI9Gp6hBRitqQle
         oHVvl3cpwNm62Pp/7zyT3ZDeijVFKUsTN4frKNNRi0dfKYsAVomApIfwJupDhIPicZvm
         x+WsXMBRmnyvLWjJrlCKcvmGBB0dRl8osNHq0Wdnd2MKLmquZ4RXE8/0LcuZ5x0rZASx
         CvJfJLqiMcAvsvvfdHqbVXK+CQTuVPPoym+L3x/fLNAMXrrZs8vzifsjF1M75ZYWxFIK
         zcT+gWhFBikNMh98FHdMTn4XYHVCcHu0pYQjZzfpA3kNZeP/Jwsz97vANU7QL2ciOQiW
         eNDQ==
X-Gm-Message-State: AOJu0YxKbkxGObq3itUo0zfoyeX2KaOrRgkVNMZbPBkteSzmiR+yEQuq
	ln+lp7MuG2yJMKaHjmsy1S6p+dd/VO5dfB8DJIeM/e8TWuHzK1/QdLdzzM360A==
X-Gm-Gg: AZuq6aJrCKfHytCMZTfRh7XjY+6z5jYqx3LFWXi+BrmN80FSB8YNwNhvzZVk889e1cL
	NDsG+ZhNwwO+de3Z3WJAMRwjOKyOdsMyGXCKvm0D9WAmAVheLTuVJ1kBqcm2BWTt1RVK06SBQ5D
	ZI7ki7MKOP9Ytv4xZVT56pKNH73z9Xn0ABGne2jd+5iMOZi9HkPzG8t2QDd3pzHCgOAuKb7m1Lj
	dr3nxt+MlptVPJCrWPK54kmKCKOZZqW4cOQITqNxPxwNdB9BXX8L7rtZ3rVSnu81pjsr7Jag+ER
	9CWkwlPMOOGI7poFlrT7OFVdmzXmpFFfshlHfe1K5eAertteSJIQTI2+k6ybLLnTM3K6Nj+RQDx
	McsOBqeMWlZbAHnnhRJQ/MLG++dPZMxtqCqq32SwFX5AlJML55py+IgDM81jzkpiIbg==
X-Received: by 2002:a05:600c:474c:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-48069c947b6mr29782095e9.32.1769531662614;
        Tue, 27 Jan 2026 08:34:22 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:e562])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee687sm115513465e9.5.2026.01.27.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:34:22 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	kpsingh@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] selftests/bpf: Add hexdump fallback when xxd is unavailable
Date: Tue, 27 Jan 2026 16:34:08 +0000
Message-ID: <20260127163408.1991583-1-mykyta.yatsenko5@gmail.com>
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
xxd (part of vim-common package). Add a fallback using
hexdump (available on most Unix systems) to generate equivalent C array
output when xxd is not found. The XXD variable is auto-detected at
Makefile parse time.

Fixes: b720903e2b14d ("selftests/bpf: Enable signature verification for some lskel tests")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9488d076c740..820816257590 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -31,6 +31,7 @@ SAN_CFLAGS	?=
 SAN_LDFLAGS	?= $(SAN_CFLAGS)
 RELEASE		?=
 OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
+XXD 		?= $(shell command -v xxd;)
 
 LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
@@ -722,9 +723,19 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
+ifneq ($(XXD),)
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	$(Q)ln -fs $< test_progs_verification_cert && \
-	xxd -i test_progs_verification_cert > $@
+	$(XXD) -i test_progs_verification_cert > $@
+else
+# Fallback when xxd is not available: use hexdump to generate C array
+$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
+	$(Q)ln -fs $< test_progs_verification_cert && \
+	(echo "unsigned char test_progs_verification_cert[] = {"; \
+	 hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g; $$s/,$$//'; \
+	 echo "};"; \
+	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
+endif
 
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
-- 
2.52.0

