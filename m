Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B4C282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51735205ED
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DapoGMtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfDXTVq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:21:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37784 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTVq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:21:46 -0400
Received: by mail-io1-f68.google.com with SMTP id a23so13094899iot.4;
        Wed, 24 Apr 2019 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WzJyuh/ma1ajUJQPClMwlhf7p+o4ybJ/vyppnP30TzU=;
        b=DapoGMtJyJ8mWhpmvg2WPJjlaM2K2pQi13iQcrrdc/c6VcAvAGikFhlstPY7yf3q/H
         CYvNqXbkxQpTKdzK+14mrSHGR4t1szlQX4iBALH1R+yywyb1CpSBJS1SFrMKmxHoPpz/
         8Agxv81VB4qTwE8r/AWSeDL2uUsotJSxdz+mLapmKWGwRf799sh87mrd7N+n6TM/GpvX
         BL9LiPvm7o1yHkXrWfh4QWIsFz7BlDM/javAAUdXuou58iiiprlFtAe1SDEgK/kDcuj0
         n6jMmRpkMnNz0JJ46dEsjqIo0kWjbB/N1G+5VD6wltgfPgKpL0vGUFBqb+YakA/FIMxg
         QxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WzJyuh/ma1ajUJQPClMwlhf7p+o4ybJ/vyppnP30TzU=;
        b=LDkwdZLYj/7bnXLFfCYq1eU4ujZaW+ozrtXwG/1UHUiYi4lF1QEu9NDi53djlM7LqG
         4sdyfwuph0bN5RpzpIHjVeiyqoNWs/n6AkNaRr3wAaXeoNspj6gFIvLY8Sfm4lj9ncTk
         wvc0zm807KHWSGEVnVu7VX7jv0QxdDxFrvYTAypbg7M7yxKOw1wNNeuif1QFosjlua2/
         VZG9fvl1Whj+JphbJq94DWlPKAnBDhecPO2vR6ZcTo9HdVlDiejIlmTOP9bdmdhk7Uxe
         9tiKBu2Wwph6ne8+pA+NaktR1+4oubEabuR0jevH9+Q/vjZvIFQD/QX9G5f1ptrnUbel
         NdkA==
X-Gm-Message-State: APjAAAXAH/yeEWw8lWVCP10YaET19lV3gPpd/LESWnbHISjtJHaR+r3H
        elVCcyJMQFZ1CCPJG/R7s5cg5UJuzSk=
X-Google-Smtp-Source: APXvYqzC0sXvV33gzqbZ++nz8wgVbw3drkTUzXEyp5lxUVtW7C3hxOXYCLHdHKj3GAoVuvorsx/yuw==
X-Received: by 2002:a6b:bfc4:: with SMTP id p187mr11025582iof.112.1556133705670;
        Wed, 24 Apr 2019 12:21:45 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id t19sm7003543iol.72.2019.04.24.12.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:21:45 -0700 (PDT)
Subject: [bpf PATCH 3/3] bpf: sockmap fix msg->sg.size account on ingress skb
From:   John Fastabend <john.fastabend@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 24 Apr 2019 12:21:35 -0700
Message-ID: <155613369561.20131.1561988055061750379.stgit@john-XPS-13-9360>
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

When converting a skb to msg->sg we forget to set the size after the
latest ktls/tls code conversion. This patch can be reached by doing
a redir into ingress path from BPF skb sock recv hook. Then trying to
read the size fails.

Fix this by setting the size.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index cc94d921476c..782ae9eb4dce 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -411,6 +411,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
 	sk_mem_charge(sk, skb->len);
 	copied = skb->len;
 	msg->sg.start = 0;
+	msg->sg.size = copied;
 	msg->sg.end = num_sge == MAX_MSG_FRAGS ? 0 : num_sge;
 	msg->skb = skb;
 

