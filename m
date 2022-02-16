Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC100C433F5
	for <bpf@archiver.kernel.org>; Wed, 16 Feb 2022 16:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiBPQ4s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:56:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiBPQ4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 11:56:46 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389072B247
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 08:56:31 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d625082ae2so5586417b3.1
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEjX8mqvhweVPssQ3aADUg4sgNUOBaiUpJdvZM1UYNE=;
        b=MmdBO/3AvmjD6OfQEWzFtZWbpNSA/34GdDNHW1q668elbaJZYc+SFo57AjnPwoZPre
         eQAp39N5LlQ9DGD75Qqle3I3jkUYAhrQ6MmByH/dm7Ev6nFwIbvs+wOeCnncyIiTENb2
         l3k0FjBPw9rgXCIaVN369t4lehqENpt7ss3HFj3nIU1dCIcG/e+d8ZzhSOIdG3y9iloy
         fkH2oAg2E3MoPxr39nJx13ZTzdXg/p1hG/Vw65BGOHn81v9ItiMEAYeUN2l9LIKBR/Hi
         1NcS+mMX0bJKe/JCP6daWS8JzAfQEuX17ZyqKk50cFri0ID3xU/DL/Cuecz6xMSJ2mTK
         Hn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEjX8mqvhweVPssQ3aADUg4sgNUOBaiUpJdvZM1UYNE=;
        b=spcyv8klRlhRM7dFM1EOAApm6z9AXJn6+weJnk1olQ8keeAL6kv9MWSJakXTSBFgrI
         8h+YPGNQJj7bgbxnobvlgUg7Yva1ew2uMyWTENUaiM6RWzHOuMDjEG3R81WiRLJyc+H7
         1ook6RH3pxjJ/GNb9FNKHSlftd/3rP8lDbdfkv1eO6uod5ZdPz0LG0ZF4v5PvfxfGs9k
         wx5owr4KsCc5yk8F3ama+jvlXquuE+0cxulHkWRVdo9R+haEut/sm4pZwtDJlqmgZIYU
         o1vH4DN9A9yDo+I2NAYp3xkGM4bzM9yz9vqWsjKpkGlt4n8uW7ByJgbchFX399McHlQD
         So3Q==
X-Gm-Message-State: AOAM530DFmuel2Hm5itBoeb5LWA8qLbfHRvi/MhvNLOQQZzrB85qmGMo
        mljeAn8L6PGJQ2TTxn0HCdKABPDT5OJWqGZLdFIQwA==
X-Google-Smtp-Source: ABdhPJxaNNCJQXu++II+pEhb4hfv3aCcqH6TivF5eQUKW/mkJhVxJAn7xmzhf5aL1uO66wrImJ9m1NqNdRfvCjozGDY=
X-Received: by 2002:a81:75c6:0:b0:2d0:cbf8:e7b3 with SMTP id
 q189-20020a8175c6000000b002d0cbf8e7b3mr3167890ywc.255.1645030589922; Wed, 16
 Feb 2022 08:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20220216050320.3222-1-kerneljasonxing@gmail.com>
 <CANn89i+6Hc7q-a=zh_jcTn9_GM5xP6fzv2RcHY+tneqzE3UnHw@mail.gmail.com> <CAL+tcoBnSDjHk_Xhd_ohQjpMu-Ns2Du4mWhUybrK6+VPXHoETQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBnSDjHk_Xhd_ohQjpMu-Ns2Du4mWhUybrK6+VPXHoETQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 16 Feb 2022 08:56:18 -0800
Message-ID: <CANn89iJTrH1sgstrEw17OUwC8jLBS9_uk_oUd5Hj0-FypTvvPw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: introduce SO_RCVBUFAUTO to let the
 rcv_buf tune automatically
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Wei Wang <weiwan@google.com>,
        Alexander Aring <aahringo@redhat.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Florian Westphal <fw@strlen.de>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jason Xing <xingwanli@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 15, 2022 at 10:58 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> Just now, I found out that the latest kernel has merged a similar
> patch (commit 04190bf89) about three months ago.

There you go :)

>
> Is it still necessary to add another separate option to clear the
> SOCK_RCVBUF_LOCK explicitly?

What do you mean, SO_BUF_LOCK is all that is needed.
