Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F2AC19F2A
	for <bpf@archiver.kernel.org>; Thu, 11 Aug 2022 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiHKOyM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Aug 2022 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiHKOyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 10:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9E9081B;
        Thu, 11 Aug 2022 07:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40419615C5;
        Thu, 11 Aug 2022 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56271C433C1;
        Thu, 11 Aug 2022 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660229649;
        bh=+fbSE2LlUV2J/Frtp9qXEkiP9lBIp9TQJEpWlfYEvKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dt6df9bWHoDV24TEv4FdpIkh1tb2iqrj7c/QnbxwyvuVWexglktfNp5CcU92KpWSR
         Cmd97cVqQSrTfxhaT9clFRiXfAVscYEw97Kq0811plPexXWckDyiYD/uoWnGpB+ttn
         UFZifV0ncqc0VuowzfVAU35loUpTOfWnMY98iUhOJN4msJOxFCbIeDkrqeR3Lpvdzi
         um8+vvH/JFI2k3fPCKXbCgM2E9yt0fPwdHXJifdgDCf9zirova+zrdTjQVLsll78CN
         DpvbYjs6DPCAtAJACYgUvieiNoCi5Sm39AYAQjZf8YTBUNDda504QzErBHgF+CAaw7
         YEJSVL75sjpiw==
Date:   Thu, 11 Aug 2022 07:54:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: pull-request: bpf 2022-08-10
Message-ID: <20220811075408.147b8b8e@kernel.org>
In-Reply-To: <CAADnVQK589CZN1Q9w8huJqkEyEed+ZMTWqcpA1Rm2CjN3a4XoQ@mail.gmail.com>
References: <20220810190624.10748-1-daniel@iogearbox.net>
        <20220810205357.304ade32@kernel.org>
        <20220810211857.51884269@kernel.org>
        <CAADnVQK589CZN1Q9w8huJqkEyEed+ZMTWqcpA1Rm2CjN3a4XoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Aug 2022 00:06:52 -0700 Alexei Starovoitov wrote:
> Yeah. It is intentional.
> We used all sorts of hacks to shut up this pointless warning.
> Just grep for __diag_ignore_all("-Wmissing-prototypes
> in two files already.
> Here I've opted for the explicit hack and the comment.
> Pushed this fix to bpf tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4e4588f1c4d2e67c993208f0550ef3fae33abce4
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Great, pulled in. Thanks!!
