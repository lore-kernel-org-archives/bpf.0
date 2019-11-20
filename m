Return-Path: <SRS0=MSId=ZM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A7C432C0
	for <bpf@archiver.kernel.org>; Wed, 20 Nov 2019 18:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8E420878
	for <bpf@archiver.kernel.org>; Wed, 20 Nov 2019 18:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwltfdha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKTSO4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:14:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37935 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfKTSO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Nov 2019 13:14:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id 14so544221qtf.5;
        Wed, 20 Nov 2019 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSCoAnpp7qjvf9UQgKjWNf3SEGH72RUV881HxOL+X7g=;
        b=Rwltfdhau77lKg8opS/7GvQHTSsh2VLZTpJA9kMwxzspaKymzIu1ViV7QrQ7SOF15r
         nENa1Efy3l6VDXPhp6HEotZaIhEHoXIGBEASc4XEESs9NBN+KYPHGJfJ3gw2F3tUb2jb
         yxi766xeSnuQhYOnz4MYVLVSHSYt2su5CYwbBHGG9eUt1htLEyBbaR+rvFYqGsD3gAH6
         vniK8vt0JNx9WBWr29o71+pCda5FPQJdTrt6NYrHDmEsjg6U+lQcHc6IGJLmquTmEeon
         4dL8tuAjdi6gKhxsIjzO8A6gU/mLfqaPK/OfwxKJS/PErlTXCFaXukz2GvZTyX6hhwfY
         qrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSCoAnpp7qjvf9UQgKjWNf3SEGH72RUV881HxOL+X7g=;
        b=ac/gnT7bnDPL95y2ccCSaQLRHwmkSxWG2qu+8bomicsoDHIVTsI06abKHyBjrkcCHU
         zrSB0xUZNn7XofhCSGl0PevWJahoqsDjaHIGSDjVoNDOFrlBgXCyTr5gRyx0VQwuf3LF
         MkKMFjiWZGEvv52Ks/AFjG0bwYzvcWaz1stzNIH7E7CXxCTRw4hw4UyTLAEmbsoVk0Kq
         BFVnISiEMqHCK+L9wIjNqEOnEhPJ1Pcru2HCITKSoPxJO1KDiorDmI3EJkfux71X3VYx
         b9IYWqnbTF7hJzXgtREGnklbTibAnE7zKPJ9GPCH/+qP1mKsSv1nNZgmse+fYW12aEE/
         h8+g==
X-Gm-Message-State: APjAAAUtsmKKvCJv+tcgLQsbATNJ86CKCBomluOrYEgy1gESAOTUFfmD
        QS7WKMJk7VyjSrJrZ51jCHwC4Sf/xzVzspqvdV0=
X-Google-Smtp-Source: APXvYqxhUTlZ2j4QyQM2MGbLADCXmUjk+nghwmyrcun5p0R4NB4fG49Zhjv/THPbbOKGVbjOeYeSeUZBfhITMuA4u1U=
X-Received: by 2002:ac8:3fed:: with SMTP id v42mr3882352qtk.171.1574273694579;
 Wed, 20 Nov 2019 10:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20191119111706.22440-1-quentin.monnet@netronome.com>
In-Reply-To: <20191119111706.22440-1-quentin.monnet@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Nov 2019 10:14:43 -0800
Message-ID: <CAEf4BzYG=wFMJ_0RdLF53qhzpKWFf4jgM1r3b6sHoiTqgSE8Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools: bpftool: fix warning on ignored return
 value for 'read'
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        oss-drivers@netronome.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 19, 2019 at 3:18 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> When building bpftool, a warning was introduced by commit a94364603610
> ("bpftool: Allow to read btf as raw data"), because the return value
> from a call to 'read()' is ignored. Let's address it.
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> ---


Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/bpftool/btf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

[...]
