Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70BC433DB
	for <bpf@archiver.kernel.org>; Tue, 30 Mar 2021 00:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA28161935
	for <bpf@archiver.kernel.org>; Tue, 30 Mar 2021 00:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhC3Aah (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC3AaL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 20:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0612161987;
        Tue, 30 Mar 2021 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617064209;
        bh=qPsUwsxkHrWhgxeyPJd4F3z2LHyi86XM2kE6x0RHwjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oZs8PZRuZ7/U+zqMS0GqUQXoWjuMrPdHCcEaEfIYI7rKJ04C9+700ZJq1yOwJLVtz
         HlyaGMoQuYWrUkAlNAUqnknNpT2O6a8zgMFAIG7adrAi9WmkZMwMXs7l3LGpL3Ao7t
         WW8AoSQsQyMeiTNnxQwEhekzqrppFFioyZTF43xbW9RTIBrWnnrfFRKuOo/0L0f7iL
         MNl06ppTQIUuH+86Vs8ErWD+SitH7zfdl+GQCcESTEPA0hBX1hBQqE4hjZLJcY9xcq
         +yPPuoFrbvePzHHdMs+bxGIrWbvLdzD9W2TKrGz/wMxhROce+HANtV3BJdKpyeub88
         7As8BmhtqWaTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet/netronome/nfp: Fix a use after free in
 nfp_bpf_ctrl_msg_rx
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161706420894.10022.11354117385100184224.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Mar 2021 00:30:08 +0000
References: <20210329115002.8557-1-lyl2019@mail.ustc.edu.cn>
In-Reply-To: <20210329115002.8557-1-lyl2019@mail.ustc.edu.cn>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     kuba@kernel.org, simon.horman@netronome.com, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 29 Mar 2021 04:50:02 -0700 you wrote:
> In nfp_bpf_ctrl_msg_rx, if
> nfp_ccm_get_type(skb) == NFP_CCM_TYPE_BPF_BPF_EVENT is true, the skb
> will be freed. But the skb is still used by nfp_ccm_rx(&bpf->ccm, skb).
> 
> My patch adds a return when the skb was freed.
> 
> Fixes: bcf0cafab44fd ("nfp: split out common control message handling code")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> 
> [...]

Here is the summary with links:
  - ethernet/netronome/nfp: Fix a use after free in nfp_bpf_ctrl_msg_rx
    https://git.kernel.org/netdev/net/c/6e5a03bcba44

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


