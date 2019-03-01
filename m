Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA4C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46EB206DD
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJq+zpX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfCAGgJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:36:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41212 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfCAGgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 01:36:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id y15so13667835qki.8;
        Thu, 28 Feb 2019 22:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wci2VGxWktEsMf2jUINHbXLI5CqPUf30cuE5HyZnKU=;
        b=MJq+zpX/GgAG2Ogb7MMHT74yOF0EIGOEWtStqzqV5aRfPD13DijzaCvbnjmFBUXeIn
         iyrEN65KgSxy3m5sxGvOsO3W8kjaCzZJluu2mR5RYsQliWBiyYrjIPQ2B15jhSIEfEoT
         f486G5hblGaeCOMMON9TCSD/cQZ4zbcyv5RT2NQzuUIIOR08ozR00E4MgBm/wcwM+wdd
         RWDn7bKd2xN9aoiHZ19n0cTiow//09PUiFqfG9r72N6JsQ4wEf4+uyn8fl0oDhnHQ82T
         57CkLtqde9TzPy3/fN+62tPjIXBQ2rTdY+yTu+36GztmHFgZycERMYmGzJea3Dy6pxye
         HHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wci2VGxWktEsMf2jUINHbXLI5CqPUf30cuE5HyZnKU=;
        b=Yo4rVBojeP4vL8Q8HZYogTkpz8D329mliCLeG59+faFFkqlJ/BVVaEQ12y8uIBZ3Dq
         4t61+FqfQkNjrjqaB1E/zANMHE3WntXv/SKwgsXbnbnC2EUgFcJCmRN6r6v/KB2IISX9
         N1OfYR2by5McyKdZQmSVmJp4XiM14PAtQTGZv2ETNBrSHfn2asvVo5QUFg5sZIcKzs3D
         Qs4PqT7YslgHIyQL9bM66apWiC+m372uMGtQ4VXDlFstiEaXHPR/lroTUUyKSPGsSH3s
         Up2dRx/hRHzEnRXjCwurl6yrjQwRZm5DAbscYwPJ7Rp6vqDsU5CtUc9jHRGUDWo0z1jZ
         pNFQ==
X-Gm-Message-State: APjAAAUmO2IWogs+2A0i3jmtG1/uhqo+E5Vxfs0EK7V915Zt0NTHkQxV
        hLy7fb3MlyWQZkSH/Wyro+3zkk6QB/Y1UUiupN8=
X-Google-Smtp-Source: APXvYqxmRsv5EEjH+iaxFIsJhypphEnoTfmGIVHa5ms04UfhDkIViLYvXif85S+QnD5AoEuen9cMyw/ttModLd7Ivlc=
X-Received: by 2002:a37:a38e:: with SMTP id m136mr2618779qke.120.1551422168023;
 Thu, 28 Feb 2019 22:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190301013716.1370014-1-andriin@fb.com>
In-Reply-To: <20190301013716.1370014-1-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 22:35:57 -0800
Message-ID: <CAPhsuW7LG7VHYN4ujh-ztrpFRE-Y0wCVht5-=0SJuq4A4eVw0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Formatting and typo fixes in kernel/bpf
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@fb.com,
        yhs@fb.com, Networking <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 6:08 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Few formatting fixes, as well as some comments clean up.

For the series:

Acked-by: Song Liu <songliubraving@fb.com>

>
> Andrii Nakryiko (4):
>   bpf: formatting fixes in syscall.c
>   bpf/verifier: fix code formatting
>   bpf/verifier: typo fixes and reflow verifier overview comment
>   bpf/verifier: fix minor typos in comments
>
>  kernel/bpf/syscall.c  |   5 +-
>  kernel/bpf/verifier.c | 169 +++++++++++++++++++++---------------------
>  2 files changed, 87 insertions(+), 87 deletions(-)
>
> --
> 2.17.1
>
