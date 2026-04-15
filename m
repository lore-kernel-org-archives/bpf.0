Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B35386571
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286814; cv=none; b=V8d4bb1sMi93wePW127jdxZlG3rIgCD++H7TeKZ4SsSflwlo6P2lOqpWkBbAiSFgWnMlNdUJM2gXa9LBfJTz1lzrDFZGd//NHHEFOxdHPfQY6bm6vRI8kubTe2DZvnxP7QKrfEtiPSndZID1TN2FKNh0uwM2YQICWZUToM4LoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286814; c=relaxed/simple;
	bh=kCNYcmfNgjCtuuNJpdXVk9xztupOqrlgLYIOM5DXg/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBG+jnuMWpaxkyCdJEGwSjPWDDGfZ0UfZxP4RwNPteaoFPlyKRoNBtVrPjATNlTyEYO24zV6KAR1pClMcny9amyrmY83egU4VFsJc1z2lnsD4DEKZdkaaOxO6C3P92j61pyD5ZqgFKRhz1Rj8BKxvMiwI01JRxZkcMrqlAMlQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RFduFoqM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RFduFoqM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso88102225e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286811; x=1776891611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QarwDcfAAe06CKb3JY8/kgN2OyTVrb9EUoTBmrcnojU=;
        b=RFduFoqMvvvhOqgmmufpKlZw5R3+T/9440CuubpYvkBfWb0CFPVtxDCdEsDBdsoFsG
         QR039W0vh3ovdYwq30xkoCix1bJHA/w90fQCRGf4exc1ZdA+58iRrw++1vS6wy+ymC+W
         hB6ISE9GgOTRNSedbgMv6IGCnKhc8yxK205kCKPZzjGjP5VixLpTQP75YQ/d46VCO8JF
         kkdYfV0HTPzbvs8xaXjUnNn62QqXppPpsqhuwmqkErQQj24Fy+UpCrFxgKAHkK/5eoMU
         Nm46OuDGSUNj6QczZIMUSQZVG215kJz4yDpLbgxd3eD53/VTPJ4+FTz50CeLNwApGe2j
         5SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286811; x=1776891611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QarwDcfAAe06CKb3JY8/kgN2OyTVrb9EUoTBmrcnojU=;
        b=U6N8L89yHoZVEGhlAqjBr3xw0S4kkHPk63FA8o26KUzHUwXTeJdT5RXgw4zR/hLCX8
         7uXrPnUdqiUfyn0FqnG06wsqfd3RJQdfJ/1/k8v1IdN/n1Pv7TDjTNhI+5hWPIkhwAKg
         czGVpVzam15Vq+XgTD+JCb/lxQBde582tbHna2qP55t4z+0Oq0fsaKL9k5NMnPeEsgPE
         rOCAHroejmLqvl65aXGkqXbeUkTw55QBTkCnYwnmvE0BqT5M/1DERjTfpgTkE/yf5lvy
         ZYuL0P1Smf7jEVCldPhK5JPgcqy3BO8Oiv4lMwvII85ou4PI/v9AYeZCo9I4zPTGnV1r
         0Ggw==
X-Gm-Message-State: AOJu0YyWIrdMgHSn4fhlyIY2s8VFstgr8VnwBBIcenq5eJPTB3qlxSVi
	b/EAAkdGGBVVi3L1aA493SrXnBEWAfTYqd9hTCapM7DKUh0pVV2L2BsfwdGMjWajEzY=
X-Gm-Gg: AeBDievyzrwue3l7yv28Z4uWzC+jIbPlzpUOlSGtcJdXmyxml9vlfihNTT7M+S/wg7y
	NvJBQckanqbaZCGKYAePC8mEBUiX4U3myGo7f/VztxYZmbXXcHBRNQcX6KeHAZRa3DtMWc0X/ps
	n3lhabRFx1qeI2ZqpymVG9xT6C6b2YG3yGK+yYTKx/evcc59BB2uTfpPmoJsIQnngtr9i0upOxP
	tovisZkgXXdz86icOinWJuzFtS8Gw/TUy4broln0Y0fs2FRAeA+MZ4K7sY1uT9xHtnfrOcy8WBX
	jF+kg2VzEIn7vJh1SL3QC6Im2pZhaKAXT6J8cfQlrqUFIqY6y6N7VbvQxQ7V5ti4TxTY94tP+ic
	zcmChC5a6zey/7wilwgpGvXSa53HuzpYxEQuP66P4ela9+rGAdfycs14+HTbEnD/FaSbFP/KbGa
	hC7FX7ZdOVdzA=
X-Received: by 2002:a05:600c:474c:b0:487:219e:42d with SMTP id 5b1f17b1804b1-488d67e72b7mr297880475e9.11.1776286811412;
        Wed, 15 Apr 2026 14:00:11 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e61cd32sm3511675c88.3.2026.04.15.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:00:10 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:29 -0300
Subject: [PATCH bpf-next v5 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-11-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286765; l=2151;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=kCNYcmfNgjCtuuNJpdXVk9xztupOqrlgLYIOM5DXg/U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO52q6ndPD+Zuqj9KzWJiSAHcc5GMQVf/6C90MqwRBbzhXDP7EeLoTE9HyFcc5JRBU9VIP7yPpd
 2CYO84FdEcwc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

With partial builds, some TEST_GEN_FILES entries can be absent at install
time. rsync treats missing source arguments as fatal and aborts kselftest
installation.

Override INSTALL_SINGLE_RULE in selftests/bpf to use --ignore-missing-args,
while keeping the existing bpf-specific INSTALL_RULE extension logic. Also
add --ignore-missing-args to the TEST_INST_SUBDIRS rsync loop so that
subdirectories with no .bpf.o files (e.g. when a test runner flavor was
skipped) do not abort installation.

Note that the INSTALL_SINGLE_RULE override applies globally to all file
categories including static source files (TEST_PROGS, TEST_FILES). These
are version-controlled and should always be present, so the practical risk
is negligible.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 163552458327..1f4a8e1f7932 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -969,11 +969,22 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
 
+# When permissive, tell rsync to ignore missing source arguments so that
+# partial builds do not abort installation.
+ifneq ($(PERMISSIVE),)
+override define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+endif
+
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	@for DIR in $(TEST_INST_SUBDIRS); do		  \
-		mkdir -p $(INSTALL_PATH)/$$DIR;   \
-		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	@for DIR in $(TEST_INST_SUBDIRS); do				  \
+		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
+		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
+			$(OUTPUT)/$$DIR/*.bpf.o				  \
+			$(INSTALL_PATH)/$$DIR;				  \
 	done
 endef

-- 
2.53.0

