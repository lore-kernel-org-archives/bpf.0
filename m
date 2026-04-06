Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85516393DF9
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499745; cv=none; b=tJNmZTEhre/lgzzTU1spUJXbCIUT68CHJrUtSw4/UgW2AHc8rKuTFGAzqVXIFKZiXAKoV8E30P24hAwFCcEfjCmDBnqnCF7b8prdFztnjQJJmJrrJi04445iWtFljn+vp9KgEg9VU1+VJfWW8+Ji5K9TexOPwgM95AnHiUH654Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499745; c=relaxed/simple;
	bh=UdmIG5ZScOMurXbOdsM3+xZHzE6mxf0WBHcm9S4szVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2tRfYnn9yc0urrNX+/+7CWGKxgnys+i0KnCPCAU33lsvqx+dLsg1G8MKCaRwMeFuNyohfDa1rKxGRrRcdukYODUHezoqga/Rt8a7XrbdjA8uILZ1+b3M3XHt9quw1oNm8ntJnnBwq2TO+GuMvfP44oh+5X8i8YEtdTsqjwpOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J+Jo8Oaj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J+Jo8Oaj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso37815495e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499743; x=1776104543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4g6ZnBzeP1JTZyYPvWQnENXpCsTRTtKLoMuVgANOhM=;
        b=J+Jo8Oajp0n0qUMnMxg79STdVU7kbwm15Pn0UudRKhEzgPZazn87GkkcnW+6emGPal
         q6/2GcTb4ewVBMgNeASzrsnovVJdvBjYPG2aeCcsvow3QMlYI1Rr3i24f/5692mOlPCn
         ms4hMqoWdzyPhHr2Wgfo7dbjycfeYCXeriMD7+s9s+5hnJ9rhmenSQfSuzG4fKHFIr4D
         mFnZY4bn5yX+Hllxk+uOS67rorJmXTkvcVYMpsGAQiRgTxtSDAqUZ6aI28U1CIbcl9O7
         8pPJvhrkl2pqIkMa0FTAlWm9E2VmIH2AhBpx6oevs7MBqniv+rjkRvYYFMSgz+qD0Z4/
         zEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499743; x=1776104543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s4g6ZnBzeP1JTZyYPvWQnENXpCsTRTtKLoMuVgANOhM=;
        b=n0TFsZJdMGsYBkQm2RE8sSFYy4iZRDyAj5xzT4LHBKz/eDuJAwwHywybi2S5Vhy4zr
         +Kc8VotdL9lEA4m8xpEN64S/iz9Hx7wG9j+pSaS771Vd61NQaRlM7VL4QDVnnYuX8l0n
         AIowSRcB6mNtKdQYhqNLXyTXxEKzU1DFsZ9ifAbqn74C2OgkF1B9xyaw3ATpjHkPoEkO
         lIzTxovsjBVbwC1nm7Z+wDKWXo4SDrBbtUdYoqhZawuWURnQZVXJOQAcWv3ALLd+gVEE
         mDamheuszv+Z4UzZXb/Ur6EYQg1e77uiGt0sbGDhLPonH3V67aTLfOATo/BOeis1jOvX
         oHiw==
X-Gm-Message-State: AOJu0YxDqecSmfGiD8n5mOedi4uLtPc7H4Sxy8f6ZZzTEU4dL3sF3fcB
	Dn/J4DZUtz/c88esbovqDUWqWF4UeZaZ8QA84w4AayzvNxahWtmDHvpDx7nK69/G7ag=
X-Gm-Gg: AeBDiesHCyUuoLncmQtRcK63brDKxP6le945M+pxyRnieP1h6NZN/BtWrIQUT7yXrAy
	Rg5y2mQcKfCWO38SWuBlnwlimaWPcvGcOiSevPpnmi0xaArzE1IRAWYuzm5mPYwvzXN2v50kBRX
	iATONrg9f+7pdJ1o8q9+d9993AdnPvhi/hEwFn3IrZGGqxrcd1F+FM5g+nitvvCk9UEPgNzohd3
	EkKdUMoqVRult5i7vL/sZnQiAJlsr1ed9cxS7KS8Anjkm6UlkeGnNV3djKdndddsQPI3XAii+oz
	yqWuoTmEcJi7zQ9Bs81BoiwKdKSbAqwjaiC+RMn12y15+hFZOjCK3WZxNn+eJ1doDEctzOCgwsq
	+h5+n/PI8TRxOrcgUUBXWBZRM6Wga0XfcgvYWjmYOz2GbrSZcNUw+AiXFIfzSn138hwGVmci99J
	zufTHa/L7wMkeq
X-Received: by 2002:a05:600c:1381:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-488996afdaemr206141365e9.6.1775499742932;
        Mon, 06 Apr 2026 11:22:22 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb84c289sm14052881241.4.2026.04.06.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:22 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:13 -0300
Subject: [PATCH v4 01/10] selftests/bpf: Fix test_kmods KDIR to honor O=
 and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-1-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
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
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=2171;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=UdmIG5ZScOMurXbOdsM3+xZHzE6mxf0WBHcm9S4szVc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPsFC+mekAxUuFuHrSS3/+5pngEcDl6zjD77+ez7jkuo+XJwp6K09aYbo1XfJInLFFrJH14hjkz
 jTijNopyyAwc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O= and KBUILD_OUTPUT. Module objects were therefore placed
inside the source tree rather than the designated build output directory.
On distro kernels where the source tree has not been built, the Makefile
had no fallback and would fail unconditionally.

When O= or KBUILD_OUTPUT is set, pass it through to the kernel module
build so module artifacts land in the correct output tree. Fall back to
/lib/modules/$(uname -r)/build when neither an explicit build directory
nor an in-tree Module.symvers is present. Guard both all and clean
against a missing KDIR so the step is silently skipped rather than
fatal.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_kmods/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..b4f86f151a09 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,7 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+KMOD_O := $(or $(O),$(KBUILD_OUTPUT))
+KDIR ?= $(if $(KMOD_O),$(SRCTREE_KDIR),$(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR),/lib/modules/$(shell uname -r)/build))
 
 ifeq ($(V),1)
 Q =
@@ -14,8 +16,15 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
 
+# Ensure KDIR exists, otherwise skip module build and clean.
 all:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+endif
 
 clean:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.53.0

