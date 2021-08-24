Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA94C4338F
	for <bpf@archiver.kernel.org>; Tue, 24 Aug 2021 00:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D37761214
	for <bpf@archiver.kernel.org>; Tue, 24 Aug 2021 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhHXALA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Aug 2021 20:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhHXAK7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 20:10:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3ACC061575
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 17:10:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e15so11165214plh.8
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLQNCLLEO0dr2EkMHlEOJRcHbmjnxgdHtyZ8leefxqI=;
        b=oYFK/Dcyz8fBho8eUcpt03KhMOr7vsxWibmccwyOlKHf1AQ3B8e08q2UkcUJzXzQqX
         FOB+PV9OnYWRrNluPxPQt7v9IJ21RioHq4JINI6j07xA4MygzFHxDEkdaPCuh1sQr0lZ
         /e1buErBRUNqmIzZSgou8cnJTb+/lYoDmmhUo1+GLwmI/Ub1sfVgYeGfZPgJSCfpquP4
         xcXSpOCMHQyEXBStRC74THFn1bVT2FCq/SOZ2XkTKLaaVKSC3oCenecCMhtuUPIA/z7T
         fLybvy5AhGBBbEAwnJDwzctd2ytXcju7RjEpS7TCOPAMpMaF+6uLdB/Gz0oTwsSLVegN
         Iytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLQNCLLEO0dr2EkMHlEOJRcHbmjnxgdHtyZ8leefxqI=;
        b=J7yPOLFYr2YFlalaD2M0+0pukPLWXhS99UuwoH4FjtotiGsS7WJHr40JNRtcD7kLtb
         AZC/1ZRh1yB43VUMyBoHtR3a0dHQVtRVGt4ExNCV+vfQvhuQpkzeVnGKmgCejB1biwfw
         3oRSTlaBuaqXON1EkqtgRigl9NxYdOj3mn7gs0/lAx8XE+jCaZGP+VP+qiELxKfN974w
         CLDH8dW4S7/EjVbbF/dtarGcWOvQT8PoeXJRwCUcMq0mp48NmT0zT7+G5wRFpQkUgtf/
         BIPZnt9Enn1igrDuLYPsIc2pNtMHKEeF19LoB8+p9Rzg2nw41x66j3iYnNQ1XPSfBcGl
         PFdA==
X-Gm-Message-State: AOAM533SlJ2p4jjaLRWSVGnKnsFEFqzgRrdeiMnee3TN6oKX9wvhmCsa
        8jY9WeKrfSg+A+NcfSmiJyg=
X-Google-Smtp-Source: ABdhPJy0sq1MRUQxCI8zLHS99ejxg5OTviAq+0m+eJSiEd4bFQzUeuaQtlqA1NDgKCqwjYUGo8houQ==
X-Received: by 2002:a17:90a:7384:: with SMTP id j4mr1234557pjg.138.1629763816185;
        Mon, 23 Aug 2021 17:10:16 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9af7])
        by smtp.gmail.com with ESMTPSA id z3sm328986pjn.43.2021.08.23.17.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:10:15 -0700 (PDT)
Date:   Mon, 23 Aug 2021 17:10:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenzo Fontana <fontanalorenz@gmail.com>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] bpf: add helpers documentation about GPL
 compatibility
Message-ID: <20210824001013.mktbw4p6mn6desdv@ast-mbp.dhcp.thefacebook.com>
References: <20210822115900.26815-1-fontanalorenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822115900.26815-1-fontanalorenz@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 22, 2021 at 01:59:00PM +0200, Lorenzo Fontana wrote:
> When writing BPF programs one might refer to the man page
> to lookup helpers. When you do so, however you don't have
> a way to immediately know if you can use the helper
> based on your program licensing requirements.
> 
> This patch adds a specific line in the man bpf-helpers
> to show that information straight away.
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
...
>   * long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
>   * 	Description
> @@ -1613,6 +1621,8 @@ union bpf_attr {
>   * 	Return
>   * 		The number of bytes written to the buffer, or a negative error
>   * 		in case of failure.
> + * 	GPL Compatibility
> + * 		Required

I think manually annotating the docs is too easy to get wrong.
I think scripts/bpf_doc.py should be able to pick it up from the code somehow?
or rely on dynamic discovery by bpftool?
