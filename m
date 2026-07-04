Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25723955D1
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783163438; cv=none; b=cnwlhdWeIVKzJ6PuHnp84POiVAahk9qSH30erDJ+SEmPSpdwrxeKXXVuhiyNtXOei0xUjFGjdF72wL1hN+RxJzk2qEZzCcF1gvByzNSwV9A9RuGWwH67qPuLSfqjt3Lehha65XTtEqxTUJhGRZaIVJnRGZ7zH5C3gkImyliqpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783163438; c=relaxed/simple;
	bh=VC0lbd93weWWPw0ARHHgPYB9edEsOZyLDpgojPf7rOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZLwoY6MC7qEncwJGZoylRKZk/mAKP71MYd/aPQ9Wa06bBTG+pXMYrTbvigYYOP/jVmOlmhb8JMbsuiaSFwfLF/htNYMZ0S6h4tl4tffleaSTkNCBgO28GMuvZykEIPK5TlMjNQsqnfv9+h+a2Iuqrqo/4otYRCjVo8LLE4OOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi8xKEOj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi8xKEOj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso915789a12.0
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783163436; x=1783768236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARFUOtndToaxiivfKYhDrkkb5hSNxGExw8ndgTKm3ko=;
        b=bi8xKEOj/y3xvuKg0UCthjb6j6HmmglrsNWVyZRM0RyAyW5tqiKSI3Q9cxKLCCm9nh
         mUbGVI+W6w2Yrg6zrjqkkRpF7JGCMRM87pJJwjJf34XFjQ37F3vuWIlOm7BxWpe4CPRt
         1CGgi1yBgMoLBHGL5XJZ8gb7igdFkOlc8gJoIgu8dgVRmdBnNyQa6Kxp7eQgTFqTguJv
         7zD1w3+GwP9KB21I/5T1E9qW+8vZkirNi0ti7us8O530HlmZndFYQNX2u47l/AaBkwnY
         XC23zPJkbZkGGKpU5IlITa8DUOERVekmKAExEA4XAMv7Edm/97Xul0B228m4Q9vZpa/A
         bbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783163436; x=1783768236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARFUOtndToaxiivfKYhDrkkb5hSNxGExw8ndgTKm3ko=;
        b=CHwn3Knlm54+2THg78kxqRGQDKiUu6OIiXuJ3GR46Li9bUimnrmRuGaiftb11Ylr0x
         1sQ4w4nf1QfsKxK80l4v38XFJcoFhFn5iNI4iqxGHhNYTG78hfRn+XxADz8RLjF8+59O
         lMt/9iHPrBvbE3geldQNSbzd7LAzAcO79fs1E+P2ARc699jUFawUYy+skYmfEBrpa8Gh
         tyFltq2Q4zbd9YR8oXJaWJQ3UDIX/hdr/lFJl46BwDgXy7lBCXrXgWJHQOpz6eBtuQIw
         X04oQTFldFVT3YiAChVE9+4YGoriHyIVQM0i00Vgwq1Eb6T6TYEFWBfk46s79wqFw/bJ
         rRwg==
X-Forwarded-Encrypted: i=1; AFNElJ+YSe0cI7J++fSV6+wLCmdlb/GgkCJlgvdqKiNb/AtH5eebhOiJORhogeve9bKknLGGBqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGVAl4WYGXo+QoIv2AMHBJ9oOHX8NslWxzS/GLnMkzJ6BtZVt
	R9S7xtWKLiQna+aqxIdBoYxnvDGG9u86Lgn8z3I/4Akd9Zo2vUc9QwB9
X-Gm-Gg: AfdE7ck9uefQ3teDldeIKjEjj5f/G+4UQA6pGaX0merR4oL1By5tiQUDTgYAE07rbzx
	4/++mgFG2YeVbXJMSZTJIiNWb573nr1oFf9AVKcqikuRO5SzUME54hh2klmyzJqO7H8U8stsNvD
	jCEb4IJGyq3lu8cNNhREmvzLrBOYVslvk1yPFnmv83UR/on2sNd6OeX9YaMNpoGA4BANNtJLWTV
	o7ZGEaNAcHQoL/Tq8gm2+HIVks8GVDWHpnthh/DJkg1ihzpuksuXU6fXpq8mBU5hA6Hr/FHUD7a
	XADACqw/aeL/b2gO/3lOib6O7STIOKufRRfMHTzo8J0ubYbeGpu3IUoXveVk+e0EtkhATMGnlsU
	bmP/KN9pOJaaw7dVoaIvD2JeToKYZg1SrCeVYEdOz2dBEUOUfuq8tYz/3sGGQSHGwL3JIGYij2c
	rK/AU7HR0n51uexn9EH576wJuOAEIgWkxXIP1Cac2Ab04qx8OMb/i7sQzu/A==
X-Received: by 2002:a05:6a20:a120:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c01c225648mr8224385637.0.1783163436124;
        Sat, 04 Jul 2026 04:10:36 -0700 (PDT)
Received: from fedora.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ffdd292b0sm1695968eec.2.2026.07.04.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 04:10:35 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: mrout@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix memory leak in msg_alloc_iov error path
Date: Sat,  4 Jul 2026 16:40:16 +0530
Message-ID: <20260704111016.95816-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In msg_alloc_iov(), when calloc() fails for an individual iov_base
allocation, the error path frees all previously allocated iov_base
entries but fails to free the iov array itself that was allocated
with calloc() at the beginning of the function. This results in a
memory leak of the iov array.

Add free(iov) in the unwind_iov error path to ensure proper cleanup
of all allocated memory.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index ac814eb63edb..3e6be455d158 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -436,6 +436,7 @@ static int msg_alloc_iov(struct msghdr *msg,
 unwind_iov:
 	for (i--; i >= 0 ; i--)
 		free(msg->msg_iov[i].iov_base);
+	free(iov);
 	return -ENOMEM;
 }
 
-- 
2.54.0

