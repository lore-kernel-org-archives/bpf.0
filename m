Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E67C282CE
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5435A218CD
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDMBhg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:37:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34938 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfDMBhf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 21:37:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so14157217wrp.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 18:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzWi9JezzyGgcV4folYEw+ZFId6C6VeEKYbwKPOQXSY=;
        b=MZR0l2+lUEaPobSV5HNfpu6sMx9wKsBh0Ybx/NRAGfVJA4hghBZAwBz88J4qyYy18u
         f64bgy9ZdoyTJGr9Epyxfl3eXkxTuzRIMGNAWXEVifqjNZ5h9ddVYmU18h1MFIR5ssW5
         /1w2GW55Fc3odX45/kxtV1Wcli4IHb3GYoie+KPSSueeTzBZ9niYB3F0l1pP5C/SXiYL
         f46EJh1z6+H1GfBNGLrBlOMa+/YIQ5yfB1V7knA238s1+GWhTW260otpGPyBxb16+ZFa
         gpV7nFJka5I7Bsb9ugE0Gs4b2BCpKWg4eBRvPcjAEDVz3KuasMdmaTtLeLlh7q5luWI5
         rLVw==
X-Gm-Message-State: APjAAAUyrp7IGACoi6YPDK1mcgDA9bc33Ht8rGmXvdU3jXuax2JON/OO
        sCU/DldxHriFfweLaPHhtKZslzO7NxY=
X-Google-Smtp-Source: APXvYqzzIQrKYuiMA/k5Ed5yKxyaO0YlFw1wb0Od4zr235bKIsct2shc+qx8TQvf0RMmi00E0xV8Cg==
X-Received: by 2002:adf:afe1:: with SMTP id y33mr39693021wrd.288.1555119454067;
        Fri, 12 Apr 2019 18:37:34 -0700 (PDT)
Received: from raver.redhat.com (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id b11sm45936819wru.61.2019.04.12.18.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 18:37:33 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] libbpf: add binary to gitignore
Date:   Sat, 13 Apr 2019 03:37:32 +0200
Message-Id: <20190413013732.18432-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some binaries are generated when building libbpf from tools/lib/bpf/,
namely libbpf.so.0.0.2 and libbpf.so.0.
Add them to the local .gitignore.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 tools/lib/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
index 4db74758c674..fecb78afea3f 100644
--- a/tools/lib/bpf/.gitignore
+++ b/tools/lib/bpf/.gitignore
@@ -1,3 +1,4 @@
 libbpf_version.h
 FEATURE-DUMP.libbpf
 test_libbpf
+libbpf.so.*
-- 
2.21.0

