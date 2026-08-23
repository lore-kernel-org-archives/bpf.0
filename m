Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E2345EB5
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514187; cv=none; b=f51hJGxYzJSZT4C5MSd6s/sTyDDMy4xQaUA5IechSCb7MZ5ghLJL8kUx/8I80gV+kLD0tO9CTshRfgAJ/MUSv+aEGtGPrIuuusgodYpM6QAyQMX6n4pstd5TXgAFz2MmbclXXjOrGGqKxwJF0+0aoZ7NqgZ+VMiMJGGRnaEW7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514187; c=relaxed/simple;
	bh=+yqz6wwpJItpfxAE1IZ0k1HUNOmBF1RBdq+ePyJMMX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmxJuuR1NwEUY3yeISz/zMKSGceOMvL32p6cHNxyuCVAnXa1ar8eAGRRsKAe6/zbeRI+RdJu+G36c5QP/Lt6HQ2lLXGu002JBi37NQ+NR6/1cChbccw7xkbkm4/Ndq0EJofMx6xWH8FMKi1ehnQPUT7B/r5AMQiYif0IIgzOMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2n65c2f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2n65c2f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e347638adso2407009a91.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514186; x=1788118986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiuUJ2wWB8cbCMqy540b9XS0HZW4uhFOZpmD2jVetYo=;
        b=o2n65c2f6iDydF5R5EXEbufjbxUuhiYDUOtHM3vLXg2E6StB28Xyd3VFBDGxwLL2UF
         ZzkYba46yTdE85T3Tblq+uR3mwXJ1YUJ7+Nfs4HV+gR7F7Jcp+QokOzsBg4dwiaWOEA5
         6TrPMY/VRbKgBMGsVg3x/J9fi4kABNwH8p/83IBbaYxpOn26lI4HpKu44Jwv7SVCn6MM
         JL/LnMNnok2YYDqBJU8vUaeT+6Oz/nwCyiUEVCoZ8nOhlDEv3c6qWNNhZS5RZbNiyxjq
         3XQPwPNPh9GI36muFMsSY/0V5FfClmM471d9yot0O74xqzfDlgvBB0ZN9QEgtkgSFOEZ
         2GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514186; x=1788118986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiuUJ2wWB8cbCMqy540b9XS0HZW4uhFOZpmD2jVetYo=;
        b=IYxRrFgEtjsz+EuuHH6zmFUmh7HpS7b8k5xOk5/JJicGkTzJJxs0EA89NlGKxZWlXg
         BgXIgc0hxDlZXMHpMXXZ1BofUQFTkgWcj56u2dD7NsqpwD9EnzA0csOJeeSz38wh96XE
         wz7kizHMG3IJ6h7oE52YH+J1Gey9/ToMcJUx//80Sa+HhYANoR1qCOPq7VwHkmZvNRQK
         +YhkeguqMk8KdAMvNQT2Rjb9+HzQdAUFXfAcG2qEpgxJnYQEGbUC5pExQmKirDQWce3a
         IJ6titUm71mQsdUceR6tiimWxufLWRHIYoUOTl0WKZqg+rbOmYw/6HQB0tewa7LFXO+g
         rxkA==
X-Gm-Message-State: AFuF++lDFM/Qm3mrnRoCakkUZaCqg/vw+jE778oL/MaPMi9i4Pa/uenD
	vssk5pPVSC6JKg7lZU93m0T1u4NiWH5oVVIrcW29pEH3KBK60kNKmzeH5POH02xo
X-Gm-Gg: AR+sD111Rw+kdR0TZhzCSLHthx6wDKy8I57Ud/UUBnfgcC62C3labAyyR1wKnMkGeMp
	/cs2KhlKLl7nujn/VJhgnI4i0t4FI7+zrR7Ep6DGDg3ukyL/pquNJk3HLYi3Wr+zgJOGxP2DldA
	xx9fBnIJB9dn4v50x7zJLrTf31mPUlgDxA/asNxPem8zfm46BLBgrfnrWae3hE/FhvZDYm4kL3x
	F7Yi8MzwwjO2g718c9sRH33fcVCQCCyW8Q+/71XzY1fPRv0W9bNZ46N+ebI5ErQgRW6acbyL074
	am+TjWmnCAPn2k2BEYqd63kb/lB+2b5vFaUWKsRCMdicpIR0GWs9vcbQQ2pe6/cX8kV2rIgnNtF
	dnC4usU2cOvzePWt8tPFOEXwudZOc+FUfOjavPnkBNckyR3XxxxEnqqQefAT3CsmKkxaQEoMOLk
	Jgmt4/7jLAe1FyPkaHEdoJPAmuEizNz3FK2zXQ9OcZYgbMFTuXaVVzBtEf0chAQVg4JnC1KPVNY
	vc0r4wiAla7n04zf87jXOKMJrlL+8zHuOwoo/whUwd+wBQtzk2xxf4=
X-Received: by 2002:a17:90b:4c4d:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-395deffbb5amr22217442a91.8.1787514186017;
        Sun, 23 Aug 2026 12:43:06 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:05 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v7 1/9] selftests/bpf: keep headers off the generic link command line
Date: Sun, 23 Aug 2026 12:42:33 -0700
Message-ID: <20260823194241.3415152-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic '$(OUTPUT)/%:%.c' rule links with '$(LINK.c) $^', so
every prerequisite of such a binary lands on the compiler driver's
command line. That only works while none of them is a header: gcc
tolerates a stray .h argument on a link line, but clang treats it as
a request to precompile the header and fails with "cannot specify -o
when generating multiple output files".

Filter headers out of the recipe, with a comment: header
prerequisites on these targets are useful for dependency tracking -
the next patch declares one - and the constraint is easy to
rediscover the hard way.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5f1a3bfc0569..118a7c356e26 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -258,9 +258,12 @@ $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 
+# Headers may appear among the prerequisites for dependency tracking;
+# they must not reach the clang/gcc command line (clang treats a bare .h
+# argument as a precompiled-header job and refuses -o).
 $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+	$(Q)$(LINK.c) $(filter-out %.h,$^) $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-- 
2.43.0

