Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5740C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5522084C
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElpRmnuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfDBRIs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:08:48 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:50392 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfDBRIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:08:48 -0400
Received: by mail-yw1-f73.google.com with SMTP id j66so886810ywa.17
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dnf6HLpesKRCQbDAqSAu7ljx2eWcXwb+4YVwCfEBDCM=;
        b=ElpRmnuvPwtiGDlkywENORXowKLdOHSe4tW9uGtDuLwabmCoaWIJKAKj5sj3vE7z76
         nyKN+eTf7dJy3LG3USugFEGUDzQCVhrfeZFG7A1Ka4C8SXatMt4aky50+lu9xO5qh1ZI
         59XEwxWUKL13XIrH1MDdnmewI/OiaMFae33FQ636mnik/kkB+ucOtklzhq59V2u1atEL
         oa5CVUQ9YzQce1hr3D7T778/07QpVxcK5cxyqFOIQ6BwOKSU/uebvCFey+kbBy4fre10
         af5mvk1+D1xh+o1Vix2avK4YLpceKPu5jg9Hwp2uCUMUAz3zLr3e+GFYS7ZhO4hL+vSQ
         S1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dnf6HLpesKRCQbDAqSAu7ljx2eWcXwb+4YVwCfEBDCM=;
        b=nvDxnlcBgDeVieL4+zg+K2ACosG5G6CyboNuTBS9ZHFNezQh/9ztmjKwTEbS/LA3sm
         KOtAvFuZMbqHP6jz9u3w937Q7E99ZmIsaq6wLlcroGwpyGZEuqdU1dnvU/oPjWGJ4xV8
         cF1sYh/muCQ4BH7rywRbr05MA+5a/fOyU4ax+zkqK55DvU9J4c5ejgv5oLPaosIVgk9J
         B7w2LQ1kPPzI5PAdHfSryA3HTUzHtqo+iasY3Ls00LQUDmWYq56nO45vlCQOAM3Rma12
         B8admVOPw5PyjANahbG7H4v+CTezuEAX6H5zF947YR7GuxYydN4eQ4Fy6wrKHXYVhX6S
         SY7A==
X-Gm-Message-State: APjAAAXFTq7KtP2Mrq2x5JxhD3dCtSPUHdEwK7OBY7bOWemgSzZF3e4z
        xdPEcu1a8ISiLcatJj75ziUHaXw=
X-Google-Smtp-Source: APXvYqwSIulsDC2TsrgHk2a+1QwhHWMHX34DmDK5BAwRG7FHZK7NOVsG97AFBCfRTqsyU4ix0YKP5zw=
X-Received: by 2002:a25:2182:: with SMTP id h124mr2860520ybh.70.1554224927168;
 Tue, 02 Apr 2019 10:08:47 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:08:35 -0700
In-Reply-To: <20190402170835.30732-1-sdf@google.com>
Message-Id: <20190402170835.30732-5-sdf@google.com>
Mime-Version: 1.0
References: <20190402170835.30732-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 4/4] selftests: bpf: remove duplicate .flags
 initialization in ctx_skb.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

verifier/ctx_skb.c:708:11: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
        .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/verifier/ctx_skb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index c660deb582f1..b0fda2877119 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -705,7 +705,6 @@
 	.errstr = "invalid bpf_context access",
 	.result = REJECT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"check cb access: half, wrong type",
-- 
2.21.0.392.gf8f6787159e-goog

