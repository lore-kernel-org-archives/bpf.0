Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B80C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3D206B7
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF6wkL8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBWCbk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:31:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWCbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 21:31:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so1890961plb.7;
        Fri, 22 Feb 2019 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+geYU2x9ValRfcN+cVEc5qlJIrxjVyE1FGXupl6GAQ=;
        b=VF6wkL8yN/dr48foodiR5WMWG0FPVTkvBcrtbIFgndlxrWlRqM0QCN4CM2BKrg/AKK
         VBqRjHe5PJJwPZnNczsiwlItMJYfkYFkxkzuq0rmlXjlbvxQyyVRcXMgLj/7pPOy7t9C
         QlLnU4qABSyIfNYmbk/CCLDYuQ14t7bGxy+aLolgjRWFM0sIJZgfa7YWigIE95703fjC
         ml2pXyyYrL/KHbpREqpy1lJgm2bCiE9zSXZVpk1EW164hgbupGYw0hS4HgoCmIaDPAgq
         ZYCt+nAQwvQkCAf6M44Uy20Jei8UM+9Ar4NuQn4j0fPphheZw+6B2yv8PKmycVHriujI
         Dg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+geYU2x9ValRfcN+cVEc5qlJIrxjVyE1FGXupl6GAQ=;
        b=i7Veja60shfrkOWPzAjm0syiQd2Sr875Irw2ZGAX0VQlkIImpnTnfb9LeANw4vRIc9
         1aNwjaXwHLlVtN7QoLOOT2tneiW2wcHRZgFWDJkpyLLjyowT/OyW+i7r/ewIM2fl8i+h
         /3Mt0plQgEDblXi6Ie3OrgTCPW3ozlzDW4CoCFd1eAnxYDg615zhUASC1pzSRLj7eaav
         gz+40WCpOry+Mnn2rb9WxxX03KevN9dB+c7rD7urov8MI4LhnRw+bx46aEh3oUmfQUr9
         WvUICaqDLPaoV8ExOi8lq2cXShn3ONaToGYcLAnp+0z11FZ+l+mQwpuAAECH5B9ThV7M
         zq/Q==
X-Gm-Message-State: AHQUAuYtY9In4akna3Dr9gHF9gzrzSpMTf8LD1/4teQZQz2MxaxrMN06
        g4hWl9GuWyuI93OBpxafwks=
X-Google-Smtp-Source: AHgI3Iba2NTJON6RpfNp5UmGQxGgXVh9qLIrx+PikjAtWPqxDA6zj3Oeslbzj2Qb7Pixo8/gV+I9Zw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr7506252plf.202.1550889099358;
        Fri, 22 Feb 2019 18:31:39 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id e6sm5679007pfe.59.2019.02.22.18.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:31:38 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:31:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Message-ID: <20190223023136.ngg334d2k6aw4qzr@ast-mbp.dhcp.thefacebook.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223003434.GA17559@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 12:34:38AM +0000, Roman Gushchin wrote:
> On Fri, Feb 22, 2019 at 03:36:41PM -0800, Alexei Starovoitov wrote:
> > JITed BPF programs are indistinguishable from kernel functions, but unlike
> > kernel code BPF code can be changed often.
> > Typical approach of "perf record" + "perf report" profiling and tunning of
> > kernel code works just as well for BPF programs, but kernel code doesn't
> > need to be monitored whereas BPF programs do.
> > Users load and run large amount of BPF programs.
> > These BPF stats allow tools monitor the usage of BPF on the server.
> > The monitoring tools will turn sysctl kernel.bpf_stats_enabled
> > on and off for few seconds to sample average cost of the programs.
> > Aggregated data over hours and days will provide an insight into cost of BPF
> > and alarms can trigger in case given program suddenly gets more expensive.
> > 
> > The cost of two sched_clock() per program invocation adds ~20 nsec.
> > Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
> > from ~40 nsec to ~60 nsec.
> > static_key minimizes the cost of the stats collection.
> > There is no measurable difference before/after this patch
> > with kernel.bpf_stats_enabled=0
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf.h    |  7 +++++++
> >  include/linux/filter.h | 16 +++++++++++++++-
> >  kernel/bpf/core.c      | 13 +++++++++++++
> >  kernel/bpf/syscall.c   | 24 ++++++++++++++++++++++--
> >  kernel/bpf/verifier.c  |  5 +++++
> >  kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 96 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index de18227b3d95..14260674bc57 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -340,6 +340,11 @@ enum bpf_cgroup_storage_type {
> >  
> >  #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
> >  
> > +struct bpf_prog_stats {
> > +	u64 cnt;
> > +	u64 nsecs;
> > +};
> > +
> >  struct bpf_prog_aux {
> >  	atomic_t refcnt;
> >  	u32 used_map_cnt;
> > @@ -389,6 +394,7 @@ struct bpf_prog_aux {
> >  	 * main prog always has linfo_idx == 0
> >  	 */
> >  	u32 linfo_idx;
> > +	struct bpf_prog_stats __percpu *stats;
> >  	union {
> >  		struct work_struct work;
> >  		struct rcu_head	rcu;
> > @@ -559,6 +565,7 @@ void bpf_map_area_free(void *base);
> >  void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
> >  
> >  extern int sysctl_unprivileged_bpf_disabled;
> > +extern int sysctl_bpf_stats_enabled;
> >  
> >  int bpf_map_new_fd(struct bpf_map *map, int flags);
> >  int bpf_prog_new_fd(struct bpf_prog *prog);
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f32b3eca5a04..7b14235b6f7d 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -533,7 +533,21 @@ struct sk_filter {
> >  	struct bpf_prog	*prog;
> >  };
> >  
> > -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
> > +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> > +
> > +#define BPF_PROG_RUN(prog, ctx)	({				\
> > +	u32 ret;						\
> > +	cant_sleep();						\
> > +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> > +		u64 start = sched_clock();			\
> > +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> > +		this_cpu_inc(prog->aux->stats->cnt);		\
> > +		this_cpu_add(prog->aux->stats->nsecs,		\
> > +			     sched_clock() - start);		\
> > +	} else {						\
> > +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> > +	}							\
> > +	ret; })
> 
> Can we bump "cnt" unconditionally and gate only the "nsecs" calculation?

xdp cannot afford to pay this penalty unconditionally.
It's not only this_cpu_inc. It's prog->aux->stats loads.

