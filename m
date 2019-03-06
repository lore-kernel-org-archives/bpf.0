Return-Path: <SRS0=uow0=RJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12757C43381
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE07C206DD
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkzQ73sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCFT7b (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:59:31 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37095 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfCFT7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 14:59:31 -0500
Received: by mail-vk1-f201.google.com with SMTP id q65so7130929vkd.4
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z88xJiLosPr1XUk2OCfsa2fhSYsT5G++8dS++xiqguM=;
        b=kkzQ73sCWXt3xy9EBCuj9/84MbNsRGcmi2rFnT+3OknTMzrgOvfZBKN5hYctl34LAS
         zJeIJMuH1Zlun3McoZJ0M8tPd5fbpEaJaO1ggcv4rQqBMXtK0Hl01cx1FAEjaKeCZML4
         vdkyOV7dWFmkM/bSDjOLs3wGMAjQPHCzyjsn4PmGCyZt6nD2LoTN8P1OvMn//xWyoYev
         NpsN+69T+JUQTgX3KhwSrpn3daXZySSMXV4NBaWuw5LMYFocHZhoTdImm1Hnmyw5JXdN
         0vX71Rh/XWnSFl2/pzKNTPWquJ4PKDDePr09vPtdXUPR3HAA01xRg4hw5hOn/Cm9cGdf
         zujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z88xJiLosPr1XUk2OCfsa2fhSYsT5G++8dS++xiqguM=;
        b=hLJsDprAqkrgBmb/m/s/wCE9kLHaMZxeRFWzrcwjfJ3CNdQm5AYqDpzaMexFYDKEL7
         Hig51+wUE4Ko7QxzLucD8XJSspmrnjtgJSfd6D6JmPtRvx187xKH1fd8fRPPNtmVUr/d
         a/UURQWrEXf4VCbtMGF015enXPUZW94pVXX/8BsjZov8tB559dMmt6YKiF3dJhODqo4F
         7baj62vWZF9PuPPooyircIVLZHgqfEixjypxqv1lkVa57rUA6OTcFgG8QVdy26T6csSX
         /J5PNdGlP1TZ4FToVUrVZ+ypvwGu4Rf98AZ8h4YvzeVJILUebOgQmdI8pWcIDxgAhOf8
         sOyA==
X-Gm-Message-State: APjAAAVZ9MalXVkR+XpV1MPr3UBGz/aOvsRso19N3FWmTd/9vfXdgLay
        HjmeyG+Vh8D2PBx1lb7NGZZPEkI=
X-Google-Smtp-Source: APXvYqwLxldxGIAJV5po6Y9iHNLY2pEHZ0XZMSgfcVUHjt4gAAN5zeUSJETppRYmae8FV2NJxyeLzcY=
X-Received: by 2002:ab0:3456:: with SMTP id a22mr6221727uaq.1.1551902370056;
 Wed, 06 Mar 2019 11:59:30 -0800 (PST)
Date:   Wed,  6 Mar 2019 11:59:26 -0800
Message-Id: <20190306195927.208503-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf 1/2] selftests: bpf: fix compilation with out-of-tree $(OUTPUT)
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of related changes lumped together:
* Create prog_tests and verifier output directories; these don't exist with
  out-of-tree $(OUTPUT)
* Add missing -I (via separate TEST_{PROGS,VERIFIER}_CFLAGS) for the main tree
  ($(PWD) != $(OUTPUT) for out-of-tree)
* Add libbpf.a dependency for test_progs_32 (parallel make fails otherwise)
* Add missing "; \" after "cd" when generating test.h headers

Tested by:
$ alias m="make -s -j$(nproc)"
$ m -C tools/testing/selftests/bpf/ clean
$ m -C tools/lib/bpf/ clean
$ rm -rf xxx; mkdir xxx; m -C tools/testing/selftests/bpf/ OUTPUT=$PWD/xxx
$ m -C tools/testing/selftests/bpf/

Fixes: 3f30658830f3 ("selftests: bpf: break up test_progs - preparations")
Fixes: 2dfb40121ee8 ("selftests: bpf: prepare for break up of verifier tests")
Fixes: 3ef84346c561 ("selftests: bpf: makefile support sub-register code-gen test mode")

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile | 33 +++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 518cd587cd63..2aed37ea61a4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -153,6 +153,9 @@ endif
 endif
 endif
 
+TEST_PROGS_CFLAGS := -I. -I$(OUTPUT)
+TEST_VERIFIER_CFLAGS := -I. -I$(OUTPUT) -Iverifier
+
 ifneq ($(SUBREG_CODEGEN),)
 ALU32_BUILD_DIR = $(OUTPUT)/alu32
 TEST_CUSTOM_PROGS += $(ALU32_BUILD_DIR)/test_progs_32
@@ -162,13 +165,15 @@ TEST_CUSTOM_PROGS += $(ALU32_BUILD_DIR)/test_progs_32
 $(ALU32_BUILD_DIR)/urandom_read: $(OUTPUT)/urandom_read
 	cp $< $@
 
-$(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(ALU32_BUILD_DIR) \
+$(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(OUTPUT)/libbpf.a\
+						$(ALU32_BUILD_DIR) \
 						$(ALU32_BUILD_DIR)/urandom_read
-	$(CC) $(CFLAGS) -o $(ALU32_BUILD_DIR)/test_progs_32 $< \
-		trace_helpers.c prog_tests/*.c $(OUTPUT)/libbpf.a $(LDLIBS)
+	$(CC) $(TEST_PROGS_CFLAGS) $(CFLAGS) \
+		-o $(ALU32_BUILD_DIR)/test_progs_32 \
+		test_progs.c trace_helpers.c prog_tests/*.c \
+		$(OUTPUT)/libbpf.a $(LDLIBS)
 
 $(ALU32_BUILD_DIR)/test_progs_32: $(PROG_TESTS_H)
-$(ALU32_BUILD_DIR)/test_progs_32: CFLAGS += -I$(OUTPUT)
 $(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
 $(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR) \
@@ -202,12 +207,16 @@ endif
 
 PROG_TESTS_H := $(OUTPUT)/prog_tests/tests.h
 $(OUTPUT)/test_progs: $(PROG_TESTS_H)
-$(OUTPUT)/test_progs: CFLAGS += -I$(OUTPUT)
+$(OUTPUT)/test_progs: CFLAGS += $(TEST_PROGS_CFLAGS)
 $(OUTPUT)/test_progs: prog_tests/*.c
 
+PROG_TESTS_DIR = $(OUTPUT)/prog_tests
+$(PROG_TESTS_DIR):
+	mkdir -p $@
+
 PROG_TESTS_FILES := $(wildcard prog_tests/*.c)
-$(PROG_TESTS_H): $(PROG_TESTS_FILES)
-	$(shell ( cd prog_tests/
+$(PROG_TESTS_H): $(PROG_TESTS_DIR) $(PROG_TESTS_FILES)
+	$(shell ( cd prog_tests/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef DECLARE'; \
 		  ls *.c 2> /dev/null | \
@@ -221,11 +230,15 @@ $(PROG_TESTS_H): $(PROG_TESTS_FILES)
 
 VERIFIER_TESTS_H := $(OUTPUT)/verifier/tests.h
 $(OUTPUT)/test_verifier: $(VERIFIER_TESTS_H)
-$(OUTPUT)/test_verifier: CFLAGS += -I$(OUTPUT)
+$(OUTPUT)/test_verifier: CFLAGS += $(TEST_VERIFIER_CFLAGS)
+
+VERIFIER_TESTS_DIR = $(OUTPUT)/verifier
+$(VERIFIER_TESTS_DIR):
+	mkdir -p $@
 
 VERIFIER_TEST_FILES := $(wildcard verifier/*.c)
-$(OUTPUT)/verifier/tests.h: $(VERIFIER_TEST_FILES)
-	$(shell ( cd verifier/
+$(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
+	$(shell ( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef FILL_ARRAY'; \
 		  ls *.c 2> /dev/null | \
-- 
2.21.0.352.gf09ad66450-goog

