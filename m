Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74638C433EF
	for <bpf@archiver.kernel.org>; Fri, 11 Feb 2022 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbiBKVaP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:30:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353650AbiBKVaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:30:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC3C61
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE6EB82CF9
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CFB6C340ED;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644615010;
        bh=Ph4DfRGPigMqDXpL3aN36p5tkUf9hR75wiHF2ZsoVPc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fso31rbIReVoczMaH7Lx+Lqv8ybMX2SzSm1/yDfadjPxOn71BelDLzjFGgp+izUE/
         hFIlMy1zMtVoLLTox8jr7RoRt8952bMatwihFpA7hpqmUst6AvEL4NqPVLzg2kaLLf
         7EHJyw7f7C7tPa5MbniN6Z7dJ3dHxYX4iw1236Owb/a9efl/LrE7+7oSN8Va4B/S3i
         O4ne9D/3oKHJkU+itEfKjTdy0gQw/4xkA24JXxwey3XmTLAg5v+D2wLEMGLfGBb2Y3
         H+okiIgsXADjQDuJVuAj/J6jKruyq7KHyb2gVF5LBxVEAwHhzyExNzfkx+KchRn9Qb
         422CuTqVKZWeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 559C9E6BB38;
        Fri, 11 Feb 2022 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fix for crash due to overwrite in copy_map_value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164461501034.10199.16749469053019311648.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 21:30:10 +0000
References: <20220209070324.1093182-1-memxor@gmail.com>
In-Reply-To: <20220209070324.1093182-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  9 Feb 2022 12:33:22 +0530 you wrote:
> A fix for an oversight in copy_map_value that leads to kernel crash.
> 
> Also, a question for BPF developers:
> It seems in arraymap.c, we always do check_and_free_timer_in_array after we do
> copy_map_value in map_update_elem callback, but the same is not done for
> hashtab.c. Is there a specific reason for this difference in behavior, or did I
> miss that it happens for hashtab.c as well?
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix crash due to incorrect copy_map_value
    https://git.kernel.org/bpf/bpf/c/a8abb0c3dc1e
  - [bpf,v2,2/2] selftests/bpf: Add test for bpf_timer overwriting crash
    https://git.kernel.org/bpf/bpf/c/a7e75016a075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


