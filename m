Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030FC43217
	for <bpf@archiver.kernel.org>; Fri, 18 Nov 2022 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKRWa0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiKRWaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 17:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13717EC9E;
        Fri, 18 Nov 2022 14:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77E0DB8255F;
        Fri, 18 Nov 2022 22:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B332C433C1;
        Fri, 18 Nov 2022 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810617;
        bh=fSARivKSHlBF6ylue5+/lo+e6lFrJaESzm2fTUt/EYM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ne9UgG7dEBMuQsjZ0XXeRSa42dLoLFpvhYkEfeYfeoYtXCsMFafvSB/og8Lh/hpnD
         65Bszi7gSJcUdiDnkVokYw0oI9MB/+0G0cTrarvm3K4NlPPh7FahJzRAKUEKRcNHha
         tbrm38B7+ydvOQkHBvk3n1Ckv/aC9qtkfuYqEeFeNhDEmC9rS1YTdgo/rPlGMjXIgS
         Mo1JeQYu+OgDve3iURT+FPFNA9eOWPDOelFADiD8OCA8r5oPsi0G4v0Q8zR4Lexv8T
         +G4eGP5X45IMANosJxvawPkoeNrEVr6sS1YBvrOtpm3b37aJ/ZX86SBU+5LNaqSD2y
         wr5LrKya9zaVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D04EE29F43;
        Fri, 18 Nov 2022 22:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 1/1] doc: DEVMAPs and XDP_REDIRECT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166881061704.15254.17480384882519639878.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 22:30:17 +0000
References: <20221115144921.165483-1-mtahhan@redhat.com>
In-Reply-To: <20221115144921.165483-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, bagasdotme@gmail.com,
        toke@redhat.com, yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 15 Nov 2022 09:49:21 -0500 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
> 
> Add documentation that describes XDP_REDIRECT.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/1] doc: DEVMAPs and XDP_REDIRECT
    https://git.kernel.org/bpf/bpf-next/c/d1e91173cd29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


