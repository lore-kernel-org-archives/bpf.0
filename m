Return-Path: <SRS0=J/LN=27=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB4C33CA2
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512892072E
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="m4otZIu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgAJKuf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:50:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36587 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgAJKud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 05:50:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so1359727wru.3
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8bTZzSa5WtPZSXKjtKZfblxBexJkqukVg2cI53b8oE=;
        b=m4otZIu8qoeeg+Bw/bDam7Wj7btwghbLpDe+jf3rXaZp8NH1x1g0i39rqPJQId6IBd
         ADRvn/MfL003Th7K4lSkxO+a2Lq2w3LEv0WHJk8+3zvc9x3/wN/rOL8ZK0kv1p8AwLUT
         55AUr+TSi1znbol7ekfnmdpVpj+A1XNi0dv/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8bTZzSa5WtPZSXKjtKZfblxBexJkqukVg2cI53b8oE=;
        b=H1YI4Enb3InP8Yeu9Uzxbljd74u6CoYNwbyXTeyJvLabDGgzsAyulQWxRvUdzDVBHg
         7xb9NlQTaHDrlwiNSwzTZ1JWQtHFPsXfmxiWu+r/iOsdOA81NR8aBwcILLnvBAGTTVjs
         ZsBxZc3eOYTnbdLyR8zzXy6jVTRO6vLYbrMisLmiHMPdmX8sN7jGrjmlyBQLEavetHcV
         AE+Jh9xPfSUBz6lqfRn32xqe8RN+Ome+X7jYLU48szp0XwJxQ1ORx8dY/JdzL5+bqUjR
         nkOCl/V4o7l8RQ68rqj6SXu6WJP1cIC49kN6kw2CjUDgPUe6rWrPbqfUkWSonTwhTW/G
         kYGw==
X-Gm-Message-State: APjAAAUe8flNmsS79wj8910lgMT9/fDlfjWZaYgBC/5lCF8DSXKFDKy1
        0XD2JflBo9rlg0NEU5CDREWiK5Xk+3PwgA==
X-Google-Smtp-Source: APXvYqzNc+WTXjAzP4Yk8uU/h1J2JSIQFsd9sOsJiZTyxEQUNVLHzV/cixo54mjT9ZnNg9NsBC/Wrg==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr2966155wrp.2.1578653430727;
        Fri, 10 Jan 2020 02:50:30 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id s15sm1677500wrp.4.2020.01.10.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:50:30 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 01/11] bpf, sk_msg: Don't reset saved sock proto on restore
Date:   Fri, 10 Jan 2020 11:50:17 +0100
Message-Id: <20200110105027.257877-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110105027.257877-1-jakub@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no need to reset psock->sk_proto when restoring socket protocol
callbacks (sk->sk_prot). The psock is about to get detached from the sock
and eventually destroyed.

No harm done if we restore the protocol callbacks twice, while it makes
reasoning about psock state easier, that is once psock was initialized, we
can assume psock->sk_proto is set.

Also, we don't need a fallback for when socket is not using ULP.
tcp_update_ulp already does this for us.

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

