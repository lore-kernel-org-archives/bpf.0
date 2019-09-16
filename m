Return-Path: <SRS0=t4jm=XL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F97C49ED7
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B612067D
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNYUSbIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfIPKzz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:55:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41132 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbfIPKyq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so1272176ljg.8
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSB3pC6OCIzwVYGBAJ0R7QI4CKajD+8ovp0KUKhem8g=;
        b=pNYUSbISKlAVLelxCU1TU78GP/FlR+e7TlMVVNr+WQfkvrUyOQytDZ1zL1iVg/OgZe
         6p6VltOKoWLDC/bPlR07+PqlPVKShLC8jd3pdogkkTiie7b6Q6qbewuXTyHcmiDnXpI9
         nexFhZb6QkDjPMIgqjqoAenm82Eo5FSyqbzu2mVY2gkxjWC6rA3RJouf7eW9/956lUwo
         n3ujW3x/Y0Utc6zd+V/GzPWYnPD5jAs+aoniDRHjpYyQyNDBZcy8WMo8xx8v4czDr4/y
         wSRreUWlENL/nESYpqKX4+K4UeYnvtu6ZqfqWthcs5MXxnIME71OVkCZMJ/i342wY9xE
         /9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSB3pC6OCIzwVYGBAJ0R7QI4CKajD+8ovp0KUKhem8g=;
        b=RSfEh30DtETp31ndXS6g1ul4oO4FBK8qqETpzr+BvX0VdRds5bahbgeD2Q1a2w1qtD
         FG7yPjXPggtSDHUqDbjPcsdFqizLvmZOkATrxladT/mIjzaEpuXYu9Lz0bCD/RO9KhyF
         Z44uJBHWeIBsVc941+UxBZuwdTlIwkkqCBP1OOPytphdFlTq6w0Sa1o3vPskNAQfl0Ef
         pxtfBCItPavRVgpZ1Avwpfu7nwi3KfcsoFi3XMZTfWG0L5FLcxfId+T9SJ3vab7EOKzV
         Mornlhznfp/R2hPP1m05roOUCBFxhwW28kOWLZtFFchRThRbeZGTT+AlW71/02O8GV/q
         dGew==
X-Gm-Message-State: APjAAAWFJ8CusZ2OBZiDdFDdPI8+KWDwhaiZOvbsaysEikc3wvW80vHU
        6fcjgFxvm14Di7dj1XyN4lkRKA==
X-Google-Smtp-Source: APXvYqx/A2fPKX099Lb1d4EObHCdvUw6KNT4rOt0p0xKK+1FDVo7yE677tG2x5n4sDmWFNFZZiiWsQ==
X-Received: by 2002:a2e:9b43:: with SMTP id o3mr13477947ljj.214.1568631284266;
        Mon, 16 Sep 2019 03:54:44 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 03/14] samples: bpf: makefile: use --target from cross-compile
Date:   Mon, 16 Sep 2019 13:54:22 +0300
Message-Id: <20190916105433.11404-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 43dee90dffa4..b59e77e2250e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -195,7 +195,7 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
-CLANG_ARCH_ARGS = -target $(ARCH)
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

