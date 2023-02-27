Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871BC64ED8
	for <bpf@archiver.kernel.org>; Mon, 27 Feb 2023 14:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjB0OJI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjB0OJD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 09:09:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3CF525E
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:08:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DF0B80C95
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7F8C433D2;
        Mon, 27 Feb 2023 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677506935;
        bh=Ghdo9HjoJ+TtjgIrDYo1QulkXzgo80VdM6yYevhHonM=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=qedsEbWcUlRe1Buk1bGJqx2IUZEIR3l1VpSJkl8sG7mfyEiG94FJtqV1YK4oDMHVo
         BceB8Me7cHGjFd5gFk/2/jMS/whVunUq+vl23oio8R4AjsaDCwF/MCm5i2kkfPLVK2
         wIIOsjB3fQt5IYooGT0Vdm2vL6KR7pICeb+/gGGZ6lBCJ6YhIL7Mecur7alKQfdCKj
         KpyhNq8CFRFQdB2rXXMGpWJauteazTryN1q3H+sGfSP9+/5y9VqPAU8dIad4ImJFWX
         S/U+UaIP6u+tRkyMMXhxTGvR9z9rmq1EaDW3IO6jjy8ghD3XCBFGzRbFHvlt87dTzi
         8uGxaaRJCkVXw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F38AC975C4B; Mon, 27 Feb 2023 15:08:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Anton Protopopov <aspsk@isovalent.com>,
        lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] XDP Multi-Attach
In-Reply-To: <CAPyNcWeAc6qPnxGQVTh1D1WEhLNocDt-=OTOGsXi0D9=Sj6RYg@mail.gmail.com>
References: <CAPyNcWeAc6qPnxGQVTh1D1WEhLNocDt-=OTOGsXi0D9=Sj6RYg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Feb 2023 15:08:51 +0100
Message-ID: <87bklfjj4c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Anton Protopopov <aspsk@isovalent.com> writes:

> When the tc BPF links patch [1] will be merged, a similar concept for XDP
> links may be used to allow multiple users to live next to each other. The
> purpose of this topic is to discuss design and how to better sync with libxdp.
>
> [1]  https://lpc.events/event/16/contributions/1353/

I'm all for doing this (and I agree we should sync with libxdp :)), but
I'm not sure what we'd discuss at the summit? Should be pretty
straight-forward to just implement the same thing between TC and XDP? :)

-Toke
