Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58DC433DB
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CD822EBD
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbhARXAu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732481AbhARXAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 18:00:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 04C6122EBF;
        Mon, 18 Jan 2021 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611010808;
        bh=7/i6FKOJv0Va3+UWXcyDz09yHfTddkLrm7z9LdFTWDM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ee2FhJV4iK0PVba647lYnKG0SJCX+04Ip+zEakrBnAXjOtRjeGOjbxF4RyaGuPaDa
         17S25O1RtUzA1hUPuRnSRe4D7oxWymmnuZ6Q1DJ4okk1LquaRaSy2ii/zwhKWSUcFc
         9OvoiFJhKAfz33joGBj3PZlhPQmmozq7YzzBQ12r2jxeYVKdj7TgewG0W98CUpQgIS
         J/T7nv1BmiXIKYLz4+KUfJ7Kc1NrzrJ25cMG+2ql+HIN1Ht6wGCldnvoLplW6T76+r
         uGQXJ9C1R0bXpI+WOX+R5HO11N/BdACdpoFu6ZzWi6LOZ2oLw/IVdQgVifj4OlAB+i
         eNhjcHWCkPhew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: add BPF_ATOMIC_OP macro for BPF samples
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161101080795.7559.2010212326831673657.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Jan 2021 23:00:07 +0000
References: <20210118091753.107572-1-bjorn.topel@gmail.com>
In-Reply-To: <20210118091753.107572-1-bjorn.topel@gmail.com>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, jackmanb@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 18 Jan 2021 10:17:53 +0100 you wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> Brendan Jackman added extend atomic operations to the BPF instruction
> set in commit 7064a7341a0d ("Merge branch 'Atomics for eBPF'"), which
> introduces the BPF_ATOMIC_OP macro. However, that macro was missing
> for the BPF samples. Fix that by adding it into bpf_insn.h.
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: add BPF_ATOMIC_OP macro for BPF samples
    https://git.kernel.org/bpf/bpf-next/c/af6953b633b3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


