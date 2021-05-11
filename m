Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218FC433ED
	for <bpf@archiver.kernel.org>; Tue, 11 May 2021 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE9761919
	for <bpf@archiver.kernel.org>; Tue, 11 May 2021 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKVVR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 May 2021 17:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKVVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 17:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EBB47611BD;
        Tue, 11 May 2021 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620768010;
        bh=QmyX4sDJBmOpfkpxxg2m7yorv+W/7QMULao8qysmXI0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tP6F1qfT8KfDWYNmUzRsG4yr/kzZGbexWMadu1tZuqWsPXca4Xb36iqDW42/PQZ7+
         +2MNXcNiMy7/4HN8V0jxxmFbqjq7mdSifHAXsxAzbUB8FqJIVMeMFpV2Lf1nQPRGmC
         2ru8Cm/7oDBnXFULiwFOmAS+mp8B/Z2DxxvYYZM/3bZva6UNtxSLtPeBJAQ9Gi7qY/
         66ItCfkUhUGJ+PfLl8XcNLtorBFj8KH2Nw/zsz2xgn4j8DD0GHGkX7HIzc6zQE976U
         5EVYa7c9G5AeZYNeSWXicqKr6VRYMRMvroR7Erm1pC6WNJU7uwO4Osj7tbFL0Brxhl
         lb63xMfdEMfAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] libbpf: Provide GELF_ST_VISIBILITY() define for older
 libelf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162076800989.29519.3115135510154601954.git-patchwork-notify@kernel.org>
Date:   Tue, 11 May 2021 21:20:09 +0000
References: <YJaspEh0qZr4LYOc@kernel.org>
In-Reply-To: <YJaspEh0qZr4LYOc@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     andrii@kernel.org, ast@kernel.org, jolsa@kernel.org,
        davem@davemloft.net, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sat, 8 May 2021 12:22:12 -0300 you wrote:
> Where that macro isn't available.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> [...]

Here is the summary with links:
  - [1/1] libbpf: Provide GELF_ST_VISIBILITY() define for older libelf
    https://git.kernel.org/bpf/bpf/c/67e7ec0bd453

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


