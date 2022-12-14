Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BEC4332F
	for <bpf@archiver.kernel.org>; Wed, 14 Dec 2022 20:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLNUcN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLNUbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 15:31:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFD49B45
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 12:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40468B81A2A
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFCD9C43396;
        Wed, 14 Dec 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671049215;
        bh=WFDkqM33DkBH4cS9HPY8dgusjuWTu/hJZ6WnjFB7fkA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DggwOjVMdbKE8mAV8/QiYqdBKWIwJq5ZGOhHwn7EAIWsMcL32IvH6V6DNLJAq6rUx
         ywvUwgfdoR+BdGvxryVbfqETppNBV1CGw9CQ5ru1dFac50/8oLk28jQiwR2EcokaXf
         elOFXQLpQenx8T2XHwlfTM7RgtX3J6UnIicrQQMiDJ2LCnnW/xJ2uNOv6Srfkz6Rg2
         /B+gQH9LKyiqYv15sjfOxUNodDBflmF5umBlodWNJ7gs1/ACTlrNpcm42dSJSfCX0T
         krE80aT0zqzdt0xvWIocuJUP+4N5az9jKlXniD5P7U8u3GuQM0gdcPTSqie1J9qEID
         T42YdMRcReNFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3468E29F4D;
        Wed, 14 Dec 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Synchronize dispatcher update with
 bpf_dispatcher_xdp_func
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167104921573.24735.12743388812676342828.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Dec 2022 20:20:15 +0000
References: <20221214123542.1389719-1-jolsa@kernel.org>
In-Reply-To: <20221214123542.1389719-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        sunhao.th@gmail.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        paulmck@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 14 Dec 2022 13:35:42 +0100 you wrote:
> Hao Sun reported crash in dispatcher image [1].
> 
> Currently we don't have any sync between bpf_dispatcher_update and
> bpf_dispatcher_xdp_func, so following race is possible:
> 
>  cpu 0:                               cpu 1:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Synchronize dispatcher update with bpf_dispatcher_xdp_func
    https://git.kernel.org/bpf/bpf/c/4121d4481b72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


