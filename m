Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F8C433FE
	for <bpf@archiver.kernel.org>; Mon, 11 Apr 2022 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiDKTWe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiDKTW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 15:22:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22245103A;
        Mon, 11 Apr 2022 12:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3985B81850;
        Mon, 11 Apr 2022 19:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A8DC385A3;
        Mon, 11 Apr 2022 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649704811;
        bh=gN3VlIO2kM2UMF7BL9EcJ3k6i8Mdp5vtjJPtlsEqNt0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fnnMbLwuhzpcCYvJSoA/zHpbtzEh+REpWMerA1WChdAoKCZ20CNhkTEbTxgtg9VmZ
         3ZRuO2HWEHn7g3wU2TIWBIalEiNAjBIpzkBcfWT27suum5ee0eBBjjek+tvZyfHHO1
         +Gm5wRO+KjJ8060Q53Hpy3HWkKcBzsA0LLRqC4Egvj42//Aa328mk/99fh6FBy27Rg
         JbafsEO9bqt2hjrGWWBqwpv0bJ/gw802C/VZFt0h1HngtCOiJ8HhFCMPCzcDkP1SKC
         +CUxobsM3gD+poYZ75yjlpSPyMJ5I5JPSWqArzgpUcvRS3Lq0zvlN3p2i3gEgq1d/7
         ZaIQC1AThkNZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63FD9E7399B;
        Mon, 11 Apr 2022 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove redundant assignment to meta.seq in
 __task_seq_show()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164970481140.25580.12633889455245025206.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 19:20:11 +0000
References: <20220410060020.307283-1-ytcoode@gmail.com>
In-Reply-To: <20220410060020.307283-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 10 Apr 2022 14:00:19 +0800 you wrote:
> The seq argument is assigned to meta.seq twice, the second one is
> redundant, remove it.
> 
> This patch also removes a redundant space in bpf_iter_link_attach().
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove redundant assignment to meta.seq in __task_seq_show()
    https://git.kernel.org/bpf/bpf-next/c/aa1b02e674fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


