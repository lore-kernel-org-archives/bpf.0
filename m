Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6053ED12B
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405440; cv=none; b=jsir88UWmxg0wcTkwaQm5XONckrC5Uel7nv9E3Pi0ELzIfxZfEzYbohwjFtSVZ+0VLihEerky/ajc5w7wpFzDbCo/viTTo0AQzliRviwBoplgShOsRJE7MOVJWDYUf0SKlEYzcMDXDV3CikwiXVD/R/BUQcPdSWunS9Nxu1EqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405440; c=relaxed/simple;
	bh=mKZfX+j1RnWBS8BtAxVShF9J7noeivYXX8VjI5ABuJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tq8AqENdI8bTDR7OWDt8yherUBJgeOSKkGr7AhLcys0fn3OSAlHvhpNrF0tk3j20ehy2lefeaYtgohx1YiCb77OmfXAqc1iQGnS4A0fX0q3ipW/ozFXJyA3x3zOupfRM/rSJZr87xdV3nneLMs9itqKPdgU/cn+dCBGGNdDmZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cHAp6zce; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cHAp6zce"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so13036720a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405436; x=1781010236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOH7mEsh3HBCYOuvtZq+OMq1SM5+4hZbsWOCsOVaeQU=;
        b=cHAp6zce6bskWM1vGbaoSPjAngW9Y0dfxW0rYv79qN6kucv3S3PAADtl9EPVQNz57P
         +e5mdymZO3T4UAmSTt4us01IkK2VKD77jxqOsD/+9hg/lAxTLhZ4DyO/XouoGZ+6K3ra
         Uf02SA0hv9GYycldcWfFBxukRbGI2GyxFiUkLzl8vpKs3+7j5qIZ5nNsBzdezWSSiKTs
         EMr29lmpmTsidg6/+d6VAI9oSgthfHANIjsLT9nXQ5UUdUG8pxPANudkvEEr/57NljOz
         rsuJYScx64oKUUK14sZEZ4R5BF/INGGjWm4jJ6ffVH5tQu/GnG3wNd3GCsWIJzGLq04s
         fq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405436; x=1781010236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MOH7mEsh3HBCYOuvtZq+OMq1SM5+4hZbsWOCsOVaeQU=;
        b=GR2yKXBzZHwlh+hJ9uQ7LjKO6Sc30aiCg8i9dQRscnxcJqnncJ+N+5IoQw7/u/IYKn
         bqGGM6s4fjLWHEoBZB8QNMyw1uxHZi/8kK2rKD9LUDfyOdu5TB5aFOfy/RFeYdvHbPFE
         bB1I1FMCETnSIgZEF+gLitK7dZT5JNaExeypMKx3wo9uhlhCf0Q6IbiLUlDNRXyTxg+q
         zZ1p9ep+ixnh5ia8fyzMlrTbJPjUukWDm7GVqQrrMH0bYvfYDihOyqbvQdrAm2jw3d6g
         Se+V50V5DrJSqJFJdj9QkbxbD8JbGvGKDfcY4tpXgFZR/5NXlDrvaNpPr9Lb+PU6PMZw
         r+fw==
X-Gm-Message-State: AOJu0YxHTcHPhyC69oofYXGXwLk8bQNYxQIcl/jk4z/RqncUbA80RzWH
	a2mhxKE0eCAG123ERRtluKx8s5SRp1O2cbjgqliW0lWhH50V3pByoNORJGj/Xq+I3aA=
X-Gm-Gg: Acq92OEH8Huu1+EnEtQlayH8HtoXfniQQ/qQbHABB/chb9ADG3/vCzqqCImVijdsgrC
	iFciZTPi22dJC/8nZ85wU7Zb6b8zaAFxpeGcfd6/CA7Z8NvkSg2NTzBpy19R0M8XxW86/AX3wqf
	L6tUHxylqhkaaSGf4S6tohJG47FuNOK/LY9j1y75elYqG2Zne+MO8GVfWAPUSrirfub9R5qyaZU
	0XbNpcnLIMvIT6ZAzOMct2L3zBXo7tD20NyBS1VV8iI0N3XYvPY02+UDoFyaaMhCfq7cq9LkaCG
	ZPfgnm7AZO5NPncDs3i8zrLuy50Ez/1rnS9uUWOQzWRYJ6HlTpyHO5uFRxUXPOMvZgbPJkrreGM
	EWVqr4oMKVz8gQe4ZxLfcZ0odR/rXM1L+lRnpIlsVP5gb36O2BNHmPNC5C1gShK+HmF7aJlGNBZ
	wHav+oGspZonh1CfHOhLRJbA==
X-Received: by 2002:a17:907:970a:b0:beb:c3a7:9cd with SMTP id a640c23a62f3a-bebc3a70a4fmr770255666b.8.1780405435805;
        Tue, 02 Jun 2026 06:03:55 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bed25666221sm264314866b.29.2026.06.02.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:55 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:03:00 -0300
Subject: [PATCH bpf-next RESEND v12 11/11] selftests/bpf: Tolerate missing
 files during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-11-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=mKZfX+j1RnWBS8BtAxVShF9J7noeivYXX8VjI5ABuJY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXuExXIll6hlcO2yxcYh0XbMjwS1dF6WLug0UL1JK/caPPPoTV6qpSwC6lK+5A0Amw2buD2QyI
 1PSwau3c0eAs=
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
index 4eebc15670e3..42d9cf848b25 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1029,12 +1029,23 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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

