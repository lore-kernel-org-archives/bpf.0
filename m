Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D84C433EF
	for <bpf@archiver.kernel.org>; Wed, 16 Feb 2022 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiBPP6g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:58:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiBPP6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 10:58:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0AE2722C3;
        Wed, 16 Feb 2022 07:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB5A61A5A;
        Wed, 16 Feb 2022 15:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0764BC340EC;
        Wed, 16 Feb 2022 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027103;
        bh=DWjFTIOayBawynWs+tf5zyrCvJcGObtREzTRWe6rd3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjqRP1auFsX8Hbjr2QUZt1jmjTqjMiVT41fdtRQR6plyGaD7x3sQW8oiIYqdh/DNK
         ch+eRKUJgYSc/94n5OlKcYGpTAwtW4E/nGvBqqp63XcIlORRNvDW0ubBW2WdE8EHJn
         RaqhVtXI8ShrPYwSB3WC5puTTVSiXPtDR7H4TbNQBiXzA2zAz2gz9nqzDK/WDpwGqs
         0x2dALLWOT4xDVKwfxEJPxmqUmI78XY3A4N8Puchu1gmEEyR/uFdw3/F0FruLwWUqO
         WFoB1OdYErXv4rVrKpMm6SNSkwdzcs+u82AFJo2lfJ06jpQh/chjeSpvAMB/SvrDgm
         Zo53i/I0XoJJQ==
Date:   Wed, 16 Feb 2022 07:58:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     dsahern@kernel.org, edumazet@google.com, davem@davemloft.net,
        rostedt@goodmis.org, mingo@redhat.com, yoshfuji@linux-ipv6.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, imagedong@tencent.com,
        talalahmad@google.com, keescook@chromium.org,
        ilias.apalodimas@linaro.org, alobakin@pm.me, memxor@gmail.com,
        atenart@kernel.org, bigeasy@linutronix.de, pabeni@redhat.com,
        linyunsheng@huawei.com, arnd@arndb.de, yajun.deng@linux.dev,
        roopa@nvidia.com, willemb@google.com, vvs@virtuozzo.com,
        cong.wang@bytedance.com, luiz.von.dentz@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, flyingpeng@tencent.com
Subject: Re: [PATCH net-next 1/9] net: tcp: introduce tcp_drop_reason()
Message-ID: <20220216075821.219b911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220216035426.2233808-2-imagedong@tencent.com>
References: <20220216035426.2233808-1-imagedong@tencent.com>
        <20220216035426.2233808-2-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Feb 2022 11:54:18 +0800 menglong8.dong@gmail.com wrote:
> +static inline void tcp_drop(struct sock *sk, struct sk_buff *skb)
> +{
> +	tcp_drop_reason(sk, skb, SKB_DROP_REASON_NOT_SPECIFIED);
>  }

Please make this non-inline. The compiler will inline it anyway, and 
if it's a static inline compiler will not warn us that it should be
removed once all callers are gone.
