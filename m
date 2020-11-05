Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A440C388F7
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D532078E
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 19:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVQhIMUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgKETHj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 14:07:39 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77CC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 11:07:37 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s89so2256326ybi.12
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+tlFswFMbIVLUEcIpuVupMGF1ehzUzL2QP6B24dd+M=;
        b=pVQhIMULF1hUYDolaloWBA6RpRQTFhBG+myKKd9n7YK9FbTkzi+3mhMBmCDQf4lRV+
         bD2FMngL6pPYsY+3mAEHTyI+5OdjAsBOg2xsgNBJtui3lQw0oKAeOvze3Ll6ZtAClJ+b
         IxisPea8/6O8fpnooxQmAQuxHIwfzsOhrIAdCefhIJ/kR3Mwc2eZxPk7bt4wdPr1uHyV
         +Vo8OfZRT6ofOXFd7qqy6UcmoSC7kh+UroJIicbGllVvySngV7wYxx+4iWZtCtbbrRLY
         +brwq68+3VsuGtXDYtWPxnVcKbNnlHnbD8VSJx4z8ZOnXmtHDdRJVq57ZZcIOO+5kCZr
         XD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+tlFswFMbIVLUEcIpuVupMGF1ehzUzL2QP6B24dd+M=;
        b=rQuZi+vq/wWjn3ysga63o2m6iIvqVJpmWkHyR+AkszbWE0qxpcvCtaeybvY7CKsx8b
         Rx/uwX08ZlUad47TKo9i2H/l0fmNTf1b1gVvXF7KqOoRHXC1C4ou6udfOpIv0ceae8cb
         n+5GAg71N1wz29KPjYaaCsiKXIsnpQGjtFJY7Wll3mNqT4OvyWiQpO/NCsVYC4y/jHNl
         zLnHZmK4W8l0joeh6W3+f5FNYRWqqPN9cqtb49YsUgfp/l8nZc/+hFax7Jq/6Fhbrhcn
         eL62AGgetXKChvso2GSdm2z0cYOQxkssVRi8c1qEZXThvIyA79ZnCZxs9HNbogQfUyyA
         mTDg==
X-Gm-Message-State: AOAM532s0zDhCelkUCtZwQMM2C3VIykbJF19MKBTy/7o8yCuzqjANm1S
        bPi8jDnpDKDNIkNw+MxI+c70pI9swqI7JqsjdOhoNTd/d6dNfg==
X-Google-Smtp-Source: ABdhPJxApnnAXAIv48VNgYupQd7YWDVDRzrOwj/uoZYqGzt4+9W+ItL2eYWogOMQTKEFUQDT9wnp+/n8MB/898m1WSk=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr5586216ybg.459.1604603256235;
 Thu, 05 Nov 2020 11:07:36 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR8303MB00802FE5D289E0D7BA95B7DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
In-Reply-To: <VI1PR8303MB00802FE5D289E0D7BA95B7DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 11:07:25 -0800
Message-ID: <CAEf4Bza0unqU9QWBtuh_y07OGnC_HxOK_RwO+UTJ_0XhQdm1Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Update perf ring buffer to prevent corruption
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 7:16 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> Resent due to some failure at my end.  Apologies if it arrives twice.
>
> From 63e34d4106b4dd767f9bfce951f8a35f14b52072 Mon Sep 17 00:00:00 2001
> From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
> Date: Thu, 5 Nov 2020 12:18:53 +0000
> Subject: [PATCH] Update perf ring buffer to prevent corruption from
>  bpf_perf_output_event()
>
> The bpf_perf_output_event() helper takes a sample size parameter of u64, but
> the underlying perf ring buffer uses a u16 internally. This 64KB maximum size
> has to also accommodate a variable sized header. Failure to observe this
> restriction can result in corruption of the perf ring buffer as samples
> overlap.
>
> Track the sample size and return -E2BIG if too big to fit into the u16
> size parameter.
>
> Signed-off-by: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/perf_event.h |  2 +-
>  kernel/events/core.c       | 40 ++++++++++++++++++++++++++--------------
>  2 files changed, 27 insertions(+), 15 deletions(-)
>

[...]
