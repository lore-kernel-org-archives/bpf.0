Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B1CC4332F
	for <bpf@archiver.kernel.org>; Thu, 10 Nov 2022 05:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKJFKS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Nov 2022 00:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKJFKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 00:10:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF02B1B8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 21:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D4C5B820CB
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 05:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92EBCC433D7;
        Thu, 10 Nov 2022 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668057014;
        bh=RV8DuRP483ZB0GRyF+ASKfNRXUpzmngLNyOflbIzYI8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fTIDToOLvMbKa2dOkT0LyhDXXt89NwIA+E+9ojtIDxQdOGJ2+u1rL5xxnb7UvkXhZ
         zFPKUuZQ9R23/8T3vUgOjo8xPEAE53GBV6qGX7ZH+TfbgJbHydWhH7YfsS8uSjE+Eu
         7zoKj6b6bXDkpjfJ1SsWHOGbHp+22ubTbsnmLYM9KMEOo9giWuiGW6BO70nC1ziAKh
         3YXbJN5AD6I8Rq3FAaUTWmb+MUbQHDBLn0ZSrxB11scP96iHKiaXOWgyun8/JVMX0k
         SDJaliZMpdj4HUPlCPsnxMpCuueL8G6SW2dLE/5DlKhqg4kkDvt9U7/9HAUdpB1l7k
         3Tnz76p83y3Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A3DFC41671;
        Thu, 10 Nov 2022 05:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests: fix test group SKIPPED result
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166805701449.8788.6440487679157292855.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Nov 2022 05:10:14 +0000
References: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Nov 2022 10:40:39 -0800 you wrote:
> From: Domenico Cerasuolo <dceras@meta.com>
> 
> When showing the result of a test group, if one
> of the subtests was skipped, while still having
> passing subtests, the group result was marked as
> SKIP. E.g.:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests: fix test group SKIPPED result
    https://git.kernel.org/bpf/bpf-next/c/fd74b79df0d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


