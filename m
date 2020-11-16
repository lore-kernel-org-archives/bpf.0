Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06040C2D0A3
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB65222EC
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 18:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQWS2ifo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbgKPSC3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbgKPSC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 13:02:29 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2EA2227F;
        Mon, 16 Nov 2020 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605549748;
        bh=fVHVpiBSYKcCSLXECk2BIBWsNI7VM3wEioJKmaABsPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sQWS2ifoTzYJ4vFEZ0yJgU9Vdv+CGoVesBbZs1e2bpV9zcv5hIYMb4Vi3dh+C6eGD
         WNgELOhWmv9AGKo2uX6DWL3nntoMP9+QYUepfHJLdQele6v42JTskp8Ta6QmukwTwm
         dxzaQEvVg7dmwKUnz43AI/tQjf0N3NnRCOB9Ftr0=
Date:   Mon, 16 Nov 2020 10:02:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Allow using bpf_sk_storage in
 FENTRY/FEXIT/RAW_TP
Message-ID: <20201116100227.1e700000@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201116100004.1bc5e70e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201112211255.2585961-1-kafai@fb.com>
        <20201112211313.2587383-1-kafai@fb.com>
        <20201114171720.50ae0a51@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20201116173734.a5efp2rvg43762ut@kafai-mbp.dhcp.thefacebook.com>
        <20201116100004.1bc5e70e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Nov 2020 10:00:04 -0800 Jakub Kicinski wrote:
> irq_count()

Umpf. I meant (in_irq() || in_nmi()), don't care about sirq.
