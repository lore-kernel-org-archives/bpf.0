Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786646AF2C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060141; cv=none; b=Rv0QXoW/NJkA2m2d3oaS3QLezYH/7LhNoF13sifZbQApDXWQ0glepyakhzdYIpfYtyC1XonQ64Z7mWW98UL/jbXxhWtROO6t7rU3jTxdzZ5x5Aq/L3VJsM4GGj2AsWYPnIWdIjNRPmk4csJm6zzDaVTwAUuj68R4+aTArTrgBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060141; c=relaxed/simple;
	bh=b7nfNBNqrJ18hpBVF8kDcZraYDe06fSNKUQ5ann5t60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQiIXmXXfsaAyAif18t8amkLrnB8jRWU0ojMyxeaqExIuV7EDC7jOWid5+DrID4Yoe3qYjRevQpwprdtHOcr5iSepbCrUHosPXXbQm6zbxUWvYy4A7vtcwvDwzdEkWABEtlStgJgn31OAjBXC/zhNOWSL1gsIddqPtbp/wOZ1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qt/09YZS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qt/09YZS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486507134e4so80063435e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060137; x=1775664937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43fw3GZqDOKnOXUmd4UFVcfR/ZtOCVdeWF0aKs+p6eI=;
        b=Qt/09YZSGdPfC/SWf+vrOEnRp/nEqfUrGkQ0Oog/EWQ/oPaXV5TMBcDqFxJpUgjCNp
         Vff1HMSRP2HHl21SHEt+dGdLj7c0H9cNHN6yqAGacmTppeqGwMWjv1BlHWuVi7YGrIcd
         rny8Al/gYouLnUc6iLBErrnliATxG/qfRb8jDYQggLLkmlGNJk1zpIgKZob4t83sykIt
         3fwTOyrIBUseux6FQASqpIti5YlKydo/mfGsMTY78+HdP1R9wPMgfHzBqur62fSzRKOA
         1G8dmBcG2utfAAxHQgXqEtLuVpATvEzzGdc5xqfbbzjp/6gUrYxy4YJqUjLjNhyPUtL+
         RuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060137; x=1775664937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=43fw3GZqDOKnOXUmd4UFVcfR/ZtOCVdeWF0aKs+p6eI=;
        b=GeBYW9ml2CplsjTAvVsmYq6CExHVRErui+OyoweVZBhUb7PkvezVgMOibdGUj0Nxhc
         8OtTyUg6H2C4rTpt2oMYwa8k+RDOPnSiEZJmp6lgu3pRsy0rDOe5SQ/kzfxziTnATtg7
         lR5r3G3IEI5YRmd29+a2Evyx1omGLU2dPGZB1HmP0mWolxcyx0XlVQgPnepAahbGRpU8
         jQxhPmrZCSsjIPwUAikyHZnhKvEKB46xXrB/NaB1j7q5NVqj3ZFKr5HzevZ5MveykREJ
         i8Xq8r9EmUbjBDIZQCdGVJO6/XnJ8lzaFatGx46recGIwYjOLLA+c/FnQ/GVpzu1viE8
         889w==
X-Gm-Message-State: AOJu0YwEgrEXOHo6y7E/w+XuaE9CM0PZfNqLdJHePr7TWRjNV89pmJpL
	LrI0XzPyL5J8Jis8gVIDUkV2hOftGj2PsMG1vKzIzFvWQq8miglO84Z/4deeyAtoCTA=
X-Gm-Gg: ATEYQzwKsBUAr2g9cgjCEz5ONirL/F4s8+FA+1OXq00jnFeJS5JxHQRF9b17Yo6Mq6d
	5W/pBLj/4zerHu3Ihn/12SaPTNuH4JSA6Tb6Z0LR+wihVCPwM9NqQ9ZNDODYprYF0jfnPEYjmK+
	p/HetWpvw1forJI08i/glvBtzuX1HH1saW462g7PlqISMhjZgKfem9pPDlhleoVrwyNLuysYcKW
	1SU1OJeF21VvGgjPpPmMhaZdhJLE8lPs44gMX/MvARyzsfQu2sYOp76StjfAUuoMplFKkVzX2DH
	AF7+QWh0w5M+t7DeI28H7MmRcp0yTr20pVBitrjNSsrWxK3lgN+eWv6G8MeEbBb3ZvTK71Ni/dm
	15cx00SMk4qa4m+1jrV4871UpHDjuP6hltsb6e+Ijn2XbEmh4BEbyxUWaX+jOjfgVipI51CRGvn
	df02BoQkcOPRhPuGsLeXE=
X-Received: by 2002:a05:600c:c04a:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488835b2f54mr51986225e9.20.1775060137100;
        Wed, 01 Apr 2026 09:15:37 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm24428e0c.7.2026.04.01.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:35 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:08 -0300
Subject: [PATCH 01/10] selftests/bpf: Fall back to distro build directory
 for test_kmods
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-1-3ae42c0af76f@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=1367;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=b7nfNBNqrJ18hpBVF8kDcZraYDe06fSNKUQ5ann5t60=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP1x9/R4Np8q6Hmj5+a7NPsgZG1tjGdEaP0IIitotMPUkrM1doOEZwf9ghhp0N/RnJj1MBl3Yiu
 4mK0CQ5TIXAc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When building against a distribution kernel there is no in-tree build
directory. Detect this by checking for .config in the source tree root and
fall back to /lib/modules/$(uname -r)/build, which is the standard location
for distribution kernel module build directories.

An explicit O= value still takes highest precedence.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_kmods/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..8babf9b98684 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,9 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+# Prefer an explicit O= build output directory if specified. Otherwise use the
+# in-tree kernel build when it has been configured, and fall back to the
+# running kernel's module build directory for distribution kernel builds.
+KDIR ?= $(if $(O),$(O),$(if $(wildcard $(SRCTREE_KDIR)/.config),$(SRCTREE_KDIR),/lib/modules/$(shell uname -r)/build))
 
 ifeq ($(V),1)
 Q =

-- 
2.53.0

