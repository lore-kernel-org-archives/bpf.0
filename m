Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F928C49EA6
	for <bpf@archiver.kernel.org>; Thu, 24 Jun 2021 22:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6C96023E
	for <bpf@archiver.kernel.org>; Thu, 24 Jun 2021 22:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFXWll (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFXWlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 18:41:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B72C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 15:39:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r5so13029057lfr.5
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 15:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ozxg8ZJNuqm0z8dn4/CfM5o7i+4Lxxs8MOPrX4hG51E=;
        b=QsCUvB8gEGJZHSU3JIRnVeXdvl8SH+SoDqRUGvUhfdW3ocKoVJb2eihlhRphRIqNw2
         jE5sE15e9XyPTbIcs4MTNO+ycbcyRao5CJ/0hwyCjmiZjFKOPehwqvzTL8jouv4NB2KN
         2GzdVmqknb5DgbCEFRuKL1NNvK+NLYencHI5uIADkqtLvUKDUzAFe3QEbicpl3g6jXzK
         3YWuwShANTvsp0HdfucAmJjQ3ndl+EzJ3vSXkf4O9EFD4ZsllvntX4xdco8ELPjuv7if
         oETqzqCuta4lKS1ib61dCmb73Q51Ez1UGW4kwBDFX+Wse67BBh006zXACqyM/II4lYkS
         vbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ozxg8ZJNuqm0z8dn4/CfM5o7i+4Lxxs8MOPrX4hG51E=;
        b=ahMe06yAJ0pVGXyWKR2Q1ORoFmQ9mYZ/GvoSVE+KzG6eZ2aYWWTJpBMUh/radU9Jel
         Uf0L3mlu53pjqk7hlyeYIRvd8NpK9VGV9m6CNeCYeSxOAq+B44JE0jt8nrGdr+qM8RBB
         iiJ07izblC+nupwzPvFDNtIFYvsO2k5/XnTLfjZLp/OHAwgwcuB8BFFamAAfhfrmEa8z
         JCI1RpZxVB2XjMv2Yx7GOUVQyEWf3RlHqs0Yexa+cZALIOEBPpjTMBakWHTblkFrb2ER
         4wUdgkUWbt91dm4ATYrvU12WNbGco2yxfCcvuuK7kO6TQfwap2opGjBhgotJLIpN9Fb0
         lhHQ==
X-Gm-Message-State: AOAM531pN7+nujZJjeKMq0IOxhRPRGUq/Ie+9ekmjEbJgDmlsgKU0wjj
        UwEyMHDdAg+9FINQO0FYU8hsCr1YCEw0L5qGnTo=
X-Google-Smtp-Source: ABdhPJye2tJkWfWMF3o+gt7OqrkK+1KTPh00r99yeVTaCu0Ug3DynSRoa6f7cTnT4RQSmWUwZMmKpGl0UASxCceGSHQ=
X-Received: by 2002:ac2:598b:: with SMTP id w11mr5720117lfn.534.1624574359025;
 Thu, 24 Jun 2021 15:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
 <20210624215411.79324c9d@carbon> <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
 <22999687621ecba7281a905a3dbbc148fee12581.camel@intel.com>
In-Reply-To: <22999687621ecba7281a905a3dbbc148fee12581.camel@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 24 Jun 2021 15:39:07 -0700
Message-ID: <CAADnVQ+7mJhWzFR45n8RsFmo9M7UmumVRTQ7k+jH=fTr-5A4gA@mail.gmail.com>
Subject: Re: A look into XDP hints for AF_XDP
To:     "Desouza, Ederson" <ederson.desouza@intel.com>
Cc:     "brouer@redhat.com" <brouer@redhat.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 3:18 PM Desouza, Ederson
<ederson.desouza@intel.com> wrote:
>
> Wait - it may be done in user space by libbpf, but it needs the
> instrumented object code. It won't work for pure user space
> applications, like those which use AF_XDP. Unless we're going to build
> them in a special way, like we do for the kernel side of BPF
> applications.

It can be made to work. See my reply to Magnus.
It's not a lot of code to make that happen.
