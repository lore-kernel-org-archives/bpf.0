Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A20440A07
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862954; cv=none; b=n0sK2SZFYda85QG8Kp6TYUIJiJWrsFq58fCsnbDH+mGiHu7LcFXY83RWyeWEt/ELhw3EyYgvawOBii4mmt2SogDYgzDhZq0tPRGxKvqYEUlbg0lJDBcc89FjPeFi3i05oqeLZpBt0/Izc/6BhL2KpJzH68SN54pssFspPTwX7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862954; c=relaxed/simple;
	bh=EasNQqFhoWwgh34dd7JDJdAM8sYZxoBaW/XlyCRQm70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1ip0veIRkommyBPgfSYejo7ZHQevIBFv7WE33wkDNVJmb/0Ncx8BzeZOpPpSZ4isdu1g1A+IAVGibDSqRN5u20kpB7z7ifLx3xWpX7BvID60ZapZm9KQl0GV6KFnS7IXHpewE+HRV/7gaPS2xbX7opFvzdG8fmOHNu6+/y++f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ9uIH+c; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ9uIH+c"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e04df8c46so43684b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862940; x=1786467740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5c7FV/SYJaoQ6sXxC9mgd+gsIFKTyq6EQR4HjtVgA78=;
        b=EJ9uIH+cjmYOvgZ+r3r+2fGNDenub1zHssXc1Wl8tVR2MCFNTTZeIe/oaKPDcvh2Xr
         wnZdiemcSsnVvpq23+3g07BiJXXe0tR8IVJfVQY5JdeEnuDdzmFw5q9eZ+NDs0zKWRSv
         N/fWZa/0XUDnjVNfH4CUdNPsbrBhkXG+jkDP5CUNVZPtpnUOVQ51z64HlaWtIbJO+shz
         wgN4Oj4Z0RBCs1owxF3P8F4MpRDOuXsRuVv5H1yx3vQmoYxx+xtE61a32s7Iz9b7vnnU
         5xEId+NL7ozCyiAOHn6HfHv7XmHG+YV/VKZJOv1ehYTOwEsAl/sawe7o7XiSY8sEUL1F
         asTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862940; x=1786467740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5c7FV/SYJaoQ6sXxC9mgd+gsIFKTyq6EQR4HjtVgA78=;
        b=K1Id5VkiHupxNtRWb+cBuveW5WoiKhrSDa+JcN8Yi0zpGq6bznl1hkTeooiTCgyR6f
         dDxkJm5WZuYu+3/yGAnZ4kAycZuot+K9RcAacdV2M5V1PpYz0vciexY4ELKf+E8e+yLi
         +RrUyAOKgoNgWsE9r1no4vb7OcmI25rpDnFYBLSsQvftKuevYOyFfZaBc9XZ2fJBtXFY
         KoPVKDuTNYVOTUJAXXscJVfHzYO2F9sX3lActN825nu1tnv4CrSIoQCz1JF4n+XO98Ig
         k8if0O3XigPubAGyyyPA0PTpalqxJAftu4+hmV0tVyqBFZTCdAYjp/apgQ2cYhT69uZR
         z1Ng==
X-Gm-Message-State: AOJu0YyNk26GUeqXTOmHPEskyiLkx3gHbTJqVSm6wRDbajoXdt4ViNXp
	rhv65Vd9unG2MaZ7gYGw73uYhrQzPO4BZkT2IKAITNwyY5/AN/Y33yuEggGB466rRY4=
X-Gm-Gg: AR+sD11Gj7vrDN6B3m4/Ywe8SNi5UcFN1nvRrNaGZccrrbUmeqCi99HAeI+CLeiDPbv
	ON/1hoE6rF8rJYObm6E8QH5ZXsbkedLxGRq0jCcEuz/uHUZfddQsRPOKHNFu492ZRLitRb4ZB+e
	9QrDczOpqOJJGiEu8Nh0fPPrKOp8+mJxe9ykPz1ngWdxPQw0qexWc6Z3My6cNnaid/U9uni8wbY
	qLee+kM7tZ6gyeiPOYOOKs3MYkuDdITo7E93FA+40Fst74SU4m54eRAFiUDIK0AMyYgUmnm4LyB
	5bteaLiymYktR157wQ4oJfnd48sIJYwdB/TCy3e/GlLJDV10oosGFDevBvkg3nXN+P559J0y3/h
	KF2vJpiJ7U59I8BKPAfFSBmc+w4tOnUM1ECA47kCeTB4lhZAIEEIdzGKzPuekuBuZ/bV6c3u+wN
	5zCmFjuRrxcUs6hjeLLBzxvb13e3oY/YWR45YoKwpo6MobCoydt4FG8hOmEmGLWAdF0OZlC0fa/
	wlii+MEQsGB/QxxJdtzGA==
X-Received: by 2002:a05:6a00:2d0b:b0:848:5c00:fa91 with SMTP id d2e1a72fcca58-84f2e0ed967mr322068b3a.38.1785862939579;
        Tue, 04 Aug 2026 10:02:19 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:18 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v5 1/8] selftests/bpf: keep headers off the generic link command line
Date: Tue,  4 Aug 2026 10:01:49 -0700
Message-ID: <20260804170156.1709916-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
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
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438..65c702613 100644
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

