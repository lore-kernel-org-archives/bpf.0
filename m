Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B9DC433EF
	for <bpf@archiver.kernel.org>; Thu, 17 Mar 2022 19:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiCQTvc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCQTvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 15:51:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993BA264545
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 12:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34CA1B81FB8
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 19:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1C1CC340EC;
        Thu, 17 Mar 2022 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647546610;
        bh=70pzwYJVMvRdZONF9AauKdogAW+ri8j14cXweNVHM1E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qhZISAnVgfZwpe91cC2Hg6UN8cxcjJiRRYcWo1SoUcOXSoItsZvSQycxW/HEqU5S2
         G5SWtsz9YVaU/NaSl9gcJwnTPAUwf7jyS9Q8RWxqXrM/CRXgg+OACXOTjfBr9MU6b+
         U8egdpHBN39ehuJS0qHkkwYsc8SrX65HkldbrKBbCiyBGixnA70rNB1D3bYRdlvFFH
         /kShYEgqUT6hZMGg2b+LE5/rM8Aeyw9RhYUpiPPmUSD2tcfDi2H4gX/fBglXQmKlRn
         6Q1lynCP0ENiKAZgVQT8yJBYS1DL+S7GhUWk5V+soWJqJ+wd5zTzptMF3TgKKydzxW
         Vvt5vnBCOZdAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981F1EAC09C;
        Thu, 17 Mar 2022 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix tunnel remote ip comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164754661061.28349.11270630176951579438.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Mar 2022 19:50:10 +0000
References: <20220313164116.5889-1-fankaixi.li@bytedance.com>
In-Reply-To: <20220313164116.5889-1-fankaixi.li@bytedance.com>
To:     =?utf-8?b?6IyD5byA5ZacIDxmYW5rYWl4aS5saUBieXRlZGFuY2UuY29tPg==?=@ci.codeaurora.org
Cc:     shuah@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Mar 2022 00:41:16 +0800 you wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> In namespace at_ns0, the ip address of tnl dev is 10.1.1.100 which
> is the overlay ip, and the ip address of veth0 is 172.16.1.100
> which is the vtep ip.
> When doing 'ping 10.1.1.100' from root namespace, the
> remote_ip should be 172.16.1.100.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: fix tunnel remote ip comments
    https://git.kernel.org/bpf/bpf-next/c/a50cbac6d81a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


