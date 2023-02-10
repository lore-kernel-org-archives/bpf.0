Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57437C05027
	for <bpf@archiver.kernel.org>; Fri, 10 Feb 2023 23:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBJXAW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Feb 2023 18:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBJXAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 18:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D53A0AD
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A5BB82615
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527BAC433EF;
        Fri, 10 Feb 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676070018;
        bh=4vapFFSMPM33RJ/1ba2pDDWeC07snffcoaTNhHg8pZ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I+tavmmJpX6UorC7j2cVHlIYhhQ/kxHN20aHBM4kOY0tyZG3TsO02G++8jk1XXspu
         3j55OvWkeBl67tdjzFZXxBUWUWxJQu6gooOvSIXzlxRrpwYuIsUSkF3rIP8J4hhqS7
         lcA88M95filb1w5WAiyRi40hgm4bNN6wGzgShvJHOZMcKaORP39j/zMKsC5AFaC3mK
         ZpfAzKLqGmrFJ/K9W55tgg+j9nXAICOcdZ5OKynaqxNRq9ROycaC/SKrFxLpvY1Mgz
         TKcI/JuJu9PlmyZhPakt3ZHJuIEIqgzOqg1PMTQZwLSKrNYpQYj7YFvskdj8HNCJ97
         vErmM27KSBzaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22C05E55F00;
        Fri, 10 Feb 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as
 EXTRA_CFLAGS to prepare targets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167607001813.18910.4122270985476270538.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Feb 2023 23:00:18 +0000
References: <20230209143735.4112845-1-jolsa@kernel.org>
In-Reply-To: <20230209143735.4112845-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux@leemhuis.info, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        irogers@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  9 Feb 2023 15:37:35 +0100 you wrote:
> Thorsten reported build issue with command line that defined extra
> HOSTCFLAGS that were not passed into 'prepare' targets, but were
> used to build resolve_btfids objects.
> 
> This results in build fail when these objects are linked together:
> 
>   /usr/bin/ld: /build.../tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o):
>   relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE \
>   object; recompile with -fPIE
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets
    https://git.kernel.org/bpf/bpf-next/c/2531ba0e4ae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


