Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A2C4727C
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 23:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DED2145D
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601422804;
	bh=rlu9A/UQuOLbugJpPLP9iSuma0XT6YBKdpUPPHd9tiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=yvQ9lZ5tMOkEitApkhFfLEvj4NqCub9pP/V86btco/JA8jvwxaU6muwXaU2F4iClo
	 jf8V4X9us71ZWa/FIqWLc/cvdFiT3bFxvUTsOJA1HRLNq6iGB6XcpBLWcEdTM9tHDS
	 FJ+ephK8dIP+INvNknEpvRp/CRZIDDbjceF8O2bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgI2XkD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgI2XkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 19:40:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601422802;
        bh=rlu9A/UQuOLbugJpPLP9iSuma0XT6YBKdpUPPHd9tiw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LQBE8R5j5yXT3nPotcAMOyY9bN5ZZFRNmm+0HYXNNNBpqKr9Q06oatsWiVQjJlBSk
         dY7uJmvxqbN/g6ySP/VSsIBmV18hQcS+v0I+3h5IyLkrfTWvD4gSdFbFlY8m9qpsnL
         3Z++EtsMGkXfKzUrbsXwlpqq3nZfOQ1ZwnBaOjew=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issues in
 sk_lookup/ctx_narrow_access
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160142280280.12683.16380021357723732123.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 23:40:02 +0000
References: <20200929201814.44360-1-iii@linux.ibm.com>
In-Reply-To: <20200929201814.44360-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 22:18:14 +0200 you wrote:
> This test makes a lot of narrow load checks while assuming little
> endian architecture, and therefore fails on s390.
> 
> Fix by introducing LSB and LSW macros and using them to perform narrow
> loads.
> 
> Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach point")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
    https://git.kernel.org/bpf/bpf-next/c/6458bde368ce

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


