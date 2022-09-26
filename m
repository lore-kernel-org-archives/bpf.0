Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9215C07E9D
	for <bpf@archiver.kernel.org>; Mon, 26 Sep 2022 17:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiIZRAj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIZQ7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E204E52084
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 09:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0DC60F76
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 16:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC7C0C433D6;
        Mon, 26 Sep 2022 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664208015;
        bh=TP5QaX58+t2f8qdTAr1xg5gT7RwUFgUsBtn3Vv67H64=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P7YsLIRFDwIwUfe/ZSBFdujWCJkMhybypcosthpTO/C4WuPvG2NiLYh87GcP1EzpD
         r9NMAwn5oZeQFVcB1Nvjn8NrbsDsXa5FayKwBq6PmwKshL6s+7ERR9Qgsqye9fQ6pI
         CUYc1SDq+cxwlmp9ql4105/JahY+HfPmZehrluXKyshPkO70mUu5WTtDTNniFRM4nU
         ETRaD1h3DZpvNssT6CkGSMtF4gj47s8Ir2XEfMjtnzHhHxs1MY+IiVSVK4QloSTwAC
         zpR5kxkJwnWvzbOztvcDaNrBoQKHkT7xVjqOOtDkvHXw6OFB8u+kjYMuEaZGzXVT+8
         O0cKiepwaN7UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C32DDC070C8;
        Mon, 26 Sep 2022 16:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] If the sock is dead,
 do not access sock's sk_wq in sk_stream_wait_memory
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166420801579.16435.17356318802759700685.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Sep 2022 16:00:15 +0000
References: <20220823133755.314697-1-liujian56@huawei.com>
In-Reply-To: <20220823133755.314697-1-liujian56@huawei.com>
To:     Liu Jian <liujian56@huawei.com>
Cc:     john.fastabend@gmail.com, jakub@cloudflare.com,
        edumazet@google.com, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 23 Aug 2022 21:37:53 +0800 you wrote:
> If the sock is dead, do not access sock's sk_wq in sk_stream_wait_memory
> 
> v1->v2:
>   As Jakub's suggested, check sock's DEAD flag before accessing
>   the wait queue.
> 
> Liu Jian (2):
>   net: If the sock is dead, do not access sock's sk_wq in
>     sk_stream_wait_memory
>   selftests/bpf: Add wait send memory test for sockmap redirect
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] net: If the sock is dead, do not access sock's sk_wq in sk_stream_wait_memory
    https://git.kernel.org/bpf/bpf-next/c/3f8ef65af927
  - [bpf-next,v2,2/2] selftests/bpf: Add wait send memory test for sockmap redirect
    https://git.kernel.org/bpf/bpf-next/c/043a7356dbd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


