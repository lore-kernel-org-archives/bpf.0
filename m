Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB63C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB22083D
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 15:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQpIsuan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCSPiM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:38:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSPiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 11:38:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so14149435pgq.1;
        Tue, 19 Mar 2019 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U+rDt+7dam2GClzpVRYyDgjfZoNsanw49Jbj5WxVGSI=;
        b=jQpIsuanSZCEHHonEsLDfz4uYcPeucvWsIqhDm4LouleVM5oWzsDb2/dh8q+eO1cUk
         k67WKnnsWwCa2Utea3YA/Ss1OsSIk0ftuCtL9UhEE+V6gPKMetsl9Bj6beoapd2cR9iS
         QttkHOeQ4VwCe0buipfDgUCyYU/jITNqC+EGo/PvhZcVBXdiRo9QuSu74UJJr2hrV+Br
         12tlpNJiGBTHj9d0TT3uWFIOIge/XwfGFZhVbeFUDyYlsSO1rBX/Yr5C4f1iIqDtDBlp
         gZ7uoEVHbUO4jKXK2zk7y/vPLlikVzpYtrn6/m7D+s7qnKVfm+rcnnYa9//GxJ+7Toqb
         3N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U+rDt+7dam2GClzpVRYyDgjfZoNsanw49Jbj5WxVGSI=;
        b=NLA3kwoOaM203QTHAkvtkGe1HuxXaWgJPcVZVjn6ee5ikt7VHKPFZMimHGj8806r4e
         1aHM6GxEPG3LjY/k79GaoNPKSTNLCN9Dx2gCo8e1nY2bZDhSGGFpDdlUn29PrxJVoC8F
         YS3FB2sUILLpMdZzffj4yeFhLJdJrQt08OUHnjPwIS/oNPkkn2dI3jXx8/Uivix746PQ
         rzQosAbo4IJK16mC/IMLgBRDkTa6g9CI3pAD3X9dbFZK6X7QJMOExztCC75NhZLPENnS
         GXU0J7Nq3ZCL8ocIDxH5Ldfy7Ew+iPpWKEFz3KuVLby7HjNdcx+7YfWh7RT5sHgikWEo
         ViqA==
X-Gm-Message-State: APjAAAWEIvcJZCeRKTsGFFMOwh8rLKJ+Kf0HPSydsD4BMvuMQCzXCosc
        TaJgpRc3AtJ5mZJFNEXmuos=
X-Google-Smtp-Source: APXvYqzE4i0Jce0Js/vX7YD8snpPyUDW0HNkyjMbc4QKWaFvo0Zn0lDcBCLRJXQdMK67hbplVco2Zg==
X-Received: by 2002:a17:902:7103:: with SMTP id a3mr2704677pll.214.1553009891290;
        Tue, 19 Mar 2019 08:38:11 -0700 (PDT)
Received: from ast-mbp ([2603:3023:16e:5000:108a:d1df:38f5:ffa4])
        by smtp.gmail.com with ESMTPSA id z128sm5275125pfz.107.2019.03.19.08.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 08:38:10 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:36:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "toke@redhat.com" <toke@redhat.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
        "jesper.brouer@gmail.com" <jesper.brouer@gmail.com>,
        "bblanco@gmail.com" <bblanco@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "iovisor-dev@lists.iovisor.org" <iovisor-dev@lists.iovisor.org>
Subject: Re: [RFC][Proposal] BPF Control MAP
Message-ID: <20190319153603.qfhp3nc5dxwgptlh@ast-mbp>
References: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 08, 2019 at 08:51:03PM +0000, Saeed Mahameed wrote:
> 
> Thoughts ?

It's certainly an interesting idea. I think we need to agree on use cases
and goals first before bikesheding on the solution.

> 
> Example use cases (XDP only for now):
> 
> 1) Query XDP stats of all XDP netdevs:
> 
> xdp_ctrl = bpf_create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type =
> XDP_STATS);
> 
> while (bpf_map_get_next_key(xdp_ctrl, &ifindex, &next_ifindex) == 0) {
>         bpf_map_lookup_elem(xdp_ctrl, &next_ifindex, &stats);
>         // we don't even need to know stats format in this case
>         btf_pretty_print(xdp_ctrl->btf, &stats);
>         ifindex =  next_ifindex;
> }

this bit show cases advantage of BTF nicely.

> 2) Setup XDP tx redirect resources on egress netdev (netdev with no XDP
> program).
> 
> xdp_ctrl = bpf_create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type =
> XDP_ATTR);
> 
> xdp_attr->command = SETUP_REDIRECT;
> xdp_attr->rings.num = 12;
> xdp_attr->rings.size = 128;
> bpf_map_update_elem(xdp_ctrl, &ifindex, &xdp_attr);

this one starting to become a bit odd, since input arguments are split
between key an value. ifindex is part of the key whereas command,
rings.num and rings.size are part of the value.

> 3) Turn On/Off XDP meta data offloads and retrieve meta data BTF format
> of specific netdev/hardware:
> 
> xdp_ctrl = bpf_create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type =
> XDP_ATTR);
> 
> xdp_attr->command = SETUP_MD;
> xdp_attr->enable_md = 1;
> err = bpf_map_update_elem(xdp_ctrl, &ifindex, &xdp_attr);
> if (err) {
>       printf("XDP meta data is not supported on this netdev");
>       return;
> }
> // Query Meta data BTF
> bpf_map_lookup_elem(xdp_ctrl, &ifindex, &xdp_attr);
> md_btf = xdp_attr.md_btf;

here it gets even weirder, since lookup arguments are also
split between key and value.
ifindex is inside the key while addition info is passed
inside xdp_attr which is part of value.

I wish we could do maps where every key would have different layout.
Then such api would be suitable.
The existing maps require all keys and values to be inform.
I guess one can argue that such 'control map' can have one element
and one value, but then what is the purpose of 'map_create'
and 'map_delete==close(fd)' operations?

I think we need something else here. Using BTF to describe
output stats is nice, but using BTF to describe input query is problematic,
since user cannot know before hand what kernel can and cannot accept.
imo input should be stable uapi with fixed constants whereas
stats-like output can be BTF based and vary from driver to driver
and from one nic version to another.

