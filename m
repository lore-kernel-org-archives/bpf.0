Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CDBC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FE4213F2
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="YJxt4IiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfCTQtO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:49:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCTQtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 12:49:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so2335558pfc.7
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iJppJ+DCOMSINiUigIohl6LvvDcmeaH90di7WHLj7Jw=;
        b=YJxt4IiSQO1IoBzt6R1VXkkBT6H/D5ZmENsvod5TzrrepJZ6mTGzCwiyOfzlZkzi4C
         dZNQkGjywwwxkHlGQnoziR19O2+7zvqlNokPluXUVg3qSsez7zzioxewU6yfnaeCbg9i
         LA4cJ7d+MbtHQdbhWmrVoGG2lliOmhqm81txuzUqzzFHmyBXqjH73MbwTU7qiAINzmK+
         kAKp0B1JPUvNIeaJeYlYnZVlEwZzL6wVZg5pY5g74ffisyv8RkZCJnaHVaguhhn7xYHq
         ZAPiZRvvwSLZonVHXzx0uhq7MIjML5eavlXowBa+lKPda0drT237SD3VspxC2rmP43V4
         yL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iJppJ+DCOMSINiUigIohl6LvvDcmeaH90di7WHLj7Jw=;
        b=ix8PrMaMOBBydRv4l4uCzXKHBLmguHnKJVrs80hvz39sUTK1MVpNWuIoehjQoqiMkt
         OmGrpK4yJ71W4nWBM4WOACzRMV6A7NHjONY/CiFkDEpkGl8sTuTO58DGKUy40LmMiszg
         AV+HIbgwrnpGgJ6NQ/VwgH275zANTswFR/znhUHq6C0YM8WXSs9Q1W0y/1a2tpwdNI6l
         5kWfH6PJaaC6gTgvwqslgnYDAvFUu2Ts9otTbjFa9r0o3xcRYSIOc/nKbqs6Y1OnvL+C
         Vpxd8E+/HMAdMtnE8dL79LNJuIh8EpUu53JBrz6GU9y1KYx2Ug5McEmmTWTpYce7DQ9H
         t8jg==
X-Gm-Message-State: APjAAAVMmlLyxPDMjzXFiiVkudBjD8FNQco45pwY0SzNu22EkWUpw7K8
        sY+PqD0fXsvMtAfmlWg0MJmoP4z5SFA=
X-Google-Smtp-Source: APXvYqyoWDOOodHWPt0JZSxKNqfdBvDg4ixKmR3YX/xYgkQLB4uaJ49HXHkJsDGyBRYEp0/nFcBVkQ==
X-Received: by 2002:a17:902:28a7:: with SMTP id f36mr9019645plb.169.1553100553708;
        Wed, 20 Mar 2019 09:49:13 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id u62sm8532952pfa.124.2019.03.20.09.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 09:49:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:49:11 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] net: introduce skb_net helper
Message-ID: <20190320164911.GH7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-3-sdf@google.com>
 <CAF=yD-JbxFKSVGuXz0-LbzAzSkMR-wZFEQe0e1mck2EY6vn3vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-JbxFKSVGuXz0-LbzAzSkMR-wZFEQe0e1mck2EY6vn3vg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/19, Willem de Bruijn wrote:
> On Tue, Mar 19, 2019 at 6:20 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > skb_net returns network namespace from the associated device or socket.
> >
> > This will be used in the next commit.
> >
> > I tried to inline it in skbuff.h, but I don't think it's feasible.
> 
> If so, is this helper necessary?
> 
> All existing cases that use it pass both skb_net(skb) and skb to the
> flow dissector, so can continue to call it locally if new argument net
> is NULL.
> 
> The new users are in patch 9/9 in the device drivers, but those should
> pass the device pointer unconditionally.
Good point, I can try to drop it.


> > It depends on 'net/sock.h' for sock_net() and 'linux/netdevice.h' for
> > dev_net(), both of which we don't include from 'linux/skbuff.h' (but
> > both sock.h and netdevice.h include skbuff.h). I though about doing
> > it as a macro/putting it somewhere else, but we will have
> > skb_flow_dissect{_xyz} use it in the next commits.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/skbuff.h |  2 ++
> >  net/core/skbuff.c      | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index e8c1d5b97f96..75e1d4d73cca 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1275,6 +1275,8 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
> >  }
> >  #endif
> >
> > +struct net *skb_net(const struct sk_buff *skb);
> > +
> >  struct bpf_flow_keys;
> >  bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
> >                             const struct sk_buff *skb,
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b413354ee709..d81f3a95fb4e 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5725,3 +5725,19 @@ void __skb_ext_put(struct skb_ext *ext)
> >  }
> >  EXPORT_SYMBOL(__skb_ext_put);
> >  #endif /* CONFIG_SKB_EXTENSIONS */
> > +
> > +/**
> > + * skb_net - Return network namespace associated with skb.
> > + * @skb: skb
> > + *
> > + * Returns pointer to struct net or NULL.
> > + */
> > +struct net *skb_net(const struct sk_buff *skb)
> > +{
> > +       if (skb->dev)
> > +               return dev_net(skb->dev);
> > +       else if (skb->sk)
> > +               return sock_net(skb->sk);
> > +       return NULL;
> > +}
> > +EXPORT_SYMBOL(skb_net);
> > --
> > 2.21.0.225.g810b269d1ac-goog
> >
