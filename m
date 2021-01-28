Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F733C433E0
	for <bpf@archiver.kernel.org>; Thu, 28 Jan 2021 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F43E64DD8
	for <bpf@archiver.kernel.org>; Thu, 28 Jan 2021 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhA1NRJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhA1NRE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 08:17:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C02C06178A
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 05:16:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so4285105wmz.0
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a7Kay7oniLiASWWlX9LUAiXElA2SneepAxnVvZ1j9Bg=;
        b=wm0m6q9c7pI2ykqugyIea0bijD0AIdx00BSXxbwNf9QgYWvNFw8u7g0iVVYt98tN+R
         rjUkKmn08QsrSjMYYgeB/BE1Z1aUcapp6QCqdf7hvy5gUsofxEMHByci4Zfw9lL29/yX
         oERUPPJs1zliyHYpPI9tgDdQ0U+aR/L6LMdXAFCyGjUEwkh375xDDu0Y0Bv4A4fL7iLF
         WKss8uZbIloYg2uibFiXWPDP07PR9t8pLYs6U7cPey3J49wkb2Z0K5VlUIsjNVzOJEjJ
         ODqonk+oM9Rgkn7zZM8koJsQ5l0anC8Mqu4tvy1VyRhac92NyvLy31OJvRvDCWk1V+ok
         /jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a7Kay7oniLiASWWlX9LUAiXElA2SneepAxnVvZ1j9Bg=;
        b=bGhKDXeLJ5AkJQhLMIQ6eKE/EKe8UA3/pTTQlPpa+VutGCC3inw5NTxjLtX/cUBaP5
         ELxWRFXUQl/SauG4fy3VOEijIHUIadWZxJEKddAbk84rZ9ZA+uZVdUaMzgfUBk7kl/hH
         sHjnUuN3mgUsdVF/EgGNvji2uri/XtqwUISGohhSeCkDwLJrf3Hv2x8fEzGfe+OXTGPj
         iq6GbbUZrJ4Y7+yv6ABN3WmOYtOlaT5bYFs2wDcj2kmMC5j/wSMiYt59i6OHO3QQaUF7
         0HooPS0O650uGkhbj0DS21e/m31iKH1HX+JIPKBJ2jgS1P14dJtYxxbrHmkJf12OElMS
         mU5A==
X-Gm-Message-State: AOAM533hicui9hZERY6ogcOfnnlMvppQxCuFgPWX9AnbwpneEDFMHNFb
        pYI4FvSm9yyiQvM1z5COUWxbLQ==
X-Google-Smtp-Source: ABdhPJy/2U8YYV4YNHpz7d82RHXpW6/38q6C4Nxk6SHw0fG6egfg8QiynFbs+Y23UmRWLv4Pm6w1rw==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr8573435wmq.26.1611839763291;
        Thu, 28 Jan 2021 05:16:03 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id s25sm5861961wmj.24.2021.01.28.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:16:02 -0800 (PST)
Date:   Thu, 28 Jan 2021 13:16:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 00/12] Rid W=1 warnings from Thunderbolt
Message-ID: <20210128131600.GK4774@dell>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210128110904.GR2542@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128110904.GR2542@lahna.fi.intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Jan 2021, Mika Westerberg wrote:

> Hi Lee,
> 
> On Wed, Jan 27, 2021 at 11:25:42AM +0000, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Only 1 small set required for Thunderbolt.  Pretty good!
> > 
> > Lee Jones (12):
> >   thunderbolt: dma_port: Remove unused variable 'ret'
> >   thunderbolt: cap: Fix kernel-doc formatting issue
> >   thunderbolt: ctl: Demote non-conformant kernel-doc headers
> >   thunderbolt: eeprom: Demote non-conformant kernel-doc headers to
> >     standard comment blocks
> >   thunderbolt: pa: Demote non-conformant kernel-doc headers
> >   thunderbolt: xdomain: Fix 'tb_unregister_service_driver()'s 'drv'
> >     param
> >   thunderbolt: nhi: Demote some non-conformant kernel-doc headers
> >   thunderbolt: tb: Kernel-doc function headers should document their
> >     parameters
> >   thunderbolt: swit: Demote a bunch of non-conformant kernel-doc headers
> >   thunderbolt: icm: Fix a couple of formatting issues
> >   thunderbolt: tunnel: Fix misspelling of 'receive_path'
> >   thunderbolt: swit: Fix function name in the header
> 
> I applied all of the changes that touch static functions. For non-static
> functions I will send a patch set shortly that adds the missing bits for
> the kernel-doc descriptions. I also fixed $subject lines of few patches
> ("switch:" instead of "swit:").

Oh, that's odd.  This must be a bug in my script.

As I strip [ch], as in *.c and *.h.

Thanks for noticing.

> Please check that I got everything correct in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git next
> 
> Thanks!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
