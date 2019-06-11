Return-Path: <SRS0=fZcT=UK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85570C4321A
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 06:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ECA20896
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 06:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekuR4icl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfFKGlg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:41:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39523 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKGlf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 02:41:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so10377579ljh.6;
        Mon, 10 Jun 2019 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB1OybDU8IsXaF9ajR5n/uysPAwBp/qRaY9IE3Ad6y8=;
        b=ekuR4iclaKqKoxi+hPT3rdJ1pLCh+eKouy19OWd1aaRv5ZyFN8NTDjASATMbzIyBYm
         uCV1hAuyJeo8TC6+h3Oew0tRG5jsqwlhD+/uP5R9FF6JemXVxJM6i1pGw8UBtorVU5f8
         rQ4CwTB+8Oqpk43w8Q8jdq/vMfQAaL1veVmNu+8WxM7dfFARsrMr0+6eWB/fnSIVqNyf
         94qZLvHRgFeIo6O16EJlvvug9jdW17BxARIBZcu8sAkfjPmVKOmacBNQ7Wp7KWu0XdT5
         K9B4hSGXpg6kWT353IWN5HGYnnFNJG5JhZYBs1A2Nz0lUZmm4zEwP5t2ObIQbiHQLYZp
         gKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB1OybDU8IsXaF9ajR5n/uysPAwBp/qRaY9IE3Ad6y8=;
        b=j0x6To45GMWUKP9rafmGduavdOgdwvuV1ZrF8M0tdZPMiIVgkDPqplusv29HUxMk7B
         hx/Dh2cjC7YAjUfqp23up5zqnDBiNQ0k6lzuJqIxDFomDr6vEyrbKlNeVdFlabDwp9Jv
         NgArDAkr/lS9la7DLffOh/CJsLpmo6SUL3qrPfBr4dU1eF2cShcVQlGcybgP/gmWAt/0
         aHyN+qnatKpfmAvKB7YWwO1i+eskOjBX6++txUmqird8aq1FqR6jYfxJF2P0EGdpo9kq
         Pf8Ra8RS/EV8OO+nrc1Yk6uwRNfCN7tPy5m+pIC4TVpKgf87iHw8okL1ZtwWD2+DhTvB
         /rwQ==
X-Gm-Message-State: APjAAAVxfIsat3ld+7BeFya2sI6hs2x5VWKOBhb+EmghNEX0M5gWSy6c
        7VN7oKc/tib+pNC8Qq+1ginXN6eFnxENXTVjQuU=
X-Google-Smtp-Source: APXvYqyRdJ6l3SXWgXGEWX/3STvcER/nOBLdfye+sG+aE3BusZaRjGpwx0cSiQgnQKjXpSAv5mEPo/lsOWjLxSl90JA=
X-Received: by 2002:a2e:298a:: with SMTP id p10mr9878897ljp.74.1560235293691;
 Mon, 10 Jun 2019 23:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190610174655.2207879-1-andriin@fb.com>
In-Reply-To: <20190610174655.2207879-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 10 Jun 2019 23:41:22 -0700
Message-ID: <CAADnVQ+_JdRryLgcQpH0ZRVZDavw+Q_fXnrEvCj90oeEMZ3iOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix constness of source arg for
 bpf helpers
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 10, 2019 at 10:48 AM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix signature of bpf_probe_read and bpf_probe_write_user to mark source
> pointer as const. This causes warnings during compilation for
> applications relying on those helpers.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
