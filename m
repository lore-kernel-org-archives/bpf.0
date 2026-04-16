Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAF3B7B64
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342111; cv=none; b=DJ3yOT/9teXPnY5kG97exs0zJJbu9io4e96QpJZuFfJcUHOIMOosa61smt092QqZK1X91jLFHKzRzY5BNvQZOtq23+PzqswXI5o1mf9QzPdC5phMKSjVfNtxizBUleswte2bTs88StO1c+cBSuxmeEarU0y9pkAyy0DbKm+TldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342111; c=relaxed/simple;
	bh=LGjyQ4DJZImIa+l6d/sVh7HyuyYJEGS3b/TTHgcThlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpVcwpiug3uIaz2WJAkA3t/6LSDXr83NvgXRubWUpjgg/rByspDSB1Q7n1CMMWxsSt4nndjprlus9/QBjr5/49C8/lkvIc6GEeid5wkqjhnFqVLj7rpweUtcrKXGCNYKvK30vdYsnrBB97MwUzsq5PSPKfJECXswHn2S1tzeKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZTFEcwrU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZTFEcwrU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso121546675e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342109; x=1776946909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+TFkSx0/A90udZGFwEtC3VdLgE/56vsioCu8yOMo9s=;
        b=ZTFEcwrUT9NS0wqycHS3to1fFTUmDTxcfoY9ELTn+2TNxe9O1ikYcC+t6WT8O58lYz
         UKpvg5AMTuGmmMmt09vJJ0MU/YLrya2GjxBhAa3YNiARSqPrfltJixb/YanvH2BuK2wO
         GvsT7SrsoqNuBJlnHVgpQwmJFqOceV5UjX2cmOjUZelWMjkpAFF2W3d4h7biYqzoex3J
         RSjoteZxJsfNHi8A4v9RNUlI5nYrOehug+aI/eCknx4/IaloJv+d5x49G0VmTaRub0VZ
         3hxVrdSxqwxf4j8Mh3zM7mG56DGWN6MX47qkU2T+wN1ynEO+DID5k3odk1XGCmd/8dyD
         DNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342109; x=1776946909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+TFkSx0/A90udZGFwEtC3VdLgE/56vsioCu8yOMo9s=;
        b=hvge2yUWQ2iZhWkxmnZ8IORVybN9yuHrJjPhTdFB2cMp2Ec+g8ldCKLV3232JB7/BW
         FqfS1pkA0JoxRM2qKcGR+D4Jwa6qs5IMEk09pdc3hKnSm6OoJH99Fq2DgWpAZWsZp/OD
         RrUp1JxlfCCUdBDdApZiHlb+cBIfjuRN80ojfHboqSOZW9IDSANPEjzEFz8gge4qtQau
         sCJRYaea14TSWj9d+70L5di2LzLdj8ZZRzp5SuzhtU2OkSXptdRDjn4jlvHODDfq/GpQ
         BPy2lAtxDk0JBZfJbt8PK5pzg3N2H12JFq3PVn9p09BXy7s4dbKNQlMkUygVVMfv7hzT
         +e7A==
X-Gm-Message-State: AOJu0YyF836xO3FRj1Q4GhVxt4vnTTCv+NXgmY2Ny5UMXAGfoxnsSK8i
	s+WFdAIk+1ms4dEvqTuEoR26bVi/iQxLqE6PqFwhTTGpDkPpAfZ5TWmbzU+mna4BTJc=
X-Gm-Gg: AeBDievdXxyMQKobkPUqAtMlUtfjULH3EZH3PkXpGYqxlR/J6bECAkrgWglZR/j9mig
	AmVAMmVmbIm1KALHUZRJL56ZXMCk9GErRJL58Ic5rM0qsOoqjnm42EquuWzoVZfAKIM9+thIsKb
	3QQUWH+YNk2lL7/DVbX1PceDzE8rzvXy1+h+4mqbTzPyfryoj7gMO9nnSFnmJi1OoHPXf3nQ98z
	Ky/fT31fNxJ38wEL0sz7EMi8at/bDGW9103MwNF9/QZej3uUXf+NLYnY31/zWGgt6Awjf27Mj1a
	XwoEQ+p87pNBORD2FfVTuku8ztP1S+175ygB1dgYO7g0lGMrB87qiq9rptHavbn27/FcGTNZ3Uv
	7XyyCIOujENMlVF4jTKmua+KI1qcQZ6er0DPwhdP4y1cMZuuzrIGkLw1ke6jGAHPLY9kmOjXyvS
	KWKVLKDZMcQU8=
X-Received: by 2002:a05:600c:608e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488d688d2fbmr359059085e9.30.1776342108536;
        Thu, 16 Apr 2026 05:21:48 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8fa5efb6sm7313415eec.28.2026.04.16.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:21:47 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 09:21:21 -0300
Subject: [PATCH bpf-next v6 04/11] selftests/bpf: Avoid rebuilds when
 running emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v6-4-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=1555;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=LGjyQ4DJZImIa+l6d/sVh7HyuyYJEGS3b/TTHgcThlA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDuUZlqeRiwM48yeqBaWgbQshRq/5+n9C2ohjmUxqNsIOut0CKCIU7ha8+GX4rUyfDTrcqgg3UW
 dPZDs0PFE1gA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

emit_tests is used while installing selftests to generate the kselftest
list. Pulling in .d files for this goal can trigger BPF rebuild rules and
mix build output into list generation.

Skip dependency file inclusion for emit_tests, like clean goals, so list
generation stays side-effect free. Also add emit_tests to
NON_CHECK_FEAT_TARGETS so that feature detection is skipped; without this,
Makefile.feature's $(info) output leaks into stdout and corrupts the test
list captured by the top-level selftests Makefile.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b23703f2cf89..7d1e5d6c30ec 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -164,7 +164,7 @@ endef
 
 include ../lib.mk
 
-NON_CHECK_FEAT_TARGETS := clean docs-clean
+NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
 ifneq ($(CHECK_FEAT),)
 FEATURE_USER := .selftests
@@ -723,7 +723,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
+ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 

-- 
2.53.0

