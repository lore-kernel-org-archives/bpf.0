Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB609C388F9
	for <bpf@archiver.kernel.org>; Sun, 22 Nov 2020 02:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8503F207D3
	for <bpf@archiver.kernel.org>; Sun, 22 Nov 2020 02:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQD+m9rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKVCWi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 21 Nov 2020 21:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKVCWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Nov 2020 21:22:36 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6549FC0613CF
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 18:22:36 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so12972228qkq.6
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 18:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sN61+5YVYZAGnYkDvdsKJNgaYzMcuDpuLXuHjAq8FA=;
        b=uQD+m9rRblaCDd4iZB+8mVk9/5tPErRpIlyUu3YBrPHRcRe34rcC8cPVGNWSz6ZW+z
         typs/M9O94qkhIwqktm3C++hFl069ghgLB/gzCIvPWhwQ3F1Q6MakRlRruy/EIRefJhP
         7rnH195fSsDreOf8bRC6wM2Pj7azlpq+nUVegoTlIQbObQpKWlrBwH3JFYhjvOXEFMnR
         DcktZHFbfI9XUYL73XC4wn4z0WuMciva8EtHqiU4Ln3drSpel8gTAO/8JiE8yF7P799M
         cxeVI89TAGv4lQdsAbti1+03nedv0tlnbCWvHJWRN5SvE879HuU41wEEiFcvuoE0j3Ib
         H5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sN61+5YVYZAGnYkDvdsKJNgaYzMcuDpuLXuHjAq8FA=;
        b=LJgW1Ig9IR2hYMcVdqtJMPLDZC7nbho6YKbTLtNf31QGx2sN9co96AsnQXvoHOsavF
         EdPxdZqavFOztr6hfwSlCY/kDfuFVt377ZVVhk2tc48JIQEvBOTSt6xsUTXpV+ZWjOCz
         uYEB1LwY25JjAOtKP5z/lV5VZf0S5t8upDSxvJoMEr0vTfXMm4uAYeRKqQ9RHQYP/NM/
         JcAg1ntk1uHodoi40ExGJTojGIkQivY3FwcXrap1GvTKqpeLh5GNsCcnC4r7F2tHHvAP
         znozJdE7DUP1g1x6KtTb1jVAeyJZf91jQSKcSoF0FeUU0+iz8k7HgHNd7iulCZsovnlK
         lshQ==
X-Gm-Message-State: AOAM530bZK9BM5PoASTjiZp9N6V6w+w/ZaQR2IWCAbqrnsLhd2KvVEcd
        25QOuJDXsNpsoO+k5hTqlS/Bvo5HzDuXJg==
X-Google-Smtp-Source: ABdhPJzypDo6muQBjxCkz/HdgOh71zFzrj2jlw662IffNyq3qQlfZ4ZgF9pqlxOCANCG/yeAMqslyg==
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr23238259qkg.479.1606011755224;
        Sat, 21 Nov 2020 18:22:35 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id r125sm5317373qke.129.2020.11.21.18.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 18:22:34 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next 1/2] selftest/bpf: fix link in readme
Date:   Sat, 21 Nov 2020 21:22:04 -0500
Message-Id: <20201122022205.57229-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The link was bad because of invalid rst; it was pointing to itself and
was rendering badly.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/README.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index ac9eda830187..3b8d8885892d 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -2,7 +2,10 @@
 BPF Selftest Notes
 ==================
 General instructions on running selftests can be found in
-`Documentation/bpf/bpf_devel_QA.rst`_.
+`Documentation/bpf/bpf_devel_QA.rst`__.
+
+__ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
+
 
 Additional information about selftest failures are
 documented here.
-- 
2.27.0

