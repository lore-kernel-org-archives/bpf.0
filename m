Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BC3E51F0
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367880; cv=none; b=pVWeajqL9aoDDrQMh1efbIy//VM5LrBnTWkbGjBZgA9fanF9YVFEX4NTXKBC1Im1POpNWKhZ6A55TGmpDTDNxtOFEApOD4lvaA8yjyFTfMkbPrHR5OsySZA+Sy7dy8gdoc9Oe8Z73Bb90hcKEkDSXa+66hYeEmxqbJ4Ft11THLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367880; c=relaxed/simple;
	bh=LGjyQ4DJZImIa+l6d/sVh7HyuyYJEGS3b/TTHgcThlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNauCnyUtscPDJnKTAjbFaBn1/cK3fzyYMWNYmTLXqd+w8IC4FNgtuZtERbIBzpVY69yK7iY+le0nSCyPXeqtb0K+5Mb9U6hDDw31lN8M8rwCh1Egp9IN20sqIF2R0ZIUkMQuKELZSxiWja/eZBeHCDw1zb/mP1IEB7dmFwoD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ERPlUVrt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ERPlUVrt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so82958705e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367873; x=1776972673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+TFkSx0/A90udZGFwEtC3VdLgE/56vsioCu8yOMo9s=;
        b=ERPlUVrt+QCIJiDX+FG+8lqoWzIs+EkhCLMF6Fv9oQPegvHry1yP5aSa0fACAKYDv5
         mNT2EvZwLXvCX+x7TkG8FBfmG8KsIILl1AZIonwqjrRqMdRAhY9bV0Y9QtfLe4rYDL5w
         oxaYBleOBohAoKmLaO8FxbTCGZKak1gzDVjvi8A2ySKl1AZaQBN82nMjyXYogL8e9+6v
         p6LHXUHAXFoUyWa5m7wCFXXhFxztNeJeXLXQnNudf4152O8dxE4vbXsvCIygV+PA06AV
         agurNpWttk5LW4lmMD9JB4R04jJD2WRTOPinS0C3EcElSiAO3Hy08RrPYRA84bb3Fhwc
         x0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367873; x=1776972673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+TFkSx0/A90udZGFwEtC3VdLgE/56vsioCu8yOMo9s=;
        b=emBQ5DE0hg72v9sXnNBlXRkevHdNZ88kUcXc3IhKfoJxSYT2321nWVdnM7TRX5q6Wc
         0RwK4gN80fUOV4z0dzPPW7OYa6zqyGtE023I7ksjVl8MK1FzW/A1uLG0xSGXnkb7KAUk
         t7FS0x9wP0kpahktNe1DdOfHvyTFnBdZ3ZbBGwaU72x8GYEW1a5P+s7rcM5lm98ddUbJ
         BXIHVpzpjHqMSMMFsAuZrP17amhSvbowp7UrO9IGowlDb1mS99Btx8b/Aeu1gF018a5r
         U6LG8SEe8egKP1elFS4mJvClOE9CrYZW6IUEJhL0ZBqCvNBNGUHV/wV/9SctaxWv2jKR
         QziA==
X-Gm-Message-State: AOJu0YxTsPcl1VWsHDCapeiBPOf1FTVROKplzYb1Vr5cnwcft+A6y4xd
	+obXp1c1EWR9lGGo0Pwnar9q8aOXAoX9/JMK8tmJVvn3WOse1KDQcZFFP1zGHPPZeck=
X-Gm-Gg: AeBDiesrWz0hm1VG2mHJ/LbNVmXhIdc7mGrMXJ5BrpPAbVL9qdho+zrhUOiuhsvWAPn
	cNABM4MWT3Wfa7vU2gRA0Va994Lnt8hhoFhSXOlVz1akrD+VFyef7fi3dv1py2JvU9ZFYTs3A4q
	XusZkIqxDAirZwkraWHPUuq4AslSFKUF7pvsm/H6Y1xYmr9BSjP1ZTLfCmqfdkso6Fk1oe3QEJB
	uNMj2TempZZgb2YPi204CRG7N2IQKe1L6KK/NNeg3Z1s6GUR/05s6er3oMc8l22OLm9UC8ulzAI
	bYK8OBMf7gL+b+dDMK9oRNsFp0w54kYm5OvIm7Vn+j7/Z4HLTdH9Q+lSpbgzN8EY/PC/bsaTkIH
	qWV6Jpqbaswk13w0FxQs7rtcxutF3v5PV4dMBC8gNPDHttZEbqywrZfZeeKwpP7Qm270gjZRuQ9
	bVkdxYzpzMvYhVTBJrVKiN/8A=
X-Received: by 2002:a05:600c:c0d3:b0:488:c282:e77e with SMTP id 5b1f17b1804b1-488fb2a698dmr1869965e9.28.1776367872924;
        Thu, 16 Apr 2026 12:31:12 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm8749784eec.14.2026.04.16.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:11 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:53 -0300
Subject: [PATCH bpf-next v7 04/11] selftests/bpf: Avoid rebuilds when
 running emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-4-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=1555;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=LGjyQ4DJZImIa+l6d/sVh7HyuyYJEGS3b/TTHgcThlA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI08/ckqohz/nSiAlXnI3fU3hujs2YjUPKtdoTCJ2gaAO2XqJOQXDYVBE1H3ACYPQ+TXtotgsne
 sNSpimrFKZgw=
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

