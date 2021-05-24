Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C9C04FF3
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C1261153
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhEXIoZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 May 2021 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXIoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 04:44:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953BC061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:42:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so38225519lfr.6
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2MagAsqzQek4RfZIbzihBJ/AzdlKDWN0pczixUAk4k=;
        b=tuIFNpzC9jLms5dbs5QZzBpxUDBVkTZeQznojy2iUxzHuA/VqdRvv8KlAVBamdXkyQ
         Uzp7DTSR7Wd5NV5vs0zpAQpJ6Ao2K84Jn5zYdm6bGxV+4OiN9GK2MTia5PNFcX6y7WkY
         Tpo+YifiOcjlXZgnnn6M9I+GClyx8ljOcogjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2MagAsqzQek4RfZIbzihBJ/AzdlKDWN0pczixUAk4k=;
        b=Uvr9j+0xZs3NF431KY1++gSHH8J1DypzEXc3FcxAxFkg/GBrbicJQx/jFcWXkCJTSj
         Z9ILmqx3MUQIbQQYPI4JTEdlNJjDm3HvAIP19nVfd5FvjqaCZx69nTmt4XxihWLA03eH
         0GCmD81Nedl0NBJ4CeYtt8oyUfmTXDtHqLBOcPhecmEeIC12AHKL/ZkIeEBz1VDrL0Hl
         gjVRidsOXgHbPFdHgp1KU+GfS5Y7mF1Z6g3HguJWh5G+9F4jbtpncz68TwydesMSUkSR
         CQvVPiXN81lTVtDyopsNFisI7VPdmPuRQ95j0AtJhDXmfy21qW+djpwPomaryyLibLRQ
         qCbw==
X-Gm-Message-State: AOAM531qlZEVMbduDSHKk9lCtLW3ZKo9NwjntuhBFBpk+CfRbDksy8bv
        s+vPo77YtUXgb5zT+Y3aUo+OXh+YIXek8Rmw10LF8g==
X-Google-Smtp-Source: ABdhPJwDAJhJQ/AhvOx9lYi+OPMvHK3iBM6jwUMxjxkbO6Ny09AsZUdSaXH2I1z/XzdfkApRy31G4ouZTtt4UKdCYAE=
X-Received: by 2002:a19:7416:: with SMTP id v22mr9995140lfe.13.1621845774673;
 Mon, 24 May 2021 01:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <87o8d1zn59.fsf@toke.dk> <CAADnVQL9xKcdCyR+-8irH07Ws7iKHjrE4XNb4OA7BkpBrkkEuA@mail.gmail.com>
In-Reply-To: <CAADnVQL9xKcdCyR+-8irH07Ws7iKHjrE4XNb4OA7BkpBrkkEuA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 24 May 2021 09:42:43 +0100
Message-ID: <CACAyw9_Vq6f7neqrgw6AjJBw7ELa+s7u12Vnt5Ueh49gaE2PQg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 23 May 2021 at 16:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

...

>
> msecs are used to avoid exposing jiffies to bpf prog, since msec_to_jiffies
> isn't trivial to do in the bpf prog unlike the kernel.

Isn't that already the case with bpf_jiffies64?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
