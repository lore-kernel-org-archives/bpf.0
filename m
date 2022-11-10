Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126F2C433FE
	for <bpf@archiver.kernel.org>; Thu, 10 Nov 2022 02:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKJCZ5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKJCZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 21:25:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97B1CB12;
        Wed,  9 Nov 2022 18:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20C561D22;
        Thu, 10 Nov 2022 02:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD204C433C1;
        Thu, 10 Nov 2022 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668047152;
        bh=azjhJ+jqEeTfQr+u7HUVlFel+rUjpdQtY7Z0nJit2yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U7cSbQJJjhOp/rcCrpopckUH6Ama7KcE7I9ebQ94vLuNqQ/u3z/j9lla20fCVP1b5
         lb34x6Azg/+80mO2VHP4SJM1ktqeNcR2pGH77QFvI9Kgdvyd7bNcKpVQcgvyZlEiiw
         RN54lk8+L0Z0feCAvsU3FEnM7VUwfwSt4xKHvVqstp4au8iMIUa4du1fp8pzc17chv
         6UU0XjMdHbLehBFhM7gKJdlLLRm9GCy7YoyTR9dKVog725snDIJWgjC2N0s4QfhTiA
         GNciGJzmcGKXL7jkuj/F22TdIE/C+PjYsKtdJGLmJ7iz37FVo3LL2QAgWj4+yCgfYE
         2/zhwliuurStg==
Date:   Wed, 9 Nov 2022 18:25:50 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, davem@davemloft.net, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [0/1 bpf-next] fix panic bringing up veth with xdp progs
Message-ID: <20221109182550.4090a6c0@kernel.org>
In-Reply-To: <20221108221650.808950-1-john.fastabend@gmail.com>
References: <20221108221650.808950-1-john.fastabend@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  8 Nov 2022 14:16:49 -0800 John Fastabend wrote:
> Not sure if folks want to take this through BPF tree or networking tree.

Whatever's easiest :) FWIW

Acked-by: Jakub Kicinski <kuba@kernel.org>

> I took a quick look and didn't see any pending fixes so seems no one
> has noticed the panic yet. It reproducible and easy to repro.
> 
> I put bpf in the title thinking it woudl be great to run through the
> BPF selftests given its XDP triggering the panic.
> 
> Sorry maintainers resent with CC'ing actual lists. Had a scripting
> issue. Also dropped henqqi has they are bouncing.

Adding Paolo, who had comments on this patch in the past.

The entire concept is worth mainintaining in your opinion, I take it?
