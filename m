Return-Path: <SRS0=vYPl=WJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7062C32750
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B204220844
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oz80OPwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfHMKYG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:24:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37753 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfHMKXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so46832222ljn.4
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vEsZUSwAdb3YjNql7rDM4PtC51lwjYe4ypkHR8meNg=;
        b=Oz80OPwmh9X4xSAJ07288MD1guPoiHr5QzEzTKNgbbW0yOVRUE+9R2dtHoUBEsUqOh
         jfyncogTYoy1qjVIr3i7veHJPy5PAhWPX4InfS2/fcPCxjXha0LkuDHcKVMFu/h35tBF
         7OvwwIzhLUNCmRZq/09ERQQedSeX9zk0DwXKJqoVegM8JC2G32PctQ3IReLpRJ+mKVDp
         HiwFTs8BXBnbAWsMmIx81qOWKhLfmDGGrY8SLnzwyu36w01+Ny16cUGqE8QmnsU/i0X2
         R5hxQLuB3m6D1bKOaEPLUABe02nOxqEFSg8c9rBfkb0AJAgNkW5LPsYVtb/aWMtMnCFx
         +XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vEsZUSwAdb3YjNql7rDM4PtC51lwjYe4ypkHR8meNg=;
        b=Sp+MBuIocSr90T6Txi/hEYZT57tjUCGA55da1pK5Qw/PUwZ3iznW6H4giykl4smjPG
         N8B2PYgKTML7Y8EayRcxzyRDHqrxjB1INchA1yJwnX5nePvjJqfs9vghHPANalGIb8MQ
         d6hEYnB4J0CgYGdor6xLWzeAwr4FtAAuOS/gKiKbY90KWb8CW+FYmpvT/vYMOKpfttaj
         YStm87HK4kOgVXDvbQoTEMETkeiT32Pbk/su33mn4kOqipVWQWL4WtQBv3L1A5CspCmv
         byh6RAwR8g6XxpGLbGjziCwxmZDhvqXOFJzHsboB1xK/DskpjuhL1J/V9lqB+cVvPnZr
         FDBg==
X-Gm-Message-State: APjAAAXiaSd9nO1ommOm6KTvhryRSb0uMOxYpmXZO+f9h2IeSDjhFFMf
        dV2Ob12GKPOKOGGfASUinz6+lQ==
X-Google-Smtp-Source: APXvYqxfBIXDeO0fClkXCBT9GDNG7S0f2BKB42eF07OqmwBW8EB8GoIyGDNisQVq/AUlsE7V5UoY4g==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr21649917ljj.34.1565691827242;
        Tue, 13 Aug 2019 03:23:47 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e87sm24796942ljf.54.2019.08.13.03.23.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:23:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 1/3] libbpf: add asm/unistd.h to xsk to get __NR_mmap2
Date:   Tue, 13 Aug 2019 13:23:16 +0300
Message-Id: <20190813102318.5521-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

That's needed to get __NR_mmap2 when mmap2 syscall is used.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 5007b5d4fd2c..f2fc40f9804c 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <asm/unistd.h>
 #include <arpa/inet.h>
 #include <asm/barrier.h>
 #include <linux/compiler.h>
-- 
2.17.1

