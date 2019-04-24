Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A498C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA35420684
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="xMTxssWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfDXVGm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:06:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40671 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbfDXVGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 17:06:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so9940002pfc.7
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rVtIgBZvZRJTUlOGEg63mCfmhpvDXAdZVWU4eQWweUg=;
        b=xMTxssWpW9Ky+Ln67ePsiafEdHX1LZCqxtvkYKDgiVoymLwdSTx/bXfTk9IW0xeRPi
         rPW1fZSWu4Xg4qYXpm3wgPLEBq5C2fYh6YsZHrFP080KEmStkE1CjukYxbzp645LNGC9
         wLFm7DNyuP9ZYqrtHU8vzIIDpPJn3CzHvI3Z5letdtm63LMBxFeJEhoSczsK6JhzWW76
         5o5mVpW5n4rr5FsOqP3kokqB4SoMBPAd8ZdftGZJkkIC27iJPWhzPgBF/7wfOvgV4YJN
         HjXtvDSlogkyBC6DtheDbWavNKs8D7L6I4KpqeKueX1orByymmd0tItOfrV6aQUAGDEl
         E0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVtIgBZvZRJTUlOGEg63mCfmhpvDXAdZVWU4eQWweUg=;
        b=t9jZ0axec+s4k2zeOBhQym9g/xPSOaj7sfcHAbXleHY832ltjDa2gErOsjG4pBux7B
         YIMNveuep3hyJHZkZFzzLq29azNpqgejvBAK76hHVpfS9l9Df92Dn0UabbyviqKYq+wJ
         sMQ1essBbECgUTK2oy0p5RzwUQP37ybIIOMDpUI3Wh13LEv3MN2oSYWhMr7iWiOEf5B+
         Rwea6lRg4N/qdRiVSJiNQ8qZoAkLCwSaHaTfdJ04cio/G+D+IjkMJwiNgn6XJdk8xkHB
         qEpv5v9pBBgolaxDGwtyGRSeCiqSIhdukCUzA4D/BMqjuwSaLXtNFh7OI9HGCkTOBxoZ
         kjeA==
X-Gm-Message-State: APjAAAX1caHpgQQ1vdEJeI4I0G4lw1mU0qanDYsy99rCnfxOFZSlYtdj
        FbsH0LMMGsuqTfi2F4b2ofQxMQ==
X-Google-Smtp-Source: APXvYqxc8cyCUydoUiJc6sxd7PSyhfF/xShxaZv2WjkgUU4nXcBWQJo5q/9Fvt4pNgRDJRpO6nTcXw==
X-Received: by 2002:a62:474a:: with SMTP id u71mr34818291pfa.87.1556140001182;
        Wed, 24 Apr 2019 14:06:41 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id j12sm24469407pgg.79.2019.04.24.14.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:06:40 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:06:39 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jann Horn <jannh@google.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
Message-ID: <20190424210639.GD1247@mini-arch>
References: <20190424160951.45865-1-sdf@google.com>
 <CAG48ez1aEenkwonZ2UXFOE46kdPWhsiOMNory4gQgK9J5kz1ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1aEenkwonZ2UXFOE46kdPWhsiOMNory4gQgK9J5kz1ug@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/24, Jann Horn wrote:
> On Wed, Apr 24, 2019 at 6:09 PM Stanislav Fomichev <sdf@google.com> wrote:
> > target_fd is target namespace. If there is a flow dissector BPF program
> > attached to that namespace, its (single) id is returned.
> >
> > v2:
> > * don't sleep in rcu critical section (Jakub Kicinski)
> > * check input prog_cnt (exit early)
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> [...]
> > +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> > +                                 union bpf_attr __user *uattr)
> > +{
> [...]
> > +       net = get_net_ns_by_fd(attr->query.target_fd);
> > +       if (IS_ERR(net))
> > +               return PTR_ERR(net);
> 
> At this point, you're holding a refcounted reference to `net`. It
> looks like that reference is never dropped?
Ah, indeed, put_net is missing, thanks!

> > +
> > +       rcu_read_lock();
> > +       attached = rcu_dereference(net->flow_dissector_prog);
> > +       if (attached) {
> > +               prog_cnt = 1;
> > +               prog_id = attached->aux->id;
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
> > +               return -EFAULT;
> [...]
> > +}
