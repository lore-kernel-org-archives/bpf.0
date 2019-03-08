Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E6C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A920857
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDpA/ghu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCHTkJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:40:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39661 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHTkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 14:40:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id b4so16760522oif.6;
        Fri, 08 Mar 2019 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+7XuQZQKiOPPSQOZIBYwN/V2ZCVmJOm7wTelezrdws=;
        b=NDpA/ghucr/9DFU5bPlqrinRlLBQjlFwcTEEvVft9s6f7qH+upqvaxdEaMpWi6dyOu
         2Qe9E1zkq1r+Fkm7IyqvH0rg6Jknfeuv5FML+yNo8fHqTWasKLrDsItcDSqZR3hp0MEj
         aQdGYFMRDwvkoLXLOtYvwpwOQJCAAkM8byjk0PeyIyPHpFWxTqbYPFf86ikHVO3sXjzt
         wg0oAoijwgAqubOxXHPWY4DP46S896NgoYgnt1a+rwyZLd+OmIM+ay8uIisSIRMbB6X8
         3SfsGK0a3NN9NbcHFdyMYSFtCRWTxnRtQhL86Bf2lbwcXS2BjrHmVlzylBCZNc0F1RzX
         iQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+7XuQZQKiOPPSQOZIBYwN/V2ZCVmJOm7wTelezrdws=;
        b=qq+wLHgTiO921wXYz9+2OiiZmPtMHOQjGzXvZzpQcBmz2yblrdABEUqqmHgBusqbxT
         cWtQGeXbjZ48b8sXGZm3YWQtaSorKI32lnP+llGpOg7+iXNq67X6zQhVRQHdZT/zGLVk
         tq63O6DyTziF42xhCTt8bOYbxJgIZKN44G7FMQEqrf390pwBg9WjtUrV1CaVhDEMgag8
         Pw8/cG/Y+1m/rasAgQUKquDnW5Kp/X/HppHRBm5uc7D/J8jUO3EDWdSurKOfoO8qQOnJ
         1KJeuV+mtacTyBVHL8iC0TT0VcA4ydY6iYMjFiCe7NDNU+y4FgH0Zevy5CLZia1FLIX+
         JkTQ==
X-Gm-Message-State: APjAAAVk/9f61X9q9T8/T0SY2gqfQYE1XnnuQJHin6tHGsiGs0qvKz71
        /cf1m/3HlEQCnXUKzZPnV25a/NNW6o+z0KdXpHc=
X-Google-Smtp-Source: APXvYqwB26QslN2KPHzPZXXVzJ9X5fuF1qUZtp5PFYcs+QDUIi8El9N52NxvTAXx3V9ZW/it/ILkK6gFAcfWQQJcNbc=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr9452558oig.27.1552074008487;
 Fri, 08 Mar 2019 11:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20190307002321.4071708-1-andriin@fb.com> <20190307140247.GV13100@kernel.org>
 <20190307140917.GW13100@kernel.org>
In-Reply-To: <20190307140917.GW13100@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Mar 2019 11:39:57 -0800
Message-ID: <CAEf4BzbLkwhCSb1i3cGJJh=OJ-_+53Q+hnqhqp96+fmj9B6aLg@mail.gmail.com>
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within CU
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 7, 2019 at 6:09 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 07, 2019 at 11:02:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 06, 2019 at 04:23:21PM -0800, Andrii Nakryiko escreveu:
> > > Due to this assumption, libdwarves and other parts of pahole are using 16-bit
> > > counters to iterate over entities within CU. This can cause infinite loop when
> > > iterating BTF data, if there are more than 65535 types. This patch changes
> > > non-public variables to use 32-bit integers, where appropriate.
>
> > Ok, there are some bits that are unrelated, I'm comment on it and remove
> > before applying.

Yeah, thanks for cleaning this up! My intent was to convert all places
where we rely on uint16_t for things that potentially can overflow (so
not just IDs) and are safe to change without binary compatibility
issues. I didn't intend this to cause you more work, sorry about that.

>
> Ooops, see below, I'm removing the non-type related parts, and will look
> at changing the types till btfdiff with that allyesconfig aarch64
> vmlinux image shows no diffs.
>
> - Arnaldo

<snip>
