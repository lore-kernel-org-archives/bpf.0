Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7DFECAAD3
	for <bpf@archiver.kernel.org>; Thu,  1 Sep 2022 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIAXaU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiIAXaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 19:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD50357D1
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB9962066
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 23:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC2D2C433D7;
        Thu,  1 Sep 2022 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662075015;
        bh=BhBdKEPf40hrUmq6ybY1QvzVG1Rk0aembAV03Xs3nsQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A6pSatHN0Yk1xSenJ/5qQkRgLY2y1qEd4EpF/DezGM73PDgPU3cDd33JPm6DB5WVg
         iNHX64kAOJPO5LKb1FvyJcW9Cp9Y4TKyM9x5jrfl0BkW60/gMaTIiTRVVOX8+VWgh6
         BeUsAtMVaDsXO+/PN1UFcORvK1kGWP60hs3iHA/pH57nHm0GQSPC2Dw7Uwm+/Tanv2
         qXR+2b5Q2Mcj8XVlkrJMwk46wenux+qFS1eOdsNdu9dnPRc/ykzfP4FC4kXrtZtMMf
         Loeov+BNphivILc1+dBFelqKom5+PDnvfcKLjH8NpinzGeLP31P+Spah5mj9+HlHo8
         o2Q9unFvAYpjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 950DBE924D9;
        Thu,  1 Sep 2022 23:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Only add BTF IDs for socket security hooks when
 CONFIG_SECURITY_NETWORK is on
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166207501560.18006.8246668912607990725.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 23:30:15 +0000
References: <20220901065126.3856297-1-houtao@huaweicloud.com>
In-Reply-To: <20220901065126.3856297-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, songliubraving@fb.com, haoluo@google.com,
        andrii@kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, oss@lmb.io,
        houtao1@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  1 Sep 2022 14:51:26 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When CONFIG_SECURITY_NETWORK is disabled, there will be build warnings
> from resolve_btfids:
> 
>   WARN: resolve_btfids: unresolved symbol bpf_lsm_socket_socketpair
>   ......
>   WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_conn_established
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Only add BTF IDs for socket security hooks when CONFIG_SECURITY_NETWORK is on
    https://git.kernel.org/bpf/bpf-next/c/ef331a8d4c00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


