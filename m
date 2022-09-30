Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50271C433FE
	for <bpf@archiver.kernel.org>; Fri, 30 Sep 2022 22:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiI3WuU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiI3WuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43818E0073;
        Fri, 30 Sep 2022 15:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBC0623C1;
        Fri, 30 Sep 2022 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4EE4C433D7;
        Fri, 30 Sep 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664578215;
        bh=S1Nfm1SuWz0ZMY9Q/MbRTaTgbwFvqK1pQY8qW4oPp1I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LJwKkmtceu4SNZr4V2rdO0VLHIB/S7sPkfYHcul+XL5zFUFL2esMhJK0WtohkuI9f
         /OriHgVf7N2jK3GZA/8NpTfnKCEv/HsEN+uW6JbdPgHJIf/bntp68pwbnmsFXbT6ck
         v+XeLUsq2D0FDukHAQRDKV4uFzMkFt4N6aIg0nLxPd22Ok8mImNH/xRdvppWrKoiw1
         6gmgbPoKsicabgcfmdnaN1MVZEN9x17B4yoTOkNiLIHxGfsGfHfhjcJVQ3UzpXHCFB
         5iFwIwAmTMzjVlL2IAnQ+LjiDLZass1XGxX2Lxzv+kXQh34S2GF4MNTB9RomXo4thB
         D024DkvRiMfSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB224E49FA5;
        Fri, 30 Sep 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/xsk: fix double free
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457821574.20099.16151789150062540312.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 22:50:15 +0000
References: <20220929090133.7869-1-magnus.karlsson@gmail.com>
In-Reply-To: <20220929090133.7869-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 29 Sep 2022 11:01:33 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a double free at exit of the test suite.
> 
> Fixes: a693ff3ed561 ("selftests/xsk: Add support for executing tests on physical device")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/xsk: fix double free
    https://git.kernel.org/bpf/bpf-next/c/5f388bba7acb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


