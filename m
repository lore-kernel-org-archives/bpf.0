Return-Path: <SRS0=y2jO=44=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6085C10F27
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA2E22522
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 01:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dixj4Z0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCKBKA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:10:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgCKBJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 21:09:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so286887wml.4;
        Tue, 10 Mar 2020 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfWEwRjnWrI+e8fHcACmfkZeIDdYu59pur6KndMjjNY=;
        b=Dixj4Z0YJlggYSUyUQ/N9K0iThizcZjLO5mZ0kvDXMOeW/zwZcQauhE3tLJNSllkoK
         80A5vpgifCRcyJxHA6rElCdLyN5yP8L1/cYjeSkp8sApvioSr0RhOv22ecMIAb1NYTpa
         REPR/NkIA4C2Ccfqoobtar0T44RnX5Xfx4leimnUWNMcxwQ24x3USvnVXQdsW5d7VE6I
         GdlFxWjKVcOw3pqvzBMvpM2DkECy6oAJXKac34Iy4ZZfaQPb5x5ODzYR05dvvDC3NmW1
         zQhhha3u1jR56yzq1wg8w+UHevJhetmbsCgSRL5kFfrfyk0JowhjrHX+xOv0cyyM9xRB
         hq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfWEwRjnWrI+e8fHcACmfkZeIDdYu59pur6KndMjjNY=;
        b=j7j6gMvHNXXQGf1qCflY3CQUovuau3mthP5ms4O5ft9epTWa8iNXGI5W0dkxSZLhLn
         qtbtQIwklyupXH/swdL+ZtKltA2G0y3GYvpQTnVosTNckmBkWbzJ2m+PonOVhmA2NNfQ
         EbMQImWuBNUY7778M1bRWhjtuu8AI1SvFCCmMWPCfp8TRYLhTanKRLHHLrcuhzWiNEr1
         f+jPlB9X28oFQGaMC0ugFpeByiwtiUSj06T7+vZwuQJdBT/PMxIV/nXGkN0SEdPFlfrT
         vUI0mf8gyuKfvasmQ7dvO4hN6LgKP3f/2NBDCS4S3jzMK4lOqc7io3mbRDkjvwcik1Sz
         5PTg==
X-Gm-Message-State: ANhLgQ2cuRdtblifYEqLQ1K0wVq75sUFI69rshxlQ9pSYnum6gFafzlR
        CPbrGmBPpNI2tOZrPVmy8w==
X-Google-Smtp-Source: ADFU+vsrGhrH0kjCQVr6n7dem2snr5Jgxu93uqYQ1n3Q1xOAaD7eT0k5slu7U6q1CB/jTfcY653ZHA==
X-Received: by 2002:a1c:a345:: with SMTP id m66mr381869wme.114.1583888968391;
        Tue, 10 Mar 2020 18:09:28 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-15-144.as13285.net. [2.102.15.144])
        by smtp.googlemail.com with ESMTPSA id i6sm36658097wra.42.2020.03.10.18.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 18:09:28 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 3/8] tcp: Add missing annotation for tcp_child_process()
Date:   Wed, 11 Mar 2020 01:09:03 +0000
Message-Id: <20200311010908.42366-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200311010908.42366-1-jbi.octave@gmail.com>
References: <0/8>
 <20200311010908.42366-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sparse reports warning at tcp_child_process()
warning: context imbalance in tcp_child_process() - unexpected unlock
The root cause is the missing annotation at tcp_child_process()

Add the missing __releases(&((child)->sk_lock.slock)) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ad3b56d9fa71..0e8a5b6e477c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -817,6 +817,7 @@ EXPORT_SYMBOL(tcp_check_req);
 
 int tcp_child_process(struct sock *parent, struct sock *child,
 		      struct sk_buff *skb)
+	__releases(&((child)->sk_lock.slock))
 {
 	int ret = 0;
 	int state = child->sk_state;
-- 
2.24.1

