Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC6C3DA6B
	for <bpf@archiver.kernel.org>; Wed, 31 Aug 2022 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHaTAi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiHaTAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 15:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E34B493;
        Wed, 31 Aug 2022 12:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66C90611F6;
        Wed, 31 Aug 2022 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B04BCC433B5;
        Wed, 31 Aug 2022 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661972416;
        bh=MvhRuP3zlkbGUdubRiIusjnGG4E7nIIMzKZytkqpbyc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b+mBGYDoGgqmZQx/Vt0p0gqZzk+HHErUuaGzPs75Q3vvS94IRAG0CG/K/vrFBjK1I
         c2PRE6kCsbBTyh2kcZrIs6NKoUQjqtxKi0htaSOEcYQJOtlgZMy3dL5MB39saqaHdA
         9Pa/v8TMal8WDQfxEezZv4Dmddh135CBV3JUvpM4WMkCTQ3OUghyt7GPtJHTWFCq2g
         UC+njYniQE43uew7Y6xw3GF6aNpoMc4Z1ghmMQGTmpzXs1EeKpVAoahvKqhMzN5kUL
         oaxwzGJaYFP8BNwAwcS0Lnp/c00WkDVwPUM6qS/0Ta3FNpTHsp0uxuYz0/dgnKNgUq
         HGIHHzpiZ4Eiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 912F5C4166F;
        Wed, 31 Aug 2022 19:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests: xsk: add missing close() on netns fd
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166197241659.25924.3620860642967353215.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 19:00:16 +0000
References: <20220830133905.9945-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20220830133905.9945-1-maciej.fijalkowski@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, netdev@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Aug 2022 15:39:05 +0200 you wrote:
> Commit 1034b03e54ac ("selftests: xsk: Simplify cleanup of ifobjects")
> removed close on netns fd, which is not correct, so let us restore it.
> 
> Fixes: 1034b03e54ac ("selftests: xsk: Simplify cleanup of ifobjects")
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> [...]

Here is the summary with links:
  - [bpf] selftests: xsk: add missing close() on netns fd
    https://git.kernel.org/bpf/bpf/c/8a7d61bdc2fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


