Return-Path: <SRS0=pAHC=C7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6668C4727E
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EF0239A1
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 10:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bvB8VbMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIVKB4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:01:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVKBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 06:01:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600768914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLO3suN0B5LIt4PxRcxRdNDdQcD9omAqbXVobcJQit0=;
        b=bvB8VbMcv76lg7v+mTn3uy5QgST4NRQnUu47qUNl8D+fm1OVsZ7ir5iOajEgMTc5mRolsx
        +JdjG1UKUAcMkTR1JPArn3y+yQ4W+XuUYFTGDk2Xl/4Whb68KND0i+avmivAL2Jgd2GPke
        OFEuWW6aD69MpOK/i3dMkpRkCKNKoZU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9B66B1AD;
        Tue, 22 Sep 2020 10:02:30 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:01:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     zangchunxin@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: Add the drop_cache interface for cgroup v2
Message-ID: <20200922100152.GW12990@dhcp22.suse.cz>
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz>
 <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz>
 <CALOAHbCDXwjN+WDSGVv+G3ho-YRRPjAAqMJBtyxeGHH6utb5ew@mail.gmail.com>
 <20200921113646.GJ12990@dhcp22.suse.cz>
 <CALOAHbCker64WEW9w4oq8=avA6oKf3-Jrn-vOOgkpqkV3g+CYA@mail.gmail.com>
 <20200922072733.GT12990@dhcp22.suse.cz>
 <CALOAHbCvRA61NbamdKSxLoy4eNqR6G_1OA=zEjb7Mu0Yh9O0sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCvRA61NbamdKSxLoy4eNqR6G_1OA=zEjb7Mu0Yh9O0sg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 22-09-20 16:06:31, Yafang Shao wrote:
> On Tue, Sep 22, 2020 at 3:27 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > What is the latency triggered by the memory reclaim? It should be mostly
> > a clean page cache right as drop_caches only drops clean pages. Or is
> > this more about [id]cache? Do you have any profiles where is the time
> > spent?
> >
> 
> Yes, we have analyzed the issues in the direct reclaim, but that is
> not the point.

Are those fixed?

> The point is that each case may take us several days to analyze, while
> the user can't wait, so they will use drop_caches to workaround it
> until we find the solution.

As I've said there are several options to achieve an immediate action.
Careful resource domains configuration will certainly help with that.
-- 
Michal Hocko
SUSE Labs
