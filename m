Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9527FD4F
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968278; cv=none; b=XehQzNpjzDI/EFAct7zo1xbCa69/KFxQl+Ts9VrDrq/wWOAJUjybsksxCOgsrDScOyaS8Rii1ndKaJ8Aj2g9k8tB1c0Rik7AwUnUbs0sAri3msDQRL2nhqOnP3v2SFtox8z4/E1yBBaFa5nN1Q0HaiwbZ+BTdCsN8efjH582LqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968278; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MusiJVq2Kl+Bk6tRsFmSIoYOqxET2CGTvOGSZsQzQ6vGNoGcCwhlaset9xK3WO2nxAmpRLY45HxeTNyDTlK62ScT74F5PUuqFezxYA52mShl+eYmDwClxbregHG2FRZFmhUORowV8h1CL/CHsm6S71opfnDiVS0aH2R2j/3mHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGPew7Nr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGPew7Nr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230d228372so1874936b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968271; x=1770573071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=bGPew7NrLebHj9dB9DEE/zsshkLACYQGdPowqtgsISA/yLaheVQQBRlWLZ6hyBDQPf
         tw3KN29xR5M+VlBbO4tmGSuS9MRBIHHhb8h17YlFxPaQXfNNY8c1+9C6ArIh9i9+2ELJ
         NMsFcLqMpnHoWKgJlIJr236lJMv6t9sfLiOhgvko5QD7HycB4w+NnYfZmuCg8lVOPQr/
         6GvAASG6ti7tkWN8O1bwQsY5p0/cnkdXRvyvPG4+JrQc+Cs4url6ZkusZyXmVuJMcogX
         YjynDHHS4Q/KuGuDbtIgVa6ZVHbog6amISPqz51b9c7++LthejbHPimZJzz3PwNvXcB8
         yt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968271; x=1770573071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=BeKA9Sk/XqIAALXG4Mss2XbiXX2VFnMKyMtnc4iD6PknBLWSf6PSK67Il4hZ3lwUaj
         7oVQlu7Sy8QMJOLUS44Va+vGfGokqA+NRCv9MDMavPKw4F1Li2vhUPC5KTOlXOPmkQ4g
         pJmZUEkxKlkKu9w8NRZI1YRVfhxfE63ywv2oPPqmSU82z8QoCnsdb2Uo3O9mVjH8BSMv
         DbvOhI/9QbZ3jcVChObZke4ux7kIl/Nntbhm21r9RyawF92hzmwEPFOzNpRLKHtbceqV
         +0u4ma6WZW+j3AO5Z0lTApLeT2HmQhFQoqGKia5snz3wWhuPpqKrKt+smuioWJ3qG8cT
         U4jA==
X-Gm-Message-State: AOJu0YzV0BmLc4OrJN/P3CMQlfumZ5GubB1dVWnoRgGGB/EgCwMKgdu4
	I58fFLFBFLLbZOq5U4gfY+LDdG4keRjU+V2wk/8wkXpfy02wlFmbeTJbfCt5AQ==
X-Gm-Gg: AZuq6aIyhhxgA0kw1QMFHrXepsdKcAnAiSI4+4sDs5hB0j239p6v8DSTIRUSo3THpzV
	AjYsOcCceHSap3L+5q8V8dxmvxQrrd1Ya3u/KsBpG3I1XO8ePUkaBQF3Tl7su8bRNzndEACN3DB
	flCGk+drAg+QTbVeXJeXzR76dH4aKX10EOjeDOMssF6/XnO2VmA/fX/Fd+IUpHvZseqUol81W91
	Lkpx5XyrxizvCNZFBm0gZidxhNjkhX5QiH5VnH8+WnRWkDLMAqfJkfkn2acRqbzlDeW5KQ0pEU/
	g5CjZkJCHvCUKVQEOeS1cZznoHEsUw+T4A+AbRHQIhSeD4pSYQYr3klnYZept5H4e4v5YZ/6NHr
	RF2xe55Nly6RjdjvypAbF4aZDDl4d7ynvMx83CSCDlAAuOZJzSR2hPYLHVQQkSPDsYnBgwUF0RU
	W+WA==
X-Received: by 2002:a05:6a00:2316:b0:81f:394a:489e with SMTP id d2e1a72fcca58-823ab65ef08mr8539752b3a.10.1769968271114;
        Sun, 01 Feb 2026 09:51:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc1asm13967537b3a.9.2026.02.01.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:10 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Sun,  1 Feb 2026 09:50:49 -0800
Message-ID: <20260201175050.468601-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3

