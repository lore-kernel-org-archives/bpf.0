Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB8541472
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086639; cv=none; b=C/F2W1om1sF5pKvw7uIkMw/ij7ss4oC9jHyhN/VAEpoLifGWNBiISpoosY2nXVEwjmtvaWHUHNQk4DXU0uQdu6pIVuEaHyEE6HbowdCksQR0iR7FfZayZq9japJ/yZZ6TZrqf2UfAer206Rd3h0aVA6IgIs/9aar0uzqhf3tUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086639; c=relaxed/simple;
	bh=Y1ffjjU3TrGKI2kHTODgUpjtuJFHQuy5DoAq4oKEq6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HATbbe568taqsiTd6Oz+YukXMO/GRLwAtiPWuen/8F11T9I5rNtszC9zqE7uzCCEAdwsdl5rb5vd/hCMXcOUZfin5LAU2SS/DGe9sV8iFoCezaMCPS2f9Y+hnMjCl2Ae37070CFKnRxAhIiBQPXpJnrOg1H8dDkDdeLnHtwmc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ2kbsZb; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ2kbsZb"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30b6dad2382so13201146eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792086630; x=1792691430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=grYpFloO+4FhzPg3/7Eg9rJ2UBt3fs+5KW5kcORLJrw=;
        b=WQ2kbsZbKRs/+4mwUcf39+OWJ4iv/UhN+hEbOVAiDDJAYZo99YfJP1IxxRaAxtYn7k
         XQkJHCDawGJCbqgClGb1yz0bSAu1bxtl6HZmIudd9xGt3YuiGii8TrXne1yhnmHsAt4R
         D8mPYpmHPNqdq8CM1IH/3+HGdooIuKjev1LM4hMviwijm2Ctiinvsbqv/evGVzD3zkqJ
         +EmSYd2JoEXQG5VlNSHALJz6xQMLR8+v2VHdekWwX+hQmbOWurqdibe15gMKolcAYriV
         mFgulLYlIaX6iGUmSkRS/amrSvO87fLe1M+DNJ03ucQJ5Xgue3uvoJw8x8KTy1cTrfob
         aUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086630; x=1792691430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grYpFloO+4FhzPg3/7Eg9rJ2UBt3fs+5KW5kcORLJrw=;
        b=E2w5xxl1BvLnRao1ZBk5BINac47L+LBR76gVUiEUhIO5n8Gc62cD4z1BmlsHu3rfPL
         hsZsjQVd7ToVr/4xo8p4mFj1kjpZ/bU9rsZsG8MltDrpPvw6WcNR1nm/kUvvXKv9ezKG
         YI1SnHnP81afGTHQz288SM23EdlR14YF6LT40JKlpshgCorvD4pJmlTGRqqjI5EWQicE
         WyuS76dwqyS+8vNOLxFLiwZYJVWEXPLuLBuzCd5mRf2ar7CMm3cc0HM+lDWmazudgbCc
         UcbUtIGkSV6GqfoarnqQ9D2M6jIS/4kxchDGjqb8DqeogPoB5eR5CENFA0Puszn6Pg9O
         LXbA==
X-Forwarded-Encrypted: i=1; AKwUvBy2mvoBypV7WEc4yUAGxdngkDHYTx3z1CpLj2+t4aGoXZcNEPqg8b8wdofYbx+PKxu1O4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKihkHTs9EDCpibL1tOebJv4j2F5JdHjBfgZj6sl6KoTBUDSGkI
	LricKTrKbzrdR3LIqsIuK78CYUhe9E93ZBHbYUEpNiyLE9EPFbhMoeyl
X-Gm-Gg: AYBFou08lsEKWfUnVSLnqb5Z2VvJqZsnIpBJMK2Cl6Z6ycuMfaf9vO3CzpxDcCQh+ly
	4SkCOqT5VwirwOwm2W52g6oCmWJ+cocY7U2mWMBnyH8Niy4Ak9+dq5I4DA96Ce+KMGpW3qpfU55
	IHwoXWmjt8GB76oW0pRo9aM9fjrwX34R8hNgOdFt4Cj872tx/KMS+6BFaHIPdb8XTSYYVeCjreM
	0s68hxfQvD2tgBzE7b8MLS5ahS78WhO19slQ2whbrSCXC0h6galWzSngG3DTsHlDZuUmTfEFKFC
	1p9SxTkQpUU29Dqsmrcb7nObLhu4HRT5DV0Z4sA0B++pL87QbqFV570LwRtosB0RSpG05hOKhtf
	WklxKvtHLADsada8uTKn80Gp5u9JTn97yLMNqJpfwGiGuShSnxlPowO0umRYHgkxipWXc3wQgOz
	Syu6Q/b6xg7WOpFWEQ2knhUbHG/R8xoP9Rt/dC6pCkRQyYrpKs1126jhbGpiLW/AE=
X-Received: by 2002:a05:7022:2211:b0:143:271a:308 with SMTP id a92af1059eb24-16a6222be3fmr39515113c88.46.1792086630287;
        Thu, 15 Oct 2026 10:50:30 -0700 (PDT)
Received: from gmail.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a8a4a56bsm519697c88.20.2026.10.15.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:50:29 -0700 (PDT)
From: pdsj2807@gmail.com
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palak Raval <pdsj2807@gmail.com>
Subject: [PATCH] selftests/bpf: remove unused duration variable from cgroup_attach_multi
Date: Thu, 15 Oct 2026 23:20:17 +0530
Message-ID: <20261015175022.1370503-1-pdsj2807@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Palak Raval <pdsj2807@gmail.com>

The duration variable is not referenced anywhere in the file.

Remove the unused variable.

Signed-off-by: Palak Raval <pdsj2807@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index db0b7bac78d1..9037e98f6f76 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -81,7 +81,6 @@ void serial_test_cgroup_attach_multi(void)
 	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
 	int allow_prog[7] = {-1};
 	unsigned long long value;
-	__u32 duration = 0;
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
-- 
2.43.0

