Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1CCCA473
	for <bpf@archiver.kernel.org>; Sun,  3 Jul 2022 22:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGCWvJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 3 Jul 2022 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGCWvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 18:51:08 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4BE389A;
        Sun,  3 Jul 2022 15:51:07 -0700 (PDT)
Date:   Sun, 3 Jul 2022 15:50:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656888664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1aMEnERkcYXRuDziS0Zc8C87mC49RuzSVJcPFqy0W4=;
        b=NdeXq3Q0aH+DxBKSCS1GbadzG/ojBzsDFkJu1dEehs/A4VIcHKeDcfyrAAnIt+xW787Q2Y
        llJrgKxTG0lCaWhR1V20IxPimKLEoF19Q8mA27pxNl262HKIDQydxfIJM2PNiE+uDGrGfC
        m9H4YfvK0CIGGgqwrCL8m/lvsv4A7zw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsIdU0xJeQWR2DwL@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <CALvZod6zCHKyjd8Ewr02xcHRWrxR_82my6mmTgsRp3HceqsBcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6zCHKyjd8Ewr02xcHRWrxR_82my6mmTgsRp3HceqsBcg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 02, 2022 at 10:36:28PM -0700, Shakeel Butt wrote:
> On Sat, Jul 2, 2022 at 8:39 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > events are not raised.
> > > >
> > > > It's not/less of an issue in a generic case because consequent
> > > > allocations from a process context will trigger the reclaim and
> > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > memory cgroup, so it might never happen.
> > >
> > > The patch looks good but the above sentence is confusing. What might
> > > never happen? Reclaim or MAX event on dying memcg?
> >
> > Direct reclaim and MAX events. I agree it might be not clear without
> > looking into the code. How about something like this?
> >
> > "It's not/less of an issue in a generic case because consequent
> > allocations from a process context will trigger the direct reclaim
> > and MEMCG_MAX events will be raised. However a bpf map can belong
> > to a dying/abandoned memory cgroup, so there will be no allocations
> > from a process context and no MEMCG_MAX events will be triggered."
> >
> 
> SGTM and you can add:
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thank you!
