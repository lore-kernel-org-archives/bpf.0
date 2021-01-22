Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F888C433E0
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5A223A5C
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 22:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbhAVWVG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbhAVWUu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 17:20:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 530B823AA1;
        Fri, 22 Jan 2021 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611354010;
        bh=XDBuysLp5eASCLrCMGDzw9hifsQ57Y8BJ5kknMK6XAs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MXdQ5uZwicnE2fshXo8xbcRPpCpP4VYQqkYLoR95M/vctFvV3E/X1F77VBGPIJcxr
         5Ty+Ohh5DeG7rWNNV6x9/QbZHh3ugArgDV08eA8meYjBO93EH7esFuift+gra+/kUw
         oEEGygFuOrgE/4obit2Yl3ELROlVWSIhf/zTsn1Q+QeRL5TYDMxd0UXOq1vebIpwr0
         2ZkLQOqLbYgyj3QF+6aaM5I41KWm3F5mt+ULw1Ng7lxKXCCAFLmcAR281L+HU1WWoH
         j3IiejlyZgeX0HxCswNibKWkQr/GSziZ7SJ0duSdV5mK/V1NT8NsCTdhJtsrgYRl9S
         3IxevMQ8gUOTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] bpf: cgroup: Fix optlen WARN_ON_ONCE toctou
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161135401027.12943.14151458125093918348.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jan 2021 22:20:10 +0000
References: <20210122164232.61770-1-loris.reiff@liblor.ch>
In-Reply-To: <20210122164232.61770-1-loris.reiff@liblor.ch>
To:     Loris Reiff <loris.reiff@liblor.ch>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Fri, 22 Jan 2021 17:42:31 +0100 you wrote:
> A toctou issue in `__cgroup_bpf_run_filter_getsockopt` can trigger a
> WARN_ON_ONCE in a check of `copy_from_user`.
> `*optlen` is checked to be non-negative in the individual getsockopt
> functions beforehand. Changing `*optlen` in a race to a negative value
> will result in a `copy_from_user(ctx.optval, optval, ctx.optlen)` with
> `ctx.optlen` being a negative integer.
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: cgroup: Fix optlen WARN_ON_ONCE toctou
    https://git.kernel.org/bpf/bpf/c/bb8b81e396f7
  - [2/2] bpf: cgroup: Fix problematic bounds check
    https://git.kernel.org/bpf/bpf/c/f4a2da755a7e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


