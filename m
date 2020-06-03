Return-Path: <SRS0=tWTW=7Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E34C433DF
	for <bpf@archiver.kernel.org>; Wed,  3 Jun 2020 20:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFD5204EF
	for <bpf@archiver.kernel.org>; Wed,  3 Jun 2020 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591217141;
	bh=MaYhkSqTs0brGU+4OYifBjcvgPmRDYUz4IfpHn9sH2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K2HAhEZwZweDLEUSfW9IHTysaWp5Zejt9rkl/4+AzrCgIdoo6rRm0KS+QvKAX/FQL
	 sDJ1O6Gf3wfWFGIBATRsMfFjoF3T40s/ZfR/1r22r09AkIhh5bpOIt1QfrHcV2IoCL
	 n8e5jrLWR29AF9M4jX5q+O2x/BFwJ810DkywtkIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFCUpf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCUpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 16:45:35 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281A620810;
        Wed,  3 Jun 2020 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591217134;
        bh=MaYhkSqTs0brGU+4OYifBjcvgPmRDYUz4IfpHn9sH2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/LEzbm09Eg9EpUnql3JTyzehUogQhp/vIDO4gEAq3S7GBL0XS58N3GSe+lEzMHiN
         zuj0KGOTkO1inHnfVcJb/IG9HSlHUm1akkYI7dOzqattrcVl20c1wnwCcVUD+SDdeE
         JIWl2eNwmCitTLL1CjQHCBUNXHGeB5pVFwx9eJ2E=
Received: by mail-lj1-f181.google.com with SMTP id n23so4508629ljh.7;
        Wed, 03 Jun 2020 13:45:34 -0700 (PDT)
X-Gm-Message-State: AOAM533zBEeNlgRDZk3AvfCrtOVF8v+AbQSp5hO6x4INHfxpmCs3HTgL
        JW0BO0K06Ro9YwT6sPyh93amWUkaxTsZmOtdptg=
X-Google-Smtp-Source: ABdhPJwEFlFOcKTiaciLhFAqpj8efwYxB2qis8Sw78896hkjvJL6mLLXXOYEeUCNeVsb8Ws+Omndj05xF+8BXjlUCjo=
X-Received: by 2002:a2e:a377:: with SMTP id i23mr479833ljn.392.1591217132285;
 Wed, 03 Jun 2020 13:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+k7+fQmuNQL=GLLaGUvd5+zZN6GViy-oP7Sfq7aQVG1Q@mail.gmail.com>
 <20200603190347.2310320-1-matthieu.baerts@tessares.net>
In-Reply-To: <20200603190347.2310320-1-matthieu.baerts@tessares.net>
From:   Song Liu <song@kernel.org>
Date:   Wed, 3 Jun 2020 13:45:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6HtiLQdvyK8tHEH80xeurvQqdaYpFgdhd=yb5hDkB7VA@mail.gmail.com>
Message-ID: <CAPhsuW6HtiLQdvyK8tHEH80xeurvQqdaYpFgdhd=yb5hDkB7VA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: fix unused-var without NETDEVICES
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>, fejes@inf.elte.hu,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 3, 2020 at 12:05 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> A recent commit added new variables only used if CONFIG_NETDEVICES is
> set. A simple fix would be to only declare these variables if the same
> condition is valid but Alexei suggested an even simpler solution:
>
>     since CONFIG_NETDEVICES doesn't change anything in .h I think the
>     best is to remove #ifdef CONFIG_NETDEVICES from net/core/filter.c
>     and rely on sock_bindtoindex() returning ENOPROTOOPT in the extreme
>     case of oddly configured kernels.
>
> Fixes: 70c58997c1e8 ("bpf: Allow SO_BINDTODEVICE opt in bpf_setsockopt")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Song Liu <songliubraving@fb.com>
