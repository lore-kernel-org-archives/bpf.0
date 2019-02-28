Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BBC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E972218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8ZR6/qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfB1SaB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:30:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33453 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbfB1SaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:30:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so24719568qtz.0;
        Thu, 28 Feb 2019 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZekeBfwJAt5R0K9R31WRnjlPi3y0+ca/nt42x/IUJo=;
        b=Y8ZR6/qNprbnE01gwklBXb+cwJ0fEIhTaYjbQuMorL4LN1g+A7NR7uXvGJ/7qoHyZ1
         ChUqTZM2nnF28nPuqKad07jdpgQtKojirEtbWe0Td2CUMHcR+6vs/wAYPFXc9F6Pskki
         8igtPYT7yVHx8OwvJS8+wG7vm88YrfffQ02tM2IDrJiFUCAISiS3iOecNT8LTjbJdQrh
         SXWyeiu5SLI34BN3EgDG6ryZJzy1eXWxm9bpP537n14qWBVC2dJ8wZqz0vK3geA6Qd0R
         uZhpUe3Z/rpDyMh61IDxSg2Ky1G87DGzOaaJEHRA94L0HKp5GAcKzTVUVjls8JoPRAwJ
         ovzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZekeBfwJAt5R0K9R31WRnjlPi3y0+ca/nt42x/IUJo=;
        b=GEz7OcJg51pkkxHvULBzuj1MuJhA3RWtFTEpWcF9ZvgrFdI+1505IOQqFcKrDR5m1R
         Ioupj9zJ/P504ob5FEmzbN6xfgVjJrCeslpYz/jCyD63Zcg+zW/ylc7zSwZWJInEgb/V
         1cyb76mz1cAO+ix0nVcRxZXRdngNnznSHRnD8EkpnrSl9Zvp7OQKZjvpB23FMH/ayhhA
         ljmmmS5Psr6RpDU7im8gwddq1th9UEgryXz0V7zAVggxuk24rPAx4OVWOJwxla6GCRqJ
         WUcK9GLBgDgn+GjDj136oeBl+Blogj+L5X7UTzATFKwPYRJbzfxrAv0zHIJpx6GpT6LY
         RnrA==
X-Gm-Message-State: APjAAAW+HdBRmb8Kyx1w31pZQiPb+mPStt+rC2ORqmU1xrR4klDYMzCU
        nrQ/RyaNk88gBa62JglaFZRKN87WyYNA5shdj/6Bsnxx
X-Google-Smtp-Source: APXvYqwySNRmOdaU38kECLyvjhTpe1TpYaH3iqo3NmCGsKmM2lvYPg7KZqsnSc3N4Jdk4Rd+5SjbTEH3g8pf3dMEhUE=
X-Received: by 2002:ac8:2da3:: with SMTP id p32mr587999qta.138.1551378599595;
 Thu, 28 Feb 2019 10:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-6-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-6-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 10:29:48 -0800
Message-ID: <CAPhsuW6GhACUz9+Mahr2U=vFxzSNxirtfqEPuu1njqngdUrZCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add btf_dedup test of
 FWD/STRUCT resolution
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-team@fb.com,
        ast@fb.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 2:48 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> This patch adds a btf_dedup test exercising logic of STRUCT<->FWD
> resolution and validating that STRUCT is not resolved to a FWD. It also
> forces hash collisions, forcing both FWD and STRUCT to be candidates for
> each other. Previously this condition caused infinite loop due to FWD
> pointing to STRUCT and STRUCT pointing to its FWD.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_btf.c | 45 ++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
> index 1426c0a905c8..38797aa627a7 100644
> --- a/tools/testing/selftests/bpf/test_btf.c
> +++ b/tools/testing/selftests/bpf/test_btf.c
> @@ -5731,6 +5731,51 @@ const struct btf_dedup_test dedup_tests[] = {
>                 .dont_resolve_fwds = false,
>         },
>  },
> +{
> +       .descr = "dedup: struct <-> fwd resolution w/ hash collision",
> +       /*
> +        * // CU 1:
> +        * struct x;
> +        * struct s {
> +        *      struct x *x;
> +        * };
> +        * // CU 2:
> +        * struct x {};
> +        * struct s {
> +        *      struct x *x;
> +        * };
> +        */
> +       .input = {
> +               .raw_types = {
> +                       /* CU 1 */
> +                       BTF_FWD_ENC(NAME_TBD, 0 /* struct fwd */),      /* [1] fwd x      */
> +                       BTF_PTR_ENC(1),                                 /* [2] ptr -> [1] */
> +                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /* [3] struct s   */
> +                               BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +                       /* CU 2 */
> +                       BTF_STRUCT_ENC(NAME_TBD, 0, 0),                 /* [4] struct x   */
> +                       BTF_PTR_ENC(4),                                 /* [5] ptr -> [4] */
> +                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /* [6] struct s   */
> +                               BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0x\0s\0x\0x\0s\0x\0"),
> +       },
> +       .expect = {
> +               .raw_types = {
> +                       BTF_PTR_ENC(3),                                 /* [1] ptr -> [3] */
> +                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /* [2] struct s   */
> +                               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +                       BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),              /* [3] struct x   */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0s\0x"),
> +       },
> +       .opts = {
> +               .dont_resolve_fwds = false,
> +               .dedup_table_size = 1, /* force hash collisions */
> +       },
> +},
>  {
>         .descr = "dedup: all possible kinds (no duplicates)",
>         .input = {
> --
> 2.17.1
>
