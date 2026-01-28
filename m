Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71583155A5D
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627159; cv=none; b=GHaUQXBqz1eB9CVQmGw+qEn+pKoon8/xsSSKLQ6t6P29txOuYQDbHWHArpv1FZFex9AYeRJmZ49eCdW/nSgK9IfnCYqjKQ4/r9Kq1dLLgiVaNUzJ+Ssd9qlLE8rGq0qJD2q/JBsp0HzPEMUtlSWEfrwNFzYq3d9vLvS+n2svJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627159; c=relaxed/simple;
	bh=10WvIMs4qilNWXFFA7Hd0GcumtOOS0qIwm/JfVJ+bV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OR02Y+Vy4HpvkoevsCM67rVWN1sSxcWpbNZ0DERi9jhbu4X5DNAl/nDP5cL6HPVED4doUBKMLX5e/NBWXPdidcMoh/CNimkg27/08s/PRxMnwvDH5NG50aWmli8ZlDd2UKiqX2GuchWNfbQVJjZtaKk5v0+ijVNI5XIhvbTINro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhcX0hK3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhcX0hK3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso1819075e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769627157; x=1770231957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olyOkzWsmiHrpXBIg8l71W8Ioi+kPoRgo/TkeEywMrU=;
        b=BhcX0hK3odurYS7oqsRSJMBy2oV/JhgwDaqmaD+e8EwderhdbWXLsI3oxb0qzNUF9K
         huOGXcEeC9efevoh51kw/Ovs6PKkhsQ1YqBoNMh4NYYtmGEolLlEqYYEzVDEWWWG6hqj
         KVDefMInnewiVigM7y9H2nBpeyNdtGZQPe9Y6MimFd3fnBeRnKb9zHs55TpuktBaHnmw
         INOH8+lfHA3Q1x3KS5lwsfb2KhPYeF3Ui81sl1juKEHWdR8AUjzRzNwn2ltWYMfAsiDa
         UxAFojLqxuruP6/X4Q0qJbDrJgCwB2NUdhTm95Mm7nETRCbysioeueGuTScrsy0ggw/8
         1/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627157; x=1770231957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olyOkzWsmiHrpXBIg8l71W8Ioi+kPoRgo/TkeEywMrU=;
        b=Cj31gDbbA4Tvlsf0zK1kXCGcUFSnp3Snr3q2FGLvOK/27EAdc7cI62HUYnKQwiW6BE
         VqcaMh+YAGxKC9Gq+5WzWerp8HlMIc4P4cyDuYZJaDS3yfPiyaSLHMpHscOdiwvMJ15T
         92j7ebURNiuAKE2/QFzPu2lCFfu6Iu+nivzpvTaFGFPSfeIJmTxw6dBYqFKDmrszhN3O
         GB0rfIJLx1Qhmv9Ld+qZk4twBrrFzdhA1M7aw4OGwi6GelX3hGrmsWA1q7HsTQ+v2XJw
         cw9pdpsoxaeWgu11NpAkRkYHd5TVQ88cljdYnpeXgo8Ov7fmAuE45KChM7TB9idAJ4Rf
         rCuQ==
X-Gm-Message-State: AOJu0YzsjW+rQt7KbDGo8d6Ro+ZnmapehDflS8o3vNC8Hrbpe426TDU6
	dhAwLb666uoh8MXC+J3frIMaKsL3Qh1Wmn8VQ+uSg25dJS3e3D9ZZiTU8f1D+zV5
X-Gm-Gg: AZuq6aL3jRQ1NiiAJKSzm7HxH9uzZuS9LyaIvKoU+2GdycZ+EXJfjq1M3PFB09skAwi
	Y8ui49VEybMCTKGaYJBsRWx8tf3G38Amjp1xe5I5VrPPsDbR56rQmADwSEoIkIqKwdciyDKub4G
	AAbAYMuVpc++iM/PD6B8n7pSPXIt/tznCDen1DudXIP0/4nWhF9lLQ14TrHu39tepd5HIzZPKRY
	heYW3M9HaA5W9MvToGh56Ej2LGkWkn6VB7rn/n65XYt58skrRbFMxWjbgIkokNxq1QZ4//cKpMb
	cznXQCIS1Y7xk5RbXyBOeE0e8K0K4A4+3fnvpLtIMZ/liFlInsFnG0V6P8M1x9yw56onLAKobzs
	QK9SoSFzyWDzSDmUbIAp8PjKOvw1ZxxjPYidfHDfVqdRmvfouAYQtEvX/1MYtoqcgBtcJl8Mvxg
	2TPEM8tw==
X-Received: by 2002:a05:600c:620a:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-48069c54113mr78595245e9.23.1769627156568;
        Wed, 28 Jan 2026 11:05:56 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:f1cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm8478482f8f.34.2026.01.28.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 11:05:55 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	alan.maguire@oracle.com,
	kpsingh@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3] selftests/bpf: Remove xxd util dependency
Date: Wed, 28 Jan 2026 19:05:51 +0000
Message-ID: <20260128190552.242335-1-mykyta.yatsenko5@gmail.com>
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

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/.gitignore |  1 -
 tools/testing/selftests/bpf/Makefile   | 10 ++++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b8bf51b7a0b0..a3ea98211ea6 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -23,7 +23,6 @@ test_tcpnotify_user
 test_libbpf
 xdping
 test_cpp
-test_progs_verification_cert
 *.d
 *.subskel.h
 *.skel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2c2f68a171ed..c6bf4dfb1495 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -720,9 +720,12 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
+# Generates a header with C array declaration, containing test_progs_verification_cert bytes
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
-	$(Q)ln -fs $< test_progs_verification_cert && \
-	xxd -i test_progs_verification_cert > $@
+	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
+	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
+	 echo "};"; \
+	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
@@ -898,8 +901,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 			       *.BTF *.BTF_ids *.BTF.base		\
 			       no_alu32 cpuv4 bpf_gcc			\
 			       liburandom_read.so)			\
-	$(OUTPUT)/FEATURE-DUMP.selftests				\
-	test_progs_verification_cert
+	$(OUTPUT)/FEATURE-DUMP.selftests
 
 .PHONY: docs docs-clean
 
-- 
2.52.0

