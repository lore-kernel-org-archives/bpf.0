Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A1C2D0E4
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12428206FB
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VapWDdeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390211AbgKXQVm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390367AbgKXQVm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 11:21:42 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEBB5206B7;
        Tue, 24 Nov 2020 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606234901;
        bh=UuIWVSXdAmf+S3OUhxaEF5FzDTKiuY5T6ZpOOruZKbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VapWDdeFezR7Mmu9aYJxDdA1uFof1y45TcggFtRmbl3rhyEhr7octdiwsBIW0XlQv
         nWLHyoIYpQmFJzrlUaboLla2ssOUWNdcTNvRnE0UHC4E9DfOOrQiLvBDlEhQBFxIzY
         LkOgaGWBS51bxTo0NqePsSwFlUMrzUCHspr3JW3Q=
Date:   Tue, 24 Nov 2020 08:21:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFQ=?= =?UTF-8?B?w7ZwZWw=?= 
        <bjorn.topel@intel.com>, magnus.karlsson@intel.com, ast@kernel.org,
        daniel@iogearbox.net, maciej.fijalkowski@intel.com,
        sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
        qi.z.zhang@intel.com, edumazet@google.com,
        jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: Re: [PATCH bpf-next v3 01/10] net: introduce preferred busy-polling
Message-ID: <20201124082139.77e933a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201119083024.119566-2-bjorn.topel@gmail.com>
References: <20201119083024.119566-1-bjorn.topel@gmail.com>
        <20201119083024.119566-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 19 Nov 2020 09:30:15 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> The existing busy-polling mode, enabled by the SO_BUSY_POLL socket
> option or system-wide using the /proc/sys/net/core/busy_read knob, is
> an opportunistic. That means that if the NAPI context is not
> scheduled, it will poll it. If, after busy-polling, the budget is
> exceeded the busy-polling logic will schedule the NAPI onto the
> regular softirq handling.
>=20
> One implication of the behavior above is that a busy/heavy loaded NAPI
> context will never enter/allow for busy-polling. Some applications
> prefer that most NAPI processing would be done by busy-polling.
>=20
> This series adds a new socket option, SO_PREFER_BUSY_POLL, that works
> in concert with the napi_defer_hard_irqs and gro_flush_timeout
> knobs. The napi_defer_hard_irqs and gro_flush_timeout knobs were
> introduced in commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
> feature"), and allows for a user to defer interrupts to be enabled and
> instead schedule the NAPI context from a watchdog timer. When a user
> enables the SO_PREFER_BUSY_POLL, again with the other knobs enabled,
> and the NAPI context is being processed by a softirq, the softirq NAPI
> processing will exit early to allow the busy-polling to be performed.
>=20
> If the application stops performing busy-polling via a system call,
> the watchdog timer defined by gro_flush_timeout will timeout, and
> regular softirq handling will resume.
>=20
> In summary; Heavy traffic applications that prefer busy-polling over
> softirq processing should use this option.
>=20
> Example usage:
>=20
>   $ echo 2 | sudo tee /sys/class/net/ens785f1/napi_defer_hard_irqs
>   $ echo 200000 | sudo tee /sys/class/net/ens785f1/gro_flush_timeout
>=20
> Note that the timeout should be larger than the userspace processing
> window, otherwise the watchdog will timeout and fall back to regular
> softirq processing.
>=20
> Enable the SO_BUSY_POLL/SO_PREFER_BUSY_POLL options on your socket.
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
