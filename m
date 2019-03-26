Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83439C10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD58206DF
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf/7Sc2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfCZSaV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:30:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40276 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfCZSaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:30:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id b11so2023822plr.7;
        Tue, 26 Mar 2019 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z2u6n1abBEfpfhUeoYFjIYu+h6yMjAoXuYBy06L41Xc=;
        b=Kf/7Sc2hPtWkjUncI9NFzuViDi6QcK7JuhQi8HXgBr3Roj6arldcVDdVnc/SOc70e4
         YTbRXjN0nrPKVhb4tFGv08VaoWn8jhtBxJY8tubaD0wCVZturaBepEDgeyKizXMs6HTU
         5Aprox15VVcJBncOu5LHMU1RmxasZkNplz0L1spGInTD/DHxv37wmPw6RPR8RNLwoHFs
         lmYF473ZlAzC0f90G+APFrGEtmIGbBY4j/jf0NeFva4q39+lyHY5abQmMiVCzbaxBck3
         83sPha98c8k0/GrKAYPc2A3NxUWXIy1yurnqYVCZyGFsAP+yB2uJGsv07oH4aGU9lLdW
         h+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z2u6n1abBEfpfhUeoYFjIYu+h6yMjAoXuYBy06L41Xc=;
        b=ce3HkC6kRNduPrFMkzE9qhFs2eqlUfeBr7XXQxcPR1jRYI3OvERWiOjRSjl7+2T4WI
         Yi2FD2f8ynbmROUqNdhrycreCSQD/jkLnmmR7XhAyXNDdpWvhY/SmnHDFkEsLNoBernc
         VgCM64QtjOt8M8tfCCsXMzWDcTosvwqEDS+RBTDcDcAgUCS2pm1o8sxkDZGGFKsV/vVe
         b+1RvnI8OAJa5uGExiP936cRDVcU1LO68uY3n15DvpV/VC908dto6g8SXep+48Yz9eRx
         GjnUSqF+wfhHOwSiaKoefmU+8bMEabuW7ebD48Nb1wSMU782QknMkgr0SzbDOFsO8aZN
         hLrg==
X-Gm-Message-State: APjAAAXmCivsCDX8HWWfBIakIsEveDxNGqTT3GfAFExiXqDSGeoT4VD0
        U5UezeIArl95X8WZ6D31e1LgvgKO
X-Google-Smtp-Source: APXvYqz2Xak1uxlAM92xST4EVOr6HCL6ihvLJAD7oPxORRfj/06pV2mBo1Gc4xQ+AAgDb5hx/KvsyA==
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr32774188plx.13.1553625019436;
        Tue, 26 Mar 2019 11:30:19 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id j28sm1774768pgb.46.2019.03.26.11.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:30:18 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:30:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
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
Message-ID: <20190326183011.jly4j3s332yohrj5@ast-mbp>
References: <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> On 03/26, Alexei Starovoitov wrote:
> > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > The BPF flow dissector should work the same. It is fine to pass the
> > > data including ethernet header, but parsing can start at nhoff with
> > > proto explicitly passed.
> > >
> > > We should not assume Ethernet link layer.
> > 
> > then skb-less dissector has to be different program type
> > because semantics are different.
> The semantics are the same as for c-based __skb_flow_dissect.
> We just need to pass nhoff and proto that has been passed to
> __skb_flow_dissect to the bpf program. In case of with-skb,
> take this initial data from skb, like __skb_flow_dissect does (and don't
> ask BPF program to do it essentially):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> 
> I was thinking of passing proto as flow_keys->n_proto and we already
> pass flow_keys->nhoff, so no need to do anything for it. With that,
> BPF program doesn't need to look into skb and can parse optional vlan
> and L3+ headers. The same way __skb_flow_dissect does that.

makes sense. then I'd also prefer for proto to be in flow_keys to
high light this difference.
may be add vlan_proto/present/tci there as well?
At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.

