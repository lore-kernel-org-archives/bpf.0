Return-Path: <SRS0=t4jm=XL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5BC4CECD
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3B42067D
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYey3wmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfIPK4H (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:56:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33723 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfIPKyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so3853414lfc.0
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6kzj0QUIRS1sDUroHtM76x4Sw0PaH661mS2z6H9lrYY=;
        b=LYey3wmgdmHy2NTiQkVRdiP/+xWiXr7/VhQu0JvCqcUIAToMMaoYBOM6JFuBqaxkZ1
         JfYQeW6MTnVu/A2LKmVE2hLug+wszlySKPK3lLmm5cC6B8YCZTCUrLGdZnxzx1ACnH70
         UB4kW6+0PoqV7L3+af21M7FxoqOZMXAUDxZSKtf5Wwlpf/fPZeNLIS3PaJbluIKMIsao
         zeKD032jBuH34HlHMsQ2ZAaBWHjzEdEuE2cwW2q876Uoe+JjqzWdVvHCsWaR/4ByQm/a
         uhSDh/DlVgXPaV80sBavReU3gg/Ek+7zUMmJllxUFjANBPZRlVHU2OI0ORj/g+vLAgMn
         Ac7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6kzj0QUIRS1sDUroHtM76x4Sw0PaH661mS2z6H9lrYY=;
        b=GhscWFrKbf7w4gFumS7yWQYVfIX4SmaxqqOSHadVVgYBWQuf2Jcl+LiLIA1hZvpQBV
         KorgFeSBNeJ4TOK9ecld7gSRCe4jLdpL7DRSmMbb/LVHQ9/xeZZ+kQ78dqBfBNXraSW1
         /HCtY0jPjpyBciFP+HvoXE/AA5pANWf7qJsAtZsUCvoBPWf9wKG+u/s8iRG9an/0i2oc
         cZ78RJr23YxQUNk3tIaAOtAQPFMeuYiU/ngaTJV6pbDVn+RAgVdEq/zAzMkoeLj6V++J
         O1T7whWqy8QhmQWag3mvOE1MzQKNwL6i8N169FgmxX2sObXSLB/E1ec+YKXdcH0nXzn4
         RM5A==
X-Gm-Message-State: APjAAAVWBkBJUanmRklKaNJto/bo+yGeeM6Ez9VaksyZdfmdDzcZoVMV
        U1RhGSAxw2GgqUwevUewAJZ8tA==
X-Google-Smtp-Source: APXvYqyJD8dqwWln86DwqzCKKtbka3vRqFxZgcxtBQ23F33WqEha0eXVuyLZUBHVuwzHF7MjlDRyUQ==
X-Received: by 2002:ac2:4ad9:: with SMTP id m25mr11489559lfp.89.1568631281688;
        Mon, 16 Sep 2019 03:54:41 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 01/14] samples: bpf: makefile: fix HDR_PROBE "echo"
Date:   Mon, 16 Sep 2019 13:54:20 +0300
Message-Id: <20190916105433.11404-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

echo should be replaced with echo -e to handle '\n' correctly, but
instead, replace it with printf as some systems can't handle echo -e.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1d9be26b4edd..f50ca852c2a8 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -201,7 +201,7 @@ endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
-HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
 	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
 	echo okay)
 
-- 
2.17.1

