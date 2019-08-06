Return-Path: <SRS0=eF9r=WC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E8C433FF
	for <bpf@archiver.kernel.org>; Tue,  6 Aug 2019 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF95E20C01
	for <bpf@archiver.kernel.org>; Tue,  6 Aug 2019 17:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlpugaoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfHFRJM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:09:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48094 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFRJM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 13:09:12 -0400
Received: by mail-qt1-f202.google.com with SMTP id s9so79604832qtn.14
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e4SLScTqtI1V1lopKxDYlItZzmDFwVySiqM/qjPmZNY=;
        b=mlpugaoSL+UvdG+aMZebOWrryZZ4vP+9G7OKamn2nyVtPFpgbbmpjXF03u3V1uCHIO
         PI0Q/JHlk2hIhpim/6VC3cEZqw3MkdEvb29YNaGO+XU/BGKcIeXPmsPSd+SBw0lcQdwG
         YSHtJuOiQ4INcZeqIKHp6b2/OOuYoqaXSSDYzp+AFLhSq2rzbqyI7gC/o9ynidI5IuiE
         Zs/5dhRnxghmJxzIlDcwEz3zM5gJoPVH2j1VL62Ktn1WejSVlSie/+nILEStU7ocRLKa
         1v8dFIZ6rzNQ/8uGie6MYpI7ZQeVEjIc6wV8p2LfCsznb/D795+bR6OL2jUGeOg0iKZm
         MIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e4SLScTqtI1V1lopKxDYlItZzmDFwVySiqM/qjPmZNY=;
        b=PoutWX9Ds3aZEJI4eWETEIr4rLyNCblL+ZCaDVf1qD1TRe1VV4poev8rNcOZ6BnO5E
         bvdKIASC1fa+p2ziLIjnTkbptdoyM3emv1fGeRmmb66TkX63VMh6tIGy+HPJ8cIgmsnB
         KbNNgC/dfegJOiaTlT4Toi8jSF6r4rFMLeJ8WfVVR1GtO8lOqF5gO/IYzPPto7rfw5vE
         mNO+CQzLSoONSuJEZQVY4dTMZ5pVifwPuDdLP5vO3sDILt+ANgTLgT3w8bi38LtxqmRf
         sI0vMckby8MH199yVCgKjo7g0aquSPfPZijVCAKRdq+fyE+IHbby62sdd9pMkXX2KhVP
         P/YA==
X-Gm-Message-State: APjAAAXp9V8kCAgNksUjuoPte8bITdXUYHdJDqZfKEZDPhFi832DNLZ9
        2Ujq4N6zIPultk0gkWLrU/gZ9V4=
X-Google-Smtp-Source: APXvYqzsyBAb4TAh/nfup7MPTSQyaNb4sM7dMyz1UzIr4ifdwswvER3+hBKpqdLs49aF5mh/sDO+Fv4=
X-Received: by 2002:ac8:2763:: with SMTP id h32mr4225202qth.350.1565111351512;
 Tue, 06 Aug 2019 10:09:11 -0700 (PDT)
Date:   Tue,  6 Aug 2019 10:09:01 -0700
In-Reply-To: <20190806170901.142264-1-sdf@google.com>
Message-Id: <20190806170901.142264-4-sdf@google.com>
Mime-Version: 1.0
References: <20190806170901.142264-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: test_progs: drop extra
 trailing tab
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Small (un)related cleanup.

Cc: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 963912008042..beed74043933 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -278,7 +278,7 @@ enum ARG_KEYS {
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
 };
-	
+
 static const struct argp_option opts[] = {
 	{ "num", ARG_TEST_NUM, "NUM", 0,
 	  "Run test number NUM only " },
-- 
2.22.0.770.g0f2c4a37fd-goog

