Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469EC4338F
	for <bpf@archiver.kernel.org>; Mon,  2 Aug 2021 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E7E60F39
	for <bpf@archiver.kernel.org>; Mon,  2 Aug 2021 09:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHBJBM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhHBJBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 05:01:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1FC06175F
        for <bpf@vger.kernel.org>; Mon,  2 Aug 2021 02:01:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q2so23011264ljq.5
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=FKkTDOoJkTf8q49ytftID668qe8fzuG5BawdaIV8kuA=;
        b=pIS2pGlmP8ZlgfkVoEdnjZDGG4WXVsdEADYJypNWJGKoEsxopWQB09EloEpv6qM5X8
         grmiivXghPgBVTrK7MXrIzJgb5qTx26Kk7x2FO/SrMMlXVv12UMLwYG8FcBIGeYzr9oz
         ThoXBUaqvnrT08bSpkwT8gIUhGBFdzx3ByNBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=FKkTDOoJkTf8q49ytftID668qe8fzuG5BawdaIV8kuA=;
        b=Y8+ODxfPtKgk+KFJx0/fJq8oyeLdY1WbPiX+XMACpMqLJ8oFJ0AiYyWmQtPkgjgkJy
         kjpdSfzyySwBhoVRBwA1/UISXTgHy5AokmnFut+E+ZDvLrcByrelCy8rPnh9jUF0/wCh
         RsVbHQMHO6d48mncpM88GS/B0YlnhEnZrphvMJkUpuCbtpKsARx1GYO4YezT/1p6IWLz
         IyZpjnn5en1laFuNDg3n/K6dYtsn+oV1Zjs6eg5WbBOsShpXhJY90AYyKXrEsINmVWUD
         WMk8R9WjweRg2bBGxGNGfMCfQTFidT7M2YzQ+29VyLtf9SoKa1W7ezQlLoKe2LY5CWCI
         JCrw==
X-Gm-Message-State: AOAM531nU4pBOO7VxxjgGbPIbZVCb2g0dz30xWEamYIfw0Bx0OtuTEbY
        aMmXWV45t7EQ4+ZhPTDTHYsEKQ==
X-Google-Smtp-Source: ABdhPJzEdmFIA6o3qeJFou32X+VoHvsVJSbMF9hUy7rsrIHD1qctKAYoiZEMsNB6Aus5gsoeOfcNXA==
X-Received: by 2002:a2e:a80f:: with SMTP id l15mr10869165ljq.354.1627894861160;
        Mon, 02 Aug 2021 02:01:01 -0700 (PDT)
Received: from cloudflare.com (79.191.182.217.ipv4.supernova.orange.pl. [79.191.182.217])
        by smtp.gmail.com with ESMTPSA id k8sm867574ljn.18.2021.08.02.02.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:01:00 -0700 (PDT)
References: <20210731195038.8084-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next] unix_bpf: check socket type in
 unix_bpf_update_proto()
In-reply-to: <20210731195038.8084-1-xiyou.wangcong@gmail.com>
Date:   Mon, 02 Aug 2021 11:00:59 +0200
Message-ID: <87sfzsnruc.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 31, 2021 at 09:50 PM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> As of now, only AF_UNIX datagram socket supports sockmap.
> But unix_proto is shared for all kinds of AF_UNIX sockets,
> so we have to check the socket type in
> unix_bpf_update_proto() to explicitly reject other types,
> otherwise they could be added into sockmap too.
>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Reported-by: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/unix/unix_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index 177e883f451e..20f53575b5c9 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -105,6 +105,9 @@ static void unix_bpf_check_needs_rebuild(struct proto *ops)
>  
>  int unix_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
> +	if (sk->sk_type != SOCK_DGRAM)
> +		return -EOPNOTSUPP;
> +
>  	if (restore) {
>  		sk->sk_write_space = psock->saved_write_space;
>  		WRITE_ONCE(sk->sk_prot, psock->sk_proto);

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
