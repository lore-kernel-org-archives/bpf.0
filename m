Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98672C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4B92070D
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6iNKqBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCZRsH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:48:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39557 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZRsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 13:48:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so4901496pga.6;
        Tue, 26 Mar 2019 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I5aWm23y/2/GO0/LXc3I3Aejb6krSPVUOPVGcs93iVQ=;
        b=G6iNKqBXMdW19JluHhIcsVaO3G7ueCvUZaovESw7dEviyXzjpWs+pZqnmWen+YQIPK
         8HfVz+H1+MhXLiynq4JikPSbwQhkcE2tmxFcQJ4Wpa4voimHs4bvspBJRpyKmeuLKU8w
         BfHdlhSz+JqdjhKn6b/6TIYVPPnZp5/GW9M6G27lmsUC5K6DNJVjEAlhlgm+QTtBjbA9
         eENzBQP/LDKeEaXB3jeyZHZG1JV20arHJYQs8iV97w7WeMtweWy+wDSg2HoqwqpqkTO+
         nDWPWo4AYsCnXneRihMLiqI0RGL0DyQHsY4ys6I+54yCCSPgATSP30Ea5m8T1wX6Fec/
         pFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I5aWm23y/2/GO0/LXc3I3Aejb6krSPVUOPVGcs93iVQ=;
        b=qRU2+NSCe+5t0flNpY9B5vZm1WJQDD8921xSLXXyQGNQZbQY7jzwJtAz/F3hS1vYYD
         zJCWWRLTnr6pzVezunaBcM9OD43b2gLfAvvk22Kf/VPm8CLpiHFM+2bq3mMFd044akdD
         3ubxUcK2I8zAeWc/Vn05DrLgpifgKYtpzoki2j9AxYT47GF0VBhArGiD+afpu6JeYIxj
         XtQfV/LqbgFcVjGsb5/mJmSaCnaS8GDDr79kGnxO2qKMkBT3SZcS1gTVrBDtw86bZdvK
         GFZe0l53Oqq65OekNKj7xS4kRW7GBPoaqepRCw/snMqg//mljMRv/Kz6QCZ/DxweHblM
         H3TA==
X-Gm-Message-State: APjAAAUoMTYZzkFC7CWTndHXCzKzrF9pWJXjTBavL+4m64OTdgKPmubM
        r0wPwFqwHDxEl8zU1cbYwGg=
X-Google-Smtp-Source: APXvYqyVxs/4PdHRIalzWvl+bz5bWfNw6R6cTmv4KsgqJbq05ndr7SKoZceCKhrT32WQ+JCEh3ihHQ==
X-Received: by 2002:aa7:80c8:: with SMTP id a8mr31542814pfn.193.1553622486182;
        Tue, 26 Mar 2019 10:48:06 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id t82sm28320312pfa.153.2019.03.26.10.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:48:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:48:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190326174802.jnhvtdephykfj6ku@ast-mbp>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 09:45:29AM -0700, Stanislav Fomichev wrote:
> On 03/25, Alexei Starovoitov wrote:
> > On Sat, Mar 23, 2019 at 09:05:31AM -0700, Stanislav Fomichev wrote:
> > > On 03/22, Alexei Starovoitov wrote:
> > > > On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> > > > > Are we ok with breaking api in this case? I'm all in on removing this
> > > > > extra information. We can always put it back if somebody complains (and
> > > > > manually parse in eth_get_headlen case).
> > > > 
> > > > Fine. That seems to be the only way forward to clean it all up.
> > > > Could you submit patch 1 to bpf tree disallowing vlan fields?
> > > > Patch 3 looks like candidate as well?
> > > SGTM, will do. Let me also spend some time and do a simple test for
> > > the vlan case, to make sure I didn't miss something important.
> > > One question here though: would I need to wait for bpf and bpf-next
> > > to re-merge to continues the series? Or we can cherry-pick those
> > > patches to bpf-next as well (and git will work it out during the
> > > merge)?
> > > 
> > > > > We can still have protocol, because in both skb/skb-less cases we have
> > > > > it.
> > > > 
> > > > proto can work in both cases, but is it needed ? Does program benefit from it?
> > > > The kernel side burns extra bytes by copying it and extra branches to handle it.
> > > > May be drop it as well?
> > > I feel like the program benefits from it, there is no need to go back and
> > > re-parse that (and in the skb case, this data is already pulled). I was
> > > also thinking about re-purposing flow_keys->n_proto for that (instead
> > > of skb->protocol), so it functions as input and output, maybe that's a
> > > more clear way to do it.
> > 
> > Are you saying that skb-less and skb flow dissector progs are looking
> > at different positions into the packet ?
> No, sorry for confusion, they are both called to parse (optional) L2-vlan
> and L3+ headers. However, with-skb case can be called with l2-vlan
> parsed (post RFS) or with l2-vlan unparsed (RFS). The vlan is pulled in
> __netif_receive_skb_core, but we can still invoke flow dissector prior to
> that when doing RFS (get_rps_cpu).
> 
> That's why have this 'if skb->vlan_present' check in the bpf_flow.c program
> (and then also manually test for ETH_P_8021Q/ETH_P_8021AD).
> 
> Let me try to post the patches to bpf tree somewhere this week, we
> can discuss the API changes there.

let's figure out what we disable for bpf/stable first.
Sound like skb->protocol isn't helping.
prog has to read it from eth header anyway. then let's drop it from ctx?
skb->vlan_present also seems to be misleading.
For normal processing skb->vlan_present means that there is a vlan hdr
in the packet, but for flow dissector is some sort of weird hint
whether skb-based dissector was pre- or post- rfs.
I think we need make vlan semantics unambiguous first.

