Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C6AC43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6CD20895
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP63H/+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfDYQP5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfDYQOl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id h16so716129qtk.6;
        Thu, 25 Apr 2019 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4Sn/UdgTAEdJAuyz9r6XmEqKumYVSOuFOBIF895kAY=;
        b=qP63H/+PqCB7mwpTffDsai1cz42uecsSxFigmv2jQ9DYZtCIgAbNpfXspJpbk4d5Xe
         jj/efAgSV6snjjv4VvnOrlH6m1zHi6IVrdq5Lz7SUcwj1DDnRvhNW/MhzzvLolZvYrL1
         0d8t5DyIYzTadWQUoWKYeoxRg3PtFTgi3GBEO+7AIhsaz6cENEYhQDbMA12FwbqcJP/6
         YwgsYTON7pmxsi6mVbHWZm90TBlvuXoNQp5ELGgoKQe4OTW/yg/B/t7RhdRnRIMINOH2
         APaMuQ/XdLjq/ntMEsjQg0BJIcaKjJY7gtq5YuqZODNQ/C8giEhHgweaa+4bDmu9N7ZL
         uJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4Sn/UdgTAEdJAuyz9r6XmEqKumYVSOuFOBIF895kAY=;
        b=Ei4U7NkvpmgKx0caNJTHQy3ruijnHH7e7SvdxTgvmo88isWOyA6OGfwojnqdmTWwTs
         vb5ICIH3lvLcu7kcj+/Unx8G5unRw0XCdGp+1iFfUGxt6PlHD/Cjrnt6KkbKNss8AIl4
         eUDi4LkUrFqxIzC/R1QUmGP76LKbvgvtOUTCiPP+C45Fcmn2WS9ahtnnIqPZBOFKWw9u
         wsjOS4nqzuWgUtJAOeZpjXyQ3K/N0pV4y4nyNZ8aAnfZHQjx2l7Crnnx56T/Jk6D4hGZ
         axiekMktNPyAz3F0Q4JFVorgnhJVSyGqweJ/q6xNNWlNkZ9SqE9vaTVTjY6TQZhb8Mu+
         020A==
X-Gm-Message-State: APjAAAV6yYnvxbAaFfa0I+BKgEibOoaXZBXVoqnlLzgy3RJ1APLpnIuw
        t0Rna9TICVbkF9NWJaPXKhhKwowUzLjy712LL5I=
X-Google-Smtp-Source: APXvYqz6ifv9zo1nFEQqYNcrZgj0E9yXrLDRsZ3eoEKLiSwZ5+0xBue0U1mqYdVHvfNKm1/sKBgkPdUyCEAqx54fuDk=
X-Received: by 2002:a0c:d1fa:: with SMTP id k55mr31333525qvh.229.1556208879792;
 Thu, 25 Apr 2019 09:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190425050355.1359736-1-andrii.nakryiko@gmail.com>
 <20190425050355.1359736-4-andrii.nakryiko@gmail.com> <b2eda1ce-4362-4b2a-0c60-7815dd8bb8d4@netronome.com>
In-Reply-To: <b2eda1ce-4362-4b2a-0c60-7815dd8bb8d4@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Apr 2019 09:14:28 -0700
Message-ID: <CAEf4BzZF7zWGP24H7YJzCD3LLy4HVmsyKL-f2+1_N1+wq=ejQw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add bash completions for btf command
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 4:15 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-24 22:03 UTC-0700 ~ <andrii.nakryiko@gmail.com>
> > From: Andrii Nakryiko <andriin@fb.com>
> >
> > Add full support for btf command in bash-completion script.
> >
> > Cc: Quentin Monnet <quentin.monnet@netronome.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@fb.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/bpf/bpftool/bash-completion/bpftool | 46 +++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> > index 9f3ffe1e26ab..030f81bdec6a 100644
> > --- a/tools/bpf/bpftool/bash-completion/bpftool
> > +++ b/tools/bpf/bpftool/bash-completion/bpftool
> > @@ -217,6 +217,7 @@ _bpftool()
> >      done
> >      cur=${words[cword]}
> >      prev=${words[cword - 1]}
> > +    pprev=${words[cword - 2]}
> >
> >      local object=${words[1]} command=${words[2]}
> >
> > @@ -607,6 +608,51 @@ _bpftool()
> >                      ;;
> >              esac
> >              ;;
> > +        btf)
> > +            local PROG_TYPE='id pinned tag'
> > +            local MAP_TYPE='id pinned'
> > +            case $command in
> > +                dump)
> > +                    case $prev in
> > +                        $command)
> > +                            COMPREPLY+=( $( compgen -W "id map prog file" -- \
> > +                                "$cur" ) )
> > +                            return 0
> > +                            ;;
> > +                        prog)
> > +                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- "$cur" ) )
> > +                            return 0
> > +                            ;;
> > +                        map)
> > +                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
> > +                            return 0
> > +                            ;;
> > +                        id)
> > +                            case $pprev in
> > +                                prog)
> > +                                    _bpftool_get_prog_ids
> > +                                    ;;
> > +                                map)
> > +                                    _bpftool_get_map_ids
> > +                                    ;;
> > +                            esac
> > +                            return 0
> > +                            ;;
> > +                    *)
> > +                        if _bpftool_search_list 'map'; then
> > +                            COMPREPLY+=( $( compgen -W 'key value kv all' -- \
> > +                                "$cur" ) )
>
> Hi Andrii,
>
> This COMPREPLY will suggest completion for "key|value|kv|all", even if
> one of those words has been used on the command line before already (I
> do not believe this is expected?). What about the following instead?
>
>                             _bpftool_one_of_list 'key value kv all'

I'll make it more precise and correct. key|value|kv|all should go only
after `bpftool btf dump map id <id> <here>`, I'll do match based on
number of workds, similar to how it's done in prog attach/detach
handling.


>
> > +                        fi
> > +                        return 0
> > +                        ;;
>
> Nit: It seems that the last bloc (the case when $prev matches on "*") is
> not correctly indented, it should be aligned with $command/prog/map/id?

Copy/pasted from `prog dump`, I wasn't sure if that was intentional,
will fix both.

>
> Other than this the completion seems good to me.
>
> But note that I did not receive all of your patches, only the cover
> letters (for v1 and v2 of the set) and this one (because I'm directly
> CC-ed?). It looks like the other patches for both v1 and v2 did not make
> it to the mailing lists or to patchwork, so you might want to double
> check and resend if necessary.

Hm.. yeah, you are right, not sure what happened there. Neither bfp@
and netdev@ didn't get it, while other recipients did. I'll send out
v3 and will see if that still happens.

>
> Best,
> Quentin
>
> > +                    esac
> > +                    ;;
> > +                *)
> > +                    [[ $prev == $object ]] && \
> > +                        COMPREPLY=( $( compgen -W 'dump help' -- "$cur" ) )
> > +                    ;;
> > +            esac
> > +            ;;
> >          cgroup)
> >              case $command in
> >                  show|list)
> >
>
