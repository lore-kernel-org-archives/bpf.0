Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CEAC2D0E4
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 00:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFD921741
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 00:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j106WQvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgKYAuF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgKYAuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 19:50:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606265405;
        bh=8pb2xy/GJ749DrwuxVFcpdi5bFykatovf4haeiIktKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j106WQvinb4ZPVMAgQNKpOj3f10YjlanYVI+rxmTQrgibuP9g3+6aj6xEEjyfp0NN
         m7cZo4TTN5QhSdcY4Xd8ZO55nKPbRA07WxuXFZ6B9CWkzF1vnyzKLGwWtonVD7oU0f
         FoMEJufEW0FYVdYkTCOU5DZYHTAdre6COrWyWb04=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next 1/2] kbuild: skip module BTF generation for
 out-of-tree external modules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160626540526.31715.17769039124481474588.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Nov 2020 00:50:05 +0000
References: <20201121070829.2612884-1-andrii@kernel.org>
In-Reply-To: <20201121070829.2612884-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, bruce.w.allan@intel.com,
        jeyu@kernel.org, gregkh@linuxfoundation.org,
        yamada.masahiro@socionext.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 20 Nov 2020 23:08:28 -0800 you wrote:
> In some modes of operation, Kbuild allows to build modules without having
> vmlinux image around. In such case, generation of module BTF is impossible.
> This patch changes the behavior to emit a warning about impossibility of
> generating kernel module BTF, instead of breaking the build. This is especially
> important for out-of-tree external module builds.
> 
> In vmlinux-less mode:
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,1/2] kbuild: skip module BTF generation for out-of-tree external modules
    https://git.kernel.org/bpf/bpf-next/c/e732b538f455
  - [RESEND,bpf-next,2/2] bpf: sanitize BTF data pointer after module is loaded
    https://git.kernel.org/bpf/bpf-next/c/607c543f939d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


