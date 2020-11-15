Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83915C6369E
	for <bpf@archiver.kernel.org>; Sun, 15 Nov 2020 01:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C71524178
	for <bpf@archiver.kernel.org>; Sun, 15 Nov 2020 01:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwZhBdpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKOBRW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 14 Nov 2020 20:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgKOBRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Nov 2020 20:17:22 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9137324137;
        Sun, 15 Nov 2020 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605403041;
        bh=mEFmTIzdq6NTdvRSn9ExatcT0h+/HejQtBplgOZui2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwZhBdpPLeewCgcmq0uEaklfbpIUUyj6JN1DoVfzgBMfkFy5VMwkiv+nMtkGZScFL
         TkaRBoYcZWELBoljz2BuEtVXM/Jf3R/Mt16gW7byzeSBZPBA0zIEQeM4lo/ZDpHTel
         4sZ0z8d6eUszc4BfD/VkWaAak12KDYUvH6MEDjBw=
Date:   Sat, 14 Nov 2020 17:17:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Allow using bpf_sk_storage in
 FENTRY/FEXIT/RAW_TP
Message-ID: <20201114171720.50ae0a51@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201112211313.2587383-1-kafai@fb.com>
References: <20201112211255.2585961-1-kafai@fb.com>
        <20201112211313.2587383-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 12 Nov 2020 13:13:13 -0800 Martin KaFai Lau wrote:
> This patch adds bpf_sk_storage_get_tracing_proto and
> bpf_sk_storage_delete_tracing_proto.  They will check
> in runtime that the helpers can only be called when serving
> softirq or running in a task context.  That should enable
> most common tracing use cases on sk.

> +	if (!in_serving_softirq() && !in_task())

This is a curious combination of checks. Would you mind indulging me
with an explanation?
