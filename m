Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3DCC433F5
	for <bpf@archiver.kernel.org>; Fri,  8 Apr 2022 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiDHQWW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiDHQWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 12:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9CAE5D
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 09:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6F5FB82B9B
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 16:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63957C385A6;
        Fri,  8 Apr 2022 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649434814;
        bh=Niz3E4cMpLlZ3/RRH7k/MR2MsJQF1i0v/pWN1swWJ3c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rIcsi8LR+PZlmorL8+0dUWK9s/ZbzZ77YD4NB1c9MfveBS2lQK9787r79dY/uq7vK
         1i0CJUc5nx/BPCugX2tSA72G9YZa7xoL1kk9b9eCAvWaYqidT0bKhxecI6JpENP7xI
         t2pS3zK6ks92B7Ti4JWGEWgtZb773ZQiUOetTcVOzUJhUIQlLlkLFkDodVCLtkMtmQ
         Wd5iwjd2Hrpn2elJ8ERh+ENdt7pZw6OYRmwwvAgInnyJd9QOEIzXGjLsSWKiQbmwtA
         WwD/yzl0SATtlbUBZof+dG4g6XAtFUYFoBmyfLc75rVh+Nj/7nvq/jZg6XrIgOO0Zu
         vITC7NJAUZ6Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A2C4E8DBDA;
        Fri,  8 Apr 2022 16:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: use strlcpy() in path resolution
 fallback logic
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164943481429.8672.18385222522361817254.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 16:20:14 +0000
References: <20220407230446.3980075-1-andrii@kernel.org>
In-Reply-To: <20220407230446.3980075-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 7 Apr 2022 16:04:45 -0700 you wrote:
> Coverity static analyzer complains that strcpy() can cause buffer
> overflow. Use libbpf_strlcpy() instead to be 100% sure this doesn't
> happen.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,1/2] libbpf: use strlcpy() in path resolution fallback logic
    https://git.kernel.org/bpf/bpf-next/c/3c0dfe6e4c43
  - [bpf-next,2/2] libbpf: allow WEAK and GLOBAL bindings during BTF fixup
    https://git.kernel.org/bpf/bpf-next/c/3a06ec0a996d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


