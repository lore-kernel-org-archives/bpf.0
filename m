Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795DC10F14
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B8720B1F
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn2ZqC4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfDWEPJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:15:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33685 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDWEPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 00:15:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so6838200plo.0;
        Mon, 22 Apr 2019 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lznylQ7QDrh2l37GMF//zlnp+CpOz7UiS1eARqpBPU=;
        b=Pn2ZqC4s2XveqNO7CrEEmhxj73o76sWooHrGqhiaOJ2mqnAHHyf19na0/QuvFTyOJO
         q7bYFKjlafoga/NwHa+ZUgVSfud7A0DIrHiem+WHLR5skzXUL+tqioFl6FrvJztOA6xq
         3O2bSZevoquJl+7K0qBqEA5613md1x+GtYpUesBkuQrul3JloyiY7ChnInpF6FFD7yM1
         Ibpahf4JAlX+E/ztW7WlGkJVYtXSUqN3FxYdKHLzaBpqcU8HkD8jY3uOIFfiPXPOMDYN
         75giXLIxbdqKjv9lLDZkletRwKSuoAJsjPD1o3M+YL/sCQFU5r480CCq513nca2NYxlC
         TSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lznylQ7QDrh2l37GMF//zlnp+CpOz7UiS1eARqpBPU=;
        b=EglytOiCMYpk3e+y+BbdJBokMyHmdtA6avafko1vhuY5y4Tb6PyM7sMApHK4wK+6p0
         3D9gZE5QtuIQSFxFWP0a7qUGUtPhAQP7cHUfHWCeWkmddzGM7RPbUc55A0yhsD9LRuRK
         nmZ/5UQWBv/xZ62bG8WCdJoqMLOPVF53UQlByiAiqUIUMHRmgBxXzPNl95OxLfoIulv/
         N1/gxgMaUKKlvlfkwcy95NuxwyQ2SCsDApfD8S86NJxZTVBRZgf63te9yurukT/p+OSA
         toS3gXwEvoPAqgQuWGX/WacQP+AT7wUyLv5kjPHXSiD8Tlkj33Tpx6whFRk4ketgR0zG
         EFGQ==
X-Gm-Message-State: APjAAAVD4/H1o2j1CYmb9+bUndP+ELISxMT48LAQMkJ3bX8wMpr4OmtU
        yoYGglzMTUmLvpPCwDU3JUc=
X-Google-Smtp-Source: APXvYqy+OqLrvbu9kV4HtwtN3FtD200x27srHV193FCK0tQRuxYlH1QPljobnyqWbflL1w6Wqm3dYQ==
X-Received: by 2002:a17:902:70c9:: with SMTP id l9mr6187454plt.33.1555992907311;
        Mon, 22 Apr 2019 21:15:07 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::2:442])
        by smtp.gmail.com with ESMTPSA id g5sm19555060pfo.53.2019.04.22.21.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 21:15:06 -0700 (PDT)
Date:   Mon, 22 Apr 2019 21:15:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com, edumazet@google.com
Subject: Re: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook
 when called from eth_get_headlen
Message-ID: <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
References: <20190422155552.222910-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 22, 2019 at 08:55:43AM -0700, Stanislav Fomichev wrote:
> Currently, when eth_get_headlen calls flow dissector, it doesn't pass any
> skb. Because we use passed skb to lookup associated networking namespace
> to find whether we have a BPF program attached or not, we always use
> C-based flow dissector in this case.
> 
> The goal of this patch series is to add new networking namespace argument
> to the eth_get_headlen and make BPF flow dissector programs be able to
> work in the skb-less case.
> 
> The series goes like this:
> * use new kernel context (struct bpf_flow_dissector) for flow dissector
>   programs; this makes it easy to distinguish between skb and no-skb
>   case and supports calling BPF flow dissector on a chunk of raw data
> * convert BPF_PROG_TEST_RUN to use raw data
> * plumb network namespace into __skb_flow_dissect from all callers
> * handle no-skb case in __skb_flow_dissect
> * update eth_get_headlen to include net namespace argument and
>   convert all existing users
> * add selftest to make sure bpf_skb_load_bytes is not allowed in
>   the no-skb mode
> * extend test_progs to exercise skb-less flow dissection as well
> * stop adjusting nhoff/thoff by ETH_HLEN in BPF_PROG_TEST_RUN
> 
> v6:
> * more suggestions by Alexei:
>   * eth_get_headlen now takes net dev, not net namespace
>   * test skb-less case via tun eth_get_headlen
> * fix return errors in bpf_flow_load
> * don't adjust nhoff/thoff by ETH_HLEN

All looks good to me.
But I don't trust myself reviewing flow dissector bits :)

Eric and Willem, could you please take a look as well
and hopefully ack it ?

Thanks!

