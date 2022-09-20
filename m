Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16FECAAD8
	for <bpf@archiver.kernel.org>; Tue, 20 Sep 2022 15:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiITPKW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITPKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 11:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D517E14
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 08:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35CE7B82A85
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0E10C433D6;
        Tue, 20 Sep 2022 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663686615;
        bh=A+iH2xRKoRfd81L+lm2/nDnBWMVbwwZV8wxA1dVDaSs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KQ8Q+porvunJs6n06eCI9C5kzjllpNI2p/+kfu2rjmwpscOZIXp76dHQHopiVrakk
         NICJrOWxaPbMGeCuJeyFQeXOawcbWKT6fwUkBcoTsY1fs66rwuWPZkCg2cyDoM+Fui
         rWKoB20um1Q7WN+uYJcmBBsfvUP4HkhLLo+IfTM877T1Iyq463Ea5jJxHVRzjw1IIa
         /ZMCn1Du7ku/FQm86kDBfXKP7Y9/hmOA+B1zOkZ9lIzPZdBbMukeJU/c782aSMFQrb
         0Y22uvf13oceZd6ZngJBpb1ntVAvgjIGl2TxKMuQoLY+5oohnmmCSXi9Q9PI5h+InV
         7RjF8VzfDvO7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FE47E21EE1;
        Tue, 20 Sep 2022 15:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check whether or not node is NULL before free
 it in free_bulk
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166368661551.24945.11632224303765790563.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Sep 2022 15:10:15 +0000
References: <20220919144811.3570825-1-houtao@huaweicloud.com>
In-Reply-To: <20220919144811.3570825-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        andrii@kernel.org, songliubraving@fb.com, haoluo@google.com,
        yhs@fb.com, daniel@iogearbox.net, kpsingh@kernel.org,
        davem@davemloft.net, kuba@kernel.org, sdf@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, oss@lmb.io,
        houtao1@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Sep 2022 22:48:11 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> llnode could be NULL if there are new allocations after the checking of
> c-free_cnt > c->high_watermark in bpf_mem_refill() and before the
> calling of __llist_del_first() in free_bulk (e.g. a PREEMPT_RT kernel
> or allocation in NMI context). And it will incur oops as shown below:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check whether or not node is NULL before free it in free_bulk
    https://git.kernel.org/bpf/bpf-next/c/c31b38cb948e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


