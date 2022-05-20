Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C4C433EF
	for <bpf@archiver.kernel.org>; Fri, 20 May 2022 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbiETXaP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 May 2022 19:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiETXaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:30:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DB1A6ADF
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF43CB82E8E
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 23:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2215C34113;
        Fri, 20 May 2022 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653089411;
        bh=M+KJpN3Msp9IUikeSLZDSQ07mUrziZdUMbcZF2Q3xrY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iEcYJUA5qV69pvxpgNdYKO/7EEft21EFE04H2kEinRV2MQH5JflUtcTRydtX2brxt
         coFKn5qd2BV3rL32+sket/jr8W72FL295FGQSPUCAiaNQov8UvAc0FsLY88uoSdSVx
         3kPDg8sKxGSUwrgAmi8itCvilI/+3g1QEUltFrw7ZFBqpgnH94U/Cyw+nBSdWx/Pbp
         Gbcv703vSvkm62t346WHOGksjNhrMjk6RqHJi4nGwHDO36CJBSV1ImbOZthlGH9yQM
         U+3vk43WupUR9jGsIFaD6J7eSX56wMB8nMdhmR7shRPciMnpu9C5sJPG59GWc2YIiK
         pstGvwZirZdAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9269CF0393B;
        Fri, 20 May 2022 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix subtest number formatting in
 test_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165308941159.26800.12054208580247014388.git-patchwork-notify@kernel.org>
Date:   Fri, 20 May 2022 23:30:11 +0000
References: <20220520070144.10312-1-mykolal@fb.com>
In-Reply-To: <20220520070144.10312-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 20 May 2022 00:01:44 -0700 you wrote:
> Remove weird spaces around / while preserving proper
> indentation
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix subtest number formatting in test_progs
    https://git.kernel.org/bpf/bpf-next/c/fa3768606582

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


