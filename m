Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B0C10F14
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 03:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1B42075B
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 03:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/o62MW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfDQDPd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:15:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37298 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDQDPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 23:15:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so13313387lfl.4;
        Tue, 16 Apr 2019 20:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kaazt4IZ53XnaaRBF/3SbnXSUpPXNhOpZMLGAmaioFs=;
        b=Z/o62MW2QN+Bz7tyaz6KIUjBJkxnO/X8I3orG6Ytb4PwXfR5af3kJIgkmUw4x2RT5z
         HP5X1sY8QHgG20lQxdc+yHPMVXvWSYRGzcAYBfRLaaL5qkROzHJ7ajFFmBSeOlE9p4zx
         +1od4c/qOiYfNK86axi4lWzzp5bj852c/nuK7TYgI+jyR0pWV40K7Tsgg+q3tFPBEgYT
         8wkjdx1ECQ9FgWrUWqVokKZHeAak07SsT5XrgfRuiEVAmUt0ZrcXisxPhvQD7PWMmygE
         4r/RFZJRSERVi9TRecqz9ZvLBocFwwBgL8JiAGRidXchyTdgmCSnwYnwY249KaQbtP7B
         9QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kaazt4IZ53XnaaRBF/3SbnXSUpPXNhOpZMLGAmaioFs=;
        b=e9oK3myLqmDj6LUtB2zHnmar5vol9UNaFPCKgAVHWcx2YJJcqkU3PkTbpHzlFwIHUf
         s2lupCy1f9sZkACcUysm4qfBnXL3feoeYRLV+s34JMCvQeCr+vcsLWneDLoHpf/gRbFS
         WN+gG2oC0Yxlln9bX0poobIYTThrf8JS0PrThHeqdrVBEu5STOVMqbgkWJ20Ov753wCL
         sF/OHUmqpVJFavf4IgMoM1HSnXDarnjRckStaVeQpWXr9YSlqcq69Zd5yauJ/H8+cVR6
         N0bN4N+HcAaLT8d8NaAv+cBH611KPJS6NtrQugSzJzFxVSa4KOS7Lhouc4C5u0lXS893
         mO8g==
X-Gm-Message-State: APjAAAWAB6Ojn9YVj4+NLYwGs/SAz0DfXPyipxh0NysLU8DKwZXrw2Ng
        adta1JrCYywI6oAVrs86xn7/FhlMEfs45J2tv+rR0oM4
X-Google-Smtp-Source: APXvYqwAlvAhQ0/D6EiE2yT9wl3U1rhqBJ/3jKho8cvTFyUr9oN9RflUY0THtwgP/6Mt4HfP0blYWmMn35tjzS6JwrA=
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr4354906lfk.126.1555470931430;
 Tue, 16 Apr 2019 20:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 20:15:20 -0700
Message-ID: <CAADnVQJdSHQt=bmDhsRPrBHA=itLAQ8fVKRDE3Maam7UMZYrXQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/5] libbpf: remove two dependencies on Linux
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, bruce.richardson@intel.com,
        ciara.loftus@intel.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        kernel test robot <xiaolong.ye@intel.com>,
        ferruh.yigit@intel.com, "Zhang, Qi Z" <qi.z.zhang@intel.com>,
        georgmueller@gmx.net
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 5:58 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> This patch set fixes one bug and removes two dependencies on Linux
> kernel headers from the XDP socket code in libbpf. A number of people
> have pointed out that these two dependencies make it hard to build the
> XDP socket part of libbpf without any kernel header dependencies. The
> two removed dependecies are:
>
> * Remove the usage of likely and unlikely (compiler.h) in xsk.h. It
>   has been reported that the use of these actually decreases the
>   performance of the ring access code due to an increase in
>   instruction cache misses, so let us just remove these.
>
> * Remove the dependency on barrier.h as it brings in a lot of kernel
>   headers. As the XDP socket code only uses two simple functions from
>   it, we can reimplement these. As a bonus, the new implementation is
>   faster as it uses the same barrier primitives as the kernel does
>   when the same code is compiled there. Without this patch, the user
>   land code uses lfence and sfence on x86, which are unnecessarily
>   harsh/thorough.
>
> In the process of removing these dependencies a missing barrier
> function for at least PPC64 was discovered. For a full explanation on
> the missing barrier, please refer to patch 1. So the patch set now
> starts with two patches fixing this. I have also added a patch at the
> end removing this full memory barrier for x86 only, as it is not
> needed there.
>
> Structure of the patch set:
> Patch 1-2: Adds the missing barrier function in kernel and user space.
> Patch 3-4: Removes the dependencies
> Patch 5: Optimizes the added barrier from patch 2 so that it does not
>          do unnecessary work on x86.

Applied. Thanks
