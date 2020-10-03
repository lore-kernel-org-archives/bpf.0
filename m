Return-Path: <SRS0=nNHG=DK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C95C4363C
	for <bpf@archiver.kernel.org>; Sat,  3 Oct 2020 02:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011E72074B
	for <bpf@archiver.kernel.org>; Sat,  3 Oct 2020 02:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruf6hQHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJCCZP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 22:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJCCZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 22:25:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035AC0613D0;
        Fri,  2 Oct 2020 19:25:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id q8so4150992lfb.6;
        Fri, 02 Oct 2020 19:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyguNtobI9WGxfG7UGTdEWOg7CmimW/i+6rbWemku+M=;
        b=ruf6hQHbNJRK44HGElMyMcLWnS6gE1a5Bnk3BBiyVcYk0kcVwAcOWdApGrjCFMJhCo
         D//C8nTa4Z4gpom5pxoxR+Tgv/y/o7DYqn4V9T8gZKceqX51vy219lv+mtqfW5Uj0sLO
         jz6NGcha5LozfPw4EsOPRRHWP2rtYyrDYUhIqK6FJ4Q0vit/8C/kGwwuFBdx3XqTRb45
         2f3/a70rivpfqI26BeTVT7nvcn0voNHf78UW8BbAGnMkeSnd6CIAZMr4ri5xjXxRcbn8
         AJbX6XQlH3/OtpQsPBkiTlwLDlTDlp3QL34hlfvTga2PfFVIfq3slpO+byagUk4+PsMY
         wsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyguNtobI9WGxfG7UGTdEWOg7CmimW/i+6rbWemku+M=;
        b=r2aI4YypfhFffzj/TKRSxLaXPeO89ASVsVoR103oFBWxabQ0m7a+AeOwX4CJt+KfZJ
         doiIqWWXfVhqhP0JDKsNqqlEVOOFCpQw5lqLMgaIN08+73hWegQfwRDjdDut1ZvSdg2x
         X3kjaCRn1uMjcdc9D3CBRih0fTY2NLYpMF6u2BYhRGRYghQ1yN4ZxSABj0DGkNnf6ZRL
         P1KWyodnhx0iBug3df78lfpkpTEqKoL9EfZYnHAVZeFpgHzgJr0N06yidjbW/hXax0f/
         /BBc+Yrjyg0DP3XW2xeU+7LwjxcM/7HkO2hY57i4WQdJLpFTufdLr9HPbw89uuUNj65s
         JEAQ==
X-Gm-Message-State: AOAM531+j+T6MqTdWx53PJAlJQAQfV/wYSqG8R0SM3H3w5VwQ+FTZUnK
        00aAwOewQslSGrGu4/xHu1iWUvG7VIVXyM3IekM=
X-Google-Smtp-Source: ABdhPJz7g9aDzCuLyh8mNm+kG5EO1pjHFuGg81CZhR2tS8bGbXsx1KwFSfF3RsJ4UeEenYrKub9MvlpvJoUMGx9oqlE=
X-Received: by 2002:a19:8703:: with SMTP id j3mr1951823lfd.477.1601691913168;
 Fri, 02 Oct 2020 19:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201003002544.3601440-1-sdf@google.com>
In-Reply-To: <20201003002544.3601440-1-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 2 Oct 2020 19:25:01 -0700
Message-ID: <CAADnVQKWw_GOd=hS6dSmXFA5Z252irr3hW45UkSgmjew+-fHRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: deref map in BPF_PROG_BIND_MAP when it's
 already used
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 2, 2020 at 5:25 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> We are missing a deref for the case when we are doing BPF_PROG_BIND_MAP
> on a map that's being already held by the program.
> There is 'if (ret) bpf_map_put(map)' below which doesn't trigger
> because we don't consider this an error.
> Let's add missing bpf_map_put() for this specific condition.
>
> Fixes: ef15314aa5de ("bpf: Add BPF_PROG_BIND_MAP syscall")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Thanks for the quick fix! Much appreciated.
