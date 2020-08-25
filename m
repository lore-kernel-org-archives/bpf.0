Return-Path: <SRS0=alw5=CD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE74C433E1
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8091205CB
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 04:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO3WEaIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHYEIz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgHYEIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 00:08:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BFC061574;
        Mon, 24 Aug 2020 21:08:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so12172018ljj.7;
        Mon, 24 Aug 2020 21:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifEPajG5WZvddRDhWRkMEk4y3lPOYfaDkQP3skchVFY=;
        b=dO3WEaIoj8S8RZPZP2BnwuqclcIlgq6eKT+Rvc70JAKsRWiwaiH4aRrRFsf2aLPOyS
         9sRj8VFMW3BJndYfux07/Juh3SX7TB51fqIobv/Hun2yB/bLHJ4ePbhcUg8olMG9dIoX
         Sh2k2Q9va3snlnc8KpkNx2gCnQmG3TAy3r+rHPRNkkoN9u5Ux+WBXiIzsHJZd8w6jvOP
         dXEDRWgwRmzC7rbbngXZzp0xu3Af+ZrMazIUfirbJeB41Wl4vTq8g5nwcKsEbTfMnkXN
         jt55jJ0uwgvwj3s6Xz3zL30h6jcGlNDbSzPTxljOrGEh+dSVV8C82s2Wx1eBg4Q6Ovsi
         78Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifEPajG5WZvddRDhWRkMEk4y3lPOYfaDkQP3skchVFY=;
        b=ezllLILIfXcLf0B/Iy5WTWWBzvGj8lmmISSSHqMEsp1+N0DwfPvH7hyhMVWiHg2X0I
         yxAZk1m8W4mEQs1XO3CoHPX3wp3qDEoNu7mZ7bwQPKUjeosgkL0jryb0tu4C7gXKlQnE
         QEomFMOzSxv343Vi44UlQBLpp+sc4BBCDLG1DHM6CVhr3yFw8YH9NvWpCjqg3kneVCgu
         CSaZZGl55y71dj1/ameMA+aJG+kVC59aliI2CJShgNjbWu52MCPYgQSc8DjngifsTTCT
         srO8i8HbWD/liQC4oUDLPCXvXUmkV1KnRwdZppgORhdcLA+AXRgD9C4LassUg0QnSWMZ
         LGhA==
X-Gm-Message-State: AOAM530CjddkOGzPPZeyamVqv9Q2+d/ExKfSdZ/E9RlDHLEKTxi4LPTz
        OfRyYJe9UzdXx5WTNhGXrN5801Iv3tnA49tsEuw=
X-Google-Smtp-Source: ABdhPJyBhlZJmM15p+hH+3iYCLyS8a8G4DpwGGmHaO7g6zLLDpGJJxA1MbEnyG1Dzc2laHVqEgs/xnN+uXC6LGF/7gc=
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr4131968ljo.91.1598328531851;
 Mon, 24 Aug 2020 21:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200821191054.714731-1-yhs@fb.com> <CAEf4BzYkHraBsaaApbaBAUsQfjnYJtnBU7EcNybzxqaHmSNBCg@mail.gmail.com>
In-Reply-To: <CAEf4BzYkHraBsaaApbaBAUsQfjnYJtnBU7EcNybzxqaHmSNBCg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Aug 2020 21:08:40 -0700
Message-ID: <CAADnVQ+FB4GQ9nUhCYHWXyocXE7-tdnWttpzMND6b1sv82puwg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix a buffer out-of-bound access when filling
 raw_tp link_info
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 1:09 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 12:11 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > Commit f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")
> > added link query for raw_tp. One of fields in link_info is to
> > fill a user buffer with tp_name. The Scurrent checking only
> > declares "ulen && !ubuf" as invalid. So "!ulen && ubuf" will be
> > valid. Later on, we do "copy_to_user(ubuf, tp_name, ulen - 1)" which
> > may overwrite user memory incorrectly.
> >
> > This patch fixed the problem by disallowing "!ulen && ubuf" case as well.
> >
> > Fixes: f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")
> > Cc: Andrii Nakryiko <andriin@fb.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/syscall.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 86299a292214..ac6c784c0576 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2634,7 +2634,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
> >         u32 ulen = info->raw_tracepoint.tp_name_len;
> >         size_t tp_len = strlen(tp_name);
> >
> > -       if (ulen && !ubuf)
> > +       if (!ulen ^ !ubuf)
> >                 return -EINVAL;
>
> I think my original idea was to allow ulen == 0 && ubuf != NULL as a
> still valid way to get real ulen, but it's clearly wrong with ulen-1
> below. So instead of special-casing ulen==0 for the case I wanted to
> support, it's easier to disallow ulen==0 && ubuf!=NULL.
>
> So thanks for the fix!
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
