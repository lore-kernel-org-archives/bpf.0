Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952FAC433EF
	for <bpf@archiver.kernel.org>; Wed, 15 Jun 2022 17:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358181AbiFORkP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiFORkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 13:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B353727
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 10:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB0AC61B75
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 17:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17B36C341C0;
        Wed, 15 Jun 2022 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655314813;
        bh=aZ5iTMaumG+nhyLT6x3GRKmWEmnPflYcZCOAyzUt36o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VVVOlQPKgmAv8L182IHUHCUC9q+uEoHW8aKsJ3fbmriqY8nyA+lrGD4GhGUYnT2Ht
         B8SPNBKXpWc0wUkatNGcEV40c4omgQ6e0WjyYNSTX6F4aASF6dl0sAo2s0BC/JlVNb
         SFEFdpzvOO2X4ksPZDir8tt1+mUWe/9zeiyL/b7KEO80XqfvU3dCja7V+bYL/J1ljA
         efX6WpXrOqvp0XWywPXt7BboxaseIcUFaGzhTxC0LPG7WJF0cquzU39j7ya3GrBYvN
         YH2IHBrZBYT6BQVsOjzL3oDfmSvpbd0Hda32k9ZolWyV9SA0BFjL3LaayqGGhKbSh2
         yz0U1rVhoHYDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F35B6E6D466;
        Wed, 15 Jun 2022 17:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Limit maximum modifier chain length in
 btf_check_type_tags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165531481299.3046.5251416383564197740.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Jun 2022 17:40:12 +0000
References: <20220615042151.2266537-1-memxor@gmail.com>
In-Reply-To: <20220615042151.2266537-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 15 Jun 2022 09:51:51 +0530 you wrote:
> On processing a module BTF of module built for an older kernel, we might
> sometimes find that some type points to itself forming a loop. If such a
> type is a modifier, btf_check_type_tags's while loop following modifier
> chain will be caught in an infinite loop.
> 
> Fix this by defining a maximum chain length and bailing out if we spin
> any longer than that.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Limit maximum modifier chain length in btf_check_type_tags
    https://git.kernel.org/bpf/bpf/c/d1a374a1aeb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


