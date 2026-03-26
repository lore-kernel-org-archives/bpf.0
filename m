Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3939182E
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502684; cv=none; b=qA9wpdLlgb4zfcPlJEgAUQZJIFea55u9QREHBg0FbJAHvnUYlATd+xtVyWWi08HtwEXKuOPIcVvKPk0dpje7d8/MYMbsi295IdrL1salswS4OvqvrGl67YD3gAdg2qkKxlobkpCtB2DFw9jj+7Hykwu5vsCIwTf4G17o7yL6ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502684; c=relaxed/simple;
	bh=YSND2dbIqRFah/gQdltOEBgQYuhZeIv5jd5oE1jPP7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA9ZwA4BKJE7045wrfEp62fYe9+udwzqpjbUuhh7VLC5lH/3qEuYZAhaBgFuhLcne257hu6Hgrcg+a4qJzPE/ZHiVQUMn1yDFVz9Mn6iNRmWli50/DtM8XD0lPgtkshqLcOeVN+q6X3XpXgdEN3GLIsxsfJbFmpFPXxBgM5f0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHBQPE/J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHBQPE/J"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so279263b3a.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502683; x=1775107483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8/OjkYXynN0DecYYM8yGUhIHH6djCpmo3lC7BSgmSg=;
        b=lHBQPE/J1YJzjiOZW/Pci5QZE/ZviVEeTZdOgw36SuV2+sPYNH2OvbRbvRq4j4/bm1
         yPSuMlv40Lm1fVnB5HQUscpdWIs9YX72E4UFasSHw7eVaAe1nLZGnYkLJIZtbPrNts3u
         3C6UvBAJnpdd5fzm0C4vuANYDvRVCgIffiJ7l7PzfEDiBrjcxp4SkwywbsRovgY72HaV
         vu49xCiIkcAIyCLYqc5FobSbwqqdgVCIXCtiYhwXUziOj+NMmX2xTOHVtknaYyuUAAAd
         aajBOYlSMGMzLcSkIIt8s0H2GC+C99kDlBc5oDat9bALjFvdgMK6VTWj/dMRyON5n+Zg
         Xetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502683; x=1775107483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8/OjkYXynN0DecYYM8yGUhIHH6djCpmo3lC7BSgmSg=;
        b=BkFKQIS+r2PkY/qYWewwVrVM4YqkIfkkwsH3e4cufeSslsXMzVbvFqEWflYPln7SCu
         NOHvyWJSJP4W9v6a+Xc9FZ7hg9r8fGsZZrY4Q0a5MKomUPsrW/W/1GbXGiCDZ5R0o85Y
         8bshWhKUUZWPyTaqireHZOv+CzXadIsKcN7YfS4aSOufhVBpLuSgVM60sDwFP+H+r2uB
         b5WVkJMH9SZkUjmTmSwYLFdAgHvb60Kj9wgqyS3KkDtp+Tl5VcpGn1X5ijHklW+gaslr
         tClmGrQVYSVfuyJ/tcHOzlISRSaGf3rKZUBMlqQ2mYrao8XQ9fe8jbszMSguK5i19SZx
         S5rg==
X-Gm-Message-State: AOJu0YzyIRYF+IDDa+IvI3hY9ylRkA5CQ9gdE22Ezb6ka7Q5rAFi8TXq
	JLUS5LXs7h/ijF9/PHR/9YkaH8PPv54hfXLEI1WxfZdTLWYMBMNIvExWLLgGMg==
X-Gm-Gg: ATEYQzyieXpLuEvCISeSupSOcsRQW7Z8KojDlK0iTL+twt9EEs8rhdreDMl41syu6Fv
	TyJKRVv/YaeZpP2HDTkbBAbSy9UrIOkZLUbAt6dA4daGeLDVmf/w6dtZqJwwNHMpxfaGdPIhqkd
	CnbusVs4PRJf0IXalpR+NTr31YQmLzxZuc0RQeg0iNPcAzjr065gqqCuUbs8UTFOIUWMAjbh7vb
	N4PwnKrRoiV5w0sPDwp/JW9ud1Zh+GCdVfDEPGJ4QNWxnxvgQI3TPJ+VWKhWTPYfp+TKVk9sAPL
	G8Ua15W3NpflnSzQkVjHQDYU32fkX9eyQyzifOvalBif7aqYBh0ofKHZL+HsvnSbWbfNRV/rMYp
	FaV33MntUvKrdEdV8BhRkf4s9RS9qpHEwPu0ypOrTnJ7QbZyepAn7iZepWqSA0H5cJTzwzySUfp
	cjyMwN1WkDa4uYPYlefA2Jk+I=
X-Received: by 2002:a05:6a00:4fc5:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-82c6e15fee9mr6440519b3a.56.1774502682858;
        Wed, 25 Mar 2026 22:24:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3d5e81sm1371388b3a.51.2026.03.25.22.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:24:42 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Make sure TLD_DEFINE_KEY runs first
Date: Wed, 25 Mar 2026 22:24:37 -0700
Message-ID: <20260326052437.590158-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326052437.590158-1-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
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

