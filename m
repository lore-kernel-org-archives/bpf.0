Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F570C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B3B20823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="T/bJuVbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCZSy6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:54:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37600 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbfCZSy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:54:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8491669pfr.4
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=79vmV+9dblqcVspKzMVCUrlm+c5aj/qTj8emumUqKVk=;
        b=T/bJuVbGi4V7UPcjic3/z6JnPQaw2G5VWwBhKuJ5KNJM7DQfGVziB5bpk/B1j8cVAY
         QXuwm7RUKILRTIN/Eq2rAWosRuKORskelJhZBwezkCEO6ILYtLzRTl8ynVfPHDekzXfz
         p6w+Cid220Ixk7UH3bxwVR2PApWq5JAHa6nKnFHRreZRNdqDhUykD4rvRSryn1rknLC6
         YYZ2HevZN6/ajt6DfDHMD99oF8WLQvzYE471buELBGFUhQVOSKgBHcbci2ajotDowQBg
         UymtjU5QBpcR1kgFdCAnsBSe25p2DO07kmRu3X51pF9XIFD70I/QhXQDMZOLCF1z+QKi
         +4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79vmV+9dblqcVspKzMVCUrlm+c5aj/qTj8emumUqKVk=;
        b=MxIq+iBSpceXXokRXAlz+7v4Z18IFDHlZEf3NV+BtztB0KPBwT5aoGQc8xl91/byKi
         NQQf2nPXv8ivy2ES/p+FG47D/FixORW+C3nIRjaWHYgjlIutRCL5nCFlphS3XzR2std/
         Cg/KxmsVLrnOX5jHCu0r3YNuh5jh94IwBAXo2kmOFcwnAgcNZpIVx2phEU2YrYka8b0o
         U05GIGXwCUCvXe+SsKy+3NvlVzDquD82AishzjuaQw18EAqVxEHdSD1r9HYyfkqqPkqF
         98MSZRpJCmHxY1J5jL7vFw7sOK3oc9QUp3JMt7fwdd6hVpncmaOtqZ8cDXRmn94yn/XJ
         hRGw==
X-Gm-Message-State: APjAAAVD7KWwA7tLMcoakDK9WngNl2rNZcqdJ6uofUvLYxRgrHgecLEW
        KPHeOfA++gxtv5DkKQ9BHTCSJg==
X-Google-Smtp-Source: APXvYqw1f2os1UgfwXAaI26xPCTDGc6cO9RUtQOy6/w3v7rGCwPdw15GSJl0wk6hog0AEviNdcHzyA==
X-Received: by 2002:a63:54b:: with SMTP id 72mr29804580pgf.323.1553626497798;
        Tue, 26 Mar 2019 11:54:57 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d20sm5643365pfo.77.2019.03.26.11.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:54:57 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:54:56 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
References: <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326183011.jly4j3s332yohrj5@ast-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/26, Alexei Starovoitov wrote:
> On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > On 03/26, Alexei Starovoitov wrote:
> > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > data including ethernet header, but parsing can start at nhoff with
> > > > proto explicitly passed.
> > > >
> > > > We should not assume Ethernet link layer.
> > > 
> > > then skb-less dissector has to be different program type
> > > because semantics are different.
> > The semantics are the same as for c-based __skb_flow_dissect.
> > We just need to pass nhoff and proto that has been passed to
> > __skb_flow_dissect to the bpf program. In case of with-skb,
> > take this initial data from skb, like __skb_flow_dissect does (and don't
> > ask BPF program to do it essentially):
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > 
> > I was thinking of passing proto as flow_keys->n_proto and we already
> > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > BPF program doesn't need to look into skb and can parse optional vlan
> > and L3+ headers. The same way __skb_flow_dissect does that.
> 
> makes sense. then I'd also prefer for proto to be in flow_keys to
> high light this difference.
Maybe rename existing flow_keys->n_proto to flow_keys->proto?
That would match __skb_flow_dissect and remove ambiguity with both proto
and n_proto in flow_keys.

> may be add vlan_proto/present/tci there as well?
> At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
Why do you think we need them? My understanding was that when
skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
that vlan info has been already parsed out of the packet and stored in
the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
points to proper L3 header.

If that's correct, BPF flow dissector should not care about that. For
example, look at how C-based flow dissector does that:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944

If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
and move on.

But, we would need vlan_proto/present/tci in the flow_keys in the future.
We don't currently return parsed vlan data from the BPF flow dissector.
But it feels like it's getting into bpf-next territory :-)
