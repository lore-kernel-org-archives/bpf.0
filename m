Return-Path: <SRS0=FlKb=3Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A122C2D0DB
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 12:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5115D2087F
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 12:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X9pyWWq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0Mzl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:55:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35115 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgA0Mzk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so6419862ljb.2
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bpXdiYGZ1Z9GKMQRebyUDAntELHMrzN4ZukdQWXFak=;
        b=X9pyWWq8sJzmtiXz4Pv0fB8mohZeb4WOJDp8B/F0KUaj2/7L7UyPQlSpkq6W91SECg
         FyudM9FyPK0yH+WNJvd5nekqLcN7clf3MDPVxMzYhzfbdF6qOssLk7SX7BMx3MA4ip2c
         vopS411AeJd2PmTR1UoMuohTps6T8uv/qXjr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bpXdiYGZ1Z9GKMQRebyUDAntELHMrzN4ZukdQWXFak=;
        b=VfZrzuvF6MbYwoBfi5ajuQAIYyZfbaf/GXckiMhoAzBmw1Ur0wI8dNmZ3vgqeW2Y+H
         +YvdePbYtl0CXp2z1DEE+PrxqqwBafChxf/6KrCaOQ0NP1379VlSR9Z6vto1mwxCm0Ml
         //NsgKFyhBcXTHaoaQmo8ir/GMU2XQif7Hr5Dg1yJdNo8ANUv0nVXhKQXpIpIQXH2wEl
         Do7A5fBiE36tCTtZ1vuyx43pHzlq9qlhf/3qev/Pg5BtJ/hnYlTLJXt7bComrAZl7PDl
         D2OuFYx0NrClihzaaYDMaVoVH1M5yDQDKo/8OIPJd6OXzZ0HTQMNYz3OLP4UNY/a+Z2C
         /iKw==
X-Gm-Message-State: APjAAAXVPSJBD7A0hgL02xWRT76S5VX4Jg6FQJiJD1WlavlJAge9l7hO
        IsD9dlmc5q8VxK+uIGkSztb6K+QrnEDmDg==
X-Google-Smtp-Source: APXvYqxC1E9Y52fY5UaDEpuJLOJRzmAPoDKrkG2yavnXCKWBddDI0kgo1rJP6Iixez2Y1xgW+0fTAQ==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr9541313ljj.182.1580129737882;
        Mon, 27 Jan 2020 04:55:37 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id g15sm8103722ljn.32.2020.01.27.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:55:37 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v5 01/12] bpf, sk_msg: Don't clear saved sock proto on restore
Date:   Mon, 27 Jan 2020 13:55:23 +0100
Message-Id: <20200127125534.137492-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127125534.137492-1-jakub@cloudflare.com>
References: <20200127125534.137492-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no need to clear psock->sk_proto when restoring socket protocol
callbacks in sk->sk_prot. The psock is about to get detached from the sock
and eventually destroyed. At worst we will restore the protocol callbacks
and the write callback twice.

This makes reasoning about psock state easier. Once psock is initialized,
we can count on psock->sk_proto always being set.

Also, we don't need a fallback for when socket is not using ULP.
tcp_update_ulp already does this for us.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 14d61bba0b79..d90ef61712a1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -359,22 +359,7 @@ static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
 	sk->sk_prot->unhash = psock->saved_unhash;
-
-	if (psock->sk_proto) {
-		struct inet_connection_sock *icsk = inet_csk(sk);
-		bool has_ulp = !!icsk->icsk_ulp_data;
-
-		if (has_ulp) {
-			tcp_update_ulp(sk, psock->sk_proto,
-				       psock->saved_write_space);
-		} else {
-			sk->sk_prot = psock->sk_proto;
-			sk->sk_write_space = psock->saved_write_space;
-		}
-		psock->sk_proto = NULL;
-	} else {
-		sk->sk_write_space = psock->saved_write_space;
-	}
+	tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
-- 
2.24.1

