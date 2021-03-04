Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC419C433DB
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBF764F5A
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhCDPBI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhCDPAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:00:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A082364F53;
        Thu,  4 Mar 2021 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614870007;
        bh=2xauiKZE48P0NSweOxU6QyYbI0f6MkBRA8KXDoFxO+E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gK6yGXBKrwDkOXaXJqhk3nEnaw/v/dA1ATczfLdFkegV3repPu0DEAxkLDmEs7LQ7
         WuB6eGzMfN8A+CHd7XCn3XB8GssSInI3rclFf7WQ0+w8/AgpJYDLQI0H3xiCKIPSeH
         v4Znz+UW2XQwMFy8BG5XqRDdJFIaE6gPkiOfOHo7+3q19LNE9SA6VqtvcwxBBECxqn
         ld9SSHH3/KM+gMcvWPOCLcY/nnwU5Puq5mKpnPBS7/Ph1ID7xb/lkmuBuoHWLJj5K4
         E0r2hKHuAa1Kc0qIWb5CPVCMo0H1Mn5jSOUD2qklsWZ4vg55zr+Oc35HNWDfINosSn
         P4aAfNzWXa8Ng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/3] AF_XDP small fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161487000759.31494.16642198184003369698.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Mar 2021 15:00:07 +0000
References: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Wed,  3 Mar 2021 19:56:33 +0100 you wrote:
> Hi,
> 
> This time three no-brainers, one is a fix that I sent among with
> bpf_link for AF_XDP set where John suggested that it should land in bpf
> tree.
> 
> Other is the missing munmap on xdpsock and some ancient function
> declaration removal.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] xsk: remove dangling function declaration from header file
    https://git.kernel.org/bpf/bpf/c/c95c34f01bbd
  - [bpf,v2,2/3] samples: bpf: add missing munmap in xdpsock
    https://git.kernel.org/bpf/bpf/c/6bc669988101
  - [bpf,v2,3/3] libbpf: clear map_info before each bpf_obj_get_info_by_fd
    https://git.kernel.org/bpf/bpf/c/2b2aedabc44e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


