Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24C388E5D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491912; cv=none; b=cV432Tp1BCIjndO/MLAs4hf0Sct7as5v5zJmMc5YaYLYwj9j/Th7noxlBhzmvA4Dm3+1MlU0DoRgVsTb/OetXRyTQltVJXcVs3DHyI4/lunsgya6L8/E6YCr+xFdi5jIND80v0ksd+LfP/8hjf6oXQW8/ieISWlNZTfIsfUVyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491912; c=relaxed/simple;
	bh=CjKnZSdKJcfduUYX6LZCm3V+sJ3BGLQkmRsI6DpGINI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7yfF+73MtfSmyLe/00/vtCJk+sm/r0dKmEJ5rIa1fGrkZ6UIxqnb8JVDRj8361A7P/5vCoy4R442HuNg7y4D3Y6x/oscxZP5VH7mwzx27omdXXmXN4kfcd3B+o6NlEujFSDfXE0Np8VaNNnb4PDrI461QrRMaSLV1DLxjIA508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=csbPIP9n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="csbPIP9n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso19822595e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491909; x=1776096709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWko0FMRajGjPHliy0mDmBxqRPZFl6s8N5nN4RhE8NE=;
        b=csbPIP9nnofpnGY2/E17zpx8Xvj+ZmB3mK71oLesdjpolMvLwzPEYq+khpCcf8IqwZ
         PTilouzG84Zv+AEXuGMwLN886TxD5qiw7OxKuQVCowsnCdLl9xKgptXnCIMXFBMdaClQ
         0TNDwLkU1MzE2dV/mr5mDVa+fDZB5238WaJBnnwab6gWMySDvzxv8do/9HznbuArMHL/
         KAI3a7DHIR9gaiOhwi7mToQHFOn8avmFPD9woksiqnQbwzaJGbSld8NGJrqvY0ikLknv
         PHTuFXLyuDVwl8+pF+HpNm0UbYvjyxFrULYHORU3qGB5Vf+Fd18ggdOfqh5qV7ApkHrK
         O5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491909; x=1776096709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWko0FMRajGjPHliy0mDmBxqRPZFl6s8N5nN4RhE8NE=;
        b=IvhyG3LDWAebQMHj/dxloaTHZJ0mfDrnr34GGH3exGM5afFGakm1Sxlg8IwRQD6Tj1
         pa901Pn2Q9tIfEysVYU7yCfKQ+2IsphmdTw2V2gXCBXRydN/Hin6twFP6uemiEcTV1df
         UwVxucwi0cbbTls9fHq3I4uXMMT2rWKbkz8LAu81GxvR8v4TQrcEelKftJM3TDrW729E
         GoylqpfrkmdzNMR5Dt+paGb/o1WzjFkua7VZLCGN3X9D9zu47kfOwL5RkCQnb6hqV0V6
         vYH2y/fpQsmv4coAID+Me++l89F187r2hXxb6Su5D4vnY9ofv5tEh8qx3y0kgerktb2i
         qPAQ==
X-Gm-Message-State: AOJu0YyJVSjBgVK91yVaxsWr7K2F1QuDuPs1fYCf+86pMzwv45qWd2cC
	M4j+0OjImCKRvVDpCSNtAX6jesoHtyNDk+jDTQzOMw7c656b02rqVV0T5M31LZ55OIQ2qrzyUwW
	kUVmc
X-Gm-Gg: AeBDietfSUcCcPCOQLi8ejuCXCpbCj4pEtbCUU7bbEVch/6pNB9OvqMF98jmmMlIt2M
	BJLmfz1OKHG+Ypp1Yxs6JqwoPsgOpbAG68ra+5sAP4bKot8kxb3p3YCVBXqgYzzRUGRM47dH0NP
	gYprMY2Zapda+hqhdg/+mXldH3vbjAhyYrR2b1SL4DS4bb1fdfn04q4wvZqnb5BuD0iFuxyMrx4
	WinmnlJTTxd1mIwuyXDhDF9pXRGuogbt16P4a/t9cKl6WHQZlmQNffjFAFsc12zbJl5DrxtDs9A
	BnMrauiRSF8+zDbrlSsbzecRkp7RWdsJjlbRL4JrIrRE6xUtFHlF+On9dXcWMJVYoJTpeNkG4li
	rJYP4uivSKjPfNs4xguWTUcdQgX3NFhCxOtVWk1zjplPPRAgTcoImcyTY1Vvg77/LesYXCmTe+y
	AxdTGrbTi9CAyBpVIx9NfBnaU=
X-Received: by 2002:a05:600c:3f0a:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-488996a34c9mr202513625e9.6.1775491908554;
        Mon, 06 Apr 2026 09:11:48 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9baff553sm16516729e0c.8.2026.04.06.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:47 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:27 -0300
Subject: [PATCH v3 05/11] selftests/bpf: Make skeleton headers order-only
 prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-5-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=1610;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=CjKnZSdKJcfduUYX6LZCm3V+sJ3BGLQkmRsI6DpGINI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAQAgIyVLzDZaCEFyIqMBpX3GCLmGh7KvDLYvFRAtLIudDVGKzvopSefPFQPqMKQ7a+ST5xfldW
 Wg/cnFXSXfg8=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C preprocessor and list
the headers each test file actually #includes. Skeleton headers appear in
those generated lists, so the .test.o -> .skel.h dependency is already
tracked by the .d file content.

Making skeletons order-only prerequisites of .test.d means that a missing
or skipped skeleton does not prevent .test.d generation, and regenerating
a skeleton does not force .test.d to be recreated. This avoids unnecessary
recompilation and, more importantly, avoids build errors when a skeleton
was intentionally skipped due to a BPF compilation failure.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3e4c726870a1..f4d6c5ed7b3a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -693,11 +693,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
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
2.53.0

