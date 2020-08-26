Return-Path: <SRS0=7q6j=CE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2ABC433E1
	for <bpf@archiver.kernel.org>; Wed, 26 Aug 2020 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7699320767
	for <bpf@archiver.kernel.org>; Wed, 26 Aug 2020 07:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMQVUM2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHZH4u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZH4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 03:56:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B9C061574;
        Wed, 26 Aug 2020 00:56:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so509664pjl.0;
        Wed, 26 Aug 2020 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQhOObv+lMeVrBH98+RIOt0nZTla/ZkBoT3gnKZpJ6g=;
        b=dMQVUM2LfcF3dyA0IeYUCQDV6Uud3W19yX1d/PlY9sKdtsdmQsSBHelgKbvvde5/3R
         i7JY6JNJ3rD/ocGzK+MiSd9BxUStN9sFvwTfrsjU+9IGIRraFtUcE3+SCvmnPEHYrOt9
         kvobXGr7kumAveis20yV1nvlBRtTRUltYase8FRgrwWOVM6esxK7zeEtgWdNg2o2TqUk
         Luc1rUvukw8jUHQ0kH63uPnHwTiucwLnZgJ6y//m2k0lJCqZouYyyLHxFe7mtYRkTcIW
         DVTzyZvPWwie7NTutGAtDTM+eaoVi2G9O8aggrgRre1FF7j/uwb6Fx7UR/TQWVigh18S
         wycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQhOObv+lMeVrBH98+RIOt0nZTla/ZkBoT3gnKZpJ6g=;
        b=W2XE0MehEEjDMAi5G82Vi4uoyOJX7Ei6XmD8nG9BQDBJrhjxhYGkl1C70z7ScuZJWL
         uSogGJnD7eQnHTpdOWX2ZjIDIxhrb6cu7lF4pUU3xV1mx72m80aAmfaLORoOBgYyUZ/0
         OLnYLoZImrr0QweoWehgsDZeEP9lFZog63K0tNi3bjmpmytVNNtBd27odFglJanx9/Su
         C9UrOgTMPmfhz5o/+L6RVVzw5K1Nd2cDWCZZexPKbmbtyZQJhbKkuuSGwsozr6/pm4Yp
         aWVGZ9X3uHhM7lO/oTU7fUvPrCDgzlpLEDLcP3qnj9MErw+xNHGL8w1JHpjZlbalpWE2
         /LjA==
X-Gm-Message-State: AOAM530PRrUv8x4kn04tNQd8j0oXSttX3I6cx/Z3Z8ZvnfRyMdnOTW6v
        FF5Ww4ILUWDj9maQzSBS9TA3yKOJLA8=
X-Google-Smtp-Source: ABdhPJwrCG4NQcUg5+X4kECL4J44UXkxe5monYE8rncYwMfmGhT59HMGGOfFVCnJx5SlXCgzvCWjFw==
X-Received: by 2002:a17:90a:2a84:: with SMTP id j4mr5025904pjd.135.1598428607699;
        Wed, 26 Aug 2020 00:56:47 -0700 (PDT)
Received: from localhost.localdomain (c-24-130-33-210.hsd1.ca.comcast.net. [24.130.33.210])
        by smtp.gmail.com with ESMTPSA id o65sm1796100pfg.105.2020.08.26.00.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 00:56:46 -0700 (PDT)
From:   Alex Gartrell <alexgartrell@gmail.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alex Gartrell <alexgartrell@gmail.com>
Subject: [PATCH bpf-next] libbpf: Fix unintentional success return code in bpf_object__load
Date:   Wed, 26 Aug 2020 00:55:49 -0700
Message-Id: <20200826075549.1858580-1-alexgartrell@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are code paths where EINVAL is returned directly without setting
errno. In that case, errno could be 0, which would mask the
failure. For example, if a careless programmer set log_level to 10000
out of laziness, they would have to spend a long time trying to figure
out why.

Fixes: 4f33ddb4e3e2 ("libbpf: Propagate EPERM to caller on program load")
Signed-off-by: Alex Gartrell <alexgartrell@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2e2523d8bb6d..8f9e7d281225 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6067,7 +6067,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		free(log_buf);
 		goto retry_load;
 	}
-	ret = -errno;
+	ret = errno ? -errno : -LIBBPF_ERRNO__LOAD;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
 	pr_perm_msg(ret);
-- 
2.26.0

