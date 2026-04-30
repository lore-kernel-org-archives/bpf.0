Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472E421EE1
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553643; cv=none; b=cZgBVI5gJsAehSvKvGwN7iS+CmkS3vFE3U+5BlYU9957ZjOybrtk4RYDkykCoG12q4yLyVvIedNpquEHQyesjOZ78OquArwxwT9Tahezs8MuHGEzPiKhUy2b7DSsqHKj0Xv9jfGpB0RP03vkcJ62LuryEKwG0tbEXuqv3o0RpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553643; c=relaxed/simple;
	bh=/WLI+3txZprQ79s0dGyS6fODzXDjv4ern4WIbfN0S30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLqtiFKS/KTBYM71MzTF6jFcQxf7cvuePr5GkrWVZPnHaN6gQJiIsBwr186Vdq4GGzFT1oSl+tiLVght7ifeU7OiD/ZGuUY3cxS9zuGOq3Jtej3IqJD7JoEqNLZMjnu1Y9O6mAimBX131hfE/ZYcOJ6boBxjqrgBMr3QlxUTLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SEIWopPe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SEIWopPe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso7463025e9.3
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553639; x=1778158439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ae2sGx+ag5Tw9HevwoQKAokRxB+3kxP91mZ1Vz184bA=;
        b=SEIWopPejOx/o59hiw9zfAteN1HNqCiq+qV6t78uth7Txwk/uvJ4Q+oqHml99Hj5a7
         BbHsAFdpUQ+8RlXud5xuSs6uhZpg4poJc1Pj9hbreI3OGGLqyFs8KS+bgmJR36/Ulo5J
         GQcHC0rkX3waGXzKPf4uEHwbV1kjSw8uRUEBPnnvVyzxFzvef08q0bsnB6kE9qTV1LaK
         uQWPOhCNej+I7BtUJVp0oeDwH/KlFemdZtmLzbQTZ+b7CoBIOHodPHJvfLamek2kXByq
         f5k8q7OaaKJeAoOT8pACURekPvA8DyTrDv7MOYLKewWaIocalP/xBHinRPMqq6uTcm2Z
         De3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553639; x=1778158439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ae2sGx+ag5Tw9HevwoQKAokRxB+3kxP91mZ1Vz184bA=;
        b=TczLatgSed36fF7ta21vIhQ4UUa5WSWjkgeqJBaNr8FOfGuOR6N90rbfW+doLpUVu3
         N1+Iafr8WeThSeCqgM9/hvawb1DR162/fXxRemb+xpAWvCqsR10l3FZz+/Cv+bmXkKg0
         wOswtM3K0tkkTQq+fDB/hcVr9TQG7UQz8SXaa02L0WMD0dGa1e9xrKNgWudaYpWHsZ/z
         /Sc96ZTSWxUbBISbfEa4HIB7pkbyXbbRwNTgsflkoP7o4Uo+espK2d8pXrffxsewdbRa
         /dU5nunYQ+t63tdKyKPspb5s1fywdigln+V+9UlCAtdPmnWY0gbW7FB+3v4EcTDDo24L
         QPrg==
X-Gm-Message-State: AOJu0Yw54HARZIJKgXyaepvYJSy1aFMDHkAI4RNDSYZmH98Y8vDIWG1N
	dy/m2wfnQSxwnLAOl4VBHnsq8qGu7z+4jKGHgTHaUb0AwJjV9d0dJ5GCW3oZFmGqvXU=
X-Gm-Gg: AeBDies8WHV14V2XabOgB9IaDakW/LDbwAB+478zS4K23u1Are6gZx5ur/wpY4wbveU
	nKLWJmOjGp7ly5QiH0fTZ/ylVMGPTncJiGaCUwFe/lOHLHN3Mkcy8vnd6HDdmGRFLPM8ZcKOoNj
	Lx2oKeoLfexm53DW6+6vW3p3EFwAMvk2O3T/HCa3k8YMvWtUaHaemGmkmjKrzJilX4J1jzEq+b2
	VRcFJXreiyRCxS8cDnhLiMzRqoCIE7ClrGnjvWnJwUq47u4GzVFWjcKm80668InONOa2Sn5w6dO
	QrVdeHmqRrJHpCzK1ZfRSZ6PvjtoHGK2iaKz6hfjvWyU20oiB/S3/0WWp8JnAYdNO/zdhsKG6ym
	+F9jGhfawtE2nsTOsjjakhSHVyGy5Wu/70saWL+nQEVMq08iEzUr6GUtEayRy81FFTxcyqKaB0G
	9PT+KGP2GSmPUAAO5LwqwP6ECI
X-Received: by 2002:a05:600c:4fc8:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48a84457a98mr47364015e9.29.1777553638716;
        Thu, 30 Apr 2026 05:53:58 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d391sm8900499eec.6.2026.04.30.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:57 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:23 -0300
Subject: [PATCH bpf-next v10 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-11-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/WLI+3txZprQ79s0dGyS6fODzXDjv4ern4WIbfN0S30=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCAb6pv/obNOHZMhZ1ZDm+Ivl91Hb7zdkDOLdjsjGtiOVKWzQESTHQTB2DY0VepKMCmCpT9ihEv
 YIMmXBDTR5gQ=
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
index 0559742137e3..459008486b89 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1023,12 +1023,23 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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
2.54.0

