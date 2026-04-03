Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13E3CAE68
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228372; cv=none; b=kR05rlAqgXZnYFDj6Cjz47RQ9zDb6ZAPA/ZYZMy5vxvv0rcPfJpBaiHJHZjTpy9QJ6r7RW7VgajSRidatH9D78v5R6gV9NEQ3gYkdjgS4hJbjJFsPJnTTUoQIDE+gjLumoRkUzsatrPXX5hCIhZOu6PkxyvvE9kkxIYiw5wDJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228372; c=relaxed/simple;
	bh=E+XHZs2fGVQU4RACjdHGDrGQXdRXwI+e4g/Lo1v6q2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMpwhp+GLEmI352Hei6Z7a0swufOzCruJXTsG1dWz5bK62nlLSjpoCNhe0kMGCLOnJ32Z9Nt1c5A+yBDXO6rpDPaFuDkZ83xKyJ8weYzdQOZdEcltGjmKqit28oLO/vYHaq9IwfFfO0hGb0H0yN7AMGVWZ9VXmiw1nqnc2fKcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/hkhn+3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/hkhn+3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso21747435e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228370; x=1775833170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsFRXjs2Dc1/g84L0Y+9YTTSj518lfxy7T1haEQdAvc=;
        b=V/hkhn+38S7ulyX7kBLhltB+fFgUucIYni4Lt2jTlTLYSSz3mRVNLSOVN2WuKN8LXK
         8VnGgFBEngMA7oYAzoGvTae5WaNNYy3J6O4v+005AqjEiKMKQ3uq1OwOgZ8EowGBsXrk
         e5aY1LMl3JrxmpSrD6UFTuOwR/vtsRd2PlXgZ5CfpF5e+MTTmdS/R84fDqVc+ZqX25oL
         ySq+pcaHJE98nRngemPeEnWQRcp7hYUuqoWQWu+EoXVnB3HMYnbXYaPX55DlSUnLM2sI
         qOhBS1U69jMPwu+G9IZNwy0NaDijOsIUdMNEaoah3xXX7e4Q0PgHb3i6oyHhai17nOB2
         gmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228370; x=1775833170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XsFRXjs2Dc1/g84L0Y+9YTTSj518lfxy7T1haEQdAvc=;
        b=X8e7ZBHboXzrHAXUsrdXIYeeQXQ0cIJSSsU2TxPKNzUwstLj1FCvsN/e/Se9URo1M5
         q9IPADvwuYcxNkeVmEgwWFlOja3WpvkcuxYCwAb72Bx0aUCwdaj1VUUnzhVnn+rhaOcK
         MYKcq1VBCLxC1gyYD5QgvG2AIC86s63P+awpVgLiTzSpSncdG+F1ra49jdKvfEBRvd8H
         +NJrgqdCjsvZ18P0htYUIOUIS9hZ7cJbf3fmM5VWyZeIBg5HzgY59gWEAd5SHmOlHjtm
         AFzkjF3lDPckNRDY8TV3NMmQhPB9wQjofK9+DOv2o0dB1zjHMJjkiq55GFMHswzT3F1/
         GjWg==
X-Gm-Message-State: AOJu0Yxm67UIPAacn580G/oD34yw7DmTSe1rrXaACskBUJx4flK6TQK0
	TZHLvkK9uG6JO6Z8yWzLQklX+KFsT/Ad79YSlyBeFQ4yPb40Hor+Z+A6mIsTAd7ZVDY=
X-Gm-Gg: ATEYQzz40uAzsvCR6B61pCWZYoHFImh4r31B3q8WcjciE0SR8YZdgvM7+H5dD2McN5D
	4xL/EZIavUCFUnkGAkYdnx/mrkDKJnMQ0u+hyatj9THi2UcgwD79KMjlczwnbAWDq3GdhEesS0h
	0QTbl+aw9w9uR1XxnYqq5M+wNZqAf7PmoPiTpBx3SArmoovRsDvzLIYYPKM4aVMIeT8h16iKtvT
	favC0u0y9NvI5TFmNTz0cLkKytMLe1dwNYEj5Cd7IPpGPWcCQyfDhB2GyGbH8fcfFEw08W02ImY
	8xGr1YbGq2HiR7L4LIdqt9GG7sXHvXMc4CJlBcJWyRIN2rpO7slL/oAnUO65ylty7adVhxeOuAY
	xncGBLpBEVAQELi5i3R9J6Embs1WRgSvSj7avfruYp+Hhb9tTkjsPFMS2vnlblmELuKKoUhYy4Y
	Y9JqcsDcK7
X-Received: by 2002:a05:600c:8b75:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-4889978c516mr54726925e9.17.1775228369627;
        Fri, 03 Apr 2026 07:59:29 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb4fb62esm6284487241.0.2026.04.03.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:28 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:58:59 -0300
Subject: [PATCH v2 06/10] selftests/bpf: Allow test_progs to link with a
 partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-6-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1805;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=E+XHZs2fGVQU4RACjdHGDrGQXdRXwI+e4g/Lo1v6q2Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHlmfpqZa0e3FSsPSm/6s/yAsCmO92EAOj8x/YPOS9q2RTA523Bsm29p5YT3AhTzjKuDZLPYFlE
 MubEyNTxP7gU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When individual test files are skipped due to compilation failures, their
.test.o files are absent. The linker step currently lists all expected
.test.o files as explicit prerequisites, so make considers any missing one
an error.

Move TRUNNER_TEST_OBJS to the order-only prerequisite list so that their
absence does not prevent linking. Use $(wildcard ...) in the filter
expression passed to the linker so that only the objects that were actually
built are linked in.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6a3835a58f87..ca64a7678dfe 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -738,14 +738,14 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
-			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(TRUNNER_TEST_OBJS)
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^ $$(wildcard $(TRUNNER_TEST_OBJS))) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.53.0

