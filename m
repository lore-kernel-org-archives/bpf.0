Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D2390CAE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976880; cv=none; b=klfCQ46J7eRm8rgE63leJOiq6upw9VT244zoteZJ7t3lVzWhsVpaoyQ1GpmlVmqcV3LnPv8dQh8wocLEI12Jjt3dAHFxo2etqzaiutcK12c6wioSdRAsbDWHNXbEOK0ocyVV8hxUMC9YiViYj0ekT294hlN2Dj2M+ejO+xau6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976880; c=relaxed/simple;
	bh=qfsK3KtNdTDf/24y49QdjdKuG3mI9WE1CZdOT6rck40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4UzyYqvdoegdyhB4p45qrAcrvOCxNjro/16HEluf1db0iMRAUVR7YmocxGu4jKz9moc/r+VMgyNwnb3g8DuVgbozMWvPIXNEnpeLgVmeeKFibpRQ8Bj+T/NPNtra3DEi/ZAVeamU49eKjWwp8zlMNYqEv2FoiAG0zALhpW4wz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA7pdWnj; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA7pdWnj"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137dd4cc208so3185885c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 20:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780976878; x=1781581678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ypEpJRomt61fdJTwLpnXYjE3sebWbqzR+cTfomFgU=;
        b=YA7pdWnj3pVQAs37tKwv9cRN7AZDDzkbyVla+GvowoiVFbrmccl1VT3Ob5NzhgxP+Y
         C0d7aRisHSgZBKvO2zTN6QCpqaQHLrkXEqgeGd4Dx7eCfhLGpc72HziCb+5bB7uSzO1A
         ZMZoZb5CGMtqsLeHWt5wibzNnm0OS1ejZmnvKzFdXQ6O+Q/KlMpeZNZQtOnBHzDOrgPT
         fCD8jFatC2J0QcnzcCNYkJR+dnEBOePSp6FHxLsKK1VqciNR3Y9jL4Zv67XLMg7sUZKH
         g7gfltKH1UsGyzrUq2HEkRVX8aQig6axNtuywFDt3Ipdg2SBRTtOcf2/1rgsI5HBpaGh
         WDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780976878; x=1781581678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9ypEpJRomt61fdJTwLpnXYjE3sebWbqzR+cTfomFgU=;
        b=iju5N9DlkxHiN54A9GCxh0kE/E2FO2HkmQmK43dmhjqac9Hx/4ZpZ0AhKi4zIn693Y
         TXf+4XQUzwlU2Ncfr8FV/w82g6zeNQyPgTdDS81MwFmgVTtHoxEAsyt/6M4NfyODDwnN
         iN4kC4m+cSNSo6sj8T0faGtB1eQIndeC4XBberSMB7TgokSvFYEX8+ejATWNo8i+9Ya0
         INJTLC8jspq52h1d/Uwnr3OWMTssqPMJ4Hy7yYXb+mTSqrSgDznuA+CyN3rsI5oYIZM6
         7y5/7sF5MP4xtefGpUcuQFAylavGyMtVx5p7CYVgPt6Fr/Pp0NTKDPptFq2gMkQPLrHj
         9uOA==
X-Gm-Message-State: AOJu0YzyXQ58QtgDgXyxuuHgYtlXH3+QtdJrGUdhyWsunFw5Q9HiQ0NF
	lQWFRAlfOOYrcaxN4mPZ1N2iLhHjibXXUI00oKTypxHB0ZrcZtGGgTHK/sisAE71
X-Gm-Gg: Acq92OH4N9fUD6HvLnj4+c4CYnTXB54gMFA5JvgvR38RD5mVC+ooMQbykB7x9EE34RV
	0y6ZUFobl3sDh+qDTB6qLijzwVeTQyuOKxKkBvkllYnow47sTvrmbfmbBMX//RvGfRo/p7P+SCS
	PzWyot8qyUVzsRJZHSh4Jw2MiUCNy2Vdvc6ZsCAaGqS8haVRVTHU2Xp4WAFmtJQoTeEmQNp18tl
	n80xZFQhdQA6rXcLawY/imiOgifSNb8pWhlGmJwSXMtKIRYEJWcbvCK6yZc4XRKzRpPhCw6L0jC
	DRgffxx6hupnsyqBrdnArDdHcbRWO/xJwfSRHK2ooacOC6F5IjEkomL2ZSumziVLgWAJceAcwVc
	E3QIP4ROT1DrANVwqh/9T7h6KCS2osdJ8MlRny/85ZIfGSjJ25hXgXWSXQDsVNGDBKupxTUhtVq
	o3ARHQy3xj+PC2rcgjkKEK/RjS4jYvFoZzRdADxM6ER6wYfi0JHaWNfIdlbZtn/1WBzQm6/NjQo
	19ohwXmy74h5RdegwQcBd98n3YkQv9ZoMi2YNsiSYucBuMHbB5gqwflKdCc6NF2jLeqf2Twb8v6
	KGN4EZhr9OGi219QlLZnmjmg0f1kqfMLtJP7k9I=
X-Received: by 2002:a05:7022:160c:b0:12c:1288:ce63 with SMTP id a92af1059eb24-13807d7b5camr7734016c88.13.1780976877846;
        Mon, 08 Jun 2026 20:47:57 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm28011373eec.11.2026.06.08.20.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 20:47:57 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/bpf: correct CONFIG_PPC64 macro name in comment
Date: Mon,  8 Jun 2026 20:47:51 -0700
Message-ID: <20260609034754.26081-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in tools/testing/selftests/bpf/progs/test_fill_link_info.cc
incorrectly refers to CONFIG_PPC6 instead of CONFIG_PPC64. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_fill_link_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index fac33a14f200..137bd6292163 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -12,7 +12,7 @@ extern bool CONFIG_PPC64 __kconfig __weak;
 
 /* This function is here to have CONFIG_X86_KERNEL_IBT,
  * CONFIG_PPC_FTRACE_OUT_OF_LINE, CONFIG_KPROBES_ON_FTRACE,
- * CONFIG_PPC6 used and added to object BTF.
+ * CONFIG_PPC64 used and added to object BTF.
  */
 int unused(void)
 {
-- 
2.43.0

