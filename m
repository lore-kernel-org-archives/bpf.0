Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDADC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F712082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCW//9Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfC0RAk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:00:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42119 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfC0RAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:00:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so10222654pgh.9;
        Wed, 27 Mar 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzHWBIAREX/6mrjY6v/9gTFQpZ+iMzm64VV3/9CIRVg=;
        b=XCW//9LdWj3CR5xIL3cnP8m4CrM4yE4I6WbkOqHrJc0md/gqLzTSOueqrnGYIPRRcH
         k+Ii/frmKY3tnHoMnAh92yy2YUxF8Cv+u2cUKLixSq0UK8wTaBm8Ql/tkoOO3AERGMO+
         NJ4xsQ7RZloF4IYHFpb3YD9h9+p0m+kyYI2PvrO6PJtiDXyTuTovt9VXSsz1j+tpkM14
         H04m+s4mR5X7YxIxvIYYDjdinburkdxBJmnaQ+R5AfUiscX969zZPpagVxeFs4omxnLJ
         O/Gp+XtEEb5gUZaUen/Vsj2gkiTuVhmshFu/REVZH0779RM2hN7kk9bQ6zWEiPHc6bYN
         2cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzHWBIAREX/6mrjY6v/9gTFQpZ+iMzm64VV3/9CIRVg=;
        b=Yu9t17EW87OvnuLKIWkaD7iP28EkLsOdFndIs4Sbg6IfGSxiZbt7Lo0d/hnsIcneVL
         nlnoOCRWp55g18wz+LjQ+uLs6EzxyIsKhwa7SfrSE8kyci2fTMej4dhyanpDeMXenxoA
         lyWLEfpwtpMcLgTuavutMG6AR86B0ksDEfNp+7e53KRxv7L10ohY83GRd2aXj1Lmo3qb
         W1AAxSTW3CmsiGpDd6/bqzFIn2W/oIwc/NevYjpXpi8i/vv1YqrEKKFqZGMNDEnOteLb
         hf2Wi/QU0NBSP/bRtFLhl9ikQDUl7lZdi2s6mC1wwqspfWsIG0VFwTS1BlM6S/IChSUH
         s3nQ==
X-Gm-Message-State: APjAAAUc+6jB0zT4pTwtssgKtXoVKeCPEiMC1jgM77gmTGeZ+zI6PVvc
        6vtEiBykYgHBMdfKLj1VBBE=
X-Google-Smtp-Source: APXvYqz8jBMevrcXUUbxW19q3J+bg6DJEAfEi3U9afwBTR6qaa34+pn78UY5PxLGcTLLsWiu27IZgw==
X-Received: by 2002:a63:78a:: with SMTP id 132mr28048429pgh.196.1553706038534;
        Wed, 27 Mar 2019 10:00:38 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id d75sm54573848pga.66.2019.03.27.10.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:00:37 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:00:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
Message-ID: <20190327170035.qbyli5r5a3cctfca@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
> After previous patches, verifier has marked those instructions that really
> need zero extension on dst_reg.
> 
> It is then for all back-ends to decide how to use such information to
> eliminate unnecessary zero extension codegen during JIT compilation.
> 
> One approach is:
>   1. Verifier insert explicit zero extension for those instructions that
>      need zero extension.
>   2. All JIT back-ends do NOT generate zero extension for sub-register
>      write any more.
> 
> The good thing for this approach is no major change on JIT back-end
> interface, all back-ends could get this optimization.
> 
> However, only those back-ends that do not have hardware zero extension
> want this optimization. For back-ends like x86_64 and AArch64, there is
> hardware support, so this optimization should be disabled.
> 
> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the control
> variable for whether the optimization should be enabled.
> 
> It is initialized using target hook bpf_jit_hardware_zext which is default
> true, meaning the underlying hardware will do zero extension automatically,
> therefore the optimization will be disabled.
> 
> Offload targets do not use this native target hook, instead, they could
> get the optimization results using bpf_prog_offload_ops.finalize.
> 
> The user could always enable or disable the optimization by using:
> 
>    sysctl net/core/bpf_jit_32bit_opt=[0 | 1]

I don't think there should be a sysctl for this.
32-bit archs and ppc/sparc should always do it, since there is no downside
and for x64/arm64 the verifier won't be inserting shifts because
bpf_jit_hardware_zext==true.
We probably need a new insn for this. I'm guessing shifts are not always
optimal on all archs. There could be arch specific insns that do it.
I'd love to hear from arch folks though.

