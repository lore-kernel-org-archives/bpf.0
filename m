Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A5C433F5
	for <bpf@archiver.kernel.org>; Thu, 28 Apr 2022 02:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiD1CN1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Apr 2022 22:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiD1CN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 22:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4114015
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 19:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 465F66132C
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 02:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A1B6C385A7;
        Thu, 28 Apr 2022 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651111811;
        bh=Vkdy6dhvyomghmk/ioZw/DJiM4VkLUnKcjCzXKlEvyo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UCG35N36VpWpEEY8uE49llMC6dlWjG368WhykuAODBcByS7OmDHX3GhqI3PmBURCz
         GVgi5Q6813yOj0Yc4fbi8fEIUVgGEdFjv6Wqk3bqCuT0YPRK+fgeT352nvkwcXyv3u
         S209bSFPwC6zDGWx2hqTIK4IoEkeJdgdQ3x3ldVPHSi2+td6QBKz08u0gFO6oXrHTh
         1l8Sas94Opp/+3b9hPzeH7hG0CT1XrK11FFeTXa+aYmnLuD8wZRkxuNUromVDCAMK2
         Ps6P8kNy/1qVZttXj8tX6eD+M283oP3JJ1mxSPdorJK19mosyQQMMHk990mcQocXyf
         1udD7/ndwUjFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E80AE5D087;
        Thu, 28 Apr 2022 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf/selftests: add granular subtest output for
 prog_test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165111181118.23123.3426687802022414864.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 02:10:11 +0000
References: <20220427041353.246007-1-mykolal@fb.com>
In-Reply-To: <20220427041353.246007-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Apr 2022 21:13:53 -0700 you wrote:
> Implement per subtest log collection for both parallel
> and sequential test execution. This allows granular
> per-subtest error output in the 'All error logs' section.
> Add subtest log transfer into the protocol during the
> parallel test execution.
> 
> Move all test log printing logic into dump_test_log
> function. One exception is the output of test names when
> verbose printing is enabled. Move test name/result
> printing into separate functions to avoid repetition.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf/selftests: add granular subtest output for prog_test
    https://git.kernel.org/bpf/bpf-next/c/0925225956bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


