Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3376C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C582083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrvzdyZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKRzS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:55:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39875 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKRzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 13:55:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id c189so4020407qke.6;
        Thu, 11 Apr 2019 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5nn/7PfwRqcJWkKr5tyERmSwF+RQpY3PIYFsWCkPG4=;
        b=LrvzdyZG/NBL26o9aUO1Sgp464BSxqg8qkLBOdmfQA+9EnWDEFWCUJFSXM+HB7kwRd
         GscCi6whJUl8rvF9lIrnsgq5cJPODgchJy9xYv6MWOMCuSj2l1B8Z9/ntFfjaFx623ll
         tWbqGV97BBLb1K6qhpslPFghugVxMwqxYBPKC/lnPHxfKQjivzEWWn0MMbkhi4HxW7fA
         HcBYneDcO6D8IYwNjLx/lo2xmPdPT1ry3PmTdMxwrTY9b1ODMRi1tPWBNQQ9Zp3Z0sio
         uVZAIsxFGJ1fvsj04NVH563LP/WGRIjVyS8/lB9hnosEDJLcpetTOVw3XHhetiqvL/8X
         73Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5nn/7PfwRqcJWkKr5tyERmSwF+RQpY3PIYFsWCkPG4=;
        b=Dio8AAbocCvYTxiCeJ9HKInkHEgGFBg0Es9FYS/TKqfYo1EXEq/17Qmcn3/Fik7t3G
         mVjIXHfXDIXeqH7UFE5UwGSCE/ApWfQ0edRK0fag4j50IF1I07heODRNUmi7Akeo8fkW
         6JNkFaWPb2xaaLn3QUNOMsEsD8D4BfyeXrn5HY6xPQ1hRSOScKCMrx99nBryZ5pDgYn7
         ODZL4vhl0LQB4I1d3aE9GngvV7csyBqUl3nxpSk7EUo0HvuqHvwBUlGc4Ha9JHP8nY57
         dE4p+ftLiiZL3vGZLBgitCNpp8qMMlH616u+RudkXWLOFQN30dFYI87iSHFIaUbl5yq0
         Vctw==
X-Gm-Message-State: APjAAAUaQUR37S8VXKV5dKC9TL4vasNSlaKpRno8ECAEImVhgR203ygP
        u8bmQ9L6dMdYDFv03B3xBhrytwMwivSSwks/1R8=
X-Google-Smtp-Source: APXvYqyR1T+tAZPTAj10oMsZfPpQwTwrtPGn0pnhpg8+/gdYXs8RNv6ZQ0XU0rqzakr7g7TijFrZJB/ZOTMKt8Slm7I=
X-Received: by 2002:a37:8843:: with SMTP id k64mr19092682qkd.8.1555005317298;
 Thu, 11 Apr 2019 10:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190411080332.24574-1-bpoirier@suse.com> <2589b64c-0ed1-7815-dde2-aee1b48602ba@netronome.com>
In-Reply-To: <2589b64c-0ed1-7815-dde2-aee1b48602ba@netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 10:55:06 -0700
Message-ID: <CAPhsuW6VvzLKVA17FdV-yV=U0Ngk=gwmhxs+-vW+PT1YYDHK4g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpftool: Fix errno variable usage
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 4:23 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-11 17:03 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
> > The test meant to use the saved value of errno. Given the current code, it
> > makes no practical difference however.
> >
> > Fixes: bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Acked-by: Song Liu <songliubraving@fb.com>

> > ---
> >  tools/bpf/bpftool/map.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index e0c650d91784..05b029b934a6 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -720,7 +720,7 @@ static int dump_map_elem(int fd, void *key, void *value,
> >               jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
> >               jsonw_end_object(json_wtr);
> >       } else {
> > -             if (errno == ENOENT)
> > +             if (lookup_errno == ENOENT)
> >                       print_entry_plain(map_info, key, NULL);
> >               else
> >                       print_entry_error(map_info, key,
> >
>
>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
