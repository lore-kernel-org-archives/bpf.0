Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC947C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB433206BA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF1yeCd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfDYVbx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:31:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40440 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDYVbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:31:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so868982lfl.7
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWe0gqnTd4hocGwwlPCQDvZYejsBD13goD6JvIVz5Bk=;
        b=XF1yeCd/S1w1DOawif61D6UHRSPAD1ylY3AwuhXhpPFm/Q8/pxWWG/kB+QO+yyAMWO
         S8tng+KMJyhQHHFIzJimXBiF6VXzwIdwu4izNrvGnKq3eGGmxlk7ISPUiHXm+6OHebin
         YHu8eUblGCBd42aZoHRZet9dJtd77Gi1DPGx4aysK4sNSTn67Be2SpRfqNLARGFKT4o9
         9JWVCLg5W8fDCBtOM0/OMcluSdCNR4jAedxp0Y0zcdPO9/QMLhGbhnIhYavgDxsYrRWz
         s4vLcZBSBqS4wlwvCQwLbm+1NTun4oLbvHLDOib2y+8pn64r/JOI/jutEuis2tN91axy
         NVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWe0gqnTd4hocGwwlPCQDvZYejsBD13goD6JvIVz5Bk=;
        b=lP37y9AJZuCqMsQu2UCWPyRI0qVBgEg4M7gNtSviO84+jkShDj76aH2TcLcZOvUABP
         xAwQf0MPP8E4HjAp3q96eQwa64f/b9WVFG/71+d8Cka5XWXxsdhTvQCAFfZ37RIcy0w1
         xu4aIk9nAPWu6Bo+GV38fFlytyOe7ACU5YNGDOO0We/psCO3aziXQ7QtCztt4N11TIDc
         FQHE4OwysCrYK2LgCfV0UZe/z1FlyPl47ylI6jScDuvJVU34B8FrCVv8+v1TLP2PDf22
         GnQSZV6AZn4y5hZqWYcoY9JpQ5BPr/A+k4nGfKi/f6DVqbXRx7jYJ3ikqPgUi34kaNX6
         4YGA==
X-Gm-Message-State: APjAAAXfvHlUgEteQuUw30LmVhUtytkksmr4OFfawgya4HGcEPBXcXU/
        sNe6GxhAJYtHKExw/zc+dyyb12UrEIWYjj3JYY168ChR1T0=
X-Google-Smtp-Source: APXvYqwA7rpxjLYryEtTcJoz0btzhbS6n0lbzGTHEWU/RtHoCf3Ap/a00PjJChPXRupxRON2m9s6mMv4eqdpM1bkrKs=
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr9187915lfn.10.1556227909597;
 Thu, 25 Apr 2019 14:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190424213141.201134-1-sdf@google.com> <f85cf077-aa9e-775f-f3e7-1538354514cd@iogearbox.net>
In-Reply-To: <f85cf077-aa9e-775f-f3e7-1538354514cd@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 25 Apr 2019 14:31:37 -0700
Message-ID: <CAKH8qBvQPGLqZySq7_ghPa+odGuOTSXBq1Mfa=Y_-sVCnArUBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 2:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/24/2019 11:31 PM, Stanislav Fomichev wrote:
> > target_fd is target namespace. If there is a flow dissector BPF program
> > attached to that namespace, its (single) id is returned.
> >
> > v4:
> > * add missing put_net (Jann Horn)
> >
> > v3:
> > * add missing inline to skb_flow_dissector_prog_query static def
> >   (kbuild test robot <lkp@intel.com>)
> >
> > v2:
> > * don't sleep in rcu critical section (Jakub Kicinski)
> > * check input prog_cnt (exit early)
> >
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/skbuff.h    |  8 +++++++
> >  kernel/bpf/syscall.c      |  2 ++
> >  net/core/flow_dissector.c | 46 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 998256c2820b..6d58fa8a65fd 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1258,11 +1258,19 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
> >                            unsigned int key_count);
> >
> >  #ifdef CONFIG_NET
> > +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> > +                               union bpf_attr __user *uattr);
> >  int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
> >                                      struct bpf_prog *prog);
> >
> >  int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr);
> >  #else
> > +static inline int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> > +                                             union bpf_attr __user *uattr)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >  static inline int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
> >                                                    struct bpf_prog *prog)
> >  {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 92c9b8a32b50..b0de49598341 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2009,6 +2009,8 @@ static int bpf_prog_query(const union bpf_attr *attr,
> >               break;
> >       case BPF_LIRC_MODE2:
> >               return lirc_prog_query(attr, uattr);
> > +     case BPF_FLOW_DISSECTOR:
> > +             return skb_flow_dissector_prog_query(attr, uattr);
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index fac712cee9d5..27466e54ad3a 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -65,6 +65,52 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
> >  }
> >  EXPORT_SYMBOL(skb_flow_dissector_init);
> >
> > +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> > +                               union bpf_attr __user *uattr)
> > +{
> > +     __u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> > +     u32 prog_id, prog_cnt = 0, flags = 0;
> > +     struct bpf_prog *attached;
> > +     struct net *net;
> > +     int ret = 0;
> > +
> > +     if (attr->query.query_flags)
> > +             return -EINVAL;
> > +
> > +     net = get_net_ns_by_fd(attr->query.target_fd);
> > +     if (IS_ERR(net))
> > +             return PTR_ERR(net);
> > +
> > +     rcu_read_lock();
> > +     attached = rcu_dereference(net->flow_dissector_prog);
> > +     if (attached) {
> > +             prog_cnt = 1;
> > +             prog_id = attached->aux->id;
> > +     }
> > +     rcu_read_unlock();
>
> Patch looks good to me, one small nit: is there any reason you didn't
> do the put_net(net) right after the rcu_read_unlock() above? Below it's
> not really needed anymore, so this would also simplify the error paths
> by being able to directly return in error case, no?
Yes, good point. I think I was probably mentally locked down into a pattern
where the refs are generally dropped at the end of a routine.
Dropping it right after rcu_unlock indeed looks much better. Will follow up
with another version, thank you for a suggestion!

> > +     if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
> > +             ret = -EFAULT;
> > +             goto out;
> > +     }
> > +     if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
> > +             ret = -EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> > +             goto out;
> > +
> > +     if (copy_to_user(prog_ids, &prog_id, sizeof(u32))) {
> > +             ret = -EFAULT;
> > +             goto out;
> > +     }
> > +
> > +out:
> > +     put_net(net);
> > +     return ret;
> > +}
> > +
> >  int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
> >                                      struct bpf_prog *prog)
> >  {
> >
>
