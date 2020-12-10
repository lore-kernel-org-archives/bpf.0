Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4686C4361B
	for <bpf@archiver.kernel.org>; Thu, 10 Dec 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA662332A
	for <bpf@archiver.kernel.org>; Thu, 10 Dec 2020 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbgLJTnF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393423AbgLJTm6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 14:42:58 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26DC0613CF
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 11:42:18 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z24so4675183pgu.1
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8NmwOfahTCP7W/9rBoKHiTMD1hQFyRHLTlM9386FI0k=;
        b=VfbSgJ3ZeByy/fmdshk+GOwnoN1OMkhT1hfqljKJcgMYBqZrLLepi5XJGNmv4nLS2X
         cLzL6uqUCEqRAXgjbhtmX5Hre9CZLBW8pDgNPg2MP0U/kpxDhlVeJz+cO0pvCcE27GUY
         F/qCacQUZ6yLrDGAFfl2Ld0gW767PAYr0pEJz2Vxhl0gHvipyHCTcrwA+VgT8tUiqVmA
         qkR3Jcx6n/ZjzlJrhaBz1KpAtMmVlMUFl1WQ45rg300IWTrO1tuXqOmzduGm5HJiZwLl
         jQ+GueJB7p+5UFL5+nBad/5CIZ2hzzoL8fgNQCD3FpiL5KkY8rDGiZZso998a2VM2eG+
         W4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8NmwOfahTCP7W/9rBoKHiTMD1hQFyRHLTlM9386FI0k=;
        b=gH0frYAg383zSNiXgUux/Vr/9tzBWNapMOiIMryeNrGOwfEhsKzVt05eqwwISf8dnN
         SXOt4Sh1nvfxFz4qKmO32WuyhXUIWzvrUZp38ugEzY7xttRM+TwfxZk6J1yhDykUDNjs
         CPaj2MLODTLFeHSNitomnK1nBFuKoqQ+UopQoO5ronfLC5JtBvfB/bXhFl6BCmclPXON
         e6qVL3dSVY9ZaNb9XQ51rwtZZ1duvBFX7Q3yWlFKL53rijVPZM07bY8BxgdZ7f3jvaTY
         0UiyhP8Lp8HTYWnwL9fvMPxjJq0eY6981OWvnKltdLeijkxcyHw9/TWfLlb4bd1LTaoC
         kYqA==
X-Gm-Message-State: AOAM530pDbVDkXFPn9pyVjTHhy7F8ro99p19k48hUaCq/NYTFY+Dd1Fw
        lRrplmUiI3wf3p2ps4/jB0f5+tUxoIeWDdzE3g2CD07ATYlUj0WcAwgiGUXPUbsNbqpHIDeTNN0
        Q+yj7zCMJnQObNPq++C8jHHuvhMdSqtRO6z5lxgCxiqCMn23EaEaPago=
X-Google-Smtp-Source: ABdhPJz4Y5CMzEYk+SlvhT5Rmp7TZ12nbw/0m5WbOZnaJIXyeVoNu/rPSyHKwvR+e1lbYdgcTdFDlMzpbQ==
Sender: "adelg via sendgmr" <adelg@adelg.c.googlers.com>
X-Received: from adelg.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:a16])
 (user=adelg job=sendgmr) by 2002:a17:902:59dd:b029:db:cda3:39c0 with SMTP id
 d29-20020a17090259ddb02900dbcda339c0mr7810947plj.81.1607629337697; Thu, 10
 Dec 2020 11:42:17 -0800 (PST)
Date:   Thu, 10 Dec 2020 19:41:57 +0000
In-Reply-To: <20201210194157.3218806-1-adelg@google.com>
Message-Id: <20201210194157.3218806-2-adelg@google.com>
Mime-Version: 1.0
References: <20201209205301.2586678-1-adelg@google.com> <20201210194157.3218806-1-adelg@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v2] selftests/bpf: Drop the need for LLVM's llc
From:   Andrew Delgadillo <adelg@google.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        daniel@iogearbox.net, yhs@fb.com
Cc:     adelg@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLC is meant for compiler development and debugging. Consequently, it
exposes many low level options about its backend. To avoid future bugs
introduced by using the raw LLC tool, use clang directly so that all
appropriate options are passed to the back end.

Additionally, simplify the Makefile by removing the
CLANG_NATIVE_BPF_BUILD_RULE as it is not being use, stop passing
dwarfris attr since elfutils/libdw now supports the bpf backend (which
should work with any recent pahole), and stop passing alu32 since
-mcpu=v3 implies alu32.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
Changes since v1:
* do not pass +dwarfris
* do not pass +alu32 when using -mcpu=v3
---
 tools/testing/selftests/bpf/Makefile | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 944ae17a39ed..a96f63dfd8dc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -19,7 +19,6 @@ ifneq ($(wildcard $(GENHDR)),)
 endif
 
 CLANG		?= clang
-LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
@@ -256,24 +255,13 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 # $3 - CFLAGS
 # $4 - LDFLAGS
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v3 $4
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -march=bpf -mcpu=v2 $4 -filetype=obj -o $2
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but using native Clang and bpf LLC
-define CLANG_NATIVE_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -emit-llvm					\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2 $4
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
@@ -402,7 +390,6 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
-- 
2.29.2.576.ga3fc446d84-goog

