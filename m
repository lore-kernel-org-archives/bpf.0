Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A10C6369E
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5DE221FD
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 23:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLBXKs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgLBXKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 18:10:48 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606950607;
        bh=kZrLeURbNjidCcnjRH+U+h23ylrjms7lIh8rmfjHZQM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TuWDu39riDEXDVuHnzbR+R8SxgLDRB5yTRVrRpkRjivLXZmkWdklm2bPmieUv+vjS
         8oWuZ+rnlxPQzzCSoBtQzMrDqldnKYexyno5Nh0vzT9/tjzNb5NivRYsvokABJBgcx
         JZ7ZX4AwBhz2JXrg0Rf/o6RQVDszxFvwNXOhP61b2oe2T8j5XOtuL2ZKqPwSDD5FoA
         b+RrCc0DCrlssrkAp4ms7nqAmweO1TmPccpqnHWiRbUZx1vueea9hohT3LwZJlphE5
         E2k8JvT4TQKdpr+3sDaw28OqRSRXJbF40TbuVNpt9LPQSuIEJrWqwVlBGGTyHlr3Jz
         qKoC2ORA2b4BA==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/2] libbpf: add support for
 privileged/unprivileged control separation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160695060728.8525.8161463786281779018.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Dec 2020 23:10:07 +0000
References: <20201202103923.12447-1-mariuszx.dudek@intel.com>
In-Reply-To: <20201202103923.12447-1-mariuszx.dudek@intel.com>
To:     Mariusz Dudek <mariusz.dudek@gmail.com>
Cc:     andrii.nakryiko@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, mariuszx.dudek@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Wed,  2 Dec 2020 11:39:21 +0100 you wrote:
> From: Mariusz Dudek <mariuszx.dudek@intel.com>
> 
> This patch series adds support for separation of eBPF program
> load and xsk socket creation. In for example a Kubernetes
> environment you can have an AF_XDP CNI or daemonset that is
> responsible for launching pods that execute an application
> using AF_XDP sockets. It is desirable that the pod runs with
> as low privileges as possible, CAP_NET_RAW in this case,
> and that all operations that require privileges are contained
> in the CNI or daemonset.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/2] libbpf: separate XDP program load with xsk socket creation
    https://git.kernel.org/bpf/bpf-next/c/56ab028af72b
  - [v6,bpf-next,2/2] samples/bpf: sample application for eBPF load and socket creation split
    https://git.kernel.org/bpf/bpf-next/c/d6482b4367ac

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


