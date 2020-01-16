Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81AFC33CB6
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD62B24695
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMt8K4Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406169AbgAPRpU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41571 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406163AbgAPRpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so20128496otc.8;
        Thu, 16 Jan 2020 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLaUOrQm0pL4vuWgLcGmsporr/tt+kx9o6ALI8C3jlk=;
        b=IMt8K4TjDrBlafhpghwdBkqPioqHv3pLCFL8pUq2HH2hrKOvfBPyZzaHjgP7QpJpUW
         S98wD5Ec/WuB5p8t05HOyCHOy/REU7CE679JHEnouQip7mL2kuQ2iIIS0oEwFLSugMnT
         zhjj1Up1INQqVrbFUl/hWhrA3QXV+b564/Fh+rqjwkgI+YzzyF/yY5JCPAFEJxVaYFKh
         Y/vzLPJJxoyW+2sRPp2dy50vNv1k2CrtJTlzQ+jnGfPLoXQEkujGd5hNN0Uq1X9fpSql
         8p1UG5svW2tKb+nMI1v/yy21e3lr8oMAduYp2rGt5J6Z9HbPkLTYxynIw+WoZqxYoke4
         CxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLaUOrQm0pL4vuWgLcGmsporr/tt+kx9o6ALI8C3jlk=;
        b=hyUbb0902d/a9hfjlX3/m/AjkmKsm/YqKiJjD1MWbep6DDby7ZfnambHaQfWhuczBP
         vNfY0BoIcHISm6hJwVaMbYdRRIKYl0jyqtM8psVWWuaPdZVS2P4zEDhkDC3Q/Pllsxq6
         qvppAx4H5KNlJB55s+ZCCqaw6Gq3NeukPmRcqgOOYhTNh4MsGTisAXZ4bWZmochjxMjZ
         wUWFqq1TIEwMy7eepRcZqHkSV1e+rnaPhkBj/tfwVtWZ5mbC8RsDc4dblLZHK6YEvhtc
         /oO7/WCRNikj0vNiGaklbTdwEwB9owhIF0+epXwgL70BmLGRA9+Mxx8gb/TiPFYh6MWs
         NHJQ==
X-Gm-Message-State: APjAAAW117EGKb7vkmSDq3kfbk7TKcdkAtcjL20BxUESL/DFqusRH0Ua
        EgWSPDassB2irzyPrebcDIzzXeHpsIVv62/85Eg=
X-Google-Smtp-Source: APXvYqzKZAVjTsIkY0wHGHffa2IXmnHkLAf/ghgz3OrHCRWIpjg+N16BlXdvhjgG9L4G+MupK5jl8KgZ9a20jzW8PSk=
X-Received: by 2002:a05:6830:4a7:: with SMTP id l7mr2856235otd.372.1579196719411;
 Thu, 16 Jan 2020 09:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20200116085133.392205-1-komachi.yoshiki@gmail.com> <20200116085133.392205-2-komachi.yoshiki@gmail.com>
In-Reply-To: <20200116085133.392205-2-komachi.yoshiki@gmail.com>
From:   Petar Penkov <ppenkov.kernel@gmail.com>
Date:   Thu, 16 Jan 2020 09:45:08 -0800
Message-ID: <CAGdtWsQ4aigyJUjBxmFQ8C5zU_4p-t0K2=uwVg2NxdUQuh-WoQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] flow_dissector: Fix to use new variables for port
 ranges in bpf hook
To:     Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 1:13 AM Yoshiki Komachi
<komachi.yoshiki@gmail.com> wrote:
>
> This patch applies new flag (FLOW_DISSECTOR_KEY_PORTS_RANGE) and
> field (tp_range) to BPF flow dissector to generate appropriate flow
> keys when classified by specified port ranges.
>
> Fixes: 8ffb055beae5 ("cls_flower: Fix the behavior using port ranges with hw-offload")
> Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
> ---
>  net/core/flow_dissector.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2dbbb03..06bbcc3 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -876,10 +876,17 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
>                 key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
>         }
>
> -       if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS)) {
> +       if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
>                 key_ports = skb_flow_dissector_target(flow_dissector,
>                                                       FLOW_DISSECTOR_KEY_PORTS,
>                                                       target_container);
> +       else if (dissector_uses_key(flow_dissector,
> +                                   FLOW_DISSECTOR_KEY_PORTS_RANGE))
> +               key_ports = skb_flow_dissector_target(flow_dissector,
> +                                                     FLOW_DISSECTOR_KEY_PORTS_RANGE,
> +                                                     target_container);
> +
> +       if (key_ports) {

If the flow dissector uses neither FLOW_DISSECTOR_KEY_PORTS_RANGE, nor
FLOW_DISSECTOR_KEY_PORTS, I believe key_ports would be used
uninitialized here. We should probably explicitly set it to NULL at
the top of this function.

>                 key_ports->src = flow_keys->sport;
>                 key_ports->dst = flow_keys->dport;
>         }
> --
> 1.8.3.1
>
