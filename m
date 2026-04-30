Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC440B6D3
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553625; cv=none; b=Oj1B0dKscacU01vyV6H5g89qRBxsyof6K2wqfQAnH8vBY/wA0w8YUXTt+voyxxXxoM8B2p6yx8mRyNnX0wezW6dZRVSLllGy//wfe2igqWgrd3BwjjUY5TWIPhxLMqhPjdDgJN65bcLq96ThuUiOEwd8982spziEH4gMXR5VkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553625; c=relaxed/simple;
	bh=aqXG984YlUxMtsZ+i7vquyVJaGX8IceA6DEnTDh+TX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLZCbN9HiIwBgRKz300obF0/p7gSSBk3VXdem5GwFMLjsCVeOd8PdZoa4kAbGTI/CCJeSaWd6XkF0CdkGBw1PVVTTydkLfsGLS+u71fcivMlZRctUXxq6ZL1pW37iOYAzrO+I0Josk5JR+uTnOTbM/6Y07QxH+mRd/NI0935uHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FEs0HcJV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FEs0HcJV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so7941085e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553620; x=1778158420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysP9AGtPxCAbfR+Tj7mfuITrZ+N0ZILV2wyZ0Jzr9sk=;
        b=FEs0HcJVJQHZtzE61RuKnaYluAxs1DHS6q0Sjt98k7Z3S3KOt9EHVZUZ57CRBzZgJJ
         zN0xv3auDhpqpztzbvVye0/8Y7UQb7jN6Jn++MJENrn1Gferyis/kPwe2nvLcf1lHoEC
         RXq/hxqjiE6UH9jp5qTRSWlRDy73EKr4dYrids2RBGaKyP38TBpjyq0cgxzXWMmxNgB3
         L8FJzYLF3gkYXIY0DbAjUNYIuWF97gCfNJtiLJMw9e8/83CMfxNQN2vzjCeD1Dp9B176
         1m4N0uovzid+7Gb4dVYeyBrbhC5HuTU1WTjQyQ+m4w8O3weP/70Pp/1ro3hZMTJQQbsp
         nWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553620; x=1778158420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ysP9AGtPxCAbfR+Tj7mfuITrZ+N0ZILV2wyZ0Jzr9sk=;
        b=iCrKPxJspaI0N9KDKsRr8SbnX/DUhpspC3SPMTl8vexS/kalsEnW6aS3EJ5l8qKmBK
         6inKqHPBxlyuRm9qV0eMPXPlX/aRPOrVXA+k8bheblF60im0djJeBpoDCwCtZNGFC13S
         hyU6xed0PbOcqoUSllptZPDwBZNXdDeYYXvct1ECTz8Mjo4RujlsaPT4X0ppIA9SCrVw
         ZlXC9j/aZCUvVVAiJ5UsxrzE6i5BxCgsJFYmxtTDN+8zz+1PA5FY+ZDKe7AbA4+BWyws
         jAMU2Rx6hppA5tGM5NB1e9N6pgdr2q8paFyfuT9+mq0C5Hc+gjQvYFh9HSJwD8ZEaJu7
         +LAw==
X-Gm-Message-State: AOJu0YxfRJ0niXEy24ImUy+pbGTNwNAAf2AbXStbR97m0Rs8+Gy/QC/M
	i7hlST/Zt7zYjITnMkwxUYpm41aD/18apFr1xm8LHsYzmLib51hnXch+X73c+ZdxFgQ=
X-Gm-Gg: AeBDieswff4iqvPbVXWDkkKrff/WYvZ4KuRjoCSHdIw0B04ydCkVapB0LnCUmdjpbFW
	B7Wg4/0Ea1qDHAPuIIhifNjYK7YMsvAWr0PPz/NiHZEzlByIVklOJwQmRkZoy/F0FZTMGHGtx/j
	KSwkNLQkQMp3i1d/Ds/PgT/POnga33ULSUIQIMP+8Qvpr9nxt90jwFTfdFNf5HXlgxaVYYJ5s/z
	ri2sdmXi84pfjNIgxvMYXRJ7W8upMos+ZtcGZZEc6q/AbCnZalKramPqlri0IFsyhsRApbvFP6F
	lQSbJ7HqLOwy8Hlb0aIngkG2KDNyQ/j4JoIXmpGuCe5dvgDnXHscUdhO0TonRyQsr5yT1WchKMR
	b+C47FUSmNi1tQd1V0/TVdgeiAuUgsHj6pNXj125QTQ9fErsX5et0E/rVMTnWsJ5sh+HrH2KoIn
	dR/4NbyeVBEQsewMxs/ekCv9i7
X-Received: by 2002:a05:600c:888e:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-48a83d6a8dcmr36394175e9.6.1777553619863;
        Thu, 30 Apr 2026 05:53:39 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d315sm7161270eec.1.2026.04.30.05.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:38 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:17 -0300
Subject: [PATCH bpf-next v10 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=2402;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aqXG984YlUxMtsZ+i7vquyVJaGX8IceA6DEnTDh+TX4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMfNfx0uSTz+XT2LVbDrne0xam7XwpfbbAQ5V7F5ctX2+k09VLAnSHIE2sFqnwGIlHQTqmWtNZO
 gFSqvfQX/FA8=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C preprocessor and list
the headers each test file actually #includes. Skeleton headers appear in
those generated lists, so the .test.o -> .skel.h dependency is already
tracked by the .d file content.

Making skeletons order-only prerequisites of .test.d means that a missing
or skipped skeleton does not prevent .test.d generation, and regenerating a
skeleton does not force .test.d to be recreated. This avoids unnecessary
recompilation and, more importantly, avoids build errors when a skeleton
was intentionally skipped due to a BPF compilation failure.

$$(BPFOBJ) is intentionally kept as a normal prerequisite: a libbpf
rebuild legitimately invalidates .test.d, since libbpf header changes
can affect the headers .test.o sees. Only the skeleton headers are
moved to order-only.

Note that adding a new BPF skeleton via a modified existing local header
still works correctly: GNU make builds order-only prerequisites that do
not exist (the order-only qualifier only suppresses timestamp-driven
rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date.
The modified local header invalidates .test.o through the previously
included .d content, forcing a recompile that regenerates .test.d with
the new .skel.h dependency captured by gcc -MMD.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9a4d8bea0c18..608e6dff0392 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
 			    $(TRUNNER_EXTRA_HDRS)			\
+			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
 			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
-			    $(TRUNNER_BPF_SKELS_LINKED)			\
-			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+			    $(TRUNNER_BPF_SKELS_LINKED)
 
 ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))

-- 
2.54.0

