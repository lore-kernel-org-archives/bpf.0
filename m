Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D26C47082
	for <bpf@archiver.kernel.org>; Tue,  8 Jun 2021 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC91613B6
	for <bpf@archiver.kernel.org>; Tue,  8 Jun 2021 20:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhFHUL5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhFHUL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 16:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F28E613AE;
        Tue,  8 Jun 2021 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623183003;
        bh=j3MfOI95xy1ju+uvQ+gfDDhBQztwdHDPZCwxxLYq1qM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FWAnva1LLHM7sfBogt4sbwiQty/eeJnWJWFL3K9t4zJ9xkxdkhzwi8hhCVc6GUG8o
         Yno3OlTiHHLDmZ+vZnGg+61xBGbdF9gwjdh8Dp4zXcvp3g5OWx98iNk6/dxRWtGeNq
         mXsOkDUQA5sLtQuZ9H1zE1dkE6sJAiBxEGHvFDLXxtTpjAbijMQ/9EvT+eW2H9m4m5
         4gvxK+8iiQeyfOcdzycZqNGutpPnsLryFJ+21d7cJVGhtu7TwFvSj1F+ntizQzHgFm
         8BQ8S9Xv6EW7s5UtSEG1n4+rxoJgAVoE37kCkD1hTpvw1OQsREl0TB+RxyiUe5/lBQ
         2lGctsqLcFynQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Make docs tests fail more reliably
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162318300320.28465.14484603794100304736.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Jun 2021 20:10:03 +0000
References: <20210608015756.340385-1-joe@cilium.io>
In-Reply-To: <20210608015756.340385-1-joe@cilium.io>
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        quentin@isovalent.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  7 Jun 2021 18:57:56 -0700 you wrote:
> Previously, if rst2man caught errors, then these would be ignored and
> the output file would be written anyway. This would allow developers to
> introduce regressions in the docs comments in the BPF headers.
> 
> Additionally, even if you instruct rst2man to fail out, it will still
> write out to the destination target file, so if you ran the tests twice
> in a row it would always pass. Use a temporary file for the initial run
> to ensure that if rst2man fails out under "--strict" mode, subsequent
> runs will not automatically pass.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Make docs tests fail more reliably
    https://git.kernel.org/bpf/bpf-next/c/380afe720896

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


