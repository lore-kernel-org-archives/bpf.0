Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB6C433E1
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AAB20789
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdqN2Rww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHRREt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHRREn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 13:04:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723DC061389;
        Tue, 18 Aug 2020 10:04:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so22208448ljj.7;
        Tue, 18 Aug 2020 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0gFSf9Ewly2JOMGfNm/hfUicHD1OEwAokUx6hde//ag=;
        b=hdqN2RwwHdlAwbG9EnlErBtJA8l/jXs/P6jNhxlPodR++PkeLfBLqeB7PoPQ8hWmFo
         fjFlDJkHsrV1c6cGL2bRdDCZV/LT2wFeTbm7EnxfTatbdBqVr7CsIqxk6j4ZKwM0nuZh
         oMeKV93cxj5UA/e+ehPv7Xw6bw/NT0aEynWX1WzOUm43IholjriJ6+rD2P76KLaI/SxY
         /Z6/tcDBnSgmL4DovfmSH2t8edN9LvOxkgYdOkV+R49tigkMpS1bNclTxraOYQt1MGbP
         OHZqdYP/TgmP5ieUJITGzCHtuuFZdnjh/Iv6SewV9MXIcXsSVvyAVQ3BukOPb9gfMLD5
         Vbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0gFSf9Ewly2JOMGfNm/hfUicHD1OEwAokUx6hde//ag=;
        b=UIZklBwSBzyExCZljr7m+AGjA5yLNVdaXtAixiPaqJBjpKlza1jRCBJACkMHNBfP9H
         2i8mtmd05dwI+nJLQxeQAXk+UYqqeLoqgUk95gkKMx3WzkNMf2zwg+rqsWfrXQ4Y4tNu
         tAl+WVGEswTmYSUhkuJ7VVEqEkNMBqh4nf0Dl4XXvUbDHT8oL8hu/eU4HjBG9847JPs+
         Of9twbyqg6TNIv5Xl4maw7JIh7XG5ZCeRYV+WSAGPSwftk1iREs/LM35LHi2rVFKBEja
         33j6uZKBsjPCczh0suHMrbiUyaCKGash+pNHm+xROckoUO+ZOP1Xd3N5X05cqvx1A7xP
         /J7Q==
X-Gm-Message-State: AOAM533vRfKMyeapiaHrxbfKwHKImjGTIjqdzrzcYS6sDxEwse80XnVs
        S0fM+2f0i35OCgL5A7xhoSUPGPsgQbhGZ4OEBUw=
X-Google-Smtp-Source: ABdhPJxhFkdl4wPbe+6azkAT2BYnmocwVLIdEP9T7LsNH3KpHAYtR+16Xb4VpFDzKmI6bm2K9gVngzvJ8y+h5/P8kqs=
X-Received: by 2002:a05:651c:82:: with SMTP id 2mr9834422ljq.2.1597770280441;
 Tue, 18 Aug 2020 10:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200818164456.1181661-1-andriin@fb.com>
In-Reply-To: <20200818164456.1181661-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Aug 2020 10:04:29 -0700
Message-ID: <CAADnVQJggLTeT7r69C-CjzEO8S2WoJLhsJFSgAdYTrR37VvsNg@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix build on ppc64le architecture
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 9:47 AM Andrii Nakryiko <andriin@fb.com> wrote:
>
> On ppc64le we get the following warning:
>
>   In file included from btf_dump.c:16:0:
>   btf_dump.c: In function =E2=80=98btf_dump_emit_struct_def=E2=80=99:
>   ../include/linux/kernel.h:20:17: error: comparison of distinct pointer =
types lacks a cast [-Werror]
>     (void) (&_max1 =3D=3D &_max2);  \
>                    ^
>   btf_dump.c:882:11: note: in expansion of macro =E2=80=98max=E2=80=99
>       m_sz =3D max(0LL, btf__resolve_size(d->btf, m->type));
>              ^~~
>
> Fix by explicitly casting to __s64, which is a return type from
> btf__resolve_size().
>
> Fixes: 702eddc77a90 ("libbpf: Handle GCC built-in types for Arm NEON")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
