Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB7C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 03:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62B820857
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pggeAahv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCTDEf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:04:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33633 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTDEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 23:04:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so670389pgk.0;
        Tue, 19 Mar 2019 20:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNHl9KNP0JMeegGXq7WnA1FTUSorcpKsot6Zv75asuQ=;
        b=pggeAahvORqqZPtfzW7JTOKwGeUpkDFcu71dt0HUt/BJdcT7o+uogm+zeiExRyYvJ0
         fwsfhsNBHARWrxTHVi/3wPkSrJp2br+k7B4CVoaN+IqD4hF1NkRYsqVCa7Behhvg0a1i
         IDVuFIjkXYsEDKZkeu4+MhP1h6RwW0AEbGy6sHYCaE7q7AJForj8SrwPKz9jKnxDycze
         aGS4juMTxg3tg5iMNa4lgARFDZP9KZNt0eEO9pC0wMB9koU4p8oNwdek1JwKzjf3cltc
         GbEbYvrO1svXV53OjZsoHP9LHvJZnjVUsbyGBqFkjL01dDAQ+gPT4S9y3z46cRTrs1Ig
         NYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNHl9KNP0JMeegGXq7WnA1FTUSorcpKsot6Zv75asuQ=;
        b=MoS9omFlE/5gC3jf8UrVDZfDUPXNlNeLtmwHfsoCr9BDi0LIXsSW1m/H2pX9RK5J33
         WFXkhU6tOUfX/9BEgAcKZ5aDf0+l3bs7MPFcUBolkW/3u2/BoCnw4VibobJVrbyOUAKE
         1P7ebteYTgILDp6BjKUHuAmIAyZc69+UbAPsNiywi4coUdlqsDggEMc74y/+hh3fH1VK
         RLS11aa2iP655VMI5jtKxsHT+bD+awlmay5ZtBTGyZ833DDBz+uft90Q0TJqp8NQ0miZ
         qGNJHJM7oBNv+06drepD6lMA3rlp3ybLOLN4cNdJI8C4l1aGMyeEtOFesHshXvfgau8I
         SoFA==
X-Gm-Message-State: APjAAAVdTlio6DjGYbBRjJJZIOOVI3lRO1s57GIQsFiTgKkGOBBsjjSV
        VC8q8wd+qp2mL/aQC0TjcOQ=
X-Google-Smtp-Source: APXvYqzG3UNtBbkZfBEFt1gtXXIkjVzUYZmpB6KFb7w0u7LXucwpD2bI/fxIgAHsvdf1LJx6IqHhBA==
X-Received: by 2002:a63:7e08:: with SMTP id z8mr5081143pgc.239.1553051074548;
        Tue, 19 Mar 2019 20:04:34 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::7f56])
        by smtp.gmail.com with ESMTPSA id e63sm569187pfe.120.2019.03.19.20.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 20:04:33 -0700 (PDT)
Date:   Tue, 19 Mar 2019 20:04:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "toke@redhat.com" <toke@redhat.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
        "jesper.brouer@gmail.com" <jesper.brouer@gmail.com>,
        "bblanco@gmail.com" <bblanco@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "iovisor-dev@lists.iovisor.org" <iovisor-dev@lists.iovisor.org>,
        "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kafai@fb.com" <kafai@fb.com>
Subject: Re: [RFC][Proposal] BPF Control MAP
Message-ID: <20190320030429.c2grdzenlawoqec2@ast-mbp.dhcp.thefacebook.com>
References: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
 <20190319153603.qfhp3nc5dxwgptlh@ast-mbp>
 <ea4391584d2321f8bf5a0e61ed1e05e5665bbf17.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4391584d2321f8bf5a0e61ed1e05e5665bbf17.camel@mellanox.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 19, 2019 at 06:54:08PM +0000, Saeed Mahameed wrote:
> 
> This is exactly the purpose of map_{create/delete} to define what the
> key,vlaue format will be ( it is not going to be ifindex for all
> control maps), to make it clear, the key doesn't have to be an ifindex
> at all, it depends on the map_attr.ctrl_type which the user request on
> map creation, so different layouts are already supported by this
> proposal
> 
> examples of different map_attr.ctrl_type:
> 
> fd = create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type = XDP_ATTR)
> // Key layout == ifindex, vlaue format if_xdp_attributes
> 
> fd = create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type =
> BPF_PROG_STATS)
> // Key layout == prog_fd, value format struct bpf_prog_stats
> 
> fd = create_map(BPF_MAP_TYPE_CONTROL, map_attr.ctrl_type =
> BPF_SOCK_ATTR)
> // Key layout == socket_fd, value layout struct bpf_sock_attr
> 
> extending this can be done in any linux BPF subsystem, by introducing 
> new map_attr.ctrl_types and new key value layouts of that control type.
> 
> on map creation we will attach the btf format of the (key, value) pair
> to the map created for that user.

In your examples above does netdev with corresponding ifindex
exist before map is created?
Does prog_fd exist ? and socket?
In all cases yes. they do. Hence creation of 'map' (even pseudo map)
is an unnecessary step.

User space providing BTF for input and output makes little sense to me.
What kernel suppose to do with it?

In case of XDP stats (that could be different between drivers)
the driver would provide a BTF to describe the stats it's collecting.
So it's kernel supplied BTF instead of user.

> > I think we need something else here. Using BTF to describe
> > output stats is nice, but using BTF to describe input query is
> > problematic,
> > since user cannot know before hand what kernel can and cannot accept.
> > imo input should be stable uapi with fixed constants whereas
> > stats-like output can be BTF based and vary from driver to driver
> > and from one nic version to another.
> > 
> 
> Well, we can decide to use static stable uapi, and still use this
> special map to leverage the map API as described in this doc.
> 
> but also we can allow dynamic value layouts, but any extension should
> be done to the end of any value structuer and on lookup we will only
> copy the size that the user already recognizes .. ? or we can
> assume/force the user to use the map_attributes to figure out format
> layouts and sizes, but still we will guarantee backward compatibility
> in kernel level by keeping old format the same, and extension is only
> allowed to the end of the value structures.

for input queries - yes. See how 'union bpf_attr' works.
It can accommodate any number of new commands with its own arguments
to query XDP stats.
For output the driver can supply BTF back to user space along with
a blob of data.

If I got your intent correctly you want only BPF_MAP_TYPE_CONTROL to
be processed by generic bpf layer and everything else to be done in
the driver? All commands, values, input/output to be driver specific?

