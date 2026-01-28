Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33F320CCC
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618543; cv=none; b=j7Yk/V09zpiPqK6NuStOlEaqcZZ1AIM7mTlgbrajZk7VRa5Gmh36BeowqfS7lKyFqydr52bq+LN9qO/1CBB1Kkv9HyxyvbiYnuASF9KqBPlksbECxsDAN95oLPYB/J4k7H1kEHow4p4PVbg+LLhEnAYdPTa1k6M+KrV7uMloyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618543; c=relaxed/simple;
	bh=G9mAU9NeH4kiybuLGpjAZZ81J/KmwmZiRcmYOsaVn/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlXT1iMZONsqB326cU6VMlcZO6t6Obc90jBd3A6vb1gGECbKs7hW+AwGKXFBt9hMVWR1GJSwE+7a+MkhOlmGd+4X38LjeyZOJKdYAkZlOTvD1hacfQvs2yvHKOVNStheW39Vdc1ZJb3OId4Wi27992i9Kjo2Nsz10UIIv1SvX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5WxBqZt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5WxBqZt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so293225e9.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769618539; x=1770223339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8TEFoJ6bWA09XKx18K4nSF7Xu2yJGPF+cPorxVBLm0=;
        b=B5WxBqZttwQkKKv/EQItqJ1hg8LVKZWvuKwY9YFaY3hDxtbweo8NxKkma5+NKp9Y8d
         uJCOnlY/jrtA2AwxfJl13uidEhG0fhwqJezYtiV+fe5ykan7ZBqg3av5ZBbmHzEjHAzf
         bkw0OyikHhuG5KG2MslY7sCLoe3dPfKvbaZO6LVaaLWicFcy8ypBf7+67Agtr3kb1tcm
         rAlFebmVN7PoU9zTYT9fpPHF8j9cIhcuzr6+LhlRC5048CGX614uQbUHDzuINZVmW+0x
         ZTuHMNi2oLvlmQqwLU4+0s6JRTAbJXPnjAxi1zNVZzDLhlFNQi1xQiA+HimNqhzvEaZM
         iJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769618539; x=1770223339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8TEFoJ6bWA09XKx18K4nSF7Xu2yJGPF+cPorxVBLm0=;
        b=BgfdL6fIA3aCUIZ22gf9QGfAwSykbQvXryNWMg4Ns0TXRLkrEB5H50Si3Hj0Lca+gd
         RsKhTQ3JvlMtVCUjaZDXUcf1w++PpJH3jp2NSb0nJoQKXG665n+pIVGbkmqnwZRkVDNS
         qPJG+twSCCpB5jYV/t0AQ4cx4tqjT+02M5y5mh8DqVXrPinwAhlnkyzf0P1ct0/RBYEW
         Jb7/7UleIrx5Y8tBJ9H2+PRil+QNNOBL9HQDjLLCjscwzzh1ZWEDljV6XeslsLBkyE52
         ofAbdh/yOq24MZ3F7qOQrdw8PRNXrxK3Zm4Dult1DmOIYOYo9jTrvq6T2YDiu5BgBhge
         q+Kg==
X-Gm-Message-State: AOJu0Yz49odZazPjPLcU9Yzg6pZf/cembKUeHJ7NvT1fPVAsKuuIdZKk
	To+wuAH3LYgDRiaNWT2nQha+uqCe0foQEt5TaaO7kzvzS8CIGDjK2GI0tBQogT7W
X-Gm-Gg: AZuq6aI+hMppGcRLd18nJucqWkvu26auIV0qOOsLFRld/8syvMx4MwJcsuBG72G4/SU
	yAUZ64P2EnpzHq334PG99O0Na94jGr3nomAadPr+jajpY+pfDobByA916Jue9mmbknHCBgWYSLY
	kMI5fdKR0SgXYnjtp0D4sxVAOnfmMEYKFyScAT3jmTSQU/WZnFU4S6/h+RlFV0z38WkzqRBPHpq
	JDGfEpXi0P03IjSKNFXOCF41x05Iq8fZCVkaKLn5xq9rA+L4dLyFPiHGY6WOF8/IsN+J1mTaC63
	dKCQ/fEX8H2Ytl13Q1PPIswOQHMq9furRWy7CxSjsH4H6xSbYXmPeuQc1vBVemKw3tOeQy5YCd7
	ElYjv7QmhR56siDTr8qekiuKTXUcvckK2CM4+F5hqZUz5JxpgBFHpD75ocQKhxF/ewdAVt48=
X-Received: by 2002:a05:600c:35d1:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-48069c6355emr104470505e9.35.1769618539151;
        Wed, 28 Jan 2026 08:42:19 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:f1cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d984b21sm6334275e9.2.2026.01.28.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:42:18 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] bpftool: Allow explicitly skip llvm dependency
Date: Wed, 28 Jan 2026 16:42:14 +0000
Message-ID: <20260128164214.149291-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF selftests depend on the bpftool. In some environments we may link
bpftool to llvm dynamically and then try to run somewhere where llvm
library is not available.
It's simpler to avoid llvm linking altogether in those cases, this
change allows to do it.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Makefile           | 12 ++++++++++--
 tools/testing/selftests/bpf/Makefile |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 5442073a2e42..7ccdd2acf65e 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -97,6 +97,11 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 
+# Set SKIP_LLVM=1 to build bpftool without LLVM dependency. When set,
+# bpftool will fall back to libbfd for JIT disassembly (if available),
+# or build without disassembly support.
+SKIP_LLVM ?= 0
+
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -149,8 +154,11 @@ all: $(OUTPUT)bpftool
 
 SRCS := $(wildcard *.c)
 
-ifeq ($(feature-llvm),1)
-  # If LLVM is available, use it for JIT disassembly
+ifneq ($(feature-llvm),1) # Force SKIP_LLVM if LLVM is not available
+  SKIP_LLVM := 1
+endif
+
+ifneq ($(SKIP_LLVM),1)
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2c2f68a171ed..e354c7302b25 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -331,6 +331,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
+		    SKIP_LLVM=$(SKIP_LLVM)				       \
 		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
 
 ifneq ($(CROSS_COMPILE),)
@@ -343,6 +344,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
+		    SKIP_LLVM=$(SKIP_LLVM)					\
 		    prefix= DESTDIR=$(SCRATCH_DIR)/ install-bin
 endif
 
-- 
2.52.0

