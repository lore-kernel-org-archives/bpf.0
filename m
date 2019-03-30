Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123EC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B441218FE
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="eKR+TilX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfC3DND (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:13:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39761 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbfC3DND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:13:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so4944745qte.6
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 20:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8X4TcZ6UmbBX4YzRBU2seHu9cFcdBzNA2svK7ZMZi5Q=;
        b=eKR+TilX6KMvcv4iHv0SgNDuBtzsB36JeJfMTHIrczKXvcxZXsMI4NvETco7M31bLI
         tFZjkfp/43nmPrpRRZiqHzG8R+G/z3RxWVG4mCd8hLKgkEcpXzBjFVIsbc+j1O8LMOXz
         fR1kYIsRqcZ9f7bvpscXOn2MxYY9aC2B5DsVqfnnzpdxyeRbXzlqcPnwlUcl4wXcEPKM
         65cc4eSEw2RN3IrPSgkK0bbQ48gGYvGFOSLPz8zLZ0NzXPXQA/7LSEaC+ITAQ68rsHLE
         RuKjS3X4HG0vZKU4w5uVKmCyePvasVldW7OOsQilIoDS4LMtEs6ms8madnAjSyAuW7Qg
         oP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8X4TcZ6UmbBX4YzRBU2seHu9cFcdBzNA2svK7ZMZi5Q=;
        b=F5gNCXnZAXymakfrhdW4KqEz5yMkizgtb2r55jtKnIY4Ujq5pizyYvrfvllahaybi8
         GQEGpBdFRXbrjTy/VUkrdXGVTaPz45tyhWKUaEMwwlzNGpM0b33KUZy3RhIJzlC4sP3B
         OAtMTIzCo+U5ju32hi00ryJt3lOCEj66VvmDvA/sMe/durMy8MulREdrnkMxuJkgxQx9
         kQPVmzGfEZ8vcBSQp6Z+GeqaxQpqsGd6EObxohjmBJ34XoP/304ZyrcztiCtnJDRSMgL
         6spRDJLgq4jCG939zG+x7nak9GwfMBtJ7zcftIzbzgPq/lWne4l9At4DyPOFav0goxgm
         pIog==
X-Gm-Message-State: APjAAAUJ0il0BI/sGo4lGtWYZEZY95EhTLFh16ujwYGZe3n6KpNDbFFZ
        VRTidNbGq0csbPklOQjH+VWkNw==
X-Google-Smtp-Source: APXvYqyFakR4g+PAP1CCEgX6y99ShKti2NVmJmwSXwEdXdj6k8qYIJpml1UlAn/p+EQKTHis9/hFew==
X-Received: by 2002:ac8:2d94:: with SMTP id p20mr44764140qta.62.1553915582758;
        Fri, 29 Mar 2019 20:13:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f20sm2280099qtk.14.2019.03.29.20.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 20:13:02 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:12:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     <davem@davemloft.net>, <daniel@iogearbox.net>, <jannh@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: improve verification speed by not
 remarking live_read
Message-ID: <20190329201259.4d20e06b@cakuba.netronome.com>
In-Reply-To: <20190330001612.2354959-4-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
        <20190330001612.2354959-4-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Mar 2019 17:16:08 -0700, Alexei Starovoitov wrote:
> With large verifier speed improvement brought by the previous patch
> mark_reg_read() becomes the hottest function during verification.
> On a typical program it consumes 40% of cpu.
> mark_reg_read() walks parentage chain of registers to mark parents as LIVE_READ.
> Once the register is marked there is no need to remark it again in the future.
> Hence stop walking the chain once first LIVE_READ is seen.
> This optimization drops mark_reg_read() time from 40% of cpu to <1%
> and overall 2x improvement of verification speed.
> For some programs the longest_mark_read_walk counter improves from ~500 to ~5
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
