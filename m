Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F95C07E96
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 07:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBA61986
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 07:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhGFHWl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Jul 2021 03:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhGFHWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 03:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3242261206;
        Tue,  6 Jul 2021 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625556003;
        bh=VRirDG2vqV1nQEPAVuRRRHRJ/jYUaivULuPRDwECKCo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QfEKn9ty58ArQ+bjfRZX48ZeQ7V6gV5ghBr9MvqhlOgpU+BljNjLM+FP6lp/w1k17
         T6TIDd2RHI5gbJs0q9CWab4Pw2Wq3b0udJyANczIq+eECX1+XasSTC0zvpL1TDjyks
         qWnC8aZw81SdVsbSdfQT7DhladPquiPZm5r5JfqfKvJriinM1Zwmt/4XSSdxkhsHBf
         A+vc6w0zbWvGDUUJICMWv1RN5SzW61otiSrXPQnLs/0SviAL2WlY/kKZHSI/DjqGsi
         kVZcfkeSf1rMOzWU2VaNDF2Z+dXlwLV2UnLzxgEdh20tSd52VtvkV6YFQqgXRDyZcB
         J2zEytjMNRhmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] tools: bpftool: close va_list 'ap' by va_end()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162555600314.16241.8997704889590852579.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jul 2021 07:20:03 +0000
References: <20210706013543.671114-1-gushengxian507419@gmail.com>
In-Reply-To: <20210706013543.671114-1-gushengxian507419@gmail.com>
To:     Gu Shengxian <gushengxian507419@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, gushengxian@yulong.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon,  5 Jul 2021 18:35:43 -0700 you wrote:
> From: Gu Shengxian <gushengxian@yulong.com>
> 
> va_list 'ap' was opened but not closed by va_end(). It should be
> closed by va_end() before return.
> 
> According to suggestion of Daniel Borkmann <daniel@iogearbox.net>.
> Signed-off-by: Gu Shengxian <gushengxian@yulong.com>
> 
> [...]

Here is the summary with links:
  - [v3] tools: bpftool: close va_list 'ap' by va_end()
    https://git.kernel.org/bpf/bpf/c/519f9d19e135

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


