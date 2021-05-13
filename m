Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58458C433B4
	for <bpf@archiver.kernel.org>; Thu, 13 May 2021 23:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9AB613F5
	for <bpf@archiver.kernel.org>; Thu, 13 May 2021 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEMXBX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 May 2021 19:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhEMXBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 19:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 668A361448;
        Thu, 13 May 2021 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620946811;
        bh=v1iISN8gegdNK7btKtU/7xpG6rDZw0k0VcoWLk4ltrM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UOiUHtw9ErRp6YuCxXybgPpZY1pwQKk71Z11v7oJYKH2p+MwOANtbJr0Czr2/RXHt
         3DwEU2IQ/KSTBi0suDbam+hI2VH6xxswDqUYGxcyeFYcx14ISYPArRNHVRN8UuUzsP
         GgwEllAb/2uMBCe/ILiB3y23DIibA6pIUlUQSdUNgAZofe0le2LwJhyYLu/RKy0nk9
         mYmjoANSdz877fZdcojumbhrSG5sf94jz1IWffggmRg7+6zZBgsbgZR3SfIWEyESEj
         sYjB5GbuEcHoTEOkZICaPG/pigb8Ywvr6j/xEE+CD+01NrrKjt9W2myBzBe8cSa5yc
         4/W/MqXHmle+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] virtio-net: fix for build_skb()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162094681137.5074.5504584757048483865.git-patchwork-notify@kernel.org>
Date:   Thu, 13 May 2021 23:00:11 +0000
References: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 13 May 2021 19:48:06 +0800 you wrote:
> #1 Fixed a serious error.
> #2 Fixed a logical error, but this error did not cause any serious consequences.
> 
> The logic of this piece is really messy. Fortunately, my refactored patch can be
> completed with a small amount of testing.
> 
> Thanks.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] virtio-net: fix for unable to handle page fault for address
    https://git.kernel.org/netdev/net-next/c/6c66c147b9a4
  - [net-next,2/2] virtio-net: get build_skb() buf by data ptr
    https://git.kernel.org/netdev/net-next/c/7bf64460e3b2

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


