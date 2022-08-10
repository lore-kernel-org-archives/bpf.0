Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B728C00140
	for <bpf@archiver.kernel.org>; Wed, 10 Aug 2022 18:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiHJSuR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJSuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 14:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A04D4C4
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC6B6148B
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 18:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33FD7C433D7;
        Wed, 10 Aug 2022 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660157415;
        bh=cqBQA7K27bVLEM9b0oSbSDlCJimBUV39MeSHP84cUzs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mMDyywgpFugKj+dw16Z+OY2CLuYcwL0OS9MXVl3MgkOmw/JqnGpEw7G8cF9XfmREu
         K1lWDrbQSUcAfbSv5c+8bTYph91ng++Y6maQCL4Rk574UTGp7rU3C0rZU8FFSzJNFI
         /kEOtoBcmdZwyf/a8SJ1dXPaTeNB2+kyc5v3x6AabGMF4X0I/DrwX1pBtIOcmgtMjY
         UT7NPB434C+2yGDWma8+YwIFivJ4viNgrV2QrhPg5Rv9zA/aZk5zzxzzsYdOhggDXp
         YUBTMaI4WyC7SlPDsncDewWrmmvjwaDYsO3blci/rrgE4EQuJ4JpBQ+clMF9qa4eTV
         AmUkf8LPqLzzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F074C43142;
        Wed, 10 Aug 2022 18:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: preserve errno across
 pr_warn/pr_info/pr_debug
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166015741512.9079.6467067492382223461.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 18:50:15 +0000
References: <20220810183425.1998735-1-andrii@kernel.org>
In-Reply-To: <20220810183425.1998735-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Aug 2022 11:34:25 -0700 you wrote:
> As suggested in [0], make sure that libbpf_print saves and restored
> errno and as such guaranteed that no matter what actual print callback
> user installs, macros like pr_warn/pr_info/pr_debug are completely
> transparent as far as errno goes.
> 
> While libbpf code is pretty careful about not clobbering important errno
> values accidentally with pr_warn(), it's a trivial change to make sure
> that pr_warn can be used anywhere without a risk of clobbering errno.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: preserve errno across pr_warn/pr_info/pr_debug
    https://git.kernel.org/bpf/bpf-next/c/d7c5802faff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


