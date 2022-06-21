Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11025C43334
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiFUAKR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFUAKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 20:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842E6363
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BCE4B8164C
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 036FEC341C4;
        Tue, 21 Jun 2022 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655770213;
        bh=486hHIQjGGPj/0355Pp/yVb4sJSIlECmubK627/vj68=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tcchza/h6ZGOQOtg4DXBthlZUlixh1BB+X19t9i2Xu+EmDtqCmevd9gSGB6UrFEiI
         8woNgFCKecB1Q7g8mjD+v5SBTue5mklz0TENhA4dHPWMwNIKYOOfXQR/IZx1d/gEfk
         0TaWurbYt/k9ebExCIXq49dx1fjAp8HcQkQ6DTndptbc9OnxRQGeLGcHJZEunFfcXX
         lYF4bqZ+JEtMdrdYHhhabqcrU9CXoyIMP7zvTNFwzAMUJZpjGEuDwMv/WWfeHSuuCm
         mTI8ykpNVV+NrGS5Aypzp5DF8IK2kP7fkhSRqXO5NEuBkPascXfqByogL7XYZ/QvcM
         FR4oHcxiEqrxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE60AE737E8;
        Tue, 21 Jun 2022 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] uprobe: gate bpf call behind BPF_EVENTS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165577021290.22381.7101862795559225149.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 00:10:12 +0000
References: <cb8bfbbcde87ed5d811227a393ef4925f2aadb7b.camel@fb.com>
In-Reply-To: <cb8bfbbcde87ed5d811227a393ef4925f2aadb7b.camel@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, rostedt@goodmis.org, rdunlap@infradead.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 Jun 2022 21:47:55 +0000 you wrote:
> The call into bpf from uprobes needs to be gated now that it doesn't use
> the trace_events.h helpers.
> 
> Randy found this as a randconfig build failure on linux-next [1].
> 
>   [1]: https://lore.kernel.org/linux-next/2de99180-7d55-2fdf-134d-33198c27cc58@infradead.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next] uprobe: gate bpf call behind BPF_EVENTS
    https://git.kernel.org/bpf/bpf-next/c/aca80dd95e20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


