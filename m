Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B219CCA47C
	for <bpf@archiver.kernel.org>; Sat,  2 Jul 2022 03:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGBDyv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Jul 2022 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 23:54:51 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32E2A25F;
        Fri,  1 Jul 2022 20:54:49 -0700 (PDT)
Date:   Fri, 1 Jul 2022 20:54:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656734087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rj9sMkqqP5l7HzOdKNBsrfbJnou//yinxJmwdTSmdLI=;
        b=i6uGEKsrCVuZ31qHbGeF7Ex6naGEza+250z+P+xO/uWqOaA5o5u2VjaxXjwAa3dW0VthEG
        a+O9+l3m0XteT2tZ0aMrRkmkEn4teLOM6g9DCfwrYLyWbJAq94izev0EbFrgg+3Ty/WYOV
        dt6HYVWRNkdklsaCpc0F30fU2cEAyxE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf: Make non-preallocated allocation low
 priority
Message-ID: <Yr/BgCT039IoNbR8@castle>
References: <20220629154832.56986-1-laoar.shao@gmail.com>
 <20220629154832.56986-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629154832.56986-2-laoar.shao@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 03:48:29PM +0000, Yafang Shao wrote:
> GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> if we allocate too much GFP_ATOMIC memory. For example, when we set the
> memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> easily break the memcg limit by force charge. So it is very dangerous to
> use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> too much memory.
> 
> We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> too memory expensive for some cases. That means removing __GFP_HIGH
> doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> it-avoiding issues caused by too much memory. So let's remove it.
> 
> __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> currently. But the memcg code can be improved to make
> __GFP_KSWAPD_RECLAIM work well under memcg pressure.
> 
> It also fixes a typo in the comment.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>

I agree, it makes total sense to me. Bpf allocations are not high priority
and should not be enforced both on memcg and page allocator levels.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Yafang!
