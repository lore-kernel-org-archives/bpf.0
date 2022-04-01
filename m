Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0BC433FE
	for <bpf@archiver.kernel.org>; Fri,  1 Apr 2022 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbiDAUwH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352104AbiDAUwG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 16:52:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF121C34B2;
        Fri,  1 Apr 2022 13:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 928B9B8264F;
        Fri,  1 Apr 2022 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 220DEC34112;
        Fri,  1 Apr 2022 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648846212;
        bh=IFviFmEmeG4O5cbe1aeGTceSmqBuYHgVcRN64yHS5M8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CvhX+mPWzCLUfeJozH+/V7eggeSJ3R8GdhBHwZ+Nq7bT3SjRysNGPLIemzeBhueDj
         bddLmsxpTBUMVeJYFCdYgbHftHyIOPylAg9FRcOd7mC2koI+ZL7TulaU+OfU/mTxhT
         3OgMcHuGrH8kWuYRwfcioa7Sjy55G5STax/FzfG3oCXvX7vI+eC3DJK5m+sLgp7exz
         A5p8qYG8O75XsxwnEy44B98db/w785IYMvYAh/iqE6vI+TEQaIwSuRpVSvK9yjkuIH
         OI3oRxldKOVHnKPlHFbsai2ADW66l3SKHdFlXHm/2aioUfH65UTMAgJFEx1n0OtaGm
         9/aY8jkTZuudA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2969E6BBCA;
        Fri,  1 Apr 2022 20:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove redundant assignment to
 smap->map.value_size
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164884621198.13250.13629878570066035972.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Apr 2022 20:50:11 +0000
References: <20220323073626.958652-1-ytcoode@gmail.com>
In-Reply-To: <20220323073626.958652-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Mar 2022 15:36:26 +0800 you wrote:
> The attr->value_size is already assigned to smap->map.value_size
> in bpf_map_init_from_attr(), there is no need to do it again in
> stack_map_alloc()
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/bpf/stackmap.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: Remove redundant assignment to smap->map.value_size
    https://git.kernel.org/bpf/bpf-next/c/8eb943fc5e5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


