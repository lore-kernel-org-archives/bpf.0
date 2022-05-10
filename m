Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59865C433F5
	for <bpf@archiver.kernel.org>; Tue, 10 May 2022 00:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiEJAyJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 May 2022 20:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiEJAyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F62B276F;
        Mon,  9 May 2022 17:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBD36158D;
        Tue, 10 May 2022 00:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3D80C385CC;
        Tue, 10 May 2022 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652143812;
        bh=zZOmZym5pqdBOPsCfPDOt0BQ17UULmanHfYJ/VIHmAM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZN6mEdi8UxijWZM8bBJJzQNKmp0i5A/9T+vBas0XKBti3RVExqRflrDDPlYCfVend
         5l1rBG5h+4g77nd10zGk4m9LENuE3FOAvZX9ggK4Gvi+sm6jjhNszWbAVNeXLb1brK
         EWwXOHUE09CjAOt3MY70yxhkJuigaat4JzhnV5Fw8+oYwHb1OceBTPAVG6U/N/8Yas
         M/eXk3LOdxh5fi5Lg0cEqcN/O/YptqY8WEFfXT6NSabe9x40QUhHDZcxsBx19FEv0R
         5sx+ysSG55kY75rHgMQKxd7qpvgwzaqjwPp6NI0Qq2JcH/y/r3nOl6RjmRIL8kKohJ
         08vHJ5b1XNm0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FD54F03932;
        Tue, 10 May 2022 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: declare generator name
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165214381252.1602.949986695734841683.git-patchwork-notify@kernel.org>
Date:   Tue, 10 May 2022 00:50:12 +0000
References: <20220509090247.5457-1-jasowang@redhat.com>
In-Reply-To: <20220509090247.5457-1-jasowang@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        peter.maydell@linaro.org, armbru@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 May 2022 17:02:47 +0800 you wrote:
> Most code generators declare its name so did this for bfptool.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tools/bpf/bpftool/gen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - bpftool: declare generator name
    https://git.kernel.org/bpf/bpf-next/c/56c3e749d08a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


