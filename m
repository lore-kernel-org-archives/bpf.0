Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB5C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26F2183E
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="qY2cYGO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCUVN2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:13:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUVN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 17:13:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so5044305pgp.6
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vdt5yEeVUhroyhs/HesFbUCcTh0Jt7YhpOQWIiUNQ1U=;
        b=qY2cYGO9w8hYHObFqr2yDb5VzCxOOWkctsmCkayjF8ZxHOhlg7lt7zNf5Op9AgHfRV
         EJY85lQ9OCexHljCaEHYTnrXSfULqWJigURR/rjZhO9MPuAWLmRjbKo+XR8a4AyzRgnb
         aCGGUOcehAE9aCRaK4WojdAiRZg/4s0MLzFalt3qFXrwkdbqiaku3T6JCrbpPwgN+zuO
         6XBbbP080CoETGELWs6l9RmYcWAZFbPhodn0j35c1klygZs8fua/O55vr+OAq2HUAjNE
         VPOlNDJbf3Ey5F2ylByzioAzCw31VC21NxGdxWEGw3doJWS7vuMyFRztyQzEUhlm+orL
         eCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vdt5yEeVUhroyhs/HesFbUCcTh0Jt7YhpOQWIiUNQ1U=;
        b=CYzaQrg56T9kKi5d4iWtwIZvl/MJSEwKGxv0G9RVAa81qhX5X8eCps2iOanG1zYSdv
         H0+7SleIBi/n+2dh8/hPAm3mFEHWZt81Rsb6e6zQ3Q11r3bjRCfzEioxvloEaHFivOx6
         BI6J8+miSV1Xma/iVFZF3riQjnRBx6l3QnX969AOXUneDf5/24f6hZ5LO4V0duCzW/SK
         v6TYkISvLCjvh3wioVayGmKGK/VQVAcmDs+bstHqmrEC6XWVXWG7z+OfWzTf8p2dL6W4
         HrnnFyD636NkrJzzH9LCcBBOlWL4b85xmA67mIdhXKlFQ2TPp/V4TpG31Qx67TcMJHNS
         wa+w==
X-Gm-Message-State: APjAAAXRMT8Nt2etuOoRV9vMHYEIFm/JVjCT++6s9Sd9yeBT+GEQfDF8
        6b9rGEqG2UkXTo7hoZQ60cV0LQ==
X-Google-Smtp-Source: APXvYqzNZ6zkRoqiyL7wTI9YAx9HXhQJT15PA7u7TuF6HkkasoNj9WDGgNrtmDEvH2R+CNpqWLd9lg==
X-Received: by 2002:aa7:8059:: with SMTP id y25mr5333794pfm.74.1553202807032;
        Thu, 21 Mar 2019 14:13:27 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 73sm6882012pga.19.2019.03.21.14.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:13:26 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:13:25 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo}
 helpers
Message-ID: <20190321211325.GU7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
 <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
 <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
 <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net>
 <20190321160057.57u7ahijddqwtfdd@ast-mbp.dhcp.thefacebook.com>
 <CAF=yD-+-aR7r2u+xEXQfn1u7e9-s2F9qmQXR4w-8Qw0BEvb6Pg@mail.gmail.com>
 <CAADnVQJ+_aEWnMe8FfDX6_5muxgXUPynPrpH62ezwjRORm5RgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ+_aEWnMe8FfDX6_5muxgXUPynPrpH62ezwjRORm5RgQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Alexei Starovoitov wrote:
> On Thu, Mar 21, 2019 at 9:13 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2019 at 12:01 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 21, 2019 at 08:44:33AM -0700, Stanislav Fomichev wrote:
> > > >
> > > > If we can agree that we switch everything to xpd-like, do we deprecate the
> > > > skb-one?
> > >
> > > This whole discussion that have been going on for long time is an indication
> > > that initial bpf flow dissector concept was not thought through
> > > and I regret on merging it in the first place.
> > > Adding more hacks on top of it with fake skbs is not going to make it any better.
> > > Since it's been in the official release we cannot remove it now.
> >
> > This patch set addresses the only open issue.
> >
> > That said, if direction is towards an alternative interface, then it would
> > make sense for the new interface to supplant the existing one for all
> > use-cases, even if that existing one cannot be removed.
> >
> > Essentially a BPF_PROG_TYPE_FLOW_DISSECTOR_RAW that
> > takes a simpler context than skb. And either that or a program of
> > type BPF_PROG_TYPE_FLOW_DISSECTOR can be attached in
> > skb_flow_dissector_bpf_prog_attach, but not both.
> 
> another idea is to keep 'struct __sk_buff' as a context,
> but have kernel side to be something like struct xdp_buff
> and disallow access to fields of __sk_buff depending on
> attach_type.
> and do different ctx rewrite for __sk_buff->foo
> depending on attach_type.
That's a great idea! The only problem that in this case, I guess, we
need another attach_type and need to ask users explicitly attach to it.

What if we go a bit further: always have xdp_buff-like struct in the kernel?
For the real skb it would have data..data_end point to linear packet data (or
the first fragment). We would always prohibit access to most __sk_buff
fields (like in patch #5 from this series). We'd have to write our
own bpf_skb_load_bytes, but that doesn't sound like a big issue.
