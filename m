Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF0C43334
	for <bpf@archiver.kernel.org>; Fri,  8 Jul 2022 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiGHWUV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiGHWUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F6A2E71;
        Fri,  8 Jul 2022 15:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A990661D61;
        Fri,  8 Jul 2022 22:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 060BEC341CF;
        Fri,  8 Jul 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657318814;
        bh=lTA0WWhEZrId7RYYncgLhzhNFNW68XcONj+L6Uzzhvw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S4ME+0phcFE39OiBvdBrMndoh0IwdPLABS32M69XyujArhLAimGAQ5EQmW3aJ+jr+
         LYRtP/B5hPaTKizffSyGjTwAEvTDnoE02FBf6rd/G3hmxsCzMFv5x9DWj5KD+KVVZq
         jESWBieNm6fIPqeeYilAHMVFo4xCcFbKCGjEQTLhqOZND1JxMr8e2pM9slmwTXBdIw
         6HXIDnTsu9nA/Lm8vp4GDfeJ92+OmilCH/3ovCi55TAFp0fKrcQ+EPvcmaH4rDsRZn
         RXBZidra82IOv2L0hC4BAAm7EDf7XqmBEaL/PFGY9NC3wcimhRtWUA1RAjfqoz8Ri6
         lst/V1OKGuhrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCB78E45BDB;
        Fri,  8 Jul 2022 22:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] libbpf: disable SEC pragma macro on GCC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165731881389.3468.1090861086732416921.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Jul 2022 22:20:13 +0000
References: <20220706111839.1247911-1-james.hilliard1@gmail.com>
In-Reply-To: <20220706111839.1247911-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  6 Jul 2022 05:18:38 -0600 you wrote:
> It seems the gcc preprocessor breaks with pragmas when surrounding
> __attribute__.
> 
> Disable these pragmas on GCC due to upstream bugs see:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55578
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90400
> 
> [...]

Here is the summary with links:
  - [v4] libbpf: disable SEC pragma macro on GCC
    https://git.kernel.org/bpf/bpf-next/c/18410251f66a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


