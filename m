Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A847A0CD
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060158; cv=none; b=tqLV2Xab7CSVA0ARvkCDo4T1Q8czyWkK8xitVXUDmQdjg8omQjTYRQWWRgsjMp5PeRhno48/SDwxIhRGP2Vvz7DejOds8f9mntV8Aa2wwO3tBCPVXCI26u91PUzt5gBasOmCdsrQ4T5/+H2lsu2Oo4jLAP4kwkUXzwr7/xuE7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060158; c=relaxed/simple;
	bh=9kRc2srfCyWc8uD9Bu47+DiUt+TkrpdHbGXfZQycNQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cK3p6dBX7NKWmWIDK4x+ptWPg2q2A5fE9FFsAnvYPukpGQfSpLXqeE2c7cWKIOmCYGV9LLm9457ahhcpv8e84KzL9MR6UezfBISqzcryLSpvGdM4GcInSvQ3uezj58//v0V7ZAbJEhTHrwM04oKPCV67feEFP8/mZXT5x5lDliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WPtH7Row; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WPtH7Row"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so14671925e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060153; x=1775664953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR5D/DWM5Dfc7y7QbYtyXQZBV4EpcqSV4OtU9XGADfg=;
        b=WPtH7RowbrNJL63OgUwXF5jjFM/EapnlKHFQZtzrPrbGKG3h4EBJZV2tP9N2wnHWln
         QE0NamD903sbHs8+M0TarDcLZodTsHlzV/h3StKPnvrj5cUKLfmjGuCuHBCsDmhtd6Tt
         0emfnqH8i+fr/nlqdpk5EoXx6KtDzI9Q3rw44jwdVTgPLvr3TJL0pnSt/SEAycdz/5Z8
         g6nTUFqm5hF6xW7kLvyb3f8O3Hc82ypxcpsZLhh+WVCrWGQR5+cdbTcgDY7kvaa0XtBB
         QTwq7igYXjumei0jkzZ8fO1BRG8KCDBQHv/gi6tIgOX6zB5BAvtmhfLZK58cyj1nNC3s
         Saow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060153; x=1775664953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HR5D/DWM5Dfc7y7QbYtyXQZBV4EpcqSV4OtU9XGADfg=;
        b=Dms57MypRIR3YYfg2tCKQN4C/iZuO3r/3vTYXt3AH+bZphv2FSkqqcY4ZVGcaM5qGa
         Qn4LPFyHObNLcJdsgdge5nO3eiyQmnlAsVXhhUS/Ixmsof7cuQTLabeIYrXA7YSUEcHS
         Qn7Tlzc7u/ODFT3skgAhVP1MFpmISGXLz96miBJ6qvgyFsEDtvEqi75LaF9qhVe904Lw
         WfPq0yFBPqWA8gFUyBhEsVexVUZ3R8CuX0fEMnKAe0hX6wTmkmyiAkxkEcYITKJEyOLP
         eTStP/ECw7v6gGBUsoRUVREUTeP/oUox06L4WvjDMqzEiZac4cpT6PC1AGMVAVpxSA3o
         L+Fg==
X-Gm-Message-State: AOJu0YwjkFHLkvSrFLlLH6DiuSrn0Bn88gc5zPbcvySHk63tvbpOp+4C
	qiLpkrZagDhe8sFV+pawiuNHIbqVkTXCcUtHPj0+txdxLPqYJ/bg5eU1l1gVnXZsk1Y=
X-Gm-Gg: ATEYQzwGuHJX1bpQscL+67Q76Mxrrvb9mvrVnkhq7jmTExbBwBDf3TaxRrRTxbfAVXA
	CbPFVwy1hfcbirFWMWE2CUKOhzF8EahZ3n8ZBpBit9BlI8BcpJrrhEs57LML+pgAwqk/bC0A9XN
	P7O1JTuap0aI3E0pQ4T4bC4pf7EqPlodZfhPLqGdXd4uWwrAgGK+LB9uBVDJ5cF5TtEYwhjWrrX
	01Y6NkGhOG7bh5VrUIlCY9gjoncCz8YvyOu5esEcbFnFbcHOO/IIMgxKvS087jATZjwbyo/9mPT
	36ftzS43hjqOE4lL3szJ4RLpamtFI5+PSy58JliDGxWZzGjrbSVzUseZMmgIsZRVXXbYgB2/pqf
	53FCZus8PdiPsgKiu+Xtb49zMbM9DiOGVvypZuFgnYe0E+avjNS4gTklfenr/twG19POCIT1IGp
	SANVzUmn/V
X-Received: by 2002:a05:600c:6488:b0:488:7d01:f67b with SMTP id 5b1f17b1804b1-4887d01f7a6mr161299175e9.6.1775060152860;
        Wed, 01 Apr 2026 09:15:52 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1cc7dsm247993137.2.2026.04.01.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:51 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:12 -0300
Subject: [PATCH 05/10] selftests/bpf: Tolerate test file compilation
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-5-3ae42c0af76f@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=1385;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=9kRc2srfCyWc8uD9Bu47+DiUt+TkrpdHbGXfZQycNQk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKthGeEAG8EHXczvyXvgIKDqYMGnyIJLHnRFqu4+9xR1Xi5pXrksKJ3A+h9fgUISNjlGo8YDDVj
 lPiOve55Khwo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. The linker step will later
ignore absent objects, allowing the remaining tests to build and run.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72f576a8236a..37a454e4cc3e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -688,7 +688,8 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) || \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
 		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\

-- 
2.53.0

