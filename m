Return-Path: <SRS0=fetE=DS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4D6C433DF
	for <bpf@archiver.kernel.org>; Sun, 11 Oct 2020 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7172321655
	for <bpf@archiver.kernel.org>; Sun, 11 Oct 2020 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602447004;
	bh=YJYRDT45YWas4khF7T032hna8YxBdJNeX2JDDJSRxJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=tcpw8uLatQRAbhTEjLCt0Gd0kem2IzMAigcxgy1UqoJE+nh5V9ph5FYdbsrN6/ayK
	 6du/AcdbpG7SEKPWsh/KhEFslqbNrkfNb90vujoDXFGtZYpdAKTrtoKVeRfgzoAv3e
	 +ghBEHWYYIfgff5kTyLvTzfKqoj3fU6hzb46EJRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgJKUKE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 11 Oct 2020 16:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgJKUKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Oct 2020 16:10:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602447003;
        bh=YJYRDT45YWas4khF7T032hna8YxBdJNeX2JDDJSRxJo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=yf8R1fUjZl5v744q4h0jgiYElJ+BNJJiKbol925Z4TTdOu3RCXCnwT+0OiVIZup7a
         eZ8n5TbYlde+tGAsIQ3PKy0MsdlZ2cTa6kA9lIKXcVnZfL11w8CE4P3DI/od7jxukr
         J3HA+VWGKmMKmVvSorgwllA1ECClGZHOdtiFadZA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Migrate from patchwork.ozlabs.org to
 patchwork.kernel.org.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160244700342.23467.7159015214036359010.git-patchwork-notify@kernel.org>
Date:   Sun, 11 Oct 2020 20:10:03 +0000
References: <20201011200149.66537-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20201011200149.66537-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net,
        konstantin@linuxfoundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 11 Oct 2020 13:01:49 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Move the bpf/bpf-next patch processing queue to patchwork.kernel.org.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Migrate from patchwork.ozlabs.org to patchwork.kernel.org.
    https://git.kernel.org/bpf/bpf-next/c/ebb034b15bfa

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


