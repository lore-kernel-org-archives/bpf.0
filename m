Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31595C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F128420879
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="zPr3rprp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCWQFe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:05:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41683 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfCWQFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Mar 2019 12:05:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so3527449pgb.8
        for <bpf@vger.kernel.org>; Sat, 23 Mar 2019 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quPtM3va7MNERPJ6j9k7oesLWTPUXB2mimdDliiri6k=;
        b=zPr3rprpFP7288Q42kA/eB5+a7Qf5Qt5jyrnjYz7CDG1HbKifLlaYUcD9jTXaCuljt
         gnjH6sxy5esvysueB+6VVwpJLbNPlTAqlw7yDazlRqkbzQTNd7PxtCbEM6Y3cnpeP1uh
         mi2+cHCDN12UJ4vEcAz4tgcNqjeLxcvfv5hfkwhiHu8kM7XdAlFCnVEzCTDqISvZRJWw
         26NqUiGX0L/OmZHLhqtW2LAMhrVT3/W19k42Yc1RGYdQg014YZjKqhRJ9gqnblKYx2e9
         S990+y7IyYs7SAgvMQ8nwW+hp/wQbOabaEColBatICLtbunbJ7oYUwrHCnTG6nJOlTR7
         RMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quPtM3va7MNERPJ6j9k7oesLWTPUXB2mimdDliiri6k=;
        b=sv69ckibS9Js5WAmHAG61QNmu6IBZu1xHve1PDqQx5e76fYLs1w+sxRPDO2GgNS45E
         4+9QcUJmcRvox8fkoMTnpbEKURF6+au2NFif4JdQcy21wGLjiMILodsQu95hMbEvBRh6
         /nKyV6rU59GH9+k7Js43WKt0ITgtRud/pZKwiloLymPEnHKYtMl2NpFUsJ42xJzK3UPZ
         Ix5Hvj3kZPkkE4S/tZw2JZyjuIzx9GIfqVcnFMkPHZHjbDpJoe+5+P8UPXiJht4OWtQM
         tNIFrKQWlzKs++vbeEGPcEKWCi1438j6igFgjr+UabLFeuhDPmYpZzog9cJqqz2RNfoe
         fx2A==
X-Gm-Message-State: APjAAAV+XsZVxvjb28R41lLh+0O3xnjvIRRRSadGGvJaY6WfCjGYRgdR
        gwnljy7IBn5ZaRO9aqZzUhnK3A==
X-Google-Smtp-Source: APXvYqyMBAS5vEn9/0EdtRJVTt7mefpa9S4i0scVkdq83Tz2yO0e6ccyuPRXR9fuJqH1oWQRWW790Q==
X-Received: by 2002:a63:f843:: with SMTP id v3mr14929463pgj.25.1553357132985;
        Sat, 23 Mar 2019 09:05:32 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id u20sm10705139pga.76.2019.03.23.09.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 09:05:32 -0700 (PDT)
Date:   Sat, 23 Mar 2019 09:05:31 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/22, Alexei Starovoitov wrote:
> On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> > Are we ok with breaking api in this case? I'm all in on removing this
> > extra information. We can always put it back if somebody complains (and
> > manually parse in eth_get_headlen case).
> 
> Fine. That seems to be the only way forward to clean it all up.
> Could you submit patch 1 to bpf tree disallowing vlan fields?
> Patch 3 looks like candidate as well?
SGTM, will do. Let me also spend some time and do a simple test for
the vlan case, to make sure I didn't miss something important.
One question here though: would I need to wait for bpf and bpf-next
to re-merge to continues the series? Or we can cherry-pick those
patches to bpf-next as well (and git will work it out during the
merge)?

> > We can still have protocol, because in both skb/skb-less cases we have
> > it.
> 
> proto can work in both cases, but is it needed ? Does program benefit from it?
> The kernel side burns extra bytes by copying it and extra branches to handle it.
> May be drop it as well?
I feel like the program benefits from it, there is no need to go back and
re-parse that (and in the skb case, this data is already pulled). I was
also thinking about re-purposing flow_keys->n_proto for that (instead
of skb->protocol), so it functions as input and output, maybe that's a
more clear way to do it.
