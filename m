Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB660C433E0
	for <bpf@archiver.kernel.org>; Thu, 11 Mar 2021 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCF064FA8
	for <bpf@archiver.kernel.org>; Thu, 11 Mar 2021 11:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhCKL2f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCKL2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 06:28:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647C7C061574
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:28:05 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 15so1674590ljj.0
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/oLxJnVlYANLfBTeS5SgMp+EjHUs0oG6jcCk59XpyBE=;
        b=nYw0bICQoa2ju573FKQi6+gOA/3HJL3MMnRlu60CrPcMtLIJV7R6b8KfIr4qPmORcc
         fsewcNKzol30XBVVCpuhQ2sILQLWCzQwOjbjOt1PSp20mrmv9ydFMchCenXhN0V8I7w5
         33uHpdUeaKXKnXUYUZuV5vimn71MQjvCCMK3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/oLxJnVlYANLfBTeS5SgMp+EjHUs0oG6jcCk59XpyBE=;
        b=O7wQf1AiNC/LuQx3SgqSdCwP64pHXsH3ek1rum5FKxOd4aDr8lnoeixtbWDGqbU4GZ
         3Lv/c/XhMCzxJaBpDkCc60OJX/z5DKheDNbgzoqQ/A1cFXA9catmxUvq6K+LVy9/IDRr
         gFpzdyiQhrGlAeQwkTzpxl43ei+eK1p4liN2SpVS59kFm26UD9AwmrzuIdFclrtl/yCn
         AyCAdFHx9YQyLXpnM1f+v/ihrfWWWXFpi6SNo093wc/QOABTSwYGNJYsgnB7qYhEB3cU
         citeyK7i3IBD9+0pNuNoNSCa36u8Ah0pf0JRgC8wq9n0SSI3DnEoseRnvAsQAL0akvml
         ygsg==
X-Gm-Message-State: AOAM532ksVBSBWuk+Ndy+TXA52TTu4Q48QnRe++TjyZX5mByLAG7SZdw
        ce+4Ph2VjtJWz79rHZfzb0hslilnVGQOG925
X-Google-Smtp-Source: ABdhPJy9UbOPwrXwpUYHUNCaB1FoJcXO7Bjb2ZKgK8TGQUhPVR+FbJ2apRVxqHRFAOeA7S3TRBjkDg==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr4418422ljj.404.1615462083831;
        Thu, 11 Mar 2021 03:28:03 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id n5sm749535lfl.245.2021.03.11.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:28:03 -0800 (PST)
References: <20210310053222.41371-1-xiyou.wangcong@gmail.com>
 <20210310053222.41371-3-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v4 02/11] skmsg: introduce a spinlock to
 protect ingress_msg
In-reply-to: <20210310053222.41371-3-xiyou.wangcong@gmail.com>
Date:   Thu, 11 Mar 2021 12:28:01 +0100
Message-ID: <871rcm3p6m.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 06:32 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Currently we rely on lock_sock to protect ingress_msg,
> it is too big for this, we can actually just use a spinlock
> to protect this list like protecting other skb queues.
>
> __tcp_bpf_recvmsg() is still special because of peeking,
> it still has to use lock_sock.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

One nit below.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

>  include/linux/skmsg.h | 46 +++++++++++++++++++++++++++++++++++++++++++
>  net/core/skmsg.c      |  3 +++
>  net/ipv4/tcp_bpf.c    | 18 ++++++-----------
>  3 files changed, 55 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 6c09d94be2e9..7333bf881b81 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -89,6 +89,7 @@ struct sk_psock {
>  #endif
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
> +	spinlock_t			ingress_lock;
>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;
> @@ -284,7 +285,45 @@ static inline struct sk_psock *sk_psock(const struct sock *sk)
>  static inline void sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> +	spin_lock_bh(&psock->ingress_lock);
>  	list_add_tail(&msg->list, &psock->ingress_msg);
> +	spin_unlock_bh(&psock->ingress_lock);
> +}
> +
> +static inline struct sk_msg *sk_psock_deque_msg(struct sk_psock *psock)

Should be sk_psock_deque*ue*_msg()?

[...]
