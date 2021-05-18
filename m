Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A7C433ED
	for <bpf@archiver.kernel.org>; Tue, 18 May 2021 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58C961285
	for <bpf@archiver.kernel.org>; Tue, 18 May 2021 14:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhEROv3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 May 2021 10:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237229AbhEROv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 10:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 52950610A8;
        Tue, 18 May 2021 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621349410;
        bh=Vfc2H+NipCXnxS2qG7P9SY2apIRJ2FjUB4cV8zanNdc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZqqzsaAbpZR8KcuIm3fyhOipG420cOFXPUJsuhOUJ4kb/laRK/J4FQ9eEKf9RljH+
         YZiQw5sQwyZZ52f+qOWMfqB3aOw6A27Lv8hLYRHpB5BzJfpdaWACeHYF5Is1LYWIhc
         Fc7RH9vGKoCJXk0Y7XfmYWi6VUOyxgQiRaQtGj8hpz3/CgybQM1BjA6KEK0SfpLxuT
         SZpD9C2LFXdxyjnT/IGDPld09XMTTCksoGptZGS4IzuETmZKEw7rpRba+Go3Gf/Vni
         HW8hlBQNCZM5mIXY6licoAJIzDN6kWzfDVt6aunWEijk2jZIf3KrlitQ93sO4G41uI
         2ZZlGe9hsjdRQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch bpf] skmsg: remove unused parameters of sk_msg_wait_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162134941026.29155.11173485735182070075.git-patchwork-notify@kernel.org>
Date:   Tue, 18 May 2021 14:50:10 +0000
References: <20210517022348.50555-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20210517022348.50555-1-xiyou.wangcong@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        cong.wang@bytedance.com, john.fastabend@gmail.com,
        daniel@iogearbox.net, jakub@cloudflare.com, lmb@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 16 May 2021 19:23:48 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> 'err' and 'flags' are not used, we can just get rid of them.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> [...]

Here is the summary with links:
  - [bpf] skmsg: remove unused parameters of sk_msg_wait_data()
    https://git.kernel.org/bpf/bpf-next/c/c49661aa6f70

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


