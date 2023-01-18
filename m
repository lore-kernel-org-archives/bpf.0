Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F89C00A5A
	for <bpf@archiver.kernel.org>; Wed, 18 Jan 2023 01:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjARBQq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Jan 2023 20:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARBQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 20:16:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA3305FB
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 17:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A5461495
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6283EC433F0;
        Wed, 18 Jan 2023 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674004216;
        bh=PPFM7sgak98D7S4+e4er6aK24DXNC+xBJqDqhX6ZgiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MEfOru7dOb343lw3N7p/qP7EaYGokyXxmO9/yIEKDjcXp1huHwK3tt0H2YX5RmuM3
         gah2FB48WSlT64plhQAvy0ZYe9XZlNGByc4wsM42Lal8Wrl+MqvrDmrHYZrMaQ1FyS
         st+Qlwtq5ciUNpvwoJXsWFUPhinG90ApJn7puHVzv8DT4WTcWg9e8VPNcRXdrWJj2e
         Z6jdccZHVHdDh5wqSRU1qSEd2yQTufVdJK5jSK0wYnjtZ31Rz4su99pXIWhVeiu+I1
         1vDxLHa3ddm0nqAmD8b9kMvDPTx2HULHh0sjbyfAJQ9d3O1HXhhyRKEzk6JNsKqL/A
         WxyYDv2dkUd/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 435A4C43147;
        Wed, 18 Jan 2023 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167400421627.17898.12379490252320099975.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Jan 2023 01:10:16 +0000
References: <20230117223705.440975-1-jolsa@kernel.org>
In-Reply-To: <20230117223705.440975-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Jan 2023 23:37:04 +0100 you wrote:
> Currently we allow to load any tracing program as sleepable,
> but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> will fail to load.
> 
> Updating the verifier error to mention iter programs as well.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,1/2] bpf: Do not allow to load sleepable BPF_TRACE_RAW_TP program
    https://git.kernel.org/bpf/bpf-next/c/700e6f853eb3
  - [PATCHv4,bpf-next,2/2] bpf/selftests: Add verifier tests for loading sleepable programs
    https://git.kernel.org/bpf/bpf-next/c/c0f264e4edb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


