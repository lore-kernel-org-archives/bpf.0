Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F79C433EF
	for <bpf@archiver.kernel.org>; Thu, 10 Mar 2022 22:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiCJWLN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbiCJWLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 17:11:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8111AA15;
        Thu, 10 Mar 2022 14:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC82D61B60;
        Thu, 10 Mar 2022 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA0BC340E9;
        Thu, 10 Mar 2022 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646950210;
        bh=d6Sa+6H35ANg2dsYtSbuRsbjH9JR3miomAT96F/gkWU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rDh0mdD/CIhZyPanFCtikTotxIscPQQk5sybeCNRhOmIXGVdoM3uLLBX/0RYnNu8u
         mZsBVb0n5Dzdd5BIZRNLfGSWaYKFoIXe9GzncTI1Dza+Ye56foMQwEkqBRzimY5Pkv
         yE0slbzCrgBc6EFQFEuTx9nCFenqasR6njOuXUwtfgoR86S/RT1QflOHPNsGZ3Q1iO
         of1zNdmSf+b+ypftOyzX8FQezQYaS5ZWCFOmR/rv9HXdbmMc2q0zL2b/6DAdemoEwY
         3lFLf4LRzEtymmzhCWUmTQLe/Zltwr9l5nMbRfQTsoQxmymG7t3CpJVm4vqnRM9kK8
         e4xFk+EapRD+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C4E8F0383D;
        Thu, 10 Mar 2022 22:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix comment for helper
 bpf_current_task_under_cgroup()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164695021017.12374.9051682055149741156.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 22:10:10 +0000
References: <20220310155335.1278783-1-hengqi.chen@gmail.com>
In-Reply-To: <20220310155335.1278783-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 10 Mar 2022 23:53:35 +0800 you wrote:
> Fix the descriptions of the return values of helper
> bpf_current_task_under_cgroup().
> 
> Fixes: c6b5fb8690fa ("bpf: add documentation for eBPF helpers (42-50)")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix comment for helper bpf_current_task_under_cgroup()
    https://git.kernel.org/bpf/bpf-next/c/58617014405a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


