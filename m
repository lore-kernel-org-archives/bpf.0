Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1BDC4338F
	for <bpf@archiver.kernel.org>; Fri, 13 Aug 2021 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B460FC4
	for <bpf@archiver.kernel.org>; Fri, 13 Aug 2021 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhHMPud (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241209AbhHMPuc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 11:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D01AA6103A;
        Fri, 13 Aug 2021 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628869805;
        bh=+kryu6Q64+NB7tmtGEDqEeSitAqfikCExqEE/WDAC7c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NeD/0ZIyrcQI44GWUC1Fbzwom5YmkUgT63Vbku9DlS86T9CECT99JD6qATFOhFGzR
         aTuEXgzg8pEvxBB/o50+XQUIu8n4PVHqj1VSeGbI9oxBPuI6Cx4hZsEEk2djf8oH92
         UfzOaxF7hhaHkNaUxdfP1T1PcjXYDIXpOZYmZrMHUZPoF1rz47pCbBU0Qa0JcqgZn+
         bljrfp2J9ryElHTeKSsHoyYr6lGLh41/MIelIKamH3ejLo4snlRgffXtROhtPA0xz0
         8VYlASCz0TJwmVnB10UcinG5UGTNPAfgOXPYM4fQHn5GFeev9LqWzOAbk9p6y82xRt
         tbO+2ZMZxPhAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] selftests: bpf: test that dead ldx_w insns are
 accepted
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162886980579.24645.7714283956292071992.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Aug 2021 15:50:05 +0000
References: <20210812151811.184086-1-iii@linux.ibm.com>
In-Reply-To: <20210812151811.184086-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Thu, 12 Aug 2021 17:18:09 +0200 you wrote:
> Fix the "verifier bug. zext_dst is set, but no reg is defined" failure
> in the "access skb fields ok" test on s390.
> 
> Patch 1 is the fix, patch 2 adds a test.
> 
> v2: https://lore.kernel.org/bpf/20210812140518.183178-1-iii@linux.ibm.com/
> v2 -> v3: Make sure that the test fails in absence of the fix.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: clear zext_dst of dead insns
    https://git.kernel.org/bpf/bpf/c/45c709f8c71b
  - [bpf,v3,2/2] selftests: bpf: test that dead ldx_w insns are accepted
    https://git.kernel.org/bpf/bpf/c/3776f3517ed9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


