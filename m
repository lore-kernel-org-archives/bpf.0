Return-Path: <SRS0=MPUm=CF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E218C433E1
	for <bpf@archiver.kernel.org>; Thu, 27 Aug 2020 01:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F1B21775
	for <bpf@archiver.kernel.org>; Thu, 27 Aug 2020 01:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJwPhgwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgH0BYV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 21:24:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E1C0617A4
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so4524011ljg.13
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=SJwPhgwUnUn2mBarnoa9bYz42e0tKRZQflSAKfXVW+1WuaJWh+0RePI1uNHutnyd2A
         YtVQxlK3Ffu4N1UF5nmbSAY8tUkVP/fRLD1G6u72jYG2ksFuQncrACVRRuOt6NpKvUPv
         fFXWzySHC85dONXfxUUAVinyHVrTxzc1msjDoirhDLNmiEGqoml2RaLfP/5L37cUSmEF
         2x+SKK69lCzSR0Uv2KNHpby9FLNCjb7H8RSlrh0dQvGgW+FHpK2t/Ozqil8Gfn1CgePU
         jjPFsyRGDg6X5bOe51QDiLaAWrD4UjhlZUsnCBSu2IvNakzMXZJxI7xDxSFVtk9hclHh
         Ey+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=mpZjCcdnJpgTHIwpOUJXDV+0axZ4thmIl5mWVdhzEAbcv+bpAN7cV+d9ldJQhwGDo5
         j17PDoxuM8YNFGBbS9RD7HQpAZR828PgO1mDBcQxRgGijG8bk60qfLGCXvlwcxqu+iyV
         dxI8hGTgIbLVVIt7jaLlfBmfvvjA1JJLeWyaUlQnm0u5BFDZRXq1OeY9ZNFCD8WTfgAO
         9VmT4Mv0fpclBGt9QD2Vyp3Shqz9gW5RxMn3qKN1bSeFig5yoe+15v2mw9e//Fv0xHcV
         YitMZ3kavVQF+jdkDj4fkMV00Hv2bHYTh1PrJ2HWpIVkN4npRuUqUXrdi9EC1mMxhsZ/
         LnvQ==
X-Gm-Message-State: AOAM530Xjw2pi/VoO2lh9Fq+0CfKkEm5QdvaP4PkRl5uJZz86Lf87RMY
        EgsIETdWjPGEpIIG3uHzf9BwJhADW3uS04jlbLo1kliaAi0=
X-Google-Smtp-Source: ABdhPJxgDGcNP9DxOQTWxsXv8cwD05YmMvT1hmUzl2euif9r0/9glXhCkah+fd374MAxguSaIYX9w6tni5KTkeihFKQ=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr7665336ljf.58.1598491458086;
 Wed, 26 Aug 2020 18:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-6-guro@fb.com>
In-Reply-To: <20200821150134.2581465-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:24:07 -0700
Message-ID: <CALvZod5Fb50fVSC9XaYyQ3awjYU8sc4-VYh66z4U__v5Pfxd8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/30] bpf: refine memcg-based memory
 accounting for cpumap maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:11 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include metadata and percpu data into the memcg-based memory accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
