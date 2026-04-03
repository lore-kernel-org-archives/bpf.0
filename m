Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5D3CCA1B
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228387; cv=none; b=jRNjeA+ty8j/mwZLeRnXvUqthuKGTdHDpquQKb3k+Y3d5SNmkoZcq5w4NAmUGgtuV5zHuYEJLj5x7o/4mNUg67kvW4M2sPFb9gZP4/VIgmP7tbX1grLReGC6lEDdOKkLZ+eeD+lAkE0bOCwBqqMPgtuRxrZPgP158eyPWNmMDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228387; c=relaxed/simple;
	bh=VgaZGJgNoIf6wfVc9SmL/U8SxxfQLWizje2Jxoqjl4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihnf2n/aHa6rf/9yPS4TdkZbJJoaFF8uy94oYgHfyR9M6PWf/Mg34LwRBbW2jvQimnorwsfokQsZme5LuyQkEZ+WaAy4iMDP3zMyCZ3qpCp/dwuo3ue5f/5mzdWlQjCh4IKLF4Aw+Cmj0PhGN/t4tEb2eYgBTFGinaNcf+5KxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IGePjyxv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IGePjyxv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486507134e4so28536995e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228384; x=1775833184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5ke/PdA8QzVJR7Spl86h1CIBtkkSiz3t60hf2vQo38=;
        b=IGePjyxvBRQb1B/xTLFB7ActDYPFyQDs815ncYUpnmikOzSXpjoHZNoGTCSAyhly5v
         VAjL/Vf/UlOtcDbPFNRXOSMvQHUclGGxd27FY5T9J8PHa6SUR0Ti9ZbXkt2D7CDTSEtW
         NS5eVPwp3gzlGJgNWTbLfmHu1f6/lo0FFYhPilm8BKWLsZkIhsxf+RxH8sx0JPPNPZmJ
         9t3Io7pd+U9dBdYuiL9G9BpFHShSVFJTaIMH83P//cRy/dqytXyDylKsHLLURphbobIy
         oYsNvAx71Anh+w0jgoY2YfE7dQD8F/r5UDa9ZNBK+KChff2A1ez7fSDSX180Od4a+2u/
         E7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228384; x=1775833184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o5ke/PdA8QzVJR7Spl86h1CIBtkkSiz3t60hf2vQo38=;
        b=GHicp7Uy/46UiDMBi4NII0tk2c++cOnLBFIggiB6El+FQx3j30KoQ9aywFPrZbZVOk
         uI1+PdqhQ8f7bmVfj8Q51VGWST6hj+DPGcqejPxlima0JkjQG2f9mp4QrLDrmp5XK5ZT
         VnLPTNpqyhrxLG0hKXzs7ntsRo3xRD0g3MYwoHdOvVJvUkGdKLR0EsCbQy7vLfal8B1n
         3gVy/JWQVaBK0zPSrKjqUPW4YqjMfwVykJLLfMnrhC7p5EMd9zYMcOD0V2qguCR/uxMt
         U6wkiMqPpc789S1BqayImlBawSX9ZEBAa3CoJwC9NB/qbLdgdAt2nEWJyBzTgGI61xGh
         0Fnw==
X-Gm-Message-State: AOJu0YwAnwXSH1kOKlZ9TCrg84luMkUvqPxjUfMdB14EqC1nEfDCgitq
	4KmjKu8KZGgRQYY/V/ltbYjYdNWdq3SwzaGA4Kwf61RvW6mLaO/WAhARqyopvfZL1ZY=
X-Gm-Gg: ATEYQzxwKiX46/b+E6uSd/GlObEUzOl8U4qa0+xZV+ZNTy9yN+Ha7d8Xs3aTLi5XHjf
	JO3IqEm7Gffm+YdDn3CJKIVSqekjYNUGNml2DAjyOGUFNzE3jH1m2EV4y3ZTNEtS6eEpi7b2rxQ
	my9MjR0N4ie08ShUebEB9UgAjxRni1gYYPv2RE+rd4szC+OGddPRSDlKCyszvaPXrhfbMNb3JXI
	ccjkwSntfuZR18FliGOcGV0gNYge6V4zUmGf8/6AvmYWr//meEXq5kLN4sFlVXgEoR9oFC+iJym
	OgSNEva5kAzk3XO3b5hpXw5KrHUnbd7+5HnZXBTg4v2ef9PC+XDOVrfExVmtyRQr8CixYVpZ+Ms
	5hpy4Lo4iSRuKhKiRZ38Fi3CFnRb8gF5OUKi3666MZ2jqbS0HPP53SwfmUV7vkiR39mgq7O2Vcj
	GWTDMMdjR9
X-Received: by 2002:a05:600c:4688:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-488997154femr50823345e9.3.1775228384139;
        Fri, 03 Apr 2026 07:59:44 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9bc41sm6878642e0c.11.2026.04.03.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:43 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:59:03 -0300
Subject: [PATCH v2 10/10] selftests/bpf: Tolerate missing files during
 install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-10-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1301;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=VgaZGJgNoIf6wfVc9SmL/U8SxxfQLWizje2Jxoqjl4s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMrZ54BOOJqDcZdAFl3NiwWeFS+siYvHChakdRJTLU+EGvle5lkem4T3+OqPl66zcPPffeR+n5j
 kC40uYAgbyw8=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

With partial builds, some TEST_GEN_FILES entries can be absent at install
time. rsync treats missing source arguments as fatal and aborts kselftest
installation.

Override INSTALL_SINGLE_RULE in selftests/bpf to use --ignore-missing-args,
while keeping the existing bpf-specific INSTALL_RULE extension logic.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6c4f85459486..d90e0dd9d0e3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -953,6 +953,13 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
 
+# Some generated files might be absent when only a subset of BPF objects
+# could be built. Tell rsync to ignore missing source arguments.
+override define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)

-- 
2.53.0

