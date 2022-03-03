Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D9DC433EF
	for <bpf@archiver.kernel.org>; Thu,  3 Mar 2022 06:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiCCGLB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiCCGK7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 01:10:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBCA165C2E;
        Wed,  2 Mar 2022 22:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AC96184A;
        Thu,  3 Mar 2022 06:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 148D6C340F1;
        Thu,  3 Mar 2022 06:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646287813;
        bh=TU7DuLmOUOXBIjeGYJd3zB0+Q4BLMX5PtrBjAzuK8Mo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iNynvhI4uNhPWhh2pPT7f0HtuhnBRH+MJALrvOl1BspEsqnAB0AgJW5MPnQM+FBAV
         seUGQWk7qRwF1o/5aSbjwTAV5bt1KnUKJwfZAy96UwHGi8CzJnn+eCyPX5VALtsPQy
         ibGPWVUP2hsKk2WqAyXhVx/o99k+30ilZ7vZYO9JtsxJszIj3evCJi/Wlxaqokgfwv
         0bOLoPgx0ZyQJ+OujqQDMARLyD9zYZIk5cB14dOFQcopACcGggStlKHDv6BdR/fNC+
         uBDKuseskgf60ByoKhMbZdGdXwI/GvbV58p/wj1WjB6AxBzBj+ccOWtZj2Zx+mPNby
         T3S4ZActdfIZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB8D2EAC09D;
        Thu,  3 Mar 2022 06:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tuntap: add sanity checks about msg_controllen in
 sendmsg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164628781296.31171.2633658939059325470.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Mar 2022 06:10:12 +0000
References: <20220303022441.383865-1-baymaxhuang@gmail.com>
In-Reply-To: <20220303022441.383865-1-baymaxhuang@gmail.com>
To:     Harold Huang <baymaxhuang@gmail.com>
Cc:     netdev@vger.kernel.org, jasowang@redhat.com, edumazet@google.com,
        eric.dumazet@gmail.com, davem@davemloft.net, kuba@kernel.org,
        mst@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Mar 2022 10:24:40 +0800 you wrote:
> In patch [1], tun_msg_ctl was added to allow pass batched xdp buffers to
> tun_sendmsg. Although we donot use msg_controllen in this path, we should
> check msg_controllen to make sure the caller pass a valid msg_ctl.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe8dd45bb7556246c6b76277b1ba4296c91c2505
> 
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Harold Huang <baymaxhuang@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tuntap: add sanity checks about msg_controllen in sendmsg
    https://git.kernel.org/netdev/net-next/c/74a335a07a17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


