Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7ACC64EC4
	for <bpf@archiver.kernel.org>; Thu,  9 Mar 2023 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCIBkX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Mar 2023 20:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCIBkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 20:40:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1D8483F
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 17:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07C95B81E16
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9FFCC4339B;
        Thu,  9 Mar 2023 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678326018;
        bh=2kQTS3A3eApeGDPiGvcz8voyyl+67uZNTfRuCgRzdyU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y6aWhy5bhJ8Kw2RS5MWg6d7nXS1vDrc3lox7e30xu8wU+KjXndQRlC5wA/ZltbcAf
         j0KI6ASlE9usWZrM1wPyDzPUNhMdh00vyQfRUhKNLf0TQbZJzJUiPcwfpvekKtlxTm
         BMIl6w28CjawiWem7PriOJee4VNThVmwYlL2Mg/Xa7BYKsUz3h8+LDNQj5DopW10wt
         phOjfJvhjErOHnTeIYqDqwZ6UNWlWlRao6oCNqAvazjU+nHUGtULmo2n403QBVMdMO
         o18M1NrPReRRQV57snbFeanma2sxlA0pQ728LYwmwDI//kWYWZNT9gFDVaFLQqvTOr
         f2nNxl4ONd2sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C591E61B61;
        Thu,  9 Mar 2023 01:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Mar 2023 01:40:18 +0000
References: <20230309004836.2808610-1-jesussanp@google.com>
In-Reply-To: <20230309004836.2808610-1-jesussanp@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, sdf@google.com,
        rongtao@cestc.cn, daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 Mar 2023 16:48:36 -0800 you wrote:
> This reverts commit 6d0c4b11e743("libbpf: Poison strlcpy()").
> 
> It added the pragma poison directive to libbpf_internal.h to protect
> against accidental usage of strlcpy but ended up breaking the build for
> toolchains based on libcs which provide the strlcpy() declaration from
> string.h (e.g. uClibc-ng). The include order which causes the issue is:
> 
> [...]

Here is the summary with links:
  - Revert "libbpf: Poison strlcpy()"
    https://git.kernel.org/bpf/bpf-next/c/3b83591e32dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


