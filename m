Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EAFC47423
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465D92075F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601382016;
	bh=5bcZHswlih1TDwO6cmZTsL6/2ntPgPe7II8Qz8DEEpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=O42tVGVBW4Eqd9B2Bx7/DPNUGhMWgrKFg5SExxm1QDi7TlH9LN80xfW7lGtOm67aB
	 a60QKl4pMJwPUYUX+/qXKXv8Ua1gKBTiUAoiR8YMSyodPLvrB4ZqZCOtyXw3lpSJ1V
	 kDCdcF9EekVjfhICeA0ba5AqDwHUYiJKKuBgEI/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgI2MUK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729884AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=5bcZHswlih1TDwO6cmZTsL6/2ntPgPe7II8Qz8DEEpk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XVNSChHo0WtRyrYG+dQXAxraGfLyb1QQz/PNDrOvr8Zv8J0/TBzfv8NXMR4VD9eR7
         utsLvXz9ncv7ETXjy9iK2IJHXmK0OBcmEUeQo7V1GJ2cCMSMkNcWwqfQ+Pc/HL8+5Z
         AQNX9fnna3Nfe8DIRbTbDQFUq4XCS4HmkOQVI9Xo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: fix possible crash in socket_release when
 out-of-memory
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200856.26741.14477161917399447364.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <1601112373-10595-1-git-send-email-magnus.karlsson@gmail.com>
In-Reply-To: <1601112373-10595-1-git-send-email-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 26 Sep 2020 11:26:13 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix possible crash in socket_release when an out-of-memory error has
> occurred in the bind call. If a socket using the XDP_SHARED_UMEM flag
> encountered an error in xp_create_and_assign_umem, the bind code
> jumped to the exit routine but erroneously forgot to set the err value
> before jumping. This meant that the exit routine thought the setup
> went well and set the state of the socket to XSK_BOUND. The xsk socket
> release code will then, at application exit, think that this is a
> properly setup socket, when it is not, leading to a crash when all
> fields in the socket have in fact not been initialized properly. Fix
> this by setting the err variable in xsk_bind so that the socket is not
> set to XSK_BOUND which leads to the clean-up in xsk_release not being
> triggered.
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: fix possible crash in socket_release when out-of-memory
    https://git.kernel.org/bpf/bpf-next/c/1fd17c8cd0aa

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


