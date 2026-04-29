Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444AA35E94F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473260; cv=none; b=DRBW1hYVuVOkHduFvLimSx+UQws0yQYOk49/mzNvinrrSkv5+CgfMms9NpgfWhOXVlhDrfDSuUrJ6uTrNmKh9QqxVfjaABMhmfQRONon4B4v1SdvmfQt+7g+vt4YErBPh5+cnyicqCaLydjTJcLhtQ668dEyKgEecbOiFWsXRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473260; c=relaxed/simple;
	bh=pbpwT1aTnlvs/k4VWEJw+b4cingvftFSwGWkwuBMoWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DONjYxNphSzev7jVeGBDgPpp08+79vsai4NqMzr0iypaiSUl+IJkBaCXLZW4nEjJvo9bjKtfSRKJdxkRy/K/iMWsAEBoIa/PMEAlyADeaIsSMJfUxmZORZngLLjPGRL+Yfp0hwfrLoVgWCbfRi++KSbuBorS6e6rZyzbEqyinak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bCJHhO7z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bCJHhO7z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so116167695e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473258; x=1778078058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfRfeM2Ktoz2YBd+nAbVoRoGagqa4SBjA60nTAl7vkM=;
        b=bCJHhO7z+SALJdpUx209jEJe2jqByLm5RqdxN/5RjPzxBlKP32nyLmQzCairVAJKq7
         EyQbEwOGqORbSfQdghEXKHPWqMSYG+mJ+yv397bDRB20l1iXTliuD1FmELwJtLmu6WsF
         ModyBBfJbpMb5EqcMwtkRBZfQQdMZx1DhccpChIBamYC/OzGDekCJ8TD0ntwYvwEzy49
         FrHbTbiJyNaZlSHVOl0XIzuBnrMNeKp5F+xLgQp3mNxYP3pcND22yH+Olc72jE6H3C0e
         q/FS5OTfKH1fg++SYzav4ENPo6byD+iCZ3JmZnI0R5fjtm9jrcMCpFCSRbKptsuvEgHH
         /bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473258; x=1778078058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfRfeM2Ktoz2YBd+nAbVoRoGagqa4SBjA60nTAl7vkM=;
        b=lEZyt+i5CPxTsU+JSOPpJkWiAKBTJT/eNjQycpK6QCvCPU3aHkb9qXiB+AYOEWA8Jb
         R6gaGAiF24s9QbWvQBFGyUf2VqIYRUIfdo7+rViKgNXH47jy08r+QdsPsPQlYKbsT9AD
         9YpW8+hMXae5uTRU29xv5+MX6wMuMAA5zxBdsgn5+nm2FrNELTA4FVqQJoTvoKOLT2DU
         MeZcJPZRQ6ZW3g4K9a3nXUiGQ5zULM7yKCe3PlrIvQ10cT13r8mHhS92SfHa3tgDJxKB
         TZZHyG84nAh1liSrYYfNrxCB3n7nOjZdj3vBP5hgbUGZO0gYckb9RBZvWE6Y2xYonr8u
         rifQ==
X-Gm-Message-State: AOJu0Yxl/SaX1XB0Vz4/xus9OmmMEsYC4/y42adlTd7ZHAQqG/Y39Ax8
	8S1jkYb0Efm32lkaORw+bu1aKFk2P6DL8N5jp2YZCu4SB9cYwLXKW5zMJMPFpvN2Fs0=
X-Gm-Gg: AeBDieu9ygzMcF5pLnseo2wQ+1tY/LYTidZR4kTq1LmDCd9uicAjEub596YWTepGnWF
	Mrdl24RdyOxt5ruEd+RM5HkBcMNUr9sSDcZn5P0hAShuEAEK/bo2hxeqyTRUdQBTYUQbyNaFAF9
	OoHcEjENKdhHQ6aqapHhpUWImCmqNC0nzmPSDF4nYTQuAjpuOWtMrp+UvxzaG/7RdDfrN+PvIVf
	Hm8aubt4D6O2PBM+jwQhy/aL7Qsf04YVZHD0DIk2JxIJtKU5jyIhXvixQNu2UHPDabo/At0vou3
	llodEjgrLMxE6eldY997bR/y2lE69qStYrtZEoFpb813zUyi+hI0Z/TE1RaKFrmuA94YlAWile+
	Ba3JD3LXNCDGXd2EYtxp8j2redi5qg549c1OD6ZEhhHcRHhf1BXsWOPgP4LkcTK+OI83F63rras
	RyBN3zaWQWu6xJCaqSDK+9Cra+ytriNsSe53E=
X-Received: by 2002:a05:600c:4e91:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48a7b54bf85mr71682935e9.27.1777473257522;
        Wed, 29 Apr 2026 07:34:17 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95cb7831df4sm1071527241.12.2026.04.29.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:16 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:46 -0300
Subject: [PATCH bpf-next v9 04/11] selftests/bpf: Avoid rebuilds when
 running emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-4-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=1555;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=pbpwT1aTnlvs/k4VWEJw+b4cingvftFSwGWkwuBMoWA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOx6r1sN+pHaompviJvGnsc7htEYgbZYrQe0hCIZL1j9hp1PNBETKr1kJS4dG0hJni6LhDBotXn
 AqgE2bAczzAc=
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
index b104c687dcf0..9a4d8bea0c18 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -170,7 +170,7 @@ endef
 
 include ../lib.mk
 
-NON_CHECK_FEAT_TARGETS := clean docs-clean
+NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
 ifneq ($(CHECK_FEAT),)
 FEATURE_USER := .selftests
@@ -732,7 +732,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
+ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 

-- 
2.54.0

