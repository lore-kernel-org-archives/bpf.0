Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E9C5519F
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C7122263
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huHDgsx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKNQE4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 14 Nov 2020 11:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgKNQE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Nov 2020 11:04:56 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A74C0613D1;
        Sat, 14 Nov 2020 08:04:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v20so14583613ljk.8;
        Sat, 14 Nov 2020 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF9DmgLTqGEWk8G/MSjCtnCNdwhHu5eQtB9G6Eddf7c=;
        b=huHDgsx+ae1FGDX8h9jJafOkUy/kOnkBc5IP2LJP3Lme7OykpwNPIz10iscYQ2JZdv
         wOFywgeHrOOmZ6V8jXBn8x11vkvugKWJHo3dkZLXTcXf2cB1SeaewfEoswCBwaZ3hubp
         15dE5M1fEfwj/IQu1HC/FI0Cd6H00RMD9A/niGe8jnlJUpwoROfAytIhWxL4821iq5Vm
         eXq9MbIyGi/YOwFg6gPh6D8Lu8V8GRiYyWyRl+MJRgno3TScjGWUbp3K38r6FLzf5QSe
         B1jIpcMTUdRTCrXjJJImgJ4GpruB67o1Pt2RZ9aZ4d3htz1m6+V+R2pBUiDxWYFrMJfg
         yCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF9DmgLTqGEWk8G/MSjCtnCNdwhHu5eQtB9G6Eddf7c=;
        b=pOQTHKnWKbqQjT14JAPOj7N2O0eXJb12Q32IdN0FLCZPpoTc887D0m/SXdc/yNuCTR
         JEBRgYfoBWtgUj7lowB/32e6VHZ4KtP+bFS7MdusuMqwrjwyQPFXckszo7C7DAMAoYai
         sT5o7DNR7i25PswCZuTTLBND89/LUQ6lGkSLvyJ+OEmGE5YLcrZT4ND742O+G/NTyME6
         VRwLYbzE1dC7Ul/O+7gWJljFZllZ5yBfJmoZ9hhvaWXrQUL7u/frPYUZIOG0RmB5ehV2
         t+TL2ENuQgDL3NiXAEC24qomrYddhSu0OUmmk5jnCYKONiyJXMlaYUlz9vUq+SLXGlEk
         Yp7g==
X-Gm-Message-State: AOAM533lgaE66bcCR3BsQZWsyssCOaqk0pJvLX5zoAC7f8ehwi1SATUp
        cA93iDsKFdY1vN9uWAp1m9i005iVfXVGMdzhv64=
X-Google-Smtp-Source: ABdhPJwQdVbB68wS/845gUvaSTHRB6Qs+X6JBjXOQM2QcuiBwzGxsUVLwJIEioDprARHZiMG0puqPHm5pAc3wHrCU7c=
X-Received: by 2002:a2e:9ad4:: with SMTP id p20mr2822115ljj.51.1605369894044;
 Sat, 14 Nov 2020 08:04:54 -0800 (PST)
MIME-Version: 1.0
References: <1605291013-22575-1-git-send-email-alan.maguire@oracle.com>
 <1605291013-22575-2-git-send-email-alan.maguire@oracle.com> <CAEf4BzaaUdMnfADQdT=myDJtQtHoQ_aW7T8XidrCkYZ=pGXuaQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaaUdMnfADQdT=myDJtQtHoQ_aW7T8XidrCkYZ=pGXuaQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 14 Nov 2020 08:04:42 -0800
Message-ID: <CAADnVQK6PFAHQMBgQ=Xp7tUFkUBg5yUgBM+r5mi-Kd5UWNWHzw@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/3] bpf: add module support to btf display helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 10:59 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 10:11 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > bpf_snprintf_btf and bpf_seq_printf_btf use a "struct btf_ptr *"
> > argument that specifies type information about the type to
> > be displayed.  Augment this information to include a module
> > name, allowing such display to support module types.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  include/linux/btf.h            |  8 ++++++++
> >  include/uapi/linux/bpf.h       |  5 ++++-
> >  kernel/bpf/btf.c               | 18 ++++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 42 ++++++++++++++++++++++++++++++++----------
> >  tools/include/uapi/linux/bpf.h |  5 ++++-
> >  5 files changed, 66 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 2bf6418..d55ca00 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -209,6 +209,14 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
> >  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
> >  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
> >  struct btf *btf_parse_vmlinux(void);
> > +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +struct btf *bpf_get_btf_module(const char *name);
> > +#else
> > +static inline struct btf *bpf_get_btf_module(const char *name)
> > +{
> > +       return ERR_PTR(-ENOTSUPP);
> > +}
> > +#endif
> >  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
> >  #else
> >  static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 162999b..26978be 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3636,7 +3636,8 @@ struct bpf_stack_build_id {
> >   *             the pointer data is carried out to avoid kernel crashes during
> >   *             operation.  Smaller types can use string space on the stack;
> >   *             larger programs can use map data to store the string
> > - *             representation.
> > + *             representation.  Module-specific data structures can be
> > + *             displayed if the module name is supplied.
> >   *
> >   *             The string can be subsequently shared with userspace via
> >   *             bpf_perf_event_output() or ring buffer interfaces.
> > @@ -5076,11 +5077,13 @@ struct bpf_sk_lookup {
> >   * potentially to specify additional details about the BTF pointer
> >   * (rather than its mode of display) - is included for future use.
> >   * Display flags - BTF_F_* - are passed to bpf_snprintf_btf separately.
> > + * A module name can be specified for module-specific data.
> >   */
> >  struct btf_ptr {
> >         void *ptr;
> >         __u32 type_id;
> >         __u32 flags;            /* BTF ptr flags; unused at present. */
> > +       const char *module;     /* optional module name. */
>
> I think module name is a wrong API here, similarly how type name was
> wrong API for specifying the type (and thus we use type_id here).
> Using the module's BTF ID seems like a more suitable interface. That's
> what I'm going to use for all kinds of existing BPF APIs that expect
> BTF type to attach BPF programs.
>
> Right now, we use only type_id and implicitly know that it's in
> vmlinux BTF. With module BTFs, we now need a pair of BTF object ID +
> BTF type ID to uniquely identify the type. vmlinux BTF now can be
> specified in two different ways: either leaving BTF object ID as zero
> (for simplicity and backwards compatibility) or specifying it's actual
> BTF obj ID (which pretty much always should be 1, btw). This feels
> like a natural extension, WDYT?
>
> And similar to type_id, no one should expect users to specify these
> IDs by hand, Clang built-in and libbpf should work together to figure
> this out for the kernel to use.
>
> BTW, with module names there is an extra problem for end users. Some
> types could be either built-in or built as a module (e.g., XFS data
> structures). Why would we require BPF users to care which is the case
> on any given host?

+1.
As much as possible libbpf should try to hide the difference between
type in a module vs type in the vmlinux, since that difference most of the
time is irrelevant from bpf prog pov.
