Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2455C77B73
	for <bpf@archiver.kernel.org>; Thu, 27 Apr 2023 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjD0V2N (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0V2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 17:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF571FFF;
        Thu, 27 Apr 2023 14:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0AD763FBD;
        Thu, 27 Apr 2023 21:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03CFFC4339C;
        Thu, 27 Apr 2023 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682630891;
        bh=8WI+7EOcX2d0SVV6EJEuUBbQgOypIi3QMvE0tZ8Cj1I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZuzcxyT9WGuBl4E6EtC+OqWLy3/jioD5rp43lfhF7bu+nuAGu/MuqFZD19ewuYL5E
         fUfQz/0bZpGb94j0Izn2LFatX0gzx8x7GTc5BLUbZkGA5MXnKWSUY2RlpmKRr3diBt
         Msw+qRtw4VDdNPcO3kmeIGskUaaJEpqMiDKgAcFLakymT2TSgrQjqgWIEsXwdTCA9T
         ITR0FRlDLPYMrF6Dn9sZWYp2dxQPMO9c1HGdnajDykNdh/t1AGGlZiBjzW7myGphnc
         FPTsY358N+TRwAN8zVEJz7Y+NFtLqhcpSukAtX1G5OtslHCRBOeqqMZ0h/p9ZBz3R3
         c0qIPzeufX9nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA117C39562;
        Thu, 27 Apr 2023 21:28:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: Dump map id instead of value for
 map_of_maps types
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168263089088.27970.1243892055183614377.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Apr 2023 21:28:10 +0000
References: <20230427120313.43574-1-kuro@kuroa.me>
In-Reply-To: <20230427120313.43574-1-kuro@kuroa.me>
To:     Xueming Feng <kuro@kuroa.me>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 27 Apr 2023 20:03:13 +0800 you wrote:
> When using `bpftool map dump` with map_of_maps, it is usually
> more convenient to show the inner map id instead of raw value.
> 
> We are changing the plain print behavior to show inner_map_id
> instead of hex value, this would help with quick look up of
> inner map with `bpftool map dump id <inner_map_id>`.
> To avoid disrupting scripted behavior, we will add a new
> `inner_map_id` field to json output instead of replacing value.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: Dump map id instead of value for map_of_maps types
    https://git.kernel.org/bpf/bpf-next/c/bf06c9393493

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


