Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2547D952
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060176; cv=none; b=H/Nn5UyjLHN6TBnJgItnOuZ1/HYr2PizFyWiMp1P5qtSdKf0kA6ADmVkDl/VNqWJ+UmctEOhzXb/KlOhtviPuCBLIsnZE8CM+/6APdUSq3fcxwu/9DVtPfLPMim61f+aYHa/82w2zT3xj25f/WaaOK1ZX1iTiahlACtGAqNdghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060176; c=relaxed/simple;
	bh=yVagyWKvjPbOTMFBAGYFdTOqwRpe3t1YiqqD3RZmsw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUC1WRlOBxvkcO736CznlnieZAyiSoo0nxrlSM63ptmJs0WOeE7FkDUvAFm9PJbj86nQcgL44WM8UV0mE520ZIEfJxVvsrtpFoskFJJzPiira9I2fstj0VUykNe7hoEOB5PX8ftOljE1Bblh5TuTsYkxOIuusaF1MJc+A6XacFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OyIRog/E; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OyIRog/E"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so1870070a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060170; x=1775664970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FvjqJGRUGf5rvJLMczRoDDubOCSWcD2sRCL5wLsrmc=;
        b=OyIRog/ECRzZPoExYO7DKJ58u+Hfat7TItfxQ6a3CAlTJGaKaFLw/+WdFx2g6o6tOs
         RPpm7cyjQbjjTcOIUhAR0JzME1mUfhro+KHhOz3pmgXkSo+kCWwsivuz80vtjGbGXH/Z
         XgwEZlMZecFlr5nTQ1JLf38GyiLf6I9xlAE+Zdm0yAIKA4HL7JGwacPST2ukJGwLCmO2
         s3tIB63tnv+xQ1WsD311pjPkZwwksCF22oJFITVGjylFUst4ISGbEOPbyWS1MXsWXlvp
         DLsgDESrww9urcI4n7/lcnUpanjfv6OefIDyjwS4L7S+VlsL4prKYldS7a21xobU2kNw
         lKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060170; x=1775664970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FvjqJGRUGf5rvJLMczRoDDubOCSWcD2sRCL5wLsrmc=;
        b=MVUDie3vJjA4GDs3/tUNLjiGlmndsiNuGjQrjKUUh3PzD5eIRLljNX5ZHJfTyOlmml
         6Ho4bVzaf8ia4iwQoXLbikk4dkqVqJ1JTszgvuO3IP8q+OPil4HEreGfHbu2h8CkoQ3o
         oHIsH1r0dL6x7jSH+luy2v6kn9cWa3n97QHWwsTXOZ90yK6cqCclegMlkbUenV7c9iSV
         qSTG35y6+d8dbMR4BV1ZDuJSTWsQ6fk3p6aTzvDeAIEd1LMI3Kzs7rbw9mjt8px1AsT2
         ssduNrPoUF3op8oqgBiXyGK1NuEOcWL3+j/UWo2gAg5aKj3Fr3VkXDLbTYIV727wwh47
         7zZg==
X-Gm-Message-State: AOJu0Yx2gO5VFrzlAFBAS7JF9Dby/bxB5p6YPItnA+6Rw80nIYrxKT3n
	Yvg20ebmPpVr4oSxDQxZssUk3+vj/70LUh6u1sDWVjpnLauArDLoaJwghv5k4s6os4Q=
X-Gm-Gg: ATEYQzx7c4gIsm1VEuJc39Uhz0D0Sa1DdkuW7JrRTEmtdyENMpS2Tchg4+D2whihCHN
	dm0J0FdCtQRrruRh8vT/o0BEmI2fTOWE5cx4YpW+CNrjTNGABzBJ+b0rJB4MAjPYgUNG/6zQsUq
	MhsYtotni6+kceqwRonNSAMAmc3xk5ZJP58fW2AtmpEhbrk8SZiwAa5exTS6tn55vp7rsJIhocC
	DMsqfAiWdnRM9aoj9CFR933Dr5CNAl7nHOPk7ZSGNU3dfype713eatzoxNUITHj2URAvCPkJD1y
	orgm4K0uTnGUS3zhmEfegUXABoV5GqzSe/2gF8X+eL9JYbDi8audha7DqBGJRyKpiCSKSTcar9U
	V0KHTBvA3Na6u47ct93y2OdB2W173bBEnebCD7q+uNsuW0ECi8k+VVM6PEObtrZ+DDaDRGIK6lb
	/sBbwcf4e1
X-Received: by 2002:a17:907:80d:b0:b97:b88c:386b with SMTP id a640c23a62f3a-b9be88fea21mr486276566b.29.1775060169798;
        Wed, 01 Apr 2026 09:16:09 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb4fb62esm539517241.0.2026.04.01.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:16:08 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:17 -0300
Subject: [PATCH 10/10] selftests/bpf: Tolerate missing files during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-10-3ae42c0af76f@suse.com>
References: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
In-Reply-To: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=1301;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=yVagyWKvjPbOTMFBAGYFdTOqwRpe3t1YiqqD3RZmsw8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJqWMuDkW7CGJ4c4k1sKyalpyIqTV3VBzKB/br2/xyUcVyk8o5hnm2bUhNHeFiX5vKvdQ7v/CyK
 tdCTirSltDAU=
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
index 3d5b88435446..ec24bad44017 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -951,6 +951,13 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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

