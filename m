Return-Path: <SRS0=dppq=5N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBDC43331
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 22:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68E720732
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 22:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DFo7Iydl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgC1Wa0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:30:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgC1WaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 18:30:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so16339719wro.7
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXJuf2d61/8VVRTPBrmoNd9kHkfvBJR4eW3rH5y+FIU=;
        b=DFo7Iydl8YwLfZxc2DLYtdcLmKa0XDIFKr95+X2iKt8uf+XyU60KPDk8AaAr9fOWP6
         16L/XsZ1lN7J4YqSsAZCHcGs8P3OdQtLqKHaYOTN0ZLZUHikJvcjESR1TIa+idWQudiY
         pR4TUEEW51zfyzcbcyulaG8fqY/4+gJMO2x/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXJuf2d61/8VVRTPBrmoNd9kHkfvBJR4eW3rH5y+FIU=;
        b=Af5BeUBQmIc2Kyd+WCHf9iGJS4tCNypBOn61dMthpyCzht3AMULV4wvWlgkZWp4WQf
         UoBpzJrQKIGga/z/tylaWSlZ5nWMhZWinbtk8OE82jpywFEpjwrTcdk2P0s/VFRJliPA
         XuwidQ5G0hT3bauZnPGpGJoeF/5VVItFFlBnVrrfEO+t8ON7TYAFNuAqAjtgha2SMpm+
         Pk0HTHowjoK4vR0lIrqBezJx8ue4T9PSVfylviZjB3HAcDaFqngEuvseT7WZ3lfxnBCf
         Sjxj2CS8pzs0Vb1EN8qhqY2tnyMf+7N3xdmGeEsVy3hDbvXQGnWeiHDrmIl1DB5DQwvY
         i6Vg==
X-Gm-Message-State: ANhLgQ1K3n8aqd23Ixj2CJ1pNjZM2DaguoZ9NkDRW5WkucDl3gSDQZ77
        KpCxvPICUp0rvYSmdNtSG7IqkQFxVI0EnjwIVs2cgg==
X-Google-Smtp-Source: ADFU+vulCziRFDJbIJ694ouqZtPpGPxGPDaurIMchBqU6/L0KIgWi8FFPyh3yqIaaooUdMm1rEUFxDNgE/x8ObAMY5k=
X-Received: by 2002:adf:e48c:: with SMTP id i12mr6643082wrm.173.1585434623969;
 Sat, 28 Mar 2020 15:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200327192854.31150-1-kpsingh@chromium.org> <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com> <202003281449.333BDAF6@keescook>
In-Reply-To: <202003281449.333BDAF6@keescook>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 28 Mar 2020 23:30:13 +0100
Message-ID: <CACYkzJ4v_X87-+GCE++g0_BkcJWFhbNePAMQmH8Ccgq7id-akA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 28, 2020 at 10:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> > Since the attachment succeeds and the hook does not get called, it
> > seems like "bpf" LSM is not being initialized and the hook, although
> > present, does not get called.
> >
> > This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> > there by default as we added it to default value of CONFIG_LSM and
> > also for other DEFAULT_SECURITY_* options.
> >
> > Let me know if that's the case and it fixes it.
>
> Is the selftest expected to at least fail cleanly (i.e. not segfault)

I am not sure where the crash comes from, it does not look like it's test_lsm,
it seems to happen in test_overhead. Both seem to run fine for me.

- KP

> when the BPF LSF is not built into the kernel?
>
> --
> Kees Cook
