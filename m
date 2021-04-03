Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC3C433B4
	for <bpf@archiver.kernel.org>; Sat,  3 Apr 2021 05:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FAD611CE
	for <bpf@archiver.kernel.org>; Sat,  3 Apr 2021 05:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDCFNy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDCFNy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 01:13:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E8C0613E6;
        Fri,  2 Apr 2021 22:13:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so5429797pjb.4;
        Fri, 02 Apr 2021 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vozdZ0e1A0cPa/cEgn/WnGI+6yRgZk0FApnNuMCWEuU=;
        b=Iwt9FdQdi2fdry1fqQNwr0MZGC68iuOs3D9t+N6EYw9Ichg39GXptZyVsfY3ikVBrh
         kJxuZFMeN6+AeQxft/HLFI/ZCpSPzsz9dpVpvd3YMLvCOFXJt17IlmBOWahavhmsNgy0
         fYobAKWpdxalszdZTB1n1Vrw18ua4eI5ZpvJLW70mU5NRAO54FPTEGE9xo3kbDmdhmt1
         zZbf0mr9pnMBFmLSMtK91Z2L9+x+MWfx7MaznuoNkX7xdQEnvpYQ4oFHIkGEMF0jKwbE
         bYXDsgpjKcUYHyhOpn8GIvzDetiPhOPQK+p2Zwozp+V7jYliWQ5sjXOUAOVk0cHc9SWq
         Uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vozdZ0e1A0cPa/cEgn/WnGI+6yRgZk0FApnNuMCWEuU=;
        b=nibdAUPk/TwKAosi6KZLix07nV284h756ZPQ8nvL7CTpL7xyu5DJAw1DlkD/HJlsv3
         aQ9AelXl6ApMXkQdg3G7YADEvCVtBsk88QR3yWJEZEkjKNZlrEffESZm97MU/5IwHXJ2
         W1JjjptyOozWMNGYRrAGM1fBWxjYfYgKjClbBda6ED+KflwCDIQSNLdFCKZU73VPAzbO
         Xn39kVmvFxMwd1Kdu4BoWeUb+cIqB59rjfvxymIVTyCXq6PC6Keqat6xpZsf/aytCy3P
         +8K7vY0VksXFIghKhA57YbinujdBEWPsjw+MzIxQX5gH5Aw3nICW5cwURK1jQPhmGxtx
         zwfA==
X-Gm-Message-State: AOAM533Syz3SZNSJhFFf0Vp3ZEcCjmNuSHOq5pxsbEIg7DL/tdL5eEji
        zI2sQhQpySzHFKbjAZBtWSsNN3KmeQRgUqPp6FU=
X-Google-Smtp-Source: ABdhPJyAPdNCXSc45xEF8J5trRqfFUuVHedSUEe5t+ggEjKTIJWi8iSEglIxemhlAGBBGNuqQplO4LRFTRKle2NYg6o=
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr17002091pjz.145.1617426831877;
 Fri, 02 Apr 2021 22:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210331023237.41094-1-xiyou.wangcong@gmail.com>
 <20210331023237.41094-11-xiyou.wangcong@gmail.com> <87sg492dq3.fsf@cloudflare.com>
In-Reply-To: <87sg492dq3.fsf@cloudflare.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 2 Apr 2021 22:13:40 -0700
Message-ID: <CAM_iQpVL=3wYLeZchLz0XhenF6yCV_Y4BOzmDmaMrjCYVQ+LMg@mail.gmail.com>
Subject: Re: [Patch bpf-next v8 10/16] sock: introduce sk->sk_prot->psock_update_sk_prot()
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, duanxiongchun@bytedance.com,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 2, 2021 at 3:16 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> > -struct proto *udp_bpf_get_proto(struct sock *sk, struct sk_psock *psock)
> > +int udp_bpf_update_proto(struct sock *sk, bool restore)
> >  {
> >       int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
> > +     struct sk_psock *psock = sk_psock(sk);
> > +
> > +     if (restore) {
> > +             sk->sk_write_space = psock->saved_write_space;
> > +             /* Pairs with lockless read in sk_clone_lock() */
>
> Just to clarify. UDP sockets don't get cloned, so the above comment
> apply.

Good catch! It is clearly a copy-n-paste. I will send a patch to remove it.

Thanks.
