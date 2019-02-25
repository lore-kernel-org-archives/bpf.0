Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558AC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E062087C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5qJEgL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBYPnU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:43:20 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45138 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfBYPnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 10:43:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id r188so3670170ywb.12
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTWwqDDmkF3Sa/i+hCAEKq8LdRoZ/ylMFQtSPl1W13Y=;
        b=t5qJEgL0VYxSnuubgigCABrELSVV6tHKPaFXEounykgu0MYXdVSolFz9krBqjuAz4F
         2ydrn6sQsQuyVYb8bFv99tqDVDgL1LTTfCG+iYveXl3GWayOKNi1ZAAD6mx6/Xpbogg9
         Fo+W04gjHchx5U7/zTYgrpKajYojTmyK9CnRxLq83140JUN7Aw0ThwKgUhCglLETlEa4
         RATeUsPkmfJ/lIeLrvS03gQQ/uGnCcyoPSp7AWbK//TsLKSZFFBqeUu7f4ov6aeA40LV
         PMNTS8yEwEdhPoehYuEtbceKa6OcBlwurgF38zCcPWEVdw7knPicHG3lZFl4m3TispEB
         PwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTWwqDDmkF3Sa/i+hCAEKq8LdRoZ/ylMFQtSPl1W13Y=;
        b=Aw5ZDdf4fukOhrI0+N1O5pTmx2+2+WqSRXnzhR9KhKkV7FyANpQ6Y7kE1idMwIHXon
         vbcmGoDY2U8Ge+n+NyPojVRT+fQnLxBUr4wloh70RRv85LyZ9jJFJAQJyTnA5zsflJJe
         RJlHlv4RyO4GAaEyrXPUR9l33c8RqZItlE6IYepY+vk+utbGKwH0LMCEjQJbgxEo+v+k
         KQ+qgnwmjwNzU0ikejL7+zmzeuUMTQ4JFE5d6zeEX6UCpdQVjdXFq9lFmBp8HUO3IdoK
         HW9gzpygJbyhrqxN2f5TfNhHvM8Y0nUSNT168IyRq5agDx88BeILuSEFKNDEI+fqTwRO
         ta2A==
X-Gm-Message-State: AHQUAuZ6JyynEo2UtL46PruUy1pbCJExSHT+R2of4qXMZ7JGHZn1rGTQ
        1i3VWVdgW2IxZgak9c7vAZnjMXvKL9Rt+qlr1vtIwA==
X-Google-Smtp-Source: AHgI3IZ8YO6kbCcjMrKcj0tys8t+0gB/4UsJ1h9wltoBIGyWC6/xIgyuob5is3b1cNePXFYzPpnFZo4Io26Lttzthog=
X-Received: by 2002:a81:1155:: with SMTP id 82mr4905270ywr.92.1551109396193;
 Mon, 25 Feb 2019 07:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20190223190709.61558-1-edumazet@google.com> <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
 <73905026-571a-867d-43eb-3d9b36f6c39c@gmail.com> <20190223231112.7dzt7ws472k6ajb5@ast-mbp.dhcp.thefacebook.com>
 <739fbe32-d019-4d97-c902-2155a15c58b5@iogearbox.net>
In-Reply-To: <739fbe32-d019-4d97-c902-2155a15c58b5@iogearbox.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 25 Feb 2019 07:43:03 -0800
Message-ID: <CANn89iKOpPJT5YEN4c7nqwus-G6zSkUpku9qjzDKnJqEmzPfwA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 3:07 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 02/24/2019 12:11 AM, Alexei Starovoitov wrote:
> > On Sat, Feb 23, 2019 at 12:48:53PM -0800, Eric Dumazet wrote:
> >> On 02/23/2019 12:38 PM, Alexei Starovoitov wrote:
> >>> On Sat, Feb 23, 2019 at 11:07:09AM -0800, Eric Dumazet wrote:
> >>>> If caller of bpf_setsockopt() is silly passing a negative optlen
> >>>> bad things happen.
> >>>>
> >>>> Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
> >>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>>> Cc: Lawrence Brakmo <brakmo@fb.com>
> >>>> ---
> >>>>  net/core/filter.c | 5 +++--
> >>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>> index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
> >>>> --- a/net/core/filter.c
> >>>> +++ b/net/core/filter.c
> >>>> @@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
> >>>>                    char name[TCP_CA_NAME_MAX];
> >>>>                    bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
> >>>>
> >>>> -                  strncpy(name, optval, min_t(long, optlen,
> >>>> -                                              TCP_CA_NAME_MAX-1));
> >>>> +                  if (optlen < 0)
> >>>> +                          return -EINVAL;
> >>>> +                  strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));
> >>>
> >>> Unnecessary.
> >>> The verifier guarantees that optlen > 0 because
> >>> static const struct bpf_func_proto bpf_setsockopt_proto = {
> >>>         .func           = bpf_setsockopt,
> >>> ...
> >>>         .arg5_type      = ARG_CONST_SIZE,
> >>> };
> >>
> >> Even on 32bit kernel ?
> >>
> >> The suspect thing to me is the min_t(long, ....)
> >>
> >> optlen is an integer, why do we need to promote to a long ?
> >
> > I think the code is actually fine as-is.
> > I bet it was copy pasted from do_tcp_setsockopt
> > where similar min_t(long) is used to match strncpy_from_user() declaration.
> > Here min_t(long) or min_t(int) or min() doesn't matter.
> > I would keep it as-is to avoid noisy patches.
>
> Max allowed input from verifier should be BPF_MAX_VAR_SIZ which is 1 << 29,
> but I totally agree that the bpf_setsockopt() and bpf_getsockopt() signature
> should change into u32 optlen as it's just confusing otherwise, same with the
> long in strncpy(). Agree with Alexei that this might have been a copy-paste
> kind of thing. Lawrence can probably clarify best?
>
> The same wrong assumption is in commit 1e215300f138 ("bpf: add TCP_SAVE_SYN/
> TCP_SAVED_SYN options for bpf_(set|get)sockopt") which tests for optlen <= 0.
> Neither can it be negative nor zero here due to ARG_CONST_SIZE. Given it's
> also confusing others, cleanup might still be worth considering. Maybe Lawrence
> can spin this into one of his next patches, if noone else gets to it first.

Yes, and considering the err_clear: error path does

memset(optval, 0, optlen);

This is even more confusing to think that optlen could be negative or
out of bound ;)
