Return-Path: <SRS0=ocPE=4W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2989C3F2CE
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 00:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E82146E
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 00:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583368601;
	bh=K9IFr31pFu37LPR+Umf66+raJbdx8VqiMGO9oMTUh6M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kYqFdXRADFwAWvUUajvIBvCOMCbqgMf2ob+TgiIthUK2yGNv43hFJInsjH7EgiZty
	 RyXgMhFXpSKzrj3LusXGhoJGnpe9H0aerUz4KC4t5UbsMopzFIdPMjNt+sWXTxWkIo
	 pM7XYG1Y+6V2Pn51nWan7VnsH7G6kDohtbby6I6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgCEAgh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:36:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32824 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388567AbgCEAgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 19:36:37 -0500
Received: by mail-io1-f68.google.com with SMTP id r15so4583649iog.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIvX0AGMbgxv4/m6WT+pMJ8EIpqBiUC/PmxWkNGeTko=;
        b=PhSdLw/yrpS/dRaAl33LSLQA0eklLHbyPx2WtBHA5gt3yB5fopfsk4mxkA+52xvqhX
         LgFLy9u42Z2GC79/HmsDVlsg17To6S25aq6YzK7mzm+e8wSy4WoIKI7fwio8eyTX8hfl
         TtTlUG7aQahYP7QAvSO2Ta5+kunpzaYoYdcdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIvX0AGMbgxv4/m6WT+pMJ8EIpqBiUC/PmxWkNGeTko=;
        b=dV8bcPsd0a6TKkeV6TkcroMOU6WTS9Mzz3WY/qwFqm9A6ulW+A6Rp5YBnFx7ptze07
         lBZGzKXRL3x4FkU4stVG++NGBQ9mvKukCSTgAsU6j/M2ZHqXbnBajTcclOaxdu/2yabf
         bkDWVby/N3yoZiKoL4CZCb3+PcmBlFO3PWb8T7qnfZL2cIY5VlBUMtKlQJulGtpNyEvL
         B4LJMAV02F1d2u6yb4+8oRw0wz/r3nGFjpO2DcZLXmWhOXjMmMlugBkd0DDSjnnmXBt/
         clz5kizrLrYcdYvVTxeMwNdK9+ulW9tXTcyBpwAzLu+bw4nJZlo8NNkJJBvXz1PqUjFe
         vxtA==
X-Gm-Message-State: ANhLgQ0ADhqCbi7s4uNTKBsIFrbOGHb2/QkUFFetWmkXPBhIcfoiNj6Y
        AEQ0aXZRRZMRnug2MxYEHgQ4Mg==
X-Google-Smtp-Source: ADFU+vu80pHUWuXIar7a/NeiyuPykachkqRMBLRI9m0O4J+f56mz7RGfR/avLQkVaOPdAnh7e3ivfA==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr1029310iop.130.1583368596452;
        Wed, 04 Mar 2020 16:36:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm2828404ilb.29.2020.03.04.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:36:35 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v2 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed,  4 Mar 2020 17:36:27 -0700
Message-Id: <20200305003627.31900-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_CUSTOM_PROGS to continue to do custom
build to preserve dependency on kselftest_harness.h local header.
This change applies cutom rule to seccomp_bpf seccomp_benchmark
for a simpler logic. 

Uses $(OUTPUT) defined in lib.mk to handle build relocation.

The following use-cases work with this change:

In seccomp directory:
make all and make clean

From top level from main Makefile:
make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
 CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/Makefile | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..355bcbc0394a 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
+CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
 .PHONY: all clean
 
-BINARIES := seccomp_bpf seccomp_benchmark
-CFLAGS += -Wl,-no-as-needed -Wall
+include ../lib.mk
+
+# OUTPUT set by lib.mk
+TEST_CUSTOM_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
+$(TEST_CUSTOM_PROGS): ../kselftest_harness.h
 
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
+all: $(TEST_CUSTOM_PROGS)
 
-all: $(BINARIES)
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)
-- 
2.20.1

