Return-Path: <SRS0=pSPe=EC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC451C55178
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5B5208B8
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603815214;
	bh=0HFJhYUVC+AxTwWVO75WIFbU9WCK/xzS7BAyc7IVUP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=QHiwkH4A36+nMJKd/fw6UYZmhbKsv4hjjll9jBuZ+lWRqUJ7xdvT37KMA6Z36pPad
	 Jvo6pb1UnYkJuNm7PcSCAr2J7NDXS/Y5BSvlcPUEWdsF8tfREduv5yLYVzC7mXcG7b
	 Ef1QspSukDvvYDQK1QDo0nWPnv8EpVKfINqdu7bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807706AbgJ0QNV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1807402AbgJ0QKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 12:10:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603815004;
        bh=0HFJhYUVC+AxTwWVO75WIFbU9WCK/xzS7BAyc7IVUP8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SyS9qhG6Hu/XhXNNGeCJnhfH+9j/6sgcDWRvT6wKin5f2F8yncXyt0R/7m1o740ZS
         0+tnZVzgy7+Ro6To5nYDvF6asyV20PinJ5bQrxmPvefFapJcOrhZQBqiEfnG0DHszV
         dtGc/nOUdz9HQ93H1GUMtTPkKmIT0W4FIx0jd4cY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix -Wshadow warnings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160381500452.20705.2585416000824554445.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Oct 2020 16:10:04 +0000
References: <20201026162110.3710415-1-arnd@kernel.org>
In-Reply-To: <20201026162110.3710415-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, arnd@arndb.de, kafai@fb.com,
        songliubraving@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 26 Oct 2020 17:20:50 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are thousands of warnings about one macro in a W=2 build:
> 
> include/linux/filter.h:561:6: warning: declaration of 'ret' shadows a previous local [-Wshadow]
> 
> Prefix all the locals in that macro with __ to avoid most of
> these warnings.
> 
> [...]

Here is the summary with links:
  - bpf: fix -Wshadow warnings
    https://git.kernel.org/bpf/bpf/c/343a3e8bc635

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


