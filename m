Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8699C636D3
	for <bpf@archiver.kernel.org>; Tue,  7 Feb 2023 22:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBGWU3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBGWU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 17:20:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4B36FD8;
        Tue,  7 Feb 2023 14:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7601B81B30;
        Tue,  7 Feb 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E4A6C4339C;
        Tue,  7 Feb 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675808417;
        bh=jLesaEC7U5NIm4cvpdmMha8J4yWV+yh6rVfEHVomlK8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VpZcMpGWn9KFcI5wZ0OLSenWMoV8WKmWMFWR3kVl0dP7ECs3scflpP8nsIMcQ+c++
         UiYcxh84MBzn6i3aCwGvN1oSxbkn67l6u42afpE3IIb0B7neuArUg2tm6YTDEB3QXW
         nCkOnCJtL9PeOTrX6dxTt/JgW3p7Y0YzAmX/X6MaEQ2Yfe+pignoSAOtwtkW5MqqHP
         lF/DheydUPcMuQViOqhGdXXdfswYfVX9wMo5K0/j1i516oguX2vH74MKMaeTttk0gw
         hzSJX/9hxdhbGzWiwDUeayrfKLhpFELwApEY27mCImDtp1NrMfbfE3wHYkhuyoK4To
         w+GNPW/JFBeAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71B5DE55F07;
        Tue,  7 Feb 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] virtio_net: update xdp_features with xdp multi-buff
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167580841746.25365.8274725624997051578.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Feb 2023 22:20:17 +0000
References: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
In-Reply-To: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        lorenzo.bianconi@redhat.com, mst@redhat.com, jasowang@redhat.com,
        hawk@kernel.org, john.fastabend@gmail.com,
        virtualization@lists.linux-foundation.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  7 Feb 2023 10:53:40 +0100 you wrote:
> Now virtio-net supports xdp multi-buffer so add it to xdp_features
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] virtio_net: update xdp_features with xdp multi-buff
    https://git.kernel.org/bpf/bpf-next/c/30bbf891f1b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


