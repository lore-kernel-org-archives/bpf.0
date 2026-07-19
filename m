Received: from mail-wm2-f3.google.com (mail-wm2-f3.google.com [74.125.225.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D253A5421
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475403; cv=none; b=g3Bb9mgjte0RpRw5HFBt3cRxPATUTHtE+evuHi88UAW4018Fn71gLSJe/oYkjbG0NYY/21WbfV07+EUJSvkDZbE01IE7p6JnW0Fs/4swnVQ7ZnCuxnbojIUx5XWXDqtll1Eajvo0X/LeVLnV76+vgrmLoVr2kiPMcDfMYohesY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475403; c=relaxed/simple;
	bh=2oa5USaUdYnShJ/OC6sAxGb9UX1weNTEblTOqF+//Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBYozaoVvVWckcY571H+Vq02e3YGu9hOFLMRfInmrVMcJOGmEFfgXVNITlhwr9z3kv4WAD0QxXpHaVFiF8va41ln7XqTagt86hBTieRDbBiIduYdaseInNvRHquvDf56SO4KCJPQ+H8pNFLHc/np/1vEn0664sXhwPiZKdpR5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1m6pVyX; arc=none smtp.client-ip=74.125.225.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1m6pVyX"
Received: by mail-wm2-f3.google.com with SMTP id 5b1f17b1804b1-493ec89dbb0so5916165e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475400; x=1785080200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0Wgj2xTEJwb2gCLeRgxerl9SDNG4n6ZvruOvMWJ0ZE=;
        b=J1m6pVyX0M5m2g3QgL0QTu5eUixcm7ZbCqP7uYDHro5dxHxCV6iDeuY+iv6Ja8dQ4g
         /mP014nNmh0xVbMnMRcehwMHKQuovECMhOWH9/bbWGwdiUENhYYnAcj1r+F0bRVOZgo/
         T3bfRC1XvqQB8Xt28evq5gRs5Ot3HirL2bmqAEFWg8p1IDYYa5nPQYVgwrXv17fpVDxP
         jEzdF+ClRb7DMbw5sGFLTDV/e6JNSdoWlLmndQaUGFWyCHCRq8X7F5/UHm9rsJ9RfjJp
         YObxED8A6lvL5ZOxfHdt2cN3/5oN4q5p7UIauGy0G04WzycGf4wk+RBiqWMQjvkYYq3J
         NdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475400; x=1785080200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0Wgj2xTEJwb2gCLeRgxerl9SDNG4n6ZvruOvMWJ0ZE=;
        b=HQNUTlGWwySacoS9rYeRteTid1rNt/NGrZ3R7xlVU997NBva7HYKV8Uc8M0rt4m3XE
         nEKC2AkyEvHVUkwKUa3ptvGpj3DwQcwOJi8BqlnZlwYp75eGPaSJyELHyWkGCARNAwfs
         HELUqPnnrXb2ukdJxNVgroX1VtKdl4wpcMbHX1zDSOIkReSrhRCI6yk731mpEfjZ8wMD
         4xs91NAL0mWhjCYUJPXki+ify3k+NTnC47zPk0WS/Plwl+oM1zHSZ44CUDRH05zvGtYk
         3s0rmonAaaOjdUxybF3mGFjEQphKLhkZ0rpFe1yLAxhw/T0Mes8LVAFEJgU8cfNadwo0
         WpoA==
X-Gm-Message-State: AOJu0Yzo0ady9wcOYF11FyOnXGdFpWsaxHCGXMdnmA5MjwvkOW43P7w0
	hKK3FwR61bFHO5TlWQozKKMTMorTpkSLkp6fnKn5FmCF9BqjFCR65rpOqqutKyZk
X-Gm-Gg: AfdE7cmlB31AkaIs9sHzN2XU6mocGenUwM/omlDZVNzQlfYQ50UNio0+DFiE8gHB2I0
	uRLmrIWQaxhgyNqdVpeicDo4qqiQ3UnOhGwaFh4esHdcIODum3MKMBK/IwhDtgAvU7tKVwY6lWg
	OEw9DN+XmqobhGL7WLGe4WCevyTD1HxDlJ4p+PzsLx+b+rILO3nkudkzPpcJeqWUTdOiVSHELHo
	eeC601DN9v1C1WD2Q601iaE61Ur9qf0viACil35W4z/ulGCHwNY5LtRvGi90j40cBsu0klqDUpG
	QqRFGSunYN1OGKdw2XV9tpxBMcC5go3LB93IKIQ+P6myyKoeHG/Ad8LjsYJdZ2dng3Dl1E9XaAe
	v1Km06rfqhRIg4Ri8sWuBelvdtJGdyaQH+RtuhETDaC8olgWaGfFycdXXjAwBwUCyb0XU/NvM6j
	4uevH7uNqxdc/i6zpnlzbSP86RGwbTOGKB0r6K5YqVKQ91UIyfTc35rmVITzVKyIyUYpgKW2JLB
	3VzVnn2RiwRLg6b/kK+bjZA6ymTIjuUUn2j9GfOTXVF
X-Received: by 2002:a05:600c:4f0e:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-4954f847354mr85184855e9.4.1784475400152;
        Sun, 19 Jul 2026 08:36:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm197510335e9.13.2026.07.19.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Test duplicate bpf_refcount fields
Date: Sun, 19 Jul 2026 17:36:32 +0200
Message-ID: <20260719153634.2908692-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719153634.2908692-1-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=memxor@gmail.com; h=from:subject; bh=2oa5USaUdYnShJ/OC6sAxGb9UX1weNTEblTOqF+//Po=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlUTyDy3zKH+zP6f2hpw48zny0Wy7i/EaDGr/EjJsb 5892BjdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn8u8bwvy704/ObDPaBnzsK 7zZ1x/4w6RbkFDk+nU3VRC6HraDpHsP/aI/m97+6XkQc+vXN0Us2fqnXzKs+Uz3ZAi743xI7qJv ABQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw BTF test with two bpf_refcount fields. The duplicate must be
rejected during BTF loading instead of reaching the duplicate-field
invariant in btf_parse_fields().

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 2100400d896b..67b9015cbd98 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4277,6 +4277,27 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 },
 
+/*
+ * struct value {
+ *     struct bpf_refcount a;
+ *     struct bpf_refcount b;
+ * };
+ */
+{
+	.descr = "struct test duplicate bpf_refcount fields",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_TBD, 1, 4),				/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_STRUCT_ENC(NAME_TBD, 2, 8),				/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 32),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0int\0bpf_refcount\0refs\0value\0a\0b"),
+	.btf_load_err = true,
+},
+
 {
 	.descr = "struct test repeated fields count overflow",
 	.raw_types = {
-- 
2.53.0

