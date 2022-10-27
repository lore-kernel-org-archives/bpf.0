Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039CFA3743
	for <bpf@archiver.kernel.org>; Thu, 27 Oct 2022 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiJ0UUY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiJ0UUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 16:20:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F758B41;
        Thu, 27 Oct 2022 13:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F4CCB827DA;
        Thu, 27 Oct 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31D21C433D6;
        Thu, 27 Oct 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666902016;
        bh=ZClBDKmSul2J6eBYrXVa+3TTlcpda/c3o4gbuzfL+VY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uP3C+yZWGEXZlt2NhZK7YjnytxLQTZ0y3sqJJlMfJ1tJQqGdDgk7O9atxEJ5tQkaj
         hnIx+EKC7lf83UvvEqweZGNi9knp4BJ90DzEUkQzPbCObjoLCCTOgiPYLiiRfoZeVo
         U/RqK3eK2NZ4IT9RfQ+bX86Zyu4qycqHWYmYw1lYEbR0kiK8pis4cTyifGGnmyyoW1
         VPHOspUpVRXJgf8orOFKMD+biNWtgQgG+9LaP0Rt4KawbzyrEuL71mOv1PUSSq6a91
         LsaY9b9vtW7bbd/wZzlyEb5qECPQOg2QqhDCzGaCudXRrx5BT4LbRItdavv/sY9bhx
         NTKpwsLBcSzVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC55C73FFC;
        Thu, 27 Oct 2022 20:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Fix a typo in comment for DFS algorithm
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166690201606.3710.8435915135914904961.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Oct 2022 20:20:16 +0000
References: <20221027034458.2925218-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221027034458.2925218-1-xukuohai@huaweicloud.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 26 Oct 2022 23:44:58 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> There is a typo in comment for DFS algorithm in bpf/verifier.c. The top
> element should not be popped until all its neighbors have been checked.
> Fix it.
> 
> Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Fix a typo in comment for DFS algorithm
    https://git.kernel.org/bpf/bpf-next/c/b6d207999c35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


