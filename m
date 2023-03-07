Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C32C6FA99
	for <bpf@archiver.kernel.org>; Tue,  7 Mar 2023 23:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCGXkY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCGXkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:40:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAE867C9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DBE61573
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9977C433D2;
        Tue,  7 Mar 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678232419;
        bh=o8DFem7SrCUggJLTAPlZdEhaoqCEKewjLBBZYR1Nl54=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TbwSwjJ9H/opeXxqqzU6Esu5sWmlixEdg2HatV0suPc4wGuuUStaiuWjdALgZHri5
         qfCbZnUrmjfJzP4WEroKpYKx465JZXmQSNxDlpjD1tTWgeOEytL5nMZXql9D26PXpK
         I3hRln4fph6ZjBYHxG3ZL84LWItOLk3GavizlvyrCB7c47WWdFzkVBFVZziKiXlFqf
         0+vKks7R5d404IdXQIXP5fFF/Nj+N/CDa9Jd1t59ZiLSiG5pR+P3TX3coylrEuo5m7
         Kp0EWKxagQg57l5KebYNleqxDLqLFjXO39aLVP/P2118WC6eDY7MCoZcO3TGviNfgO
         tLSIsrRbTAu2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FE1AE61B63;
        Tue,  7 Mar 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] libbpf: usdt arm arg parsing support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167823241952.30619.2262071990732323589.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 23:40:19 +0000
References: <20230307120440.25941-1-puranjay12@gmail.com>
In-Reply-To: <20230307120440.25941-1-puranjay12@gmail.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  7 Mar 2023 12:04:38 +0000 you wrote:
> This series add the support of the ARM architecture to libbpf USDT. This
> involves implementing the parse_usdt_arg() function for ARM.
> 
> It was seen that the last part of parse_usdt_arg() is repeated for all architectures,
> so, the first patch in this series refactors these functions and moved the post
> processing to parse_usdt_spec()
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] libbpf: refactor parse_usdt_arg() to re-use code
    https://git.kernel.org/bpf/bpf-next/c/98e678e9bc58
  - [bpf-next,v3,2/2] libbpf: usdt arm arg parsing support
    https://git.kernel.org/bpf/bpf-next/c/720d93b60aec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


