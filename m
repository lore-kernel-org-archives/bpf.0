Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F8DC54EAA
	for <bpf@archiver.kernel.org>; Fri, 27 Jan 2023 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjA0UCn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjA0UC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 15:02:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F36622786
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 12:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 094E761DA1
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61098C4339C;
        Fri, 27 Jan 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674849616;
        bh=+LHsMaWrGHcSwg6aQpJ6olSOYKVByI10pKYASRXiVrc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vu0oJoAKMn/r30PG44htyw0GtwMQsRkzJ3lZRMP04msDOTpTck5JQf+MqtNNjROij
         nJ6q5INlDX4Jdg5DBJNm7G5E4MXWi8sb939Im4mE/v1+IITvntkAP78i2ogzY4HxZC
         2vkruoidv9FwDjYHE+51fYf2I6U/HpZZDfsggoKXKSNmwCZ+8JsNNRdXgSOeFvvKaB
         n2mBJdHnibSsJnz/XAVmaViff5ZFJW/Ma588Dl7y9mFidkIOUIAKQURwJhjypjfsGo
         m0cs4R0XEkP4Yg47HPzOTz29nWJOljdQH2D6HjysF0YppciRq3Vn9wWaEtdxOXokPM
         BJrue5k7OyVlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38540F83ED2;
        Fri, 27 Jan 2023 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Fix malformed documentation formatting
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167484961622.8531.2364144205830189708.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 20:00:16 +0000
References: <20230126024749.522278-1-grantseltzer@gmail.com>
In-Reply-To: <20230126024749.522278-1-grantseltzer@gmail.com>
To:     Grant Seltzer <grantseltzer@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Jan 2023 21:47:49 -0500 you wrote:
> This fixes the doxygen format documentation above the
> user_ring_buffer__* APIs. There has to be a newline
> before the @brief, otherwise doxygen won't render them
> for libbpf.readthedocs.org.
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] Fix malformed documentation formatting
    https://git.kernel.org/bpf/bpf-next/c/b183aab07058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


