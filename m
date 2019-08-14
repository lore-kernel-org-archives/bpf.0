Return-Path: <SRS0=gekI=WK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6049DC433FF
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1FF208C2
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1bioI/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHNRiE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:38:04 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38055 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfHNRiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 13:38:03 -0400
Received: by mail-qt1-f202.google.com with SMTP id i13so8225271qtq.5
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=80gVs8IzWGoGeL5TQc1siGuhLRsZ2VKQxE10IPj1Irs=;
        b=Q1bioI/n+qQcRZew1C8g0VJqGvV5n9pgtuUy6trAUYjnHmvSrOtv1BC0gRwtv3cIYN
         qXy3mNfP95c6J2AAmospsrxq6/YW+sZwiWl9rUqgdoxAITU7hknQQVPj4YFyLfSDDB8U
         x3kQhiAa8FnI33t9USybZgIsKakb7nP3SblL54Aieh53ARev4PKL1STrgK89hAbrxumo
         g6HCpN67+bDmvrgrEYokOsbcXIMvg5zMYUxscI6MCSfnJdUJPJXDUbRg7ovVpCZgRhZO
         PrpEl0heiaThkGfdvC8vekhSgu3wHH0lZxnaw7WybIVUervtdn0g3UVfxxyekEyydTgp
         l8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=80gVs8IzWGoGeL5TQc1siGuhLRsZ2VKQxE10IPj1Irs=;
        b=sWhzhSuIDDpiCETndVtjrrWStuCbtYASOzXf3H7Kvee+muw5Nb+YuUTIer2C3nEFAm
         wGmwNWhJB+RJ6grEGuouqTa7qSUr03XhygfTvxfNmSjP1PsTlxNODg6uQ5ZFDvV8Rd3y
         Udtjswo+RZCDm+cwlBmKRpmMCe+ARCMXWyItj2xfCm4v/lF4+j1QIM55vuzVxgqvY7I4
         +tBNYgPAtn78SRemm/l05DscKW/M1OKhLBOai+oNgxbQ2T2fdazA/EDZ2NGRaVN9A3bI
         9phxTVpjv1wZhLvGQedsAsYceg+ZDoNb5WEhgQUuamayai7ndpPjWU94BtvsVqOt8SAu
         SQAg==
X-Gm-Message-State: APjAAAXdl4n8eMbP5M7QwJshw+vYfjwZv0fPlHJK9V899dSIMBcxEjfF
        tgO3Iccate7wNSiovL1JK/stvFg=
X-Google-Smtp-Source: APXvYqzM7C2qcyJEskTtqWiuXOTMK3bdPyK7ataW8vGHhJkDbLNYXvf5f+x6KUGryz2W6YLKW13zzo4=
X-Received: by 2002:a37:ac19:: with SMTP id e25mr551488qkm.155.1565804282786;
 Wed, 14 Aug 2019 10:38:02 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:37:50 -0700
In-Reply-To: <20190814173751.31806-1-sdf@google.com>
Message-Id: <20190814173751.31806-4-sdf@google.com>
Mime-Version: 1.0
References: <20190814173751.31806-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v4 3/4] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync new sk storage clone flag.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4393bd4b2419..0ef594ac3899 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -337,6 +337,9 @@ enum bpf_attach_type {
 #define BPF_F_RDONLY_PROG	(1U << 7)
 #define BPF_F_WRONLY_PROG	(1U << 8)
 
+/* Clone map from listener for newly accepted socket */
+#define BPF_F_CLONE		(1U << 9)
+
 /* flags for BPF_PROG_QUERY */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

