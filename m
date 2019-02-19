Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0467C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F10821773
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 02:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlAAgicU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfBSCo6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:44:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34733 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBSCo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 21:44:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so31884563oty.1;
        Mon, 18 Feb 2019 18:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dlomt5XHYAK/UUzJqInZriXmoFo6+Mmo0BnHowwY/KA=;
        b=HlAAgicUkPJxX+f9z8b3gxtxxPyO4pRHxttPvSHxRKGjrWgIJHdekf6oGNtAUyjY31
         ppqQMgxwa62AQCnD4kR1OCa7VCZj9XXfbmiaJ8FH/Ce5/b7rNFkRvVNlwGKjV1/ynXNu
         7Kfuh72Z3I6Yr5HpdViyKcMPB62xbvXZc9VNbMagtJE3v2OJKMNdlfcwHmHWG4OOLJcK
         aTFMD5yxAVPwygmRqR1s8P3kSAU4v6rksMF6yW2uQNFD0EIvKDGqmyaV6ucJ27H6Tros
         umDE1kjboTlEe7lu4KgdoukBeqiWGwjoB0QXkDlqlIcT2ts5hsvM0330Ky8IeYQY4Z36
         sF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dlomt5XHYAK/UUzJqInZriXmoFo6+Mmo0BnHowwY/KA=;
        b=JIQb8Y3Ont9m0fwnu12vzrXlS37vXybB3Ryq2mZoNV5z0Q2al/8dUcKjKU1XRRRolu
         YBD1yr5/5Z+/7npCaa/rdxTOxt8BCeH6V15RTjg6/Q1ef5F4OlshZlWovRUV59t2tYDN
         fKJtRmyMnkRNb+/hrC/PzU7ZiDOozxE53HX24bpdOypz7LdYK3HJ6TdJHHRMwNkU7C94
         LP3JpBsNhu3YVyK2s8Ho1mnYAyWxRRowBJUAaTS008LEJCMU6TgdMvqyLTg6BlDZflGh
         wxAJtJ53nAdFhWvFn2DFym9un8aUYlXcEoIhOpA5yMHMkW5JlA2tvK1+0d0PSECCnyaj
         FVJQ==
X-Gm-Message-State: AHQUAuZXm56Qx7Yr9559EiFqKsbdprOuuG80b6FKoAxeKAEzxyQIOrrO
        6t/TplMR92IQEnWj7gWEEubHZsF6eZDaFRbV8ro=
X-Google-Smtp-Source: AHgI3IY7gGf1wZjsy8uTooCLCqmwR1PtPLVmOKBwPsXcmxgmFyKBEBGFCaxNAiC5Hl9k/7ixDF65ol9zV/XsR4vglEI=
X-Received: by 2002:aca:60c1:: with SMTP id u184mr1169981oib.45.1550544296792;
 Mon, 18 Feb 2019 18:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20190217082018.1008069-1-andriin@fb.com> <20190217082018.1008069-3-andriin@fb.com>
 <20190218142900.GR31177@kernel.org> <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
 <20190218195515.GT31177@kernel.org>
In-Reply-To: <20190218195515.GT31177@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Feb 2019 18:44:45 -0800
Message-ID: <CAEf4BzY1BYF_Ki4zHf=_6K19A32xpV6MsfpaZLWS_Y2maYfEwQ@mail.gmail.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 18, 2019 at 11:55 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 18, 2019 at 11:38:41AM -0800, Andrii Nakryiko escreveu:
> > On Mon, Feb 18, 2019 at 6:29 AM Arnaldo Carvalho de Melo wrote:
> > > Thanks for all the cool work!
>
> > My pleasure, it was fun! :)
>
> So, next step, tag a pahole release and announce it, but I wonder about
> the libbpf linking, wouldn't be better, for now, to make it link
> statically with libbpf?
>
> I ask this because libbpf isn't yet generally available, so perhaps we
> should have some logic to detect if it is available and link against it
> or if not, use the module stuff we have now and link it statically,
> wdyt?

I agree. Now the question is how to do it.

The easiest way to do this is to make bpf-static an OBJECT library in
cmake, which will make it compile as PIC library. But that feature
requires cmake 2.8.8. Would you be ok to bump minimum version of cmake
to 2.8.8 (it's 2.4.8 right now).

If not, do you now what's the proper way to do this right now with older cmake?


>
> Hopefully we get the problems noticed via btfdiff before that.
>
> - Arnaldo
