Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1893AC433E9
	for <bpf@archiver.kernel.org>; Tue, 29 Dec 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60DE21D1B
	for <bpf@archiver.kernel.org>; Tue, 29 Dec 2020 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2Pkr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Dec 2020 10:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2Pkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Dec 2020 10:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 84B8D21D1B;
        Tue, 29 Dec 2020 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609256406;
        bh=phw2a8MM503wzDIqg05w+Xs3aYq/xcdl1tKvEE4iM2A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RgTf/7Sp+ADJay9/TTIuQMgyrhRP2zJTsBdSCbrQSAudrfdamiEK1VTQacPlZI63V
         5ZIPzOaLh20Hb9R2MGx3Z+3hlcjx72pWUDZZxWl2yD3FADkZNU/ZQGhdB7+QCdPXoo
         CdNGSM7mMJ5O5UYvEppxnSfdnL5CGxnHF24luHESjaSiD32H64sDSCOy2/LbMu/9UU
         bgEO2A0jRkjP58UhNETXFyf+msVTFQ0eWSzJCXYcCwN7bXaDAm1zOkobaOJW7pGCRE
         bjcXE0tDTVtp5YKZakEa+gPwfkRWYgPKulIpBjvhT5LT/p4qrA+GhU0yzs4KbTS8N3
         yc95l8yKlgigA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: core: Replace fput with sockfd_put
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160925640648.5575.958503304666157507.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Dec 2020 15:40:06 +0000
References: <20201229134834.22962-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201229134834.22962-1-zhengyongjun3@huawei.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     john.fastabend@gmail.com, daniel@iogearbox.net,
        jakub@cloudflare.com, lmb@cloudflare.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Dec 2020 21:48:34 +0800 you wrote:
> The function sockfd_lookup uses fget on the value that is stored in
> the file field of the returned structure, so fput should ultimately be
> applied to this value.  This can be done directly, but it seems better
> to use the specific macro sockfd_put, which does the same thing.
> 
> The problem was fixed using the following semantic patch.
>     (http://www.emn.fr/x-info/coccinelle/)
> 
> [...]

Here is the summary with links:
  - [net-next] net: core: Replace fput with sockfd_put
    https://git.kernel.org/bpf/bpf-next/c/f734031bb4c7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


