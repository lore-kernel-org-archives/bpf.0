Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BCC49EA2
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33848613BD
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 15:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhFRPMQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhFRPMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 11:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A088613D1;
        Fri, 18 Jun 2021 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624029003;
        bh=y7D2QxM8hT5xLQTejr2q3FNQ9Ih9QX98O+xXCp5QQMU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=chMTqVjmCmZirlgVERMdEomTZtr2chUw074fqkbRvd/Ctj2y1IYYzV+nRtN/mD6eW
         o26fQnNC8YSZOBUriq/MT/CySVZDhwhdzF3BQm/8qLV6ThJN4mn4iPodchqCefOkS4
         Nb3XM83dzBLm+N2ONqFkw0J1EqNjTcJowbAfqgYL+NoAWhVkPXurVDuHx+DmNn/IdO
         EGUC0W8BPn6D3MxZ+vkt6eKds7L8digrwdmH3a06I3TvPH0/HNHfyedZUyxb1BF1Ih
         LwguOsWvmOJbwHE+HvoK6JSZkjbF3Se45GZC07Yhs0QQgT8PhG7fKBEG2rAiD8bhSc
         Z/RKrzCgkE8gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] xsk: fix broken Tx ring validation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162402900355.14256.7025664905117630187.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Jun 2021 15:10:03 +0000
References: <20210618075805.14412-1-magnus.karlsson@gmail.com>
In-Reply-To: <20210618075805.14412-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, xuanzhuo@linux.alibaba.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri, 18 Jun 2021 09:58:05 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix broken Tx ring validation for AF_XDP. The commit under the Fixes
> tag, fixed an off-by-one error in the validation but introduced
> another error. Descriptors are now let through even if they straddle a
> chunk boundary which they are not allowed to do in aligned mode. Worse
> is that they are let through even if they straddle the end of the umem
> itself, tricking the kernel to read data outside the allowed umem
> region which might or might not be mapped at all.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] xsk: fix broken Tx ring validation
    https://git.kernel.org/bpf/bpf/c/f654fae47e83

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


