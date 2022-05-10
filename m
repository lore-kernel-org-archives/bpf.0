Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6ABC433F5
	for <bpf@archiver.kernel.org>; Tue, 10 May 2022 17:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbiEJRyN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 May 2022 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiEJRyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 13:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F56BFF6
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF40F61A09
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 17:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AF9FC385C2;
        Tue, 10 May 2022 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652205013;
        bh=YdBmIcDVVNOYmHwaSFlRdx8fAfSXc+YAEdJA3XSrCAI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W7UwzVrc82iDR6wuxTHFIiMvW8sDObgt0VlAgzQVgBOtSDRV0WAxNapGf1T68hZuE
         Ho3ceBK27ergciLzsSi4N8BnwefVwEdT6EPDJomX4lV8kwOpZ8wFC1+0V7od1dG0Uu
         93jOBmKSLkUz2WIYL8mBTr9ynT9YBFed/rzb3GhZ0F6/vQbhHs61UBFEv4rj1W4ers
         hol4CWlpH5lwlmP1AT7BmWsVKvQ/FLlUP2KIDRz9mAvJvDDGQE7qRVJ7hAuny6kQug
         1J0LO6UmXzWlSjUxm5VIpIruhK2969Y3sBGQirzC7cPMf8VsK+wqZMG78E0f0a2TkA
         2cEJuna9osD5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AB8AF0392D;
        Tue, 10 May 2022 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: bpf_link_get_from_fd support for LSM
 programs in lskel
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165220501317.1369.13666686860078876054.git-patchwork-notify@kernel.org>
Date:   Tue, 10 May 2022 17:50:13 +0000
References: <20220509214905.3754984-1-kpsingh@kernel.org>
In-Reply-To: <20220509214905.3754984-1-kpsingh@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 May 2022 21:49:05 +0000 you wrote:
> bpf_link_get_from_fd currently returns a NULL fd for LSM programs.
> LSM programs are similar to tracing programs and can also use
> skel_raw_tracepoint_open.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next] bpftool: bpf_link_get_from_fd support for LSM programs in lskel
    https://git.kernel.org/bpf/bpf-next/c/bd2331b3757f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


