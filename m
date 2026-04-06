Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA6394790
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499756; cv=none; b=PqZ4qEfddCIfSwbeFpi1+IrqWQD9sEClc1A+r7HOJl6akkO5724lZjJRy6SKZHhU1Jg0DTyyAm7YvDXIr3HWPTBvgOp9rfG+e26piCXhYS4r4tfUHCU8kdatkGsjvAkP9LPR/x4XRBmgXUn+qeuCN+kFREPc4prqnThmUnyXgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499756; c=relaxed/simple;
	bh=23NdMGoa+vcqEV0jJ3meh8Gl+VeTbF/g8o0rZHbeMi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/MNh9oPZwlCBN4U1NWb7ohUPMoi8+sqk45tygB8y3gAzyd9Ktq190yzlh/uwbTScw3YgZJ70C6SLGAHYChX6qSv7aOt+hEjZNmsuVTXFfMejPHzHDnb7z3SiJWPLIME6qs2wds4IGYG1E81vJQn7am4GDO9O0hTsfMhX59WUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uylvzhkm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uylvzhkm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so19725405e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499753; x=1776104553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlS9hoNLxVP1THYSXUkUN3DbjIQMFidMedFjH2/H618=;
        b=Uylvzhkmd6CMvyiOsxMmKsE8z19AJq0ckEjm9UaTlek1KJA/sNnViaT5MedwswxGBG
         bukVYlEnwpCumlzvnwal0DrWNTj5KbQemv5P4lqctucQRSGp0i4OQ7Y2BLKlbqvaTBHd
         0kYAlgJggxQzjhSqsXM8NVMRcKT0JPrk5DaPEdhqpSCikz+FTL9PKvBjselwR7Qsw80M
         CoUVRDe0WVmOgJCey8Ic3C3AbX+bUBEr4YoW1tM9fOauKf2ffv3wtznwRhOmb6j49n8I
         iCq3sfmwGmeBWiI9/BVYmEJG20SMEYNeL4YiicYfEtG3xIS5FoOm/NCxGFV8CRsi4wWA
         jwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499753; x=1776104553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FlS9hoNLxVP1THYSXUkUN3DbjIQMFidMedFjH2/H618=;
        b=hiNhCXCpPbBCpABBWm6C5q34CjAGpBDEY6tUMOFGSKpvuBdKB8iplvFe4wuWQ7xbmE
         uReyV66m5hjpfII/v12O5jpbVCNV4nYwDfkAqZd7nEUegdILoo5PCq5ZYVLz4rn4P+WL
         ekNAh8e+WrmjAyN2vtmiBZZDg+dqN2Y4zGik1k3P3v0nVekc3JhJTGqJC1sRqz/LlWvd
         JV5bqm6rH78f1l3MKocIk5eny3aWwrjZ0rc2wdHLaDUwKA2ur3PzFEU4z5o80u9hoe8/
         6VtQqOOEYAaamXVTQ/QoUvvAtyLg04mpSgLfxvZkq/3CHOwO7Rh0VKnlOMjYb4znnNw2
         QcQQ==
X-Gm-Message-State: AOJu0YwhysvXe8UVokxCc3EDsRSpr8/srhOiR98sU+GpkzUUcoJ8le8I
	DwwugUAtjen5G15D7ZMSYJb3eXetjZsgIkQf5mik75ziz9uf0NpPjmj/ABPIoMROOZA=
X-Gm-Gg: AeBDiet/MJuEEQdc+6AIVICumRwnw32VGI2QhK2HpaFmsslvSeI3sNE1LeJNXebi336
	30A+X/gGtPcX7h6SijqfGRvzbHItNBAuykBzVBY8qez2+nXLtfuv80dOUPemaHmrmjb+SYJQEpY
	sjzn75jFd/D3uqukwj+V/4GbgA5uzCAMWai4DlMKG5XhNfLtyDJ+dIDqML0+E/L4z1Yt0Pi3WrA
	imCJZi+w5XnUYLUxwJ0Btv9E+oIYFTUJFzy3gy9fkvS2hr0cvtQcfDt4aVddd2jdyi4WC781EF+
	9j1xH2VMc20N8DVMjqFBBUuLy9Hsbvo9Sh1VfEe3m3Gx7hRlZPxRcUCT97vqOPD3Ftfmb8ePQhu
	jjULNjo/2teqVFA6FwplbpXdjRASVh6U6U+Vnihsc7EN+nIBQWsCvBF4IH5ZskUooItBFbhqLOK
	E+46aoZISrFnmV
X-Received: by 2002:a05:600c:8b52:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-4889978140bmr217856345e9.18.1775499752950;
        Mon, 06 Apr 2026 11:22:32 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605830999f2sm17555974137.12.2026.04.06.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:32 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:16 -0300
Subject: [PATCH v4 04/10] selftests/bpf: Make skeleton headers order-only
 prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-4-9914f50efdf7@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=1610;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=23NdMGoa+vcqEV0jJ3meh8Gl+VeTbF/g8o0rZHbeMi4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNdZ69AfgrAyqanC50wjNZ9qTNcmG1B/46tYgH8fwNfwYd/7Lgcz6tym3xBLEo78DUawQ1CD435
 VTdS+uD6dyQ8=
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
index 781238152c4f..72f576a8236a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -697,11 +697,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
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

