Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBCC00140
	for <bpf@archiver.kernel.org>; Mon,  8 Aug 2022 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiHHQAT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiHHQAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 12:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F585C44
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 09:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4126B80E24
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 843DEC433D7;
        Mon,  8 Aug 2022 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659974414;
        bh=X9q44N7Un9T4eBygc8JgvL75dG4RfgnsHuK5697+I7M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ta4RoEPFKKglACjuunOso9IH67SWxmQ6pcGpMqJMAMALHvk4Od8pEK5mn+U0X0fo5
         JVVv9szoQ1D6KlsiznefBqVeOBlwFzJiV9qXiqti5BfCZq8eid39JhPA0hhcd2w+0K
         8ywHP58yPDIcbie9Wi/701MuvfHU3NM6tYqpnnY+V2FrAs7Eb34L6hEv3INSUoqWKj
         XfqYcQLLah0z6MSEP/r0ZQ+AuS9eJ6bUEz0e7wNbKlbTdPiW9pD6tXrWhkIGCDAI7L
         8jHP+LT7qQiPvkm86fpYuSu/VqRgmEOzTvB962wLcdVFWKRL6NV0QUE6Gzz7p+sIct
         J5JuISaUBplJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AAD6C43142;
        Mon,  8 Aug 2022 16:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: verifier cleanups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165997441443.32093.4867734298996596066.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 16:00:14 +0000
References: <20220802214638.3643235-1-joannelkoong@gmail.com>
In-Reply-To: <20220802214638.3643235-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Aug 2022 14:46:38 -0700 you wrote:
> This patch cleans up a few things in the verifier:
>   * type_is_pkt_pointer():
>     Future work (skb + xdp dynptrs [0]) will be using the reg type
>     PTR_TO_PACKET | PTR_MAYBE_NULL. type_is_pkt_pointer() should return
>     true for any type whose base type is PTR_TO_PACKET, regardless of
>     flags attached to it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: verifier cleanups
    https://git.kernel.org/bpf/bpf-next/c/0c9a7a7e2049

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


