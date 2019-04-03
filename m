Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D67C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5BB206DF
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG9t2cd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDCRaf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:30:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCRae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 13:30:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so8657755pgs.8;
        Wed, 03 Apr 2019 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=obV3/tl+c0o924S075h4KyLriaoXqA3niT96z4OcmJo=;
        b=ZG9t2cd+imHFVpfFy9QcvdxOXHPxvt6DmssQ5i4X51h/Gc2mYKsM8g2/ktTONzNiIu
         T9PRu5wIm3YwFrLnAsT5fKkvKHE4FgAQn7FJpBFOPIJwPsdQ26CaB6sK6dfp9wqJzV07
         wEISPgAE9pm8MafX4wCGffxktE4dJAZD4pHGKJNnt1X/DcKqzyY4FjtdGWwLB5FVcCQt
         mLp0DI41f+eUMhNk3GGLaOqFlrvhNp7HLguTRZP27mxKzF7DrVPQ6pl7VssOIc5CSL5H
         WhszFHW7CbzxrtnBnWSZISXE7W3MwjFGfTRDfPyYCo09ijy4G1spEmMBlyLe+X1hSbLt
         y3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=obV3/tl+c0o924S075h4KyLriaoXqA3niT96z4OcmJo=;
        b=fapoCrnNqEThY++ETl3D+Bpu8VSNRYvmix4XHM28gSVOvucAAxdypgpZvU+GCz67pJ
         mV44CbrNUv5Ql0xctmXKqnJI+SVZl2CZMQ9IjfJrcNRkr8YxvXKtYeV85NEdMnTWs+mT
         j/TnlPXlszFqZ6SQYD5yGpZ1d9h5rM6lg27tfELh2f3R4HIB/liX5aYpCVCkM+B2oiGp
         vjhlquHPKkk+M+3pnZXgNVhGCQNbEMqODTB9sCQplAdKq8KKNhhAEQtrpYNAA+ZntHDG
         sVkLoRnmDN/7uqE5qHHL4JO+RqA6eMPiMzXoNzHW+gesMzLn+ThFCVyCzqKl1WFIDgnF
         1kfg==
X-Gm-Message-State: APjAAAV9UguAzr2oG+UyyOTZttBjJFR8usFcIw1QK4UzIgj/Pl79BCo8
        YnTnSX6Na8jBezg1BdTkhkg=
X-Google-Smtp-Source: APXvYqytEe8bura7AOgrFvarX2OvrzPXYs0MmQcB7IPE3jZRa5BDutfeIIHX0jnbssNLJrqOk8FKLA==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr823150pgk.97.1554312633836;
        Wed, 03 Apr 2019 10:30:33 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::7ac0])
        by smtp.gmail.com with ESMTPSA id w68sm23414447pfb.176.2019.04.03.10.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:30:33 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:30:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
Message-ID: <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
 <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 04:52:40PM +0100, Edward Cree wrote:
> On 02/04/2019 15:37, Daniel Borkmann wrote:
> > If we really want to have a kernel warn, then lets add a
> > helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
> > the verbose log intact as well.
> +1
> 
> Any time the verifier detects that its internal invariants have been broken,
>  logging a warning is the right thing to do, just like any other part of the
>  kernel.

It's not black and white.
As I said I don't think verbose_and_warn() is necessary.

Messages like:
verbose(env, "bpf verifier is misconfigured\n");
are technically 'broken internal invariant', but it shouldn't be a warn.

Whereas this:
        if (WARN_ON(regno >= MAX_BPF_REG)) {
                verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
                /* Something bad happened, let's kill all regs */
                for (regno = 0; regno < MAX_BPF_REG; regno++)
                        __mark_reg_not_init(regs + regno);
                return;
        }
should stay as-is.
It's a warn, and verbose message, and clean of regs.
Similarly:
        if (WARN_ON_ONCE(ptr_reg)) {
                print_verifier_state(env, state);
                verbose(env, "verifier internal error: unexpected ptr_reg\n");
                return -EINVAL;
        }
is a warn and more than just a verbose message.

verbose_and_warn() doesn't fit these two practical cases of warn + verbose.
Hence I see no reason to combine warn and verbose into single helper.
They're perfectly fine being separate.

