Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07188C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17702082C
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRuavD93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfDBUwZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:52:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38126 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 16:52:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id r2so5457787ybl.5;
        Tue, 02 Apr 2019 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqqrAECT1ILD3F2uHKFt/siM2Vc70gc4L2L68y62cU8=;
        b=GRuavD93YKr5me8HnTyb3iZreDSyTS0WDrJanML5F2FWth0V7NcSUKudRj7QsqscBW
         LL6KqfeqR8kGT1eMNhJOZeOmo5X30Fl+OXDHtyVOuKdxJ3NuDjfUGt0+S+G1xcBNM72z
         fFQwIPIDxHMWQw1NG7H+vp77M3NHMPo6/710V/Qvm+wYpaFbx7DOAqGFcHGjQu3ZB57O
         SfM/M3R3pxrjBpXMzHkqG62yBSr1rUbvK/rFKU90NRPNTmb4F+uQuv3DRcOEwAL+iN4J
         6s0HT0YsG+ps93sBvny5cEh4bh9Bdw9QganQGtdOebH+hzX+hwEXqEQqBHNOsNHCYd4U
         W2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqqrAECT1ILD3F2uHKFt/siM2Vc70gc4L2L68y62cU8=;
        b=Z7ubtrH+C76z8jAFcWDmQhtzk3Gpw4Yob8hC7lIV3/vGmR0wnwR45uVm+j+DN5Pjm6
         cFrhIj/tE7a7rSopOSD95XyuJB2ScEiANak7OzAbxjpqK2ByCOBxBKyzOxLW4olfgrxD
         xZfU1+XkGUAw6WvtMTt7QT6QMG5o/bS4uyhT7Gb6O8tmFHIEF0ZoR2fOBkVVSDXbrXI/
         WIeTz8an6hqD/4MMPVJ0AacPfAWGpZ3ssWhntuelihluS5Rpsdqbj42z80dp0rXiGuZ9
         BkJN7gFoQtG4aI524xSBhiVQpFNAjweNYbqyTKKoRsZBmMbTQke5AeKjmunnd6zA28Pz
         ebFA==
X-Gm-Message-State: APjAAAV8rsSyN/sOalX8s0Y+mYuMVWXwdMFA+Jjpk2oEuXj2GhpDCzE3
        PIkwcvx5d8yzEWFIw3rVkBOgMUhbRab936KxRNM=
X-Google-Smtp-Source: APXvYqy6MaYAXEggqDNXrCnnK7cufKvkfByGlm9otFDsvwBuB5itNMH6HQ/WR6KdmQejGng7mdpl4HvAt58AYdso+K8=
X-Received: by 2002:a25:3b44:: with SMTP id i65mr57926526yba.90.1554238344620;
 Tue, 02 Apr 2019 13:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com> <CAF=yD-JOZuJ4cg30Gcx-RU2KHZ5iy6gJ=okhVbcNybRkqRY+dw@mail.gmail.com>
In-Reply-To: <CAF=yD-JOZuJ4cg30Gcx-RU2KHZ5iy6gJ=okhVbcNybRkqRY+dw@mail.gmail.com>
From:   Petar Penkov <peterpenkov96@gmail.com>
Date:   Tue, 2 Apr 2019 13:52:13 -0700
Message-ID: <CA+DcSEg++t_+44_3Sn3zzaQD3sfoww8CdKGbpHGJkSjvNvQDMA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/5] flow_dissector: lay groundwork for calling BPF
 hook from eth_get_headlen
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 2, 2019 at 1:18 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Apr 1, 2019 at 4:57 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > This patch series fixes the existing BPF flow dissector API to
> > support calling BPF progs from the eth_get_headlen context (the support
> > itself will be added in bpf-next tree).
> >
> > The summary of the changes:
> >   * fix VLAN handling in bpf_flow.c, we don't need to peek back and look
> >     at skb->vlan_present; add selftests
> >   * pass and use flow_keys->n_proto instead of skb->protocol
> >   * fix clamping of flow_keys->nhoff for packets with nhoff > 0
> >   * prohibit access to most of the __sk_buff fields from BPF flow
> >     dissector progs; only data/data_end/flow_keys are allowed (all input
> >     is now passed via flow_keys)
> >   * finally, document BPF flow dissector program environment
> >
> > Stanislav Fomichev (5):
> >   selftests/bpf: fix vlan handling in flow dissector program
> >   net/flow_dissector: pass flow_keys->n_proto to BPF programs
> >   flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
> >   flow_dissector: allow access only to a subset of __sk_buff fields
> >   flow_dissector: document BPF flow dissector environment
>
> For the series:
>
> Acked-by: Willem de Bruijn <willemb@google.com>
>
> This looks great to me. Thanks, Stan!
>
Acked-by: Petar Penkov <peterpenkov96@gmail.com>

Thanks, Stan!
> >
> >  .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
> >  net/core/filter.c                             |  16 +--
> >  net/core/flow_dissector.c                     |   4 +-
> >  .../selftests/bpf/prog_tests/flow_dissector.c |  68 +++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_flow.c  |  19 ++-
> >  5 files changed, 196 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/networking/bpf_flow_dissector.txt
> >
> > --
> > 2.21.0.392.gf8f6787159e-goog
