Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7312AC433E0
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3966F23359
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhATN0O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jan 2021 08:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730509AbhATNPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 08:15:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4201523359
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148479;
        bh=/Dib82sU5arH2pQ+ODWj2A/H3qlrgt26ReauOPltmfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A0ujDq6LP+USWQhT5cpJn2rJU+bT1xQmLFDRgP2HuT6cSDLJahRAshL0DZUkmaEV9
         RXwHGyhwsktLXiJnVyaMk40vcrfpo44ydNOx5rTHSlcyls0bcSiq5RdSmsXJFd4Dii
         qMjB4mw7U6AHpmbhbHzCcSA2ducAd1fLHoOPVjw/GACi4Mk/u2llEGr0XfqngMQ1mA
         nHyLeMEJNZamlYwRyOJWZ1duJwn4n6fdAgBZyF4iRjuijHMDehcVRRqldb1mJxuU7O
         L6uLiOaruevwG4XaPRaBwQkpW/hhbzlmUknu6qR5YwTTfYEIzVeZx6YqONRh+nbq6E
         rG9b6fL40TK3g==
Received: by mail-lf1-f50.google.com with SMTP id a8so384629lfi.8
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 05:14:39 -0800 (PST)
X-Gm-Message-State: AOAM530/vMD83s3iUZkIsr1p8dpvYFkxoI6N8ZD7SGu+82nMIjSg8mUZ
        iCqw1AEnibxJ8TaZXUxAMg5Io+52VX4/yXNZfwDxog==
X-Google-Smtp-Source: ABdhPJwawW11X5iYWnsm7L16MlX0ajtl8yyrregStk3UhMSaOYlPVR4hFbvlBPmgF/Zt7P4AaTVWXn8y9EekG/OQR6g=
X-Received: by 2002:a19:4941:: with SMTP id l1mr4149690lfj.80.1611148477497;
 Wed, 20 Jan 2021 05:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org>
In-Reply-To: <20210119155953.803818-1-revest@chromium.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Jan 2021 14:14:26 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6Sar+BQELJtTRdAhFReEpusa48N_7QDnMnXzBxcJC7kw@mail.gmail.com>
Message-ID: <CACYkzJ6Sar+BQELJtTRdAhFReEpusa48N_7QDnMnXzBxcJC7kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Be less specific about socket
 cookies guarantees
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 5:00 PM Florent Revest <revest@chromium.org> wrote:
>
> Since "92acdc58ab11 bpf, net: Rework cookie generator as per-cpu one"
> socket cookies are not guaranteed to be non-decreasing. The
> bpf_get_socket_cookie helper descriptions are currently specifying that
> cookies are non-decreasing but we don't want users to rely on that.
>
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: KP Singh <kpsingh@kernel.org>
