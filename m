Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D22399004
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419936; cv=none; b=mXnzzLg6Gf/cXvsAa47B0sEpd2R4EuqOZy3tY/B9kq5xUHKz+JB26EOhw3LIjrFYk0IL3YboC5qlPbJogfDKCrXfB2Lk1Zm6fyFvkwLewdgGiMWk/iTArrFyQaTPhzXCTo6VJCCSaQOPPUpFXlc8HWyE3MYVvgEpW+dosDVf644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419936; c=relaxed/simple;
	bh=pbpwT1aTnlvs/k4VWEJw+b4cingvftFSwGWkwuBMoWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI8ymzeanMAXugoLNps4PlOFKYEfJ0i/gAZYmLynEg6n5sq8VlmFBE8zNEHWLIWCiPLL+37REAIstpesWT5zkjQFn0FWdk7tyTsuFX+DX+HMJrVPJv6PNGdQzSjohIWyFLMZJKg549Iedzw3C3ZCOYMVyVpREJK7JF8vdDCMri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K7XEhlQA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K7XEhlQA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so70492855e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777419933; x=1778024733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfRfeM2Ktoz2YBd+nAbVoRoGagqa4SBjA60nTAl7vkM=;
        b=K7XEhlQADJDvOMKZSclwFRMmJGc4YQ3uqT0g4F8Dxi2NWx/yWOyFyA1GmRkd7beP4W
         BwKBS42GfdVwIj3+ucPfU8GIdXmnf5xS2D3hYd70s9mK4bPyX2/hDuGF3TM4HaDUl/K0
         6sC7xuNlX9ZZzyE4DLyAHaGijNYUbnkCCWAUG34oNSG7sV2de0bAhYr4/FpLeOge6sSk
         +tDzblQJ1RnZyjw2BagW/eqJF14S+x7+HPrKPho+UF+vpQjXuguddglgx2UePHkHb687
         8LwEXVDMyYupbinQYWJmEmNvxnliw4OxX2jyX1DHreit43yBzsBmc8buqMtRGO3W3stm
         ckZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419933; x=1778024733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfRfeM2Ktoz2YBd+nAbVoRoGagqa4SBjA60nTAl7vkM=;
        b=ab2VSBsfV2mpk73Lp0/XPFMW1L0gE6LKAO4V//cDej5SHjELDFwNq0FBNBQGqc30De
         d+JVKK+GQIe2fh+reOdYUt37TCOz7lQNYe/hd0AwU2lCseKDg5aleOFz7oIYh8husw6a
         SFCMyFZstTFXIf1sXV/ZzFcThRY4R8NIT/FTYIr7xCanbC0qe+qOWycAN5SB9TK3I3cV
         0D7/eHIfqFGksaVD3XELKou7nrtKzfzHMNXIUKeD2HO16tHm2kqvpLEkqvjN+7KMyYfR
         FMUbzdSW8384fTbR6YiYCNriwQfr/ybivb6c8r55ZlpmfwESko+DbGoyb1tErBVUsU6q
         Sgig==
X-Gm-Message-State: AOJu0YyWClyBHY0pHGLpaDfhhVDS/uWUAq4/gR2WVrZBhXyyDXMgFjiq
	g8ES1jHhx5lvvv7V15yPgNr7nZSBaEN9/HciPPW0ZYpGAhSWo6n1c6p+ExO6mnZNWdA=
X-Gm-Gg: AeBDieu1oK6U0DuNb9wMeOW2mdYLiuqjEO/GjkaeNmpZR36UbE2XfoRJDJnooNxaG9l
	W4pdTaHEQfjofBMtsAxAMgbKF9X56xvx+IKOdAzskHb9pmRROrmv6XT85vu1vQNKH/uaAVqLn3u
	kpWUngBWd5eRRUvoAYyTHJrex+DcfVFH/Eq73E3zQZaDJqDikgETYIwbUFph0/rvzySteZd3ZM2
	YjaDhZSE3h1C/k4o5UN94G+BZ3ObCo8UHsV2nTW8882gosvC2MtlRTPNwO/ZWRHsmvSWcWT5Wyp
	XStAqCw4AChdVVuzyowSwkcEueQ2+Lkv48cUaHUgunsxMrJJtCqIYofhCVMhkMLvdFBC9gvGpHB
	QlIbFCDiE/u/ObsqfkE646OlShc/Sp00ZLFe7DY83lzLMuodMrySrNEW8SD2cT0S5cqsgOClqH/
	Mc7ZSPDh3nZs0ZZQD4rKGTitvA
X-Received: by 2002:a05:600c:4713:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48a77aed429mr80989345e9.12.1777419933461;
        Tue, 28 Apr 2026 16:45:33 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-629843365e9sm214210137.7.2026.04.28.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:45:32 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 28 Apr 2026 20:45:05 -0300
Subject: [PATCH bpf-next v8 04/11] selftests/bpf: Avoid rebuilds when
 running emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-selftests-bpf_misconfig-v8-4-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777419912; l=1555;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=pbpwT1aTnlvs/k4VWEJw+b4cingvftFSwGWkwuBMoWA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCxcEN5y899hg/gBfdfhM/iJ0taCQUUzGVXJ6akhKBwDcjQYo5+ftQKPAvExHbXI1hqz3Rykm14
 5VkDKVo5YMA8=
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

