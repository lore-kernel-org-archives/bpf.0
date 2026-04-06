Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D83947AA
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499772; cv=none; b=OuamLqOdV02pcK17aTVPTXLBYxRolhiyVidec66iBHpxi6PwFUzPnb5llPfhbj1jecd0+nTSKwxi//s25LBzTjeaWEbgJkSXToLUO2A0TOgSMvEUScYf0IZK+1ZpPPLRdWxTwvIEcU5rXCgR90RwHN5h+YKzGlePJzV+5vp86fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499772; c=relaxed/simple;
	bh=NO40hlT3q/UQLTKYN24Xfp26cxU/OmT6kvT04yakHR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujv/Hm1O2rZK1MjSHOd7bFenyjSOa7GdDOVhnwjCVheVJcTybtlhLzi0Jv57/TYfw6JiTJvgGT7xl//comYa2hBQrSvDLF8JX8qCOdaB+ErzbHaV17OPAiYQO7ashswf4oIoPt6Ed1UOMiUr6RmYpJ5qPzjDHVPXLmbD/Dqzkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+LTJAiv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+LTJAiv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so12281065e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499769; x=1776104569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atRPErzIDwCuTw8U4bY1TIrRJ7Ayq0ANPp/cVJlRlp8=;
        b=P+LTJAiv4WgPlsLQH18qbSKBIDhmVyQzzaxmXlKoNSgNAyEdeRaCrg8iEuspfx4g/5
         r62Ku2M0kkPtcqHBPX3C8nfGmmC0JZePAead49UVZ/aKXq8tXMDAzwIP4ymcvl29SAtn
         MK35dVwKKxrIDWGpoUmkD4F1Rts754QhReJuBwFc8teDvBmqRCENE3IG9wYW4P785qFy
         /qcgU0VgbWgZYgDe240vVqBTyIg06o+YecD9agWC1+aFdB95aPnqYobcCcVqz6bN229O
         ZvaDTvkWNYaRtnx7nWzbAUIvPB3XuadDCO8Jo+qC3wN5bY5SUHESoR2Q2w8GE0BJqH0F
         ltQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499769; x=1776104569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atRPErzIDwCuTw8U4bY1TIrRJ7Ayq0ANPp/cVJlRlp8=;
        b=CLgv9OEwUTdZ7CBLNIDKhGIP+wCd7+xTUL+mrc4Vd5qhkbuF9boMp62k5jH3oSS+KM
         YsQvN2W5qR7h3zLU50TgAUkzm9AnVIKa81USb04teJtInj80+Xw7IHTDKo2vzjNE1a02
         JEJ+/zRSVgKWmUJxe+/BLtMggKEV/C4Hs6+wDXhlL6hXinb4N/nBxEWJLQl7iDIOPTFm
         gjnh14OdoLb9T/Fcny5/uiNuKQ5vmHRXyc7VAQjYUIxn7cZY3LNOekHfZKbj2trvWsaz
         ik6Ikeo8iKQmKFC7vkewodlmXpMeTIIPo5xOfJIgDTHzADYdJ1UnT3x01wN2+iMotjKS
         dgHA==
X-Gm-Message-State: AOJu0Yz04IEGIiEpRn3zqOekGhoIB5hadEzqouNv6qTKOBSKARtgxTj5
	vNGO2ewqRkL3a03o7A9gNbNXAbBLJxRFXdr3Hk3aF3TaQ3fYKiwQfg0UvqNwSiIM4LM=
X-Gm-Gg: AeBDievTX2DSbNQcif+52WqN4GA35L5RTmnzjrvJlNsiYFD5hXPj9Mx5nONBLslsySm
	EV0IWkLjyE9d2f+mO1/8qm3GhH/7hz+ly5WU8fZg4RWQTCahENEMyfN3C2d/F/OX+jH2IcSFA6K
	CoNzH3U+tvGNhBj9MogcElb/UqURH6rU7pz0F/VcOuygnHEL7THm8j32Pt1G5eXVuyWeBHHDdmv
	kDQ9TfRmSTwOSpnfjlqyoizU3o7vFlMj2O3Nx7Y1Z/EmjVEKrvbDSOz6kDFoG5I8rsX11Rc7YB+
	oxCEQGY+004zbg3nDDw5X7tLv0lXcXLMfXFpwP1eIjBM+vZdjFxEtCj+0+zp2MzBoECunjB+508
	27lLGhqy4LR1Les4ZRi68b6Xtuacr4J7Zdo1B4RtB5eX9rCZfYdY/MF88xx3WgCI+iFn8J+f5bV
	kty2CfeeLDJlAC
X-Received: by 2002:a05:600c:6986:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-488996ecae3mr175406675e9.8.1775499769101;
        Mon, 06 Apr 2026 11:22:49 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm17639880137.1.2026.04.06.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:48 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:21 -0300
Subject: [PATCH v4 09/10] selftests/bpf: Skip tests whose objects were not
 built
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-9-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=1740;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=NO40hlT3q/UQLTKYN24Xfp26cxU/OmT6kvT04yakHR8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJLZSqyIII0z7HGBBkZHOTxm0gTNEchdkW7FTR5AQiBKJz9SUvEUe+NAlCp5ZNF3Vg1QK5eqlsT
 Xcp8u98gwBAY=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When Kconfig options or missing headers cause a .test.o not to be
compiled, the corresponding prog_test_def entry in tests.h has NULL
for both run_test and run_serial_test. The existing infrastructure
check treats this case as a fatal coding error and calls exit().

Separate the two failure modes: having both function pointers non-NULL
is a genuine coding error and remains fatal. Having both NULL means
the test object was intentionally omitted from the build; mark it
should_run=false and continue so that the remaining tests are
unaffected.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0929f4a7bda4..85ac25a51a8d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -2022,12 +2022,15 @@ int main(int argc, char **argv)
 		test->should_run = should_run(&env.test_selector,
 					      test->test_num, test->test_name);
 
-		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
-		    (test->run_test != NULL && test->run_serial_test != NULL)) {
+		if (test->run_test && test->run_serial_test) {
 			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (!test->run_test && !test->run_serial_test) {
+			test->should_run = false;
+			continue;
+		}
 		if (test->should_run)
 			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
 	}

-- 
2.53.0

