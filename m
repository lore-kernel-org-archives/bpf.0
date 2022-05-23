Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F76C433EF
	for <bpf@archiver.kernel.org>; Mon, 23 May 2022 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiEWQaO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 May 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiEWQaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 12:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550F68F88;
        Mon, 23 May 2022 09:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E236961468;
        Mon, 23 May 2022 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41870C34116;
        Mon, 23 May 2022 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653323411;
        bh=ugmRt4chq+TNnb9r5il2EpsiqJ9I/2uQ1hNN7mqiox4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p7fmk9ik9rmVC+TNbbxLvwBH/RqTONGenUGme5u4MlCRn63zuHctoyRP6bINUIb2y
         oVKfauZT7C7kMIAPzDD8cH3+5E85BvMYmWmfw3CLvvAAXIBNU7DysoPmaF/Gf9Qone
         TIpS1qqe5GuJTZTZRxlxeSIa8mfup/oDtgyjjoHc5JtGJtggY2P+s4cvGQ+2YY06vN
         aS/AU3M9taTGFYMLhhng82Tv+2aluWPJm8mE5pmrXA9+WrAnusi2UmE+RCRQY1Liqc
         U+58FKYed9c5mzxVerB3wu2VG8ZW4WzjPrQ4lUO6Zxy3LFS+CI2tMUp13q9FCqDnYd
         DlfTDP/pWmE1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2888CF03942;
        Mon, 23 May 2022 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: add maintainer to AF_XDP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165332341116.6335.1557221382490019130.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 16:30:11 +0000
References: <20220523083254.32285-1-magnus.karlsson@gmail.com>
In-Reply-To: <20220523083254.32285-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        maciej.fijalkowski@intel.com, davem@davemloft.net, kuba@kernel.org,
        kpsingh@kernel.org, john.fastabend@gmail.com, yhs@fb.com,
        andrii@kernel.org, songliubraving@fb.com, kafai@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 23 May 2022 10:32:54 +0200 you wrote:
> Maciej Fijalkowski has gracefully accepted to become the third
> maintainer for the AF_XDP code. Thank you Maciej!
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - [bpf-next] MAINTAINERS: add maintainer to AF_XDP
    https://git.kernel.org/bpf/bpf-next/c/a56672f2027e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


