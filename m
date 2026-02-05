Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00686339871
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330576; cv=none; b=VR6I4nrIZXbB2rMw2Tsm9nzq0EoYoHRm+kI9AUZp7W9ysKAaxRmoz046s9Gq7B6Ont3tkpXFMTEcRsadyLb3ozklBIhAFU8suU0Vc0tlZQcH+BpUtcTqfmeQYkvovfZH/XKiC2anlc1Ifp0Nwm5wQ3PA/mAOFzLKbQaaPM/iFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330576; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8HqpjaGM0VPaZ5U+7C5KLqeMK1Rh+PXsTRkOrqg5J86qhd/z4DNst9VOYovLME9waRLkTtz1VXLUe7WGnMo1Xw4TbE0DscYrbzZB8V08i30KHXuALbAnzFRh8/+R1vBebFERIVGfmnV2vjkk8bmyI/Q6HhOyS1QA2nAhZbNI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiugn2hd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiugn2hd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a94450ae14so327325ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330575; x=1770935375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=Aiugn2hdiEdSuCb0r72AORurJk6Ksui814gHEHhczvo86IoA3a8PA+3bOvNmcLKRBG
         LKrHvSG00k/SQLND+CtFaFZWWTIdemlHAAcDeFcn3BqPFXmWx3nfSKyL8fffUUoVln2/
         k4Kv6gFOoXEoqNAnmd41G8TrL5WyNKmblwwC6odRpWW7kgySZWojq4mn3CS32YJSmzzP
         +W9uBMxItydX7M/BKKCeev9g2nquCuHdnTKP+zRcyKkWQEyL07t2KPrRCe2d+H0Qzt5j
         CbDsGOvb/TQqGcPsdo1TQID+d+jyynx0VMuse0DB0pM8LeGacVberbEKKfHb8kCGxEXp
         u+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330575; x=1770935375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=vBavLqe9K6yTyOpi+WRReHRaQm6F2xg4/U1r42DNoPf7Ye5ru754FjLoE4gy8rq55q
         gRQkEE93rcJL00chT0oR6y7rW+z/PN+5+l3NEskxWMr/Y4luMiaudT0LeDkZyalbikXm
         fbeVsIQacJDAAlNOCK5/DmurbLHHPdx+XfqlNE4maGyYsSsJF+ZNEZabgBA4YDW2gaZI
         vbwY5lralMLNX2VQeibs3h+fCBq3vwOSPzC6NZ5E3T8uNvhNkoCs0CxnKQjV7uJ4PRcQ
         t9RDspFFr/QHiPGRc54n5ACMWuEz5rSuFBNcE4gQ+SmIvqlXJunddvpTHR3P3SPz6CTo
         btng==
X-Gm-Message-State: AOJu0Yy7snGSBEI7ymvq7tgVs7Az/g24TWeyXw07bAL9GFFRzjF9oV6k
	oXgcXqmXhU9u3t3OhFvEf8TFHOr0CRmihDGUNOSP4Y8TSZegKRjrQwuJVpJZ8w==
X-Gm-Gg: AZuq6aJuLMXqjYTbWbkxFkt5xUsmEtwYni+DQzlwwKpf9bbVi6rmCu7ae0RsEQWijtJ
	V3Bt+CxsD5J9/ADHXojEKdce/11mmIWlUarx56qFvV+npWod+PhuuLlJ63SbRd2As/OOibiFJcs
	c/bQBU38MKWpRGQHOzj3BMwLKFAsfQM7OaD3YW9cnhlSbdx9lvhj2zmfs5Ie3pg/gyfrDq3LdGE
	36sk2QaibED+3VUlmEKpMn9r59Ha3r0LhlkA1y3ezhK4VvQz1Utgob2PGn+0U3TpO8V5Ep4O4sH
	nU9yv61Jov4S23ubqRyRVImVcDcA+TQEosQqVl1yb24x29+k8jXd5OrRbhEy1cmHfR/ZUhdDECK
	bhIUd/YsuCv7P1GWHZX1tfjjwXgWVTAdbfL9oJUaKl1sW2fUVnSekn1+YBDM+1OPdqBMQihaVZ7
	5Dug==
X-Received: by 2002:a17:903:191:b0:2a9:9c2:e8e7 with SMTP id d9443c01a7336-2a9519a8081mr6457685ad.60.1770330575247;
        Thu, 05 Feb 2026 14:29:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8b041sm3846305ad.34.2026.02.05.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:34 -0800 (PST)
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
Subject: [PATCH bpf-next v7 16/17] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu,  5 Feb 2026 14:29:14 -0800
Message-ID: <20260205222916.1788211-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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

