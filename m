Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B819C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314D2175B
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzeMH6E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfCTSaf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:30:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCTSae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 14:30:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so2881020edq.4;
        Wed, 20 Mar 2019 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBnilLO7QZ1YZ1qFHzuRuVRazTgwBBJga/7quL355Sk=;
        b=RzeMH6E4WPPmoxajjupEJPgTKyCH01j4RCpRgVIaFj/TJcUDHQIoRcNTuNZZmPcwqv
         MjOlMoEaUDzTOxYs5hKp5a9Y80xQPKCXAs4D4df984AD37KYBQ8tv2tJyL4aVGKcOe3E
         35MXwrgAfcvdpKOWAhRGN/fpxjma7W3wfswl9k75LTKFbIvbQZr/ILIe+2EC7jiTtdZ7
         drfw5zqirEMK9YpXRT1zmIJQ9TOx6vcpz5UhNbhSqu37AW5tmL5IGccJtgtZlkqQm4FW
         zXrP1M3p8GCUs67kxIvaNTU4DVJunvFsVohDePDAFVbn3JxZfeQc+DWeBwUYyvWL/GI/
         00Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBnilLO7QZ1YZ1qFHzuRuVRazTgwBBJga/7quL355Sk=;
        b=kg19/9LE+R2k0T7aBodrP3UqVS5q2j48PtZiC8rauiRMCbKbc7ti2FfLq1gvZAuj7f
         gRp1ZHyG6e/EqSh4AV15b54PKnJQiCl81vB81O+oK6PhyeXDVtG439UaJcNOwfhGbiTv
         W++Vj2iAKVofIe6nBowpmaQEN0304OVdIs7xWc/FIt44u9uPjLCMU3fQfMJzWiwM9N5N
         +UahFg+NsaEGZYwtUBwb1O59KT93iBU385xZIPt1dfzSOt4FlSn6nzDM+MMPDc4LC/F+
         d2D95v2XfWu0v8iFuHu8te6mtrL0eLtVr5zMJ/A805seh1t3yQR5hJNNQU9/KyluUKu8
         z7+A==
X-Gm-Message-State: APjAAAXUzBO06XAVl0+MI3ScdFg3++cXJUultLHLjrbbIdbJsoxN0qvj
        LnXeYt2CtAVapdjtpBYxeHJ+w+oveMmGFT1oYdQ=
X-Google-Smtp-Source: APXvYqwTeyhAlVEXj71EEuikZknaWnf4Nv3GP4TpuYLsR4mwYMidqx4fXBIlorQRAg/LfADVd6175haOjNEpgZM+88o=
X-Received: by 2002:a50:f286:: with SMTP id f6mr7456528edm.139.1553106633128;
 Wed, 20 Mar 2019 11:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-8-sdf@google.com>
 <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com> <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 20 Mar 2019 14:29:57 -0400
Message-ID: <CAF=yD-J3RDh=pX490gO2c+ybe5ZUbeYsEqGyFVcCNXMDHXqE6w@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 7/9] bpf: when doing BPF_PROG_TEST_RUN for flow
 dissector use no-skb mode
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Stanislav Fomichev <sdf@google.com>,
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

On Wed, Mar 20, 2019 at 12:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 03/19, Willem de Bruijn wrote:
> > On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Now that we have __flow_bpf_dissect which works on raw data (by
> > > constructing temporary on-stack skb), use it when doing
> > > BPF_PROG_TEST_RUN for flow dissector.
> > >
> > > This should help us catch any possible bugs due to missing shinfo on
> > > the per-cpu skb.
> > >
> > > Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> > > nhoff=0, we need to preserve the existing behavior.
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
> > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > >
> >
> > > @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> > >         preempt_disable();
> > >         time_start = ktime_get_ns();
> > >         for (i = 0; i < repeat; i++) {
> > > -               retval = bpf_flow_dissect_skb(prog, skb,
> > > -                                             &flow_keys_dissector,
> > > -                                             &flow_keys);
> > > +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> > > +                                         size, &flow_keys_dissector,
> > > +                                         &flow_keys);
> > > +               if (flow_keys.nhoff >= ETH_HLEN)
> > > +                       flow_keys.nhoff -= ETH_HLEN;
> > > +               if (flow_keys.thoff >= ETH_HLEN)
> > > +                       flow_keys.thoff -= ETH_HLEN;
> >
> > why are these conditional?
> Hm, I didn't want these to be negative, because bpf flow program can set
> them to zero and clamp_flow_keys makes sure they are in a "sensible"
> range. For this particular case, I think we need to amend
> clamp_flow_keys to make sure that flow_keys.nhoff is in the range of
> initial_nhoff..hlen, not 0..hlen (and then we can drop these checks).

So, previously eth_type_trans would call with data at the network
header. Now it is called with data at the link layer. How would
__skb_flow_bpf_dissect "swallows L2 headers and returns nhoff=0"? That
sounds incorrect.

Agreed that the output should lie between nhoff and hlen, but as far
as I can tell it is always zero indexed to the data passed, here the
link layer:

        if (!data) {
                data = skb->data;
                proto = skb_vlan_tag_present(skb) ?
                         skb->vlan_proto : skb->protocol;
                nhoff = skb_network_offset(skb);
