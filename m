Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BDC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4265120878
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOVGSjMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfDYQDm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:03:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42311 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfDYQDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:03:42 -0400
Received: by mail-io1-f66.google.com with SMTP id m188so386413ioa.9;
        Thu, 25 Apr 2019 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mP8S+aTEH0TfrmSoHVNIm1wecVOgLyl9+6N0y5RZVwA=;
        b=tOVGSjMKPfYnHj5fs3I7dZ8JJPOa9KvniD6MPnPhW076/Wbo/MIsW91fcqGG6DzPhH
         BnWpOVC9n9Q/8sjJXCIApjnKCDR35R21t+iUDg9EqHSMkb3vYuXu2LhWr6vCbcpFUszv
         A9XDXt/QOgcjuEVo7UkGHHj5opPE1qEkYtrw9bMUQUdelKhArwxNiFRhxAQbuu4PBdP+
         EttgbIMbL5BWoUbfcZUH9cy8hcYqT15RZs/qiBv/w2F5TjZfPClEG8lR2qYGhWGbrR9N
         H2RW0q4hzF5R09Q1cUBJCok3u5YH+qeZ4D96VQyyLXRlQwnGZoK6Zcu5D4WcfgNPzx/j
         zWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mP8S+aTEH0TfrmSoHVNIm1wecVOgLyl9+6N0y5RZVwA=;
        b=iFfo3HXtbpAsWDLsvjyHBmABM6XYI6Yc9FkfoMZge0yfrEDpWXLCohS2mmCI2RALC6
         3m005F6TNn0un0LMbe4jukaQ23Pfz5vPPbSRXH/nQGXeI8gq6tiXIoRiB7BSxYOCQUp/
         +jrW49ONSiOMf7l8b2kCVmRlDbaQq4LJzhV8NUU37te3jjkPVwAGqmdgeuuLuttx3pMZ
         ikkBeh3Io/hGyaetL2IvMdCgYue42VAbqZYeawN1BTbHd9bI/B8W6vRFua8yYXY+oyO/
         9P89jO7z9ZMj2Tex9aDvcAZ3vUeRttbNRtYKpn+uUYzFC/P3iASz8WoElzbDeDkcKMb4
         B63A==
X-Gm-Message-State: APjAAAUnhXxDiYKpbtOOiDlIr6QEihrFuofArztEZ0+w05S2icQxLH72
        xQ4pHov6uVg7fRve4DuHkP0=
X-Google-Smtp-Source: APXvYqyZdFKCFUOxxDjVPVb2hhs7xO+eX3vun8mFXjPZsituIWhIninfz8D8N92V46eOhCqQhk0K+w==
X-Received: by 2002:a6b:cd89:: with SMTP id d131mr24448277iog.213.1556208221459;
        Thu, 25 Apr 2019 09:03:41 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id y203sm10215796itb.22.2019.04.25.09.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:03:40 -0700 (PDT)
Subject: [bpf PATCH v2 2/3] bpf: sockmap remove duplicate queue free
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 25 Apr 2019 09:03:25 -0700
Message-ID: <155620820561.22884.3039312050426038300.stgit@john-XPS-13-9360>
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

