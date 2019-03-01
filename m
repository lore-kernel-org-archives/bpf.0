Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613EC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B225205F4
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI4f37ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCAXSg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:18:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39968 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAXSg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:18:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so29831968qta.7;
        Fri, 01 Mar 2019 15:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbvwQJz9ujP/tyRSAADRjNh+8cjhNtfUw319+07z6Ls=;
        b=fI4f37neUjKCEVmmHF/rtosWfD2WtTGXSFA1UYcFcrZzyEnPznQA/BnRkjDhdvo2q3
         SGmBavaJKcQScBOqubm+gcIrKGj5xSQmxNjwxRcSoLvvPOiIPnixx0Tue60RnNfVxPxB
         FniMeGYxgVyrG/BM/aIDv0QiWAr97Vx9RVpDNvsXSwEKMl4iXdMifVhZiy+t63oOJmx8
         axeVDFoxlCworUz9qTVVtNs3+Y1bgJK7w8i81BlOxQxaRHaqXT146pT0mKJG7TVV0hSN
         r6OwQgX23cENmUEx6y3aXEfSBg/OrSRwPNbQ73qc+sJgSWMwkJQmZ0cRalJkk7pIwRqU
         XTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbvwQJz9ujP/tyRSAADRjNh+8cjhNtfUw319+07z6Ls=;
        b=candbhjTT75FXRUD8rQP0APXl1kzn045rpmWZ9NvEIWJK9l4kLNl7F4BHTF3jot3CL
         XNmtg2ITH+GRic8ZboxLSNsBhWVcG5BsakY2tb/GTU7DtLHYno3j2Q17AbaKKrLTTZ85
         Je0oCfAcSX+Sxoln8+HjipYJkk/tFaRDrjKKtCVV3J2iLzFvJEkjRHfvTI/K3EFZ+Hlf
         2lfqlcOqmpQsCC2eD0yNjFF8lQQSCDaJtScziDpI9GgIKkv5oJ6oYfGfi3buXBgfT/SZ
         2TuC8hQb4uyd0quDTDca/MAKPp7tUNnRVNZ2KFCrPVQsYbat1oDO6Y95pwtHRaVn33II
         C5Fg==
X-Gm-Message-State: APjAAAVbR5mU8Pflrf8+Uu+X6hyZexFdMfG1pbmCu9+ZdEbFQTtFrhXK
        tl+9S0CFEzBegeCawLrzhUFPh4kJkTcFdt4ZW+o=
X-Google-Smtp-Source: APXvYqxdZfc7RV1F6z1Qrh4yeWP13hMQ4sdNg54ZW2ce4LBXRq0QYtVPc3bvbhb7JTlPzRSV+mKpZ+qbqh1cGKgtUAo=
X-Received: by 2002:ac8:2da3:: with SMTP id p32mr6105919qta.138.1551482314474;
 Fri, 01 Mar 2019 15:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20190301210529.8218-1-daniel@iogearbox.net>
In-Reply-To: <20190301210529.8218-1-daniel@iogearbox.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 1 Mar 2019 15:18:23 -0800
Message-ID: <CAPhsuW4J52-hiYTb5X=-qYH-rRChiao26DFTjghf8x6N1xuNeg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 1:06 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Marek reported that he saw an issue with the below snippet in that
> timing measurements where off when loaded as unpriv while results
> were reasonable when loaded as privileged:
>
>     [...]
>     uint64_t a = bpf_ktime_get_ns();
>     uint64_t b = bpf_ktime_get_ns();
>     uint64_t delta = b - a;
>     if ((int64_t)delta > 0) {
>     [...]
>
> Turns out there is a bug where a corner case is missing in the fix
> d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
> type from different paths"), namely fixup_bpf_calls() only checks
> whether aux has a non-zero alu_state, but it also needs to test for
> the case of BPF_ALU_NON_POINTER since in both occasions we need to
> skip the masking rewrite (as there is nothing to mask).
>
> Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
> Reported-by: Marek Majkowski <marek@cloudflare.com>
> Reported-by: Arthur Fabre <afabre@cloudflare.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
> ---
>  [ Test case will be routed via bpf-next to avoid useless merge churn
>    due to test_verifier rework in bpf-next. ]
>
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f295b790297..5fcce2f4209d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6920,7 +6920,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>                         u32 off_reg;
>
>                         aux = &env->insn_aux_data[i + delta];
> -                       if (!aux->alu_state)
> +                       if (!aux->alu_state ||
> +                           aux->alu_state == BPF_ALU_NON_POINTER)

alu_state is a bitmap. Shall we check "aux->alu_state &
BPF_ALU_NON_POINTER" here?

Thanks,
Song

>                                 continue;
>
>                         isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
> --
> 2.17.1
>
