Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074043644CF
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066441; cv=none; b=m6LKUKnPJF6oUWQCwvwFujtzRlwHsCqnJVas9/4cpAF8a3rEra4QbDv/kW1Emm19fpxhEdRZHKQSwpqAsK7pGDvjxRNcUD7gMtC46WzVcvYdkao1HJdDK+WCmRdZFW9YImMFAwr1i76dE3J7cw/zaFnl0+gXK6r+Zwut0YVRc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066441; c=relaxed/simple;
	bh=Wrs612k4HMzgEdRdl2RtVJxH6qi+BSvMo2suBh87tOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Al5LRTNR+K7ATp3naiAnyowtCll/rE0TqXRl2ll+QXIycG7FmC2sl/1Zfm/+dYRvhpzk7XbGZ6MFTC5aMDnX7GZ96cwt0MvzRIH9i7J+pp/e9u95urKe5qZOKLUBM2K+fH7gXk2m6LXmpdLcaQOA4hwiOraeH4iJy3BHPj72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glSQkWXp; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glSQkWXp"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-307d0405e07so2220768eec.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 21:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781066439; x=1781671239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOeWxYHjR6btBdoFOnH8/C9j8Azo7z3JwI2PgFMzUYY=;
        b=glSQkWXpMqsqW40lgfuHWX1h7X0V5YGtxqVRVJrhOCEZ8veQM7HuE/kz9Y+CUeBQzE
         Ylzd6mLsljEmkY7VJs4AZUS0zBOQs0BmK1ReADf0Gzvz7TN4bBLaZJtIRpbHQNWIgcEo
         TXv6cAVrRQxvBVC19fUdtijnp2RT+FbpTDreBjkuqaWcpPoRYEafj2TQWWwRfyeqrwfZ
         Kqgs8mOa0tfzDDj0aVY/1nHt4gsOBD9rYGlRGDxoPqZyED7X0YV8LTZ0MQ2z1dL49X7w
         uOJwss9YPVG1JQC8lyOE5C6t/WK5vCOeO3bQsOlwuHcnvRblDwAgb9t11d/cYUJNsibr
         /exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066439; x=1781671239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOeWxYHjR6btBdoFOnH8/C9j8Azo7z3JwI2PgFMzUYY=;
        b=Gm4y50P6vSqkmNcsspoN2xiclfjBN6Kij6/TrExpLsNK3CEi5i7HjrG0LOCU5aQyK+
         fm3ap92/zdoZ6God2yRB5pqIek42Ka7ZEw4kjpdn7psH20h8GHxJg7Ve14lM0WHkgH4H
         vBLHHnmKRx3vd0hP/jo0hGL2AuKNcjo+KBHKeOW82MlnaQksSAvPcDGAW/x7jHAkrAMv
         XxhOe0wfYdBNBVrtW3qopof5eBUHrooE6+eTnwVwgSpJCcV+ZEHFa2slYe/zxPqpmhYZ
         HclMtyEh1ZglwoufUAFoDhoYCkw1BnIadgqu7Ui0fQmztYYPdpugeV4qNHC/6rpfivQI
         d1Lw==
X-Gm-Message-State: AOJu0YyewEUkRRl3yyQD9OMKaXnooSye24wyfIavLNkdtVY/+l1ioSGg
	FM153t8IzpK6LqcDkO/DZ7JzdTqJJu+l/aHsfnaH6vkSEG37RDHjuE7TbBHEnjcc
X-Gm-Gg: Acq92OHHrJIjuET5yQ0zZ0rPkQ6Lrrnw2wFYoJTV5I5+0d72DGznRyOIGCOUAQWvSU0
	u4cmMSD0L9vOHrVF46a7aT6VNMyYrYQtRvZgnOoU4/2ZDtgrlww7+hMaO/Gkpa2Im0CYBGrGlT7
	nvyDVSyJcauX/4mtfPrkucy2RbSyvzqlZAkC/NX8am0GY+q2ItnzyyCnLdnVuiopBhXs/7W3ce4
	96tSeKg5IwYknp+hrzIwgDoBcNo+FDgQ1i53nfMvn1W5I0KkuaaxRIG7Yrsz36kwB80jc6UQQUh
	pmUU5ADBfd/UCiu3Qic4EOyAGFO2srRvz7cVO7jI5g+RPp/5zte36EcBoLtArCWMcys6keiyTWR
	XHedxl9HxqsYglCJJWAb/NS/Emd+dH4C4rNfwFkXEqvG2yTtM/LAijPYjTqfn4iC1+YfBQDkMnE
	7yv4ubS30r1YEZikBNfA6JFFKhPjOb5qvnnM+MuAA4hrw7cGoYtZTu6/isvRr0gmCiP9++IqePy
	UZsKWPAFGgt618Op+x3P/H6kBpBJZ7Hbt4wtl08oinYwj33JWa9TJqb8p6u6Yo6dEvRJ6kyqq0G
	dqbMWEE94wRht8Xf+3pm6MeSOwr6
X-Received: by 2002:a05:693c:374c:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-3077b32a2a0mr12893217eec.30.1781066439103;
        Tue, 09 Jun 2026 21:40:39 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm24737900eec.24.2026.06.09.21.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:40:38 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2] selftests/bpf: correct CONFIG_PPC64 macro name in comment
Date: Tue,  9 Jun 2026 21:40:20 -0700
Message-ID: <20260610044023.225820-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in tools/testing/selftests/bpf/progs/test_fill_link_info.c
incorrectly refers to CONFIG_PPC6 instead of CONFIG_PPC64. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1: Fix typo in file name in commit message

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

