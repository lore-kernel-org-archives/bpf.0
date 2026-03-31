Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D33E0239
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992964; cv=none; b=N2dFqpSmKWLO+XxUmTUlwRLd1JVdqe1fBD2XKPZW9tz+ZY2MeyZXqFy258oi9d8QWdje+MCmTb87C8fq+WCXyX+xWnR5tD7ruO3Qy5lKMhqXMphgIifSe271d7bZoTMgrYTCh++tSbzP0Bke4JMEubGzBaTsm+jW1DwMVcRKTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992964; c=relaxed/simple;
	bh=Ju4ygmTkRydc7E+rp1FYjjhcOlDxD+ZSbc+7FEaaUhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNl+LLX4RUPtcGMRdO7d3y3GIFE/k31zdejUMW1vzFHeLPiPoibq5f4N135drwj/TZeh4JMH/KQD5pAwX9zKub3I8KkWAJ8lQdLdS5moph6D+Sp8OT1axAirec9J310CmhhQRtKtG71gosN99OG6PYDLUCAC6CLSmP9E1BN+AiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvvoYc2B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvvoYc2B"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0c8362d93so36791165ad.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992962; x=1775597762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaIFgHnU4DaWjh/UiXHK1X/M4VeK512MJHWU+/hlPNs=;
        b=VvvoYc2BtMLPB0NOPQ1Fps1wWMhsd24T1dRhCz1VTHqhFAq6rE1pQmbQRIWFOgf6TM
         kafUt0p0+MhB8i3svlo0o9r5SPFmYMKqyPXSKUmoxUCe4jCtuO0tNeJ84UdWrINStZc4
         xqjyZiDjMSOuZjx69RvnIgae7i//Xwvjcw8SpnF+CSzoZXdgi4YGqXWI+f7LPeHCKyJV
         hIuJcWdo0cUZDpVNIJzbHipXM1p+WpTVpV/g1Unqsd8E5pLPsTl2RbBSXUIEAXZI5eqB
         dLTcICGH3G0O0Ljd5XU0B7fITktf57cJODjS+QQBNNwebHhKjX8yGIyCxfa5XlUIky76
         DdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992962; x=1775597762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WaIFgHnU4DaWjh/UiXHK1X/M4VeK512MJHWU+/hlPNs=;
        b=CWodlpMgzkiQpmES6xvj5YsoeIuMewicUarUUAinixOBWN5JuwzOibNQ0+jvz8DX6+
         LHAfIaHIhaDeVyMAcTDpWV8xCAIb/GbZziFm788AnchqH67PmT+V90TDBQ5DkVljWjlU
         OEu0JjyQMP/PoJHiLpwC8Npv0/+VHBS/YjJ4KcFQRKuIZyW9FysSrtHCc41tT5SJCO+M
         vkELEAwp/ee5kKUvZ9i8drBo2K9gFf1BoHCwMA5uA74oj31Hq0fQ7JZXp2pW1/NKQc2U
         kKs/2wNPE6rc3rWD9Yg8raQ7an3R2X/LzPRtUG6CnwSgIGVRosYV8V4mN7bRUKybsQ9M
         yVhQ==
X-Gm-Message-State: AOJu0YxAT8+RdUc2DsR4ng9yXh71nLw05T7dqiZnVT4FC/MMrPEw+f6A
	dfgmlnVr+7HJgUQmxBWzIuR+UTmfX/DOGdAYKfRB6+9j9PGfgR9wYWih5iF5NA==
X-Gm-Gg: ATEYQzyT631pue4mbFa2MI6yoPz96FidpZtKyLc59gJxYwpY1zZk2nMfFHOaboSWxJk
	SiYqWv/ZTI4kCmhKGcfG8PSnWwUkmK6MAWX+OjqFw0vW0qJW1fHrZcHEKHARxbXTw2XscORQC4Z
	igRtpIalm4y7rhss3dhL7BLCA9hW2vfNEATWC9z7Wu360huaUrgiE0ZLpHugEZJK70tWkIHlsQG
	wEsGsE2EHkmjm3lbKdqMG+Z7DmYKKzB/se1ayAnLQ8du0GlDInuJ1qVukRcsUf18Ofct8SKBlGK
	4oY5TbkHr4aaOGsfAsvN7YdBudLcHpLkm7Gh5MNc2F0odB0uwm44AnprLnAqPj+aaJXOTePhMUQ
	Eq/8fBpvAMEKDei34FLb5eN4En04Js6PIjInEv6Ihr5ydDS6DjhvdrRfXh6GlJ5KIUpYkwjhZfU
	0uLLpdi5+qlrhAvw==
X-Received: by 2002:a17:903:3c2b:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b269ab5ffamr7415035ad.18.1774992961785;
        Tue, 31 Mar 2026 14:36:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:18::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242766203sm145254495ad.40.2026.03.31.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:36:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Make sure TLD_DEFINE_KEY runs first
Date: Tue, 31 Mar 2026 14:35:53 -0700
Message-ID: <20260331213555.1993883-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331213555.1993883-1-ameryhung@gmail.com>
References: <20260331213555.1993883-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without specifying constructor priority of the hidden constructor
function defined by TLD_DEFINE_KEY, __tld_create_key(..., dyn_data =
false) may run after tld_get_data() called from other constructors.
Threads calling tld_get_data() before __tld_create_key(..., dyn_data
= false) will not allocate enough memory for all TLDs and later result
in OOB access. Therefore, set it to the lowest value available to
users. Note that lower means higher priority and 0-100 is reserved to
the compiler.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 366a6739c086..e242c455ddae 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -278,7 +278,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 #define TLD_DEFINE_KEY(key, name, size)			\
 tld_key_t key;						\
 							\
-__attribute__((constructor))				\
+__attribute__((constructor(101)))			\
 void __tld_define_key_##key(void)			\
 {							\
 	key = __tld_create_key(name, size, false);	\
-- 
2.52.0

