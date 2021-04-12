Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D29C433B4
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AED6121E
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 08:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhDLIFo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhDLIFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 04:05:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F543C06138C
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 01:05:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z8so14256969ljm.12
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UJUZ5l+pwb94CXGmjUo0/e251C6xLvaEkwpXTFxqWxA=;
        b=iVAb7vJAZL3xNbiRZqDlWuRDPrbzftnEC07YIJlZos4pNad3eScwPFC3jTXMufI8LX
         8KQbvRT+N9A1drMSvHycGWVjBIN74tTOFqdvBiuSQAE4EqHyUGNckgzikDEEFjVoH6fD
         jMKe6RRjaVS+3u4DBiAfkA8bn09AdzvDwJMn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UJUZ5l+pwb94CXGmjUo0/e251C6xLvaEkwpXTFxqWxA=;
        b=Dns4uZ7/zF0xn1b5irBhCYwmwg4meaZsLc+cBnBiCWv13g0E2To5DtFX5/0Ow4pcoe
         KOkSMVaN9PtCsCQ1QZqa3y5Zb3ddjP/kOg28XqDpyrJcjBAlDcTfvYOgb7IjULrOpWct
         u71YzWt464Xfm7PNl98MJr1xAssZAjz3kUBFCLsqZCWQR0eufoFaYoYRmQjnuL+3BpVF
         N35BtvJSQ0XYEbVa1aXgDbUdz6pXN9OkD4Z0P5M3j/UORPdO1WZKzq54HuQuqqmnz69q
         wnrBfgbusY4/H1lXWPZ8FFXsJ78ynsWYllQkpHI+gqINch7j5DikzlJxSOAjnjF5LcbZ
         5bug==
X-Gm-Message-State: AOAM530eKEGUSEhdjxcnoi7MaSvoPD0NebIDZAKa2EF0cOJnOkj58R+A
        A52BbimUNjO0qvOTqoUZpgtMZQ==
X-Google-Smtp-Source: ABdhPJzzvWmMcZuSAAXGirY2acPsow1EdDKCC5gv1xy4oJ1TSAImzbsK5/th4asQ6X9yL7Gq+mImMA==
X-Received: by 2002:a05:651c:1243:: with SMTP id h3mr17555000ljh.128.1618214724994;
        Mon, 12 Apr 2021 01:05:24 -0700 (PDT)
Received: from cloudflare.com (79.184.75.85.ipv4.supernova.orange.pl. [79.184.75.85])
        by smtp.gmail.com with ESMTPSA id d7sm2131512lfv.268.2021.04.12.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:05:24 -0700 (PDT)
References: <20210407032111.33398-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        syzbot+320a3bc8d80f478c37e4@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next] skmsg: pass psock pointer to
 ->psock_update_sk_prot()
In-reply-to: <20210407032111.33398-1-xiyou.wangcong@gmail.com>
Date:   Mon, 12 Apr 2021 10:05:23 +0200
Message-ID: <87r1jg2aik.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 07, 2021 at 05:21 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Using sk_psock() to retrieve psock pointer from sock requires
> RCU read lock, but we already get psock pointer before calling
> ->psock_update_sk_prot() in both cases, so we can just pass it
> without bothering sk_psock().
>
> Reported-and-tested-by: syzbot+320a3bc8d80f478c37e4@syzkaller.appspotmail.com
> Fixes: 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

We don't necessarily need to pass both sk and psock.  psock has a
backpointer to sk that owns it.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
