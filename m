Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4916C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81967206DF
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 00:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu6m8rVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfCZAfW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:35:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46994 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCZAfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 20:35:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so7207489pfj.13;
        Mon, 25 Mar 2019 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wdq07ihQygP8c+HiXGN2J2OwhwNpZbQD+E9mRZGi5A=;
        b=lu6m8rVtGmqmtNT2Sc74bkC3Z8Lxz+qphmTAWlUv3W3Qy9nHH5uI/xnrwmvKe/RzB9
         v+AlvL76fEkcLd9V4cyKPOnqpi0G9uhvSHqZ+gL5oZEKdXIEY4BkHlTXb2NnvQML9VuO
         udodM93vYfI0iCjyFg81n2yt3gwha52efsx1oMzhYf1MkHbmnDQKd3/yoR9fabKGQwmT
         5x/xll+z9m07Ay5ZvCZFb7yECsDnZw1i8olYfji7HLluTXXCCDpIo5z9giKOMVOzO0wl
         IEYLbJo2KeTk89sWSdSp0S98j7l4KDnnc1U3TdbM+iR0i9WVIU3omdk9mGwP5v+Nc7/K
         v/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wdq07ihQygP8c+HiXGN2J2OwhwNpZbQD+E9mRZGi5A=;
        b=WaA3ZXFxRsgrcYQpjCu9K8GNC8hcaW9XUWuNfNatk194s8DTX8leGnfrSZDTUXbq6H
         9shosx4rQrfLVU82a8gsM0WjI71efvL6Yx7Q63XXYhQdCFu9/5vIYsJ6Vfp7zh+12UTW
         JHPmP7XidI7aN3Ijy4kJkT81wVUq1LDhTXaO0EELAvXZW5VORJC9pX5HEK98Y3mL7Prj
         9/lovrZfj4Irp9iPL75qr0IyjpZ/98ROJ5878NQ5EjWVSmIZI/ziG+cLgoqhoZnGsMHj
         e8otBNRXF42TdWiuQA0bcMaPI4uj8emr5WaPabHQ3vw2EqkqpCazuyByw8EMbQOhmBXf
         k1Ug==
X-Gm-Message-State: APjAAAVryW7IBrd2X/oP1CcdIkofGm/VLuCuu81ZSVxtiOExT+TGMmsS
        /q9urbrfYF6moLCe3NBRqTA=
X-Google-Smtp-Source: APXvYqwbWNxpRuKijUycviM/O298wY9SmehGeURptdCR5fLawQYwzkmbpeCky6hWO0JgIaPuRZ5viQ==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr25957124pgn.274.1553560521191;
        Mon, 25 Mar 2019 17:35:21 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::3:b0d9])
        by smtp.gmail.com with ESMTPSA id i24sm8668496pfo.85.2019.03.25.17.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 17:35:20 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:35:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 23, 2019 at 09:05:31AM -0700, Stanislav Fomichev wrote:
> On 03/22, Alexei Starovoitov wrote:
> > On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> > > Are we ok with breaking api in this case? I'm all in on removing this
> > > extra information. We can always put it back if somebody complains (and
> > > manually parse in eth_get_headlen case).
> > 
> > Fine. That seems to be the only way forward to clean it all up.
> > Could you submit patch 1 to bpf tree disallowing vlan fields?
> > Patch 3 looks like candidate as well?
> SGTM, will do. Let me also spend some time and do a simple test for
> the vlan case, to make sure I didn't miss something important.
> One question here though: would I need to wait for bpf and bpf-next
> to re-merge to continues the series? Or we can cherry-pick those
> patches to bpf-next as well (and git will work it out during the
> merge)?
> 
> > > We can still have protocol, because in both skb/skb-less cases we have
> > > it.
> > 
> > proto can work in both cases, but is it needed ? Does program benefit from it?
> > The kernel side burns extra bytes by copying it and extra branches to handle it.
> > May be drop it as well?
> I feel like the program benefits from it, there is no need to go back and
> re-parse that (and in the skb case, this data is already pulled). I was
> also thinking about re-purposing flow_keys->n_proto for that (instead
> of skb->protocol), so it functions as input and output, maybe that's a
> more clear way to do it.

Are you saying that skb-less and skb flow dissector progs are looking
at different positions into the packet ?
In case of with-skb it's already after eth header was pulled?
In such case skb-less should be different program type or
both should point at the same point.

