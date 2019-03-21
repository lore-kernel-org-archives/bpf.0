Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E3C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775A218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruHmT0+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfCUQNv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:13:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUQNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 12:13:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so5507260edg.0;
        Thu, 21 Mar 2019 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE5LDvqnOby84DX4sq8IwASC4B6RaQi7UFF2VQLWRCc=;
        b=ruHmT0+xlO3ZOmv5tLUpS6sCzvXlDeNwdUna2ST1gKUJyOW6uX4AOOGNNPAf3rZFm2
         DhZGW73Dmo9c71N9rcmhozMHrf1KchoQBYRANKrFE8v3gwj7C1Wd4LoDcoWcF1odKCoF
         pgkHUha3R0GdEEW+6p9rrEhqNvNIsKqY04fkY/ZonEj9I/m+AQcJcaLimaNktpvYWGtP
         h13s5FRdlI5U/RHYDPqTveC3qMOu+50rojz9JhoHBtDKjO2CPU8u/fbHs5u1EYPD9QaY
         65epycXOzw/HUsGi5VurvrDToA2apJwCa7CaCamh92BI/BYFevkr7Gk6LEIOxxmVELi3
         jq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE5LDvqnOby84DX4sq8IwASC4B6RaQi7UFF2VQLWRCc=;
        b=mD9V8wkhhnhmeSXWZACQFf4L5TRNocaapCHvfmRzDv4WSLD2r/McY/mP/RapVNWmuv
         669ZW6oXTHibCat0jgaK8BBfAY/Yu63ohoAr6rH5vNteTRWuqCrYb6I0y/3bEVT7t2+L
         sDuu6A6epIFaMo/KBoYZuR14iBJzml2U3v7+w9bk88gw2klwZIa74YAwVUzvXXvLY+X2
         Gsn8HMeqp4yw+v4hqaQfupAY4/4WeLjMSPI8vmkgrra+rFUmEqSPz8XetEfRBhGm9Sa0
         JHYW/+04IN+U/V2usDQ9iQN3qz+opiSSv/e9HggmfcTAEaMYA8iMepOHXQYLyQfm7CJR
         EMIw==
X-Gm-Message-State: APjAAAVu4FYZvBYQWslmcJ39cQno8AJw+u862QUWmk6EL+/2pT4jnGgU
        c/iHHgutlCGo6aXf/ttwqDbacgggmIP8qD/lGm4=
X-Google-Smtp-Source: APXvYqzIiGBm8zkwnDcIRkURUKpyZYnxojlgdm+feAhcok52Gxl/T8rr5Irje/LAscPQ/KaK/RVgwYTEW8HXiXsmn+I=
X-Received: by 2002:a50:b6a9:: with SMTP id d38mr2993363ede.98.1553184829212;
 Thu, 21 Mar 2019 09:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
 <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com> <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
 <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net> <20190321160057.57u7ahijddqwtfdd@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190321160057.57u7ahijddqwtfdd@ast-mbp.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 21 Mar 2019 12:13:13 -0400
Message-ID: <CAF=yD-+-aR7r2u+xEXQfn1u7e9-s2F9qmQXR4w-8Qw0BEvb6Pg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo} helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 12:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2019 at 08:44:33AM -0700, Stanislav Fomichev wrote:
> >
> > If we can agree that we switch everything to xpd-like, do we deprecate the
> > skb-one?
>
> This whole discussion that have been going on for long time is an indication
> that initial bpf flow dissector concept was not thought through
> and I regret on merging it in the first place.
> Adding more hacks on top of it with fake skbs is not going to make it any better.
> Since it's been in the official release we cannot remove it now.

This patch set addresses the only open issue.

That said, if direction is towards an alternative interface, then it would
make sense for the new interface to supplant the existing one for all
use-cases, even if that existing one cannot be removed.

Essentially a BPF_PROG_TYPE_FLOW_DISSECTOR_RAW that
takes a simpler context than skb. And either that or a program of
type BPF_PROG_TYPE_FLOW_DISSECTOR can be attached in
skb_flow_dissector_bpf_prog_attach, but not both.
