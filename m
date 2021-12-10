Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219DFC433EF
	for <bpf@archiver.kernel.org>; Fri, 10 Dec 2021 06:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLJGxq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhLJGxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 01:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB079C061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 22:50:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 740DDB8277B
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 06:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21477C00446;
        Fri, 10 Dec 2021 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639119009;
        bh=u/0IXOMVsglltNfaxSv4yq8fxkf/VEwYM7PEU7dG9uQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=giMthX0vHRcNwCJsUzJa9XkM6eRkK3rEfIxTZuAcEXWFBzDOAUA6KqtUdVQTKxZIs
         /+WdUz6yoBbMlVMV66mmT0DprEW2tbUe2QuFpc9zUDkrYrpwfZy6dHwMHzNDJYPArO
         MPUgimuQm8NPuPsi2j5EIYAHuLxyCMakzU8OhoxSA3DZJ8gJEfTFCQ8Ki1vOFvYkxG
         iKdmbB6t9Z7QptwSRKB0OcNQfuy7uXJS1lErCVuE9ETPNTLg9GRlVpMlobbQj2fW8O
         tbW10/25xAKjnjgcFQEKS/Jptdy4MOAbkVU0vhXvo0AqutDYs15qqf3zFjx7lLHqyh
         k50GlbJqPfUrg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0E6E60A36;
        Fri, 10 Dec 2021 06:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163911900898.29298.5489054463848952459.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Dec 2021 06:50:08 +0000
References: <20211210063112.80047-1-vincent@vincent-minet.net>
In-Reply-To: <20211210063112.80047-1-vincent@vincent-minet.net>
To:     Vincent Minet <vincent@vincent-minet.net>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 10 Dec 2021 07:31:12 +0100 you wrote:
> The btf__dedup_deprecated name was misspelled in the definition of the
> compat symbol for btf__dedup. This leads it to be missing from the
> shared library.
> 
> This fixes it.
> 
> Signed-off-by: Vincent Minet <vincent@vincent-minet.net>
> 
> [...]

Here is the summary with links:
  - libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
    https://git.kernel.org/bpf/bpf-next/c/666af7064562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


