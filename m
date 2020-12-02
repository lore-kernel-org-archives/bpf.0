Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2BC64E8A
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 04:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD29221FE
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 04:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgLBEkr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Dec 2020 23:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgLBEkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 23:40:47 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] libbpf: fix ring_buffer__poll() to return number of
 consumed samples
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160688400701.16325.9634862699515593863.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Dec 2020 04:40:07 +0000
References: <20201130223336.904192-1-andrii@kernel.org>
In-Reply-To: <20201130223336.904192-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Mon, 30 Nov 2020 14:33:35 -0800 you wrote:
> Fix ring_buffer__poll() to return the number of non-discarded records
> consumed, just like its documentation states. It's also consistent with
> ring_buffer__consume() return. Fix up selftests with wrong expected results.
> 
> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Fixes: cb1c9ddd5525 ("selftests/bpf: Add BPF ringbuf selftests")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] libbpf: fix ring_buffer__poll() to return number of consumed samples
    https://git.kernel.org/bpf/bpf/c/f6a8250ea1e4
  - [bpf,2/2] selftests/bpf: drain ringbuf samples at the end of test
    https://git.kernel.org/bpf/bpf/c/156c9b70dbfb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


