Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38598C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 05:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E392186A
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 05:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNFRegP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfCTF16 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:27:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTF16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 01:27:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so1042401pfn.9;
        Tue, 19 Mar 2019 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfT7v0amOxkFidUyNowcTAponrX/HnbeAkvg8V9ZsCQ=;
        b=XNFRegP1pOlytFeDT4EGej9hEc2mDrGpE0VxHljPo9+d1r3rGVZwXuZYBWL6P1gvuL
         6mknmiBG1m3ADI5hq04vdlVcgTOwOd54Wqvd0OPYGfQyWDt2rhotvbTprbXCaEo+a1Dz
         bebMevYyI8MZSO31T6+jVPfxVB1NkFjF7g2g40wqef971vPnknlyvOtFDTRgyw0EufGB
         R/uhUt+fne4IjitUQpnrQa5NL+PEQ79veBdNrVzP+co6GqS2LtN/J7EsMpL9nkbS2uFc
         ft++QFblMNg8R3+EEDuPrFdNGyAOIiN/AGDxian6B7wfqDqObqVzUEZGHY7myTfnVZhl
         juwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfT7v0amOxkFidUyNowcTAponrX/HnbeAkvg8V9ZsCQ=;
        b=aO1MWjFOPbKMytklrj/nukxh3guYu0QrI7tPMw+rcbgJXNTkDm2J3U8v4sOY3Vubob
         hUcEMMuAbVH4q3QKreUDp158RXD760RMjzwOsy+XsuXU+eesK3BpEpNRmrDfKqvruC4k
         vATQSDMGbrjgJDczgHv4iVNU+7BM0fvBjKarhPEpqXIV1EkN5COJKqWNPVVA/7XAsg2A
         CryT4cuPFZz+ZcyFfL3GfQ02gPDIboPojO77IElo78x4rq4uibDuJBgyKIItjaWdBqf8
         5YvB5LkD2Fs8Uvhw/ntxttYRKdjaQnY7zmU+gV26a5t/gx6AGEtlN3L6nXC9zIRmozrw
         uNUg==
X-Gm-Message-State: APjAAAVBfRsrbaBQrhCVVqZbqMGCwKAHI2J/SVMsOaWsDxZKiIR0t6OU
        yIIsTHniWq580wAaA/beONLwBhfj
X-Google-Smtp-Source: APXvYqxM0pYYMdpzCrizJN3BMXOrsiV7WJX666ezlZWL/qBb1v28NW1FCmouKd2cGiLvodDQT3+ogw==
X-Received: by 2002:a63:d357:: with SMTP id u23mr5493956pgi.153.1553059677187;
        Tue, 19 Mar 2019 22:27:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::7f56])
        by smtp.gmail.com with ESMTPSA id v5sm1627617pgr.4.2019.03.19.22.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 22:27:56 -0700 (PDT)
Date:   Tue, 19 Mar 2019 22:27:54 -0700
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
Message-ID: <20190320052752.xs4bf3v432b6thyx@ast-mbp.dhcp.thefacebook.com>
References: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
 <20190319153603.qfhp3nc5dxwgptlh@ast-mbp>
 <ea4391584d2321f8bf5a0e61ed1e05e5665bbf17.camel@mellanox.com>
 <20190320030429.c2grdzenlawoqec2@ast-mbp.dhcp.thefacebook.com>
 <2412411ee9115352428e71ff214bcc8bd44e8781.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2412411ee9115352428e71ff214bcc8bd44e8781.camel@mellanox.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 04:47:11AM +0000, Saeed Mahameed wrote:
> 
> consider the following command line, with bpftool that compiled way
> before xsk-ring-szie attribute was introduced.

perfect. let's agree on the use case first...

> $ bpftool xdp set eth0 xsk-ring-size 128

would be great to have. no doubt.

> what this can eventually do:
>  
> fd = create_map(BPF_CONTROL, map_attr.ctrl_type = XDP_ATTR)
> 
> //Query BTF of the control (XDP) map
> query_map_attributes(fd, &map_attr);

and bpf_map_info returns btf_key_type_id and btf_value_type_id
Are you saying btf_key_type_id will return single u32 with name 'ifindex' ?
Where do you specify netns_id+dev_id ?

> // Find if control map values btf layout include the new member
> offset = btf_get_offset_of_memeber_name(map_attr.btf, "xsk-ring-size",
> BTF_TYPE_INT);
> if (offset < 0)
>      return offset; // the new member is not supported in kernel
> 
> *(value + offset) = (int)new_val;
> map_update(fd, <eth0 ifindex>, value);

what about other fields in this value ?
If zero do not update ?
Shouldn't it be read/modify/write ?
So lookup everything first, modify only that '*(value + offset)'
and do map_update ?
and the driver received full blob of bytes for all fields.
What driver suppose to do ? Rewrite all fields ?
Or try to be smart and do read+if_not_the_same_write ?

Different ifindexes will be different drivers,
so single map providing single btf_value_type_id for all of them
isn't going to work.

I hope you see that such api is falling apart even for simplest use case.

