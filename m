Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD793AA4EE
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725879; cv=none; b=jstUbRZY/OY8a9RkdhA9wx01aBNC+7ZlvKTr+MRhukP/JcTijWllUTUs68oyEoLZrBsVRY55TkuOdjdQ+f/ToxnLOVd0PmnHTHcrinluljXa9Hi88eNcRHi0t8cjIMg34zLRj0/zyat6b8HC38GL7tULkRRsiw3Ncp/I7xJ5Cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725879; c=relaxed/simple;
	bh=EwaLLf5jOk2+IkPFrBBMcFB3CuCjf2P4D7wJT+f52xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMxNh0S0KmAjs0pCaxvgcp2fhK1dChwD5IaU4qZrFeZNlaHdeZoNxK3AXQdEkSoMexZ0dRPrPpAE+zt6/zZd1iq4zoRpesQ8oQ3yYJaTxJEZXNIAzludME8gCDLFN87pwh1gkEFRyMJPpE4SZq/F3bocMj9neEROB+iif3f3KpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buwHRC5U; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buwHRC5U"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso315309a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775725878; x=1776330678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOwXxXxMUC6OWtWELmNSlvZ5InMUhdFGYBRE1vTG+dk=;
        b=buwHRC5UbXNhn4ekMRpjCIGPNbdlddIKbnOyA30j7feCZjUtJpAMo2Sz1hgiws+x3Y
         A7lpA0pQvEi81e9sZusV9JJZ0PWEMtJelALEWDQXHModRewxPQDaob0GHxEX4M57EiD7
         7mhzFxrnyR2qO3HBmM45Gfsh5XJjFI/MtqCa4q2HBTIkvJPSFg/bTPAZpwIe9Nh4VG46
         mXdNe8w2ylw43QYP+NOz0iIRatTxSTDQ7LnOyC2hKtrYz2SthF7aNVjEcK+9Sg74PgGs
         egpugyasmPlhIp1e0mBHzRj/pNje46SOSCZwrdSv15uiMF/WTmaJJVKeX6xgrQEncsKM
         Hkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725878; x=1776330678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOwXxXxMUC6OWtWELmNSlvZ5InMUhdFGYBRE1vTG+dk=;
        b=kenz169CLsMOsLpfJpp3g+4IFIkUvV339CREUAGFm79AUyj5Hx5Ia5ybdKKMQInMlA
         vaGwY10MPeIZtuWN6fBkAwW4jGbMJI57x7ztKQJkQLvQNxV9zv4VBlZ2ioDSgbbZDWA7
         YRxaA+UjE08wtFtGezuQaeZgu3ClOEB8NbAzIZk/jjcOSIDUtnru5OlVT9KqN4gzZz+5
         lZp5PgchE9bHYuV0A0yvzWZcuG1eAEQUAoAzwwdEaX8s7JK7Zy5W7zIZYA2A5XGRQqmh
         CNT5zHDcoSA8LOishLN3jc8JQqj6bpz5LMASw/Gz094w66nC44F80hnutyzXVXDD0ZM8
         qV7g==
X-Gm-Message-State: AOJu0YzcnDEPy9mCOXhs9bNHwy8EdCZZ0pbidT8AC5onGHv3W3F/6jXq
	qrPzOKsMZg9HGk0uL5qJw+htC7PGgWzTiQjL0p2OIFLQAJ7CJM4V/bspAr7NoR4UJjo=
X-Gm-Gg: AeBDietrsEYvUb9JXDt1anCmr5/XfVd48qCp+F4jMJRqNjnhIYrA/wGE3cFcVUuUS3T
	St6DcEZhl1aNUvX9FpkD8L6nkNrxuNE50OnE8obe7vcNa4kHRQu/Hrk65pcdtHoXLwOPdXbB9Dz
	XbsCi/MWwWnjQ7Zs6qStxrNiiwcNZq3cRVuR4KX0zS/J31Dz7z+gzW9oYnA56mfxiQoqauuFnfd
	xg7w36FgMhqInVeOxTnuaglgX5CMWz0ZWJTooa0NwJ1WfZyEqIgJbxCL5JiuyDPT0/mOGsVh+BZ
	Q7EACmoRMPDFCPVibTkOjcd2Hur9PosdE8e9P+f4RRPsQsVjv/JLMoe6JVb8ufd0SDj0mHX2xTN
	hOtktFku2R9OTfiV5YO0XG3za0PJOeRReZL9/PidAZFUq7bBxqoZBLho80hLy8gb72Dv2qQNKdY
	VH/ZDPfjd6uLHio62r2bx+6w==
X-Received: by 2002:a17:903:38c7:b0:2b2:67ca:5fff with SMTP id d9443c01a7336-2b2c73c64f3mr29638575ad.28.1775725878037;
        Thu, 09 Apr 2026 02:11:18 -0700 (PDT)
Received: from laptop ([2406:5900:1154:b176:214:1c7e:a705:3905])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm213540125ad.56.2026.04.09.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 02:11:17 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH] selftests/bpf: fix const qualifier in fexit_bpf2bpf test
Date: Thu,  9 Apr 2026 18:11:01 +0900
Message-ID: <20260409091101.364091-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prog_name is an array of const char * strings, so strstr() returns a
pointer into const data.

Store the result in a const char * to avoid discarding the const
qualifier.

With GCC 15 this triggers -Werror=discarded-qualifiers and breaks
the build of tools/testing/selftests/bpf.

Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index f29fc789c14b..d8225da4c1af 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		struct bpf_link_info link_info;
 		struct bpf_program *pos;
 		const char *pos_sec_name;
-		char *tgt_name;
+		const char *tgt_name;
 		__s32 btf_id;
 
 		tgt_name = strstr(prog_name[i], "/");
-- 
2.53.0

