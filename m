Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27498C433E0
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 23:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8920239D4
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 23:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbhAVXax (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbhAVXav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 18:30:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 976A523A3A;
        Fri, 22 Jan 2021 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611358209;
        bh=tXZGZHf5vtWuvhsVs/7oA87OuFC/E+rqKGccMjWHu9I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a+CyHYAuUc3ZpjJSmRbxg0uCQkNDM3F/91kYe1NT87kRUGXysrNxL0JYjkdiei+Lh
         NW9UqAz4iRMALznnoKbojyZVwKr9P2TJLEsyjW6vK/l759y/JrueazAu9T+2CLLdB4
         aOUn/y2YnpM6+7OIeTz//awJoakq9c0YcIWfb2FXh0NVsPrvruj/zFlWuuFWp/doDB
         BFHLOVKXYVKghW5QPaEEjZ8NrWFsQmQ8bVrs3v05CI0Sug7R43+LbDqItWCqMLTX2+
         hDWgCbiraUzzuAW5cTKXttSFh6AvNzZjSOHeMSv9lmcTtE5Ti1KQNXapX/6xu3lx1I
         x94M6T2cpd4yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv10 bpf-next] samples/bpf: add xdp program on egress for
 xdp_redirect_map
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161135820955.8788.2073072556982929124.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jan 2021 23:30:09 +0000
References: <20210122025007.2968381-1-liuhangbin@gmail.com>
In-Reply-To: <20210122025007.2968381-1-liuhangbin@gmail.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        brouer@redhat.com, john.fastabend@gmail.com, yhs@fb.com,
        toke@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 22 Jan 2021 10:50:07 +0800 you wrote:
> This patch add a xdp program on egress to show that we can modify
> the packet on egress. In this sample we will set the pkt's src
> mac to egress's mac address. The xdp_prog will be attached when
> -X option supplied.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv10,bpf-next] samples/bpf: add xdp program on egress for xdp_redirect_map
    https://git.kernel.org/bpf/bpf-next/c/6e66fbb10597

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


