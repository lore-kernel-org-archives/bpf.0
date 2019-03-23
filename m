Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7878C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664C7218E2
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMnxwmGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCWBlH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:41:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46773 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCWBlG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 21:41:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so2626006pgg.13;
        Fri, 22 Mar 2019 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Too3DdMfuQCMcAoYfWjQD5d6AfYv0dOadxGyNNx4rv4=;
        b=HMnxwmGIAgjmCtLiTB8ZGgBkLxZ3WzfZM1m02EJ/S3MRMagyxHgA0nqtQajkirosFL
         0iQvGlXK1YTCMkf22vZY1x10NMs7IoH03ivcrUDq6NdBVrqerRoYjxFzv2OeAgZ8Jce3
         g5SkyKbUgBwvyLEqAlqiyM6JNFwhTjna2UaaZ5Kf4+F9MTdYi61On3r8qqSoAw5sCyYb
         c357+HPkBavqkjZJ7DTcPkIUF9clWCYxOjHTGw/HezGGQ8G3CaOrXIhE6NWnF3zFzxPS
         0CBovj32oBEvinfNs7QAo2tKTxaaGO5epvkMRywTMTib0C2EAefoP6Q034NiobEPagv8
         7Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Too3DdMfuQCMcAoYfWjQD5d6AfYv0dOadxGyNNx4rv4=;
        b=uioKeWgzL6IcBDMOdbwLwyms8iOp2jfONzpylzCVwJH21QKDuUMnqzsl5ojIWiECg5
         rcJXl8bi6ugHUKOsdrfC+rzyfUTPvpQtAFm2sdojvKxqCpbRjibFtTjRofRNcLkX23/C
         yTBBHkTA8Zp4nUP+o64l/9Km62uQ06MHwbnWeJ6uFWhDRab2MepwiQulNKUmO+zxKdhU
         XBQ928yMS1G0LJyVZf+pOocjLo/NxM5dzfEYKBVxIptbECKN+NoyfkI7rt2rDCICtbVQ
         XrXkl+jkx0s63pOFoPZtxfNkvXvJZGsy/M3X9NuHs945Qy3nbeOqdd2UNgy42idxgh7e
         aY9Q==
X-Gm-Message-State: APjAAAX6au+gspBcxOYx4zB6V93PdcX3HzmdfS1d4Yo3sbzxxNpXWABM
        4Cs/pPEVIQTGVqLi4xf6sEU=
X-Google-Smtp-Source: APXvYqwZW67Ah0WvYGgvXkeUFvoyhyoUex67jszXEVR3lpvGYgiEqKi+VRlYo8zotVSmy+d3UXxHkA==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr12899971plp.283.1553305265956;
        Fri, 22 Mar 2019 18:41:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::e4e7])
        by smtp.gmail.com with ESMTPSA id 20sm13513302pgr.80.2019.03.22.18.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:41:05 -0700 (PDT)
Date:   Fri, 22 Mar 2019 18:41:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> Are we ok with breaking api in this case? I'm all in on removing this
> extra information. We can always put it back if somebody complains (and
> manually parse in eth_get_headlen case).

Fine. That seems to be the only way forward to clean it all up.
Could you submit patch 1 to bpf tree disallowing vlan fields?
Patch 3 looks like candidate as well?

> We can still have protocol, because in both skb/skb-less cases we have
> it.

proto can work in both cases, but is it needed ? Does program benefit from it?
The kernel side burns extra bytes by copying it and extra branches to handle it.
May be drop it as well?

