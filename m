Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAAFC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165F7206BF
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyBUVLmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfDYQon (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:44:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43688 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYQon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:44:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so798939qtq.10;
        Thu, 25 Apr 2019 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5U4NcU3WQUrdc7FKzdv7bVZ+jm1XDLR4piEP5uZUIeU=;
        b=AyBUVLmVDlp4fKiC4+Uc0BLgGzXCdYprx0ZVDI/7qx2zyOuQaQV/iE2U1jRR05Io8j
         cdrpsuHIH5qtEz+ybBtvex5PVqfc/ZidhZegSH3yPsDltMBg/MXi/skHC+cvqcWqY7fI
         ZRkiDZJxp0FkxnzSP6jXZQO86YvlYCjrK0ktko7pMFKcXRbZrr4rxVUmsdZq7Au6sFBc
         04No0kTXtZWi8BMz02znEElkJyn291RFRo5RxFP4Fy5/ya8nsq+6IjAyjG207tuGRfMb
         NaDpJGsoRMBsNxp8EYW72jgy3FA0S91LaqqRvwaEy8PURjoU5Gdg2K93UsMMyuid9B87
         oGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5U4NcU3WQUrdc7FKzdv7bVZ+jm1XDLR4piEP5uZUIeU=;
        b=cxYz0aqvO1fNR6cyKzRBNfNulwfZFbu8FgQKmKAbdQT+5xIjxmtfdaLps74fMLrSgE
         SERcTzF5A7qR4A/hEMk4DfIlwqo8CTgUJqkC652Z2ukO/jf8sGePPsnhoNblILRCll4T
         QnKWdOhOn952iFl5xljccaFZ1SajIyRrVqTeZJjFUM2un9vb0x09MZMhMPVGBo+1Eb4d
         Xk9WpOuxTZtvL+lib+A91+azQWZjwBTKDqlU4fYt4oHjCvusgjgw3e2YbGzBsZUrjxs0
         KHlsVkrVkevj81/XZbTFJABwNdnEBeMIRpN37c56Eav9WeVCFoY1zaQqqMWf7z1C7xHf
         vwoQ==
X-Gm-Message-State: APjAAAXxmwnY2ExAzrUa3hmQLVgmESuTGGTpoXC09kqsGRmmLgEB58Qu
        XKT+DiF/20JtzAUH8C6Tu6CQng4G8av5rZ3RlFs=
X-Google-Smtp-Source: APXvYqwOMukPNxJD6NopimwbLsGIN3kGQb7l0f46x5sbGEzRiuZ0nGiPBAO5nhQs0h6UiOg/95g+i4Mk5uIr/g6zCCE=
X-Received: by 2002:a0c:d1fa:: with SMTP id k55mr31463256qvh.229.1556210681634;
 Thu, 25 Apr 2019 09:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190425050355.1359736-1-andrii.nakryiko@gmail.com>
 <20190425050355.1359736-4-andrii.nakryiko@gmail.com> <b2eda1ce-4362-4b2a-0c60-7815dd8bb8d4@netronome.com>
 <CAEf4BzZF7zWGP24H7YJzCD3LLy4HVmsyKL-f2+1_N1+wq=ejQw@mail.gmail.com> <7bac058b-ca3c-5e20-ed6e-667a6602db7e@netronome.com>
In-Reply-To: <7bac058b-ca3c-5e20-ed6e-667a6602db7e@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Apr 2019 09:44:30 -0700
Message-ID: <CAEf4BzZhinUWSMdVthBM=gWDxHTojbXE15xA63QgcJkZ9d8pig@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 9:33 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-25 09:14 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Thu, Apr 25, 2019 at 4:15 AM Quentin Monnet
> > <quentin.monnet@netronome.com> wrote:
> >>
> >> 2019-04-24 22:03 UTC-0700 ~ <andrii.nakryiko@gmail.com>
> >>> From: Andrii Nakryiko <andriin@fb.com>
> >>>
> >>> Add full support for btf command in bash-completion script.
> >>>
> >>> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>> Cc: Alexei Starovoitov <ast@fb.com>
> >>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> >>> ---
> >>>  tools/bpf/bpftool/bash-completion/bpftool | 46 +++++++++++++++++++++=
++
> >>>  1 file changed, 46 insertions(+)
> >>>
> >>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bp=
ftool/bash-completion/bpftool
> >>> index 9f3ffe1e26ab..030f81bdec6a 100644
> >>> --- a/tools/bpf/bpftool/bash-completion/bpftool
> >>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> >>> @@ -217,6 +217,7 @@ _bpftool()
> >>>      done
> >>>      cur=3D${words[cword]}
> >>>      prev=3D${words[cword - 1]}
> >>> +    pprev=3D${words[cword - 2]}
> >>>
> >>>      local object=3D${words[1]} command=3D${words[2]}
> >>>
> >>> @@ -607,6 +608,51 @@ _bpftool()
> >>>                      ;;
> >>>              esac
> >>>              ;;
> >>> +        btf)
> >>> +            local PROG_TYPE=3D'id pinned tag'
> >>> +            local MAP_TYPE=3D'id pinned'
> >>> +            case $command in
> >>> +                dump)
> >>> +                    case $prev in
> >>> +                        $command)
> >>> +                            COMPREPLY+=3D( $( compgen -W "id map pro=
g file" -- \
> >>> +                                "$cur" ) )
> >>> +                            return 0
> >>> +                            ;;
> >>> +                        prog)
> >>> +                            COMPREPLY=3D( $( compgen -W "$PROG_TYPE"=
 -- "$cur" ) )
> >>> +                            return 0
> >>> +                            ;;
> >>> +                        map)
> >>> +                            COMPREPLY=3D( $( compgen -W "$MAP_TYPE" =
-- "$cur" ) )
> >>> +                            return 0
> >>> +                            ;;
> >>> +                        id)
> >>> +                            case $pprev in
> >>> +                                prog)
> >>> +                                    _bpftool_get_prog_ids
> >>> +                                    ;;
> >>> +                                map)
> >>> +                                    _bpftool_get_map_ids
> >>> +                                    ;;
> >>> +                            esac
> >>> +                            return 0
> >>> +                            ;;
> >>> +                    *)
> >>> +                        if _bpftool_search_list 'map'; then
> >>> +                            COMPREPLY+=3D( $( compgen -W 'key value =
kv all' -- \
> >>> +                                "$cur" ) )
> >>
> >> Hi Andrii,
> >>
> >> This COMPREPLY will suggest completion for "key|value|kv|all", even if
> >> one of those words has been used on the command line before already (I
> >> do not believe this is expected?). What about the following instead?
> >>
> >>                             _bpftool_one_of_list 'key value kv all'
> >
> > I'll make it more precise and correct. key|value|kv|all should go only
> > after `bpftool btf dump map id <id> <here>`, I'll do match based on
> > number of workds, similar to how it's done in prog attach/detach
> > handling.
>
> I think that bit was mostly correct. What you have is =E2=80=9Cif we're a=
fter
> map and it's not prog/map/id, always complete with key/value/kv/all=E2=80=
=9D.
>
> What I'm proposing is =E2=80=9C[in the same context], complete just once =
with
> only one of key/value/kv/all=E2=80=9D. Like this:
>
>         *)
>                 if _bpftool_search_list 'map'; then
>                         _bpftool_one_of_list 'key value kv all'
>                 fi
>
> With that you probably do not have to change it for word numbers.
> Although if you wish to go for them, it's fine too.

I still changed it, because in my follow up patches I'll add extra
options (e.g., to output BTF as compilable C), at which point this
script will start suggesting key|value|kv|all in the wrong place:

bpftool btf dump map id 111 compilable <cursor-is-here-now>

Now it will suggest `key value kv all`, but it's incorrect, so I want
to make sure those for go only after `map (id|pinned) <value> <here>`.

>
> >
> >
> >>
> >>> +                        fi
> >>> +                        return 0
> >>> +                        ;;
> >>
> >> Nit: It seems that the last bloc (the case when $prev matches on "*") =
is
> >> not correctly indented, it should be aligned with $command/prog/map/id=
?
> >
> > Copy/pasted from `prog dump`, I wasn't sure if that was intentional,
> > will fix both.
> >
> >>
> >> Other than this the completion seems good to me.
> >>
> >> But note that I did not receive all of your patches, only the cover
> >> letters (for v1 and v2 of the set) and this one (because I'm directly
> >> CC-ed?). It looks like the other patches for both v1 and v2 did not ma=
ke
> >> it to the mailing lists or to patchwork, so you might want to double
> >> check and resend if necessary.
> >
> > Hm.. yeah, you are right, not sure what happened there. Neither bfp@
> > and netdev@ didn't get it, while other recipients did. I'll send out
> > v3 and will see if that still happens.
>
> Cool, thanks!
> Quentin
