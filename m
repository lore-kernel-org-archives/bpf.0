Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB223B8BC7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342127; cv=none; b=XzUg1XX5RRsd+oqKOimRsAem0T6dJLf3xBv8pYXr+NQP5uvw1F/K4qPr9GLmDtWZbfyptaKDQ1V10V05XMGFaTfyZociJnNn789j6XzOhLNY6/zg0l6eVryArD5VfA4II+MBGEgQ0oEvas3ZVNRMnhaEH9Bfb79FHoteq02E4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342127; c=relaxed/simple;
	bh=+YBja3AAyMuyPOK7hY8a4GWFTYXYPSBMUIrp92cTH/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/C4xl7086dQ8F2FE7DMIy98OdDnOsI+FP8SyJsm7/K7VifY8EUEG53KGiUNLfh8pR4WLmS1xTCwUnyL7QcB4S7xvC5i7P78ctQSOXLOteCxNmw8022CTr+rB+e7U1brV3npCEcfzR0ZB4EdpMaUJ5oeYpEecNMCAlIVzt9FpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+ULfnEV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+ULfnEV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so76735195e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342124; x=1776946924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvrCOjn7+Dc7pEGNMqsF8NC6gFHe3KAEuMAKz+F5t7U=;
        b=D+ULfnEV1CStbBURrGak8ju4SBJkwSwwZGXDBwKDCqChiV8pUGQ0vKN2SMAejuwal4
         m6XmWp229lv/ysZ5PbLfhqiVmUrP03vsqzlZeiRZOwinqWSD0rHtLSbkwfiy0AolzO7Y
         FlsJswOrJJ344GmAzAplC3exPD+L8neDVI+AXfBESA3xuLe36QA0ivcsyy2/Liahgm8U
         yTMs2ajmjXiqdaUAINoOZ5kNgvYZ7jlHxa33GrPF3Rup7V1NOJjLMzwQItW0YBOSpiga
         CwpLy5J5dOIUEXKnFNJm27oOCswCvTZxypJ2b6oBYgZeTM4pyowaSicO3hlan77wC+em
         oAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342124; x=1776946924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvrCOjn7+Dc7pEGNMqsF8NC6gFHe3KAEuMAKz+F5t7U=;
        b=K1eXnfAbjuRutudEdcdER+7D5ZikGb2i/58LIdDTXO/H2QesA2twNEc6sYW+7d7p2j
         k3L3HYnJLqJX6gWQhGa3noUfdZaLX4AlflIVfgwPnZY3M3kXTGSZrHFJ7I7Hky+cnFSP
         GOcFvarfZebahuFEHLDrNpRQIKQhqO8FeMi09TFHTFgOlSgcrGBKvDgQlBGUqUoWN+Xm
         sg9ZFg73fSVaoYG65gOgneoqEh1VEjICo0JX8rXMQaEMoedM0KL2z9UY5zA8bQ3Qdsk7
         MoisNCQbveEJXJfMMgD//ke8FL/SvwsoYGfbZkQqymmhrdaEa10DqpFNEh6SmhHo4pgW
         pWJg==
X-Gm-Message-State: AOJu0Yx546R8z5I73dJ9T/II5Hp+b8ZDCY9HLGpP6YDPjdULc0YboLxm
	MXubKEOkvaOHKxsx0u0og6r05h45Ya0M5qAorm3KoiAL0kxm2CfDJIdnsJlfgJ16SVaZh0VqBOz
	Mq5VwSHE=
X-Gm-Gg: AeBDiev9ZYfwZ3eEq76WjoXL8mLRmJZPk+PF6ZGUE8kfo0wwtT2Y2sBmSM3km0Ff2HA
	fLuVEQCuHPWVjo5kuipnoLhEW4BZH2KXvqn327fBajaz1oEbtkgfHY6FA2ZIuzyVTUSMZNSAGLP
	qz88ye1NANJhQEDp8z8riFQ0Y57j1/PzGkF+fSermT8RNPayUXSz/O4rbVa11uTzQCOU5K5JlTu
	MDv7I5KqOX668hikufTO3eov6o6w3RnPnhxEgn5eP+1E5M4Be4KmniUHLB8rYklkCWAkPCaDdaY
	5LRHgTSwsuopH/SEZ5PTnr0gc9RgmaD/QWLPHJLTsfmOFrfw2WTKbMqU/coKDfsric5JxpfSaM6
	E/I90j8cvYnWEG6vDi7chyD7PReD3AXKBc6Om4M5ByUg8u5mKUEhR7c8icPy5IEPRBeL/gbBd/L
	IM/RBeeLik0kk=
X-Received: by 2002:a05:600d:4:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488d68ab2bfmr295279095e9.24.1776342124135;
        Thu, 16 Apr 2026 05:22:04 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84673sm7164252eec.19.2026.04.16.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:22:03 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 09:21:25 -0300
Subject: [PATCH bpf-next v6 08/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v6-8-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
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
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=2177;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=+YBja3AAyMuyPOK7hY8a4GWFTYXYPSBMUIrp92cTH/A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCjJr7qrZTvsZeXw66sAmgEJNp6GdcrYlWF3NbAxILcL6xQzFchcMR6yXSO6q6ybEvNTrrLSd05
 jOLUJE3UtxA8=
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

Place the wildcard expansion before $^ in the filter to preserve the
original link order: test objects must precede libbpf.a so that GNU ld,
which scans static archives left-to-right, pulls in archive members that
are referenced exclusively by test objects (e.g. ring_buffer__new from
ringbuf.c).

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5ad50d3ff2f8..79991dc98ddd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -758,14 +758,15 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
+$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),,$(TRUNNER_TEST_OBJS))	\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS))
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.53.0

