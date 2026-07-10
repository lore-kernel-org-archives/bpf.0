Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E203D6CD7
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721403; cv=none; b=aFaHJZLUIAwT7xRmLmRzGb9DINil8hwEdlDHF3qRJmRaW5Ub8leqcYOXrY98ggEwjxIp6XF8XP3O4RiFPp6u3XQydWn+XPqFUPmVG75J6XqV28UIWLDSBFMHqje6mYh60XR5C35LrTFgxkJ9YTTx0yezh7oloAgrJfiBIzIwMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721403; c=relaxed/simple;
	bh=6lkAv+z1VdbJq3O3jTSPjcCfj4Q5wG5BSAJJAOcOXHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6UouwWj6J0COZUo54ziK6Avtv3LjPWZAXMFHzjbjQ3Hs1JgrrqDpjKFzHgHs4XZYW+Gcl7kcQLEyWUpt33DlTPyAotNJ3ZbYAKkiiaFQUpmWeLwB2tqJlom7xxWvCyI5lQIw7n5buwANciK00CAfwovINUKBVAhCT1ur2YMDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S0tI3mbP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S0tI3mbP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso11956665e9.3
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783721400; x=1784326200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzUlPYC5qPANfrz/AaLisWernv7XLVGLrQnhU/QY2L0=;
        b=S0tI3mbPcygfc3OSyYX7yza6E53e6IPoU6DnHzkKppI/FxuWIssCLORe9s7IzhTWiF
         HFXTr4nQek69yYuMmQQ78z90awnGxaAqLkKtwqWqIMEJf4KE7USFeBDhXSAuPjomO5vW
         q2YajYYlSTkXmQp9xi2xPTtChMqhbaGEjPO4pEbMHvWbM464zhz2DOz3uVVBK4Fxggzc
         API859Iioy/WDMaR4v363l3yFj6SdzsmX1kcqP0t/Q0QTQe8c/BDRhnA47sHfuDe5rmv
         x2j42OECujTon9b6S/Lfp52kL38MnRegsF/P7yqGv53JW3Y8wEkfES2WwNOQYU7xI9cF
         p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721400; x=1784326200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KzUlPYC5qPANfrz/AaLisWernv7XLVGLrQnhU/QY2L0=;
        b=cAiIMjcDBkOXh3/nKlf3+JJV1n2FCLXyuAV/BYcV4P4xqTCET0QcdqImPCtk9W7We8
         mnXOfO7ED+qVLtYkgYwGSaAAzxXzvuMRCc6Em3qNtc27x4l7P6IhxVRcszGp0I35aN9y
         LKN0qesWb9KdO3E52aNV56g5ZjfZMO1r5Rp1t3pOqUJ8GADwsbXp5Z0QxGO/6wyvKHvr
         n7HwaRgoznIUV0BekN/9i6f+/KMmBrZX8W69jwu0pDg5bvBSbR2Lf/DtQ53M1NrELaFf
         KKpmqcxwdQVXu728jWChETca4A4KJjRbUgjy01FAwyVUFIES5RIvIDSXIA134FQS3PWt
         QLxw==
X-Gm-Message-State: AOJu0YxhxTqKJdFAwMXVgfy3IUsOsfSTO40IiQ6l3CGzdkJxo/6L7iws
	LDaaGQ0sEfIn7VaMcr4ta+HB1IjqFILT9/WDTAcdadv77vh0iYHm6a4s8g/yj2kPmpI=
X-Gm-Gg: AfdE7cmte13A42Jcl4VrneCmjnFTFWywMtdBb2UCDZoDN8U0kofpTkfcq6W7XFKUHS+
	GVodzOl0b0ee3P1MFRvHIZlbpt9KlwlsJCmThtodGc1VWmjBwixkA2Wwck2k1q8rLnwr63iG4nh
	hYzOXtrig8FB0I8P4EZGj9wuT7/OEt4zRUEPQE/xLrvy6fDW4+1aQj6+JlNVGjim4n9x9wR4Lto
	EN/QYtDuW9bKddwDhop/0EaTDfb8rohTuWE6mbKJI6Ro3dWZOjMfz18rRBQnB4oWMTm+gqwfqfp
	wcX865ifIx9KdpM2u2rVArzUHlQh22nT9bFr6mifF0W29t8QBBEl+s4fzB+PHzZb/alw5pr/STu
	xGd//g62BUjf9Ut2TP9gQull2uchZZZ0t6iA4djprvoJRjZ7VF5MlNGxZblWtjvwpELnA5UXhOx
	JwDw==
X-Received: by 2002:a05:600c:4ed4:b0:493:b8d9:f28b with SMTP id 5b1f17b1804b1-493f881f0fcmr5699615e9.23.1783721400302;
        Fri, 10 Jul 2026 15:10:00 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:157e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bef1bdcsm57774077b3.12.2026.07.10.15.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:09:59 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 10 Jul 2026 19:09:40 -0300
Subject: [PATCH 4/4] libbpf: Search /lib64 and /lib in resolve_full_path()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-selftests-bpf_fixes-v1-4-aa24dfd6f4f9@suse.com>
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783721384; l=1278;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6lkAv+z1VdbJq3O3jTSPjcCfj4Q5wG5BSAJJAOcOXHA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFR/tut4OCyvgDwlGseV1WK7Te9XAEVFFha7CXAmadILbP0Na3iXB7sPAJthSMsus23eA2gfg4K
 BR9Z1mD/LWwA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

attach_probe/uprobe-lib and uprobe_autoattach selftests fail with "failed
to resolve full path for libc.so.6" on older non-usrmerged distros, where
libc.so.6 lives under a top-level /lib64 or /lib rather than /usr/lib64 or
/usr/lib. Add /lib64:/lib to the search paths, alongside the existing
/usr/lib64:/usr/lib and Debian multiarch entries.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1368752aa13c..1ab939dfb7f0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12973,13 +12973,14 @@ static const char *arch_specific_lib_paths(void)
 /* Get full path to program/shared library. */
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
-	const char *search_paths[3] = {};
+	const char *search_paths[4] = {};
 	int i, perm;
 
 	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
 		search_paths[0] = getenv("LD_LIBRARY_PATH");
 		search_paths[1] = "/usr/lib64:/usr/lib";
 		search_paths[2] = arch_specific_lib_paths();
+		search_paths[3] = "/lib64:/lib";
 		perm = R_OK;
 	} else {
 		search_paths[0] = getenv("PATH");

-- 
2.54.0

