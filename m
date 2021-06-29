Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F13C11F69
	for <bpf@archiver.kernel.org>; Tue, 29 Jun 2021 17:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5EC61DE4
	for <bpf@archiver.kernel.org>; Tue, 29 Jun 2021 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhF2RxX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Jun 2021 13:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234559AbhF2RxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 13:53:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BFFD61DD9;
        Tue, 29 Jun 2021 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624989055;
        bh=BHQaL+GEnFraBK8r0sQgwllHiMm3o7iplDoCGCRBYJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bl2EmnjElH0Qg4SszCAHpwGVasnNNXErgmSl0OJpv+l6hCMir5v2lTmAQEsaqyYjg
         /uSWn50T3bC2bPvr+Pmk63h3TSP9E9V5eRh6nNQ5GRSIihInO7gvApdQI1avE1cdoE
         jA4Plz9EBQDFtvsIm+eTqpU+sRgvQWH5/xQUuBd4=
Date:   Tue, 29 Jun 2021 19:50:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
Message-ID: <YNtdfN28J59Ajogy@kroah.com>
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 10:37:34AM -0700, Rumen Telbizov wrote:
> Add support for policy routing via marks to the bpf_fib_lookup
> helper. The bpf_fib_lookup struct is constrained to 64B for
> performance. Since the smac and dmac entries are used only for
> output, put them in an anonymous struct and then add a union
> around a second struct that contains the mark to use in the FIB
> lookup.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Rumen Telbizov <telbizov@gmail.com>

Did David author this, or did Rumen?

