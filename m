Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3676C05027
	for <bpf@archiver.kernel.org>; Wed,  8 Feb 2023 21:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBHVCj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjBHVCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 16:02:31 -0500
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 13:01:59 PST
Received: from out-167.mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244686182
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 13:01:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:54:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675889672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hTM8UpF2EtjSujDo7i2tE9vOByipsbn/8EnqcT62yo=;
        b=Ry7eN87/TYrSA13FkeYWI7VOPAtMOfzHdTJfFZ2b7Nedf1QTqlEvqusjNketL0GRiON+HV
        ugDGe5+DwAr+yGSsSKxqPie6MJi6wD1IHSQk5YA8hIFUvfJD64qNjT2qxHL4INA59UHKzG
        2FCaSYoG/O+/qRhiEw1+8qk5f4hQ6Ks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH bpf-next 0/5] bpf, mm: introduce cgroup.memory=nobpf
Message-ID: <Y+QL8s1VEHlolXM3@P9FQF9L96D.corp.robot.car>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205065805.19598-1-laoar.shao@gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 05, 2023 at 06:58:00AM +0000, Yafang Shao wrote:
> The bpf memory accouting has some known problems in contianer
> environment,
> 
> - The container memory usage is not consistent if there's pinned bpf
>   program
>   After the container restart, the leftover bpf programs won't account
>   to the new generation, so the memory usage of the container is not
>   consistent. This issue can be resolved by introducing selectable
>   memcg, but we don't have an agreement on the solution yet. See also
>   the discussions at https://lwn.net/Articles/905150/ .
> 
> - The leftover non-preallocated bpf map can't be limited
>   The leftover bpf map will be reparented, and thus it will be limited by 
>   the parent, rather than the container itself. Furthermore, if the
>   parent is destroyed, it be will limited by its parent's parent, and so
>   on. It can also be resolved by introducing selectable memcg.
> 
> - The memory dynamically allocated in bpf prog is charged into root memcg
>   only
>   Nowdays the bpf prog can dynamically allocate memory, for example via
>   bpf_obj_new(), but it only allocate from the global bpf_mem_alloc
>   pool, so it will charge into root memcg only. That needs to be
>   addressed by a new proposal.
> 
> So let's give the user an option to disable bpf memory accouting.
> 
> The idea of "cgroup.memory=nobpf" is originally by Tejun[1].
> 
> [1]. https://lwn.net/ml/linux-mm/YxjOawzlgE458ezL@slm.duckdns.org/
> 
> Yafang Shao (5):
>   mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
>   bpf: use bpf_map_kvcalloc in bpf_local_storage
>   bpf: introduce bpf_memcg_flags()
>   bpf: allow to disable bpf map memory accounting
>   bpf: allow to disable bpf prog memory accounting

Hello Yafang!

Overall the patch looks good to me, please, feel free to add
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

I'd squash patch (3) into (4), but up to you.

Thanks!
