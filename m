Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B493CC433FE
	for <bpf@archiver.kernel.org>; Thu, 24 Nov 2022 00:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKXAvx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiKXAv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:51:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE2C7682
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED1561F90
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 00:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 895B3C43470;
        Thu, 24 Nov 2022 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669251015;
        bh=5KSI5yupV7GKyJ/EYR2feRUftN+xbpV3OFSPylV5xaU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UOnmcl4MeBMaskb6dd1BYeHPqxZzx107K3OPWap49goP20fj+mneqF+J2FIrLuWN5
         MZz2wPib/3Kb6FqMsStFzmY4jccFfFHRrE9x83Kz3u6xJcrtkD1BO3Y3zR1y4JtKFh
         ra0ORmHIqTYA0VHhR3Ed+kSnsTXT59o1Hcb8f5+Ndc3kaNlJnj3kbKzp3UDq9NkkDi
         FOOz3YpMAS2E+otT+stP0XiYrS9Wv3ta9SOeIqbInmx+Ve7XvGkRlrGhMXmXr4gz7d
         6ffuOdBXJp3bpjl7enhQv8m6IihmP0MAyDO429hCBlGmfPWXSWjEhqZd3mhtxJhcYx
         4Jcrm5IaIRoKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A129C395EE;
        Thu, 24 Nov 2022 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Unify and simplify btf_func_proto_check error
 handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166925101543.15445.1369934958197078804.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 00:50:15 +0000
References: <20221124002838.2700179-1-sdf@google.com>
In-Reply-To: <20221124002838.2700179-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Nov 2022 16:28:38 -0800 you wrote:
> Replace 'err = x; break;' with 'return x;'.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/btf.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Unify and simplify btf_func_proto_check error handling
    https://git.kernel.org/bpf/bpf-next/c/5bad3587b7a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


