Return-Path: <SRS0=d63n=DB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95157C4363D
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 02:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8172223E
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 02:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="va0e9AIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIXCFz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 22:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXCFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 22:05:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7DCC0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:05:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h9so1194327ybm.4
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frYh6tAYSKOqElnsqf4rl/3lWHPEP+L0ux8vp73dqcg=;
        b=va0e9AIO5rSRoeD8VkcDmdKDZKrLDY9nKOcVCtxkQMsQenEhCDIPw3WU4oXdd+rjLa
         TNlADA3YQSMAsJ9ZEf5bkabcYeuqNHmZTeSONY2utWXnm5YZaMEqx77VEdHyT7KCg2G4
         7DAj+LRogWEtJJkgS5E6DSPKLr5M+6C+84cTk1wZzV582dBrMX+COtyBPyH3LAmUpuKt
         uGRG2ZPI7O6tyQG2d15tU2ypmJDbIkLPbDjRJQLblbVlLeIv3/LQTNOv9JLUGfNlc0y/
         JUHzLa7JD+q1vCfvtUvfVyEmeBwJIdeO6rq0eQ2ECTcCmy6I6DyzZzcxaAKTGWoc7n+c
         sWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frYh6tAYSKOqElnsqf4rl/3lWHPEP+L0ux8vp73dqcg=;
        b=NXJwaW/oTkQ+c3oPmhkJAoUm8Y7W/i9f7ekSJeFbOUCXe1GDWSFgRcsDZTuzOMLuhd
         C1C2B1pUBIb+RG7j/WUC7C5xM8A/2hN3quv5HU74/xtAI1QV0dTJ0fpMoQ0xdePFKbg2
         u2txZkvQ7fFXnBGPdUPOfgqG0F0dnPbbdlRiafvefh8Bbf+WELYVsodcwBzpJiQL86aZ
         8qUI+J+a+sUn0uTdC/aZGSl0WgW+UbQYuFujpcP/iGtvSd1pM34OmK5UsiMQuvuop9WY
         JeWslFPtURsKQp486hzrG05q9MYDYBgE7jFoTqWRa2QW9tMkeObBHhPuQbQvuz9sMmI3
         c69w==
X-Gm-Message-State: AOAM531fn5uY0+HN75E4plJWOFWdrQUqY2TlpwANq73DIq/m8tHwhU6U
        WW6khTMlZYMWzhIW0+s5QpdDEx96oYIEoY1a6kQ=
X-Google-Smtp-Source: ABdhPJw9PWou6hCBKKX9rVefsrrV2L+kBFjPIWcO+Q0DYP76bTYFkIn3fdbRo1AdHQUomTQt6skyGUpeC0QSEG+nMj4=
X-Received: by 2002:a25:cbc4:: with SMTP id b187mr4083159ybg.260.1600913154443;
 Wed, 23 Sep 2020 19:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+phbXaN-X5WDBWX7i5NZhs_acRhXBxea1ZFQrwK29bcQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+phbXaN-X5WDBWX7i5NZhs_acRhXBxea1ZFQrwK29bcQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Sep 2020 19:05:43 -0700
Message-ID: <CAEf4Bzakdg_u0yB23RCLCXespyjU4jrt6rFTjQhngwVVVtQ=xw@mail.gmail.com>
Subject: Re: flow_dissector test is flaky
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 6:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi Stanislav,
>
> looks like flow_dissector selftest got quite unstable recently.
> test_link_update_invalid_opts:FAIL:340
> bpf_link_create(prog1): Argument list too long
> #33/25 flow dissector link update invalid opts:FAIL
> test_link_update_invalid_prog:FAIL:400
> bpf_link_create(prog1): Argument list too long
> #33/26 flow dissector link update invalid prog:FAIL
> #33/27 flow dissector link update netns gone:OK
>

I've seen similar flakiness for cgroup_link selftest that used to be
rock solid. And it just clicked when I saw this, that this patch might
be a culprit:

https://patchwork.ozlabs.org/project/netdev/patch/20200917074453.20621-1-songmuchun@bytedance.com/

It makes bpf_link detachment delayed, so now anything that relies on
the fact that bpf_link gets auto-detached immediately after the last
link FD was closed is flaky. But that is a pretty reasonable and
convenient assumption. So can we please revert that patch? It's a
really nice guarantee to have, while the benefits of the fix in that
patch is a bit ephemeral.

> It's failing for me half of the time with a random number of failures.
> Not sure what happened. I think it was stable in the past.
> To reproduce:
> test_progs -t flow_dissector
