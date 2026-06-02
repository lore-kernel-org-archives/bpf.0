Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E43E1CFF
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405417; cv=none; b=TZd3apy83kLKB5v1q/xLAJJ1bgMHObyOqTMVRoauyW7iw17ts5O8HhD37dPEMRdg9el+rYuFnNa27bnMh3bRbIlhEpmpdji3vHZN81nFvbZOj1doyOhd1hHpAJiWeYanB9eTvkDn9+/p0xCyDNfVgFwlRjyowtrHNYTV2fZOZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405417; c=relaxed/simple;
	bh=KQMQ4HA7sxO7BUSzHCnxywkdpfJKSWuXs/B8rKOPhnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bT+h58wLO7PfyjGtHDSnD0Nf2ra5ACFFP4Kp85EjG27z5guH0FlZ0x5GOjuy07tFSyXKI2arCFZs9h4/L1yKAPPa7Jtqh3/a7t/An4t9xM/bliAnU+baFEIRmSempShtTD2Ow4ECqPeakNyFfPGu4H0BpA2myljKO8ffYpVDnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AXVkIjBZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AXVkIjBZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso607466266b.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405413; x=1781010213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22zLe9Ow+Y8QfsqqgbxzwNbQJ3fAGWrDqmjGgu/Chr0=;
        b=AXVkIjBZ5v5az/YMBVUEIhPMcFzIPK2yagxYDB1i6ls/Yxot+pcb7VtpLuMHC03n06
         uFV9Y3jCWlbvXhlMtSlY8iNB1873DOAAgpZTlkly1qo8SH9UlKMxzep//Gxw3k88DjXY
         2x1S3/Ke6bWH2iebx5Jx0WBcuREDcydbv1XbgISRCkAY6D3STG4TQBWHJjnL8+PCTc0c
         qJPZJfD3yW6OuW8TAGXXssbvCWTIQlwczYLkSOrtyI3YXn4zzubW13Ta47AGT1OgrJKI
         HspC2wx2KbgyOvcyaxr/ShJ2/uf8KUxCiPV84rcaA7SNa1ja1x6Gplv4uwyJcSLVJpz6
         4cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405413; x=1781010213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=22zLe9Ow+Y8QfsqqgbxzwNbQJ3fAGWrDqmjGgu/Chr0=;
        b=W6HhrceBFz4T3ZBsor5TFMQemCPbSiWAGvwyuDvqigavZq1QtiWR7TeohTOAWgBkvT
         mBdzZNwF/9M5OZG+Ri9t0/s9jGl2gbpYZVMTbe7U+SHkfSnOMwoLZm1o99Sc6Pr+snoa
         38YA4eIY9EzFdySujCcLMUki0/Z+BRQ5zRrf1W8ACDWzxAmk/GQ6DuOPc8iOFQqT5XR2
         wY35l+POkATXYwcqNkppD03QJFy3+kluJ/k/z8TIaDehBKi/pzTUPmxUgvpgS/cg3GZa
         DYQOhskrmAeB969cis5g41jv1i84zhI6EgmRBtQ8JEhAn3LCk9fOZHpZdxxA3gZV2NWF
         BNwA==
X-Gm-Message-State: AOJu0Yxp4ZJby5uq5ECSV2BgOUVZshZR4wv0TkbITLgRyPpBBQX8p7so
	yQX7gKodlgbjp99dt8pZM2iUcyJryzwYWYisRQrPbUKnl1Pj1wlQ1e6hySk448tLRcA=
X-Gm-Gg: Acq92OEvUbR67nK7K56eMENkpEAB6m9KdZmRMwrFDrzuFQzMLBDQ0aT3zyVD0hsSF2Q
	CrxzJVGwKPGxTvX8+82CJnlKJQZThxzaN36uqsyv5iA0r0P63/U7i1emEB0/nPdo8zQ3gnekv7o
	TtfkkBrgwzE1sEdYwNWqrYv/NmS9c5PvpWziSy/uCYhhBTbKCPgUXdLyq/st9DBN737V6DvNXxu
	Tb8sn+KRfdH5WRTd8JAdalob1HJtxlaC5MwaR7I8k6pJGG1pOa2wjKCPzef8L5sZ15ZgJ0vU+cY
	511SH0k6umoQz+2HsSI8WzXP0yiHQxG40GQ4ooqZC8CktZEXfc8crgRHXTBCvL5VJdFP3glhgRE
	DBNFTtdNLG7c+WHQf6avp/j0B/dQXAsdmuayUN+bUaHqC+jMCcCsoyeKgQV/Y6y2p5gUNkWfILh
	aMwGlaG/618ZH1PyI4r0zpjzzdGfM1cQ/T
X-Received: by 2002:a17:907:72cf:b0:bd8:f776:6980 with SMTP id a640c23a62f3a-beab0cd17acmr906172966b.10.1780405413366;
        Tue, 02 Jun 2026 06:03:33 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bef0874a308sm121575866b.19.2026.06.02.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:32 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:53 -0300
Subject: [PATCH bpf-next RESEND v12 04/11] selftests/bpf: Avoid rebuilds
 when running emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-4-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=1555;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=KQMQ4HA7sxO7BUSzHCnxywkdpfJKSWuXs/B8rKOPhnI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJVp2o2ipGMRt38bfAm/cSRpwXsGhnDw6nwPiUVeigzN4J/zhtbOkN4oCrGluohl4eAH++dD3Uw
 ZUULOQR40ZAo=
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
index dc1f4a4a3582..49f6a5503e84 100644
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

