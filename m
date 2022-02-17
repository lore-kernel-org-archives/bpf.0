Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD4C433EF
	for <bpf@archiver.kernel.org>; Thu, 17 Feb 2022 03:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiBQDFc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Feb 2022 22:05:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBQDFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 22:05:32 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48823D5D5;
        Wed, 16 Feb 2022 19:05:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h125so3816306pgc.3;
        Wed, 16 Feb 2022 19:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMoY/UclmOzHHpj7q9oQ/Af/xKLviGmGe8f60N9+gmY=;
        b=SNP965VUfhZXrVmh8kTvPSsUo8uMC1jyZXYcE//TNFlPTGHB9dXy4htdU3q6jLFr/h
         n/aaksqxMzXOFAPyNiluL1tEVo5gJbuBJAn7EbMdBfSMh252KspUFNvtuDIvgSSfIvf0
         6AZDUBq3v4fSDSO1sic7C7luXkosniXoMwvKe4FV7AUNHqdYjXOIdo96Y1EVvpdi+RLA
         HDdX9eDaVGNjmE/oUN7AxsVDQsfk18Gn9DOknMXwy0Q0Xv716a0sqITsqhxGQDgjxIzw
         j9rNWSGHzwWEix4lRiwo2f/OMZoGldMBq719xPT6ATBYzi733Ub75qC+1wTZQ6ORVqNV
         OR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMoY/UclmOzHHpj7q9oQ/Af/xKLviGmGe8f60N9+gmY=;
        b=JTeorBLOByEpbSTg7kV8+fXea2s7sNMnwC1ahSgHgVZQAN5nQXrJo8teO6O3Wd8rsf
         67muaWi7PI2EaoeVEIGrWaKlTQ36+3WoRC7VOnvofKOMvDNWRZDHnuqfvDhr1jCAL0vE
         edljVaJJCyht66qFQuU0BnhM9t6L2RK4Se35JgDG0BVNKq0xkRCwvtElVlXLZ5lr5bNG
         85Ge1qOlQL6Cu6hcsyK4vpJVG5pch3ALbsvVMN49zuBAQ5O6+jPUKnWodYnbb8eta/k5
         Bt6su1M6M7fEUriAtrbIPhvJSXsjMfBigEZO0Vxsv5UH/WoKFtEVZj86RuV/1Tsita4u
         aO8g==
X-Gm-Message-State: AOAM531uSO4z8dRtlnIlmQroJXPvCNQ+nrfR23Tq/LSmlyrw8tYLFM+Q
        Eo1djBPBsInqEXlb95UXRFeuHXk3qzbRwZuQk9g=
X-Google-Smtp-Source: ABdhPJyLApRn+E2RrFYRd8bcKZvA9EPDU6eRpSCfrj/S6z/9sjnhhHgWU+v18QjChCGhBycQ0aSbyDB3PvbmUV7j64U=
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id
 b6-20020a056a00114600b004c9ede0725amr897542pfm.35.1645067118729; Wed, 16 Feb
 2022 19:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20220216073055.22642-1-lina.wang@mediatek.com>
In-Reply-To: <20220216073055.22642-1-lina.wang@mediatek.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Feb 2022 19:05:07 -0800
Message-ID: <CAADnVQK78PN8N6c6u_O2BAxdyXwH_HVYMV_x3oGgyfT50a6ymg@mail.gmail.com>
Subject: Re: [PATCH v3] net: fix wrong network header length
To:     Lina Wang <lina.wang@mediatek.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 15, 2022 at 11:37 PM Lina Wang <lina.wang@mediatek.com> wrote:
>
> When clatd starts with ebpf offloaing, and NETIF_F_GRO_FRAGLIST is enable,
> several skbs are gathered in skb_shinfo(skb)->frag_list. The first skb's
> ipv6 header will be changed to ipv4 after bpf_skb_proto_6_to_4,
> network_header\transport_header\mac_header have been updated as ipv4 acts,
> but other skbs in frag_list didnot update anything, just ipv6 packets.

Please add a test that demonstrates the issue and verifies the fix.
