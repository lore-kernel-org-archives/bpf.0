Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D760C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFF1205ED
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO34IH/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfDXTVa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:21:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38064 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:21:30 -0400
Received: by mail-it1-f195.google.com with SMTP id q19so8171983itk.3;
        Wed, 24 Apr 2019 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mP8S+aTEH0TfrmSoHVNIm1wecVOgLyl9+6N0y5RZVwA=;
        b=AO34IH/2TllLmwv47sqAbo1SE4YMJlVB9rRLimNv6kshCjkI+S1UF2nsvfhigH3gJJ
         MLMJcxhxETf260fpIGQDpHApx6yFOE3IwoyeVZAYJ4lKJm82AVks6UK4YeAUypISClOZ
         vLwG8ZLVi1/pI8A8fNu8ukS6sd44GjKhNhUwx7zHW3zU91yPFt/bFU1/PnGsaFOCUQQm
         eFcvBQH4+7q5x+MZRNssh6udusKyjf9HpMUtFlwEL8tCvwULeEenFnh63NyxwKwCAcJF
         eWeqM8RnqmzZC3Zb+/dyzvTadINbKW1E6iRA8DUHXqTbKto1mB58WMbKfA8Jvjz1s6Lx
         L/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mP8S+aTEH0TfrmSoHVNIm1wecVOgLyl9+6N0y5RZVwA=;
        b=h3dOJ5mrGzuo5JvQsNY0BdFU/ptJpCkXgP6KFUMsq65SXY1cHOBfIirWrMTT4vzvm9
         4IJ+pogXy4EksjU192mZSjrE1l+Zm57RMADMN6004oIKOB0r0KeJOiB6cJtWVBGm9K/t
         oeC+r1cMC+qjKe36wVQ7CYjAtQl48ZeSpPUmGC8iVcEb6Peyar/C6jDqw+LJ7Wqvaf7G
         4Tbwu4uNxYdWVDfdR9ajkcxc/FXnUu0QZoqSTeHioUfKgv6N1txTdbLspzIQexT57Xz0
         QJAyHxQH8LgQ3YvOJM8FyDlxE8EA7em3GHc5hYW6kuzPT/cW4CENWBDzNY6Z2PWa7F5T
         BoVw==
X-Gm-Message-State: APjAAAUz7/yDkp6WtF+dUXyQ5hmk8U3gTUkPcNJArQPWMiS8uEcyrDt1
        aAcImSCmvsJwaX+T/hZVTqnyfUfY/C0=
X-Google-Smtp-Source: APXvYqxIjOmZ3JB/47YpXZOX5jXK0juWhhN3LShCHc+oIS0dZpOA7vpyp/83U9LNCJGwQavIp+2VGA==
X-Received: by 2002:a24:ba02:: with SMTP id p2mr616519itf.94.1556133689665;
        Wed, 24 Apr 2019 12:21:29 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id g4sm2875149ioc.9.2019.04.24.12.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:21:29 -0700 (PDT)
Subject: [bpf PATCH 2/3] bpf: sockmap remove duplicate queue free
From:   John Fastabend <john.fastabend@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 24 Apr 2019 12:21:19 -0700
Message-ID: <155613367954.20131.3754049633704647622.stgit@john-XPS-13-9360>
In-Reply-To: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
References: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In tcp bpf remove we free the cork list and purge the ingress msg
list. However we do this before the ref count reaches zero so it
could be possible some other access is in progress. In this case
(tcp close and/or tcp_unhash) we happen to also hold the sock
lock so no path exists but lets fix it otherwise it is extremely
fragile and breaks the reference counting rules. Also we already
check the cork list and ingress msg queue and free them once the
ref count reaches zero so its wasteful to check twice.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/ipv4/tcp_bpf.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 1bb7321a256d..4a619c85daed 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -528,8 +528,6 @@ static void tcp_bpf_remove(struct sock *sk, struct sk_psock *psock)
 {
 	struct sk_psock_link *link;
 
-	sk_psock_cork_free(psock);
-	__sk_psock_purge_ingress_msg(psock);
 	while ((link = sk_psock_link_pop(psock))) {
 		sk_psock_unlink(sk, link);
 		sk_psock_free_link(link);

