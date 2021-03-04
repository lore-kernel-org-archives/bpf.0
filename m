Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81901C433E0
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D9F64F8C
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhCDPLQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234086AbhCDPKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:10:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E6FF64F8F;
        Thu,  4 Mar 2021 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614870608;
        bh=riJ0/Z4CIjm3xBqsxZ7ig0C95BWhFF0J6XmljxD+IRg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oTID1kg0NJDawXPOv6hyMpX8YJkFN2FLkxWboNq2mDHDtUw3n2n3e/7UeOcSR207g
         F6mM0PqPNxuiy/oTDVQfm0aTeoT/x2B9GfbUjnQnGHh3x7B5tmS2tApusDwoxItpP9
         FP8jLexHC2j8ZJtpCzdkpACVFSjGkgv5ruYJlnXa4YLUzfsMrHrZN87yoXnuRkeufS
         GFF0fQvluy5Qsr47pO0XqqnIJkQ1D4eCdX8bv14wP7k+nQ3kYfZ609xq9oYcyML2FD
         dHddaycyaDSnhYcBokXdUaR3x8l/97YanGRaE+tiTX4BtV/8yXLjIsRrv4IaKHFw7a
         eOCC8UEcP8fRw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161487060828.4521.7890765755645261679.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Mar 2021 15:10:08 +0000
References: <20210301154019.129110-1-iii@linux.ibm.com>
In-Reply-To: <20210301154019.129110-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        kafai@fb.com, bpf@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon,  1 Mar 2021 16:40:19 +0100 you wrote:
> insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
> adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
> This happens because insn_no_def() does not know about the BPF_FETCH
> variants of BPF_STX.
> 
> Fix in two steps.
> 
> [...]

Here is the summary with links:
  - [v3,bpf] bpf: Account for BPF_FETCH in insn_has_def32()
    https://git.kernel.org/bpf/bpf/c/83a2881903f3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


