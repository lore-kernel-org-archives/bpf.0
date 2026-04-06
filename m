Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21399392C27
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499752; cv=none; b=PRNenySl3dvCmR95O3tANNcE9wF2lw5r7AtNk2INy2zCk6ZPIs9iWq3YS1HaEHfKFwsYnJd0XFRy0VB/TsupJU5wqe8fngKTlKoI1m1MsX4dQGie7HLtM55GxjTeXje7m7ZSy01qfKtqOVYATNJAqlAy5kHKzJQrqQG1PrMpaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499752; c=relaxed/simple;
	bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfyN67PHQ4KbKATwf2K7MRAmgFd4sflD3M4xA45OQ1ZULX48v4n8CIZGTDgvbOtt3OE0ye8TfKTqZJZCzegmTO2w+5+u8qQiEsltt4F7Rr8E9xtWRlqkUOUO/nl2RO+GszVdbQTjArB2yAr197lTORLhpDQSPmo8J5H6/5sHD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VLhK4ban; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VLhK4ban"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso19681485e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499749; x=1776104549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=VLhK4ban5SB0EjBzuTaxNxWTq/Cf0Uc1Cmz0G/tyjHjjEKLz1z8XdZulv9VPDf27TE
         GCZSR8H7iTvJdNtkTr78xhtEWtqBQmPDqXc6rQHtuHX28i+X8JesW+/68n3AZy4SZOTL
         btKJoUc/QASudN5r6dY/Hz49gUuKnF3tSr5A5k1F7KdRAr7AViWWZizHsTOa/0jCLpdC
         TXON7hF/zc+OxpE3QVjWZGxvQrnTAOzquwFabrRikVb+MH+LD/tcHFVBMtOvzuTp5rME
         +h12nXGJnSkTl3KYxVTeC/MO4FFDj5s9WYu9oTzo+GyQ6/U97kxsC//+B10quuAl+2Mh
         JUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499749; x=1776104549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=ZF1VvilfX9ddlCHzoZ5VECmoSY2IG6/fbcQ88zjU7LFON/vytfF8XeyA2DoOgMZdpa
         ajnQ3rgxjKcuf+Rvg0PkQQtMnfrqmge8SUAD2Zg12HOIk9X0bklyCJwHPz6paus2ntt/
         zJqWfTgjy1GDLgqe2dFHCktHrsK+9eKXIheqlxfMj6HWiQeGLHf71gbImQ9gg4ScByry
         X5ImM04XVfs4gFHnrb8V4rga7GPVhsjkqvTy/H6X25hHTlsFoNRxV2OaaIkggQvsa6eD
         3vW9PBG/oKFMn2dsJaaTfud9OKjHObPQWQdlGuaaSzvmns0K/bbVe+09qwfDktZx73IZ
         S98A==
X-Gm-Message-State: AOJu0Yw3lrO+t3o1mXpwDYc1XienRYB7IGmDLZZ3ehUXRmeNawZCb5u6
	89qW/HqBTAljc/qVVk0NucudJzLQwa/LYzFnqiLiE6uBoSZosJnxII2sjIYtlkgS8W4=
X-Gm-Gg: AeBDievhDVUMsGEsamqWGk87h0/fbGYwYHJBFqE9qmh2UEX/aNi/wsY6X6vjVSbtW57
	MpD0SQeYrq6fj5BOoBYTqCb4OF234aRJijoV8rkjtmfs+plRQ9ofw20iKgipwsQZNS03rg/EAsc
	u7h5anOZFlh190Kvp131YzXGRKrIUu2U4m2NXX2PqntUOJnncHEYmcQ0JuSaf5vLpqsnpaEAaJf
	tkqOPo231Hz1p/2xUjH0dLxmz5B4qXmr2eZVo9B1EDn+zyJHA1YXDc8UL5fjXg6eiuugQOb22gq
	2GVj5kZccqRaBvQTpNKbWQI5ld7cTKmpGrhbCZzAwSjXapHpBVUcqH/AI4+D2CdG5QeiqufDP1L
	45m5HTo9q17W0OVfqVde7i7i3zYqyi+ibgj1D+lJgEQ/z2ByfKoIqDWHvg1SuPCpno3ngE/Kade
	KCVA8dEiYqiHCXCqmQJuaHdMY=
X-Received: by 2002:a05:600d:a:b0:486:fc3b:3e61 with SMTP id 5b1f17b1804b1-488997d1788mr158558915e9.18.1775499749438;
        Mon, 06 Apr 2026 11:22:29 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9bc41sm16853202e0c.11.2026.04.06.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:28 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:15 -0300
Subject: [PATCH v4 03/10] selftests/bpf: Avoid rebuilds when running
 emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-3-9914f50efdf7@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=1031;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHxdcziFu6PN48z0Fxo285Wtd1vV/o9yNXb1hgsHpGglvB7hPLWkf6rVvug1UFkNyMTLJB1G2lH
 gBI9xF+/Nrgo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

emit_tests is used while installing selftests to generate the kselftest
list. Pulling in .d files for this goal can trigger BPF rebuild rules and
mix build output into list generation.

Skip dependency file inclusion for emit_tests, like clean goals, so list
generation stays side-effect free.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6052bba2c157..781238152c4f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -703,7 +703,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
+ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 

-- 
2.53.0

