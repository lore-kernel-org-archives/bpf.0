Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7AC4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5CE205F4
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+etNVQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfDBRIl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:08:41 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:33450 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDBRIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:08:41 -0400
Received: by mail-io1-f73.google.com with SMTP id n15so11401707ioc.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j0vnY/0hcfGaryJZ/GM94CD8aGeRQIsfEF1AVEQ+s3w=;
        b=I+etNVQT2+Lx7fZzxD4N0jAbA59BMw0HQBw1bLTOtGgfcKI90gyvMI0IFa7jBIwucX
         bulQ+btfUyhC7Ylaw9jhk8AZ6S2o6skIWZg9hf6oaMGpyX32WrcHfSMPfjWGeCfAc6Ke
         C5U7zOah7h4FUaDZrVvoJi/gMUaD+npLx8SLPSHX5uspUyBgaH1BqzJta2uMwuYnCPSC
         sBAj4rHNaPXEgEqqDSDuFvgQXyfY/ujipT977xxanr8aWNUooz0Y/R7bwPeinH/7rv4x
         MaOptolNw5SrZceOe6f7G7PfEZFOozCQZsqSDr7Cxi6MYgYlY9YIL+AEXBFIvtGx2rSs
         Ea3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j0vnY/0hcfGaryJZ/GM94CD8aGeRQIsfEF1AVEQ+s3w=;
        b=fCnkGh36+TN/ozT4vB4H6U873Wc8nM27ZL6kNIYNxwLif5a1od+2hMWg9embzm8Ls/
         AMxv8KyKg/KV01XF5nrBw2x4mt7iS5oQeuyLTyiu5a5ivw99Wt+53JRHmvzc96sshCWj
         VUIDQUVQ3AFGtbIO6tqjMEO4XXIv979NCT+AS9DPl5OlwDBHHw4yBldREWM256OM/0IT
         9b/aNfoOKr5WtuU4jOfJsINYd6IIFtKK1aYSiWMz+LwhKYl3BmJ3Pla1/FT14eibjtHn
         I/LzX3FzqdlgvbsfQoY59Ust702psPcPTXZw6GdjP5M6MO36o81pzlzeBzvFI/b3BO2u
         yusw==
X-Gm-Message-State: APjAAAUG5MaE+dIvoqdzqoy11e9kO4jBIb0PjyhA4Kpa94wFHMLZiHWH
        5Ym/Oyx+NI5HOGRr5GpNtPJScto=
X-Google-Smtp-Source: APXvYqzTNb9f0zuyHoJ1WGv9OwX6IFK5hR1Y8jmgVvDVrCdgMSF0Oh7wnC3sMfF9EI8sD/jL0dhyeBA=
X-Received: by 2002:a24:3d8c:: with SMTP id n134mr7992162itn.14.1554224920254;
 Tue, 02 Apr 2019 10:08:40 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:08:32 -0700
In-Reply-To: <20190402170835.30732-1-sdf@google.com>
Message-Id: <20190402170835.30732-2-sdf@google.com>
Mime-Version: 1.0
References: <20190402170835.30732-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 1/4] selftests: bpf: tests.h should depend on .c
 files, not the output
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This makes sure we don't put headers as input files when doing
compilation, because clang complains about the following:

clang-9: error: cannot specify -o when generating multiple output files
../lib.mk:152: recipe for target 'xxx/tools/testing/selftests/bpf/test_verifier' failed
make: *** [xxx/tools/testing/selftests/bpf/test_verifier] Error 1
make: *** Waiting for unfinished jobs....
clang-9: error: cannot specify -o when generating multiple output files
../lib.mk:152: recipe for target 'xxx/tools/testing/selftests/bpf/test_progs' failed

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2aed37ea61a4..e7ee6a242146 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -206,7 +206,7 @@ ifeq ($(DWARF2BTF),y)
 endif
 
 PROG_TESTS_H := $(OUTPUT)/prog_tests/tests.h
-$(OUTPUT)/test_progs: $(PROG_TESTS_H)
+test_progs.c: $(PROG_TESTS_H)
 $(OUTPUT)/test_progs: CFLAGS += $(TEST_PROGS_CFLAGS)
 $(OUTPUT)/test_progs: prog_tests/*.c
 
@@ -229,7 +229,7 @@ $(PROG_TESTS_H): $(PROG_TESTS_DIR) $(PROG_TESTS_FILES)
 		 ) > $(PROG_TESTS_H))
 
 VERIFIER_TESTS_H := $(OUTPUT)/verifier/tests.h
-$(OUTPUT)/test_verifier: $(VERIFIER_TESTS_H)
+test_verifier.c: $(VERIFIER_TESTS_H)
 $(OUTPUT)/test_verifier: CFLAGS += $(TEST_VERIFIER_CFLAGS)
 
 VERIFIER_TESTS_DIR = $(OUTPUT)/verifier
-- 
2.21.0.392.gf8f6787159e-goog

