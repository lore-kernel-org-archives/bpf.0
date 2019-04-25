Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A7C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3913C20878
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doPDsqQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDYQD7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:03:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53335 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfDYQD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:03:59 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so974286itc.3;
        Thu, 25 Apr 2019 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WzJyuh/ma1ajUJQPClMwlhf7p+o4ybJ/vyppnP30TzU=;
        b=doPDsqQFqRqg/8j8mLsSdy2Ea/jCpse5NX1+N8m/Tx8/1wtCadZv/UxXOipbqd39wq
         n6nXR0MrsXjqYsVWq4JR36aZFAfM2uuvjnzRnXp05SbxeQ0Nig94mNlfgCD+c4JwxB/5
         Z/g2DIYPHLg9kEdybHgaqyM+e7TlOz60mvzf6SHJ25rzkDk2jF/RvdV3lmJCOxvFJY79
         l7pzMi5OgjyynM/uhujagQOhw3eESTMigyB+nMUidnz1iRHA040aq6yM929slpU7VW6W
         9ijVB4rxCxA5nWzcPaB36OC2EPVhp4E2ZR8r6aTamHjavFCMw1CuYYzSRCtqUEmakX3o
         aqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WzJyuh/ma1ajUJQPClMwlhf7p+o4ybJ/vyppnP30TzU=;
        b=k6mNk88HzYwh3T69aM+91vdyEJaCeIGrp0h7DWc8QUKIwIV8mmbVdrqhMVgrC943W6
         tomKDrP1lmTQjmBgs9vJ+MnQpLrhNY9BHwwy7QHgDlXfNSv4a4++2sfzY7M8N6lbxQYM
         8xXk5BmRNkAJkIXOuh0kFtYGfHNoro+HTqoJF/lPlaQvm/xSoblw+uo8FqpRuYp4lP2c
         /tt/6SsdxwWLzzRNdHYBj0I1doGDrY5ygWMjh9B5hQ1UULhpm7KwlULiXRk7sHuXm809
         xqrAez7ocHPxr3sjVtllQfV/OyqKvidtpL+V+seiWaB4eRvFAZ/u/o3fKlVwQektqyeL
         MBFQ==
X-Gm-Message-State: APjAAAU+ORYR56dCBURBd1h2tpPIIzJLedAhD802jQhFvaOYv5TQvviP
        U0lMj+EVRq3DXMRNqqMmZys=
X-Google-Smtp-Source: APXvYqzxIOt9YlC7G3NKGTmpDOBV8fWO/h8wGSPrOufr/4NvmkOpQ224K5+KhXQ+XJLmNnirem6jIQ==
X-Received: by 2002:a24:650d:: with SMTP id u13mr4291735itb.95.1556208238496;
        Thu, 25 Apr 2019 09:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id k18sm7722234iob.60.2019.04.25.09.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:03:57 -0700 (PDT)
Subject: [bpf PATCH v2 3/3] bpf: sockmap fix msg->sg.size account on ingress
 skb
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 25 Apr 2019 09:03:47 -0700
Message-ID: <155620822744.22884.2153244672128774358.stgit@john-XPS-13-9360>
In-Reply-To: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
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
 

