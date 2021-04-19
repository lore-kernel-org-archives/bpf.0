Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B6BC433ED
	for <bpf@archiver.kernel.org>; Mon, 19 Apr 2021 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9345F61285
	for <bpf@archiver.kernel.org>; Mon, 19 Apr 2021 17:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhDSR5P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhDSR5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 13:57:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9BC06174A;
        Mon, 19 Apr 2021 10:56:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d124so23672418pfa.13;
        Mon, 19 Apr 2021 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQf9mcOLrtUNLG51UOBy0gl3Ky2lVF6jZ0E+cVTDSzA=;
        b=pnRru+odH83Tbsz6aQxAt6s0wPZaPwnfbEV14srN6nojtS77CdwBa8TXnZw7ZSRE1V
         YXpwvTZMYP2crraRl8YkifzDQCOJxdb8q9lC5OzfJTCGQpnhFGKv6eFuQXpNJ1H2WnEL
         pxypOQKeqz34HfJgQUZRzZIBvWP+6fG+BPsn08iMRPQlAR32m8cH74vgWLnM8jdZif7o
         uZt4kTvrMlz7N2d1HXQA9691dDCvngIpTH/+2kGCKlrVe3zh9rq7WY3bCoOkxGZcbvQs
         d2Z7KxA7CJYFR3FIfUxjLX3PYhVpRb5TrPnOOSramfNpaasy/Vm2efMJVmj0nZYPk6VT
         HvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQf9mcOLrtUNLG51UOBy0gl3Ky2lVF6jZ0E+cVTDSzA=;
        b=crIRi60jdL95OuuGbIzsQldd/h5+Pp5EalSNdXKgOQ/rT6j6vaBFtTs0dKDv0FmIW5
         2BMk64smwshm8M4XTPpLFsHBaRsDRP35m6naF+f2WBF30obWU5URJX2VpXW3wJ8yv/qo
         iwgsw/zbNJvQHO37xQ2++Fh4pRUMYFMhtHOb23v7bLyM5pw5GHL4JmzXtoO6cYX3xY4m
         o7roB1tbTGnp6oODhaHHARm6ekgfA6lTUspkg3KNZEQGlINfZys+I+teVeHMoGHzGBTE
         onnlFXaYoJcQzLgXa3KV3imt5/72uGxwutmOILxftb7sKCpXarJsWY+BZNS5bTewqnRv
         7Pug==
X-Gm-Message-State: AOAM530AHPcKywi8qCT4ONEiFBsQSgUM31Q8dnujKjhPKY8yQgo4Ybgp
        CW4ejaF50W8EVGphlZ/4GaQjfw907Wi5ag==
X-Google-Smtp-Source: ABdhPJwQZcIo+zcZf2Q6bBm/SYl3Fbjm0hF7pVFetnQ28SbBTSCG/qnORySs7j8Pqru0P2EWy7qIkA==
X-Received: by 2002:a63:e706:: with SMTP id b6mr2185486pgi.302.1618855003122;
        Mon, 19 Apr 2021 10:56:43 -0700 (PDT)
Received: from unknown.attlocal.net ([2600:1700:65a0:ab60:e9c9:f92c:88fa:755e])
        by smtp.gmail.com with ESMTPSA id g2sm119660pju.18.2021.04.19.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:56:42 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, jiang.wang@bytedance.com,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [Patch bpf-next v2 5/9] sock_map: update sock type checks for AF_UNIX
Date:   Mon, 19 Apr 2021 10:55:59 -0700
Message-Id: <20210419175603.19378-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419175603.19378-1-xiyou.wangcong@gmail.com>
References: <20210419175603.19378-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Cong Wang <cong.wang@bytedance.com>

Now AF_UNIX datagram supports sockmap and redirection,
we can update the sock type checks for them accordingly.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/core/sock_map.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 1107c9dcc969..2acdd848a895 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -533,6 +533,12 @@ static bool sk_is_udp(const struct sock *sk)
 	       sk->sk_protocol == IPPROTO_UDP;
 }
 
+static bool sk_is_unix(const struct sock *sk)
+{
+	return sk->sk_type == SOCK_DGRAM &&
+	       sk->sk_family == AF_UNIX;
+}
+
 static bool sock_map_redirect_allowed(const struct sock *sk)
 {
 	if (sk_is_tcp(sk))
@@ -552,6 +558,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	else if (sk_is_udp(sk))
 		return sk_hashed(sk);
+	else if (sk_is_unix(sk))
+		return sk->sk_state == TCP_ESTABLISHED;
 
 	return false;
 }
-- 
2.25.1

