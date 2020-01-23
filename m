Return-Path: <SRS0=areF=3M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F519C33CB6
	for <bpf@archiver.kernel.org>; Thu, 23 Jan 2020 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EA5214AF
	for <bpf@archiver.kernel.org>; Thu, 23 Jan 2020 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="sAHPVyqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWPzj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:55:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51969 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAWPzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:55:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so3100736wmi.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WPgC+WzLyR0JTgO+VoeJbEDZ15TC0NlN7bHnmyGW2I=;
        b=sAHPVyqYzEvMha6fJROM+PxTgNcCuPo0cqK6Hmrx/LtDCX9xkACEVFpq3smba2rVdX
         241+QsoWj3jHFOjTX9ZOnh2/rjweZ1pugbdNMtq5P0MHHbKs8cOZTxUgwbwXY2oEE0Jj
         4aKna+SWlPYXVm8IQgZ9KUW3wS9mmOaCGtb5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WPgC+WzLyR0JTgO+VoeJbEDZ15TC0NlN7bHnmyGW2I=;
        b=EQmn7+S+J9Ln7FVeTelNZbVg7sZQcB4TBM01oTix1xBt8UAhUtLX3xCAec4OWSqAIz
         PwanRECpX60aADqS8MrOoAVpLUcXWK0XbvjO9VF4x/H6usQ0EseLl5yYGO+ePkNZxL1R
         ++CCxQarA9+tz3BNpY5gy0Ns4uq9yAN5THfW+0uhbenAmbb2EL94da2zmZYRfVWAKUJr
         i82liLDrZ+7OVTVHTOPmkdI81NtMQaf2KxVkMsRO+zrXzZGqlftt4HkvMS8aWq88aRfj
         30E6GAsoO2GJDv9+7ONbbB2VcDZp68iqQh+SYhTkM4rKgp8mNEj8miR8K+toOXSjy+C8
         IZSA==
X-Gm-Message-State: APjAAAXcATM89I1WedRBwrbpGlSHVPR0nSDGubueUyR2EFDvly5dCVoJ
        GzWaQNlk3lbV4weE4/FZygSArT2JB7nAyg==
X-Google-Smtp-Source: APXvYqxusyD9UZ0NtSJm5Rb2TIUtnZRoVYn3HHN6hF8Fj42CoPuNw7X83sITQRWfWc/8VVkI5MGWbw==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr4616036wmb.99.1579794936814;
        Thu, 23 Jan 2020 07:55:36 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id o2sm2554270wmh.46.2020.01.23.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:55:36 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 01/12] bpf, sk_msg: Don't clear saved sock proto on restore
Date:   Thu, 23 Jan 2020 16:55:23 +0100
Message-Id: <20200123155534.114313-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123155534.114313-1-jakub@cloudflare.com>
References: <20200123155534.114313-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no need to clear psock->sk_proto when restoring socket protocol
callbacks in sk->sk_prot. The psock is about to get detached from the sock
and eventually destroyed. At worst we will restore the protocol callbacks
twice.

This makes reasoning about psock state easier. Once psock is initialized,
we can count on psock->sk_proto always being set.

Also, we don't need a fallback for when socket is not using ULP.
tcp_update_ulp already does this for us.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index ef7031f8a304..41ea1258d15e 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -359,17 +359,7 @@ static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
 	sk->sk_write_space = psock->saved_write_space;
-
-	if (psock->sk_proto) {
-		struct inet_connection_sock *icsk = inet_csk(sk);
-		bool has_ulp = !!icsk->icsk_ulp_data;
-
-		if (has_ulp)
-			tcp_update_ulp(sk, psock->sk_proto);
-		else
-			sk->sk_prot = psock->sk_proto;
-		psock->sk_proto = NULL;
-	}
+	tcp_update_ulp(sk, psock->sk_proto);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
-- 
2.24.1

