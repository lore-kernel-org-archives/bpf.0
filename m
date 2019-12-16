Return-Path: <SRS0=Avyz=2G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E55C43603
	for <bpf@archiver.kernel.org>; Mon, 16 Dec 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4EA206E0
	for <bpf@archiver.kernel.org>; Mon, 16 Dec 2019 15:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+1PIwoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfLPPEz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:04:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34374 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfLPPEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 10:04:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so4494031lfc.1;
        Mon, 16 Dec 2019 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqMxtYK86E/dK/JkCXWfrBWfWCnClygQ3fiSuT/+OCk=;
        b=E+1PIwoPOoOCmQl+gN9b3UwDF7ZjcZJvSsMZuO+gWnjX9h2Fswrfi4WL7l6UBzSREh
         0ObA1dNI1oP1RjZE2x0RvJgKYICIXRYamNRp6YOPKStHsQJOcHtkmXljlPWfwofoNHuX
         8k110n6t4Ol5Sxb9CAn6eaygq1w6QKX0LGRONDLAVrwrIgnunNnUPn24Jh2tyjT86S0b
         LZ2qpEtrkgcd2Z0OQJaTxxBrGsm/a3beEyBt4eqV2CuS6JjJZlht8Z55e8t84bN4r9vS
         U7lzgcotKgPQaZb/mHOkSzryD7ZltZWJxlIxkwez2A0zADOQ/9ETIenshtM48sC/Pndi
         ymxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqMxtYK86E/dK/JkCXWfrBWfWCnClygQ3fiSuT/+OCk=;
        b=BXuUlUSurzZlhp7v5H7M2XnA+N6xAeS/N5exws03I9xKe/0wDurrT6FuNte5Iz01WF
         TLqKpz9/4yF0P309CcWhOoUR8A0nwiTUQPbsIBOfu/7b/D16zBo2jWb3VvLwmFGAAEhw
         b6MEZsgARaaWCwvR98JfmBL3XJHHofT4pNQo9WK0SxNPAACwOwOyBklbqvMrXemWWbgr
         x4p/YC0eB81Oam2qZxduK0oPQtis4LqCD78BQd+//wAwvlR2kjXyQApeXEWGVBXGC0kM
         C8fHtddG+VMAtWGZ2cdFu9SFhiWYwILG+21bnRv60riKKBe7Y4bhiHD0OIFvp0htLv3F
         Mz2g==
X-Gm-Message-State: APjAAAUSFXsLiKLvLbbA98+bLmMrEcDBD0NbG9lj+2FkpFkGaVIxsdIB
        ayfQEbB1ipTT9TKLuDiHuu1YUhS3T0g/El+6fqI=
X-Google-Smtp-Source: APXvYqyoUwpnNeJu6ovp67D7t/iHvbG/t29Oy+2vD8gSnZbRUa+UmmGr/4Kp7RAwr7cQvtZAMxl1ZyiD36rNErwKdeo=
X-Received: by 2002:a19:888:: with SMTP id 130mr17125559lfi.167.1576508692892;
 Mon, 16 Dec 2019 07:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20191216103819.359535-1-toke@redhat.com>
In-Reply-To: <20191216103819.359535-1-toke@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 16 Dec 2019 07:04:40 -0800
Message-ID: <CAADnVQJYJ5XakE2cGDvzi4fX2zpoiwkjFMxWn05=44NWhDTpGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: Set -fno-stack-protector when
 building BPF programs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 16, 2019 at 2:38 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> It seems Clang can in some cases turn on stack protection by default, whi=
ch
> doesn't work with BPF. This was reported once before[0], but it seems the
> flag to explicitly turn off the stack protector wasn't added to the
> Makefile, so do that now.
>
> The symptom of this is compile errors like the following:
>
> error: <unknown>:0:0: in function bpf_prog1 i32 (%struct.__sk_buff*): A c=
all to built-in function '__stack_chk_fail' is not supported.
>
> [0] https://www.spinics.net/lists/netdev/msg556400.html
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Applied. Thanks
